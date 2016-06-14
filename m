From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 35/52] KVM: s390: enable ibs only if available
Date: Tue, 14 Jun 2016 20:57:12 +0200
Message-ID: <1465930649-181383-36-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's enable interlock-and-broadcast suppression only if the facility is
actually available.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d987eb8..ad93b40 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2789,6 +2789,8 @@ static void __disable_ibs_on_all_vcpus(struct kvm *kvm)
 
 static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
+	if (!sclp.has_ibs)
+		return;
 	kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu);
 	kvm_s390_sync_request(KVM_REQ_ENABLE_IBS, vcpu);
 }
-- 
2.5.5
