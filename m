Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A6265CA7
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207406; cv=none; b=YVtSXVlyswThABwI33K25z09jkxs/g9vOh4f2M/M+NDPybjMDjd97eOpYFDOKkbIu7tlpwJKskAf6uU0JyZ6weiDLBkETxnm5wTknaTQW/vxXDyYc3vacS1tNtR15a9v99DweyMhpju/w5ZiH165VRWzhjFHx1l/MgSfo1C2K/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207406; c=relaxed/simple;
	bh=TLOp0TyJ3DZkSLJDbbHKO8NCyyIOCgOOtseQksnZfMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1MQ7F3Wwe7E/WSXsZY4AXJHELukDOr8FqtCdN+bY5zFT51xkhZd+B4PEGKBEA1fk1p/oHkGXhLrmJ3cq4DSvRO5pPrmrEw1+W2aEVaffre8KY+p8OzdSY8ZY72Z+rY9wATli4+CfM9BcDrJv3gKeOdCmjJwXBYkiS6KQD10+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ArAxBGdc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ArAxBGdc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539D6ktG003389;
	Wed, 9 Apr 2025 14:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ruv2THun2A6aLFSbY
	5wWOabXhrxxxjT97zmwRHc6OF8=; b=ArAxBGdcnTBuFd9reFzCk8lSwQkkQhCc/
	CP/O7yo51woJ4FHFBEunHWc/g1GzAXYxFz/UxhmC6SUBDd6FdR1x8vl6WA5LTbGK
	a969sWM7HZFxejRcupYWdYQ/k9n/Zs1UeoWXu4fsEMdGXNy7w9bwTlNdq3ceD43S
	+IOKQ2Fw4/NoWjh4un6kAvX63nqNIUdlzTbJKDLRPi269Gbc2FzZVHgw9zJ5075w
	F6VU+sDN8oSI9fVjRHhAaVCJ6ECEJBQkNBGGUeUr5LFCLJoZft5sThd239b8B8K2
	JlMXOOoxg3QY1q9pX7OEsxSSMYaLRNdzo16WfUdjQwwsJJGmEG8Iw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w7yxd07r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539D0HAA024610;
	Wed, 9 Apr 2025 14:03:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutg78c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3Hks59572636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 306E420063;
	Wed,  9 Apr 2025 14:03:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A640220040;
	Wed,  9 Apr 2025 14:03:16 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:16 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 16/24] s390/zcrypt: Propagate xflags argument with cca_get_info()
Date: Wed,  9 Apr 2025 16:02:57 +0200
Message-ID: <20250409140305.58900-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409140305.58900-1-freude@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gsrLSblnQFr4QSBNBKeEy_r7UlS4hYJd
X-Proofpoint-GUID: gsrLSblnQFr4QSBNBKeEy_r7UlS4hYJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

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
index 88f3c7708c2a..2257410110f5 100644
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

