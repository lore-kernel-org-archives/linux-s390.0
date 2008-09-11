Return-Path: <linux-kernel-owner+w=401wt.eu-S1755512AbYIKNpq@vger.kernel.org>
Message-Id: <20080911133538.026764388@de.ibm.com>
Date: Thu, 11 Sep 2008 15:35:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/4] [RFC] kmsg macros, take x+2.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
as requested this version of the kmsg patches uses a hash over the
message text instead of a manually assigned message number. There is
a new kernel function kmsg_printk which calculates the hash, prints
the prefix together with the hash and then the message itself.
Since it is impossible to add a parameter to a va_list kmsg_printk
has to do two seperate printk calls.

The kmsg tag now consists of the kmsg component and a 6 digit
hexadecimal hash. The code uses the lower 24 bit of the Jenkins hash
of the message text (there is a convenient inline implementation in
include/linux/jhash.h). The likelyhood of a hash collision with 100
messages per component is ~0.03%, with 1000 messages ~3% and with
10000 messages ~95%. As an example the old xpam.3 message:

  xpram.3: No expanded memory available

now prints as:

  xpram.f6ae78: No expanded memory available

For translation purposes all messages need a unique id, that makes
the special id 0 from the older kmsg patches rather useless. The
replacement for id 0 are single line kmsg comments, e.g.

/*? Tag: xpram.9a3d44 Text: "  size of partition %d: %u kB\n" */

This makes the script to ignore the message, the check run will print
no warning and no man pages will be generated.

That leaves the question of dev_printk and friends. The dev_xxx macros
prefix the message with the driver name and the device name. Both
strings are dynamic, the perl script therefore can not find them which
makes them unusable as part of the kmsg tag. Now there are some options
how to deal with it:

1) Keep the existing dev_xxx printks, do not include a kmsg component in
   the printk prefix and print the hash seperately. With the hash at the
   start of the string an example printk would look like this:

   617579: qeth: 0.0.f5f0: unknown card type

   The bad: the hash prefix is out of place. The large number of dev_xxx
   printks makes a hash collision very likely. The only solution would be
   to increase the number of hash digits. The message looks like crap.
   The good: the message check/print script works and existing code needs
   no change.

2) Keep the exiting dev_xxx printks, do not include a kmsg component and
   sneek in the hash right after the driver name. This would look like
   this:

   qeth.617579: 0.0.f5f0: unknown card type

   The bad: the script has no chance to find the corresponding kmsg
   description because the driver name is not known. Automatic message
   checking and man page creation would be impossible.
   The good: the messages look fine.

3) Keep the existing dev_xxx printks, include a kmsg component and print
   the hash with the component. The example from above would look like
   this:

   qeth.617579: qeth: 0.0.f5f0: unknown card type

   The bad: the driver name gets repeated and that every file that uses
   dev_xxx has to define a KMSG_COMPONENT. The message looks like crap.
   The good: the script works.

4) Define new kmsg_dev_xxx macros that are similar to dev_xxx, include
   a kmsg component. These new macros do not print the dynamic driver
   name, only the kmsg component. This is what is currently implemented.
   The example from above looks like this:

   qeth.617579: 0.0.f5f0: unknown card type

   The bad: each driver that wants to use the kmsg_dev_xxx needs to be
   changed. kmsg_dev_xxx in subsystems will have to do the print of the
   driver name in each printk as it is not included automatically.
   The good: the script works and the messages look fine.

I still prefer option 4). Anyone with a clever idea ?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
