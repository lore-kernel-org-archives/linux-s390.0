Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] Add new builtin_misc_device users
Date: Sat, 29 Oct 2016 16:38:40 -0400
Message-ID: <20161029203843.515-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Bas Vermeulen <bvermeul@blackstar.xs4all.nl>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Miao <realmz6@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matias Bjorling <mb@lightnvm.io>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The new macro builtin_misc_device doesn't currently exist anywhere
other than Greg's char-misc tree.  As such I was going to stagger
the patches containing users of it by a merge window to avoid any
dependency issues, but Greg offered to take the users in via the
char-misc tree which also solves the dependency issue (assuming
the blackfin and s390 people don't mind).

So these three patches are the ones from my queue that use the
new macro.  Build tested for s390 and blackfin to ensure no typos
or implicit include issues inadvertently crept in.

We are simply replacing module_misc_device with the new
builtin_misc_device in code that is always built in due to
the Makefile/Kconfig settings controlling it.  Along with that
we get rid of any other modular related references that are
inactive in the always non-modular case.

Paul.

---

Cc: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Steven Miao <realmz6@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org

Paul Gortmaker (3):
  lightnvm: make core.c explicitly non-modular
  blackfin: make-bf561/coreb.c explicitly non-modular
  s390: char: make slp_ctl explicitly non-modular

 arch/blackfin/mach-bf561/coreb.c | 10 ++++------
 drivers/lightnvm/core.c          | 14 ++++++--------
 drivers/s390/char/sclp_ctl.c     |  4 ++--
 3 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.10.1
