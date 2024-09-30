Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68918FDDA;
	Mon, 30 Sep 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702450; cv=none; b=V8iP4ks64kAN83CaqYNNMRdiNMXYJTyQHFybDgNXpFXPtp1QQqmuuerc2TKaI4BRitg6EchPXwYWBjJj5GvAGlTfDiXLARocvrhE/eGkI3EKjpU4aYMOtgSzqj5c6F+QTsgNqJaewce2oBYqTC7m1+Jm2CDKnM5T/rpI5sF+VaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702450; c=relaxed/simple;
	bh=1IWkyp1luxPA/PVmroBHpj8L7Xshr10wK7hTg1y6CRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQz17NwyZXbeEsCDuRzh8crZ84Ia9OdK/6AQdpSHp39SjwBdcjzBfVZW4roKaG3XmOW27SsdLOvwsTDCyXFqUnoIJw7n4OIEB+xeG3UWABWFjSgycADiCVUxXMSBj7d0Z/uU4Jkm4k2lVFhEdq5m5r9Dm5bEAIDTRMTbtDStK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gJ9r2S6k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gJ9r2S6k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAtPMa019886;
	Mon, 30 Sep 2024 13:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=hRBl0bNdlf2qX
	c+6Ah6a2822a+NX/25nXMWlZVyNL4I=; b=gJ9r2S6kN9qjMX3GPXBAloekfJseI
	a5GA8ymj4+Mt20x6Q99Jb4LXxpdSCduL3abeDfdoXhsUQ0sj8FXjoBRgTuDVBdj3
	YNy+2pzVrmGGiHCosaXH311ui/n2PW1WA0Il4JzyOQZkYuGu04i+SldiiD9NLjmC
	YMOhA6GECq72N1si5jj9LYf0rVaV/vLlsqpSc3I821II1LGwTYgbOCiGT62laCwM
	nkaXdV8yV7l7RqP5AnmJ3HR3J9CZ6blep69Ebf9KOQVUeKJsqMsv6o/mqzz7OOdC
	Pvt320prg6PY7fQVX41yhdDBxX1cQJbPlIB7+/iQTjdgbBanH7IlriXJg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb21dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCLGqV013047;
	Mon, 30 Sep 2024 13:20:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6evs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDKh7g46530842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:20:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 287E22004D;
	Mon, 30 Sep 2024 13:20:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA52D20043;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 2/2] s390/uv: Provide host-key hashes in sysfs
Date: Mon, 30 Sep 2024 15:20:41 +0200
Message-ID: <20240930132042.2081982-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930132042.2081982-1-seiden@linux.ibm.com>
References: <20240930132042.2081982-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ArgOT-_IxNjUL4DvJZMiSPARujOzK3_U
X-Proofpoint-ORIG-GUID: ArgOT-_IxNjUL4DvJZMiSPARujOzK3_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Utilize the new Query Ultravisor Keys to give user space the information
which host-keys are installed on the system.

Create a new sysfs directory 'firmware/uv/keys' that contains the hash
of the host-key and the backup host-key of that system. Additionally,
the file 'all' contains the response from the UVC possibly containing
more key-hashes than currently known.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 16 ++++++++
 arch/s390/kernel/uv.c      | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 153d93468b77..7eda73073cdd 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -31,6 +31,7 @@
 #define UVC_RC_NEED_DESTROY	0x8000
 
 #define UVC_CMD_QUI			0x0001
+#define UVC_CMD_QUK			0x0002
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
index d703ecc9aea5..5496bceba275 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -721,10 +721,79 @@ static struct attribute *uv_query_attrs[] = {
 	NULL,
 };
 
+static inline struct uv_cb_query_keys uv_query_keys(void)
+{
+	struct uv_cb_query_keys uvcb = {
+		.header.cmd = UVC_CMD_QUK,
+		.header.len = sizeof(uvcb)
+	};
+
+	if (!test_bit_inv(BIT_UVC_CMD_QUERY_KEYS, uv_info.inst_calls_list))
+		return uvcb;
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
@@ -750,6 +819,7 @@ static const struct attribute *uv_prot_virt_attrs[] = {
 };
 
 static struct kset *uv_query_kset;
+static struct kset *uv_keys_kset;
 static struct kobject *uv_kobj;
 
 static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
@@ -789,6 +859,11 @@ static int __init uv_sysfs_init(void)
 	rc = uv_sysfs_dir_init(&uv_query_attr_group, &uv_query_kset, "query");
 	if (rc)
 		goto out_ind_files;
+
+	// Get installed key hashes if available, ignore any errors
+	if (test_bit_inv(BIT_UVC_CMD_QUERY_KEYS, uv_info.inst_calls_list))
+		uv_sysfs_dir_init(&uv_keys_attr_group, &uv_keys_kset, "keys");
+
 	return 0;
 
 out_ind_files:
-- 
2.43.0

