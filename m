Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BA184101;
	Thu, 24 Oct 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751207; cv=none; b=lQ0c1bMosVA3US7rEKkRdxWGxXwD2leM9w5DArq6QFvG5lXZ4qcv8RfDCvAoiDvDO+qMm6oKvQKPiR5IdmOx0rW5gDGgNdykDCS/DYR/PkHMMyC/4kXRXxOVMQEB9xb0ExzSWSqEWChif7YoMFb2umBJA0TWtKmNnX7O2a2uC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751207; c=relaxed/simple;
	bh=wi7DrlcozzdfQQxbJz64FcJgeM+hzTWDnMjNyGx1qvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/1SPjJ3oxg6fLQkOsVqcqs+6RU7pF0xCNvnTyhrhn9tlqGVvXfaPLfqNC0VbZ4N71XTs8TZ7aPlEkkpUPZ7wBwkMIZGVIf3+XmP8+b2lBTJO1Ev8Xu9ALHPr7anNiGVsbJvriN3p6EUlNGpsLbb3eoIP5whVq26Pq5sERjflQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XzjhfDM9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XzjhfDM9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O0e9u8012538;
	Thu, 24 Oct 2024 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pNqU+806yrBGetf5b
	f5sG94MR4fWhoSVuIHkbtiUnkc=; b=XzjhfDM9a1oStwB2pk3tANbDnaQzKRqHj
	JISGnOX/niPh+/vA8vHxc35OpLJMSCdD6sRM6jdKfZGvnhdpa7Ly6t07ZycOgLgZ
	LuC39EQd5WerZ93biivWSq/TgcFBpdjpHxBux3a8qeXNTGkQO/k/y6+yRqqkulci
	rP/15caNt2LYh1cNEH0fhcpHnJLzGQY0Y3DqIgr8vUUKJmcrDvfmsjsc0b5aEcv3
	JEgkrsZcHAPwmo/6OIRrRYhy2mv/jc20boLp6/Jb3Nup1ZkmrHPT6RGe9nLbu6O/
	mLdlS8LAWigG90eg4ldJus3CO0hlRKmBdy4GeRo80Hs3DiP4iewUw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw411em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O305KF014557;
	Thu, 24 Oct 2024 06:26:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7xwvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 06:26:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O6QdGR33686138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 06:26:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0D5C20040;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39F22004E;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 06:26:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v5 6/6] s390/uv: Retrieve UV secrets sysfs support
Date: Thu, 24 Oct 2024 08:26:38 +0200
Message-ID: <20241024062638.1465970-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024062638.1465970-1-seiden@linux.ibm.com>
References: <20241024062638.1465970-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3PJcCV_PogiDJuU7nKS68LfHGZcPyFPU
X-Proofpoint-GUID: 3PJcCV_PogiDJuU7nKS68LfHGZcPyFPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=863 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240042

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
index f063e21d898d..0f8d107d678c 100644
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
@@ -531,7 +532,8 @@ struct uv_info {
 	unsigned long supp_add_secret_req_ver;
 	unsigned long supp_add_secret_pcf;
 	unsigned long supp_secret_types;
-	unsigned short max_secrets;
+	unsigned short max_assoc_secrets;
+	unsigned short max_retr_secrets;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index cb9cb3f47471..5247c8b0cdff 100644
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
2.45.2

