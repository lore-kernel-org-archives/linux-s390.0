Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD412036FF
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304514; cv=none; b=kpm3M+1Gajiu3WW1U3E1mZYfgQ2sBIGKZMmgGnE/2RmVf8e8IJHOFoed3qDwSYJOK/NVnE3ZAIUD1UHQ3ch9B6cde9UHEuzdFf0Laxb15i0d5vixnsow51gthh5PmW8otIcV5SEP8pn9I0OqZchhYdfIP/BJkQKv/0OPO4WQpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304514; c=relaxed/simple;
	bh=pkpL1GBmkOytjXVFVFGl4V8VBQ44QS6Bw48lT3AxwVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhlOIuwvF5tpgvXEXo/8me3ut7SnuueWvmEbq2i4w0Oc+SBHgQsTKFBgEc12aguX5XDSQzQOQtap5mPE9hCGugRYkelec6r+OOUQ8SsXpzOl2JX/4Dk4TfpfDNMh4gqtVj4T0RMUZaWrgqfN139RRAO/yuCwSzq49M46SkEe/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JcfzAJaz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JcfzAJaz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6PvYE009609;
	Sun, 23 Feb 2025 09:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IHN15LSB9HSHyU3gU
	Xto9bB39124oXadnrzb4iUTPrU=; b=JcfzAJazSQkHL7Qpurt2UIHRoHlFvPrQ7
	dqpSZzChFJL4zX/d1OaKEHpEjZRJHGWHEyKRZ10YyWOwQHZkKMeHkTOvx50ifC6Z
	NAQEhz+lFEY08ui1PB3iyKvWze8qi+ATbLvCV93iC3rMpUq2HY8j88KgPPXCJ6bO
	INI8/vgZcyJkOwZOuw1PBVAglUnK49ZJsjOHfeF+ZcYSfJ0dtKwjLn087mXcgU84
	SPOZachKOuwVAcKLReDp65W0odCXIDE02X6deb9LdQVkL+yPRqEc4/swxw6E3YTd
	dReR5+HVlaYND/HXKSI4yT8vrIAwsgv4YJo1B02al3SZqbSAjM8CQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gjfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6M5wD026961;
	Sun, 23 Feb 2025 09:55:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk1kyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t5HP42140062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EE5220040;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F08A2004B;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 14/20] s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of kmalloc
Date: Sun, 23 Feb 2025 10:54:53 +0100
Message-ID: <20250223095459.43058-15-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: svFswFsNo0RKtuRl23-5eIqkolVmnjVL
X-Proofpoint-GUID: svFswFsNo0RKtuRl23-5eIqkolVmnjVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=946
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Locate the relative small struct ep11_domain_query_info variable
onto the stack instead of kmalloc()/kfree().

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 09b5ab0d7174..ef5f69bda6c2 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -791,36 +791,31 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
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

