Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651E1426C
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403355; cv=none; b=hU2QaftX6xlCBqsqoBCdL36DcTitVFvQemMMKe3amQkBexouUPD7wqpiWUsFbMORgiskHmIlb/c5NyEjKWBtxItr1D7ZwmLCrpo+anEMlXzoD381zPIH8jJ9fxljb6Ulif8M+IdA7/bkLXIb0aeaSj0qLEgqwfQUpeaRetlQ12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403355; c=relaxed/simple;
	bh=YzxhKuaULIIFqc+44cNOmPMKWLI1AwC/HgyLrZKVJl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG9vrDE1XT8XZgwr9rr/1Lh6p/QaK4QHvFyT5vl+x3tv2tJ62j+kQ0pmO+fANjIQkgu29LZxyKx3bqIROdaIYDnTctqwTDzFyc191NsY5ZfNczptB4hdKHW8Q6VKw1USmzT6U5evnfbs2u3g6IgOKh5uraKxEC3i6V/NCsnWEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMQaYEKk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMQaYEKk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjWh007113;
	Wed, 23 Apr 2025 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fT1TbmXlpe+e0REuf
	kn0ZGIAMNmWTMlDmdp+8yhizQk=; b=EMQaYEKk4ohoveYABgMJxpr3BQNBXKuLw
	/C2qcSGmd3/syO6ta2U6HmlrWr/YjbuIFyLVL+YrjqahMzGonnh1nf/G4YRi6TKs
	yEWSBlal0XteRnCsILFEXMciSSjSecfQNVk1Ov1V7wOvcJKYBs+6XcBUJmsyxgz6
	ifqyrgxFW/XcNmlRmtcE5UKW7gQpOSdwSjpottzAkkU1UZ5P7lCkk1qnboQZf1cF
	CH6GnUZHW+rXRGNOzQF3IsoVk7Grhno2jDnNySFFc45VKgrrGF0Kot1sy0a7K5a4
	/GApUpXVhLlaje49+AcLBl8B0ZRCCzoq0uBgMfjHPIZiET+kHFe7Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnstmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6YZ0X022266;
	Wed, 23 Apr 2025 10:15:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxah55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFeAM13697438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03AE20063;
	Wed, 23 Apr 2025 10:15:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4336C20049;
	Wed, 23 Apr 2025 10:15:40 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:40 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 08/25] s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
Date: Wed, 23 Apr 2025 12:15:17 +0200
Message-ID: <20250423101535.143137-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h6c5WprYz49wXElULsJVFwkfKRFySvdX
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808bdd1 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=sYXt4NxlOlHJ86jwmuIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfXy4YO3MMcW1mU S03NkjEs3hfkR1y0tFWWIxSaByBbijA15mWTOGgzSJX7dD3IRg2LjoK8+FArxqn0IJ9+fDoQAIz i35Yyitz/OOd52lJkRTtcsrq2AjcVaBOENFC7I2Mc69htgw+HSIp/aDWXrnZEn35axkqE9MwC3U
 g0aARH+VqSzToNrOZTGa2suXNjO2HvmUPwvteA24ZeAOfO6lclZhrXJp7oCb0o04tWCiMqEoYMD FKxXiaef6DBfgZZVCo6GLB2sUyKNV5TXhK3pjye+Ad3evOeAbToRFAFnzWtfIbQqoIzNHFc4GX8 ihHUAZeSbPCqFVI9qk3/ezJBFAoEcypNX2qyobmw2Pymd9tH4c4uexZMY2QoJRxMvidlSE8Hy4k
 LCkLowrUT8PIewtXdhTwehyxbOAUrDy8tltHOSY62YHXFzIVhKVJ2pM5yi5gtO3KjggND8hu
X-Proofpoint-ORIG-GUID: h6c5WprYz49wXElULsJVFwkfKRFySvdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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
index 0ee86ca47aab..8b66c0d81c74 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1304,19 +1304,25 @@ static void zcrypt_device_status_mask(struct zcrypt_device_status *devstatus)
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
@@ -1622,7 +1628,9 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
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
index 4bad4c68c9c0..2ae62757c562 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1806,7 +1806,10 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
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
@@ -1913,7 +1916,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc = 0;
+	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 
 	/* fetch status of all crypto cards */
@@ -1922,13 +1925,16 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
@@ -1993,6 +1999,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 8b37b045fd92..c0eb39b55904 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1598,7 +1598,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, rc = -ENOMEM;
+	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
@@ -1608,13 +1608,16 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
@@ -1668,6 +1671,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
-- 
2.43.0

