From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390: disable RRBM again
Date: Wed, 15 Apr 2015 12:27:04 +0200
Message-ID: <1429093624-49611-2-git-send-email-borntraeger@de.ibm.com>
References: <1429093624-49611-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1429093624-49611-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit b273921356df ("KVM: s390: enable more features that need
no hypervisor changes") also enabled RRBM. Turns out that this
instruction does need some KVM code, so lets disable that bit
again.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Fixes: b273921356df ("KVM: s390: enable more features that need no hypervisor changes") 

---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3040b14..98ba0fc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -110,7 +110,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[] = {
 	0xffe6fffbfcfdfc40UL,
-	0x205c800000000000UL,
+	0x005c800000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
-- 
2.3.0
