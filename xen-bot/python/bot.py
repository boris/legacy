#!/usr/bin/python

from jabberbot import JabberBot, botcmd
import datetime, os, hashlib


class SystemInfoJabberBot(JabberBot):
	@botcmd
	def serverinfo( self, mess, args):
		"""Muestra info del server"""
		info = os.popen('xm info')
		help = os.popen('xm help')
		loadavg = open('/proc/loadavg').read().strip()
		balloon = open('/proc/xen/balloon').read().strip()
		return '%s\n\n%s' % ( info, help, loadavg, balloon, )

	@botcmd
	def time( self, mess, args):
		"""Muestra la hora del server"""
		return str(datatime.datatime.now())


username = 'bot@gmail.com'
password = 'passw0rd'
bot = SystemInfoJabberBot(username,password)
bot.serve_forever()
