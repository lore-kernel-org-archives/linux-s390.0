From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/3] s390: kvm: Cpu model support for msa6, msa7 and msa8
Date: Wed, 26 Apr 2017 14:38:15 +0200
Message-ID: <1493210295-58687-4-git-send-email-borntraeger@de.ibm.com>
References: <1493210295-58687-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493210295-58687-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

msa6 and msa7 require no changes.
msa8 adds kma instruction and feature area.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 3 ++-
 arch/s390/include/uapi/asm/kvm.h         | 3 ++-
 arch/s390/kvm/kvm-s390.c                 | 4 ++++
 arch/s390/tools/gen_facilities.c         | 1 +
 tools/arch/s390/include/uapi/asm/kvm.h   | 3 ++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index b6cda49..575ccb0 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -140,7 +140,8 @@ struct kvm_s390_vm_cpu_subfunc {
        u8 kmo[16];           # valid with Message-Security-Assist-Extension 4
        u8 pcc[16];           # valid with Message-Security-Assist-Extension 4
        u8 ppno[16];          # valid with Message-Security-Assist-Extension 5
-       u8 reserved[1824];    # reserved for future instructions
+       u8 kma[16];           # valid with Message-Security-Assist-Extension 8
+       u8 reserved[1808];    # reserved for future instructions
 };
 
 Parameters: address of a buffer to load the subfunction blocks from.
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index bf92679..3dd2a1d 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -141,7 +141,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kmo[16];		/* with MSA4 */
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
-	__u8 reserved[1824];
+	__u8 kma[16];		/* with MSA8 */
+	__u8 reserved[1808];
 };
 
 /* kvm attributes for crypto */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8771fef..7eb1275 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -276,6 +276,10 @@ static void kvm_s390_cpu_feat_init(void)
 		__cpacf_query(CPACF_PPNO, (cpacf_mask_t *)
 			      kvm_s390_available_subfunc.ppno);
 
+	if (test_facility(146)) /* MSA8 */
+		__cpacf_query(CPACF_KMA, (cpacf_mask_t *)
+			      kvm_s390_available_subfunc.kma);
+
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
 	/*
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 0cf802d..be63fbd 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -82,6 +82,7 @@ static struct facility_def facility_defs[] = {
 			78, /* enhanced-DAT 2 */
 			130, /* instruction-execution-protection */
 			131, /* enhanced-SOP 2 and side-effect */
+			146, /* msa extension 8 */
 			-1  /* END */
 		}
 	},
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index a2ffec4..7f4fd65 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -131,7 +131,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kmo[16];		/* with MSA4 */
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
-	__u8 reserved[1824];
+	__u8 kma[16];		/* with MSA8 */
+	__u8 reserved[1808];
 };
 
 /* kvm attributes for crypto */
-- 
2.7.4
