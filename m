From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 49/52] KVM: s390: pfmf: handle address overflows
Date: Tue, 14 Jun 2016 20:57:26 +0200
Message-ID: <1465930649-181383-50-git-send-email-borntraeger@de.ibm.com>
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

In theory, end could always end up being < start, if overflowing to 0.
Although very unlikely for now, let's just fix it.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 752a1ac..b8327b8 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -715,7 +715,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	}
 
-	while (start < end) {
+	while (start != end) {
 		unsigned long useraddr;
 
 		/* Translate guest address to host address */
-- 
2.5.5
