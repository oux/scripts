#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import json

import imaplib

import pynotify
import os
from datetime import timedelta
import time

login = 'GER\\michelse'
passwd= 'XXXXXX'

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    if "m" in sys.argv:
        obj = None
        try:
            obj = imaplib.IMAP4_SSL('irsmsx101.ger.corp.intel.com','993')
            obj.login(login,passwd)
        except:
            sys.stderr.write("Login failed on startup\n")
            pass

        pynotify.init("mail notif")
        notified = []


    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        sys.stderr.write(line)
        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        if "m" in sys.argv:
            unread = []
            unreadbz = []
            try:
                obj.select('bz')
                unreadbz = obj.search(None,'UnSeen')[1][0].split()
                obj.select()
                unread = obj.search(None,'UnSeen')[1][0].split()
            except:
                sys.stderr.write("obj.select() didn't work. Trying logging\n")
                j.insert(0, {
                    'full_text' : 'Check Mail error',
                    'name' : 'newmail',
                    'color' : '#FF8800'})

    #            try:
    #                obj = imaplib.IMAP4_SSL('irsmsx101.ger.corp.intel.com','993')
    #                obj.login(login,passwd)
    #            except:
    #                sys.stderr.write("Login retry didn't work\n")
    #                pass
            message = ""
            for mailid in unread:
                if (mailid not in notified):
                    notified.append(mailid)
                    mail = obj.fetch(mailid,'(RFC822.SIZE BODY.PEEK[HEADER.FIELDS (FROM SUBJECT)])')
                    message = mail[1][0][1]+"\n"

            if message:
                notice = pynotify.Notification("New mails", message)
                notice.set_timeout(10)
                notice.show()

            if len(unreadbz):
                j.insert(0, {
                    'full_text' : '%d ‰' % len(unreadbz),
                    'name' : 'newbz',
                    'color' : '#FF8800'})
            if len(unread):
                j.insert(0, {
                    'full_text' : '%d ⌧' % len(unread),
                    'name' : 'newmail',
                    'color' : '#FF8800'})
            else:
                notified = []
        if "w" in sys.argv:
            WEATHER="/home/seb/workspace/misc/weather-forecast/weather_forecast.sh -i"
            j.insert(j.__len__()-1, {
                'full_text' : '%s' % os.popen(WEATHER).read().split('\n')[0],
                'name' : 'wearther',
                'color' : '#FF8800'})

        if "t" in sys.argv:
            FILE_PATH = "/home/seb/WW/ww.votl"
            MTIME = os.stat(FILE_PATH).st_mtime
            NOW = int(time.strftime("%s"))
            DELTA = timedelta(seconds=NOW-MTIME)
            DAY = timedelta(days=1)
            COLOR = '#008800'
            if DELTA.total_seconds() > DAY.total_seconds()/2:
                COLOR = '#FF8800'
            if DELTA.total_seconds() > 2*DAY.total_seconds():
                COLOR = '#FF0000'
            j.insert(0, {
                'full_text' : '☑ %s' %  ':'.join(str(DELTA).split(':')[:2]) ,
                'name' : 'todo',
                'color' : COLOR})

        # and echo back new encoded json
        #sys.stderr.write(prefix+json.dumps(j, ensure_ascii=False)+"\n")
        print_line(prefix+str(json.dumps(j, ensure_ascii=False)))
