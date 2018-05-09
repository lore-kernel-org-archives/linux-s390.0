Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:51:39 +0900
Message-ID: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180509075139.nNlGSE86g5Z3h119g7F4acKb4SlpYmL_LWLckCJGSXs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for s390-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 08d12cf..f0414f5 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -82,10 +82,10 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
-		VMLINUX_SYMBOL(_sinittext) = . ;
+		_sinittext = .;
 		INIT_TEXT
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(_einittext) = . ;
+		_einittext = .;
 	}
 
 	/*
-- 
2.7.4
