From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/9] KVM: s390: Removed SIE_INTERCEPT_UCONTROL
Date: Thu, 28 Nov 2013 15:06:50 +0100
Message-ID: <1385647618-15541-2-git-send-email-cornelia.huck@de.ibm.com>
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

The SIE_INTERCEPT_UCONTROL can be removed by moving the related code
from kvm_arch_vcpu_ioctl_run() to vcpu_post_run().

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |   24 ++++++------------------
 arch/s390/kvm/kvm-s390.h |    2 --
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 569494e..7f47835 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -732,14 +732,12 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 
 	if (exit_reason >= 0) {
 		rc = 0;
-	} else {
-		if (kvm_is_ucontrol(vcpu->kvm)) {
-			rc = SIE_INTERCEPT_UCONTROL;
-		} else {
-			VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
-			trace_kvm_s390_sie_fault(vcpu);
-			rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		}
+	} else if (kvm_is_ucontrol(vcpu->kvm)) {
+		vcpu->run->exit_reason = KVM_EXIT_S390_UCONTROL;
+		vcpu->run->s390_ucontrol.trans_exc_code =
+						current->thread.gmap_addr;
+		vcpu->run->s390_ucontrol.pgm_code = 0x10;
+		rc = -EREMOTE;
 	}
 
 	memcpy(&vcpu->run->s.regs.gprs[14], &vcpu->arch.sie_block->gg14, 16);
@@ -833,16 +831,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		rc = -EINTR;
 	}
 
-#ifdef CONFIG_KVM_S390_UCONTROL
-	if (rc == SIE_INTERCEPT_UCONTROL) {
-		kvm_run->exit_reason = KVM_EXIT_S390_UCONTROL;
-		kvm_run->s390_ucontrol.trans_exc_code =
-			current->thread.gmap_addr;
-		kvm_run->s390_ucontrol.pgm_code = 0x10;
-		rc = 0;
-	}
-#endif
-
 	if (rc == -EOPNOTSUPP) {
 		/* intercept cannot be handled in-kernel, prepare kvm-run */
 		kvm_run->exit_reason         = KVM_EXIT_S390_SIEIC;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b44912a..aad541f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -27,8 +27,6 @@ typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 /* declare vfacilities extern */
 extern unsigned long *vfacilities;
 
-/* negativ values are error codes, positive values for internal conditions */
-#define SIE_INTERCEPT_UCONTROL		(1<<0)
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
 
 #define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
-- 
1.7.9.5
