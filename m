From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: prevent buffer overrun on memory hotplug during migration
Date: Fri, 22 Dec 2017 15:51:28 +0100
Message-ID: <20171222145128.20836-3-borntraeger@de.ibm.com>
References: <20171222145128.20836-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171222145128.20836-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We must not go beyond the pre-allocated buffer. This can happen when
a new memory slot is added during migration.

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org # 4.13+
Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 572496c688cc..0714bfa56da0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1006,7 +1006,7 @@ static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
 		cbrlo[entries] = gfn << PAGE_SHIFT;
 	}
 
-	if (orc) {
+	if (orc && gfn < ms->bitmap_size) {
 		/* increment only if we are really flipping the bit to 1 */
 		if (!test_and_set_bit(gfn, ms->pgste_bitmap))
 			atomic64_inc(&ms->dirty_pages);
-- 
2.13.4
