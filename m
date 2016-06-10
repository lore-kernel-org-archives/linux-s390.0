From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 10 Jun 2016 08:16:29 +0000
Subject: [PATCH] s390: avoid extable collisions
Message-Id: <1465546589-52788-1-git-send-email-heiko.carstens@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We have some inline assemblies where the extable entry points to a
label at the end of an inline assembly which is not followed by an
instruction.

On the other hand we have also inline assemblies where the extable
entry points to the first instruction of an inline assembly.

If a first type inline asm (extable point to empty label at the end)
would be directly followed by a second type inline asm (extable points
to first instruction) then we would have two different extable entries
that point to the same instruction but would have a different target
address.

This can lead to quite random behaviour, depending on sorting order.

I verified that we currently do not have such collisions within the
kernel. However to avoid such subtle bugs add a couple of nop
instructions to those inline assemblies which contain an extable that
points to an empty label.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c | 2 +-
 arch/s390/hypfs/hypfs_vm.c   | 2 +-
 arch/s390/include/asm/diag.h | 2 +-
 arch/s390/kernel/ipl.c       | 2 +-
 arch/s390/mm/fault.c         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 045035796ca7..27779f0743ac 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -344,7 +344,7 @@ static inline int __diag204(unsigned long subcode, unsigned long size, void *add
 
 	asm volatile(
 		"	diag	%2,%0,0x204\n"
-		"0:\n"
+		"0:	nopr	%%r7\n"
 		EX_TABLE(0b,0b)
 		: "+d" (_subcode), "+d" (_size) : "d" (addr) : "memory");
 	if (_subcode)
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 44feac38ccfc..012919d9833b 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -70,7 +70,7 @@ static int diag2fc(int size, char* query, void *addr)
 	diag_stat_inc(DIAG_STAT_X2FC);
 	asm volatile(
 		"	diag    %0,%1,0x2fc\n"
-		"0:\n"
+		"0:	nopr	%%r7\n"
 		EX_TABLE(0b,0b)
 		: "=d" (residual_cnt), "+d" (rc) : "0" (&parm_list) : "memory");
 
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 5fac921c1c42..86cae09e076a 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -49,7 +49,7 @@ static inline void diag10_range(unsigned long start_pfn, unsigned long num_pfn)
 	diag_stat_inc(DIAG_STAT_X010);
 	asm volatile(
 		"0:	diag	%0,%1,0x10\n"
-		"1:\n"
+		"1:	nopr	%%r7\n"
 		EX_TABLE(0b, 1b)
 		EX_TABLE(1b, 1b)
 		: : "a" (start_addr), "a" (end_addr));
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index a6d2a998e328..44317398b77b 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -174,7 +174,7 @@ static inline int __diag308(unsigned long subcode, void *addr)
 
 	asm volatile(
 		"	diag	%0,%2,0x308\n"
-		"0:\n"
+		"0:	nopr	%%r7\n"
 		EX_TABLE(0b,0b)
 		: "+d" (_addr), "+d" (_rc)
 		: "d" (subcode) : "cc", "memory");
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 19288c1b36d3..6ad7eff84c82 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -624,7 +624,7 @@ void pfault_fini(void)
 	diag_stat_inc(DIAG_STAT_X258);
 	asm volatile(
 		"	diag	%0,0,0x258\n"
-		"0:\n"
+		"0:	nopr	%%r7\n"
 		EX_TABLE(0b,0b)
 		: : "a" (&refbk), "m" (refbk) : "cc");
 }
-- 
2.6.6
