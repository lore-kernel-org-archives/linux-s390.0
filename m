Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE33CF02D;
	Mon,  6 Jul 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327995; cv=none; b=GLcUm8ckT/xKbmh+yFIfCKgSqmgMdR00FFld7jB4+n//cyIGDHCmVoaFa3HYxWozTn7nLus585JIlbHyBztPdjebGGodMn+o+W5ieYfZiq0i3uw0NmpvFZwFb1nMVedpLEQqVW0Z/a4ANMGruNO51m5F4HJQ3ih3/K6areE+6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327995; c=relaxed/simple;
	bh=llvN3IZFcUshVTAczuCJUjfOKA8YD9Z811nBogXAWp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0p/Cu0T/GsxBX0aMKTkUsOx5Bf32kSj7I0gZ2L/J9dAPqRyM2lQiXelej9Ji9Uar2WrdlgO5fiNuUrIe989T+EyO08zUEL6M9ykQT60cJN9e3vrja0kBkMhcFrI4Ne3xkMvwUpcNoIKVGkd790GN66AAfQTt0KlNB+krr24iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rcF93HKP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rcF93HKP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJ01l2305858;
	Mon, 6 Jul 2026 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gmIW2Lo8Ag1p9dPld
	1JaBPWJ+Hy0kuL3TR8h9zOY+PI=; b=rcF93HKP2CIoa5yt6qTSAURM91wjHB9Ow
	KdwxNj0wu0jnPCWT8jmH1+OFF2719Aw98WXyYl0EEDU+2UUnHtCyZGgGqd9LZZl8
	dFyzuqJ7/ZedM4EZqeP7NAtS6R7fy5IOQrgrxYlPb59990IMpggSTxBFIw7Ms/pw
	9AGY9DfskHYt2FnASUTmxB5DoRFalcVqhJ8kAbsblJn/FzopfR+cHSO3adBQV/5T
	nTNgDBwDhctp3kLIEjAnth43HFRC8rAzgDlVdURcjRZUagdcSPJk5v108VqqP4Me
	l86+L9fo7YfTLs6yR37tKoF47+sOvXaLLri/+8UrdbdQ1xD/+YSWg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nfcd013189;
	Mon, 6 Jul 2026 08:52:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjvtw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qUhu51315136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52AF020043;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E077F2004D;
	Mon,  6 Jul 2026 08:52:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:29 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v4 01/27] VFIO: take reference to the KVM module
Date: Mon,  6 Jul 2026 10:52:01 +0200
Message-ID: <20260706085229.979525-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6cd6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=d-V1UPfWWZlnQKifVG0A:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX9b+V/vQxM3ug
 yZq/dYqEcW54DFpO9LkAyQOjqHr9C5fPPLgpQsU8KgZ1tJNe4RN6kko310Iwn5Dk0NibMrfckZq
 +s96xpGeUM8zOvko4OGvThXozGsGJxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXxDxYJSNBcaMT
 H3AcgJisD7N2ZV1ETChlmZ5hRva8e7oViLYuTEZVKs5Ym5FX7DJucP3aM1nOFS7y4Rl6J3uRoCF
 vg91b73CcOpP1OHKppBsnOUXdh3plkQ6JbGebUskgnPVf1uSVCGKo6/z39ANNz+DIW/jmJFd/8N
 s191Xoda0ijk73e4AoyclR3aqRmSXW00PKbGSQnyLzsvA8J/tzDiMlDWoq8fSZCy2X4KSYLIkKc
 rMjbJp4QIBYwC7kmWgYcgN3ZXdBh+9JNNs3gQRIrQHNB7BIWMuCDxYDp8qgsKD/jc6zrz6aZmrf
 yotojyc+wG+NGmJRQbfjEATVAi3f9JxCkrtVChQoL4wTHHA0THrUXCy14E/iArO3ygb5Q242wyS
 wjsGBiW4F2y5sCUyXHk7+jlI4IEjiDlYC9F8lvqL4kEku3mXIhero2tMeLHSGgu70MRBwKIEbPQ
 JgV6RUtgBbr25j1Ouxw==
X-Proofpoint-ORIG-GUID: GKcqpM7IKKFfKLjVx_hpnSB4EZgBbzJa
X-Proofpoint-GUID: GKcqpM7IKKFfKLjVx_hpnSB4EZgBbzJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

From: Paolo Bonzini <pbonzini@redhat.com>

VFIO is implicitly taking a reference to the KVM module between
vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
symbol_get and symbol_put.

In preparation for removing symbol_get and symbol_put themselves
from VFIO, actually store a pointer to the KVM module and use
module_get()/module_put() to keep KVM alive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
---
 drivers/vfio/device_cdev.c |  2 +-
 drivers/vfio/group.c       |  5 +++--
 drivers/vfio/vfio.h        | 15 ++++++++++-----
 drivers/vfio/vfio_main.c   | 38 ++++++++++++++++++++++++--------------
 include/linux/vfio.h       |  3 ++-
 virt/kvm/vfio.c            |  4 ++--
 6 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..a729be99d06c 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-	vfio_device_get_kvm_safe(df->device, df->kvm);
+	vfio_device_get_kvm_safe(df->device, df->kvm, df->kvm_module);
 	spin_unlock(&df->kvm_ref_lock);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..fc24c0b2cc6f 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -163,7 +163,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm_safe(device, device->group->kvm, device->group->kvm_module);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
@@ -860,10 +860,11 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm, struct module *kvm_module)
 {
 	spin_lock(&group->kvm_ref_lock);
 	group->kvm = kvm;
+	group->kvm_module = kvm_module;
 	spin_unlock(&group->kvm_ref_lock);
 }
 
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..8209da17246c 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -22,8 +22,9 @@ struct vfio_device_file {
 
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
+	spinlock_t kvm_ref_lock; /* protect kvm and kvm_module fields */
 	struct kvm *kvm;
+	struct module *kvm_module;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -89,6 +90,7 @@ struct vfio_group {
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
 	struct kvm			*kvm;
+	struct module			*kvm_module;
 	struct file			*opened_file;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
@@ -107,7 +109,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm, struct module *kvm_module);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -170,7 +172,8 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm,
+				      struct module *kvm_module)
 {
 }
 
@@ -434,11 +437,13 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
+			      struct module *kvm_module);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct kvm *kvm,
+					    struct module *kvm_module)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index ed538aebb0b8..8289aca97b6b 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -448,7 +448,8 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
+			      struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
 	bool (*fn)(struct kvm *kvm);
@@ -459,25 +460,31 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 	if (!kvm)
 		return;
 
+	if (!try_module_get(kvm_module))
+		return;
+
 	pfn = symbol_get(kvm_put_kvm);
 	if (WARN_ON(!pfn))
-		return;
+		goto out_put_mod;
 
 	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	if (WARN_ON(!fn))
+		goto out_put_sym;
 
 	ret = fn(kvm);
 	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	if (!ret)
+		goto out_put_sym;
 
 	device->put_kvm = pfn;
 	device->kvm = kvm;
+	device->kvm_module = kvm_module;
+	return;
+
+out_put_sym:
+	symbol_put(kvm_put_kvm);
+out_put_mod:
+	module_put(kvm_module);
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -496,6 +503,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
 
 clear:
 	device->kvm = NULL;
+	module_put(device->kvm_module);
+	device->kvm_module = NULL;
 }
 #endif
 
@@ -1520,7 +1529,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1531,6 +1540,7 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 */
 	spin_lock(&df->kvm_ref_lock);
 	df->kvm = kvm;
+	df->kvm_module = kvm_module;
 	spin_unlock(&df->kvm_ref_lock);
 }
 
@@ -1542,16 +1552,16 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
  * When a VFIO device is first opened the KVM will be available in
  * device->kvm if one was associated with the file.
  */
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_group *group;
 
 	group = vfio_group_from_file(file);
 	if (group)
-		vfio_group_set_kvm(group, kvm);
+		vfio_group_set_kvm(group, kvm, kvm_module);
 
 	if (vfio_device_from_file(file))
-		vfio_device_file_set_kvm(file, kvm);
+		vfio_device_file_set_kvm(file, kvm, kvm_module);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..5bfec0339804 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -55,6 +55,7 @@ struct vfio_device {
 	unsigned int migration_flags;
 	u8 precopy_info_v2;
 	struct kvm *kvm;
+	struct module *kvm_module;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -377,7 +378,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6cdc4e9a333a..c593f31136f9 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -37,13 +37,13 @@ struct kvm_vfio {
 
 static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
 		return;
 
-	fn(file, kvm);
+	fn(file, kvm, kvm ? THIS_MODULE : NULL);
 
 	symbol_put(vfio_file_set_kvm);
 }
-- 
2.53.0

