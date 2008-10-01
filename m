Return-Path: <linux-kernel-owner+w=401wt.eu-S1754610AbYJAI6J@vger.kernel.org>
Message-Id: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/21] s390 patches for the 2.6.28 merge window
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
I have the following patches on the features branch of git390
for the merge window of 2.6.28:

Christoph Hellwig (1):
      [S390] s390: use sys_pause for 31bit pause entry point

Cornelia Huck (6):
      [S390] cio: Update cio_ignore documentation.
      [S390] cio: Exorcise cio_msg= from documentation.
      [S390] bus_id -> dev_set_name() changes
      [S390] more bus_id -> dev_name conversions
      [S390] Use s390_root_dev_* in kvm_virtio.
      [S390] bus_id -> dev_set_name() for css and ccw busses

Heiko Carstens (2):
      [S390] nohz: Fix __udelay.
      [S390] Move private simple udelay function to arch/s390/lib/delay.c.

Hongjie Yang (1):
      [S390] dcssblk: add >2G DCSSs support and stacked contiguous DCSSs support.

Kay Sievers (1):
      [S390] bus_id -> dev_name conversions

Klaus-Dieter Wacker (1):
      [S390] qdio enhanced SIGA (iqdio) support.

Martin Schwidefsky (3):
      [S390] bus_id ->dev_name() conversions in qdio
      [S390] ptrace changes
      [S390] xpram: per device block request queues.

Nigel Hislop (1):
      [S390] Add ioctl support for EMC Symmetrix Subsystem Control I/O

Peter Oberparleiter (3):
      [S390] cio: move device unregistration to dedicated work queue
      [S390] cio: introduce purge function for /proc/cio_ignore
      [S390] cio: inline assembly cleanup

Stefan Haberland (1):
      [S390] dasd: fix message flood for unsolicited interrupts

Ursula Braun (1):
      [S390] qdio: speed up multicast traffic on full HiperSocket queue

Comments are as always welcome.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
