From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:50 +0000
Subject: [GIT PULL 04/19] KVM: s390/vsie: avoid sparse warning
Message-Id: <20180731084405.28953-5-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is a non-functional change that avoids
arch/s390/kvm/vsie.c:839:25: warning: context imbalance in 'do_vsie_run' - unexpected unlock

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 84c89cb9636f..5539df037f91 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -818,6 +818,8 @@ static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  *          - < 0 if an error occurred
  */
 static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+	__releases(vcpu->kvm->srcu)
+	__acquires(vcpu->kvm->srcu)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-- 
2.17.0
