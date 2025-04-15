Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544ED1A0712
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727091; cv=none; b=ttR55LJX62ZLAWQLiP6Cu0oXfy2c5mQ0477H2InFHQIAjb2mMoXibyChdMBbyEb+yDif0/5ugM639FkAah/QTAEHK2gJa7VMZotnZU48bCbkTOZGxsTc25a2L5PEyVGcMkr5OYot0LkQpFxQ1kBl0msbBHuGTCDLyGPRVQjLRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727091; c=relaxed/simple;
	bh=TjYyemav/Ks6EUbs6i0MzVvB+063NCeWdj9kjEX5o4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cak9EkZUpfyO8it8k1vS9SSOQCOUIRqv8AuwZ8UA46FCJ+Dq4VLN59BO/ondkDW649FhYufbdy14h9FfWWC/HnNFgkjJwhSBzilFGJwqTBuaw2kWiD8bmwece8HDVdWAvY3r58YucVzkreYUWaCHyHtRsvQ4KTGdckkMD+Cswfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qDLctNEA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qDLctNEA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FA40FK021063;
	Tue, 15 Apr 2025 14:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1fbaBh9R9Ox/4IEwX
	ZgSxc0at3k7gohQHQiArXPQDds=; b=qDLctNEAl9are/+XjKok926lg6V/aNVWK
	oJO5lk6Vxm6Rselm/uw0uYY5dZvEFVdAcCtI+BSt8tS6MkTnBa7k+S021Zw0l/gz
	VirNMmvnThSFoN4Y5xyXYYCRrUFjQ8uUKyT9kA0bzTZtgmA7BU+EBMZzEIkZ/WUt
	gQBF7Nvero4YMmDk56QjlVMINRfRyQo/Tzl3CzMfQBb0OnDJQYbHZ+cqMIZnxvKt
	JrwRgLLXQjBT2G7Sp5Ooab6YfNLQYBA28WkvDBRcn7I6S9M/lY5PHp68ds3Kf+rX
	hqHOAT6+LD4j9DqCjeHpASngogpwq3H5TWQHFv4ZLGto4Z3hW39sQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ncfhaj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FDBaax001255;
	Tue, 15 Apr 2025 14:24:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyuptu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOhrN34538182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F017E20043;
	Tue, 15 Apr 2025 14:24:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08F42004E;
	Tue, 15 Apr 2025 14:24:42 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:42 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 08/25] s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
Date: Tue, 15 Apr 2025 16:24:21 +0200
Message-ID: <20250415142438.118474-9-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: KxwNQyYPiJihySzt0_f7DNOG1P0Rd764
X-Proofpoint-GUID: KxwNQyYPiJihySzt0_f7DNOG1P0Rd764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

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
index 7c53fa04ab8e..849921ce83fa 100644
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
index 59a7daf3aebf..3162b186ea44 100644
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
index 3befb7f56fa6..f10ea66b691e 100644
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

