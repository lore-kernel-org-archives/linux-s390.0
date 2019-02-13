Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/11] s390: don't redefined the HAS_IOMEM symbol
Date: Wed, 13 Feb 2019 18:40:05 +0100
Message-Id: <20190213174005.28785-12-hch@lst.de>
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Rely on the common defintion instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a25e19364f5..0f62e33ffcb2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -159,6 +159,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_SG_DMA_LENGTH	if PCI
+	select NO_IOMEM			if !PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
@@ -708,9 +709,6 @@ config PCI_NR_FUNCTIONS
 
 endif	# PCI
 
-config HAS_IOMEM
-	def_bool PCI
-
 config CHSC_SCH
 	def_tristate m
 	prompt "Support for CHSC subchannels"
-- 
2.20.1
