From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 9/9] KVM: s390: Removed kvm_s390_inject_sigp_stop()
Date: Thu, 28 Nov 2013 15:06:58 +0100
Message-ID: <1385647618-15541-10-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The function kvm_s390_inject_sigp_stop() as been unused since the
removal of the old mmu reload code and thus can be removed safely.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.h |    1 -
 arch/s390/kvm/sigp.c     |    6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 36f6b18..095cf51 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -128,7 +128,6 @@ int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_interrupt *s390int);
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
-int __must_check kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index c137ed3..c370058 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -190,12 +190,6 @@ unlock:
 	return rc;
 }
 
-int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action)
-{
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	return __inject_sigp_stop(li, action);
-}
-
 static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 {
 	int rc;
-- 
1.7.9.5
