Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E74457A5;
	Fri, 31 Jul 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503400; cv=none; b=Wgh4481hX21M/XgSIXE5ZEuW9TXM3fMKKgNgRXjCxCJaMzZ0madiVbJgxcPB3fja6d9nP1cjM90EQsi179kEHUAY9akOhSsSi5XxV4U/6co+XMUgC5otSV4/n91T7iYd2M45NcKKOIrL4SHhvCRWpmCaJMBUrvL7Dp2j2dQk9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503400; c=relaxed/simple;
	bh=CICD/5LiKsZOQio7EnwScEUOi6Hmuo25l1ZaAalt1WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VijChhV/SK4oyp+Uiyj1jf2u4X5LDNSqttXNos5jhRsiC71L23GvYcsdta132Btie9P3xUJt5ex1x8V7Jg9dkI0ItptWvurNBQQty1Ug31boUGNIEUDvyZvz1VX56HP33AD4pEN0twHxT28T/5higltX0pszTRY7mtzvuPkEMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CkJj1HOw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CkJj1HOw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlwdT1791076;
	Fri, 31 Jul 2026 13:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=haO0xL
	g1lpYQDFg+IUbQ8KntQoXbMlCu5mOwhPaZ38Y=; b=CkJj1HOwbZfiRhwIjzkUOc
	hVHGjuN3IGRbD0Nb+r2y1BEIFjjlDHgy+NPANbUhQp0WvTn0mRmj3UWuabS5StiX
	TqdZmMxvXGU8HF0DBi6DTlEWZS2ieWO7cS0AKXPFgPQH4zla1GlRxp2jfxF9rSnX
	BOXZrRN6VNzt3q0o6W7qHD/EH79KYw/jryCgc5BXmUP0T5YU75Ankv0p817565tj
	UDWYxL0ballBkBiv75jExPoocVsXQ9k4161zcKeeWFlNJhUfq34U3q/jwYjjgl/2
	cBRSeOhFdbU3ikdbo3k6CH/paF0u/kfVNj6d+44v9un6mS3cC6n5FXLRyPa4CtwQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdc41g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuGHF021726;
	Fri, 31 Jul 2026 13:09:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg436-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD93CA32965088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B13E620040;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ADD22004B;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:03 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 01/31] vfio: Use file-based reference counting for KVM
Date: Fri, 31 Jul 2026 15:08:29 +0200
Message-ID: <20260731130902.654679-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Zkjb6K7lJBXcG6qt_qPGmH9FhMYnE4iR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXx92q1D91z8MN
 CnLPRFpuefHDoA1CrGKOH8NheaD1LWqVbK9lppP1XCbpey6IekS39BHwoh8ajT6lbVvKF49AlTp
 KIpmTDTmLV1VbcWsteZ8+0Z1djOWiKc=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c9e78 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=x4cQU7UQcekLRWkedJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXyEH0gfwrCeq7
 hUEgU1RPtk0jO/XM1QZPC6zcC8Vz7Ja3ipTg/s+FnaXJxUlHu/s+/pgT90aWt8IUoyCRbvVPsoc
 JBvSygvUAP0oUFLtyWxXYa/OYN16f2JFzIJDKFqVMMHYoEwzxMmYauIhL8AzzqJeq3GFvrtC1wc
 YouVdKb9URxEm656zyE+z353CyNd+TQIoIVAxG08RmHGx92XhkQ9MZ1r4Wpfuwz8sgd6hen1TzF
 vk2jL5CXsGeML5QjDYDoHeRFHyUpbwZV1csyLS/YMrf0k6BQZV/S7ubd0lLPZcelnI+k6Sk4eIB
 3JG2RyjnePDz23MpBvV33u9ntYyScb6EdNJijcoQZqPlYNNRXtzKnfNKnlXK2uLxfZfsRee7kfG
 5n0tDAygXmCATKZ4JJQTQcnWa2w5mE5ciH6Qm/psURHnUMYb+cYG/CA8uVaPmxu5Gtuq5sTSP1C
 3HN0SvNNZOCjYhL48/w==
X-Proofpoint-GUID: u029MMhrGTWQTlFvb-nZKPp46zOeFdW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface. This leverages the kernel's existing file reference
counting mechanism via get_file_active() and fput(), eliminating the
need for manual module reference tracking. The file->private_data field
provides access to the underlying struct kvm when needed.

This simplifies the code and removes all remaining externally exported
symbols for KVM, paving the path for a second concurrent KVM module.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/include/asm/kvm_page_track.h |  8 ++---
 arch/x86/kvm/Makefile                 |  3 --
 arch/x86/kvm/mmu/page_track.c         | 16 +++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 24 ++++++++++---
 drivers/vfio/group.c                  |  2 +-
 drivers/vfio/pci/vfio_pci_zdev.c      |  7 +++-
 drivers/vfio/vfio.h                   | 10 +++---
 drivers/vfio/vfio_main.c              | 49 ++++++---------------------
 include/linux/kvm_host.h              |  2 ++
 include/linux/vfio.h                  |  4 +--
 virt/kvm/kvm_main.c                   | 23 ++++++++++---
 virt/kvm/vfio.c                       |  8 ++---
 12 files changed, 81 insertions(+), 75 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 3d040741044b..046a25c8fe4f 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -44,13 +44,13 @@ struct kvm_page_track_notifier_node {
 				    struct kvm_page_track_notifier_node *node);
 };
 
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n);
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n);
 
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn);
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn);
 #else
 /*
  * Allow defining a node in a structure even if page tracking is disabled, e.g.
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 77337c37324b..713fb6e76730 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -61,9 +61,6 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
-				-e kvm_get_kvm \
-				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb..860049ed24ea 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -237,10 +237,11 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
  */
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm(file);
 	int r;
 
 	if (!kvm || kvm->mm != current->mm)
@@ -252,7 +253,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 			return r;
 	}
 
-	kvm_get_kvm(kvm);
+	get_file(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -267,10 +268,11 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
  * stop receiving the event interception. It is the opposed operation of
  * kvm_page_track_register_notifier().
  */
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -279,7 +281,7 @@ void kvm_page_track_unregister_notifier(struct kvm *kvm,
 	write_unlock(&kvm->mmu_lock);
 	synchronize_srcu(&head->track_srcu);
 
-	kvm_put_kvm(kvm);
+	fput(file);
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
 
@@ -339,8 +341,9 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
  * @kvm: the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -369,8 +372,9 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * @kvm: the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..bf6a5b959fcd 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -8,6 +8,7 @@
  *	      Halil Pasic <pasic@linux.ibm.com>
  *	      Pierre Morel <pmorel@linux.ibm.com>
  */
+#include "linux/cleanup.h"
 #include <linux/string.h>
 #include <linux/vfio.h>
 #include <linux/device.h>
@@ -1815,13 +1816,26 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
  * @matrix_mdev: a mediated matrix device
  * @kvm: reference to KVM instance
  *
- * Return: 0 if no other mediated matrix device has a reference to @kvm;
- * otherwise, returns an -EPERM.
+ * Returns: 0 if the reference to kvm is successfully retrieved from @kvm_file
+ * and set into @matrix_mdev; otherwise, returns:
+ *	-ENOENT if a reference to kvm could not be retrieved from @kvm_file
+ *	-EPERM if another mediated matrix device already has a reference to the same kvm instance
+ * 
  */
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
-				struct kvm *kvm)
+				struct file *kvm_file)
 {
+	struct file *kvm_file_ref __free(fput) = NULL;
 	struct ap_matrix_mdev *m;
+	struct kvm *kvm;
+
+	kvm_file_ref = get_file_active(&kvm_file);
+	if (!kvm_file_ref)
+		return -ENOENT;
+
+	kvm = kvm_file->private_data;
+	if (!kvm)
+		return -ENOENT;
 
 	if (kvm->arch.crypto.crycbd) {
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
@@ -1837,13 +1851,13 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 			}
 		}
 
-		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 		release_update_locks_for_kvm(kvm);
 	}
 
+	no_free_ptr(kvm_file_ref);
 	return 0;
 }
 
@@ -1891,7 +1905,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 
 		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
-		kvm_put_kvm(kvm);
+		fput(kvm->file);
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..807378cb48de 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -860,7 +860,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
 	spin_lock(&group->kvm_ref_lock);
 	group->kvm = kvm;
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..d3a110101353 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -144,6 +144,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	struct kvm *kvm;
 
 	if (!zdev)
 		return -ENODEV;
@@ -151,8 +152,12 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 	if (!vdev->vdev.kvm)
 		return 0;
 
+	kvm = vdev->vdev.kvm->private_data;
+	if (!kvm)
+		return -ENOENT;
+
 	if (zpci_kvm_hook.kvm_register)
-		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+		return zpci_kvm_hook.kvm_register(zdev, kvm);
 
 	return -ENOENT;
 }
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..ede8a8001b03 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -23,7 +23,7 @@ struct vfio_device_file {
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
 	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	struct file *kvm;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm;
 	struct file			*opened_file;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
@@ -107,7 +107,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -434,11 +434,11 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct file *kvm)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index ed538aebb0b8..8fad1ca1189f 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -448,35 +448,13 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
-	if (!kvm)
-		return;
-
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
+	if (!get_file_active(&kvm))
 		return;
 
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	device->put_kvm = pfn;
 	device->kvm = kvm;
 }
 
@@ -487,14 +465,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	if (!device->kvm)
 		return;
 
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
-
-	device->put_kvm(device->kvm);
-	device->put_kvm = NULL;
-	symbol_put(kvm_put_kvm);
-
-clear:
+	fput(device->kvm);
 	device->kvm = NULL;
 }
 #endif
@@ -1520,7 +1491,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1536,22 +1507,22 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 
 /**
  * vfio_file_set_kvm - Link a kvm with VFIO drivers
- * @file: VFIO group file or VFIO device file
- * @kvm: KVM to link
+ * @vfio_file: VFIO group file or VFIO device file
+ * @kvm: KVM file to link
  *
  * When a VFIO device is first opened the KVM will be available in
  * device->kvm if one was associated with the file.
  */
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
 {
 	struct vfio_group *group;
 
-	group = vfio_group_from_file(file);
+	group = vfio_group_from_file(vfio_file);
 	if (group)
 		vfio_group_set_kvm(group, kvm);
 
-	if (vfio_device_from_file(file))
-		vfio_device_file_set_kvm(file, kvm);
+	if (vfio_device_from_file(vfio_file))
+		vfio_device_file_set_kvm(vfio_file, kvm);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..90a9f840fece 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -784,6 +784,7 @@ struct kvm {
 	 * kvm_swap_active_memslots().
 	 */
 	struct mutex slots_arch_lock;
+	struct file *file;  /* Back-reference to VM file descriptor */
 	struct mm_struct *mm; /* userspace tied to this vm */
 	unsigned long nr_memslot_pages;
 	/* The two memslot sets - active and inactive (per address space) */
@@ -1074,6 +1075,7 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct kvm *file_to_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..b279bdb6f813 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,7 +54,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
-	struct kvm *kvm;
+	struct file *kvm;  /* Holds reference to KVM file */
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -377,7 +377,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..994cb40cf2ef 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1313,7 +1313,7 @@ void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
 
 /*
  * Make sure the vm is not during destruction, which is a safe version of
@@ -1323,14 +1323,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
 {
 	return refcount_inc_not_zero(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm_safe);
 
 void kvm_put_kvm(struct kvm *kvm)
 {
 	if (refcount_dec_and_test(&kvm->users_count))
 		kvm_destroy_vm(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm);
 
 /*
  * Used to put a reference that was taken on behalf of an object associated
@@ -4802,7 +4802,7 @@ void kvm_unregister_device_ops(u32 type)
 		kvm_device_ops_table[type] = NULL;
 }
 
-static int kvm_ioctl_create_device(struct kvm *kvm,
+static int kvm_ioctl_create_device(struct file *file, struct kvm *kvm,
 				   struct kvm_create_device *cd)
 {
 	const struct kvm_device_ops *ops;
@@ -5345,7 +5345,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&cd, argp, sizeof(cd)))
 			goto out;
 
-		r = kvm_ioctl_create_device(kvm, &cd);
+		r = kvm_ioctl_create_device(filp, kvm, &cd);
 		if (r)
 			goto out;
 
@@ -5477,6 +5477,15 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+struct kvm *file_to_kvm(struct file *file)
+{
+	if (!file_is_kvm(file))
+		return NULL;
+
+	return file->private_data;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_to_kvm);
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
@@ -5508,6 +5517,10 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 * cases it will be called by the final fput(file) and will take
 	 * care of doing kvm_put_kvm(kvm).
 	 */
+
+	/* Store back-reference for VFIO and other subsystems */
+	kvm->file = file;
+
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
 
 	fd_install(fd, file);
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6cdc4e9a333a..0166cc4d39b3 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -35,15 +35,15 @@ struct kvm_vfio {
 	bool noncoherent;
 };
 
-static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+static void kvm_vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *vfio_file, struct file *kvm);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
 		return;
 
-	fn(file, kvm);
+	fn(vfio_file, kvm);
 
 	symbol_put(vfio_file_set_kvm);
 }
@@ -168,7 +168,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, dev->kvm->file);
 	kvm_vfio_update_coherency(dev);
 
 	return 0;
-- 
2.53.0

