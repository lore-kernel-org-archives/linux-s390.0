From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 27/47] KVM: s390: reinject io interrupt on tpi failure
Date: Tue, 15 Apr 2014 14:00:30 +0200
Message-ID: <1397563250-3089-28-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The tpi instruction should be suppressed on addressing and protection
exceptions, so we need to re-inject the dequeued io interrupt in that
case.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |  6 ++++++
 arch/s390/kvm/kvm-s390.h  |  2 ++
 arch/s390/kvm/priv.c      | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a1403ba..1c74bb9 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -846,6 +846,12 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 	return __inject_vm(kvm, inti);
 }
 
+void kvm_s390_reinject_io_int(struct kvm *kvm,
+			      struct kvm_s390_interrupt_info *inti)
+{
+	__inject_vm(kvm, inti);
+}
+
 int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 			 struct kvm_s390_interrupt *s390int)
 {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 11ed0a5..dc506f3 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -137,6 +137,8 @@ int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
+void kvm_s390_reinject_io_int(struct kvm *kvm,
+			      struct kvm_s390_interrupt_info *inti);
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
 
 /* implemented in priv.c */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4f6bc16..f4451f0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -259,7 +259,15 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 		if (write_guest_lc(vcpu, __LC_SUBCHANNEL_ID, &tpi_data, len))
 			rc = -EFAULT;
 	}
-	kfree(inti);
+	/*
+	 * If we encounter a problem storing the interruption code, the
+	 * instruction is suppressed from the guest's view: reinject the
+	 * interrupt.
+	 */
+	if (!rc)
+		kfree(inti);
+	else
+		kvm_s390_reinject_io_int(vcpu->kvm, inti);
 no_interrupt:
 	/* Set condition code and we're done. */
 	if (!rc)
-- 
1.8.4.2
