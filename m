From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 3/6] KVM: s390: Add the SIGP order CONDITIONAL EMERGENCY SIGNAL
Date: Wed, 11 Dec 2013 19:57:46 +0100
Message-ID: <1386788269-20249-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

This patch adds the missing SIGP order "conditional emergency
signal" by calling the "emergency signal" SIGP handler if the
required conditions are met.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/sigp.h |    1 +
 arch/s390/kvm/sigp.c         |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index 5a87d16..c002cd5 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -12,6 +12,7 @@
 #define SIGP_SET_PREFIX		     13
 #define SIGP_STORE_STATUS_AT_ADDRESS 14
 #define SIGP_SET_ARCHITECTURE	     18
+#define SIGP_COND_EMERGENCY_SIGNAL   19
 #define SIGP_SENSE_RUNNING	     21
 
 /* SIGP condition codes */
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index bc0d85a..eee1402 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -1,7 +1,7 @@
 /*
  * handling interprocessor communication
  *
- * Copyright IBM Corp. 2008, 2009
+ * Copyright IBM Corp. 2008, 2013
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -89,6 +89,37 @@ unlock:
 	return rc;
 }
 
+static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
+					u16 asn, u64 *reg)
+{
+	struct kvm_vcpu *dst_vcpu = NULL;
+	const u64 psw_int_mask = PSW_MASK_IO | PSW_MASK_EXT;
+	u16 p_asn, s_asn;
+	psw_t *psw;
+	u32 flags;
+
+	if (cpu_addr < KVM_MAX_VCPUS)
+		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
+	flags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
+	psw = &dst_vcpu->arch.sie_block->gpsw;
+	p_asn = dst_vcpu->arch.sie_block->gcr[4] & 0xffff;  /* Primary ASN */
+	s_asn = dst_vcpu->arch.sie_block->gcr[3] & 0xffff;  /* Secondary ASN */
+
+	/* Deliver the emergency signal? */
+	if (!(flags & CPUSTAT_STOPPED)
+	    || (psw->mask & psw_int_mask) != psw_int_mask
+	    || ((flags & CPUSTAT_WAIT) && psw->addr != 0)
+	    || (!(flags & CPUSTAT_WAIT) && (asn == p_asn || asn == s_asn))) {
+		return __sigp_emergency(vcpu, cpu_addr);
+	} else {
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_INCORRECT_STATE;
+		return SIGP_CC_STATUS_STORED;
+	}
+}
+
 static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
@@ -417,6 +448,10 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		rc = __sigp_set_prefix(vcpu, cpu_addr, parameter,
 				       &vcpu->run->s.regs.gprs[r1]);
 		break;
+	case SIGP_COND_EMERGENCY_SIGNAL:
+		rc = __sigp_conditional_emergency(vcpu, cpu_addr, parameter,
+						  &vcpu->run->s.regs.gprs[r1]);
+		break;
 	case SIGP_SENSE_RUNNING:
 		vcpu->stat.instruction_sigp_sense_running++;
 		rc = __sigp_sense_running(vcpu, cpu_addr,
-- 
1.7.9.5
