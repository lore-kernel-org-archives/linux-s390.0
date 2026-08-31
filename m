Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF087375F80;
	Mon, 31 Aug 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187716; cv=none; b=pEcxK0Gu2kTPRj/yhOUCZA1fLq79gpLZCV92DuknfgmFM3UsD1r0kiMJzFgV1X4u3cJH40oBSbwQ/QR/xX9q18jkhdzY2wAfw6Xf2Uu5H8K0Ghzs75v67i2ZJURDr7ZhQeHaTLSE42gwBHnd3ra8nAxFLy57yhZZegKvGAHQVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187716; c=relaxed/simple;
	bh=26gziGi2HwmdVjE4u72mW6p0XNm/qrTyjMenzyhGxDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8H+x31GWCfHB6TDcmh5d/489wGAXHKhwYmWQDoQGX4q8rM8IzUbpPNgjB0iOucKZYqUbVBau/0ZEJORehufzLgkrSoyKXb6hUcjDcSGDSMdjqhcWrboR6rO6Puh3XRyOm44j3+aBAqh0xSfqsEYPCLrvAqk8YSKl05gl8kqME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qeqsiQm2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qeqsiQm2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZBOF1398288;
	Mon, 31 Aug 2026 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7kaI+/
	UPeDpXa5Qci0g2WEyi5wxbt+xukphIht2Cyqk=; b=qeqsiQm2MnrroSczHORote
	/gs0e9Kyc29tvSatf3pJeD5p+VhwUf+sM32z8+BEnQAPtMVpcEA6hVM7uML00eCo
	i8oTMXB52LY9GmC+yOpgPeCds4gQPKHoOVQ01bsG7nq5iJLkrXhAbSW65osLkV5H
	8Ujw38wxIkjEyeqtT5f7tpiQOajNLPaWxPyOX19Xj7GBim7HPoqemsIsxGoIwsN5
	ClwWa5GPwTwc7k44UfhWgqPlMGxllsqxsk/uxk7ZpoFtYuLarKjrVaX8OlopSt7p
	P9K3OWpMm959dP5tQDVCFo3qBjau1UNt3Sh+/h22yez2FIlbjHA/luyw8+oF/0bg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudhyrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfbQD015523;
	Mon, 31 Aug 2026 14:48:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6m63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm3Is43188718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A7020043;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FE082004F;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:03 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 01/23] vfio: Use file-based reference counting for KVM
Date: Mon, 31 Aug 2026 16:47:38 +0200
Message-ID: <20260831144802.834315-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: grjCtHBEg3MoNxpQpoi92VvbIRSBtAbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXziSPzJVeJWat
 Zudf8a1OU4z9vSKbQH2cyvFiHIKqqWifNLuePh+ZVKk0YdUZgcq2743i7mxj4H14uIIqSPfAFRH
 DhdFO+N4LjpcDCzATxLLKuaixRGpPikWgabROpfnidn0iz7FhirsHbALLC8U6cCvL3v09Hh2R6z
 6ppskZPd6KaCVXlM5PcZH8dDKwsqbzIr+vzT4fnicEa9kUuOvmVZ+0+earoMVZ18R8c7l1pr7kV
 d+qQrCf4aPOxaV8knURHRPjt4/9f6CXfoMbytNTG4IWHHVD4rFCcSyeSb/yiEhrik0eh/lk4/Mu
 AwmRpf3RaVhMwg8shU4IQx8+rwYoPSeqduXnPdBIQ0ODjffoJgLVrJRCtVYsBQSXeGeAtd5o2YW
 Ethp8GjCtsQROuib+8AS7G5OO+faqy+BUOnd+XH11P0vakb/xQcXhYAkqxKQVyItp7RJxgr1aYF
 BaPNwNlqPa025ZTHCdQ==
X-Proofpoint-ORIG-GUID: Eeush9WWXkx4w75GgqXJx8Uzs6k8IDcQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX/IVBGuAyAvXE
 yZ/2SZUYCbKc1ZPZE8zf1UWIXioD2oPdQPtSYUt8vQOTlvELprsBh2sAUmIMCnQqh7JUuvAIGx1
 a9MQNH0p09cwx4C3M08n2RhIngxZ83k=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a959428 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=cFm4mksYcdg9GKIP9xkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references. Remove the put_kvm field in
struct vfio_device as is it no longer used.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface. This leverages the kernel's existing file reference
counting mechanism via get_file()/get_file_active() and fput(),
eliminating the need for manual module reference tracking. The
file->private_data field provides access to the underlying struct kvm
when needed.

group->kvm and df->kvm hold a reference of their own, taken when the
pointer is stored and dropped when it is overwritten or cleared. They
have to: the kvm-vfio device fd holds a VM reference of its own, so the
VM file can be closed and released while the kvm-vfio device is still
alive and still pointing at it. filp_cachep is SLAB_TYPESAFE_BY_RCU, so
a stale pointer left in those slots could be made to reference a
recycled, unrelated file.

kvm->file itself carries no reference, so that it does not pin the VM.
It is only ever read with get_file_active(), which is safe because
kvm_vm_release() clears it, i.e. before the struct file is freed.

This simplifies the code and removes all remaining externally exported
symbols for KVM, paving the path for a second concurrent KVM module.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/include/asm/kvm_page_track.h |  8 ++--
 arch/x86/kvm/Makefile                 |  5 +--
 arch/x86/kvm/mmu/page_track.c         | 20 ++++++----
 drivers/s390/crypto/vfio_ap_ops.c     | 20 +++++++---
 drivers/vfio/group.c                  | 11 +++++-
 drivers/vfio/pci/vfio_pci_zdev.c      |  8 +++-
 drivers/vfio/vfio.h                   | 10 ++---
 drivers/vfio/vfio_main.c              | 57 +++++++++------------------
 include/linux/kvm_host.h              |  8 ++++
 include/linux/vfio.h                  |  5 +--
 virt/kvm/kvm_main.c                   | 20 ++++++++--
 virt/kvm/vfio.c                       | 13 ++++--
 12 files changed, 107 insertions(+), 78 deletions(-)

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
index 0474604ab8a1..96f89d6f7e6a 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -60,10 +60,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 			grep -v -e kvm_page_track_register_notifier \
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
-				-e kvm_write_track_remove_gfn \
-				-e kvm_get_kvm \
-				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_write_track_remove_gfn
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb..98f133e4f0b3 100644
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
 
@@ -336,11 +338,12 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
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
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -366,11 +369,12 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
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
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..f160e1945fbc 100644
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
+	kvm = kvm_file->private_data;
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
index f47f36314a1c..3dc302062a67 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -184,6 +184,7 @@ int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
 int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
+	struct kvm *kvm;
 	int ret;
 
 	if (!zdev)
@@ -195,8 +196,13 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 		return 0;
 
 	ret = -ENOENT;
+
+	kvm = vdev->vdev.kvm->private_data;
+	if (!kvm)
+		return ret;
+
 	if (zpci_kvm_hook.kvm_register)
-		ret = zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+		ret = zpci_kvm_hook.kvm_register(zdev, kvm);
 
 	if (ret)
 		zpci_stop_mediated_recovery(zdev);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..f76504d707e1 100644
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
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..bfecce1b5955 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -784,6 +784,13 @@ struct kvm {
 	 * kvm_swap_active_memslots().
 	 */
 	struct mutex slots_arch_lock;
+	/*
+	 * Back-reference to the VM file for subsystems (e.g., VFIO). Holds no
+	 * reference to avoid pinning the VM. Access via get_file_active(&kvm->file)
+	 * only—safe because cleared in kvm_vm_release() before file freed. Callers
+	 * storing the result must take their own reference via get_file()
+	 */
+	struct file *file;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	unsigned long nr_memslot_pages;
 	/* The two memslot sets - active and inactive (per address space) */
@@ -1082,6 +1089,7 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct kvm *file_to_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
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
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..34b4c43908b3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1314,7 +1314,7 @@ void kvm_get_kvm(struct kvm *kvm)
 {
 	refcount_inc(&kvm->users_count);
 }
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_kvm);
 
 /*
  * Make sure the vm is not during destruction, which is a safe version of
@@ -1324,14 +1324,14 @@ bool kvm_get_kvm_safe(struct kvm *kvm)
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
@@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 
 	kvm_irqfd_release(kvm);
 
+	WRITE_ONCE(kvm->file, NULL);
+
 	kvm_put_kvm(kvm);
 	return 0;
 }
@@ -5496,6 +5498,15 @@ bool file_is_kvm(struct file *file)
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
@@ -5527,6 +5538,9 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	 * cases it will be called by the final fput(file) and will take
 	 * care of doing kvm_put_kvm(kvm).
 	 */
+
+	kvm->file = file;
+
 	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
 
 	fd_install(fd, file);
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

