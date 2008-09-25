Return-Path: <linux-kernel-owner+w=401wt.eu-S1756132AbYIYQpx@vger.kernel.org>
Message-Id: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] [RFC] kmsg macros, take x+3.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
after a short chat with Greg on the kernel summit here is now the
hopefully final version of the kernel message catalog patches. As
version x+2 this uses automatically generated message hashes. The
new thing is that there are no more special kmsg_dev_xxx macros,
this version uses the standard dev_xxx macros. If a KMSG_COMPONENT
is defined then dev_xxx will include the message hash after the
driver name in the format:

   <driver-name>.<message hash>: <device name>: <message>

The problem with finding the correct driver name in the kmsg-doc
script has been solved by requiring that the driver name and
KMSG_COMPONENT have to match. See patch #2.

To convert a driver to use the message tags you need to do:
1) Add KMSG_COMPONENT to the start of each source file of the driver:
   #define KMSG_COMPONENT "driver-name"
   The define should be before any of the includes.
2) Replace all normal printks with kmsg_err/kmsg_warn/kmsg_info/..
   The dev_xxx printks do not need to be changed in any way.
3) Compile the driver
4) Check for missing messages by running "make D=1 <?.o>" on each of
   the object files of the driver. For example if I want to check the
   lcs driver I do "make D=1 drivers/s390/net/lcs.o". Alternatively you
   can check all object files of your current configuration with just
   "make D=1". Be prepared that this will take a while..
   For each message that misses its documentation you'll get a blueprint.
5) Fill in the ksmg blueprint of the messages and copy the result to
   either the source file where the respective message is located or to
   a text file with the component as its name in Documentation/kmsg.
6) Create the man pages your driver with "make D=2 <?.o>".

Greg: could you please comment on patch number #2 if this is ok with
you now?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
