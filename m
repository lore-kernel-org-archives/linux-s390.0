Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEF3F0A82;
	Fri, 29 May 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069900; cv=none; b=sogqxZeYqnFdpZNWAcWnC6ZKkxDvSIQ2LEnweB0+04iWLNA5+PaxoyL+bCwU9JsscgIKPSP966GP3Jk5mB3mGpDWXueiV+CGrnWjf69t/6ygvPNgRJzmv5CE1jd26fkTKYosa8HE7SnmrfujkotvVEg/YJeuRFt8sYL2IwzLuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069900; c=relaxed/simple;
	bh=LqtOgVyEfeTGxsxmlm/e1kJpdL65uM9L8WZi7A64hcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smHaPG85iaKPG+hpraWpm0BJyz2HPTzIVPvjT5buSaTbhjhXIKKjsMJOmlJQvvz9RDqiN8vMYL24/ft1TdYNa+rMYRt9iebIxS4bW7CyHHZvlcv14lEVMwH2SYJF0ix11EG6tkoh1z34AeOXFH/yIa7teiet3OoO1YWF7vW+twU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ik243tM1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ik243tM1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF9bDG2418009;
	Fri, 29 May 2026 15:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=38JiNFeklbccFtH2p
	h2/bPaFd8mrZsh9Ea0AawF0sQg=; b=ik243tM1UzJzROY1FZfm5i3fiWnPWK21c
	p+jIRchW1JMM2Am/IrWQRK7rEEe5rbm53BK2PoILvm6Dlkf8/NjEuxP383gn2xds
	Dd1qarTIthis0G8uHd8GOohDYtVYG/MA/TmFFyoa9j3ninygnSqrroyU1pQG418k
	1Y/hrsdthdwg+IIqJKf4BLQd44ZaT75TMIAFqpHGTHR/VprcAmuvZZLI4Sg43n2K
	59L7T5v57HEDM0Izt46sRhK/u5ffow1hmztCpBkRc9rJ/hAryOalMTnxYy64n3hw
	IWV7Or7pFPSELNsWCAZuICgRClCVYSQ4udDrOfK8F/iZFFiqiMo7A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884ve0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:50:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6h9005005;
	Fri, 29 May 2026 15:50:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgg1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:50:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFopgi49807858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA5A20043;
	Fri, 29 May 2026 15:50:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904DC2004B;
	Fri, 29 May 2026 15:50:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:51 +0000 (GMT)
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
Subject: [PATCH v3 03/27] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Date: Fri, 29 May 2026 17:50:17 +0200
Message-ID: <20260529155050.2902245-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b5e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=Iid1VeoRPhL8jyw1u-UA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: NU_-Q4KFPUH2BieGYecsp8vJiPmwpRyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX/lyxJxEHtGhf
 mGvQZFpi+vfwZZSPBjJ0A3NJylhXgGL/ggCqSU+Sz93jxXP3090B3BpaIuYbO5x2IHlHITOC9xz
 ucsSw1PZ+W3u319F6D8hUKE5iWoqaE2yPbA2TzhP5amPuCL3467uPs4wjhb0uIyHuFyKJGknAyj
 ROOSvfIAn9Wb0F8/44ASvEfJVNYRKnzmvINLzkHXLPph+h3o/LgwweEtYErlXYUn0OHeb/AqseC
 3BFGGwI6Cbx2ApOb3ZFBzHzVL/mbbsu/ZrqUhVEnFS7S9uca2Y0HOwmBcOaFo7gO0OgjGTf5c3f
 m0pzwqN9l1MSv4AoTNxJQm9NqX0GoSXjt8zogebGld5s9HpN6GmxwSVO3IW36VRL9wiLcRrQQVZ
 Ttdp9VbXx4IIesJj4OFlc4u+kGranpdnQwPN/0qeMuT8sLc3k8FzijE8lEeEQ8Bo5FLxnrwnULi
 oJxvXcnBDeTYwD9RTlw==
X-Proofpoint-GUID: NU_-Q4KFPUH2BieGYecsp8vJiPmwpRyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

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
index e606db41ff3f..053559a8c7f3 100644
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
@@ -444,9 +444,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 #if IS_ENABLED(CONFIG_KVM)
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
@@ -455,21 +452,13 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struc
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
@@ -481,14 +470,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
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
index 8a068cbf12ff..088986d0aca2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1072,7 +1072,6 @@ static inline void kvm_irqfd_exit(void)
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
index 5bfec0339804..81f04e60ebfd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -67,7 +67,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3c08f640c996..2eca44a69a9a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -119,6 +119,7 @@ static struct dentry *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
+static void kvm_destroy_vm(struct kvm *kvm);
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -1148,6 +1149,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 
 	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
 	refcount_set(&kvm->rc.users_count, 1);
+	kvm->rc.destroy = kvm_destroy_vm;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1310,13 +1312,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
2.53.0

