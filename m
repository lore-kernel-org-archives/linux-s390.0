Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457211F153C
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727094; cv=none; b=XipCGsYymMvHgjV3/1I5W+L0QWQpd9mfRddrFGSUpHwIN0O9aCMq2A3SfdwNif7eDDhA9yoQ8cAvlxjjIzwj7I22U4EC/LpaveXmQrqyPAziM7F5vIV4Kd6w1iLfcvnxQukvndFKhqCHnj/Jv6BUI4cs1uEob7f/+wsgwFuJ0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727094; c=relaxed/simple;
	bh=nZ2xZS2eDY5c5dqPF11YqWKDJoaDQggiKLGhMfgnDSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/z7XN0U5gxlJ9CK8fhBgSfar7ffvIHcXjj22aC2rJFMI1wsETO4rKdPwrWNeG6qoGxXRGTwzmgOOFf8E2qr5ff4OJ/5ipQtf3OaZZUvCntnZREPd67MOOTA3M8SEOyzLsZfwDFeuBt/tGhSjZwx1VrHex2dtTkFie2mL+L1zkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A3YDGlZl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A3YDGlZl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAeXVx020476;
	Tue, 15 Apr 2025 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gvbT0KzOiFab21CtG
	VgcBVx4aP8d5zgRTfwrLy2LqPk=; b=A3YDGlZlbUlVZ3oIyaWJTLgGMeAHTLHCp
	ul/jEQvnOG3YGRcAvxASOX3UEjub23LnW3EM2tXWfC4vBDqxGeijpYQa32RRC7Kr
	L+ReGZX5szJvHSgFIYJLXW/vyjKBYX+ZsI+kcDyscrSnjlPq5ecpbsgSkJFUUSU2
	Snqmt4yyJlYTycV9fLSg7RvyP9h/41EVQkDtfG93C9Sz9hVix1JwMaSaX8a0KdQ/
	SlgLgEJB0blGIzQFlC02V91asc2G1dsOtyn1VxBJdCfYHhBrGlnw/qX+jg0NVGW9
	L2K6kWZUMwZWZFB/eTt17251sElDFm22OHLxWkRUzrU2HOo0oO6MQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461nwq13ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FDLq10000920;
	Tue, 15 Apr 2025 14:24:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyupub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOk6m53936618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317092004B;
	Tue, 15 Apr 2025 14:24:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D268120043;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 16/25] s390/zcrypt: Propagate xflags argument with cca_get_info()
Date: Tue, 15 Apr 2025 16:24:29 +0200
Message-ID: <20250415142438.118474-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415142438.118474-1-freude@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d5VVF06nj98kgJFlR3s7VgVXSPYFZ-8Y
X-Proofpoint-GUID: d5VVF06nj98kgJFlR3s7VgVXSPYFZ-8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

Propagate the xflags argument from the cca_get_info()
caller down to the lower level functions for proper
memory allocation hints.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 6 +++---
 drivers/s390/crypto/zcrypt_ccamisc.h | 2 +-
 drivers/s390/crypto/zcrypt_cex4.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 47eb164cb1ea..2ecbea39c03a 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1635,14 +1635,13 @@ EXPORT_SYMBOL(cca_query_crypto_facility);
  * Fetch cca_info values about a CCA queue via
  * query_crypto_facility from adapter.
  */
-int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci)
+int cca_get_info(u16 cardnr, u16 domain, struct cca_info *ci, u32 xflags)
 {
 	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
 	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
-	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1721,6 +1720,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
+	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1749,7 +1749,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		if (domain != 0xFFFF && dom != domain)
 			continue;
 		/* get cca info on this apqn */
-		if (cca_get_info(card, dom, &ci))
+		if (cca_get_info(card, dom, &ci, xflags))
 			continue;
 		/* current master key needs to be valid */
 		if (mktype == AES_MK_SET && ci.cur_aes_mk_state != '2')
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index ca41a675dd3b..38d69aceefe6 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -255,7 +255,7 @@ struct cca_info {
 /*
  * Fetch cca information about an CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci);
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci, u32 xflags);
 
 int zcrypt_ccamisc_init(void);
 void zcrypt_ccamisc_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index ecf1fcc6315e..84cbcbab2741 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -85,7 +85,7 @@ static ssize_t cca_serialnr_show(struct device *dev,
 	memset(&ci, 0, sizeof(ci));
 
 	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci);
+		cca_get_info(ac->id, ap_domain_index, &ci, 0);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }
@@ -119,7 +119,7 @@ static ssize_t cca_mkvps_show(struct device *dev,
 
 	cca_get_info(AP_QID_CARD(zq->queue->qid),
 		     AP_QID_QUEUE(zq->queue->qid),
-		     &ci);
+		     &ci, 0);
 
 	if (ci.new_aes_mk_state >= '1' && ci.new_aes_mk_state <= '3')
 		n += sysfs_emit_at(buf, n, "AES NEW: %s 0x%016llx\n",
-- 
2.43.0

