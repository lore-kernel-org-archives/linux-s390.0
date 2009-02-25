Return-Path: <linux-kernel-owner+w=401wt.eu-S1759738AbZBYPIv@vger.kernel.org>
Message-Id: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 00/46] s390 features patches for 2.6.30
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
there are 46 patches in the features branch of git390 for the
upcoming merge window of 2.6.30. Three highlights:

 * A new shutdown action for automatic ipl after dump.
 * Large volume support for the dasd driver.
 * High performance ficon support for the dasd driver.

The other patches are the usual collection of non-critical bug
fixes and cleanups. As always nitpicks and reviews are welcome.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
