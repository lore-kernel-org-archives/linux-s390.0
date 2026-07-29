Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA52FDC28
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318808; cv=none; b=bnV0s77HhWITN5LUdvFvNK0qRybssvGKcbkGpRAtNNVCO2Ni3rwyo1HdtnQQOb+PBqBDQ3QC4Ed7o43ja47WFoYpK3IcAEVqGzAx6RWVRWdjiIh9Wd/PPP5KYBG7oN+P96k6RIGwujRq00pDA4Czk5lfruzoSAmSBaQrZjitGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318808; c=relaxed/simple;
	bh=qocKoWdZnENzbn828WDoLdY5yvVqMuL7CoXJ1nF8e1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC2JYqantdqhjhV/lnf9v1M3wKvbNLgYARVUYhBoyX9LKdtODTHSbhlJz9gniuMZ4b/Yho3ll6o5Hlt4yJnUSUjyx8iMeaT6edOcv3mGDciwryZuJ4oLpJlOYOtIoWhxD4MjQ+LGWiBruCEdDzMorGp4tNDkkkKoE69yLqD2Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PpaL4VOI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PpaL4VOI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7ltCd3633970
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ybyp32bmgmuXQC+Jc
	PQIhBEWOPkpnP4NZUz3y6DpIHg=; b=PpaL4VOInqjdIkOUpQEwd8oZyuyux9Fox
	bcFLKdY14OhgmQVLGh6ucexfJfXZwiC+/T5zwnzVWIeZaaLoYSIQNcsRI58WUYev
	XtXs4W+ONxjAV/hXKHYPWRkaR3t6a7LVRY8MZ8F0rJCDq5bEZ0AcEPKi5rNlKDjm
	jX+HKPDy1+u4irhsw9oQ+XnWyYx3rObaPtebmklKs1K+BPKxSZuewcASEjA/6Goc
	DiKrjNoN/SSA9v2Sd+KNKcOalLf/3uGpfJUoXpIukACeyak8BgqKQradxKHV1Jui
	iDGaPESQZBcDvhfXY9aeOb3l3qXakHbKgxT2AJ+/S8D65pcH59njQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd19dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9fG6X017316
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgdxnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9rLqI27722090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:53:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24A052004D;
	Wed, 29 Jul 2026 09:53:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65AE2004F;
	Wed, 29 Jul 2026 09:53:20 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:53:20 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with zeros
Date: Wed, 29 Jul 2026 11:53:18 +0200
Message-ID: <20260729095318.184141-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729095318.184141-1-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: whCYQgj9FI6Wd6vD9ciPkjH99ObyE_Ly
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX1syFmUIl19Ct
 t65j53MHWskBKaMM7h6iu9q2kgpa1AQZ4LOklQQvp82gsOfmMTLrJt+7kFwTIezRKpMHIYYs+5x
 54eZunOkMvWhgrEUzX6pbNoIcBborAM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69cd95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=k09C4uiNLOfmAsoB0WMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX0gS0Z2OzDPoO
 InDoTzqJMPYE/AzYucLLQdQgckc9Ab/XHfQwMJ51QlcWuDuRvrNl503ownlzEVtYZUDk2+X0XWz
 aTgxZm/i/sCTkkEJIJ6FLFDsGNnATRNfhpz7YS9S+Tw08zf2Cc3qSh1rtVD11TFgebKsWKVFOfL
 irkFk7pG6e9q75LNX5/hkYC7vQVJyPfToiiU7Sfk7l/Brwg9ecNjhXAtW8W6gVICoiXLugQI+kJ
 VOU01FCUeTdyeUj/Lsu4mj9pqEhAPgDpP+TNg7d32jAqUHkrbdDKqX0SZjM5XsitHg3VKHGe2hs
 wbsIqUcGaJ6THwfYrFWMmwm5zm1twbV7qlBekuuFvDx0G1R+6mSh220wO3qdeo2lQkjH7Kri0El
 KWAyUHPxQJ2HoxvrVGGbgRDiDxRQs9yVvSqL9xhBbK61bANMIjWayzWPniZncZa2lm/YPrmkwIK
 KKVWqQkJvTeK4m3KW5A==
X-Proofpoint-GUID: whCYQgj9FI6Wd6vD9ciPkjH99ObyE_Ly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080

The both functions xcrb_msg_to_type6cprb_msgx() and
xcrb_msg_to_type6_ep11cprb_msgx() copy the user space message into a
kernel buffer based on the message length. But on further processing
the message is supposed to be 4 byte length adjusted. Thus up to 3
bytes of uninitialized kernel memory are forwarded to further
processing steps and may unwanted expose kernel memory to the crypto
card firmware.

This patch contains code to pad the gap between user space copied
message and message buffer length sent down to further processing of
the CCA or EP11 message to zeros.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 59e182d1bddf..0269c92a84bd 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -395,6 +395,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 			     xcrb->request_control_blk_addr,
 			     xcrb->request_control_blk_length))
 		return -EFAULT;
+	/* pad tail with 0 up to req_cblen */
+	if (xcrb->request_control_blk_length < req_cblen)
+		memset(msg->userdata + xcrb->request_control_blk_length,
+		       0, req_cblen - xcrb->request_control_blk_length);
 	/* copy subfunction code into AP msg type 6 function code field */
 	if (msg->cprbx.cprb_len > req_cblen - sizeof(msg->hdr.function_code))
 		return -EINVAL;
@@ -541,6 +545,10 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 	if (z_copy_from_user(userspace, msg->userdata,
 			     (char __force __user *)xcrb->req, xcrb->req_len))
 		return -EFAULT;
+	/* pad tail with 0 up to req_len */
+	if (xcrb->req_len < req_len)
+		memset(msg->userdata + xcrb->req_len, 0,
+		       req_len - xcrb->req_len);
 
 	pld = msg->userdata + sizeof(struct ep11_cprb);
 	pld_len = msg->cprbx.payload_len;
-- 
2.43.0

