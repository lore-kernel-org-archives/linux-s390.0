Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53832D738F
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696214; cv=none; b=OjvFmbshZwTMe8+QLO4qDWR8FezIDOakWGNh7su74UcGwtohndxZJc5qQuif+r5KZAX43ZITBR9hVp3hBcW4MPJdi9+f48+UE9jkh4DsMiHVdxNVOS3+D+//ZwuyxL9BvYyF1j6wqFVrKD7JhGqkxXNvxz40Bn4cE+rhbYqkqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696214; c=relaxed/simple;
	bh=Ojk1bEY52vJrVU8qzEUX40y9qQRu3wK9DLtvUttUSGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7Td9tdMzIjp16OpOALLcaNSMbWEAQMMUgwoZzX/2+lFbOEQFPwpqwdQ5hzhO8/vhnTfjPbeX8I9NajBCAg9i2MSaFptJxfadN885dGU6ueX3olnEXc6y4SsONqHWb7c91HXEQOmOuMfelbg6j4g0RiKx0KYnvnI7oDmXkJr6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xzw1lIQZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xzw1lIQZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmhcg765810
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0/YUx64Q3dIDor79E
	ve08QLJMDvqajuUZCQ35ZKJQmo=; b=Xzw1lIQZWevzaDPupOml/oC5IePd9xBK8
	afVuWHUmz8EP1pB6AZECWDdBGSS4Dh8CYHHmrgLiQNJVwQWyqwuLKrYBYhULcyDS
	XtWwfqirvKn3NTaQoAbbC6vAK/7AlXlS3a6rHf9UBTExxqQP6KddiTDgJySCZVMt
	nJh81L8boXcLMuGwZSaOVowjsP5qgcWGci69zDeIEVngn0AU8/1MBH7oAyecHtRu
	/f/iAjk98/HY1S0SAQDNpbPRFmdKejOLmNrFMJ/UFczvBlpgtfWSXEgSmzu1LCsn
	B31Oygtz5LCPlPqmqHVjDtmJu7TK5qyHHX2zQJfqyxdQIGtMeFHFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke7hh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AF4h9G020291
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwjrax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFA6H023134934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:10:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0F520040;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10AC2004B;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 1/1] s390/zcrypt: Improve zcrypt reply message verification checks
Date: Fri, 10 Jul 2026 17:10:05 +0200
Message-ID: <20260710151005.79765-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710151005.79765-1-freude@linux.ibm.com>
References: <20260710151005.79765-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a510b53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ob2ZjO9MYi1PFxOv-r4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0OCBTYWx0ZWRfX+UNOOApU1iYt
 oOrHjeSYEH5PXlvrjpBXv1IlXS47XvsI55icl0Rfr/LZ9T6mKe7bsQszjwxEs9AticQQLnwWaA9
 kdU9uBVduFhtruHTdOIjFhGYyznFQAYBieCRPUKzab6XaBKsMb5mPHbql3wp7X518MTk+GgJPae
 s/H5Ih2/QZS7g212nOn6kpBPNGQ0OjmlozHaQytZA9tw2edYtKup5j8tBX5DFqKLTtWfrOVpACx
 BPxV+FJ9wBN3dRUR+UZxG6FXSlk5vPZj+GTvkBGKrTXja2/k7FnG8uY1Uf0inMqOV5GOEeLV7Ro
 00ERs17PGXBuQsJTEEfuDpNaFUjN80nvZ+W+l2UTLJnQ4+VCH7HG6dd2y7JGzKd/8IW+HDi1z2k
 9VxANAPchxUkB7wcjz/1LFMcy5jnDLa2cocm4fcTmuUiEo6MS07rdueqzWpHU4NVQEFiFCcc3g2
 LcNDuNfYeG31koiDZyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0OCBTYWx0ZWRfX0Jlvq4jidnLb
 UrW2jUbtzv7PINjcLrYGJjsyswmwRy8PFXUqZnR/v1ASiKJDmTaMi34+9rNBisPL/4378p1JpJF
 XbERE1/Oi4canXb1yEmmka3F9B1NBRk=
X-Proofpoint-GUID: ykGAh3n4v6COTpSYYKVkhVtTK0p7NxSm
X-Proofpoint-ORIG-GUID: ykGAh3n4v6COTpSYYKVkhVtTK0p7NxSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100148

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

The 3 hunks of this patch deal with CCA, EP11 and (CCA) RNG replies
and improve the checking for reply buffer size by using size_t instead
of int. RNG replies an additional check makes sure the hard coded
limit of the data buffer is not exceeded. Also there was a condition
with additional data for an CCA reply where some of the field values
where unchecked used to invoke memcpy into user
space. zcrypt_msgtype6_receive() now checks all the relevant fields
before convert_type86_xcrb() uses them.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 42 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..8252fd185663 100644
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
+	size_t len, len1, len2 = 0;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
@@ -863,7 +870,8 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	    t86r->cprbx.cprb_ver_id == 0x02) {
 		switch (resp_type->type) {
 		case CEXXC_RESPONSE_TYPE_ICA:
-			len = sizeof(struct type86x_reply) + t86r->length;
+			len = (size_t)sizeof(struct type86x_reply) +
+				(size_t)t86r->length;
 			if (len > reply->bufsize || len > msg->bufsize ||
 			    len != reply->len) {
 				pr_debug("len mismatch => EMSGSIZE\n");
@@ -874,10 +882,27 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 			msg->len = len;
 			break;
 		case CEXXC_RESPONSE_TYPE_XCRB:
-			if (t86r->fmt2.count2)
-				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
-			else
-				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
+			len1 = (size_t)t86r->fmt2.offset1 +
+				(size_t)t86r->fmt2.count1;
+			if (t86r->fmt2.offset1 > reply->len ||
+			    t86r->fmt2.count1 > reply->len ||
+			    len1 > reply->len) {
+				pr_debug("len mismatch => EMSGSIZE\n");
+				msg->rc = -EMSGSIZE;
+				goto out;
+			}
+			if (t86r->fmt2.count2) {
+				len2 = (size_t)t86r->fmt2.offset2 +
+					(size_t)t86r->fmt2.count2;
+				if (t86r->fmt2.offset2 > reply->len ||
+				    t86r->fmt2.count2 > reply->len ||
+				    len2 > reply->len) {
+					pr_debug("len mismatch => EMSGSIZE\n");
+					msg->rc = -EMSGSIZE;
+					goto out;
+				}
+			}
+			len = max_t(size_t, len1, len2);
 			if (len > reply->bufsize || len > msg->bufsize ||
 			    len != reply->len) {
 				pr_debug("len mismatch => EMSGSIZE\n");
@@ -917,7 +942,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
@@ -927,7 +952,8 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	    t86r->cprbx.cprb_ver_id == 0x04) {
 		switch (resp_type->type) {
 		case CEXXC_RESPONSE_TYPE_EP11:
-			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
+			len = (size_t)t86r->fmt2.offset1 +
+				(size_t)t86r->fmt2.count1;
 			if (len > reply->bufsize || len > msg->bufsize ||
 			    len != reply->len) {
 				pr_debug("len mismatch => EMSGSIZE\n");
-- 
2.43.0

