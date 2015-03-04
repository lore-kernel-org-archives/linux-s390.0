From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/5] KVM: s390/cpacf: Enable key wrapping by default
Date: Wed,  4 Mar 2015 12:41:50 +0100
Message-ID: <1425469314-48913-2-git-send-email-borntraeger@de.ibm.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

z/VM and LPAR enable key wrapping by default, lets do the same on KVM.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0c36239..b4d2030 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -839,9 +839,13 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
 
 	kvm_s390_set_crycb_format(kvm);
 
-	/* Disable AES/DEA protected key functions by default */
-	kvm->arch.crypto.aes_kw = 0;
-	kvm->arch.crypto.dea_kw = 0;
+	/* Enable AES/DEA protected key functions by default */
+	kvm->arch.crypto.aes_kw = 1;
+	kvm->arch.crypto.dea_kw = 1;
+	get_random_bytes(kvm->arch.crypto.crycb->aes_wrapping_key_mask,
+			 sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
+	get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
+			 sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
 
 	return 0;
 }
-- 
2.3.0
