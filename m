From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: Fix sdnxo setting for nested guests
Date: Fri,  7 Apr 2017 14:27:45 +0200
Message-ID: <1491568065-7491-1-git-send-email-borntraeger@de.ibm.com>
References: <70b26028-8076-c7ff-be17-b99946a20642@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <70b26028-8076-c7ff-be17-b99946a20642@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

If the guest does not use the host register management, but it uses
the sdnx area, we must fill in a proper sdnxo value (address of sdnx
and the sdnxc).

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 2fafc2b..025b1f2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -627,7 +627,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x10b0U);
 		if (rc)
 			goto unpin;
-		scb_s->sdnxo = hpa;
+		scb_s->sdnxo = hpa | sdnxc;
 	}
 	return 0;
 unpin:
-- 
2.7.4
