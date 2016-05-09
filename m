From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/10] KVM: s390: Enable all facility bits that are known good for passthrough
Date: Mon,  9 May 2016 11:20:19 +0200
Message-ID: <1462785621-12600-9-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

Some facility bits are in a range that is defined to be "ok for guests
without any necessary hypervisor changes". Enable those bits.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index eb52b36..5fe6605 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -119,8 +119,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[] = {
-	0xffe6fffbfcfdfc40UL,
-	0x005e800000000000UL,
+	0xffe6ffffffffffffUL,
+	0x005effffffffffffUL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
-- 
2.5.5
