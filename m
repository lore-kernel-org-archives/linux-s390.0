Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D53AAF65
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339907; cv=none; b=p0tNssdDTqo+KIu8MtTkALusmUvB0d+4WSReHNRbeUTWmNdwDKKOZLUlr/ClBA/jLcUPLm6nqGKA1bkO2Z1W9wC2Z39lOS921zB4cRgV/dpFkfsqnKR3YnY6cRCcX1JQ2nVl1HtUHzO789gv1T1i2VWamzsljHRAJyjYK0/Kts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339907; c=relaxed/simple;
	bh=ZC/ZqMaJZKNDGUXV6c3QQp5Fr5Gld5DLrUMx35ovw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwTSPGWmu2MhnxccfTq2uvGCJ3elvMwMMFPyEeqpcxeSlIbWhYJxzgtkfthHSRcF7qHjWeG77micXdEixPQu4H8ZG/6DaN7CJE+fkHOrpheyP/yna4Zl0997jLp1M7JmPUfYZzO1jNpvdQg5AskXqLPho98XGIu6UbXXJfdeNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tkl06E9a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tkl06E9a"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFI6N22685485
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mnx0WOO8gf4MPmYIc
	JsIjsT2HVYhYDvbSO92EsKSoxw=; b=Tkl06E9a8jpv1ObNGoqXoL/6FAyJIA+rd
	JEBXRXNfjtiK8mnFHRrW7H7uB1TvOIdHw4adehLf7zlnrzgNKGy3ImDmw3WVEpjg
	TJDi61EsBN7UXfIuqDXX6IpYk9T53MXAsW1BvNZfne6lPyUt94Xxpdb6mgJTWs6t
	yWQtEfxB2HhyPDhA7QHC6QfTm4gEFE5jubtSpBhqpoEAz/qRbmFt4vjV79yDs2ba
	yPm2xg/th30COObq/mQ2FQuoOHqE2lwFTaPv1+EAIENGyLpfBm/3KdNw/oOo4xPu
	EYsplx0HfBfg3KgEht0AkrUhEg7OCPwZ7kAkj5vUWtyK4EegY3cUw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyckdmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfMcQ022904
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgf4yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFj0Bc25952536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:45:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B542004B;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D8CC20043;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with zeros
Date: Wed, 29 Jul 2026 17:44:58 +0200
Message-ID: <20260729154458.195135-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729154458.195135-1-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vy_PRR6R3XhwIkp8u08rUCMK4koKk_PH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX1Qs5451JciYQ
 0WiTuzk3QGIfBTkHu5sIEWcvpjwHx1suZqsfyCqzYpY+fKB/FgZsY8ruOBs0TcAxnqJrsha1lCq
 L0MND6rT7M/LhKc7RRqmpfrlr86J5lMEQOtIHeXcOhw/1ZzSOiJ6eVxQBW0GdLHnYuUPdiyz9K+
 U1FjgDUZ64jxIIMgbKLxNqpTwVtc1JgX8Bb4aNW6ntUQ+pBMBXtLZYC28cSvfhVidSEnxCdeFzj
 W3kI0q7KQjmCdWIlz3VSYV/K0OlIPXubjKR4fxwho19ECI68SX3kavDjZOA53ZmaoQ51sd9PMlr
 fdKvkTGQ11hemzS0LWxULaW5rWK5oyJmTWfVNjoVQMxyXZe+9KjfJJEkWkQGB6H1rKtNaCI6HLm
 vF1+7IEy/ElaGQaK5Jg7EEcITcr8gc+jqbCa0sSo8Ls8bTHWQzd16bY5s2UYXvklJ0cPzx9U/Ts
 yICo+ZWGFLl3v33C3/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXxs+A0zT1VkaA
 g5wEZpYhko8/fgifhXxheDcf9wLskXVHQ5V/wKIOi9HDsGrqpE0R6dxltdfiGEP0ug6ENdyaxwX
 Xx3jxAgHUeuQTpVb0xTTuuxaKUyE2UE=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a2001 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=k09C4uiNLOfmAsoB0WMA:9
X-Proofpoint-GUID: vy_PRR6R3XhwIkp8u08rUCMK4koKk_PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
index da7580933c6f..4a60540b0700 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -396,6 +396,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
@@ -542,6 +546,10 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
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

