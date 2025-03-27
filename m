Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457C214A98
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086400; cv=none; b=nspVNDuZQlCiZqHFlk0hIBJNQuxDmvmw+MhwEb0wFCPs5iJG/7rgcJF7ofSB8iy/kASmnquUMZGnPC9a//Ean2j3flCEnmRLhmftlXYo98W7sDl+gUgmO6oUllFPiHODXLhQHIiHPKtgU/RJhb1fmICCYyUq9Vi7ghTdCJtARMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086400; c=relaxed/simple;
	bh=2SqdpWmZfX685bZn437bR9W+JCOMJU3T9OCtSVb8H50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=socF0uQ9KpyQTk9LLK5JElohXbXMgDzux7dLTYEPb7dCXWfWdHepUouSAuo9EEf2QcrcjDLfFqfnesDQqQm1Zm7xl0V8tVnRwI/zosJyxMP1i2SPmhSc1nJye4xkcFYfOr6IIPBNyWqUFfCxK2/oeRq1aom92N7lNDEMnsJcg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jU3EF8Hz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jU3EF8Hz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE389G008027;
	Thu, 27 Mar 2025 14:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+GzsjNNJZmXJT/Lfx
	s/WqV7J8Xg3iLLxeidf7sB/F8w=; b=jU3EF8Hz9HyfUJOAQ4PQm45RBKXdft/Z4
	2e103zQlGAcZzm1CySXiQcnqmIZpsoxyvL55BEU3ZFz7NXRiKwLPywjI+2GOEyGr
	EQN7n1ZjtQvgIian9ftXcXvkm6kKLIFHwRMuHvR6zEX2PXVxPaBu9St15FzRKhGa
	2geq96fb6UBbKvAWut2Cnci+FI1NQjL1tXfPuwvTuQEIjUEg3eNS1NU2JkCmfaP2
	P6mYN90HAoOTw3ti9WkO4UnSbo7N0R5ms8XT+ufe7FToTCSHudYbBSfZoTdU7wIu
	5G4Z98/ScN7bRE4r4MPpvEDsoCY40tUEvTpK8zfX5DTckI3WIDXnA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83p878m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBPC5w020105;
	Thu, 27 Mar 2025 14:39:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp5rf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdpbF32506228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27EBE20043;
	Thu, 27 Mar 2025 14:39:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C207B2004E;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:50 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 16/21] s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
Date: Thu, 27 Mar 2025 15:39:36 +0100
Message-ID: <20250327143941.45507-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p0SsrZERRZtjxUgAgXyGjwmLkWC6o0AX
X-Proofpoint-ORIG-GUID: p0SsrZERRZtjxUgAgXyGjwmLkWC6o0AX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=972 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Locate the relative small struct ep11_domain_query_info variable
onto the stack instead of kmalloc()/kfree().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 8f93c54c238c..fa9e52287886 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -703,36 +703,31 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
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

