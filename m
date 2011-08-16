Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110816141441.898339466@de.ibm.com>
Date: Tue, 16 Aug 2011 16:14:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/1] [patch 0/1] include storage keys in hibernation image
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Hi Rafael,

Version 2 of the storage key patch for hibernation on s390.
I've added the following changes as you requested:
1) moved the s390 specific code to arch/s390/kernel/suspend.c
2) introduced CONFIG_ARCH_SAVE_PAGE_KEYS and added a select to
   the main s390 Kconfig file
3) added the empty default functions to include/linux/suspend.h

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
