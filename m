From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 14/21] KVM: s390: clear the pfault queue if user space sets the invalid token
Date: Thu, 15 Jan 2015 14:43:27 +0100
Message-ID: <1421329414-76826-15-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We need a way to clear the async pfault queue from user space (e.g.
for resets and SIGP SET ARCHITECTURE).

This patch simply clears the queue as soon as user space sets the
invalid pfault token. The definition of the invalid token is moved
to uapi.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 -
 arch/s390/include/uapi/asm/kvm.h | 3 +++
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 4de479e..b617052 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -469,7 +469,6 @@ struct kvm_vcpu_arch {
 	};
 	struct gmap *gmap;
 	struct kvm_guestdbg_info_arch guestdbg;
-#define KVM_S390_PFAULT_TOKEN_INVALID	(-1UL)
 	unsigned long pfault_token;
 	unsigned long pfault_select;
 	unsigned long pfault_compare;
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 9c01159..ac3000d 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -108,6 +108,9 @@ struct kvm_guest_debug_arch {
 	struct kvm_hw_breakpoint __user *hw_bp;
 };
 
+/* for KVM_SYNC_PFAULT and KVM_REG_S390_PFTOKEN */
+#define KVM_S390_PFAULT_TOKEN_INVALID	0xffffffffffffffffUL
+
 #define KVM_SYNC_PREFIX (1UL << 0)
 #define KVM_SYNC_GPRS   (1UL << 1)
 #define KVM_SYNC_ACRS   (1UL << 2)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9bdc9f9..bfb2b99 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -936,6 +936,8 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_S390_PFTOKEN:
 		r = get_user(vcpu->arch.pfault_token,
 			     (u64 __user *)reg->addr);
+		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
+			kvm_clear_async_pf_completion_queue(vcpu);
 		break;
 	case KVM_REG_S390_PFCOMPARE:
 		r = get_user(vcpu->arch.pfault_compare,
@@ -1408,6 +1410,8 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		vcpu->arch.pfault_token = kvm_run->s.regs.pft;
 		vcpu->arch.pfault_select = kvm_run->s.regs.pfs;
 		vcpu->arch.pfault_compare = kvm_run->s.regs.pfc;
+		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
+			kvm_clear_async_pf_completion_queue(vcpu);
 	}
 	kvm_run->kvm_dirty_regs = 0;
 }
-- 
1.9.3
