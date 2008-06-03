Return-Path: <linux-kernel-owner+w=401wt.eu-S1755307AbYFCRF6@vger.kernel.org>
Message-Id: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:58:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/14] s390 feature patches for 2.6.27.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
these are the patches that are currently on my queue for the merge
window of 2.6.27:

Cornelia Huck (6):
      [S390] cio: Register all subchannels.
      [S390] cio: Introduce modalias for css bus.
      [S390] cio: Rework css driver.
      [S390] cio: Cleanup crw interface.
      [S390] cio: Export some symbols for modular css drivers.
      [S390] cio: Base message subchannel handling.

Heiko Carstens (1):
      [S390] initrd vs bss section clearing.

Martin Schwidefsky (2):
      [S390] Introduce user_regset accessors for s390
      [S390] stp support.

Peter Oberparleiter (4):
      [S390] cio: introduce fcx bit to chsc characteristics
      [S390] cio: introduce fcx enabled scsw format
      [S390] cio: provide functions for fcx enabled I/O
      [S390] cio: provide helper functions for fcx enabled I/O

Sebastian Ott (1):
      [S390] cio: remove lock from ccw_device_oper_notify.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
