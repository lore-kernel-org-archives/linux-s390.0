Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7E1D90DC;
	Tue, 15 Oct 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991748; cv=none; b=HX/JGcyOSLddJlC75ED9XL+KZmrLkL1gDBMg4FZOAl7Nb3pmZNI/r78UYsTNbDCH2noPZF0VFWaLoRXiIq/ZfwhT9rzveUJy/wwqj5htvDIeP1aJ5nQB3GgxOqbM7hNJb3TqJVW0REggNg1rsaG6Na19I1Fn8vk2gzFExptMwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991748; c=relaxed/simple;
	bh=3oJlOFC+/viLUq7EoxBu1cXSAeaiQ64PDkqEoUZrSuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHIZUIYbkIfr8uqOoum01bKycqnqfts+HBPYct5XZhD52LEqkro7t3TmvHHTh7yCDlC2yb+kx5WGkWe2i0kUe7QhAQ4hkUydRVeO9yaY5IALr5xklHsf1EHLrADnEeKKuQw1RI7WfzypRgP4ru/K1Xtiqljqoxh9jTI+hW7bFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hk4X9Rbr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hk4X9Rbr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FApREO013734;
	Tue, 15 Oct 2024 11:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kDMx+b3NA0SMQ9hQR
	JTG3fXF7OlwjD/EZUny+rQIbkw=; b=Hk4X9RbrTcnPMKEUlPjTlmw/xVOjW9btf
	tNHBHgnke/1xluqPCm2nW3kpxpaQYRFmiSFTupelxHd+HnG/tzuf2QjrRMJQ61Ix
	ekZUaS4BxVkbE4wdYO2I6QrPBH6dHybOPK4oDCLQ1j/2EwY5vZhPIZ/DPC9IRh8F
	h/kzT85Dnoon30+CKNU71pfzp/Dcl+0KOreNIT6qXiwYfrw9ZJ71mhM49Rm/k8n7
	Gx2iupS2M0aEObwrn3JN5Axwmxcr5nfdUoQrbzV7C3+fNT4FuHGXVoaNlPL/LXGW
	YXnvPdyX2Kqb8+uECpH+1rYmwrth8CABVN6Tcg7xLQN2vEYd28GIQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q0gg699-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F9Bl8f006338;
	Tue, 15 Oct 2024 11:29:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650u5jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBT15145220276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:29:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07E122004E;
	Tue, 15 Oct 2024 11:29:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0C9E20043;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 6/6] s390/uv: Retrieve UV secrets sysfs support
Date: Tue, 15 Oct 2024 13:28:59 +0200
Message-ID: <20241015112859.3069210-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015112859.3069210-1-seiden@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZchDVYvTm25Yp-vx1pO1ADzehwuntxHa
X-Proofpoint-GUID: ZchDVYvTm25Yp-vx1pO1ADzehwuntxHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=859
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150078

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
index bc61cf3e689b..371bbaf3dbe9 100644
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
@@ -530,7 +531,8 @@ struct uv_info {
 	unsigned long supp_add_secret_req_ver;
 	unsigned long supp_add_secret_pcf;
 	unsigned long supp_secret_types;
-	unsigned short max_secrets;
+	unsigned short max_assoc_secrets;
+	unsigned short max_retr_secrets;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 588caf5d4f0c..d6079aa9b57b 100644
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

