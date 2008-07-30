Return-Path: <linux-kernel-owner+w=401wt.eu-S1759707AbYG3RNh@vger.kernel.org>
Message-Id: <20080730165656.118280544@de.ibm.com>
Date: Wed, 30 Jul 2008 18:56:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/3] [RFC] kmsg macros and script, take x+1. 
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
the last kmsg patches on lkml got some useful feedback and Andrew advised
to extend the scope of the this discussion to lf_kernel_messages.  I've
added all individuals I could find who participated in the kernel messages
discussions last year.
Since then we continued to work on the kernel messages for s390 and the
three patches in this series is the gist of it.

The lastest changes:
 * kmsg.h has been moved from include/asm-s390 to include/linux
 * The s390 specific documentation is now in Documentation/kmsg/s390
 * The script checks for messages in the source file, Documentation/kmsg
   and Documentation/kmsg/$SRCARCH
 * I've reduced the number of patches to three, a single example how
   the kmsg interface is used should be enough.

The initial approach has been to keep the kmsg interface local to s390,
but Andrew thinks it has potential for common use. That is where all
the people on Cc: come into play: what is your opinion? Can we go ahead
with it?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
