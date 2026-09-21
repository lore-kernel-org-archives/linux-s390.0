Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45931D39A;
	Mon, 21 Sep 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992990; cv=none; b=Lr9gc54+AFgcJeo9mYNV7yDFK8xYK0SFZ4bmHO+QCyuGHdV/m/nxtyG94XQ+QlhU/pEUCDp/e09eA0MJMb9oVMvyOKqRH7YUAt+s+lR+R9PBbQ3+cOKHRFiQlkbRtsCTQciItXKCPtBIujH5Sx4NUpKkrq3iLgzg6eUBoQvPI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992990; c=relaxed/simple;
	bh=g41koLUKZm4n7AgXGWQzbN0/M1v/004xbaSxM23HqEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLin5EZBk3audN/ahjs6gZfjJm4TzjeJFZzabVIkJZMBBSwe56HzjMQ+WeEdgf2BxeATprKTu2UwOHkTaTALaPvWONgEl0A4EeWepe/hzg9+H2ITt16EI5TzHNjGtmOCZeoGwMMno5HdJVdLgKaHUY25nhFzjlio1ytcE3Uxfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GwRtdSfs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GwRtdSfs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5rHG1169864;
	Mon, 21 Sep 2026 12:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VXFUH1QxpK8/t3Xpc
	tOj61LOAq6u+jG5XBzfK9zF5nQ=; b=GwRtdSfsypbqCUuZxB0nRKKgWCUq9UJpX
	qzUs34uz1LTVLwPcF7QI6nV/u8zlSB1mg++TwTXMxnmkWzHROiB+rRxvqpo2ucVU
	FoYDSSbUMIS5ITdcvN9h4n3o9dEtD04IbsB8tUnUi9eayhDmZxDNc57HJX/hYVHh
	zF4Nal3D8EnFp3i5iREAZ5ybUSTL631SLznN+GpyBA9rVOjnKJ1jcR8MD4ujAa4s
	ssa980Acn/XM4qL8WU2oqbNYaE58bQNW1JOb4OFJZStvoLgpZuRGk37X3nVw+zun
	CMOCA3wP5HmoFHNUcdgFqqV4d57PbmvXb+lInd8iPkARHYetVB45g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske189g4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlknF1160855;
	Mon, 21 Sep 2026 12:16:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgd0mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCGLBf37945668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:16:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F8AA20040;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 132DD2004B;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH 1/2] s390/sclp: Introduce dedicated sclp-vt220 event buffer type
Date: Mon, 21 Sep 2026 14:16:18 +0200
Message-ID: <20260921121619.1354611-2-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921121619.1354611-1-maxbr@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qwgV2ieK69Z-zyCobAJ71yjR3lbpdUi8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX8xnysxO9yPn7
 BamqdsKst+aBq3lvelT1sBDU9LAuaKi1CV5gmpVaPbKYhOaIMAhiYcF0qSz9JQpwiURLdU9PXZ6
 OL3xWSbZkT1v7G0v7VS0KBDbZzEYJaQQNx0hxPPDTUzDWSlX2g7yodxuyVe4rgl1q3rDdIDcHUb
 wVw9zB1H8IkJoAaRjDaK8HZXuleAaoMwxr2F1qYgwud1085b2oM30pNTNvkSk2leuixJSnslBsn
 JZTXyjB8C9zcWGTUOwLsm6Aj/M1rYWkRRBzYQ7mFMvnOYeDeW0fpzhmr3r69OAG1oLDZyDswPba
 rxD4dZf9o6szojleYyAE9spthkeGIZlX5rwKHs3d1XIsEKCjOsNY1D3ZwRVg4Wzykf2zGomYytm
 4gPv586EyhxLASyesWkQekbjp6YrRZcfL7g45oz3dTxmml8pHjWz2r99+2tPpfryOu0HdUWrvo9
 nENuLaTJtF/AAExTW+Q==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab12019 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=62qZpib2f5YcqYSorq8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX6RivyGKLONOy
 xCd6gMgdxxEHNtk4mPA/8VQlPW93d9w89bZN77n1/YuBhfwzPng0HKgd3sjUwINsbSDLSdwd8uX
 QkVT4n0ptwCiJbbKX0rfFePYE1g2reI=
X-Proofpoint-GUID: I1CXZRygHUOQ50wvds4jwa9Vd2nrt9DY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

Introduce sclp-vt220 event buffer type to replace the
byte-manipulation behavior in the receiver function with well defined
primitives.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp_vt220.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 62979adcb..6dd176049 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -52,6 +52,12 @@ struct sclp_vt220_sccb {
 	struct evbuf_header evbuf;
 };
 
+struct sclp_vt220_evbuf {
+	struct evbuf_header header;
+	char type;
+	char data[];
+} __packed;
+
 #define SCLP_VT220_MAX_CHARS_PER_BUFFER	(PAGE_SIZE - \
 					 sizeof(struct sclp_vt220_request) - \
 					 sizeof(struct sclp_vt220_sccb))
@@ -522,25 +528,22 @@ static void sclp_vt220_handle_input(const char *buffer, unsigned int count)
 /*
  * Called by the SCLP to report incoming event buffers.
  */
-static void
-sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
+static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 {
-	char *buffer;
+	struct sclp_vt220_evbuf *buffer;
 	unsigned int count;
 
-	buffer = (char *) ((addr_t) evbuf + sizeof(struct evbuf_header));
-	count = evbuf->length - sizeof(struct evbuf_header);
+	buffer = (struct sclp_vt220_evbuf *)evbuf;
+	count = evbuf->length - offsetof(struct sclp_vt220_evbuf, data);
 
-	switch (*buffer) {
+	switch (buffer->type) {
 	case SCLP_VT220_SESSION_ENDED:
 	case SCLP_VT220_SESSION_STARTED:
 		sclp_vt220_reset_session();
 		break;
 	case SCLP_VT220_SESSION_DATA:
 		/* Send input to line discipline */
-		buffer++;
-		count--;
-		sclp_vt220_handle_input(buffer, count);
+		sclp_vt220_handle_input(buffer->data, count);
 		tty_flip_buffer_push(&sclp_vt220_port);
 		break;
 	}
-- 
2.54.0

