Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669DF1D0E1E;
	Wed,  2 Oct 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885143; cv=none; b=KUxx2n9N2xr/CCYBR2XFmQdibb9CxuUiNwC2/ZHE7zCpwRMo8M7+ogpE/qegYdboGcVNpTY1XeF4201rCafW7dnHPx7N6aFo8O3k4QcBK88SEzO9v/JUbdhjgxJiBBm/OKVV+ldkm2Q7TCXzMJqfs5pVS1eTb3cUaWD0t9+/1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885143; c=relaxed/simple;
	bh=/zga+w2qpY78WKA0VdO0SbraYKEtAQdxRG51dXopdJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ubeoi/8bYYc5P+5DrHcLac6UG3IFNNuF1xg+N81fILz/2hbC8lPhXZezZvYo2qslAHNpC5/8Uk97vidkzj3NQSfxt/u7eJpVHR6HzsTNwn7E+zOh0VqUgz7fYttYeURQbZ84KKC26zcFdMtL3LQNF1rGhrYONwXxN5S/DW6JbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gUL44xQJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gUL44xQJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FlnoQ028952;
	Wed, 2 Oct 2024 16:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lFjEQXoCQJOmH
	KbyuOaOqgx3CMwMTeJMBggCjY0jlgY=; b=gUL44xQJ/1c0ClUbvLwAaLgyA0G4N
	atwC0ACKzgChlBgqgPmWeyLCQ42idjEFUzweYH0g4/IUrdmMtNc2KdHkFqEMj0sn
	IE4rCxzg0bfE9Ylz8yP24Ob82OdeKMVOwEXP5LSEuVQ4ryzYC9pIhqtHpY10BSYh
	5O/pbzTmOOLoMNUU0nR6tdW1EmyNjnD37JrBWpyxGFIgZvIVqgIplF90dFeC5SLz
	FpAasWnlPOLRimYTpxmzbj6gYX9aEsdStDIL9UygksKf9SkTZd39+lNIy5oALluk
	PsByN0YGqMF4Q4rQM22hPbpoUFIEmeHSO/nf4gJ+9BJhWn5ebAwCWVwBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42194n833k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492FvoRv020408;
	Wed, 2 Oct 2024 16:05:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4sbehw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G5ZuV54460890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:05:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0E820040;
	Wed,  2 Oct 2024 16:05:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC6120043;
	Wed,  2 Oct 2024 16:05:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:05:35 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 6/6] s390/uv: Retrieve UV secrets sysfs support
Date: Wed,  2 Oct 2024 18:05:32 +0200
Message-ID: <20241002160532.2425734-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160532.2425734-1-seiden@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: quZOMTp4yxPj3x7vnHyQFVdzxaUdkwLB
X-Proofpoint-GUID: quZOMTp4yxPj3x7vnHyQFVdzxaUdkwLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=853 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

Reflect the updated content in the query information UVC to the sysfs at
/sys/firmware/query

* new UV-query sysfs entry for the maximum number of retrievable
  secrets the UV can store for one secure guest.
* new UV-query sysfs entry for the maximum number of association
  secrets the UV can store for one secure guest.
* max_secrets contains the sum of max association and max retrievable
  secrets.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/boot/uv.c        |  3 ++-
 arch/s390/include/asm/uv.h | 10 ++++++----
 arch/s390/kernel/uv.c      | 24 +++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 2a71e759dc42..4568e8f81dac 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -46,7 +46,8 @@ void uv_query_info(void)
 		uv_info.supp_add_secret_req_ver = uvcb.supp_add_secret_req_ver;
 		uv_info.supp_add_secret_pcf = uvcb.supp_add_secret_pcf;
 		uv_info.supp_secret_types = uvcb.supp_secret_types;
-		uv_info.max_secrets = uvcb.max_secrets;
+		uv_info.max_assoc_secrets = uvcb.max_assoc_secrets;
+		uv_info.max_retr_secrets = uvcb.max_retr_secrets;
 	}
 
 	if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index aef333aaaef4..89e10dcc3f63 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -143,9 +143,10 @@ struct uv_cb_qui {
 	u64 reservedf0;				/* 0x00f0 */
 	u64 supp_add_secret_req_ver;		/* 0x00f8 */
 	u64 supp_add_secret_pcf;		/* 0x0100 */
-	u64 supp_secret_types;			/* 0x0180 */
-	u16 max_secrets;			/* 0x0110 */
-	u8 reserved112[0x120 - 0x112];		/* 0x0112 */
+	u64 supp_secret_types;			/* 0x0108 */
+	u16 max_assoc_secrets;			/* 0x0110 */
+	u16 max_retr_secrets;			/* 0x0112 */
+	u8 reserved114[0x120 - 0x114];		/* 0x0114 */
 } __packed __aligned(8);
 
 /* Initialize Ultravisor */
@@ -528,7 +529,8 @@ struct uv_info {
 	unsigned long supp_add_secret_req_ver;
 	unsigned long supp_add_secret_pcf;
 	unsigned long supp_secret_types;
-	unsigned short max_secrets;
+	unsigned short max_assoc_secrets;
+	unsigned short max_retr_secrets;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 410f96e06cba..421bd8e02f04 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -696,12 +696,32 @@ static struct kobj_attribute uv_query_supp_secret_types_attr =
 static ssize_t uv_query_max_secrets(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", uv_info.max_secrets);
+	return sysfs_emit(buf, "%d\n",
+			  uv_info.max_assoc_secrets + uv_info.max_retr_secrets);
 }
 
 static struct kobj_attribute uv_query_max_secrets_attr =
 	__ATTR(max_secrets, 0444, uv_query_max_secrets, NULL);
 
+static ssize_t uv_query_max_retr_secrets(struct kobject *kobj,
+					 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", uv_info.max_retr_secrets);
+}
+
+static struct kobj_attribute uv_query_max_retr_secrets_attr =
+	__ATTR(max_retr_secrets, 0444, uv_query_max_retr_secrets, NULL);
+
+static ssize_t uv_query_max_assoc_secrets(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%d\n", uv_info.max_assoc_secrets);
+}
+
+static struct kobj_attribute uv_query_max_assoc_secrets_attr =
+	__ATTR(max_assoc_secrets, 0444, uv_query_max_assoc_secrets, NULL);
+
 static struct attribute *uv_query_attrs[] = {
 	&uv_query_facilities_attr.attr,
 	&uv_query_feature_indications_attr.attr,
@@ -719,6 +739,8 @@ static struct attribute *uv_query_attrs[] = {
 	&uv_query_supp_add_secret_pcf_attr.attr,
 	&uv_query_supp_secret_types_attr.attr,
 	&uv_query_max_secrets_attr.attr,
+	&uv_query_max_assoc_secrets_attr.attr,
+	&uv_query_max_retr_secrets_attr.attr,
 	NULL,
 };
 
-- 
2.43.0

