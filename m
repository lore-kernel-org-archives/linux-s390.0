Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02413E7623
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335978; cv=none; b=hBSMmZ2tsKzo5U/+fhPpnlMiX81Ln4jA3AzZxLTBuh9jWXPjW1ZASvyK+nhUIKSokzj8eJ5kZyqEPZj2UlhHMS53idxLYhTqHLBPGlHlmXRkafFScQnL7wECQxn3ayaj/thDJDL+wzGMcxC+0nIvpMPkOdhAQC3rFd5XPVDyPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335978; c=relaxed/simple;
	bh=qocKoWdZnENzbn828WDoLdY5yvVqMuL7CoXJ1nF8e1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8fpj65M5HBmZ8D4NMUP6nikDVBNXSG5nxz5pML7BfF71zFQA6FHuO2YD2BMpLep9S/8Qmz4+imdbNwWp0RkRpPkNAbIRhngqAAuqcfPERxAwMQCDrGSgP/H3vug4kLqa+wYhO0htAGjOEbHk8heY61GgCD6B4K5mN+/+mOKRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=goWB6Z9i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="goWB6Z9i"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDI4Wb022469
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ybyp32bmgmuXQC+Jc
	PQIhBEWOPkpnP4NZUz3y6DpIHg=; b=goWB6Z9iuymO0ZLMd2IxmA6q4RfdLv2F3
	h1aMhQaiNYHh3ohesCkGfBqaIlxNbWPlb4s9chGb0/ic/CvJYKd6XJipwCzkjxLP
	/2J6ildzwLU9gzAACXhlmqZtNr+s1ibkSNB6OgjJKu4kmW23rnDbKU9BAMqY5nTa
	KsvY/RIIPA7uYatanZLiv+f7oxEBCEQdDPpfD5bBovpPd8b+dBtTdkQJC0q8+adw
	Bdc/BwFp339R1CnqzLYG7sOamDfOoibQKGtGQvEQaU5nbcItu3uyRJtC+VkGIMiB
	GtvoKtLYYDyR6+OPLyfy/xn/YO6H4zWxJr40BSOb29+xRl+LD+Lsg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntchj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEQkxm012628
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEdTEs33489198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:39:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9D3620043;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B322520040;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v8 5/5] s390/zcrypt: Pad trailing CCA or EP11 message with zeros
Date: Wed, 29 Jul 2026 16:39:28 +0200
Message-ID: <20260729143928.191969-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729143928.191969-1-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX0pFKx5Ax59/W
 grJvPc0oyjXVXNrIbnuVrYFqN2ilNe/xekTEH3vtlfHaAi5w/T+VP+OrNvmgnSkCAb7PzwflNhZ
 gQm2U+pvJOO2hWVETa1IgoyGYeeUzNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX7m0dngPHpTlX
 +qBE7NmNcJB+tlxyLhM7GwNyEJC7dSJ8YAttrOmysXK4KB71Nwvbbik9ZOdNBG5QHvMtVsAltim
 UI2mUQ1ueQb4VMw4IXWpP74gOuh10Y4pc8fSks3c491Uw0kEiTRMw2U+TUKYtmDgtHoiddjwxAE
 ICCSiAA2RrzaJg9ZF7R2ryZW8Gt4QHC70EzWkDPP8Rq5oD2ryHDktrSDW6Kdcx3exOXeAf+EpYQ
 GDY+f1Xb17aOrPm6tU9jJP2o/vGex1edSRKKV6T1wqwUn2O1wy4HnYkT7LRdf4EoezciNxOfKs9
 mq6Spf0+kxicEBTLsbIohJOL1zxIsK0enfI9ZXdeHOsCsU8b1M0SZ1Cvfnmqb93AvKKse9a6Dlj
 emu73xtVb5qpPd4p3x1PSwbXM1sKFL/ZfZYIOLqAqYiRXq74z4TYsC7C0P0VV946HBL9BmSR/rV
 AKF2/OKWmQaXp15epvQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a10a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=k09C4uiNLOfmAsoB0WMA:9
X-Proofpoint-GUID: -hfx6G5eBpurszIZvM4xNybjHyubiBoz
X-Proofpoint-ORIG-GUID: -hfx6G5eBpurszIZvM4xNybjHyubiBoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290117

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

