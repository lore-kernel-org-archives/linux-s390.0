Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D41FFC5E
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403354; cv=none; b=m8vQw2KX7JfAxYz3bqrbGX0nlVGiSuGuKK4EWLNLId/NWQTB32QICMwPPyKTUCQvyeHpvkOndRJ9o6d2yRShI9P2zDPrRB26nAtXQcCMAWUMTiDTq9skDtkEWQFWFvPV4dHy5Pke5E+vErcT+xJM+nu6edkRdWwGu9LYBTp6l2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403354; c=relaxed/simple;
	bh=/22fEDRMRpcUpjcq2BYMNVcUVt+yqmzD5/TRToHN1sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZt7kJZ62GOruR+W1ovSxvTmpkLNVRxI/57zstkgCHWFjv1OyDA9i0P+VyNAWtPPNxm0+kuzBYOCIgH/gk47eZKFdb9oVPem9vx2TAmEhyXhGxFRSfBEOcR3RcDX7uLjjTgNR2KKBNT9r/qa/AppUEGymjZL3qUFMykivR/83h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mpbh/Yn5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mpbh/Yn5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fkxl024575;
	Wed, 23 Apr 2025 10:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3A1p6wOxw3o9IFGPZ
	KdncELfwKUk1IdlzaVwuV9fbAM=; b=mpbh/Yn5mReS9tyNKnUz1BeuhmBvQBjQY
	/XbDqVn7l07iADREZR9J+ruiPtx760zuKUd3xp6SMrSK51T97p1MCc/rut/fipmF
	PSva8+KYshUyheZwXjmNBD5/qJU9ll3N8535/JUW4J14J8/UZKYcxONo7dobqJu2
	l3HcXsBCJQEOKnsAzqEa3pl2YZewGRF+4COcbQxlTq/m44UaNoTar9nvXcHkV7aF
	CA4+7DA5o+Q51HpWXBNH84P/vuzw7zW8yMpAI2PKy/rXt1s4KrN+VD45E+dUy8W/
	satWXSevx5Bdsdf+0MeYxVWwg9huXuTt++iMjmJ6S6keDfz8aqE3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466k77jkw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6dDVe008608;
	Wed, 23 Apr 2025 10:15:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxjhc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFk9f54591822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A852004D;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8D520049;
	Wed, 23 Apr 2025 10:15:45 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:45 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 17/25] s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
Date: Wed, 23 Apr 2025 12:15:26 +0200
Message-ID: <20250423101535.143137-18-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vpVObq5ywMDzqEH2XnqhLFETFHYaAWp8
X-Authority-Analysis: v=2.4 cv=TNdFS0la c=1 sm=1 tr=0 ts=6808bdd6 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=Rt_IQ_Eltt8tSNyM_tYA:9
X-Proofpoint-GUID: vpVObq5ywMDzqEH2XnqhLFETFHYaAWp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfXycj4p5Q33vo8 jrkBvw6gpDs5So5wb2derbTQiT7cbok7+bUH0x2jfgWx0K2B9IUYibbjba+CDRGYnCu2MoXxHVK WPOZR2nMaIL/AJCajPJLlTcs0j4faRlpeal624EvTptl/WoH6ImfD4ok+cKMj9Gc/JQACgdNTDO
 y6RGYYLSqPWS04hdswC2WJzHQJOWzifOGeLlk/tMuCvOsRUSbNlHOKnj22cg5Jae5cWVrqLreJC hUjGiD54oz8EXgrQE+ladQekKBTxO5mUZJJzdJtIe7+0qWY1a65IgJGEjLH2djcZrCWD3fuIylw D4qb/C9la9yayS0aCQ/mPUYFMSqkDpo/0ipK18bC87G2+KWuRGxBZLusQo2yoLOoLYcylAncUNe
 dfAPAt69Ul7l0f42/CYaIXULIP+tOCp5ELkR6SL0zltpsEzc8UAWfnDSiT0396ZoiPnA4UvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=950 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

