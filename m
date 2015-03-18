From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/11] KVM: s390: drop SIMD bit from kvm_s390_fac_list_mask
Date: Wed, 18 Mar 2015 12:44:08 +0100
Message-ID: <1426679049-37696-11-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Setting the SIMD bit in the KVM mask is an issue because it makes the
facility visible but not usable to the guest, thus it needs to be
removed again.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0dc22ba..42b8a25 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -107,7 +107,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 unsigned long kvm_s390_fac_list_mask[] = {
 	0xff82fffbf4fc2000UL,
 	0x005c000000000000UL,
-	0x4000000000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
-- 
2.3.0
