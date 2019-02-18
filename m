From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Feb 2019 11:30:46 +0000
Subject: [GIT PULL 1/1] s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity
Message-Id: <20190218113046.226380-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When facility.76 MSAX3 is present for the guest we must issue a validity
interception if the CRYCBD is not valid.

The bit CRYCBD.31 is an effective field and tested at each guest level
and has for effect to mask the facility.76

It follows that if CRYCBD.31 is clear and AP is not in use  we do not
have to test the CRYCBD validatity even if facility.76 is present in the
host.

Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
Cc: stable@vger.kernel.org

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a153257bf7d98..d62fa148558b9 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -297,7 +297,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->crycbd = 0;
 
 	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
-	if (!apie_h && !key_msk)
+	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
 		return 0;
 
 	if (!crycb_addr)
-- 
2.19.1
