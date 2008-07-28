Return-Path: <linux-kernel-owner+w=401wt.eu-S1760652AbYG1R4A@vger.kernel.org>
Message-Id: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:53:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/15] [RFC] kmsg macros and script.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
this is the next step of our project to document all s390 specific
kernel messages. The message cleanup patches have been integrated
into the upstream kernel. After we removed the meaningless messages
it is now time to brush up the remaining messages.

The first patch introduces a new set of wrapper macros around printk.
These macros add a prefix to each message and a message id can be
specified. The second patch adds a script to help writing the kmsg
comments that describe a kmsg and it can be used to write man pages
for the documented messages. The remaining 13 patches convert some of
the printk messages found in the s390 architecture files and some of
the s390 device drivers to demonstrate how all this is supposed to
work.

The code is currently only usable for s390. Should this be of interest
to other architectures as well we have to think about where to put
things. We'd be happy to get feedback on this.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
