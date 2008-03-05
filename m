Return-Path: <linux-kernel-owner+w=401wt.eu-S933104AbYCEL61@vger.kernel.org>
Message-Id: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/10] s390 bux fixes for 2.6.25-rc4.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Assorted bug fixes for s390. The shortlog:

Christian Borntraeger (1):
      [S390] sclp_vt220: speed up console output for interactive work

Heiko Carstens (3):
      [S390] idle: Fix machine check handling in idle loop.
      [S390] Get rid of memcpy gcc warning workaround.
      [S390] Fix IPL from NSS.

Hongjie Yang (1):
      [S390] incorrect reipl nss name.

Martin Schwidefsky (1):
      [S390] Update default configuration.

Michael Holzheu (1):
      [S390] Load disabled wait psw if reipl fails.

Ralph Wuerthner (1):
      [S390] zcrypt: fix ap_device_list handling

Stefan Weinhuber (2):
      [S390] dasd: let dasd erp matching recognize alias recovery
      [S390] dasd: fix reference counting in display method for proc/dasd/devices

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
