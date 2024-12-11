Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F51FF5E3;
	Wed, 11 Dec 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939684; cv=none; b=phX9o+U6gwE6fb7yElyXQgke0TNo/a5EVJeUsLwo2/ceKCRJ9dIMjSrGlCV1gPgZX4spHhCb9YDaM4PuofZX1f1d5EIuCiRrE6ckCIZ4Ri7072y9CQb+4v0jHJTkGwZXuKVfDBJjpvxkldkjwjDXDZRK6EXYCC6RDeEoUnIh2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939684; c=relaxed/simple;
	bh=12hHO6niZJCGhDppSxFeOOejXGKMBYthJ3BtK3jvRTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2VKDNBp2lVYmFOGdRLXNtWV8fqw5BEDkpvG82kLUxe0fIuHr+yV/jiN3BTIZSbt5hdD2/0QVIRg/sy/ufbwGldxRkaURMANaUD1YiGKkhlKecY/F/8wIiAljsaAYnUrkMVXxsGebm8ke/C4QYVEg5hpZy7W96DKyWscR4S7PW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TzEUFM+P; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TzEUFM+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939680;
	bh=12hHO6niZJCGhDppSxFeOOejXGKMBYthJ3BtK3jvRTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TzEUFM+P4aeZJONYMcELMIJUOrbGLYmfY0cw+oZrGWQC7zffknnd7W8uZZr9LGcrM
	 Dbdz02z/F7xbeM5GwCb260Y+ymcNRqp4YjO8sY8pDaxilQNov9L21pMip0Ds7N/azb
	 rc6wo1lMDHWt5XK7g3XE/+sAe+b2YHvCLbUOUGuM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:54:40 +0100
Subject: [PATCH 2/5] s390/ipl: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-s390-v1-2-be01f66bfcf7@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Niklas Schnelle <schnelle@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939680; l=11532;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=12hHO6niZJCGhDppSxFeOOejXGKMBYthJ3BtK3jvRTk=;
 b=dOJco9ecFmAWupmBRF/pti0kK3NFAOnxA3nOy+C6NKPdLAHK49ckiSV48geXcHMuSCHQ0rsX8
 EHa7PKxT0SACaUZtN2nmFg5np2iTF+JV3BTQJfko6/NHRbHup8nuIi0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/s390/kernel/ipl.c | 142 ++++++++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index edbb52ce3f1ec23d8e464fce3fddee64d2327848..5291e6dd347d3cb4d1d8c5812ce1d5ad2b5a326d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -280,58 +280,58 @@ static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
 			sys_##_prefix##_##_name##_show,			\
 			sys_##_prefix##_##_name##_store)
 
-#define IPL_ATTR_SCP_DATA_SHOW_FN(_prefix, _ipl_block)			\
-static ssize_t sys_##_prefix##_scp_data_show(struct file *filp,		\
-					    struct kobject *kobj,	\
-					    struct bin_attribute *attr,	\
-					    char *buf, loff_t off,	\
-					    size_t count)		\
-{									\
-	size_t size = _ipl_block.scp_data_len;				\
-	void *scp_data = _ipl_block.scp_data;				\
-									\
-	return memory_read_from_buffer(buf, count, &off,		\
-				       scp_data, size);			\
+#define IPL_ATTR_SCP_DATA_SHOW_FN(_prefix, _ipl_block)				\
+static ssize_t sys_##_prefix##_scp_data_show(struct file *filp,			\
+					    struct kobject *kobj,		\
+					    const struct bin_attribute *attr,	\
+					    char *buf, loff_t off,		\
+					    size_t count)			\
+{										\
+	size_t size = _ipl_block.scp_data_len;					\
+	void *scp_data = _ipl_block.scp_data;					\
+										\
+	return memory_read_from_buffer(buf, count, &off,			\
+				       scp_data, size);				\
 }
 
 #define IPL_ATTR_SCP_DATA_STORE_FN(_prefix, _ipl_block_hdr, _ipl_block, _ipl_bp_len, _ipl_bp0_len)\
-static ssize_t sys_##_prefix##_scp_data_store(struct file *filp,	\
-					struct kobject *kobj,		\
-					struct bin_attribute *attr,	\
-					char *buf, loff_t off,		\
-					size_t count)			\
-{									\
-	size_t scpdata_len = count;					\
-	size_t padding;							\
-									\
-	if (off)							\
-		return -EINVAL;						\
-									\
-	memcpy(_ipl_block.scp_data, buf, count);			\
-	if (scpdata_len % 8) {						\
-		padding = 8 - (scpdata_len % 8);			\
-		memset(_ipl_block.scp_data + scpdata_len,		\
-		       0, padding);					\
-		scpdata_len += padding;					\
-	}								\
-									\
-	_ipl_block_hdr.len = _ipl_bp_len + scpdata_len;			\
-	_ipl_block.len = _ipl_bp0_len + scpdata_len;			\
-	_ipl_block.scp_data_len = scpdata_len;				\
-									\
-	return count;							\
+static ssize_t sys_##_prefix##_scp_data_store(struct file *filp,		\
+					struct kobject *kobj,			\
+					const struct bin_attribute *attr,	\
+					char *buf, loff_t off,			\
+					size_t count)				\
+{										\
+	size_t scpdata_len = count;						\
+	size_t padding;								\
+										\
+	if (off)								\
+		return -EINVAL;							\
+										\
+	memcpy(_ipl_block.scp_data, buf, count);				\
+	if (scpdata_len % 8) {							\
+		padding = 8 - (scpdata_len % 8);				\
+		memset(_ipl_block.scp_data + scpdata_len,			\
+		       0, padding);						\
+		scpdata_len += padding;						\
+	}									\
+										\
+	_ipl_block_hdr.len = _ipl_bp_len + scpdata_len;				\
+	_ipl_block.len = _ipl_bp0_len + scpdata_len;				\
+	_ipl_block.scp_data_len = scpdata_len;					\
+										\
+	return count;								\
 }
 
 #define DEFINE_IPL_ATTR_SCP_DATA_RO(_prefix, _ipl_block, _size)		\
 IPL_ATTR_SCP_DATA_SHOW_FN(_prefix, _ipl_block)				\
-static struct bin_attribute sys_##_prefix##_scp_data_attr =		\
+static const struct bin_attribute sys_##_prefix##_scp_data_attr =	\
 	__BIN_ATTR(scp_data, 0444, sys_##_prefix##_scp_data_show,	\
 		   NULL, _size)
 
 #define DEFINE_IPL_ATTR_SCP_DATA_RW(_prefix, _ipl_block_hdr, _ipl_block, _ipl_bp_len, _ipl_bp0_len, _size)\
 IPL_ATTR_SCP_DATA_SHOW_FN(_prefix, _ipl_block)					\
 IPL_ATTR_SCP_DATA_STORE_FN(_prefix, _ipl_block_hdr, _ipl_block, _ipl_bp_len, _ipl_bp0_len)\
-static struct bin_attribute sys_##_prefix##_scp_data_attr =			\
+static const struct bin_attribute sys_##_prefix##_scp_data_attr =		\
 	__BIN_ATTR(scp_data, 0644, sys_##_prefix##_scp_data_show,		\
 		   sys_##_prefix##_scp_data_store, _size)
 
@@ -434,19 +434,19 @@ static struct kobj_attribute sys_ipl_device_attr =
 	__ATTR(device, 0444, sys_ipl_device_show, NULL);
 
 static ssize_t sys_ipl_parameter_read(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t off, size_t count)
 {
 	return memory_read_from_buffer(buf, count, &off, &ipl_block,
 				       ipl_block.hdr.len);
 }
-static struct bin_attribute sys_ipl_parameter_attr =
+static const struct bin_attribute sys_ipl_parameter_attr =
 	__BIN_ATTR(binary_parameter, 0444, sys_ipl_parameter_read, NULL,
 		   PAGE_SIZE);
 
 DEFINE_IPL_ATTR_SCP_DATA_RO(ipl_fcp, ipl_block.fcp, PAGE_SIZE);
 
-static struct bin_attribute *ipl_fcp_bin_attrs[] = {
+static const struct bin_attribute *const ipl_fcp_bin_attrs[] = {
 	&sys_ipl_parameter_attr,
 	&sys_ipl_fcp_scp_data_attr,
 	NULL,
@@ -454,7 +454,7 @@ static struct bin_attribute *ipl_fcp_bin_attrs[] = {
 
 DEFINE_IPL_ATTR_SCP_DATA_RO(ipl_nvme, ipl_block.nvme, PAGE_SIZE);
 
-static struct bin_attribute *ipl_nvme_bin_attrs[] = {
+static const struct bin_attribute *const ipl_nvme_bin_attrs[] = {
 	&sys_ipl_parameter_attr,
 	&sys_ipl_nvme_scp_data_attr,
 	NULL,
@@ -462,7 +462,7 @@ static struct bin_attribute *ipl_nvme_bin_attrs[] = {
 
 DEFINE_IPL_ATTR_SCP_DATA_RO(ipl_eckd, ipl_block.eckd, PAGE_SIZE);
 
-static struct bin_attribute *ipl_eckd_bin_attrs[] = {
+static const struct bin_attribute *const ipl_eckd_bin_attrs[] = {
 	&sys_ipl_parameter_attr,
 	&sys_ipl_eckd_scp_data_attr,
 	NULL,
@@ -593,9 +593,9 @@ static struct attribute *ipl_fcp_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group ipl_fcp_attr_group = {
+static const struct attribute_group ipl_fcp_attr_group = {
 	.attrs = ipl_fcp_attrs,
-	.bin_attrs = ipl_fcp_bin_attrs,
+	.bin_attrs_new = ipl_fcp_bin_attrs,
 };
 
 static struct attribute *ipl_nvme_attrs[] = {
@@ -607,9 +607,9 @@ static struct attribute *ipl_nvme_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group ipl_nvme_attr_group = {
+static const struct attribute_group ipl_nvme_attr_group = {
 	.attrs = ipl_nvme_attrs,
-	.bin_attrs = ipl_nvme_bin_attrs,
+	.bin_attrs_new = ipl_nvme_bin_attrs,
 };
 
 static struct attribute *ipl_eckd_attrs[] = {
@@ -620,9 +620,9 @@ static struct attribute *ipl_eckd_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group ipl_eckd_attr_group = {
+static const struct attribute_group ipl_eckd_attr_group = {
 	.attrs = ipl_eckd_attrs,
-	.bin_attrs = ipl_eckd_bin_attrs,
+	.bin_attrs_new = ipl_eckd_bin_attrs,
 };
 
 /* CCW ipl device attributes */
@@ -640,11 +640,11 @@ static struct attribute *ipl_ccw_attrs_lpar[] = {
 	NULL,
 };
 
-static struct attribute_group ipl_ccw_attr_group_vm = {
+static const struct attribute_group ipl_ccw_attr_group_vm = {
 	.attrs = ipl_ccw_attrs_vm,
 };
 
-static struct attribute_group ipl_ccw_attr_group_lpar = {
+static const struct attribute_group ipl_ccw_attr_group_lpar = {
 	.attrs = ipl_ccw_attrs_lpar
 };
 
@@ -655,7 +655,7 @@ static struct attribute *ipl_common_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group ipl_common_attr_group = {
+static const struct attribute_group ipl_common_attr_group = {
 	.attrs = ipl_common_attrs,
 };
 
@@ -808,7 +808,7 @@ DEFINE_IPL_ATTR_SCP_DATA_RW(reipl_fcp, reipl_block_fcp->hdr,
 			    IPL_BP_FCP_LEN, IPL_BP0_FCP_LEN,
 			    DIAG308_SCPDATA_SIZE);
 
-static struct bin_attribute *reipl_fcp_bin_attrs[] = {
+static const struct bin_attribute *const reipl_fcp_bin_attrs[] = {
 	&sys_reipl_fcp_scp_data_attr,
 	NULL,
 };
@@ -917,9 +917,9 @@ static struct attribute *reipl_fcp_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group reipl_fcp_attr_group = {
+static const struct attribute_group reipl_fcp_attr_group = {
 	.attrs = reipl_fcp_attrs,
-	.bin_attrs = reipl_fcp_bin_attrs,
+	.bin_attrs_new = reipl_fcp_bin_attrs,
 };
 
 static struct kobj_attribute sys_reipl_fcp_clear_attr =
@@ -932,7 +932,7 @@ DEFINE_IPL_ATTR_SCP_DATA_RW(reipl_nvme, reipl_block_nvme->hdr,
 			    IPL_BP_NVME_LEN, IPL_BP0_NVME_LEN,
 			    DIAG308_SCPDATA_SIZE);
 
-static struct bin_attribute *reipl_nvme_bin_attrs[] = {
+static const struct bin_attribute *const reipl_nvme_bin_attrs[] = {
 	&sys_reipl_nvme_scp_data_attr,
 	NULL,
 };
@@ -955,9 +955,9 @@ static struct attribute *reipl_nvme_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group reipl_nvme_attr_group = {
+static const struct attribute_group reipl_nvme_attr_group = {
 	.attrs = reipl_nvme_attrs,
-	.bin_attrs = reipl_nvme_bin_attrs
+	.bin_attrs_new = reipl_nvme_bin_attrs
 };
 
 static ssize_t reipl_nvme_clear_show(struct kobject *kobj,
@@ -1031,7 +1031,7 @@ DEFINE_IPL_ATTR_SCP_DATA_RW(reipl_eckd, reipl_block_eckd->hdr,
 			    IPL_BP_ECKD_LEN, IPL_BP0_ECKD_LEN,
 			    DIAG308_SCPDATA_SIZE);
 
-static struct bin_attribute *reipl_eckd_bin_attrs[] = {
+static const struct bin_attribute *const reipl_eckd_bin_attrs[] = {
 	&sys_reipl_eckd_scp_data_attr,
 	NULL,
 };
@@ -1048,9 +1048,9 @@ static struct attribute *reipl_eckd_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group reipl_eckd_attr_group = {
+static const struct attribute_group reipl_eckd_attr_group = {
 	.attrs = reipl_eckd_attrs,
-	.bin_attrs = reipl_eckd_bin_attrs
+	.bin_attrs_new = reipl_eckd_bin_attrs
 };
 
 static ssize_t reipl_eckd_clear_show(struct kobject *kobj,
@@ -1587,15 +1587,15 @@ static struct attribute *dump_fcp_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *dump_fcp_bin_attrs[] = {
+static const struct bin_attribute *const dump_fcp_bin_attrs[] = {
 	&sys_dump_fcp_scp_data_attr,
 	NULL,
 };
 
-static struct attribute_group dump_fcp_attr_group = {
+static const struct attribute_group dump_fcp_attr_group = {
 	.name  = IPL_FCP_STR,
 	.attrs = dump_fcp_attrs,
-	.bin_attrs = dump_fcp_bin_attrs,
+	.bin_attrs_new = dump_fcp_bin_attrs,
 };
 
 /* NVME dump device attributes */
@@ -1621,15 +1621,15 @@ static struct attribute *dump_nvme_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *dump_nvme_bin_attrs[] = {
+static const struct bin_attribute *const dump_nvme_bin_attrs[] = {
 	&sys_dump_nvme_scp_data_attr,
 	NULL,
 };
 
-static struct attribute_group dump_nvme_attr_group = {
+static const struct attribute_group dump_nvme_attr_group = {
 	.name  = IPL_NVME_STR,
 	.attrs = dump_nvme_attrs,
-	.bin_attrs = dump_nvme_bin_attrs,
+	.bin_attrs_new = dump_nvme_bin_attrs,
 };
 
 /* ECKD dump device attributes */
@@ -1655,15 +1655,15 @@ static struct attribute *dump_eckd_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *dump_eckd_bin_attrs[] = {
+static const struct bin_attribute *const dump_eckd_bin_attrs[] = {
 	&sys_dump_eckd_scp_data_attr,
 	NULL,
 };
 
-static struct attribute_group dump_eckd_attr_group = {
+static const struct attribute_group dump_eckd_attr_group = {
 	.name  = IPL_ECKD_STR,
 	.attrs = dump_eckd_attrs,
-	.bin_attrs = dump_eckd_bin_attrs,
+	.bin_attrs_new = dump_eckd_bin_attrs,
 };
 
 /* CCW dump device attributes */

-- 
2.47.1

