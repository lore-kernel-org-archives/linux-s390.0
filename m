From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/4] KVM: s390: Support keyless subset guest mode
Date: Fri, 21 Apr 2017 12:09:45 +0200
Message-ID: <1492769385-237420-5-git-send-email-borntraeger@de.ibm.com>
References: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Farhan Ali <alifm@linux.vnet.ibm.com>, "Corey S . McQuay" <csmcquay@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

If the KSS facility is available on the machine, we also make it
available for our KVM guests.

The KSS facility bypasses storage key management as long as the guest
does not issue a related instruction. When that happens, the control is
returned to the host, which has to turn off KSS for a guest vcpu
before retrying the instruction.

Signed-off-by: Corey S. McQuay <csmcquay@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/intercept.c        |  3 +++
 arch/s390/kvm/kvm-s390.c         |  8 +++++++-
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/priv.c             | 19 +++++++++++++------
 arch/s390/kvm/vsie.c             |  6 +++++-
 7 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 552c319..426614a 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -122,6 +122,7 @@ struct esca_block {
 #define CPUSTAT_SLSR       0x00002000
 #define CPUSTAT_ZARCH      0x00000800
 #define CPUSTAT_MCDS       0x00000100
+#define CPUSTAT_KSS        0x00000200
 #define CPUSTAT_SM         0x00000080
 #define CPUSTAT_IBS        0x00000040
 #define CPUSTAT_GED2       0x00000010
@@ -185,6 +186,7 @@ struct kvm_s390_sie_block {
 #define ICPT_OPEREXC	0x2C
 #define ICPT_PARTEXEC	0x38
 #define ICPT_IOINST	0x40
+#define ICPT_KSS	0x5c
 	__u8	icptcode;		/* 0x0050 */
 	__u8	icptstatus;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 2c9ad25..bf92679 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -119,6 +119,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_CMMA	10
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
+#define KVM_S390_VM_CPU_FEAT_KSS	13
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index f5378f3..a4752bf 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -426,6 +426,9 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 	case ICPT_PARTEXEC:
 		rc = handle_partial_execution(vcpu);
 		break;
+	case ICPT_KSS:
+		rc = kvm_s390_skey_check_enable(vcpu);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 11b7d66..8771fef 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -300,6 +300,8 @@ static void kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_CEI);
 	if (sclp.has_ibs)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_IBS);
+	if (sclp.has_kss)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
@@ -2034,7 +2036,11 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->sdnxo = ((unsigned long) &vcpu->run->s.regs.sdnx)
 					| SDNXC;
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
-	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+
+	if (sclp.has_kss)
+		atomic_or(CPUSTAT_KSS, &vcpu->arch.sie_block->cpuflags);
+	else
+		vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
 	if (vcpu->kvm->arch.use_cmma) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 455124f..55f5c84 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -254,6 +254,7 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
+int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu);
 
 /* implemented in vsie.c */
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 0ffe973..c03106c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -198,18 +198,25 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int __skey_check_enable(struct kvm_vcpu *vcpu)
+int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 {
 	int rc = 0;
+	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
 
 	trace_kvm_s390_skey_related_inst(vcpu);
-	if (!(vcpu->arch.sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)))
+	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
+	    !(atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS))
 		return rc;
 
 	rc = s390_enable_skey();
 	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
-	if (!rc)
-		vcpu->arch.sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
+	if (!rc) {
+		if (atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS)
+			atomic_andnot(CPUSTAT_KSS, &sie_block->cpuflags);
+		else
+			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
+					     ICTL_RRBE);
+	}
 	return rc;
 }
 
@@ -218,7 +225,7 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
 	int rc;
 
 	vcpu->stat.instruction_storage_key++;
-	rc = __skey_check_enable(vcpu);
+	rc = kvm_s390_skey_check_enable(vcpu);
 	if (rc)
 		return rc;
 	if (sclp.has_skey) {
@@ -916,7 +923,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		}
 
 		if (vcpu->run->s.regs.gprs[reg1] & PFMF_SK) {
-			int rc = __skey_check_enable(vcpu);
+			int rc = kvm_s390_skey_check_enable(vcpu);
 
 			if (rc)
 				return rc;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 025b1f2..4719ecb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -117,6 +117,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		newflags |= cpuflags & CPUSTAT_SM;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IBS))
 		newflags |= cpuflags & CPUSTAT_IBS;
+	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_KSS))
+		newflags |= cpuflags & CPUSTAT_KSS;
 
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
@@ -289,7 +291,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	 * bits. Therefore we cannot provide interpretation and would later
 	 * have to provide own emulation handlers.
 	 */
-	scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_KSS))
+		scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+
 	scb_s->icpua = scb_o->icpua;
 
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
-- 
2.7.4
