Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B766265CA0
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207401; cv=none; b=rV06+a/YU5E+CBiKRF1fQgxpKDz4vDPJprg5JWwr4G9J920Y5mD1CCLHcrxsZGFDhB+dPDsL/cVjyIi4dL6r5IQZCkcK533TblvTkgqrjZlfCkhcReAMiXjb1ymg8URQWfsdAAE+0MkNZc1fdmDygEUpm8PPVrHfsm715FfnWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207401; c=relaxed/simple;
	bh=xXb6U48Yr+GG+OnQizgP+GJfLl4qEmgpU1bojcdDzVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxoIHzTZPC1OxBMnmKslDqDmGBRO//OEpBN5I7TUi6TtXp8H7WzPAunjnDVeFXYJpFwN0PzvuWJqSzJPV7ojec1P6mHyn8Ker9/9yNL6NktzJQUFDHIOi56sppnUbWcxXHv3XoztvGTEFd33xYseD79ryhAPBmsUj24rJpYwcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dAuMuuZ1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dAuMuuZ1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539DrP6E003817;
	Wed, 9 Apr 2025 14:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dt965VTXeZHGqBKVG
	cALaJiRBSsoFNihyApBxoETLGk=; b=dAuMuuZ1llfOBQudTQ4CE9Nxwgkn1E5lp
	MMiXkVuTq2B9pk3X//LsE9nyhiEI7zZQv/gLCVVKUjzjpte0AhXurbNvkCZsvbhY
	SbClRdlWvr7wzCasD9XRCvgcIx61YbHUdOARzgQTODQtyrVrNeIVSQVUNZCjdfup
	15q8x9E8FY3DUo7EDUJufwkJUMhC3ZD5odFLa9kxTfHZ17r2LRyR1sh9IE9XcZYU
	F9HCBY3PcsXpWZ+vGfaOMM5E9DnyXAqrU9VqXX7jMWIV9DoikHfDnUY/5g2OYQyI
	wO+1YtuCz2zrDUZrpODcGWvgBKT/nwDUBR2/1kirCWMsVVx3ZIOrw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w7yxd06y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539CWEPR024651;
	Wed, 9 Apr 2025 14:03:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutg77w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E3Bhd43057596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCC9920040;
	Wed,  9 Apr 2025 14:03:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B54E2004B;
	Wed,  9 Apr 2025 14:03:11 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:11 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 08/24] s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
Date: Wed,  9 Apr 2025 16:02:49 +0200
Message-ID: <20250409140305.58900-9-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: m6UPTkt2XnAVRftSIg4qrhzlXjhEnMqO
X-Proofpoint-GUID: m6UPTkt2XnAVRftSIg4qrhzlXjhEnMqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090086

Rework the existing function zcrypt_device_status_mask_ext():
Add two new parameters to provide upper limits for
cards and queues. The existing implementation needed an
array of 256 * 256 * 4 = 256 KB which is really huge. The
reworked function is more flexible in the sense that the
caller can decide the upper limit for cards and domains to
be stored into the status array. So for example a caller may
decide to only query for cards 0...127 and queues 0...127
and thus only an array of size 128 * 128 * 4 = 64 KB is needed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      | 14 +++++++++++---
 drivers/s390/crypto/zcrypt_api.h      |  3 ++-
 drivers/s390/crypto/zcrypt_ccamisc.c  | 17 ++++++++++++-----
 drivers/s390/crypto/zcrypt_ep11misc.c | 12 ++++++++----
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 95b9e6200ce2..421f32ce12d8 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1307,19 +1307,25 @@ static void zcrypt_device_status_mask(struct zcrypt_device_status *devstatus)
 	spin_unlock(&zcrypt_list_lock);
 }
 
-void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
+void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus,
+				   int maxcard, int maxqueue)
 {
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	struct zcrypt_device_status_ext *stat;
 	int card, queue;
 
+	maxcard = min_t(int, maxcard, MAX_ZDEV_CARDIDS_EXT);
+	maxqueue = min_t(int, maxqueue, MAX_ZDEV_DOMAINS_EXT);
+
 	spin_lock(&zcrypt_list_lock);
 	for_each_zcrypt_card(zc) {
 		for_each_zcrypt_queue(zq, zc) {
 			card = AP_QID_CARD(zq->queue->qid);
 			queue = AP_QID_QUEUE(zq->queue->qid);
-			stat = &devstatus[card * AP_DOMAINS + queue];
+			if (card >= maxcard || queue >= maxqueue)
+				continue;
+			stat = &devstatus[card * maxqueue + queue];
 			stat->hwtype = zc->card->ap_dev.device_type;
 			stat->functions = zc->card->hwinfo.fac >> 26;
 			stat->qid = zq->queue->qid;
@@ -1625,7 +1631,9 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					 GFP_KERNEL);
 		if (!device_status)
 			return -ENOMEM;
-		zcrypt_device_status_mask_ext(device_status);
+		zcrypt_device_status_mask_ext(device_status,
+					      MAX_ZDEV_CARDIDS_EXT,
+					      MAX_ZDEV_DOMAINS_EXT);
 		if (copy_to_user((char __user *)arg, device_status,
 				 total_size))
 			rc = -EFAULT;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 84d636fd14a4..05542ce8ad3c 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -172,7 +172,8 @@ int zcrypt_api_init(void);
 void zcrypt_api_exit(void);
 long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
 long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
-void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
+void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus,
+				   int maxcard, int maxqueue);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 05085b40a55c..0d3bf6b1fcb4 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1808,7 +1808,10 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	zcrypt_device_status_mask_ext(device_status,
+				      MAX_ZDEV_CARDIDS_EXT,
+				      MAX_ZDEV_DOMAINS_EXT);
 
 	/* walk through all crypto cards */
 	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
@@ -1915,7 +1918,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc = 0;
+	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 
 	/* fetch status of all crypto cards */
@@ -1924,13 +1927,16 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	zcrypt_device_status_mask_ext(device_status,
+				      MAX_ZDEV_CARDIDS_EXT,
+				      MAX_ZDEV_DOMAINS_EXT);
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
 	if (!_apqns) {
-		kvfree(device_status);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	/* walk through all the crypto apqnss */
@@ -1995,6 +2001,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 00e9d141a456..e1a1d047ac8a 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1599,7 +1599,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, rc = -ENOMEM;
+	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
@@ -1609,13 +1609,16 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	zcrypt_device_status_mask_ext(device_status,
+				      MAX_ZDEV_CARDIDS_EXT,
+				      MAX_ZDEV_DOMAINS_EXT);
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
 	if (!_apqns) {
-		kvfree(device_status);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	/* walk through all the crypto apqnss */
@@ -1669,6 +1672,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
-- 
2.43.0

