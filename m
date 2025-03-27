Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76C21859A
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086399; cv=none; b=F4R6FDTTTxaTSdJwk/d3hSb5KItPYwvSdCXITs1fE5k///qcoHZN+j00OOKt3x7/fjxBL2psbw4g0e+Odv4VWdmLYPwxN1126I9BsF4Tu4OoDBMsH4vrZQeRdd7sujlIYuYElwOHL2Ye7IO365s5h/XivacKtM+X9GCRaOR16Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086399; c=relaxed/simple;
	bh=wi7OLs9xPa4UQLtdtLPCWcCgDss9J1bHB5KNW3Rx1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9/9nCZp9gL5po1wnTuj1Job11TG2owYzmVb+Nl+w2kqkPhqi61j67Wpjcz5RfOWBXP7J9ffZCbXOgejoPRfFbU/NMTy3q4sQaz6y++vwcWZKoJHTpzNcEE2Wlc4o2BFGg6CeNAxCMc5eGlCq0dLJ/NlHpalEaY1+YrPscIzhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LeCo5El1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LeCo5El1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8nM3J009650;
	Thu, 27 Mar 2025 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7LWg5/Ok+CuggBgvO
	FhfuVBp4eU8akpXHmsVHf4b2Mc=; b=LeCo5El1ZGpKBoBTWuaiUPA3B14AhnxNm
	5Cys1V/Y/9KrE7rq8W2U8Ik2Gr44xYVm72QmcX9S12Qxt1NhHkbqsiVckHdkr/Eu
	v+7Kvh54wdJCqkwwGLidveQJkXqMPZKYechEdaj3ty3LqPzAP3PoSgo1n0PqtxKA
	zEu6T7ZWKhhRfp7vHfeUFTbYEdqV5t5BfjXpCjG5AOke95QSi5QxGHzA3diwJKzQ
	TdNBw14bKreAhyu7e4aKTjzEH13upHQVliftmbhBEZzW7iCkxXUfGLmy0TtxtRnP
	nCLFBtZUz30Dr7XAmHk8IYw3AgYclKpnnvJPlpBfkc8hpjFh1rslw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrrq4ehy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RC3Gr7012250;
	Thu, 27 Mar 2025 14:39:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mdq3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdowo36372818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0A202004B;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5636E20043;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 15/21] s390/zcrypt: Propagate xflags argument with cca_get_info()
Date: Thu, 27 Mar 2025 15:39:35 +0100
Message-ID: <20250327143941.45507-16-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: woHhb-AwWjAqanMcLOAgEzWmrEOZ0CUq
X-Proofpoint-GUID: woHhb-AwWjAqanMcLOAgEzWmrEOZ0CUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270099

Propagate the xflags argument from the cca_get_info()
caller down to the lower level functions for proper
memory allocation hints.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 11 ++++++-----
 drivers/s390/crypto/zcrypt_ccamisc.h |  2 +-
 drivers/s390/crypto/zcrypt_cex4.c    |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 7a3ab4f4ce2c..9c9a8412f4eb 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1636,14 +1636,14 @@ EXPORT_SYMBOL(cca_query_crypto_facility);
 /*
  * Fetch cca_info values via query_crypto_facility from adapter.
  */
-static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
+static int fetch_cca_info(u16 cardnr, u16 domain,
+			  struct cca_info *ci, u32 xflags)
 {
 	void *mem;
 	int rc, found = 0;
 	size_t rlen, vlen;
 	u8 *rarray, *varray;
 	struct zcrypt_device_status_ext devstat;
-	u32 xflags = 0;
 
 	memset(ci, 0, sizeof(*ci));
 
@@ -1717,9 +1717,9 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 /*
  * Fetch cca information about a CCA queue.
  */
-int cca_get_info(u16 card, u16 dom, struct cca_info *ci)
+int cca_get_info(u16 card, u16 dom, struct cca_info *ci, u32 xflags)
 {
-	return fetch_cca_info(card, dom, ci);
+	return fetch_cca_info(card, dom, ci, xflags);
 }
 EXPORT_SYMBOL(cca_get_info);
 
@@ -1730,6 +1730,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
+	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1758,7 +1759,7 @@ int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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

