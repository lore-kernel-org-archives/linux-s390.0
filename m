Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B544DB6E;
	Tue, 28 Apr 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392368; cv=none; b=he7hAWU4zdS1fjRSgw+xGNalMlJI8W2TcGvRgO+YOv5Nzfqf6bJQdihpXRwcdolXXsSzOevm9ccatBf3L1IbEJ+rzOtA1XJ+sDH49OtpO2qXarIx+/pb36gzyc4yvI/qfuMrRYyxyM3/6WOb6PYkLPyA296Xk1IDZE1omTErQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392368; c=relaxed/simple;
	bh=sLmO43I1fGggXTJc6lDyGm22zjRCnOY5uimqRbSoEyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1tPlav8mkNe9l1bsWc5QB1Wfw/XkJEUbJih6G2FsRDvvdALrRou5mz1qOAwoumHW9JKhPVth0ji5ErUeTCvRssvxJ5RBQn0iu2/TadjbJCZvX0QSqodkfsZr1ox9HPDrn9ihcsMIu3id5HqR2ADEiVTdbkRZI7hdivO0AYC698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R2hyFp6h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R2hyFp6h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S8J12f3499801;
	Tue, 28 Apr 2026 16:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qt6ktfrLJePUXMeoV
	k3l/jfY20rrL/wv5Pu2sFHRLCI=; b=R2hyFp6hgmFBo9YseeBBllLF38dUSYopv
	KyRycZ9sA8dhhjJ9trvvOR+H2t3d1fXTu0YgOiTDvBocspfMxJAnsyTcfoeUkaMK
	tZE4tdcxZDYKPKaD1WTav76diNn17S2XAzpOCyBJEBatgLiuE8/6gojqKwovMynR
	gDixdAO/xY4JIKTQQkqOYQ+ChaNnlfI2vaP4VXTGwXmL1U2nI0e0RZbSV+utZ5we
	LnRjq08Aha53jIbqfeQReIlqb1x2lstKsREhqUYG7/FBa+Yy6fQvlPlqyhIPvGS+
	3LLJJqM5+HCCRsDYVPImnnLc4EcmetOTo+GzQEVFLa16r8hjxOFDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFroXY006523;
	Tue, 28 Apr 2026 16:05:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqajaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5SkR53019056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C379920040;
	Tue, 28 Apr 2026 16:05:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B85320043;
	Tue, 28 Apr 2026 16:05:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:28 +0000 (GMT)
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
Subject: [RFC PATCH v2 03/28] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Date: Tue, 28 Apr 2026 18:05:00 +0200
Message-ID: <20260428160527.1378085-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -QXboBkip70_d1llBqYzXAJDdwZ7VnxT
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dacd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=Iid1VeoRPhL8jyw1u-UA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: -QXboBkip70_d1llBqYzXAJDdwZ7VnxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX8eJFi2zG4Lzr
 8hQiN2chErpEopbvQg2Y0QxgwakR5C/bj+gWmIsQ1XE+grlni9Uph/rX4hMEOn3pGE9hXnWrIgw
 ViJ13qtFaUyOO9UB8GU3BjdIPJYACp5HRipJ+6i0bzB1UhDvcJsZbXA1BOqyB5+d9FmmHAWTTb2
 fDsY+dPUHTUxeIrnhSmZNbuosrzcbJjCYpClmdH6um6DBfU/p97nYSmB9UduuLX7skDeuGiHtO/
 Hy1EL+XlBo4wYGhdBiEwmZVfziL2alX3Q3deXFck2MLku+SfMDw8PMx5b7Fv9Y1vRIeHLVbWqgb
 xxaMEFSFU2fE9SfcbgAV0zumj9WG3Z9RBgOGX9UoYQB/zVKsp9ssKcfnnknOpZdOB10z/lWvb+A
 Qq53NmTPiU7ZgcWGnS4AVN/MuqnDrCH61yE4i9MP5TlXTTjF2czZ/XL0lVFEHz+GywQAmGD5UCV
 29SybtU0AhBsntIFJag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

The remaining use in VFIO is for kvm_put_kvm, which is not inline
because it needs to call kvm_destroy_vm.  However, storing the
address of kvm_destroy_vm in the "struct kvm" is enough to remove
the dependency from VFIO.

This also makes it possible to direct kvm_put_kvm to either the arm64
or the s390 implementation of kvm_destroy_vm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
---
 drivers/vfio/vfio_main.c  | 24 +++---------------------
 include/linux/kvm_host.h  |  1 -
 include/linux/kvm_types.h |  8 ++++++++
 include/linux/vfio.h      |  1 -
 virt/kvm/kvm_main.c       |  9 ++-------
 5 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index cb6eaabd64ce..f27a1d00c21e 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -17,7 +17,7 @@
 #include <linux/idr.h>
 #include <linux/iommu.h>
 #if IS_ENABLED(CONFIG_KVM)
-#include <linux/kvm_host.h>
+#include <linux/kvm_types.h>
 #endif
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -435,9 +435,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 #if IS_ENABLED(CONFIG_KVM)
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
@@ -446,21 +443,13 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struc
 	if (!try_module_get(kvm_module))
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
+	if (!kvm_get_kvm_safe(kvm))
 		goto out_put_mod;
 
-	ret = kvm_get_kvm_safe(kvm);
-	if (!ret)
-		goto out_put_sym;
-
-	device->put_kvm = pfn;
 	device->kvm = kvm;
 	device->kvm_module = kvm_module;
 	return;
 
-out_put_sym:
-	symbol_put(kvm_put_kvm);
 out_put_mod:
 	module_put(kvm_module);
 }
@@ -472,14 +461,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
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
+	kvm_put_kvm(device->kvm);
 	device->kvm = NULL;
 	module_put(device->kvm_module);
 	device->kvm_module = NULL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5163b541c82d..ca06f9bda028 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1064,7 +1064,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 4cb68c71a13c..8a9be07cb8dd 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -144,6 +144,7 @@ struct kvm_vcpu_stat_generic {
 
 struct kvm_refcount {
 	refcount_t users_count;
+	void (*destroy)(struct kvm *kvm);
 };
 
 static inline void kvm_get_kvm(struct kvm *kvm)
@@ -162,6 +163,13 @@ static inline bool kvm_get_kvm_safe(struct kvm *kvm)
 	return refcount_inc_not_zero(&rc->users_count);
 }
 
+static inline void kvm_put_kvm(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+	if (refcount_dec_and_test(&rc->users_count))
+		rc->destroy(kvm);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 69a8d527b0e8..5c69532d6127 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -65,7 +65,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6e3796814da7..27a718a0bc01 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -120,6 +120,7 @@ static struct dentry *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
+static void kvm_destroy_vm(struct kvm *kvm);
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -1155,6 +1156,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 
 	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
 	refcount_set(&kvm->rc.users_count, 1);
+	kvm->rc.destroy = kvm_destroy_vm;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1317,13 +1319,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
-void kvm_put_kvm(struct kvm *kvm)
-{
-	if (refcount_dec_and_test(&kvm->rc.users_count))
-		kvm_destroy_vm(kvm);
-}
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
-
 /*
  * Used to put a reference that was taken on behalf of an object associated
  * with a user-visible file descriptor, e.g. a vcpu or device, if installation
-- 
2.51.0

