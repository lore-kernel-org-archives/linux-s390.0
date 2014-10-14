Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Oct 2014 10:13:42 -0400
From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH] s390/hmcdrv: Restrict s390 HMC driver to S390 arch
Message-ID: <20141014141342.GA30995@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ralf Hoppe <rhoppe@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This driver is only usable on 64-bit s390 machines.  Mark the Kconfig
dependencies to that users on other architectures are not prompted for it.

Fixes: 8f933b1043e1e5 ("s390/hmcdrv: HMC drive CD/DVD access")
Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 drivers/s390/char/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index dc24ecfac2d1..db2cb1f8a1b5 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -105,7 +105,7 @@ config SCLP_ASYNC
 config HMC_DRV
 	def_tristate m
 	prompt "Support for file transfers from HMC drive CD/DVD-ROM"
-	depends on 64BIT
+	depends on S390 && 64BIT
 	select CRC16
 	help
 	  This option enables support for file transfers from a Hardware
-- 
1.9.3
