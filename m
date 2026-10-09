Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FE4E50CA;
	Fri,  9 Oct 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556112; cv=none; b=gTI9Epm4/OP9ggxHS7wevJlGpRS/A7T6ZtA/lL1SPoMHlB5ATKfGIlxqr3B24YiSII1VtfL5zLXgSkKpYrKCh5UHykApkUhuTBX6e6XcozDa1yZYdhAjp9NxE70DshlhQkImHhR4Kp8HksBe6SgcqxDzapaXxd4BaDqjghbyIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556112; c=relaxed/simple;
	bh=sk+Y5PpYICqykskfApPKMrwwbFo04A8UzPCHYw9xZ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjWfEWyfo7UQb2lD6y699zkEMUj26ioTSuuohTu2nSCG3J2dDRzk3ZAbkdNYg8eJ/u0HVxzaG8TzTRjSFVKKpe3dNJpYBEqewZ7UiB4lLqwtwx8nO7Do8mdqu8pEuEldQXUCNJhvM4QNHKkMW5X9aPgXtm+fYD9+zvUH3VGu6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eXBl7mko; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eXBl7mko"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZx4R198626;
	Fri, 9 Oct 2026 14:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VR12/JG8QT9VI1tS9
	0PA03cC5gTTCMZ6OAWjchAPhQE=; b=eXBl7mkoLSw/U71dn8pqjwF1kfFq99cG7
	q2UQcxRBLYm6GQixg7joJJMRv3cm7E8QpwjDsYHiXFVAHoyldtCO8xZRKnIfPCVj
	ZylNq/ntDZ0HRGyvYt0emNzTwmoQF1S4ZpHqYvPoHugcNp1iDX1HBNWItetlQ9Zw
	eGZBEth27OkLK/c3e++R7OMa7B0uMGkIPaYEdx2B4J9Owr5fMcwK8UeOeN+sA/xk
	kdizxP0YtkE0CuEnkZ3wuc+slcrek5yhXmq7tSahTdW65L81htB1T6RnLP32Kp38
	HHBZSBIqmd70P3fjXrBFXNdkogsA0qDCIFFrSIr8biycrLTwigZmA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvk7wv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWYMX905934;
	Fri, 9 Oct 2026 14:28:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd1fea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ESDRE27525750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:28:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C8D58057;
	Fri,  9 Oct 2026 14:28:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3375C58061;
	Fri,  9 Oct 2026 14:28:09 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:28:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 4/6] KVM/vfio: Use file-based reference counting for KVM
Date: Fri,  9 Oct 2026 16:27:47 +0200
Message-ID: <20261009142749.186650-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UhmcPkQfXsB5JRNoYNJJ87qHS911giv2
X-Proofpoint-ORIG-GUID: L7_wSFaxM5kzR-asDMOGD1GgIQmJZOrr
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8fa00 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8
 a=r1p2_3pzAAAA:8 a=TsCUmDc0jMQTdhPbWzQA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfXxWO82uJjrMoU
 DzzbiFQjBtwpd/Brp5B3JF8s+0Xn8pxT6bgLmK+D9ORausfu61x3MgpJ1lr1innnTH1krw+Vsbi
 RlwIQDfDY8UXfJaRg2Pd4ToHpZh09N6CmYY5fv2cUjxh2otWDw9Prdkt4SCwyiBQ46NFfi6vtc+
 N0mjv5pU3guVeN+gxQ9Pua4s6x3/JMzdICc330RXAIs1eSN22pqIgpV5Z02E50SUz6kpCIw09wh
 XkFbX3RwJbyrGS8MwOrVqGjosUedwJBFWTXSH6Ar6NvSK/0XERd07u97OFpVM6VeZM4Qa1ms/7O
 o7gcDYLgkNIivoXcXbsGFz9lPFEtj5Yt9gqszGALfFw+A4UCfLhKgy9F8arL2iV8FfcX2j5BTlY
 quIvWmLA8TFE97fMXThxBsQ5lPo6eo/hVTzLorOgJzt2zNXcM5YrSeSsKANSeFj2ieCl3ARnWvj
 XMHR8hIVOZtdUREKrYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX6JdpUjnd+KUH
 wABPu1bWuVSdG8D55GE5Kxnub064Z99HBrLk2iS5kXnDyeE6P0aq95dyijpmS/i4VVvLCcpW49V
 YjYsguqirbtYKHecAt3qbuDpNNDprL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface, leveraging the kernel's existing file reference
counting via get_file()/get_file_active() and fput(). Convert the x86
page-track API and update s390 vfio to use file_to_kvm_<arch>(). This
simplifies the code.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
[borntraeger@linux.ibm.com remove _safe from vfio_device_get_kvm_safe]
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 +-
 arch/s390/kvm/s390/pci.c              |  9 ++++-
 arch/x86/include/asm/kvm_page_track.h | 10 +++--
 arch/x86/kvm/mmu/page_track.c         | 22 +++++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 20 +++++++---
 drivers/vfio/device_cdev.c            |  2 +-
 drivers/vfio/group.c                  | 13 +++++-
 drivers/vfio/vfio.h                   | 14 +++----
 drivers/vfio/vfio_main.c              | 57 +++++++++------------------
 include/linux/vfio.h                  |  5 +--
 virt/kvm/vfio.c                       | 13 ++++--
 11 files changed, 90 insertions(+), 77 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 8a7eed5847e1..9519b8028b10 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -722,7 +722,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 void kvm_arch_free_vm(struct kvm *kvm);
 
 struct zpci_kvm_hook {
-	int (*kvm_register)(void *opaque, struct kvm *kvm);
+	int (*kvm_register)(void *opaque, struct file *kvm_file);
 	void (*kvm_unregister)(void *opaque);
 };
 
diff --git a/arch/s390/kvm/s390/pci.c b/arch/s390/kvm/s390/pci.c
index 82892e1e03d9..d79bd3bdc68e 100644
--- a/arch/s390/kvm/s390/pci.c
+++ b/arch/s390/kvm/s390/pci.c
@@ -498,17 +498,22 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
  * available, enable them and let userspace indicate whether or not they will
  * be used (specify SHM bit to disable).
  */
-static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
+static int kvm_s390_pci_register_kvm(void *opaque, struct file *kvm_file)
 {
 	struct zpci_dev *zdev = opaque;
+	struct kvm *kvm;
 	int rc;
 
 	if (!zdev)
 		return -EINVAL;
 
+	kvm = file_to_kvm_s390(kvm_file);
+	if (!kvm)
+		return -ENOENT;
+
 	mutex_lock(&zdev->kzdev_lock);
 
-	if (zdev->kzdev || zdev->gisa != 0 || !kvm) {
+	if (zdev->kzdev || zdev->gisa != 0) {
 		mutex_unlock(&zdev->kzdev_lock);
 		return -EINVAL;
 	}
diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 3d040741044b..ea885dd5c9af 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -44,13 +44,15 @@ struct kvm_page_track_notifier_node {
 				    struct kvm_page_track_notifier_node *node);
 };
 
-int kvm_page_track_register_notifier(struct kvm *kvm,
+struct file;
+
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
 
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1d9515c967b0..c1c26d7a9aec 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -65,7 +65,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-	vfio_device_get_kvm_safe(df->device, df->kvm);
+	vfio_device_get_kvm(df->device, df->kvm);
 	spin_unlock(&df->kvm_ref_lock);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..185f359f75d3 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -163,7 +163,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm(device, device->group->kvm);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
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
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..2eeb526a8da5 100644
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
+void vfio_device_get_kvm(struct vfio_device *device, struct file *kvm);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
-static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+static inline void vfio_device_get_kvm(struct vfio_device *device,
+				       struct file *kvm)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..ea8e6cc13c45 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -472,36 +472,14 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm(struct vfio_device *device, struct file *kvm)
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

