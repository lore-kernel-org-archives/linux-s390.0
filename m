Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 08/20] s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select
Date: Mon,  5 Feb 2018 02:21:20 +0100
Message-Id: <20180205012146.23981-9-ulfalizer@gmail.com>
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com, egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com, mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org, will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The ARCH_WANTS_PROT_NUMA_PROT_NONE symbol was removed by
commit 6a33979d5bd7 ("mm: remove misleading ARCH_USES_NUMA_PROT_NONE"),
but S390 still selects it.

Remove the ARCH_WANTS_PROT_NUMA_PROT_NONE select from the S390 symbol.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0105ce28e246..bb090b7992e4 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -112,7 +112,6 @@ config S390
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
-	select ARCH_WANTS_PROT_NUMA_PROT_NONE
 	select ARCH_WANTS_UBSAN_NO_NULL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
-- 
2.14.1
