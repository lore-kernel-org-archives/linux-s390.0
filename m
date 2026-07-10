Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171341B373
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682893; cv=none; b=bZ6GZpB9D3eZ9IH4P6o6a51TnqKkNS+2Q5yhMsRVbdW51u21zvcgRFs1Xj938UHEB0mZv7q1uHW9Bhl3Rq+BxqqRhauGUcu0a+b8a4NvdpcdnZQUK3QOLQTeNhgtQjRfa/EvThlsjhQu6KU79+Qq2cFoYcT5BU9E5Ct2FD1UAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682893; c=relaxed/simple;
	bh=BoPz6CqtethS12FkUVZm3oTV3CzXkqr80/kv3MbvNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+GU+908W6FAJb592lBxSzahbwy7cCltFLNQ3R9EjLxxauz/pvdQh3jaBazdSrqNEFWDSSKC3koRa1070iMbYJPJjq3WKbLjjsyvlQIe5mGKsPGXzLf1OziyHKtbR9nNCODmwYXvT//KP02tufm6a6rNelzmW+zyrmT0Fqy1nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ip6qk++y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ip6qk++y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAnEwB248395
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s0l+2d92WweNv020A
	VJH66k1KN8QpN/Q+4U5B8u2hvE=; b=ip6qk++y9Ex00e1Xpj9YRTAJJ247onBgT
	r+NOscF9oV1/203cSHbg1outwbKe0rDg96jPbl2vtBScr3orw89H7mPZEde7rk05
	7dVZLEd1zeVNDBww6p/OZHtghta0Ew5jHLASEYw+9r3VOQ1Nfo2IuOhuVoRjX2CQ
	5RZHwm7kItMvGC8YOx7huw03hsEAYigHq6aNQag9t3y9wVFC73HYHSPSMAr+YpNG
	ofX19fCre/+rzEL5f3Fot0XzYcwR3iqXF4Ny6G3/AIHMWIjw8WKS9YAP4BSYAy3M
	310hBTnpBzozUC7iwK4E1DFdyycX9DpMN+ksU0KcRXNY1yDBo3R7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke6mvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ABJcPd025495
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkhrea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:28:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ABRveK62063036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 11:27:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D6E20040;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE262004B;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 11:27:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v4 1/1] s390/zcrypt: Improve zcrypt reply message verification checks
Date: Fri, 10 Jul 2026 13:27:56 +0200
Message-ID: <20260710112756.75346-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710112756.75346-1-freude@linux.ibm.com>
References: <20260710112756.75346-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50d742 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ng_CRhvcuIW9pqeT64gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX84OVYqab8MKg
 L+uJ05USmrcDoRz1w8oPFmY7O9AlfXXpbfKV1UrP0N0lU5UEoV6VVcQzkh0zf+ETpyYgPJp//48
 ZVMTzpzZKA/uJDZPVHML3eBqGjiNpSdGRY9xoEu+9gVprL25yCR47XEnkZtKhwHRuzqxvXZ+uoJ
 qFbHD+7C+giXPdZaqkyqgm9Q5OLjHIzbbS0T+XSnQcgmx4sphL9xjYW1NLf4544eEOI2i60GFn/
 A35HRtWq0y+DD6dLqkotC6Iv6bOM/OaXMP+vuamMTQZVaHVgXylkpsELvv6L/WpYlG0nl1+mRIN
 1IY+VXydfTtRBxMF0Ib+86isu780rLnU5GjgLOjj7pnjTJGYFY4suulq0N9sh4FpLNeLfiWkBjH
 yaS+CyL7rSC+2fzzqVgFM6Ud6Xq4SUVlErUxIERjvICqCBeSDJ0l/rzIIJg7an2OfONZVeTy7Re
 4ODFuzlM55CjSoqoGPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExMiBTYWx0ZWRfX6ZlIM1RnkAC0
 fNqVkMqyiuxm8RpyA+k0I84Ehi2crH8Bi2OchN8FF5fCdpAIYmOThJQSguPFAGPqa0cl6Uxw3gU
 UqMuKE2FXY36wYhMi+VzBj/UcUPjga4=
X-Proofpoint-GUID: 4HWhPQwJBRWoB-OurkhX8038X6osAfkF
X-Proofpoint-ORIG-GUID: 4HWhPQwJBRWoB-OurkhX8038X6osAfkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100112

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

The 3 hunks of this patch deal with CCA, EP11 and (CCA) RNG replies
and improve the checking for reply buffer size by using size_t instead
of int. RNG replies an additional check makes sure the hard coded
limit of the data buffer is not exceeded.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..ae175cab041b 100644
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
@@ -917,7 +924,7 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
-- 
2.43.0

