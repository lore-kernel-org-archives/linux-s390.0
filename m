From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 19 Aug 2011 13:09:51 +0000
Subject: [patch 2/2] kexec-tools: Allow to call verify_sha256_digest() from kernel
Message-Id: <20110819131212.181608175@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, kexec@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

For s390 we first want to check if kdump checksums are valid before we start
the kdump kernel. With this patch on s390 the purgatory entry point is
called with a parameter. If the parameter is "0", only the checksum test
is done and the result (0 = ok, 1 = invalid) is passed as return code back
to the caller (kernel). If the parameter is "1", the complete purgatory code
is executed and kdump is started.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 purgatory/arch/s390/setup-s390.S |   14 ++++++++++++++
 purgatory/purgatory.c            |   13 ++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/purgatory/arch/s390/setup-s390.S
+++ b/purgatory/arch/s390/setup-s390.S
@@ -11,12 +11,23 @@
 	.balign 16
 purgatory_start:
 #ifdef __s390x__
+	larl	%r5,gprs_save_area
+	stmg	%r6,%r15,0(%r5)
 	larl	%r15,lstack_end
 	aghi	%r15,-160
+
+	clgfi	%r2,0
+	je	verify_checksums
+
 	brasl	%r14,purgatory
 	larl	%r14,kdump_psw
 	lpswe	0(%r14)
 
+verify_checksums:
+	brasl	%r14,verify_sha256_digest
+	larl	%r5,gprs_save_area
+	lmg	%r6,%r15,0(%r5)
+	br	%r14
 	.section ".data"
 	.balign 16
 kdump_psw:
@@ -24,6 +35,9 @@ kdump_psw:
 	.quad 0x0000000000010010
 
 	.bss
+gprs_save_area:
+	.fill 80
+
 	.balign 4096
 lstack:
 	.skip 4096
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -9,7 +9,7 @@
 struct sha256_region sha256_regions[SHA256_REGIONS] = {};
 sha256_digest_t sha256_digest = { };
 
-void verify_sha256_digest(void)
+int verify_sha256_digest(void)
 {
 	struct sha256_region *ptr, *end;
 	sha256_digest_t digest;
@@ -34,16 +34,19 @@ void verify_sha256_digest(void)
 			printf("%hhx ", sha256_digest[i]);
 		}
 		printf("\n");
-		for(;;) {
-			/* loop forever */
-		}
+		return 1;
 	}
+	return 0;
 }
 
 void purgatory(void)
 {
 	printf("I'm in purgatory\n");
 	setup_arch();
-	verify_sha256_digest();
+	if (verify_sha256_digest()) {
+		for(;;) {
+			/* loop forever */
+		}
+	}
 	post_verification_setup_arch();
 }
