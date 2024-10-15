Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DFE1D9A42;
	Tue, 15 Oct 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992387; cv=none; b=H8BtXmVQ3miv35gWvgGRlYKcuCMgv6H+MBgyALzlusrhenKZ8SiTqPXPIuNlrRt3YUfyE0jmh5Du3GZAfhZ0UcT49v6dDXlxoZYZvX27eJ07P2vo5AyMNMe2ikGCsQ1M8m0JDD4gIJNtN7YVxVTSlAYhOoy3b1rmA+SKNHTADos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992387; c=relaxed/simple;
	bh=58uJnLDG+K1A6/sQwu2cMHBgb2mBKUVqonzE/zEVOaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=squdU/ysQyhsYM2cMMsidfwVXsyETXrypwKKBiHSntn9J2tyQoc4em78Dqh7tcZEpU7qPHNGFGl1S9560TnDUyvovLNzPGI4kPqNVm+RTE//XGaqGvG1qX8aRC7nMOwZaTzxlH1h0jMLmh+zea8Euigb1RvdBvedQiqIwP7aIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jIXDCNRv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jIXDCNRv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAtP5W013270;
	Tue, 15 Oct 2024 11:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fk76LQzDBx4kVEEhq
	sBZ/E8kseSV0JsntjP6I3cX2rg=; b=jIXDCNRvPgdU7pLTYgV+Rss/FG9DdxT9Z
	pkV5jzDG6e6D7vydYVJPO0nPyMy0ysdnIMGj3t6Y919xIodQ8/2Z2wPk/VHGbBNQ
	Kk52yBccG+0S3WkWivw6rMf1w44eA8H09wryTgWCpwX4vjQW4NKPYphsYmXgRNhV
	04bZIXh08LhZe5edBD5ezJVkkW5N9/KP4AhDigAYVPN1Y1l11Wl5WOaYYiLw9X8r
	MuWUo9plsGUa24TGSYfHKnOy+9DWZtxg6tI/5H5Tsvgja/z4SLJsV9LA987XnpQL
	n6l20vJuRUcnMBzYmigDgpg9GWot6ZbvvI+taovdPISlEjwW/Mn8A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q2fg6eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8uJH9005286;
	Tue, 15 Oct 2024 11:39:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj394k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBdeRZ43188688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:39:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A4E2004D;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D282004E;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/uv: Provide host-key hashes in sysfs
Date: Tue, 15 Oct 2024 13:39:40 +0200
Message-ID: <20241015113940.3088249-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015113940.3088249-1-seiden@linux.ibm.com>
References: <20241015113940.3088249-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JbJTIYzJ6PXVfEwUYm_km3Ex3eLqhiuB
X-Proofpoint-GUID: JbJTIYzJ6PXVfEwUYm_km3Ex3eLqhiuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078

Utilize the new Query Ultravisor Keys UVC to give user space the
information which host-keys are installed on the system.

Create a new sysfs directory 'firmware/uv/keys' that contains the hash
of the host-key and the backup host-key of that system. Additionally,
the file 'all' contains the response from the UVC possibly containing
more key-hashes than currently known.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 17 +++++++++
 arch/s390/kernel/uv.c      | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 153d93468b77..6dab9757419b 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -31,6 +31,7 @@
 #define UVC_RC_NEED_DESTROY	0x8000
 
 #define UVC_CMD_QUI			0x0001
+#define UVC_CMD_QUERY_KEYS		0x0002
 #define UVC_CMD_INIT_UV			0x000f
 #define UVC_CMD_CREATE_SEC_CONF		0x0100
 #define UVC_CMD_DESTROY_SEC_CONF	0x0101
@@ -94,6 +95,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_ADD_SECRET = 29,
 	BIT_UVC_CMD_LIST_SECRETS = 30,
 	BIT_UVC_CMD_LOCK_SECRETS = 31,
+	BIT_UVC_CMD_QUERY_KEYS = 34,
 };
 
 enum uv_feat_ind {
@@ -145,6 +147,21 @@ struct uv_cb_qui {
 	u8 reserved112[0x120 - 0x112];		/* 0x0112 */
 } __packed __aligned(8);
 
+struct uv_key_hash {
+	u64 dword[4];
+} __packed __aligned(8);
+
+#define UVC_QUERY_KEYS_IDX_HK		0
+#define UVC_QUERY_KEYS_IDX_BACK_HK		1
+
+/* Query Ultravisor Keys */
+struct uv_cb_query_keys {
+	struct uv_cb_header header;	/* 0x0000 */
+	u64 reserved08[3];		/* 0x0008 */
+	struct uv_key_hash key_hashes[15];	/* 0x0020 */
+} __packed __aligned(8);
+static_assert(sizeof(struct uv_cb_query_keys) == 0x200);
+
 /* Initialize Ultravisor */
 struct uv_cb_init {
 	struct uv_cb_header header;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index ba514b9dca6a..3c74e6179cdc 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -722,10 +722,76 @@ static struct attribute *uv_query_attrs[] = {
 	NULL,
 };
 
+static inline struct uv_cb_query_keys uv_query_keys(void)
+{
+	struct uv_cb_query_keys uvcb = {
+		.header.cmd = UVC_CMD_QUERY_KEYS,
+		.header.len = sizeof(uvcb)
+	};
+
+	uv_call(0, (uint64_t)&uvcb);
+	return uvcb;
+}
+
+static inline ssize_t emit_hash(struct uv_key_hash *hash, char *buf, int at)
+{
+	return sysfs_emit_at(buf, at, "%016llx%016llx%016llx%016llx\n",
+			    hash->dword[0], hash->dword[1], hash->dword[2], hash->dword[3]);
+}
+
+static ssize_t uv_keys_host_key(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct uv_cb_query_keys uvcb = uv_query_keys();
+
+	return emit_hash(&uvcb.key_hashes[UVC_QUERY_KEYS_IDX_HK], buf, 0);
+}
+
+static struct kobj_attribute uv_keys_host_key_attr =
+	__ATTR(host_key, 0444, uv_keys_host_key, NULL);
+
+static ssize_t uv_keys_backup_host_key(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	struct uv_cb_query_keys uvcb = uv_query_keys();
+
+	return emit_hash(&uvcb.key_hashes[UVC_QUERY_KEYS_IDX_BACK_HK], buf, 0);
+}
+
+static struct kobj_attribute uv_keys_backup_host_key_attr =
+	__ATTR(backup_host_key, 0444, uv_keys_backup_host_key, NULL);
+
+static ssize_t uv_keys_all(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct uv_cb_query_keys uvcb = uv_query_keys();
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(uvcb.key_hashes); i++)
+		len += emit_hash(uvcb.key_hashes + i, buf, len);
+
+	return len;
+}
+
+static struct kobj_attribute uv_keys_all_attr =
+	__ATTR(all, 0444, uv_keys_all, NULL);
+
 static struct attribute_group uv_query_attr_group = {
 	.attrs = uv_query_attrs,
 };
 
+static struct attribute *uv_keys_attrs[] = {
+	&uv_keys_host_key_attr.attr,
+	&uv_keys_backup_host_key_attr.attr,
+	&uv_keys_all_attr.attr,
+	NULL,
+};
+
+static struct attribute_group uv_keys_attr_group = {
+	.attrs = uv_keys_attrs,
+};
+
 static ssize_t uv_is_prot_virt_guest(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -751,6 +817,7 @@ static const struct attribute *uv_prot_virt_attrs[] = {
 };
 
 static struct kset *uv_query_kset;
+static struct kset *uv_keys_kset;
 static struct kobject *uv_kobj;
 
 static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
@@ -789,6 +856,10 @@ static int __init uv_sysfs_init(void)
 	if (rc)
 		goto out_ind_files;
 
+	/* Get installed key hashes if available, ignore any errors */
+	if (test_bit_inv(BIT_UVC_CMD_QUERY_KEYS, uv_info.inst_calls_list))
+		uv_sysfs_dir_init(&uv_keys_attr_group, &uv_keys_kset, "keys");
+
 	return 0;
 
 out_ind_files:
-- 
2.43.0

