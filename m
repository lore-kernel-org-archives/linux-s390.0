Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940A1581E1
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501795; cv=none; b=CNGlalySA6X+JCVUddO0ixiw/mjfmog7y+1V5aZuFDyisd0rcV1y+GWltx/nb9q67+lPd+/13F5MJiFG0c30lDDunKUEs54JIagzcvGE5OwCC8wZme8i4Lx5maM3eKDPNcDAag4HV+AQvj70XzF60Xzy+M3Amt7p7AF9SV3/Jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501795; c=relaxed/simple;
	bh=Pqf6RVnfL+yJtsUXx0EEoklL0vAtDo3ONwiWY2fnr3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCvfh1Lo5mqXj5ofGZLL63wn1m2TjVcA3DVSZX7AsLQh75OlurOu8Kepl68qkSPbtvrc78hX7foE+ClLMBnQ8EXopyNBGkGS3Dj6WYJm71yn0fMn2BsXeqMtCGA6IfBED3BkWGxYTqeXdJbWkxxCkoDUtybGuo0vd89naaHPXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d3qmG47V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d3qmG47V"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9EtnD007445;
	Thu, 24 Apr 2025 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=34SaLMRRNnrXFwrWa
	zIxq8Urq17n3C/MV+NwobTcXGM=; b=d3qmG47VbYgzQe6aZnK2FWaYo/zkdByEY
	bCjzSZDPR/PbFq8LP35C5nrvNRWiH5DPiewBbwuB2+OCNtvOFHldSlQVTtoICgUV
	YuMaEgL5P5md1rxdpWfdNbt5KmyqmEknY5RGk0yvuve2SM78vyLEO//Kb7p8ucXJ
	BhGCvneB2ZbgSqhZSooEMfh85ZTS0Lxgw8ciQ01RBjQnzNqkkpYMgvcfnPZ/8SBH
	looqHAZv0Cl43/tIlp0KejOGm1wEisGDRRNfJ2lYuyRGGGq/4y+FeW0vLoi+dfqh
	MiiMalZoXXX/Xrl16MS8t5XgPf/TaoeFmmy3prGzHuC9w7K6WN0mQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60u8wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBSPSX005829;
	Thu, 24 Apr 2025 13:36:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxgd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaOm256492344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1869920043;
	Thu, 24 Apr 2025 13:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD91A2004D;
	Thu, 24 Apr 2025 13:36:23 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 08/25] s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
Date: Thu, 24 Apr 2025 15:36:02 +0200
Message-ID: <20250424133619.16495-9-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=680a3e5c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=sYXt4NxlOlHJ86jwmuIA:9
X-Proofpoint-GUID: QE_i6acNJ-DdKBT0adktixv73n6kjZOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4OCBTYWx0ZWRfXyKgPXPnQ47Zb D4j8lM8ogGzh1ZE//QFOszkIbFnUYsmRV6Y4qLdOmmHuCV6pHdJy94EDsH/SW7bMiRk2Ts63bcc /CPU1kFVB3IcbYCYLvO+mj0FQ/bss9b5LKt7DbZNPf05sUoG75Gvpu2MsDLXPvc6rwJIOZPBtv2
 pYvKpvFHlsx3EORAeWzdFAYHaSWj3jkhi8BUktOwsmgVzfB0JufWXHT/AY7p7tMicbtsC+tqwWa 72oJtVXqd8Zx/trvNZwqLwYVH+TA83MIrSm3Nu2wlPJMyCSpEK70yYeG/i4iiPzfrnGOzstwP1o oIFHZeKywF8U6Z2rljwlNZ6eRknmUcto+tbxZy7T/RgV/ml00vme6HAf9R93/5eNYgaAbPz3XdO
 m8ARtUwSvlVKMgGglet4RRjW/SOTs8Q4FsfD0gp9IOWLGN0gHRAvjC43chNBvuhjwRNGajfB
X-Proofpoint-ORIG-GUID: QE_i6acNJ-DdKBT0adktixv73n6kjZOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240088

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
index 88bf719b4c58..89baa87a13fc 100644
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
index d51ab5a0c58f..bbc804d632a4 100644
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
index 048582851f25..af6582a6ca48 100644
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

