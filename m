Return-Path: <linux-kernel-owner+w=401wt.eu-S935140AbXJSRWv@vger.kernel.org>
Message-Id: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:18:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/10] 2nd batch of s390 patches for 2.6.24.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The latest and greatest for 2.6.24. This patch set includes the tlb flush
fix that has been discussed back in June/July and a cleanup of the mm
related definitions for s390. I have three more patches in the works that
go on top of the cleanup. These three patches add two new features:
1) dynamic number of page table levels and 2) 1K/2K sized page tables.
For both features common code changes are required. I'll apply a bit more
polish to the patches and then send them for review. 

The shortlog for this patch set:

Cornelia Huck (3):
      [S390] cio: Use to_channelpath() for device to channel path conversion.
      [S390] cio: Fix incomplete commit for uevent suppression.
      [S390] struct class_device -> struct device conversion.

Heiko Carstens (1):
      [S390] Add per-cpu idle time / idle count sysfs attributes.

Martin Schwidefsky (6):
      [S390] Update default configuration.
      [S390] tlb flush fix.
      [S390] Remove unused user_seg from thread structure.
      [S390] Introduce follow_table in uaccess_pt.c
      [S390] Cleanup page table definitions.
      [S390] 4level-fixup cleanup

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
