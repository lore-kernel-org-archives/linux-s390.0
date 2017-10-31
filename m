From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 31 Oct 2017 17:22:08 +0000
Subject: [PATCH] s390: pass endianness info to sparse
Message-Id: <20171031172208.9941-1-luc.vanoostenryck@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

s390 is big-endian only but sparse assumes the same endianness
as the building machine.
This is problematic for code which expect __BYTE_ORDER__ being
correctly predefined by the compiler which sparse can then
pre-process differently from what gcc would, depending on the
building machine endianness.

Fix this by letting sparse know about the architecture endianness.

To: Martin Schwidefsky <schwidefsky@de.ibm.com> (supporter:S390)
To: Heiko Carstens <heiko.carstens@de.ibm.com> (supporter:S390)
CC: linux-s390@vger.kernel.org (open list:S390)
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/s390/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index dac821cfc..64c2fe9dc 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -21,7 +21,7 @@ KBUILD_CFLAGS	+= -m64
 KBUILD_AFLAGS	+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
-CHECKFLAGS	+= -D__s390__ -D__s390x__
+CHECKFLAGS	+= -D__s390__ -D__s390x__ -mbig-endian
 
 export LD_BFD
 
-- 
2.14.0
