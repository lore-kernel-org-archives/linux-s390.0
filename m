Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC41A76DE
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403350; cv=none; b=FYH02qSzPRxq72Q4M6mOnSFvYyNemvsEW/u4IfDeM7Ih9iLlFDXCu5a0xRPt6DYxtkUFSn3NT+4uJDmRxL3/JSYyYMPh23eaVmxay+IsyMbEy0VKmZv9JOmvaxEG0O6CBoI+Wp4zMdZ+1sRaE/ElewZMbuAHrkS7NnaRKBWLJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403350; c=relaxed/simple;
	bh=R/wdCvzFYiAIW2oZXqsi6pLAY872HFm+/S7nEKHfdA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+MT6SoKsFwuLUcqi3x3apYrpCwH66g4jeHkfVYe8Kwffs8UmROoNI09k9WX024fNEgQ2s/al+tFG6EM2lF5Bo3kMdE3P1CpLg37AEaNIaNoVV4clD+0TK/5dT8Hj3bfoctIkODf29t5Ygu0gh9kfd9FLgH0DGF7NqflyoIAMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQHiU0Ft; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQHiU0Ft"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fi8Q024360;
	Wed, 23 Apr 2025 10:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S1xsL0hcm2/3xnwnA
	MCzerclq/d6OVE8A5YsaeStE64=; b=dQHiU0Ftg/ppTm3z8JXkfJbDxzjBExTD7
	T0ZqIZ29AGQKbhxTDgPBoVwJrOhJO9opWjc2Ykvv78FNTjWnFGCp/YEQQeillZzH
	fkGn+unF1lMZtcXruAUSjZ9cpnMGET+uFBRruasz/tCEWh+rjfJbH2v0phXW9W6C
	wgbuLPw5UAI96T+wyE/XogxL0jr3k/LzNP364vNC3Tu2P1AVefkBxPUFXF/kCfAW
	6/80ghO5pyOur7tPDTyq4uwg/OEUtushdnUsU8zBSRG2BwvEBKTHWHr3vZ5DZcSY
	E7LO09XJFn13CiLUhFoAYu3fzVss47L0NHVGNEqKF8uTl4xyq0Feg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466k77jkw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6YZ0Y022266;
	Wed, 23 Apr 2025 10:15:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxah59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFgts29294904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79E82004E;
	Wed, 23 Apr 2025 10:15:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6321220049;
	Wed, 23 Apr 2025 10:15:41 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:41 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 10/25] s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
Date: Wed, 23 Apr 2025 12:15:19 +0200
Message-ID: <20250423101535.143137-11-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: iwo5oqs1nNRoGlnuWWDsakjdGFHKDCxr
X-Authority-Analysis: v=2.4 cv=TNdFS0la c=1 sm=1 tr=0 ts=6808bdd2 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=3M2YImFgLaUfd0MdNsQA:9
X-Proofpoint-GUID: iwo5oqs1nNRoGlnuWWDsakjdGFHKDCxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX8h2VuJvSM2Wv Pa/Wl5evO04lbHdEDkzW92G/SwBTQt0K3DaNpC27R/fSv/w+ZnRD39BU7VaVFS6ZkRMWyie3jFg 6mXshUVM4NYCcKlzE850tCsqPDdWeBsSAm2AQAO1NuF0H4mOalN8APowvwP9+Iwf0G1+Km6Scxg
 HNVL9lhEMTpQRI3LMUbuX1yNksLQ3rWOeRPm0GjxeuneQpAaTjakx1pLP6D56WKHhYghlIihjhN bquZpkjP/YNrrhZpidrvvAhcIc69N3PQp2vGzAqc1qIObwdXzzH1aX6QdD3p2g94h3cFcC33EAZ e/ZXSYiGzB285LPGiOceTS2lZqY7iMQn036c3X02uJ81fWlAKUt6JnoeqVwLQiGTu2Q/TqfYPDC
 RWx+L1nHjkLrRBv3SZSbrjBOcaROF8XWtq4TilsExbFBBn1rf9wBM/3pvfW2kV3yEBewbBxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

Introduce a pre-allocated device status array memory together with
a mutex controlling the occupation to be used by the findcard()
function. Limit the device status array to max 128 cards and max
128 domains to reduce the size of this pre-allocated memory to 64 KB.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 46 +++++++++++++++++++++------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index c0eb39b55904..f53b5602c3d4 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -39,6 +39,22 @@ static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 #define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
 static mempool_t *cprb_mempool;
 
+/*
+ * This is a pre-allocated memory for the device status array
+ * used within the ep11_findcard2() function. It is currently
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
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -1602,16 +1618,15 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 
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
@@ -1621,7 +1636,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 	/* walk through all the crypto apqnss */
-	for (i = 0; i < MAX_ZDEV_ENTRIES_EXT; i++) {
+	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
 		dom = AP_QID_QUEUE(device_status[i].qid);
 		/* check online state */
@@ -1672,7 +1687,8 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	}
 
 out:
-	kvfree(device_status);
+	mutex_unlock(&dev_status_mem_mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL(ep11_findcard2);
@@ -1685,11 +1701,21 @@ int __init zcrypt_ep11misc_init(void)
 	if (!cprb_mempool)
 		return -ENOMEM;
 
+	/* Pre-allocate one crypto status card struct used in ep11_findcard2() */
+	dev_status_mem = kvmalloc(ZCRYPT_DEV_STATUS_EXT_SIZE, GFP_KERNEL);
+	if (!dev_status_mem) {
+		mempool_destroy(cprb_mempool);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void zcrypt_ep11misc_exit(void)
 {
 	card_cache_free();
+	mutex_lock(&dev_status_mem_mutex);
+	kvfree(dev_status_mem);
+	mutex_unlock(&dev_status_mem_mutex);
 	mempool_destroy(cprb_mempool);
 }
-- 
2.43.0

