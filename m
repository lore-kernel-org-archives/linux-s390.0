Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13827371897
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141137; cv=none; b=YYmBeOr5zUWy2vXpxRvp58purssNLJj5lJULvn4Cmkh+9IwFYERSbdTHrLXtLircsU8EwuH3YUMRU50Kjh08mbCiqIS4uyhEyOdoERVHd13AjAzPx/bdXw6iSzh8MgtTVS8vvbAHL/h7Z8jPL8bi3uVhusWBkOqejNNXKAhHcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141137; c=relaxed/simple;
	bh=PHVqWklFXRZvsn6sJHd8EeltQDTTnTG23qJ9RGcTwQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2RgtVekaEnsptGqr2CW+CT2cLZOSYZ3F7UOvoVKRVgEGtkNNydUgb1X/zxKJGkVe1zEOLn99XE835zW9saJWwJMMk0G/iFP8yMnLQ+rJl1ojPK4DBOTQEUa3USJYYmAjdG5CMYPI2WZMwHwXNEP7qEhKJ3F59e0iWaILo5g9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3wQMSAg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3wQMSAg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7lcZk1598345
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kxmZahhNDmGuywHCk
	SkAq9hmLcaxiNl5U4Lc6awbGNA=; b=S3wQMSAg6gMr5Lw+hJ1dsu9e76OfZvcZW
	RghFflANUG1O9wiRiAZDt597cKc4inlF6DpY+7NTlUKVR5wbfFbqIUn+mOw72TRa
	38Z06HztEPdSCHbYz0nnGHSvjq2ynqqbPtiVt/JI4APn937aavsPwmcCs8WBAWFW
	ObIBo4HEEw7+EcPVhP3gYcvF1gwGjs8yvSTGCVRQpJl+wrcp2G4GXZrExQXz4++T
	q//4UW+fmPY9X+8w61QH3okG6y3Mo+8jIFIaIBA0Qk3RdIHvHhREYbmdy8tAmiC5
	pv5SuLnsbrcrVxc33jtlVUsLxhCLVcQxn4xwaLCywsiVw99gjV+pA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw771ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8QYQA001736
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh4g4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:32:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R8WAN450332034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 08:32:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3CB2004D;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4AA920063;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.203.40])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 08:32:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v6 2/2] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Mon, 27 Jul 2026 10:32:00 +0200
Message-ID: <20260727083200.151976-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727083200.151976-1-freude@linux.ibm.com>
References: <20260727083200.151976-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBuAx_kVJALZF4sCgeEEMERK63JYA8fX
X-Proofpoint-ORIG-GUID: wBuAx_kVJALZF4sCgeEEMERK63JYA8fX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX88D5S2ganhP8
 ZEVwyEXhqoaDVsCMkUAsy2zmf43ilDC7zdihba+bzT7BCtROAgQhN1FNEzyZNa8LS0v9qiGByie
 edVmUdxTM9J3lDX6pESslzHweT0DWChs3xUwbZ/gcMdxqoXOylJ2sog3xvJ/wxLjaFYDpPVb8Vp
 9mDvfNI49+1fEkEfZ+LKF56RgEGtKbnpZ/fXuIJ5ltTTeSSyDKlzXFz0xsL5hyhtdwYxkfAYl4H
 x4D9Q7MZXVgSxh48m16kc/0lEyrm31jWgbTK2RKfXjXEJlAl0FLB8DtqsvZAQpp/XDGax/01Wnu
 AYMD8KBxx0MUMBxYPfs9Y19VrUvyOnxXc+xA0F5fy3WdU/V+lTKxHtThRTq2dnCF6yvACF9j+PK
 S4eFs3u4SEMLsW0WJiHpC7KXE2gvkOcazeDv5Qs3K5hl4PZgarblnsZLg3htIc5gK4xDES6ZYrD
 46Vc90H6ln6WjYgJzow==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a67178f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yrkiJltxsN2MUqc3cT0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX7znWsmvw37CG
 AmIwJPlZCuVN2JOuvrn+EGVfC3T8w34O0tq1KNauAVr7uAl9kBsxUE2bzyUp3j20NCt5/T+f/7M
 CL39BF1UIPOtBbo565xP8QX8ndukydg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270082

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
2. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.
3. There was a gap between the message size copied from user space and
   the message buffer sent down to the card. The msg buffer size is
   rounded up to 4 byte boundary.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, and validating minimum request size and
minimum reply size before copying from userspace. Also pad the gap
between user space copied message and message buffer sent down to the
card by zeros.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 2e4aef330b68..f4cca7fcaeea 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -477,16 +477,25 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 		unsigned int	dom_val;	/* domain id	   */
 	} __packed * payload_hdr = NULL;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_len, rep_len;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) +
+	    2 * sizeof(unsigned char) + sizeof(struct pld_hdr))
+		return -EINVAL;
+	req_len = CEIL4(xcrb->req_len);
+	if (req_len < xcrb->req_len || req_len > U32_MAX)
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
+	if (rep_len < xcrb->resp_len || rep_len > U32_MAX)
+		return -EINVAL;
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
@@ -498,6 +507,9 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 			     (char __force __user *)xcrb->req, xcrb->req_len)) {
 		return -EFAULT;
 	}
+	if (xcrb->req_len < req_len)
+		memset(msg->userdata + xcrb->req_len, 0,
+		       req_len - xcrb->req_len);
 
 	if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
 		switch (msg->pld_lenfmt & 0x03) {
-- 
2.43.0

