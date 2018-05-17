From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 17 May 2018 11:18:21 +0000
Subject: [GIT PULL 1/1] KVM: s390: vsie: fix < 8k check for the itdba
Message-Id: <20180517111821.239220-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

By missing an "L", we might detect some addresses to be <8k,
although they are not.

e.g. for itdba = 100001fff
!(gpa & ~0x1fffU) -> 1
!(gpa & ~0x1fffUL) -> 0

So we would report a SIE validity intercept although everything is fine.

Fixes: 166ecb3 ("KVM: s390: vsie: support transactional execution")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 8961e3970901..969882b54266 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -578,7 +578,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
 	if (gpa && (scb_s->ecb & ECB_TE)) {
-		if (!(gpa & ~0x1fffU)) {
+		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
-- 
2.14.2
