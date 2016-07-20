From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: let ptff intercepts result in cc=3
Date: Wed, 20 Jul 2016 14:40:00 +0200
Message-ID: <1469018400-8397-3-git-send-email-borntraeger@de.ibm.com>
References: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We don't emulate ptff subfunctions, therefore react on any attempt of
execution by setting cc=3 (Requested function not available).

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index c77ad2d..4616038 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1185,7 +1185,15 @@ static int handle_sckpf(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_ptff(struct kvm_vcpu *vcpu)
+{
+	/* we don't emulate any control instructions yet */
+	kvm_s390_set_psw_cc(vcpu, 3);
+	return 0;
+}
+
 static const intercept_handler_t x01_handlers[256] = {
+	[0x04] = handle_ptff,
 	[0x07] = handle_sckpf,
 };
 
-- 
2.5.5
