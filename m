Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/12] KVM: s390: add MSA9 to cpumodel
Date: Mon, 29 Apr 2019 11:09:54 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-5-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This enables stfle.155 and adds the subfunctions for KDSA. Bit 155 is
added to the list of facilities that will be enabled when there is no
cpu model involved as MSA9 requires no additional handling from
userspace, e.g. for migration.

Please note that a cpu model enabled user space can and will have the
final decision on the facility bits for a guests.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virtual/kvm/devices/vm.txt |  3 ++-
 arch/s390/include/asm/cpacf.h            |  1 +
 arch/s390/include/uapi/asm/kvm.h         |  3 ++-
 arch/s390/kvm/kvm-s390.c                 | 13 +++++++++++++
 arch/s390/tools/gen_facilities.c         |  1 +
 tools/arch/s390/include/uapi/asm/kvm.h   |  3 ++-
 6 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 95ca68d663a4..4ffb82b02468 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -141,7 +141,8 @@ struct kvm_s390_vm_cpu_subfunc {
        u8 pcc[16];           # valid with Message-Security-Assist-Extension 4
        u8 ppno[16];          # valid with Message-Security-Assist-Extension 5
        u8 kma[16];           # valid with Message-Security-Assist-Extension 8
-       u8 reserved[1808];    # reserved for future instructions
+       u8 kdsa[16];          # valid with Message-Security-Assist-Extension 9
+       u8 reserved[1792];    # reserved for future instructions
 };
 
 Parameters: address of a buffer to load the subfunction blocks from.
diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 3cc52e37b4b2..ce2770743cc5 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -28,6 +28,7 @@
 #define CPACF_KMCTR		0xb92d		/* MSA4 */
 #define CPACF_PRNO		0xb93c		/* MSA5 */
 #define CPACF_KMA		0xb929		/* MSA8 */
+#define CPACF_KDSA		0xb93a		/* MSA9 */
 
 /*
  * En/decryption modifier bits
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 16511d97e8dc..09652eabe769 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -152,7 +152,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
 	__u8 kma[16];		/* with MSA8 */
-	__u8 reserved[1808];
+	__u8 kdsa[16];		/* with MSA9 */
+	__u8 reserved[1792];
 };
 
 /* kvm attributes for crypto */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d3f3e63bb164..0dad61ccde3d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -368,6 +368,10 @@ static void kvm_s390_cpu_feat_init(void)
 		__cpacf_query(CPACF_KMA, (cpacf_mask_t *)
 			      kvm_s390_available_subfunc.kma);
 
+	if (test_facility(155)) /* MSA9 */
+		__cpacf_query(CPACF_KDSA, (cpacf_mask_t *)
+			      kvm_s390_available_subfunc.kdsa);
+
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
 	/*
@@ -1331,6 +1335,9 @@ static int kvm_s390_set_processor_subfunc(struct kvm *kvm,
 	VM_EVENT(kvm, 3, "SET: guest KMA    subfunc 0x%16.16lx.%16.16lx",
 		 ((unsigned long *) &kvm->arch.model.subfuncs.kma)[0],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.kma)[1]);
+	VM_EVENT(kvm, 3, "SET: guest KDSA   subfunc 0x%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm->arch.model.subfuncs.kdsa)[0],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.kdsa)[1]);
 
 	return 0;
 }
@@ -1499,6 +1506,9 @@ static int kvm_s390_get_processor_subfunc(struct kvm *kvm,
 	VM_EVENT(kvm, 3, "GET: guest KMA    subfunc 0x%16.16lx.%16.16lx",
 		 ((unsigned long *) &kvm->arch.model.subfuncs.kma)[0],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.kma)[1]);
+	VM_EVENT(kvm, 3, "GET: guest KDSA   subfunc 0x%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm->arch.model.subfuncs.kdsa)[0],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.kdsa)[1]);
 
 	return 0;
 }
@@ -1554,6 +1564,9 @@ static int kvm_s390_get_machine_subfunc(struct kvm *kvm,
 	VM_EVENT(kvm, 3, "GET: host  KMA    subfunc 0x%16.16lx.%16.16lx",
 		 ((unsigned long *) &kvm_s390_available_subfunc.kma)[0],
 		 ((unsigned long *) &kvm_s390_available_subfunc.kma)[1]);
+	VM_EVENT(kvm, 3, "GET: host  KDSA   subfunc 0x%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm_s390_available_subfunc.kdsa)[0],
+		 ((unsigned long *) &kvm_s390_available_subfunc.kdsa)[1]);
 
 	return 0;
 }
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index fd788e0f2e5b..e952cb3b75b2 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -93,6 +93,7 @@ static struct facility_def facility_defs[] = {
 			131, /* enhanced-SOP 2 and side-effect */
 			139, /* multiple epoch facility */
 			146, /* msa extension 8 */
+			155, /* msa extension 9 */
 			-1  /* END */
 		}
 	},
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 16511d97e8dc..09652eabe769 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -152,7 +152,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
 	__u8 kma[16];		/* with MSA8 */
-	__u8 reserved[1808];
+	__u8 kdsa[16];		/* with MSA9 */
+	__u8 reserved[1792];
 };
 
 /* kvm attributes for crypto */
-- 
2.19.1
