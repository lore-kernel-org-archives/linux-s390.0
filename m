Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418237CD3F;
	Thu,  2 Apr 2026 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103755; cv=none; b=WgSfXaw/q8xpe88hVdfaupoDloOUGDcJcO2TQtmYYr9iMq82zRKlriZ3VagVQ9XMsA/DwrgsgjW6XsVvNuWDAnw9YNdymBo5AE9clezIterwqZyVxeE++BrIZuIXeV13QyC3+X0L3tvcZ3CPqQa9C6mgzIUVEbYnxwoKeb1rBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103755; c=relaxed/simple;
	bh=8fslYNiBDeDvYKlIH6be1b0FJpshghLCvU949uGewkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKifl++A0cmInE5lL3oDZSOrQv0j6IUEnjmSWdRjIEtmuwrR01jmtjUCzjU2yOoC/UuJAy3GQ4YpSazmVqDQ5vv3K6SWF4Kv19Q+gB9SVuxc3VfVKVwvH5nXJILvuvCiNmlWwjrvSQz5ch9oQBnT+mS1J2VHQvgzOCqw4DWPyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SWKWmRLS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SWKWmRLS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M0Ixs4177299;
	Thu, 2 Apr 2026 04:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FZHSwXFrNyFLpPkI4
	pGHXT7cu/PhP9/U1uyFtKunKrQ=; b=SWKWmRLSIuGlcRwMsUKqSTdd0FmHbcvwm
	r1QKriW4PfWqd+fCU6hr2oG08yIclH+C9LEXbymiIps4uE8PnNi/5zPDxWLakgFN
	9TX0Dlctz0jz3PBtOKLA8WOkwoHmv+SK0eDDGimVDfxicZCaxKXw4TVQ3wKE0Adr
	g1hssK17/P3KFtR8JalP7+zThU7H+2b8cMaylh1wmKTPk1Ckz0imXj7MksWm2EzQ
	p4OSp7YtwjNu3GksuvL9LlHeulNgIa+ov0s60VyBEOQsUHNCNWeiYorercx6i1EY
	v1Y2phUAVnbhfrRrRCw53RTvhFfvGoDhewFAVLCm6KRZV/ofA3PzA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msabrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631NEI0S021631;
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasrsar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LQ2555247174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808052004B;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CF632004D;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 01/27] VFIO: take reference to the KVM module
Date: Thu,  2 Apr 2026 06:20:57 +0200
Message-ID: <20260402042125.3948963-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cdeecb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=Ag_mHdKxWRgQTeLQ5iYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX6EuHG/+LXOWh
 yAdLKZ+TFj9mLwPL+D45EAFEks0cDelFygzdT8bFmMECsZEyNKm5Jy68K3E89Z3fPj4vhGJfcg6
 4BrM3gIAbSUHPQ+Tox3kWT2v3FBJ2Riqxq4svb2bFo/IA7ZDceb5vwI+m+aH2B6BH/ixL2Tj8fK
 tAjr1AkIt3NTRG3MRHUconsgeBpHtEnEP3PEXb9NFSOQ1TofMWi0X1TycWTOG+6ZYguyxM7Shpq
 sGNloW+xXpGDUh8F0xbFZedSTz2l3IKmp1hjmAB9kPkNuAdrfIiR7ovRMV+3dujPRsf1wLXEMLV
 hxEuoLfWGvOYsJ8Pmz+deALBfW3arWku/nzsqeXrQbsoob8ygOA2UqQw2Io8I4n22GmGUFrjLk3
 7JpykkEeIJzLd4unKYFJjdzEK1s8QOz27PFNinrGkpMtZ1x7Z/i6ijCYeQ3zCDiUlQLnX6p6GTa
 E47rLam1SIIaUFnEJOA==
X-Proofpoint-GUID: YFRfrINo973Tw-EIVJfE4hUa9_z8UZRQ
X-Proofpoint-ORIG-GUID: YFRfrINo973Tw-EIVJfE4hUa9_z8UZRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

From: Paolo Bonzini <pbonzini@redhat.com>

VFIO is implicitly taking a reference to the KVM module between
vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
symbol_get and symbol_put.

In preparation for removing symbol_get and symbol_put themselves
from VFIO, actually store a pointer to the KVM module and use
module_get()/module_put() to keep KVM alive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/vfio/device_cdev.c |  2 +-
 drivers/vfio/group.c       |  5 +++--
 drivers/vfio/vfio.h        | 15 ++++++++++-----
 drivers/vfio/vfio_main.c   | 18 +++++++++++++-----
 include/linux/vfio.h       |  3 ++-
 virt/kvm/vfio.c            | 14 ++++++++------
 6 files changed, 37 insertions(+), 20 deletions(-)

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
index 742477546b15..b1b753889a77 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -433,7 +433,8 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
+			      struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
 	bool (*fn)(struct kvm *kvm);
@@ -444,6 +445,9 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 	if (!kvm)
 		return;
 
+	if (!try_module_get(kvm_module))
+		return;
+
 	pfn = symbol_get(kvm_put_kvm);
 	if (WARN_ON(!pfn))
 		return;
@@ -463,6 +467,7 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 
 	device->put_kvm = pfn;
 	device->kvm = kvm;
+	device->kvm_module = kvm_module;
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -480,6 +485,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	symbol_put(kvm_put_kvm);
 
 clear:
+	module_put(device->kvm_module);
+	device->kvm_module = NULL;
 	device->kvm = NULL;
 }
 #endif
@@ -1483,7 +1490,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1494,6 +1501,7 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 */
 	spin_lock(&df->kvm_ref_lock);
 	df->kvm = kvm;
+	df->kvm_module = kvm_module;
 	spin_unlock(&df->kvm_ref_lock);
 }
 
@@ -1505,16 +1513,16 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
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
index 9f9acb66cc1e..8161229f4b86 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -35,15 +35,15 @@ struct kvm_vfio {
 	bool noncoherent;
 };
 
-static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *module)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
 		return;
 
-	fn(file, kvm);
+	fn(file, kvm, module);
 
 	symbol_put(vfio_file_set_kvm);
 }
@@ -142,6 +142,7 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
 
 static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
+	struct module *module;
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
 	struct file *filp;
@@ -157,6 +158,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 		goto out_fput;
 	}
 
+	module = filp->f_op->owner;
 	mutex_lock(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
@@ -175,7 +177,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, dev->kvm, module);
 	kvm_vfio_update_coherency(dev);
 
 out_unlock:
@@ -207,7 +209,7 @@ static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
 #endif
-		kvm_vfio_file_set_kvm(kvf->file, NULL);
+		kvm_vfio_file_set_kvm(kvf->file, NULL, NULL);
 		fput(kvf->file);
 		kfree(kvf);
 		ret = 0;
@@ -330,7 +332,7 @@ static void kvm_vfio_release(struct kvm_device *dev)
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
 #endif
-		kvm_vfio_file_set_kvm(kvf->file, NULL);
+		kvm_vfio_file_set_kvm(kvf->file, NULL, NULL);
 		fput(kvf->file);
 		list_del(&kvf->node);
 		kfree(kvf);
-- 
2.51.0

