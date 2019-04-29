Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/12] KVM: s390: add deflate conversion facilty to cpu model
Date: Mon, 29 Apr 2019 11:09:57 +0200
In-Reply-To: <20190429091002.71164-1-borntraeger@de.ibm.com>
References: <20190429091002.71164-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-8-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This enables stfle.151 and adds the subfunctions for DFLTCC. Bit 151 is
added to the list of facilities that will be enabled when there is no
cpu model involved as DFLTCC requires no additional handling from
userspace, e.g. for migration.

Please note that a cpu model enabled user space can and will have the
final decision on the facility bits for a guests.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/uapi/asm/kvm.h |  3 ++-
 arch/s390/kvm/kvm-s390.c         | 19 +++++++++++++++++++
 arch/s390/tools/gen_facilities.c |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index eba5bac08348..47104e5b47fd 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -154,7 +154,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kma[16];		/* with MSA8 */
 	__u8 kdsa[16];		/* with MSA9 */
 	__u8 sortl[32];		/* with STFLE.150 */
-	__u8 reserved[1760];
+	__u8 dfltcc[32];	/* with STFLE.151 */
+	__u8 reserved[1728];
 };
 
 /* kvm attributes for crypto */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 757f76bba9ea..38ca8324a91a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -335,6 +335,7 @@ static inline void __insn32_query(unsigned int opcode, u8 query[32])
 }
 
 #define INSN_SORTL 0xb938
+#define INSN_DFLTCC 0xb939
 
 static void kvm_s390_cpu_feat_init(void)
 {
@@ -390,6 +391,9 @@ static void kvm_s390_cpu_feat_init(void)
 	if (test_facility(150)) /* SORTL */
 		__insn32_query(INSN_SORTL, kvm_s390_available_subfunc.sortl);
 
+	if (test_facility(151)) /* DFLTCC */
+		__insn32_query(INSN_DFLTCC, kvm_s390_available_subfunc.dfltcc);
+
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
 	/*
@@ -1361,6 +1365,11 @@ static int kvm_s390_set_processor_subfunc(struct kvm *kvm,
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[1],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[2],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[3]);
+	VM_EVENT(kvm, 3, "SET: guest DFLTCC subfunc 0x%16.16lx.%16.16lx.%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[0],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[1],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[2],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[3]);
 
 	return 0;
 }
@@ -1537,6 +1546,11 @@ static int kvm_s390_get_processor_subfunc(struct kvm *kvm,
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[1],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[2],
 		 ((unsigned long *) &kvm->arch.model.subfuncs.sortl)[3]);
+	VM_EVENT(kvm, 3, "GET: guest DFLTCC subfunc 0x%16.16lx.%16.16lx.%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[0],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[1],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[2],
+		 ((unsigned long *) &kvm->arch.model.subfuncs.dfltcc)[3]);
 
 	return 0;
 }
@@ -1600,6 +1614,11 @@ static int kvm_s390_get_machine_subfunc(struct kvm *kvm,
 		 ((unsigned long *) &kvm_s390_available_subfunc.sortl)[1],
 		 ((unsigned long *) &kvm_s390_available_subfunc.sortl)[2],
 		 ((unsigned long *) &kvm_s390_available_subfunc.sortl)[3]);
+	VM_EVENT(kvm, 3, "GET: host  DFLTCC subfunc 0x%16.16lx.%16.16lx.%16.16lx.%16.16lx",
+		 ((unsigned long *) &kvm_s390_available_subfunc.dfltcc)[0],
+		 ((unsigned long *) &kvm_s390_available_subfunc.dfltcc)[1],
+		 ((unsigned long *) &kvm_s390_available_subfunc.dfltcc)[2],
+		 ((unsigned long *) &kvm_s390_available_subfunc.dfltcc)[3]);
 
 	return 0;
 }
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 1ec6bed785e8..cead9e0dcffb 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -94,6 +94,7 @@ static struct facility_def facility_defs[] = {
 			139, /* multiple epoch facility */
 			146, /* msa extension 8 */
 			150, /* enhanced sort */
+			151, /* deflate conversion */
 			155, /* msa extension 9 */
 			-1  /* END */
 		}
-- 
2.19.1
