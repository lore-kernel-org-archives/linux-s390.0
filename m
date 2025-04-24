Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37531519BC
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501820; cv=none; b=FtY68gMpVRVuFiCFQFe0nkKwCAfb8RLKeOANCn2+c4hAbfpaS2UPSApkLbT3VHDdQOAxcGEcU0YMJSqjWq/s0sFVhspmSiJNj4civNgxFjnrOdLV4+hSyzc0PD1tmMSL28QPdFk9xhnwNN+QdOH+yeqPkNUgURVsNJsjHHP5dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501820; c=relaxed/simple;
	bh=qud1Q3uZrM0pf64n0LjW2yMEpWhxvrSkhM4bxnyIncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDEyHRVQYchvraBeEgRnTxx4WxZF7CGGgsk9znFj0hucF8h95O62veI37QyNOKUEbIIkt6zI1j0CKWESYJ7TfVafhLWTfEBUUtDV9QMRs+IIsXeQ8k7BGI95p545BxtbeS7bmNvmZTyEcdFxnoamQjYSujGQa5kikgKHWd8Pjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xr4MHD3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xr4MHD3H"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAxVIN029599;
	Thu, 24 Apr 2025 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IevgxHjHA+Dor1rnI
	/JcL4sWjHp4Ppl1t0VX2e4AjHM=; b=Xr4MHD3Hl2i4KYJ3Xf2JFKm6gb0YTlTfL
	pDYYSK4dvpazGsmc5V3HhU2AtrmdG9XWeQNMv88pY1IHuPbcxCfQ7LyHewMdOrex
	qur//AfaCc5PvvmcXO22Gw0Wdqt6OmNi0czQR6jwew3hSixDfECGjS3EXyVIzeXY
	0pFTviczu51T21iSNfI8rksp2Z1+sdYwQqsa+o9lOFsCNEfWeu2UQMbla8IR4W43
	CVkPek7kPdIL+o0HBy2Bch+PEf3fBNlMJW+RYS0yzPzk0ROp9PNgejCkZPASt053
	FeFd9IHst88wMkxDBYgM3K3y+uj4+FecW9zT+/MSveXInqYRsMrSA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aabu9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBSrid008601;
	Thu, 24 Apr 2025 13:36:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxrdqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaOOH56492346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C85320040;
	Thu, 24 Apr 2025 13:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25E852004B;
	Thu, 24 Apr 2025 13:36:24 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 09/25] s390/zcrypt: Introduce pre-allocated device status array for cca misc
Date: Thu, 24 Apr 2025 15:36:03 +0200
Message-ID: <20250424133619.16495-10-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX/2JB3yCB2c2z DkQ5WwKVqkHg5C2E9KqA2qHd271tS+K+8RntBQDFES9Q2fPEoShzu7mhMJ0RyLFVrxkyF2kxlfw eRovVwoGnjj8rpsYnu4/UUOaCP6XhylTaoMC1YHxXQo6+SgJSAxgBW2IDvyB1Nwlabgglpa5+EB
 GIrd+aorne+XbSVSbdvIUEmfAGu5ymvh3L7yOSok0TnvznQlGR8nmXjd0is/HeO6gOi1ZoO78UB IyX0uRypou//VrWWHeh1Lt2lUD13UN2irCotzpeEOvGphMd+ozPNo5ictIwrDtbpuhX6HrmnuGT b94C1n+XgYfPp91B+PJj7gv8yBplhwSjkTK+KgMMRVg+H/HJddC08L6dGYtSVZWvA1rSAUJipMg
 sI2YdFDNrbaMsIdT42imdWK/mqI0E2EMEq5jnGm25mfzLwMenzRHsVN214dwlKIcAd9bWvbb
X-Proofpoint-ORIG-GUID: fRmOIWH-oQWYe7TJu5LOi8_TYiWaVDSc
X-Proofpoint-GUID: fRmOIWH-oQWYe7TJu5LOi8_TYiWaVDSc
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a3e77 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=usCmz767aogY_-vmJnMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard2()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 47 ++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index bbc804d632a4..7ecd4a7c0792 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -51,6 +51,22 @@ static DEFINE_SPINLOCK(cca_info_list_lock);
 #define CPRB_MEMPOOL_ITEM_SIZE (16 * 1024)
 static mempool_t *cprb_mempool;
 
+/*
+ * This is a pre-allocated memory for the device status array
+ * used within the findcard() functions. It is currently
+ * 128 * 128 * 4 bytes = 64 KB big. Usage of this memory is
+ * controlled via dev_status_mem_mutex. Needs adaption if more
+ * than 128 cards or domains to be are supported.
+ */
+#define ZCRYPT_DEV_STATUS_CARD_MAX 128
+#define ZCRYPT_DEV_STATUS_QUEUE_MAX 128
+#define ZCRYPT_DEV_STATUS_ENTRIES (ZCRYPT_DEV_STATUS_CARD_MAX * \
+				   ZCRYPT_DEV_STATUS_QUEUE_MAX)
+#define ZCRYPT_DEV_STATUS_EXT_SIZE (ZCRYPT_DEV_STATUS_ENTRIES * \
+		sizeof(struct zcrypt_device_status_ext))
+static void *dev_status_mem;
+static DEFINE_MUTEX(dev_status_mem_mutex);
+
 /*
  * Simple check if the token is a valid CCA secure AES data key
  * token. If keybitsize is given, the bitsize of the key is
@@ -1919,16 +1935,15 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 
-	/* fetch status of all crypto cards */
-	device_status = kvcalloc(MAX_ZDEV_ENTRIES_EXT,
-				 sizeof(struct zcrypt_device_status_ext),
-				 GFP_KERNEL);
-	if (!device_status)
-		return -ENOMEM;
+	/* occupy the device status memory */
+	mutex_lock(&dev_status_mem_mutex);
+	memset(dev_status_mem, 0, ZCRYPT_DEV_STATUS_EXT_SIZE);
+	device_status = (struct zcrypt_device_status_ext *)dev_status_mem;
 
+	/* fetch crypto device status into this struct */
 	zcrypt_device_status_mask_ext(device_status,
-				      MAX_ZDEV_CARDIDS_EXT,
-				      MAX_ZDEV_DOMAINS_EXT);
+				      ZCRYPT_DEV_STATUS_CARD_MAX,
+				      ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
@@ -1938,7 +1953,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -2000,7 +2015,9 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 out:
-	kvfree(device_status);
+	/* release the device status memory */
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(cca_findcard2);
@@ -2013,11 +2030,21 @@ int __init zcrypt_ccamisc_init(void)
 	if (!cprb_mempool)
 		return -ENOMEM;
 
+	/* Pre-allocate one crypto status card struct used in findcard() */
+	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
+	if (!dev_status_mem) {
+		mempool_destroy(cprb_mempool);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void zcrypt_ccamisc_exit(void)
 {
 	mkvp_cache_free();
+	mutex_lock(&dev_status_mem_mutex);
+	kvfree(dev_status_mem);
+	mutex_unlock(&dev_status_mem_mutex);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

