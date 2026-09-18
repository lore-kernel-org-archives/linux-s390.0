Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD5502574;
	Fri, 18 Sep 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738601; cv=none; b=C0TR9Zir2+MsXkYSaHZGVYiRZ7jY7zHeYFSiMx+upPUzSip1iln1eqYvStec/MKNdGdjjJY/DGi5+g9WSq4eltT/CS06kdFLPsN66FB9LL3arvUzGh/uKsiB4d5gafqlskA6GgfQY/WzMmg4SjZBg8ow2QNMWvR3t7FWnSAL0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738601; c=relaxed/simple;
	bh=XsnM/0XsktS2sF+YlIfsDsw/JgGZ+aGtjJctmbBOLeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inLyB2QdGvyGuC/9Ug0yudz0dKwuHAn6yu6AJacUhh6Fp6EFbnSxAs7IXNOv24EW7X2fts9F+KfKwpTmugDH5zthuYMHShV9/MFC9ynOsNJ7azAQuXi/mI0eh8dJKzSem6tEOLFPTnE6kq6gu63y0f+5/cU2ADh+ZIJc8Rv2sU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AAbG5ARW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AAbG5ARW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2nhS991057;
	Fri, 18 Sep 2026 13:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TPCKSNeFnfNK3/ftY
	279YVqWwTRGevmLg/hUf5O+cjQ=; b=AAbG5ARWeUnJQS8eDx2g1IjvyBvkHF7vP
	gT7Ly+I8HJJajOQ5nZZ8gY21bId2UAn00E6Ap6ps4I8hIoGhaiiXrFxbZQJZf/Fz
	S90erFgAjUAO53zNuCGNK7Qzi9vbWInK3A1FBFfKAA1nie8qqeIP7+10eXTHxHss
	Igrfmiuu9Ug0/NAhVCQZjrsdukvzkShef87E7dLfMpwVhDhYYqNO8eWp6sNO2+aq
	6As3f7uZCK+YR9MVuOhsGXzxHMm0NkOMYfZAYK0lEUGMcclO2nIDFVZyldLNg3Mc
	XfDhGuJXJcaOyFdLqNPcI1Q2iY7Bzq3JqEtmLnd9ikVITKuV1ZsAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvfnp2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqHT739423;
	Fri, 18 Sep 2026 13:31:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q88u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDV9Hq40042860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A207120040;
	Fri, 18 Sep 2026 13:31:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 426EF20049;
	Fri, 18 Sep 2026 13:31:09 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:09 +0000 (GMT)
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
Subject: [PATCH v8 04/29] KVM/vfio: Use file-based reference counting for KVM
Date: Fri, 18 Sep 2026 15:30:41 +0200
Message-ID: <20260918133107.1042730-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfXzEzjvNjNDHOp
 T1BE1I+RCJv5Wr/r9Zvs23W64BI64dhlCN1+P39tzZ0gFj1WtIep3llmHLZc+KiA3qCktm7l9mk
 PnqsBpmLB4VLDjtEcDTEAEIPz+u+WBM=
X-Proofpoint-ORIG-GUID: OcRhjop6AO359DjUigtUwK_Zw5h2LoL0
X-Proofpoint-GUID: 6U6c6oZmo-28uCesnMvaCAOLAgclfmBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX8EaFOiKey/1d
 t4tH8VOfMR9F3qtnPuYx/oCrcEMl+6UrPlzziGq3QJm5LplCA2GP7pd++VoYc0dKFDyzndIOJen
 Gj+yoBQozhlEd9Td2hPVWn2sl4kius9SqcZZjz82CRG4WuyqoeGuWxZE5+EnJdDQlWMcddXZUGH
 e+xfKYw1osATtREdH1Hu9sywWWyo9vUFAYqgBmDT46R0W6f+qGnN2tbSbxM5U8KxwJsUFCPaEpb
 LlOWeI0ntnRfqA9lhWfrLZI7ZlFa88TzF6cF7z+HigfTpHbiVbYfLC8/ycOy43tLMtSlTW32A2c
 SXxIIFYkDboEGzLFZNJYkTXU1XTZmHmlNqn+NXT8+8/eQ1pYE4gkvUxqIfu3n2wEZJ/HZyWkbKS
 sOyvvzJBlGMh2YJtGfP1tng/d+0L2ouVx9C1AgkDQ24RskFfuU7FK48BEvk24mkk7N9pysCy5mY
 I0/gLll8YHxSIj371HQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad3d26 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=NcvOO2zV9weGGrCt3WIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180184

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface, leveraging the kernel's existing file reference
counting via get_file()/get_file_active() and fput(). Convert the x86
page-track API likewise, and update vfio_ap and vfio_pci_zdev to use
file_to_kvm_s390(). This simplifies the code and removes all remaining
externally exported symbols for KVM which would appear twice for when a
second concurrent KVM module is introduced.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/include/asm/kvm_page_track.h |  8 ++--
 arch/x86/kvm/mmu/page_track.c         | 22 +++++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 20 +++++++---
 drivers/vfio/group.c                  | 11 +++++-
 drivers/vfio/pci/vfio_pci_zdev.c      |  8 +++-
 drivers/vfio/vfio.h                   | 12 +++---
 drivers/vfio/vfio_main.c              | 57 +++++++++------------------
 include/linux/vfio.h                  |  5 +--
 virt/kvm/vfio.c                       | 13 ++++--
 9 files changed, 84 insertions(+), 72 deletions(-)

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
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb..f12558dfcd81 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -16,6 +16,8 @@
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
 
+#include <asm/kvm_page_track.h>
+
 #include "mmu.h"
 #include "mmu_internal.h"
 #include "page_track.h"
@@ -237,10 +239,11 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
  */
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm_x86(file);
 	int r;
 
 	if (!kvm || kvm->mm != current->mm)
@@ -252,7 +255,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 			return r;
 	}
 
-	kvm_get_kvm(kvm);
+	get_file(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -267,10 +270,11 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
  * stop receiving the event interception. It is the opposed operation of
  * kvm_page_track_register_notifier().
  */
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm_x86(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -279,7 +283,7 @@ void kvm_page_track_unregister_notifier(struct kvm *kvm,
 	write_unlock(&kvm->mmu_lock);
 	synchronize_srcu(&head->track_srcu);
 
-	kvm_put_kvm(kvm);
+	fput(file);
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
 
@@ -336,11 +340,12 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
  * add guest page to the tracking pool so that corresponding access on that
  * page will be intercepted.
  *
- * @kvm: the guest instance we are interested in.
+ * @file: the VM file of the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -366,11 +371,12 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * remove the guest page from the tracking pool which stops the interception
  * of corresponding access on that page.
  *
- * @kvm: the guest instance we are interested in.
+ * @file: the VM file of the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..556e643244f2 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 
 /**
  * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
- * to manage AP resources for the guest whose state is represented by @kvm
+ * to manage AP resources for the guest whose state is represented by
+ * @kvm_file
  *
  * @matrix_mdev: a mediated matrix device
- * @kvm: reference to KVM instance
+ * @kvm_file: the KVM VM file this vfio device is associated with
  *
- * Return: 0 if no other mediated matrix device has a reference to @kvm;
+ * Return: 0 if no other mediated matrix device has a reference to the VM;
  * otherwise, returns an -EPERM.
  */
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
-				struct kvm *kvm)
+				struct file *kvm_file)
 {
+	struct kvm *kvm;
+
+	if (!kvm_file)
+		return -ENOENT;
+
+	kvm = file_to_kvm_s390(kvm_file);
+	if (!kvm)
+		return -ENOENT;
+
 	if (kvm->arch.crypto.crycbd) {
 		get_update_locks_for_kvm(kvm);
 		if (kvm->arch.crypto.pqap_hook) {
@@ -1841,7 +1851,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		}
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
-		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 		release_update_locks_for_kvm(kvm);
@@ -1894,7 +1903,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
-		kvm_put_kvm(kvm);
 	}
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..5bf8cbdff377 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -860,11 +860,20 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
+	struct file *old;
+
+	if (kvm)
+		get_file(kvm);
+
 	spin_lock(&group->kvm_ref_lock);
+	old = group->kvm;
 	group->kvm = kvm;
 	spin_unlock(&group->kvm_ref_lock);
+
+	if (old)
+		fput(old);
 }
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index f47f36314a1c..332bc66db55b 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -184,6 +184,7 @@ int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	struct kvm *kvm;
 	int ret;
 
 	if (!zdev)
@@ -195,9 +196,14 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 		return 0;
 
 	ret = -ENOENT;
+	kvm = file_to_kvm_s390(vdev->vdev.kvm);
+	if (!kvm)
+		goto recovery;
+
 	if (zpci_kvm_hook.kvm_register)
-		ret = zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+		ret = zpci_kvm_hook.kvm_register(zdev, kvm);
 
+recovery:
 	if (ret)
 		zpci_stop_mediated_recovery(zdev);
 
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..9b619951a5d0 100644
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
@@ -165,7 +165,7 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
 }
 
@@ -429,11 +429,11 @@ static inline void vfio_virqfd_exit(void)
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
index 423ead48aafe..ed96acfa8635 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -472,36 +472,14 @@ void vfio_unregister_group_dev(struct vfio_device *device)
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
 
 	if (!kvm)
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
-
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
-	device->kvm = kvm;
+	device->kvm = get_file(kvm);
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -511,14 +489,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
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
@@ -1544,9 +1515,13 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
 {
 	struct vfio_device_file *df = file->private_data;
+	struct file *old;
+
+	if (kvm)
+		get_file(kvm);
 
 	/*
 	 * The kvm is first recorded in the vfio_device_file, and will
@@ -1554,28 +1529,32 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 * iommufd successfully in the vfio device cdev path.
 	 */
 	spin_lock(&df->kvm_ref_lock);
+	old = df->kvm;
 	df->kvm = kvm;
 	spin_unlock(&df->kvm_ref_lock);
+
+	if (old)
+		fput(old);
 }
 
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
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 45f08986359e..0cc91c6f96d2 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,7 +54,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
-	struct kvm *kvm;
+	struct file *kvm;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -66,7 +66,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
@@ -378,7 +377,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6cdc4e9a333a..19548a430942 100644
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
@@ -144,6 +144,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
+	struct file *kvm_file __free(fput) = NULL;
 	struct file *filp __free(fput) = NULL;
 
 	filp = fget(fd);
@@ -154,6 +155,10 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	if (!kvm_vfio_file_is_valid(filp))
 		return -EINVAL;
 
+	kvm_file = get_file_active(&dev->kvm->file);
+	if (!kvm_file)
+		return -ENOENT;
+
 	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
@@ -168,7 +173,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, kvm_file);
 	kvm_vfio_update_coherency(dev);
 
 	return 0;
-- 
2.53.0

