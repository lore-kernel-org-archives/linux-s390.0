From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/18] KVM: s390: remove old fragment of vector registers
Date: Fri, 12 Feb 2016 14:22:56 +0100
Message-ID: <1455283382-62999-13-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Since commit 9977e886cbbc ("s390/kernel: lazy restore fpu registers"),
vregs in struct sie_page is unsed. We can safely remove the field and
the definition.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8959ebb..727e7f7 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -229,17 +229,11 @@ struct kvm_s390_itdb {
 	__u8	data[256];
 } __packed;
 
-struct kvm_s390_vregs {
-	__vector128 vrs[32];
-	__u8	reserved200[512];	/* for future vector expansion */
-} __packed;
-
 struct sie_page {
 	struct kvm_s390_sie_block sie_block;
 	__u8 reserved200[1024];		/* 0x0200 */
 	struct kvm_s390_itdb itdb;	/* 0x0600 */
-	__u8 reserved700[1280];		/* 0x0700 */
-	struct kvm_s390_vregs vregs;	/* 0x0c00 */
+	__u8 reserved700[2304];		/* 0x0700 */
 } __packed;
 
 struct kvm_vcpu_stat {
-- 
2.3.0
