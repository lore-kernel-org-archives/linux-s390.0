Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378E1D049B;
	Wed,  2 Oct 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885067; cv=none; b=tApgRpu2GFr71hGhC6vTVMwDdXBBSpO7TBdbWGBln4F9UtFxAa+Ls1Bch9XfEyAtpzb3PUJupljou6ws5PleVE4iinwmdl0EbzdxH5ub3gFRF21DHMzXdt8tUlLcjMYdKV7bxhJBD87i6dRAAsEq3TBAnkWo22eawd5ESX+oaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885067; c=relaxed/simple;
	bh=5ps02AKUPUap7CrHuP3f5c17HukPF3XWNUIwPsZTYog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anX7kfAfPjT+wUAfE+4rJncIGy2UhKyicGRb8fQxkuTPhwlYYhn1mDWEhYFEF9rROdUgkCp1nfZliHj6YFO/UNOwKl8UXHXW3WcZ6mAqHVMntibIHP4kCKV30Fjwpf454ldx/ZST6t1fUbKc8cezAtc/5nZtc+GsxAKvIlZSB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GcHBAn58; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GcHBAn58"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FsWMi007700;
	Wed, 2 Oct 2024 16:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=w/MDoCgvbNfd8
	wXTx+iyLWxZ8nVcDQGLHyq3macLLnE=; b=GcHBAn58joJE8w06QU4yVlXxp+ONC
	Z1SC22Bc5hPN1J6ySyW9Bohsktc6hIqqMVi93KYPEo6dgJoN+1HwBXiMoCY6TVgz
	bPB4V+1/x9OlYYJb7rdVEh7wLAGKSojWWMr1Z5VwL95ATJ2M20FreCFL9VlSVPtB
	Ewq/92YzqSaWMPOH1xwvyVAphOOY08P9lX9wvwPfst8iSOi0WWU14kfXdHBDYBct
	TFAAVvC6v1Kg4jsSiBJycGig4AOZw1vsiVeEZN2NMXGkcDH7V4gWuvuEdVbTfcHI
	5VCHRfWNQ7HiAiHGhiEgSRchFi3l40ZAtyVoG30VpfjpS6trGY5+RXPxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42197t81nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492D1tqa017866;
	Wed, 2 Oct 2024 16:04:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n37nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G4Jt457016632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:04:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF07420040;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E55C20049;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 2/2] s390/uv: Provide host-key hashes in sysfs
Date: Wed,  2 Oct 2024 18:04:18 +0200
Message-ID: <20241002160418.2424889-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160418.2424889-1-seiden@linux.ibm.com>
References: <20241002160418.2424889-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nvgdKIppzR-8aEW98OPCHzStbNERK-lu
X-Proofpoint-GUID: nvgdKIppzR-8aEW98OPCHzStbNERK-lu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020114

Utilize the new Query Ultravisor Keys UVC to give user space the
information which host-keys are installed on the system.

Create a new sysfs directory 'firmware/uv/keys' that contains the hash
of the host-key and the backup host-key of that system. Additionally,
the file 'all' contains the response from the UVC possibly containing
more key-hashes than currently known.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 16 +++++++++
 arch/s390/kernel/uv.c      | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 153d93468b77..c69ac06a31f9 100644
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
@@ -145,6 +147,20 @@ struct uv_cb_qui {
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
+	struct uv_key_hash keys[15];	/* 0x0020 */
+} __packed __aligned(8);
+
 /* Initialize Ultravisor */
 struct uv_cb_init {
 	struct uv_cb_header header;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 901e852f858b..6333e3346d88 100644
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
+	return emit_hash(&uvcb.keys[UVC_QUERY_KEYS_IDX_HK], buf, 0);
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
+	return emit_hash(&uvcb.keys[UVC_QUERY_KEYS_IDX_BACK_HK], buf, 0);
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
+	for (i = 0; i < ARRAY_SIZE(uvcb.keys); i++)
+		len += emit_hash(uvcb.keys + i, buf, len);
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
@@ -791,6 +858,10 @@ static int __init uv_sysfs_init(void)
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

