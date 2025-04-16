Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45A2192FA
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811901; cv=none; b=uF8z7OZTcjYubtYh3ys7CnkWPGESdf1ehrZvfPZu4DPgm4ddmokVGOGVudDS09KgD3v7Rooqu5DbK86w67AwSkIQLrbf1W/PUBQS+t2AzVf0dKmPg8ZJobKQmrOV2w2guSQFdU/ct8RMFqaHffgpCe4KksS6AgOK7Fev/ev3qR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811901; c=relaxed/simple;
	bh=/22fEDRMRpcUpjcq2BYMNVcUVt+yqmzD5/TRToHN1sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUaZVR7LbBog8wHIgPSfW72gXBAacCtz014Ib0gCzWfyq8yj22QWSvOKVci/P552V8SpmAf7xfCWcW3sdpQLaYnHhLW7Uy94uW7X4g4kb0cfiISAjLCIoLRlxFXd9uygSkr8ztziylFArkpD72MiYN5KL2UZxlD1L6asNLgphoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvX19OHh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvX19OHh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8xvWH028308;
	Wed, 16 Apr 2025 13:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3A1p6wOxw3o9IFGPZ
	KdncELfwKUk1IdlzaVwuV9fbAM=; b=RvX19OHhR+ymyo/pzhLmOAWzy62nkfDHm
	2DjdNyUmMcpZBtIh/XUHpyoWjXKOA1B6LIzMQfgi5XjA8VPBMXKHGby+jAXNoYRm
	g0h6o2iIcRhzuy+snWelT7O0mXAjjubahe2SDRIUCO9Ht1Qt17/2w5J3Df9xuSeM
	y1E4TCSRFJBkiXztwT+keFFIX58OVxL4GaHb9GrlUc/4SzSTQ3G/4uxJ41ZohVaw
	QrS/FpB/rYOIktP2NbSPFcZ5e03GX/4OCaZLXZFNnR3d5qdXh0kgC1oLWID/uMrd
	tdpEEh6RkQSJDcHKNjjTuIKYHr32hjYisn1woO4bfXGTrPCYlIsrA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxbg55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GAGMOW031061;
	Wed, 16 Apr 2025 13:58:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnrncd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDwChH25493788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09222004E;
	Wed, 16 Apr 2025 13:58:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BB5220043;
	Wed, 16 Apr 2025 13:58:12 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:12 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 17/25] s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
Date: Wed, 16 Apr 2025 15:57:52 +0200
Message-ID: <20250416135801.133909-18-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zohYny7qrVfTfkVAkzJ9B6sKxSi-nuXQ
X-Proofpoint-GUID: zohYny7qrVfTfkVAkzJ9B6sKxSi-nuXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=956 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160111

Locate the relative small struct ep11_domain_query_info variable
onto the stack instead of kmalloc()/kfree().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 57471abac778..b4c97cf25fa9 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -702,36 +702,31 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
 		u8  new_WK_VP[32];
 		u32 dom_flags;
 		u64 op_mode;
-	} __packed * p_dom_info;
-
-	p_dom_info = kmalloc(sizeof(*p_dom_info), GFP_KERNEL);
-	if (!p_dom_info)
-		return -ENOMEM;
+	} __packed dom_query_info;
 
 	rc = ep11_query_info(card, domain, 0x03 /* domain info query */,
-			     sizeof(*p_dom_info), (u8 *)p_dom_info);
+			     sizeof(dom_query_info), (u8 *)&dom_query_info);
 	if (rc)
 		goto out;
 
 	memset(info, 0, sizeof(*info));
 	info->cur_wk_state = '0';
 	info->new_wk_state = '0';
-	if (p_dom_info->dom_flags & 0x10 /* left imprint mode */) {
-		if (p_dom_info->dom_flags & 0x02 /* cur wk valid */) {
+	if (dom_query_info.dom_flags & 0x10 /* left imprint mode */) {
+		if (dom_query_info.dom_flags & 0x02 /* cur wk valid */) {
 			info->cur_wk_state = '1';
-			memcpy(info->cur_wkvp, p_dom_info->cur_WK_VP, 32);
+			memcpy(info->cur_wkvp, dom_query_info.cur_WK_VP, 32);
 		}
-		if (p_dom_info->dom_flags & 0x04 || /* new wk present */
-		    p_dom_info->dom_flags & 0x08 /* new wk committed */) {
+		if (dom_query_info.dom_flags & 0x04 || /* new wk present */
+		    dom_query_info.dom_flags & 0x08 /* new wk committed */) {
 			info->new_wk_state =
-				p_dom_info->dom_flags & 0x08 ? '2' : '1';
-			memcpy(info->new_wkvp, p_dom_info->new_WK_VP, 32);
+				dom_query_info.dom_flags & 0x08 ? '2' : '1';
+			memcpy(info->new_wkvp, dom_query_info.new_WK_VP, 32);
 		}
 	}
-	info->op_mode = p_dom_info->op_mode;
+	info->op_mode = dom_query_info.op_mode;
 
 out:
-	kfree(p_dom_info);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_get_domain_info);
-- 
2.43.0

