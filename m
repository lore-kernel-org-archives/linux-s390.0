Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA6849C
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501806; cv=none; b=JkhBlcuZQgPR06VwzrvA2yXIbzgTDPlQEEv3tmXjIuO6W10EDf5hSOxFQp6qeU5R9Op44dCb0n71+C+5cCCcNS/qQGH7okTltYr2RlwsE54/ASuSDxuxUGDhk33v+MFDl80OgvR4EOWcVWMTjs/90f/YmeDL0zsvwb9VJtEoaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501806; c=relaxed/simple;
	bh=K2LM1mEOsbJjSbE297OXJ+YiNBMBt3FcmTEBOgF8Ypg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jkfd1gnUFUuEYL4m1raqA0fUcGfNQxZkyXv6dTD+heevmkaowa6H7T+i60SGIQmU87ClS3dsC4yyilTCSxmgW6L1Lr/pt4mNZu3m8ZHCbIw3rT6nF2AYZObcwB9pVnbtmfa1rBScgmwUa+n3lyFwxYHQdbjSeuZZvkOSm/IpXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmRV4xt1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmRV4xt1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA45bn001042;
	Thu, 24 Apr 2025 13:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9CVGO0ifVHmbo/2OI
	CyBR7Kcaz8Vnf9DKRj3607AbBU=; b=gmRV4xt1fzABBSxPfRHwf2xezXoMP4oZ1
	H63DtH+sOSwFv2+DHrkJ27q5raqXOmzknFYRRGdi3E+aKulPV5TRiMAfX8QTokJV
	KqEVhvUyLz7rj+ndKrlJhz9rutt+r4SMR2bt/il3kYwdx5GEldf1Zf79gOtbTo0x
	03rcn6o5PH5rtolIcy0QQHGqkBRl0LKPzXxKpcF/GLuL/xTDhQ8MSUc/+4Qr6Jfp
	vUC5cNYIalUxVN8mJDM+2ekQidQJtfS+h0MeEOS4y1nMgI/L4osJrbqZMGFu3dHF
	TvHhZhGFWbqCXMftlHoPEp3hoXPod0IxftiR1qa4sdj0V1V9OkYoA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k10he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBdVu3001305;
	Thu, 24 Apr 2025 13:36:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy0cuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaS1455640548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639AA20043;
	Thu, 24 Apr 2025 13:36:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8592004F;
	Thu, 24 Apr 2025 13:36:28 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 17/25] s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
Date: Thu, 24 Apr 2025 15:36:11 +0200
Message-ID: <20250424133619.16495-18-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QNuDDZs7TwNW1UVpLpLH8VgG-oHC47dv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX6K+uH4QvH52R wvrztDA1nnR1/V1sPvEj/27LIBfLLjGNdj5YAp1Hh2cy1fiPyDNhtCW3Gg04T7QRNbb6ByAoQqN sMgPKeTqOs0b8UymRMo5tWd+E/2VuL1sQW7wgQxewXU6cbSizRe+9kiO/Cl+wMMU+p+hQueAH2L
 LolbESoS+VW0lOIPwzavyA1KrbIFXg5UvFd37eCS/jbzRmGPdhrJrD6b873se+VYzyT3IipfOzt Ak248keJPKBy94MqqcK/+ByXJiTxj7/0VDa1oON3ZeAf0sfhuIJA9jr4dAj5H7XZDLZVnQu7VkW tU9qAV3eYlT8SFomJZRNpHrwEgakxdxt8VE1cmgXeoCbk8uXJcRMC0TcvQwlQb1hHl/xKpTvGH9
 KlMbyCk4b71YT6AYUZMnkmBzIZnyiTHrbvWVZFaCbIKgXX+0t5xYfGHd8B+sdqNHrSRuTQ8Y
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680a3e69 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=Rt_IQ_Eltt8tSNyM_tYA:9
X-Proofpoint-GUID: QNuDDZs7TwNW1UVpLpLH8VgG-oHC47dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=956 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Locate the relative small struct ep11_domain_query_info variable
onto the stack instead of kmalloc()/kfree().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 5bb72ca40105..d8a8afebe211 100644
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

