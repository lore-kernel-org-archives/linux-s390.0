From: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Subject: [PATCH 0/7] Remove errors building drivers/DRIVERNAME
Date: Tue, 25 Sep 2018 22:51:47 -0300
Message-ID: <20180926015147.GA14862@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

This Patchset changes some driver's Makefile to allow them building 
using the command 'make drivers/DRIVERNAME', if compatible.

The changed drivers would return error if the above command was run
on them, after an x86 allyesconfig.

The main reason of this patchset is to allow building lists of
drivers looking for warnings and errors to be fixed.

My main objective is to allow developers with low processing power
to do changes in the kernel and look bugs using free services like
GiltabCI. 

If there is any interest helping/using this, I have a prototype in
https://gitlab.com/LeoBras/linux-next.

Leonardo Brás (7):
  drivers: dio: Avoids building driver if CONFIG_DIO is disabled
  drivers: nubus: Avoids building driver if CONFIG_NUBUS is disabled
  drivers: parisc: Avoids building driver if CONFIG_PARISC is disabled
  drivers: zorro: Avoids building proc.o if CONFIG_ZORRO is disabled
  drivers: s390: Avoids building drivers if ARCH is not s390.
  drivers: oprofile: Avoids building driver from direct make command
  drivers: hwtracing: Adds Makefile to enable building from directory.

 drivers/Makefile           | 4 +---
 drivers/dio/Makefile       | 2 +-
 drivers/hwtracing/Makefile | 3 +++
 drivers/nubus/Makefile     | 6 +++---
 drivers/oprofile/Makefile  | 1 +
 drivers/parisc/Makefile    | 2 +-
 drivers/s390/Makefile      | 8 ++++----
 drivers/zorro/Makefile     | 2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile
 create mode 100644 drivers/oprofile/Makefile

-- 
2.19.0
