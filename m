Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/12] s390: cio: fix cio_irb declaration
Date: Mon,  8 Apr 2019 23:26:20 +0200
Message-Id: <20190408212648.2407234-7-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

clang points out that the declaration of cio_irb does not match the
definition exactly, it is missing the alignment attribute:

../drivers/s390/cio/cio.c:50:1: warning: section does not match previous declaration [-Wsection]
DEFINE_PER_CPU_ALIGNED(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:150:2: note: expanded from macro 'DEFINE_PER_CPU_ALIGNED'
        DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)     \
        ^
../include/linux/percpu-defs.h:93:9: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
../drivers/s390/cio/cio.h:118:1: note: previous attribute is here
DECLARE_PER_CPU(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:111:2: note: expanded from macro 'DECLARE_PER_CPU'
        DECLARE_PER_CPU_SECTION(type, name, "")
        ^
../include/linux/percpu-defs.h:87:9: note: expanded from macro 'DECLARE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
Use DECLARE_PER_CPU_ALIGNED() here, to make the two match.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/cio/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 9811fd8a0c73..92eabbb5f18d 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -115,7 +115,7 @@ struct subchannel {
 	struct schib_config config;
 } __attribute__ ((aligned(8)));
 
-DECLARE_PER_CPU(struct irb, cio_irb);
+DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
 
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
-- 
2.20.0
