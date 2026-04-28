Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79E44D014;
	Tue, 28 Apr 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392146; cv=none; b=AMZtRyXucBDYiiGer3kjpaTUOTu/Ve+2dl4fue+FQoNtV72Ys9+/zrJ0XJciRpTWCIRyDtRsmewp/gkw0CDvwFroYFHWCwD2XoBkUTbH7Pa6RF6xwlyU0rSKH4SZkfvkgq7CSSThLOQaH6aShpiY50YKcl87Wo71Nq2TqZfK7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392146; c=relaxed/simple;
	bh=xpBoS0vYziibIdR/Dkfw3B3CLYx670ekSHESM1p0b04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee0A98pnA9KliSB99lfrIh8b+LGnAFwe+qWrOPNpkunn9NfF9/Nziy2o5pNMO7kQr+t633Pu3cwLx3LizQaINEYves3TwBS01s6TnYQVDwpPLVQpwI8SAawjm2VP+MSoQ/Q6WY0mcQUNx2mAYEpWLjDPrP2kn27uWaPew1f9SGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h3anNAfw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h3anNAfw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6XPo22497857;
	Tue, 28 Apr 2026 15:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B2j94V/uzP3SFd9G3
	ERlrsoyUwM0lq9xReO4GEkxtkc=; b=h3anNAfwqlfBWLXBcaGzLnijMxj4+DOlL
	yY0YnQcHp3wr1Bdl5v/7nsUiMXd934uOJk/DDxDejvOIGqKMaFhFe2PMdQj9kVkJ
	bnUICpo901IcZZPk5/FgssHlFTBBE7TNFf9gnnWnv60+/ETGRW7SVS/AQA0nPkEs
	5Y39AL2FS3NJWOnbAfIKsDs54CBk1psvghpawVe7zyf0yDcErfu7mwIaXYZup9KB
	7x7Sp/GLhSkcw6abTRyVvLk6tUumtjj468bb5N0PvgD+N+2k7HqYCqgm5Ar4KlCV
	qJpCHpgCDdHMxKYcgoRNyqIi50MWOYXcQKs3rvy0zfSflVTDfqG/A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb56c80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrplo027791;
	Tue, 28 Apr 2026 15:56:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya54x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuNbM62914850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89E502004B;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34C8D2005A;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 01/28] VFIO: take reference to the KVM module
Date: Tue, 28 Apr 2026 17:55:53 +0200
Message-ID: <20260428155622.1361364-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0d8ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=U3YOjIjXimIOwXAI40wA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX9ADGUyZkpOhM
 WSw/5yH5r95hTz2kwgCVJ7SCeYasRH+LOrW4N9awR9RpPFdAaUWH1vx54nqDUiYMZ++XPi4Zo/z
 XPiFzyw7JeNMR5rGB8vNzxW9pqfD+jRVf9+ma8Sm0oLZvs0AhTinJoYtOfnEm8lxAES9V6MPY75
 DXcW/9WQEnSPBHx/DgZdGamf3tMU0rVEHSXYR2Iv88JWSnc4KhDhxjBKG8bF9m0A4lv8NdXGTvM
 /rV2omoMV54dUPCxoBwg8qfrsSR9AKpLFQfR4rMNBeUFoSyug/HmhR9Zk9Il68p4VUR1RUNL0fW
 JxGfEFfeqQm1pzur9lLpPikUPChfjPAtQ+4X1KVmpx+CcXcL9dqv7T3DJmhSf2hPuosck57Km/k
 NSi4pK/PgyYw6jD/gwv+vhuRXw14LVUS0kNrFH8k+a6o3kSDCal6/sBn0HJi+MselKWniUs7ZeV
 wbEowdZzOj1uwKXVeOg==
X-Proofpoint-GUID: qXDkqdgae-nHDTKICu1p3-WpTKhNp8Zi
X-Proofpoint-ORIG-GUID: qXDkqdgae-nHDTKICu1p3-WpTKhNp8Zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

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
 drivers/vfio/vfio_main.c   | 37 +++++++++++++++++++++++--------------
 include/linux/vfio.h       |  3 ++-
 virt/kvm/vfio.c            |  4 ++--
 6 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..a67d7215c239 100644
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
index 4f15016d2a5f..7d28f45fefaa 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -158,7 +158,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm_safe(device, device->group->kvm, device->group->kvm_module);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
@@ -858,10 +858,11 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
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
index 50128da18bca..a0c38f89b30a 100644
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
 	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
@@ -108,7 +110,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm, struct module *kvm_module);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -171,7 +173,8 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm,
+				      struct module *kvm_module)
 {
 }
 
@@ -435,11 +438,13 @@ static inline void vfio_virqfd_exit(void)
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
index 742477546b15..d1bbc42d484a 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -433,7 +433,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
 	bool (*fn)(struct kvm *kvm);
@@ -444,25 +444,31 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
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
@@ -481,6 +487,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
 
 clear:
 	device->kvm = NULL;
+	module_put(device->kvm_module);
+	device->kvm_module = NULL;
 }
 #endif
 
@@ -1483,7 +1491,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1494,6 +1502,7 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 */
 	spin_lock(&df->kvm_ref_lock);
 	df->kvm = kvm;
+	df->kvm_module = kvm_module;
 	spin_unlock(&df->kvm_ref_lock);
 }
 
@@ -1505,16 +1514,16 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
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
index e90859956514..69a8d527b0e8 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -53,6 +53,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	struct kvm *kvm;
+	struct module *kvm_module;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -339,7 +340,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..515ed445d8e1 100644
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
2.51.0

