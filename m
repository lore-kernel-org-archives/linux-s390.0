Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EF1917FF;
	Mon, 30 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702361; cv=none; b=Z/QNpJhKE/vFkJvr6uX9MbRSVVluafxo9G/tNZTDzkP5F1QzZhfV+pPB5qGdeIw0Pcx4GoS2LdXhbjLFxelZgoUnQN6FxL0Whwr2cdi1ntfMMV53wUqWAdMBZkZQWRL8asxcfAltqKO6I9r0LIb50TktR1VIj0B07CjeHEbSprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702361; c=relaxed/simple;
	bh=KWOJsgPOtI2ciHjeMG79gLaAlbobHPEj/SfBjWKepUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYYlJ79eFCf/RvsJRCsZ6l3P/IHFJal74qBOHOFf9rdvOvj8iK9R4zD0qwMmk/SBvU0hU1NHCJfRBtylzjacT4PTBFZPrhqbwRWPQ8gUNofpyhWu6+cdSeAfsfQRpcVVdvGT3YwdmTDQvg6M29FBTgYaHGsPBivRLYLjdD2GyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQfwLfMa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQfwLfMa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2wHqS011669;
	Mon, 30 Sep 2024 13:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Nwu9/nluX9mVA
	Ghnnfm3SdjttB8IG/ZrPr/MrXs5TpQ=; b=UQfwLfMa1O9e5RBoTaWPrHaAwUWxu
	ik8QfFbJL2IFCFpY8nbwtpPd30Q60/4Wmp/e5PEbetXyYN16hbMiVITmGG79Gpkv
	oo7RoWeQJXuR9jVpKzrbprn+EG6P0xGL+g6+CEPlLdILNiTUiewKTF2gMryz2Z55
	ojOj+c0fPE2bThn9CYDI71cX9z+BwnZZ0ODvcwN83hODgjxAgn4Vbq1bnjYPzZQa
	TfzFIlg/6X7tjl3ntgFwKr5HukxKa0mP96uHvqKfZNrvOerDCaOM2TRJuehIH8Y4
	vfbNvfcaCrXfjl/A/TTmD5vR0YlLgUIYQiJIUIWg8q17XhsVZtdILq2RQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb215s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAOVFr007947;
	Mon, 30 Sep 2024 13:19:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxpu1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:19:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDJCgM13369612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:19:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03E3920049;
	Mon, 30 Sep 2024 13:19:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1B22005A;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:19:11 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 6/6] s390/uv: Retrieve UV secrets sysfs support
Date: Mon, 30 Sep 2024 15:19:09 +0200
Message-ID: <20240930131909.2079965-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930131909.2079965-1-seiden@linux.ibm.com>
References: <20240930131909.2079965-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ubcraTtFtW-p1XJgA5NYWeyw-IalVPsC
X-Proofpoint-ORIG-GUID: ubcraTtFtW-p1XJgA5NYWeyw-IalVPsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Reflect the updated content in the query information UVC to the sysfs at
/sys/firmware/query

* new UV-query sysfs entry for the maximum number of retrievable
  secrets the UV can store for one secure guest.
* new UV-query sysfs entry for the maximum number of association
  secrets the UV can store for one secure guest.
* max_secrets contains the sum of max association and max retrievable
  secrets.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/boot/uv.c        |  3 ++-
 arch/s390/include/asm/uv.h |  8 +++++---
 arch/s390/kernel/uv.c      | 24 +++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

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
index 6838aa23e4e5..91631bea22d8 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -144,8 +144,9 @@ struct uv_cb_qui {
 	u64 supp_add_secret_req_ver;		/* 0x00f8 */
 	u64 supp_add_secret_pcf;		/* 0x0100 */
 	u64 supp_secret_types;			/* 0x0180 */
-	u16 max_secrets;			/* 0x0110 */
-	u8 reserved112[0x120 - 0x112];		/* 0x0112 */
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
index 090246efc1fa..cde4ff642f9b 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -695,12 +695,32 @@ static struct kobj_attribute uv_query_supp_secret_types_attr =
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
@@ -718,6 +738,8 @@ static struct attribute *uv_query_attrs[] = {
 	&uv_query_supp_add_secret_pcf_attr.attr,
 	&uv_query_supp_secret_types_attr.attr,
 	&uv_query_max_secrets_attr.attr,
+	&uv_query_max_assoc_secrets_attr.attr,
+	&uv_query_max_retr_secrets_attr.attr,
 	NULL,
 };
 
-- 
2.43.0

