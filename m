Return-Path: <linux-kernel-owner+w=401wt.eu-S1755854AbXD0OFr@vger.kernel.org>
Message-Id: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/38] s390 patches for 2.6.22
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is the s390 patchset for the merge window of 2.6.22.
Most of it is cleanup and bug-fixes, but there are some
new features as well:
 - Channel path configure function.
 - Improved oops output with an in-kernel disassembler
 - Make use of generic bug.
 - zfcpdump support.
 - Processor degradation notification.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
