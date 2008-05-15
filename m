Return-Path: <linux-kernel-owner+w=401wt.eu-S1760738AbYEOPDn@vger.kernel.org>
Message-Id: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/11] s390 patches for 2.6.26-rc2
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi folks,
the number of bug fixes has grown past 10 so I guess it's time for
another patch set to get them upstream. Nothing exiting, the shortlog:

Cornelia Huck (4):
      [S390] Remove last traces of cio_msg=.
      [S390] dasd: Use const in busid functions.
      [S390] s390dbf: Use const char * for dbf name.
      [S390] tape: Use ccw_dev_id to build cdev_id.

Heiko Carstens (3):
      [S390] sparsemem vmemmap: initialize memmap.
      [S390] smp: __smp_call_function_map vs cpu_online_map fix.
      [S390] show_interrupts: prevent cpu hotplug when walking cpu_online_map.

Huang Weiyi (1):
      [S390] blacklist.c: removed duplicated include

Marcin Slusarz (1):
      [S390] vmlogrdr: module initialization function should return negative errors

Michael Ernst (1):
      [S390] cio: Remove CCW_CMD_SUSPEND_RECONN in front of CCW_CMD_SET_PGID.

Stefan Weinhuber (1):
      [S390] dasd: fix timeout handling in interrupt handler


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
