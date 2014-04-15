From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 05/47] KVM: add kvm_is_error_gpa() helper
Date: Tue, 15 Apr 2014 14:00:08 +0200
Message-ID: <1397563250-3089-6-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

It's quite common (in the s390 guest access code) to test if a guest
physical address points to a valid guest memory area or not.
So add a simple helper function in common code, since this might be
of interest for other architectures as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7d21cf9..471d140 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -879,6 +879,13 @@ static inline hpa_t pfn_to_hpa(pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
 
+static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
+{
+	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
+
+	return kvm_is_error_hva(hva);
+}
+
 static inline void kvm_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	set_bit(KVM_REQ_MIGRATE_TIMER, &vcpu->requests);
-- 
1.8.4.2
