From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 51/51] KVM: s390: vsie: add module parameter "nested"
Date: Tue, 21 Jun 2016 15:13:29 +0200
Message-ID: <1466514809-146638-52-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's be careful first and allow nested virtualization only if enabled
by the system administrator. In addition, user space still has to
explicitly enable it via SCLP features for it to work.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 31cf22f..03eeeb0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -125,6 +125,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
+/* allow nested virtualization in KVM (if enabled by user space) */
+static int nested;
+module_param(nested, int, S_IRUGO);
+MODULE_PARM_DESC(nested, "Nested virtualization support");
+
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[16] = {
 	0xffe6000000000000UL,
@@ -264,7 +269,7 @@ static void kvm_s390_cpu_feat_init(void)
 	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
 	 */
 	if (!sclp.has_sief2 || !MACHINE_HAS_ESOP || !sclp.has_64bscao ||
-	    !test_facility(3))
+	    !test_facility(3) || !nested)
 		return;
 	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
 	if (sclp.has_64bscao)
-- 
2.5.5
