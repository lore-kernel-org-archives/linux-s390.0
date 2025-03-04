Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF92853F1
	for <linux-s390@vger.kernel.org>; Tue,  4 Mar 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108890; cv=none; b=ot+7o9YR24H8SnoO8kyo0Kk5Wydf9lT60T8C430ZvaVIUaG6+v2OlIaxCD8vK02+EcdZCgOixX96e8ktuNWm2zR1DYPnPsGWc/GYeo+DM9C30SIJasJIXu/6F1h8ieiTuBN1MnpzqjhTz+58oxjCLZwD3xqhtSte71j+8VQAnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108890; c=relaxed/simple;
	bh=HJky8kPIfYCJ3cOU05ulkvblgacBsoVEh/xMlA1Q1Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyJ5jgkEFHaED4Adujyqmu3X/9Q/4yp8aDg600d9ltaefXwMb9aLIFSzmFThY2PSrmMqR3z6/Bvt7c8+58z7ktVVfYWNxroTx4ZTl7AWsqp+fcDb28apHKgcIRZuwpzh6C+vm6fb5iPQ/wcTw9FWGcr8ygxi7Mr0nRd6FGr0J4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M073cy3R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M073cy3R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524F6cLR021865;
	Tue, 4 Mar 2025 17:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VdsS7OOUHSyelCVVW
	vcvXA72Kbiwtt0JymfFREotTDY=; b=M073cy3RurE26pgozB17eKse4brwhLlws
	LUVWX9sDprRzUPfy5Vdqe4fxfnUbKnAtgup4myhhBlDCVJgOACWQ6UsfbMw9k0dv
	aQ+XtwhCu3h/0w9/9tqyDxj/2Ogn2ltPJ26iQQUHEvfh/DGUW/su6n9xe8ppBz35
	nw1Xzm9jY2G6QwVacftNlC5tTlrmZ65rtvHAnWdKr53vKEwd9EXA5SzZ7MUyOsJm
	9iXTlnct9MGqdJiejTXzZ6AHsRGpJsikkONeoICPfsnOuCZrqHMtt8kbNHkRre6t
	CYwpZQE8iGy+Cf9qPdAw9T658hvAyQ9m7XKt+yb+5KdfvLEgOr0DQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7kugy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524F0TN8008934;
	Tue, 4 Mar 2025 17:21:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyenr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:21:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HLLhI29491732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:21:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CCDA20040;
	Tue,  4 Mar 2025 17:21:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01A52004B;
	Tue,  4 Mar 2025 17:21:20 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.1.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 17:21:20 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v2 07/20] s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
Date: Tue,  4 Mar 2025 18:21:03 +0100
Message-ID: <20250304172116.85374-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304172116.85374-1-freude@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7LwLlaFk9ZFhRKn8PDWNZ3qwRDUGcFH9
X-Proofpoint-GUID: 7LwLlaFk9ZFhRKn8PDWNZ3qwRDUGcFH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040136

Rework the existing function zcrypt_device_status_mask_ext():
* Add two new parameters to provide upper limits for
  cards and queues. The existing implementation needed an
  array of 256 * 256 * 4 = 256 KB which is really huge. The
  reworked function is more flexible in the sense that the
  caller can decide the upper limit for cards and domains to
  be stored into the status array. So for example a caller may
  decide to only query for cards 0...127 and queues 0...127
  and thus only an array of size 128 * 128 * 4 = 64 KB is needed.
* Instead of void the reworked function now returns an int.
  The currently only way to have the function return != 0
  is by providing card or domains limits beyond 256.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      | 20 +++++++++++++++-----
 drivers/s390/crypto/zcrypt_api.h      |  3 ++-
 drivers/s390/crypto/zcrypt_ccamisc.c  | 22 +++++++++++++++++-----
 drivers/s390/crypto/zcrypt_ep11misc.c | 14 ++++++++++----
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 62cc05881b13..bd2738e3792a 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1317,19 +1317,25 @@ static void zcrypt_device_status_mask(struct zcrypt_device_status *devstatus)
 	spin_unlock(&zcrypt_list_lock);
 }
 
-void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
+int zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus,
+				  int maxcard, int maxqueue)
 {
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	struct zcrypt_device_status_ext *stat;
 	int card, queue;
 
+	if (maxcard > MAX_ZDEV_CARDIDS_EXT || maxqueue > MAX_ZDEV_DOMAINS_EXT)
+		return -EINVAL;
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
@@ -1337,6 +1343,8 @@ void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
 		}
 	}
 	spin_unlock(&zcrypt_list_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL(zcrypt_device_status_mask_ext);
 
@@ -1635,9 +1643,11 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					 GFP_KERNEL);
 		if (!device_status)
 			return -ENOMEM;
-		zcrypt_device_status_mask_ext(device_status);
-		if (copy_to_user((char __user *)arg, device_status,
-				 total_size))
+		rc = zcrypt_device_status_mask_ext(device_status,
+						   MAX_ZDEV_CARDIDS_EXT,
+						   MAX_ZDEV_DOMAINS_EXT);
+		if (!rc && copy_to_user((char __user *)arg, device_status,
+					total_size))
 			rc = -EFAULT;
 		kvfree(device_status);
 		return rc;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 25a339ef52c3..3b57e7437f3d 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -178,7 +178,8 @@ int zcrypt_api_init(void);
 void zcrypt_api_exit(void);
 long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
 long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
-void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
+int zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus,
+				  int maxcard, int maxqueue);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 2c2ca2d67e2d..420895df70f0 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1807,7 +1807,12 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	rc = zcrypt_device_status_mask_ext(device_status,
+					   MAX_ZDEV_CARDIDS_EXT,
+					   MAX_ZDEV_DOMAINS_EXT);
+	if (rc)
+		goto out;
 
 	/* walk through all crypto cards */
 	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
@@ -1875,6 +1880,7 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
 		rc = -ENODEV;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
@@ -1914,7 +1920,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, curmatch, oldmatch, rc = 0;
+	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 
 	/* fetch status of all crypto cards */
@@ -1923,13 +1929,18 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	rc = zcrypt_device_status_mask_ext(device_status,
+					   MAX_ZDEV_CARDIDS_EXT,
+					   MAX_ZDEV_DOMAINS_EXT);
+	if (rc)
+		goto out;
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
 	if (!_apqns) {
-		kvfree(device_status);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	/* walk through all the crypto apqnss */
@@ -1994,6 +2005,7 @@ int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 86578a95b140..df16294eff9e 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1603,7 +1603,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 {
 	struct zcrypt_device_status_ext *device_status;
 	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, rc = -ENOMEM;
+	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
@@ -1613,13 +1613,18 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				 GFP_KERNEL);
 	if (!device_status)
 		return -ENOMEM;
-	zcrypt_device_status_mask_ext(device_status);
+
+	rc = zcrypt_device_status_mask_ext(device_status,
+					   MAX_ZDEV_CARDIDS_EXT,
+					   MAX_ZDEV_DOMAINS_EXT);
+	if (rc)
+		goto out;
 
 	/* allocate 1k space for up to 256 apqns */
 	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
 	if (!_apqns) {
-		kvfree(device_status);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out;
 	}
 
 	/* walk through all the crypto apqnss */
@@ -1673,6 +1678,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		rc = 0;
 	}
 
+out:
 	kvfree(device_status);
 	return rc;
 }
-- 
2.43.0

