Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3B3FE364
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588947; cv=none; b=bTviXelIaq/4RWC/YY6Ln5gXtn6EvekhfljjMjxLyzjRpYqMmJiBl0tyTVfEEit4IzvbDyPFChIKwcrHRKwtYpVftP0UQg3saLKCoI/b49a+/GuHVQH+1RJUkkBUfQDPUqqSXPPcGiWcb7QYqC7XhGY+CIqLNzmM4liknOQ+qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588947; c=relaxed/simple;
	bh=4DDyGpA62eez2J3Zb/Db7TAbmg/ojMWE1TRAJe+Gc7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmjniwwZbfB9eyHXfFkO+eOtIR0H0OZwpKErE5+gv7Ki2sM33iL9FhdBl6t4e+vkD+8S9qdOsxjvngnb4ZtMIRdRkj2ZeDmL6cTuHjKPCVmHfI+4vUPkqII+nxDU67diK8vrLWCqEp/YUr2RahFOP8LKhZ8WLwaKrF+hEgUUE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGcrHsc9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGcrHsc9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IJvP1154719
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 09:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wQZSewR/RDoitVqoH
	leXlM4ySLFu8OhNDaA+QBULOE8=; b=gGcrHsc9eOtJD2QWeebrAX41Q+Idrw1Xs
	p/YpkX0FTl+o0DpRHepcWeXgOw9d+QgnNDg1GmZtDauS1LEVc59C/4qdENL0f2i1
	ruT+Y8HZWeppnUcndDGvyRHbXXMjry3DkcE2r2JQUR83Uu1IGEPIxp4afi8qpfB8
	MfkCbBqNuWph7BO20XEeBYzNYbrAe8CJTP5efua0l5rS7eSnu/ReSHsG1umD9hU/
	i2E5H4Ce+hz2sc7Yfi3sr7UA7mNEb/wULUq0vg3sA/+ABwg6D3Cb/9dPJDfUYXOs
	46jkcD/R7y8qTcqB83nj6+bz8doi45B+jXexe/zG/AUEFF4lU6yog==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw50yn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 09:22:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699JbWZ005117
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 09:22:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqcp5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 09:22:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699MK3K52101572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:22:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121FD20040;
	Thu,  9 Jul 2026 09:22:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E41E92004E;
	Thu,  9 Jul 2026 09:22:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:22:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, dengler@linux.ibm.com
Subject: [PATCH v3 1/1] s390/zcrypt: Improve zcrypt reply message verification checks
Date: Thu,  9 Jul 2026 11:22:19 +0200
Message-ID: <20260709092219.57356-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709092219.57356-1-freude@linux.ibm.com>
References: <20260709092219.57356-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVzmTqfhqIeJgQ6Bp5GSZDWCUn48Vw4S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX4Gub5eWmTQ+S
 iy/yXJD4FKtHQOytOFa/3pIhUlEnk4PCo4pzsspL6hFfWDY/xCnbkNnRJRePoM5ajf/8HfALKOY
 92wkxm//0S34OEhC+to/WUT593cSPniJ3kawZvXXXo6+XBUxcRLYApEt+1vGPWuy9lOxF2AaxvQ
 RnxDlSHkyM3F/Y4/FOTphtAqRkfmayyM3aDH0vb5gZqGJtsItrzp2DWKlUE+e7+onz/58fDITcl
 yXbyzeCx1atQPixAb3xiDNC/HBVLWjoa9D+VuUI5ETrkQeviaAq/62W70nv9h5Ap/pVFuG83N6t
 CxPvQZBiuPus5T5Ppztc4pBVjcjaXTOvBMNDIsLuvRQbL2+hph6zPq9Q/f0HDkRXyp1ItTyVbwW
 1bUDNzs45O+zhd6ZovkbVZaazp1fdoageFwdlOImJAzc7O9E/ilHB2NaIioefOVaEHt//zb8ozG
 e81w9GLBi3utHaNLERA==
X-Proofpoint-ORIG-GUID: vVzmTqfhqIeJgQ6Bp5GSZDWCUn48Vw4S
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f6850 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3LdY7DrGIPYvhDJGGbcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX+yyR0Gk7U57K
 musf8gBVyiWkaRM/gyL+04baOjkJpGkwSTsfns7D8JvVWAX5WXK8NxSgeVWrVqz/tiCGweJDj/M
 XwEV9gnSxADhQPQ5Y9tWP+rbA2QiZzE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

The 3 hunks of this patch deal with CCA, EP11 and (CCA) RNG replies
and improve the checking for reply buffer size by using size_t instead
of int and the check_add_overflow() function. For RNG replies an
additional check makes sure the hard coded limit of the data buffer is
not exceeded.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 39 ++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..5deef2e38f06 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -691,6 +691,13 @@ static int convert_type86_rng(struct zcrypt_queue *zq,
 
 	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
 		return -EINVAL;
+	/*
+	 * Note that offset2 and count2 have already been checked in
+	 * zcrypt_msgtype6_receive(). So only check for not exceeding
+	 * the hard coded rng buffer size.
+	 */
+	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
+		return -EMSGSIZE;
 	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
 	return msg->fmt2.count2;
 }
@@ -853,7 +860,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
@@ -874,10 +881,23 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 			msg->len = len;
 			break;
 		case CEXXC_RESPONSE_TYPE_XCRB:
-			if (t86r->fmt2.count2)
-				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
-			else
-				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
+			if (t86r->fmt2.count2) {
+				if (check_add_overflow(t86r->fmt2.offset2,
+						       t86r->fmt2.count2,
+						       &len)) {
+					pr_debug("len overflow => EMSGSIZE\n");
+					msg->rc = -EMSGSIZE;
+					goto out;
+				}
+			} else {
+				if (check_add_overflow(t86r->fmt2.offset1,
+						       t86r->fmt2.count1,
+						       &len)) {
+					pr_debug("len overflow => EMSGSIZE\n");
+					msg->rc = -EMSGSIZE;
+					goto out;
+				}
+			}
 			if (len > reply->bufsize || len > msg->bufsize ||
 			    len != reply->len) {
 				pr_debug("len mismatch => EMSGSIZE\n");
@@ -917,7 +937,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
@@ -927,7 +947,12 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	    t86r->cprbx.cprb_ver_id == 0x04) {
 		switch (resp_type->type) {
 		case CEXXC_RESPONSE_TYPE_EP11:
-			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
+			if (check_add_overflow(t86r->fmt2.offset1,
+					       t86r->fmt2.count1, &len)) {
+				pr_debug("len overflow => EMSGSIZE\n");
+				msg->rc = -EMSGSIZE;
+				goto out;
+			}
 			if (len > reply->bufsize || len > msg->bufsize ||
 			    len != reply->len) {
 				pr_debug("len mismatch => EMSGSIZE\n");
-- 
2.43.0

