From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 06/47] KVM: s390: export test_vfacility()
Date: Tue, 15 Apr 2014 14:00:09 +0200
Message-ID: <1397563250-3089-7-git-send-email-borntraeger@de.ibm.com>
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

Make test_vfacility() available for other files. This is needed for the
new guest access functions, which test if certain facilities are available
for a guest.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 arch/s390/kvm/kvm-s390.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fe2396c..4b1df68 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -91,7 +91,7 @@ unsigned long *vfacilities;
 static struct gmap_notifier gmap_notifier;
 
 /* test availability of vfacility */
-static inline int test_vfacility(unsigned long nr)
+int test_vfacility(unsigned long nr)
 {
 	return __test_facility(nr, (void *) vfacilities);
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 25a8b84..f3ab9fc 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -162,6 +162,7 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
 /* is cmma enabled */
 bool kvm_s390_cmma_enabled(struct kvm *kvm);
+int test_vfacility(unsigned long nr);
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
-- 
1.8.4.2
