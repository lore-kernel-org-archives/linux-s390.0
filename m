Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 3/4] s390: drop CONFIG_VIRT_TO_BUS
Date: Mon, 15 Apr 2019 10:35:53 +0200
Message-Id: <20190415083605.2560074-3-arnd@arndb.de>
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

VIRT_TO_BUS is only used for legacy device PCI and ISA drivers using
virt_to_bus() instead of the streaming DMA mapping API, and the
remaining drivers generally don't work on 64-bit architectures.

Two of these drivers also cause a build warning on s390, so instead
of trying to fix that, let's just disable the option as we do on
most architectures now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1a2eec61196d..25e0e7375166 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -188,7 +188,6 @@ config S390
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_SCALED_CPUTIME
-	select VIRT_TO_BUS
 	select HAVE_NMI
 
 
-- 
2.20.0
