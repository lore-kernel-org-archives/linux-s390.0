From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: vsie: fix riccbd
Date: Mon,  5 Sep 2016 14:07:03 +0200
Message-ID: <20160905120703.9491-2-cornelia.huck@de.ibm.com>
References: <20160905120703.9491-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160905120703.9491-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We store the address of riccbd at the wrong location, overwriting
gvrd. This means that our nested guest will not be able to use runtime
instrumentation. Also, a memory leak, if our KVM guest actually sets gvrd.

Not noticed until now, as KVM guests never make use of gvrd and runtime
instrumentation wasn't completely tested yet.

Reported-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c106488..d8673e2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -584,7 +584,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		/* Validity 0x0044 will be checked by SIE */
 		if (rc)
 			goto unpin;
-		scb_s->gvrd = hpa;
+		scb_s->riccbd = hpa;
 	}
 	return 0;
 unpin:
-- 
2.9.3
