Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24837F00F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746021; cv=none; b=QKLJ1zGu1lmE4LKX3v75QPLLsSvbLFVQDh6osMAfPDhiVfO8pegImYrM5q4SdmSifEzPdZv8dCB9CLl3Zw7UqW3HSPQO+/eoQPfgqkFJ1byGnKP7iC0jcfCt0QK5n+pGsBVMIzMT8oH3RFy2+nNlhsVt8IkuutwNbc+RTfroBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746021; c=relaxed/simple;
	bh=VqI8WODz1NlzLtuG2QV8sSJoeC2XKS6crfkrdqcilZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjbMStm0MAjtPo9BpomPbdLNJOfx+6R1DA8jC1Co9MZYnE455XzZLu19A3IiuKX2yOUQx5apluRn4wxUujB0zXZ3ujL/14moyPyEBArLjC2O5bAohys+3d4vIArFxWjAoIH60sz2XPfTDM9wjOzePRVfJ8S35ybgyMtrJrlAEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HV6YElLD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HV6YElLD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlcPt243655
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7RoShhVjeB96eKv/n
	FfCcqdg0g6U9GcPCUXc0wZbNqk=; b=HV6YElLDrQy0b+oI6yrNSOyAaA0rHhwBP
	/KDGIm1sJopLPSeifYSIe31OL3c+7mPHbtzaaz0oP+iarGl1QPSZWQ6k+xM75vrM
	yLP/S/Wb+hzZWUGmfSnbHTrahvWKfpWarmTH+CNp4cEQkVm+ugzIPJD+trkOMhvf
	0uYs6ytZd/Dh+rBzE1GndmZ5dK4AWBWIFodjkwX61yAkBwQtq37I6i3ynhuvo4mR
	gJCWfiIAhodpmr9eLOuMsR0xAPvdLwP0pO9IOiRu4zqfz3fwNjZtwHeB9IexDMwT
	IfqwoEiZ7jvN3LgrHQahB8pLgfyyzIQK44HyQHYyof4BvrlNkThqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4qq42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738QLB4014908
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh4emb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:33:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738XYcK29032740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:33:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4748D2004E;
	Mon,  3 Aug 2026 08:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C1520067;
	Mon,  3 Aug 2026 08:33:34 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:33:34 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v11 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with zeros
Date: Mon,  3 Aug 2026 10:33:38 +0200
Message-ID: <20260803083339.212885-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803083339.212885-1-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfXy7OpU50wQ84o
 1mVIrBqC+2g1Dzg5EAJpJ7/LfMiHTQjXzH5iI5f54tauie5dwdGlkta1FaHVKY1cnLpmBE71sfU
 7Vu3hIKKh5skybajD6Q0EPCeXAJ34/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3MiBTYWx0ZWRfX90WXOGV9dL0z
 Bpk8ZPHJJSswxI5Tq5v7ROwlJVNpsFWcjFZN8bkU9QKBff2FwSbKTGqHfHv7CPGFVTjZKHzRFNc
 mQUEif1y7juwLSQutS3uHk952ZACcTEd3eF5FMdCJPXRxs2l10wBzfWVkZvqYrODCtldVTBxo+t
 lw1cIExrVHK/FaTMw2Y1n6DuB+RIQ+RfjzqIoottdYN12/mWGfMuItkPptm7fTsuOxVAUX9bmNX
 HjN2/amn3+/JzFdeK1s19E1GHXBYcdfE7PmQG47r7trH5WFarMGuDhUKP+2XffhYO4Y+JENswrU
 JICM4D/QWZlKCstmwN0EZQP/lX4B2JuyZOgGwyxQ6+YcO6DcNsC53Xe+QNkOTXk2mEDC3TgG+/5
 yL1tKoR9rZy/DumiZnYAvwRtWMc4hZ9sYj9oeQztYGZt2dXtDg7G3CiR3kOOFwo7YWAl/1QedXL
 xm3C0StfVWZ1qB2CTXQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a705263 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=hlsHp_40IBquOkZy5q0A:9
X-Proofpoint-ORIG-GUID: 2N8tTr9KHQRWS35w4nDPkOV4_3BQMG1x
X-Proofpoint-GUID: 2N8tTr9KHQRWS35w4nDPkOV4_3BQMG1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030072

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
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.1+
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index e79e68b4dd41..3df1d676de5d 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -398,6 +398,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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

