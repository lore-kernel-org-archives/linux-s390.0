Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] KEYS: correct alignment of system_certificate_list content in assembly file
Date: Thu,  5 Dec 2013 14:48:22 +0100
Message-Id: <1386251302-6345-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: dhowells@redhat.com
Cc: brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Apart from data-type specific alignment constraints, there are also
architecture-specific alignment requirements.
For example, on s390 symbols must be on even addresses implying a 2-byte
alignment.  If the system_certificate_list_end symbol is on an odd address
and if this address is loaded, the least-significant bit is ignored.  As a
result, the load_system_certificate_list() fails to load the certificates
because of a wrong certificate length calculation.

To be safe, align system_certificate_list on an 8-byte boundary.  Also improve
the length calculation of the system_certificate_list content.  Introduce a
system_certificate_list_size (8-byte aligned because of unsigned long) variable
that stores the length.  Let the linker calculate this size by introducing
a start and end label for the certificate content.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 kernel/system_certificates.S |   14 ++++++++++++--
 kernel/system_keyring.c      |    4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/system_certificates.S b/kernel/system_certificates.S
index 4aef390..3e9868d47 100644
--- a/kernel/system_certificates.S
+++ b/kernel/system_certificates.S
@@ -3,8 +3,18 @@
 
 	__INITRODATA
 
+	.align 8
 	.globl VMLINUX_SYMBOL(system_certificate_list)
 VMLINUX_SYMBOL(system_certificate_list):
+__cert_list_start:
 	.incbin "kernel/x509_certificate_list"
-	.globl VMLINUX_SYMBOL(system_certificate_list_end)
-VMLINUX_SYMBOL(system_certificate_list_end):
+__cert_list_end:
+
+	.align 8
+	.globl VMLINUX_SYMBOL(system_certificate_list_size)
+VMLINUX_SYMBOL(system_certificate_list_size):
+#ifdef CONFIG_64BIT
+	.quad __cert_list_end - __cert_list_start
+#else
+	.long __cert_list_end - __cert_list_start
+#endif
diff --git a/kernel/system_keyring.c b/kernel/system_keyring.c
index 564dd93..52ebc70 100644
--- a/kernel/system_keyring.c
+++ b/kernel/system_keyring.c
@@ -22,7 +22,7 @@ struct key *system_trusted_keyring;
 EXPORT_SYMBOL_GPL(system_trusted_keyring);
 
 extern __initconst const u8 system_certificate_list[];
-extern __initconst const u8 system_certificate_list_end[];
+extern __initconst const unsigned long system_certificate_list_size;
 
 /*
  * Load the compiled-in keys
@@ -60,8 +60,8 @@ static __init int load_system_certificate_list(void)
 
 	pr_notice("Loading compiled-in X.509 certificates\n");
 
-	end = system_certificate_list_end;
 	p = system_certificate_list;
+	end = p + system_certificate_list_size;
 	while (p < end) {
 		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
 		 * than 256 bytes in size.
-- 
1.7.5.4
