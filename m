Return-Path: <linux-kernel-owner+w=401wt.eu-S1757944AbYGAMvy@vger.kernel.org>
Message-Id: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/14] additional s390 patches for 2.6.27
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
in the last couple of weeks some more s390 patches have piled up
for the 2.6.27 merge window:

Cornelia Huck (7):
      [S390] cio: Get rid of css_characteristics_avail.
      [S390] cio: Introduce abstract isc definitions.
      [S390] cio: Allow adapter interrupt handlers per isc.
      [S390] cio: Use isc_{register,unregister}.
      [S390] cio: Repair chpid event handling.
      [S390] css: Use css_device_id for bus matching.
      [S390] cio: Add chsc subchannel driver.

Felix Beck (1):
      [S390] ap: Use high-resolution timer for polling

Heiko Carstens (1):
      [S390] idle: remove idle notifier chain.

Hendrik Brueckner (1):
      [S390] Extra Kernel Parameters via VMPARM

Peter Oberparleiter (2):
      [S390] cio: suppress chpid event in case of configure error
      [S390] sclp: simplify vt220 cleanup logic

Ralph Wuerthner (1):
      [S390] zcrypt: Add additional card IDs to CEX2C and CEX2A

Sebastian Ott (1):
      [S390] cio: introduce isc_(un)register functions.

I've added them to the other patches in the feature branch of the
it390 tree. See

git://git390.osdl.marist.edu/pub/scm/linux-2.6.git feeatures

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
