Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0539448B87;
	Thu,  3 Sep 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423412; cv=none; b=WO5FVv50lz5Exala+ONBNZAv2ob7A2QpuHQYAGLbplHcagBcp4vd15WS84UfidsxLP3nvABdgD4eeraOkmrtCt6Maxb6/V17EKvlMk032FcAOw655GxZcGG/2Km2byrz/S0SJ0mA7KcwZCzHKVJt9cLVXpsrie3YH9VxN8UyP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423412; c=relaxed/simple;
	bh=1zk3zQFWO0H9B5qKps31ogM6hJSFks217CrSJhxVOgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EPPKM93GV3kXJUaUnXHJQRpxyYPY3KXpjhfTSh0xpZXZ9so8IFrDH6d90cnXHR2iCtWlsXY6W0gDc4HYbIGwNsHpUTBFUH/sWbNr1pFWDQ5PEeUu8n3r2eO3bveXUFpt/C/rQzk1uT+Kc91S5D6GWjcwisVuiaonGt5wYfgqMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TS7Mq7bX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TS7Mq7bX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361VVM2187937;
	Thu, 3 Sep 2026 08:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hX40Ka7rkJvBEDSAHx6hxgpuBa8q
	BfCPoMz9bd9z0ew=; b=TS7Mq7bX5GXccRdu4DVKUjGszJPCmqJQKmVVxM+oyrh/
	OiZEnytX33CqX2xK9Z6oYg67h2y0P04cFRsb3aHhFHZ+CIRR2adR2JTKS0rVUj05
	RzfdJAk0WY1W31WqtF5FMF8XkXQSm1LpFnIe1OAaub2IS3R9sxIX89fE1b6fBpOy
	ADDBhy3N9rPESIeXorpOJkdABTJ+T43AMF3nQh3eKt1IjUivEycQV36iZ65PW005
	jx2n+kA75YaWuBb2LdOKip+lopF9CK5/VZoH7ocMUDzXbhP/Pbf5KDKKeAEblylU
	EwcLzuSywEDjMTXbeF2Mt7ttTfSMbW0DitNr75ZWSA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5ushu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:16:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6837uHLf003056;
	Thu, 3 Sep 2026 08:16:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkeqxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:16:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6838GRZB12058966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 08:16:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25CA42004F;
	Thu,  3 Sep 2026 08:16:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6EAD20040;
	Thu,  3 Sep 2026 08:16:26 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 08:16:26 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 03 Sep 2026 10:16:08 +0200
Subject: [PATCH v2] vfio: Use file-based reference counting for KVM
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ7CIBCF4as0s5YGSKmtK+9hugA62EksGFBS0
 3B3sUuX/8vLt0PCSJjg0uwQMVOi4GvIUwN20f6OjObaILns+SAky44CcyPvx3nQRnUK6vUZ0dF
 2MLep9kLpFeLnULP4rX9AFkwwZR1yI5zu8Hx9kH9vLZm1tWGFqZTyBcUD68acAAAA
X-Change-ID: 20260812-vfio-f9069d8ab545
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a992ce1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=8N7KX3Qg9dOTSCVtP4QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: scI-ub8GnB-iOcPvkur9bkamfM5Z99mK
X-Proofpoint-ORIG-GUID: 1kJMsWMgbfaXQzuPVO_6_y83tOTjCVAS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfXyFYD8tt9I73Y
 F4MqtnNnw3ng3Q+InlCQI4ndGUGszt5irV3mip2YeH0Ev1mD/m6BWOawA98zgSn73B8iS9nw+wc
 Bdv5tZwJADCsRHnolmyqGrhpyFQES9M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfXx3j078kpCWhO
 1Z6yJPn8NawKD67p9fWF6XA2+CBeYI4HkBZX+/SecUrZPc+pSSH+uerZEDV8uYxBqrQrFoVFV6A
 PqbNDTQ+GzjI4q1zdowiPb55hPmEBmP+YHH8wJch4xOiflxnYLJBygGJalH/5LXlkcKCp8Dv6kr
 xDI4kiqqmW10Vb4BnBG+R2swe5z23I2HlnuiB4Wve1hqaFU9Xu/ivmLGKT9hM5l/Ro7hmIacXmw
 ALXesezsKbmvrgLMdHIwWJJvM77zPG6Dw2I8YZ2RGyk9tmNY1MuwAK7Pjf86TUA5PazewfujJNw
 eaYiStiTkrW8exN62JYhvE9e1F6TcM3t54hXoeAuFwDR6TZDXBAlGpHWXimMUXm5Ov7Abr+HxlR
 zCZyeFL7uOmYZTxScfJ721QjB33BryYkf7mbdpSK5e39DldUcl5v/b5A+NvHfPEYc/fwqi/YJ5i
 GFxmHPWdEP5+JJf9ZSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030071

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
have to. The kvm-vfio device fd holds a VM reference of its own, so the
VM file can be closed and released while the kvm-vfio device is still
alive and still pointing at it.

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
This is a spin-off for the arm-on-s390 series [1] to address all the
relevant persons w/o polluting their mailbox.

The motivation of this patch is to remove all exported symbols from KVM
to other modules. This patch helps us having multiple KVMs running in
parallel. The arm on s390 series creates a second kvm module (kvm-arm64)
for hosting arm guests on s390 with HW acceleration. For this we need
two concurrent KVM modules. One for s390 (native) and one for arm64
guests.

Steffen

[1] https://lore.kernel.org/all/20260831144802.834315-1-seiden@linux.ibm.com/

Changes in v2:
- Rebase on 7.3-rc1+ and resolve conflict with 9f240376d034 ("s390/pci: Store
  PCI error information for passthrough devices"),
- Fix stub prototype for vfio_group_set_kvm for !CONFIG_VFIO_GROUP
- Link to v1:   https://lore.kernel.org/r/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com
---
 arch/x86/include/asm/kvm_page_track.h |  8 ++---
 arch/x86/kvm/Makefile                 |  5 +--
 arch/x86/kvm/mmu/page_track.c         | 20 +++++++-----
 drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
 drivers/vfio/group.c                  | 11 ++++++-
 drivers/vfio/pci/vfio_pci_zdev.c      |  8 ++++-
 drivers/vfio/vfio.h                   | 12 ++++----
 drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
 include/linux/kvm_host.h              |  8 +++++
 include/linux/vfio.h                  |  5 ++-
 virt/kvm/kvm_main.c                   | 20 ++++++++++--
 virt/kvm/vfio.c                       | 13 +++++---
 12 files changed, 108 insertions(+), 79 deletions(-)

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
index f47f36314a1c..045132e90bfe 100644
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
+	kvm = vdev->vdev.kvm->private_data;
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

---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260812-vfio-f9069d8ab545

Best regards,
-- 
Steffen Eiden <seiden@linux.ibm.com>

