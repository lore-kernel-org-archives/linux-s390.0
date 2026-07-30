Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B443E08D
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420916; cv=none; b=cQ9kftyvz/hJJo1mVcbm6yyiv/z+5E3/zs+2q969SPVIUyYO2urK5MFxJC1ynMm+YeSW+qU46pU4lWyejd0MfYUK7+GyzKs1TUbp9jmOfiWdaLEh8lP9Nj18atdU90YH+oyV28Y/9BhFjS5x1w10ld24iWliYT4OK2ieidlwJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420916; c=relaxed/simple;
	bh=IMkvSujBthe6k4qGS4UJ/Pf3X7uoFSyb0anGSsdUa40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrOzBTXikGamKLnS6RTxAxxDrm2MlddmYmXFMtadwg+uGo/d2iCeJiV8fGVlbGIPrrl7tKcXOpUVFOztnxHIkBsoXVE8149a5mxiA6Kt3RcHZsQBtaohTgvsv5Qa/sGgqRtxa9n3OWRYstMAYPo4bgKwv31jz90pYcjD6wQOsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q++jPBU7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q++jPBU7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDIEmE3021344
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HWywune125Xl9FYBO
	bgvKkwgdP/k1AMLm7W2u8o2prQ=; b=q++jPBU7JM4JxG+aTGOHux5rM6H2sUCoM
	V74Wagek83U3W2ZQvb2cLO9WFtlgrxZkQTvbSb0qdy10J4rHgmXxLwbMG/6c9vD0
	WwoqHILP77cAqSpLh2qDru1kUuG1knsm4NkQ9vXwj3Mo65NtuNepuJBJDmz3Ou6T
	WLFKrLSiRO/5IZ5Yuq28htTZw1P9g7EH8S9oCFd8pBODiXB5lEqdAP+hGkSmSMWh
	bpztCdCHHxrpGVtUWTGPi2wJcd+AhJ7WUGo7PLRo4zAoQA4fO0NSWJUFBQ1II7rG
	QPABUMn3x9QxA+mAP2m7O3m67wEJDMx7bn6gCa1QzGqa785/xKmoA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjf9gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBI4v011727
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybdxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEF98x47907236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:15:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32DE72004B;
	Thu, 30 Jul 2026 14:15:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12CA020043;
	Thu, 30 Jul 2026 14:15:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:15:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v10 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with zeros
Date: Thu, 30 Jul 2026 16:15:09 +0200
Message-ID: <20260730141509.205970-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730141509.205970-1-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXwHrrBwFlIYlI
 SUPUxTcQjaA3rBNzlWAMsQ5+eKPBrw4Jz+bCF3YbKKss/4DIj+g72zQVFnfEzSDcoQj2pc8TRru
 pez7IOxgOHMWMhYMbyAQilu9WzgW9WQ=
X-Proofpoint-GUID: KsdSUcQ8gY68rYJHskiCLcC0q-mDLK28
X-Proofpoint-ORIG-GUID: KsdSUcQ8gY68rYJHskiCLcC0q-mDLK28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX5XolPcEdXqPi
 9F5ZLjLcteiHN/qmcmMr7BGi0Gev8xooK/PYCQchVgw35UHFUwk4WPd2WcJ0v27+RSmrsURypSv
 C0PTaSMYkY2fmLu2ur0dD28Y+66WM5a13z8nZrTogmE6/dRIQE/ryb+3xywb6JEbOSc3dI+ELLa
 x6O0SAWMHyNOF9AkTB6rB029/+eqlW0mpRxRNSqOPIL2lmw/BFZQ3i8sm7VKzhzLEdO0opuOXXz
 ayXvXmgYRAFLaD7R+TUNuyjMyErymwxJ0ho8r49DtYCWuKm1w16P5dt18aw1jO2eecE5zkmCBtN
 +r8yxqSQF4q3e4uItH1Sp7rJcwl1lyyefqrut3+6CjD3hCim23epZNWuY8TOl005l+NKdmqFzkM
 /rlCtXuxDl2/SmbRu7dctnMi8LFBUJZp7NyaKRMuf9V9Wg7ZjiFIJZlVCvQbtv8jae9+4IVp2sX
 flPebQCLsT9Upv5Xjnw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b5c71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=hlsHp_40IBquOkZy5q0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300105

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

Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.1+
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 02705f184ef8..e11505248c05 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -399,6 +399,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
@@ -543,6 +547,10 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
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

