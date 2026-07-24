Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3A2F6596
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888039; cv=none; b=LtqAy6HV/aI/5gC5fE8qAaVM/Poll5loQed0UlVdy9Mf9/g2J+tCYQoqBskC+MIUl7w3ORPa81G8VdbnTbKJfpKtVwfRBPRtTDodbm+OJ7rSaAiWC8tzivqdSSjE4llkagrfUBaQnu/lQwtxFnbbgfUNp9acNt0Db3T/Im4sWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888039; c=relaxed/simple;
	bh=2W9zG3KSqAZYDl1Sgx1rJOdOg52/UVrC2pQYj/Cw25k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP0Smss0vpQhtuW5cULUy0/dqn2HEpStAfDR7+uLRdWWjASQwtq/uU0dRkBAjoQEdektsZfGOhcvnD5tnOXMB/M1sac0lMB3s9s6L/+U8yA/77xDc86fcsCwoG8jmpa0DgHGLchs4j/a6D7SmC/mOa42oaNdYsMUJBlwxRLclj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5uecGac; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5uecGac"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADSvm1532556
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZUmM4OSsrekD44ws7
	v5QAyUXDoJagxf7eaa+QCZotb8=; b=g5uecGacGSH2EgSBzyqvk5PCvamvGZG4p
	0pgsMS4ysIL20Uk5vBEHWoObJEjyQeh0LMx/bVEylVbvXzy63nqsuNiVlPmsM+b9
	jV2W5Ft88mnbzDehCKa4jQgHKUCPa1XnX9DW+y42dMp5V5ja+l+FUy+7MSQ6USQi
	KceViWHtjQpdcl/dLgMfpFA1PaifVFPqos7kuqI5ozA4IiYmpqtjlhBBKDdYCLVL
	dYB3g98qzJMsKboSN4O2kGJRQg2+Jq901SUOQlT/jtFzXaS15Np1EXh4MdDo6HIW
	gJ5p5fZBnjOkid1Mkm3tDByk00gFNjCLHSIEJPH3mMmOSlPi5jIiw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abv6re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4acJ022588
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wggyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OADoOo47055320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:13:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB2E2025F;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DBA02025D;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Fri, 24 Jul 2026 11:51:28 +0200
Message-ID: <20260724095128.140810-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724095128.140810-1-freude@linux.ibm.com>
References: <20260724095128.140810-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX177PK3TMTznB
 Agz84lIhTtw/aiJHGSO6JQviK7NGX0/FiZ4f7Pd4hfLGR5tRXviORcvXbUetoYSd5p2Ux9ClSZx
 T3EHCL/B8f8a8EdXS8OnzJv8VU1mAInbmTnjMuggFviJKKrB2bJcTUnBklRv1KU5kN9NCRqADiq
 tG8vo1OxWl/xOxpDkHPXAChJgB/3HmP6czrd1BkAib7IVW54EDXsKT3uO/nZzu2aRoVeAUM8pDE
 6+ekpU8iBvTPqGu31PjiDia2s7WpdpVDcpAGVYxnthARoo0FDBIwuQYtylHFCVkYyXebtQ3pNd8
 xftSc3SQLV4HbbIaE5OnGuclFEqQaF+5WQdND42xFZkLpsRH3/ciDGFQqfkQD23ifP0OMRRkjDb
 yNBQOeiFDKGsxH+OpwSOwC8jSt62CX/LcidNouawrLYW9cvWKv+by+nplC3fktKTGZQPi01qOyE
 8papxSNWWP/bWPiPj8w==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a633ae5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yrkiJltxsN2MUqc3cT0A:9
X-Proofpoint-ORIG-GUID: SoqzeGPYKrvu1VBXDh2rmDd6CfmRTPYt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX8iRSCL90WGRf
 3Rca0skWKmO4ftUOPf5iVo2xIeECyU/J6seINxrnZCZeNAKNIJXrIwFJQ65hoQTliBBRfzvUodR
 eYz1rKadmZv5+Oa0ACPQ8BVVAd2X69k=
X-Proofpoint-GUID: SoqzeGPYKrvu1VBXDh2rmDd6CfmRTPYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Integer overflow after CEIL4 alignment: Signed int variables could
   overflow during 4-byte boundary alignment, causing undersized
   buffer allocations or incorrect bounds checking.
2. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
3. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, and validating minimum request size and
minimum reply size before copying from userspace.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 4ac767661cb5..3b56b7745588 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -474,16 +474,24 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 		unsigned int	dom_val;	/* domain id	   */
 	} __packed * payload_hdr = NULL;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_len, rep_len;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) + 2 * sizeof(unsigned char))
+		return -EINVAL;
+	req_len = CEIL4(xcrb->req_len);
+	if (req_len > U32_MAX)
+		return -EINVAL;
+	ap_msg->len = sizeof(struct type6_hdr) + req_len;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
 
-	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
-		return -EINVAL; /* overflow after alignment*/
+	/* reply length and overflow checks */
+	if (xcrb->resp_len < sizeof(struct ep11_cprb))
+		return -EINVAL;
+	rep_len = CEIL4(xcrb->resp_len);
+	if (rep_len > U32_MAX)
+		return -EINVAL;
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
-- 
2.43.0

