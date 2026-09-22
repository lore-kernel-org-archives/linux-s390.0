Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F41522681;
	Tue, 22 Sep 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071153; cv=none; b=sLi+B3mbzF7IgSVD33lMrJG7xvOFIoRZXuJsxB6b24vyHkQirq8O5iOEfYwZVRZmCphew6IUU03usaUbUfnhhifZiaNPgJGtzyCewXfqauMSXfX425gjKSkX2iBzLcudEr3bLDAWbUVpSKgVt+cwW9aO4M6uxZF9v7QcaAHzf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071153; c=relaxed/simple;
	bh=g41koLUKZm4n7AgXGWQzbN0/M1v/004xbaSxM23HqEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzZKooHzCl1x+sKzvJAuIy30PP6vtKxvhr+MkplO/TYwEfQQfoW5C3bm78f57kkQ+x8gkGz/2en4njreEYXCxqkD6e3u652tQBSdvADhu2luxNcHC0G++HLrj6TYLA4eqYnFVcccY7se7Nl6U7Rlfq25dGKn5EvdNPstmFfk+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KYj5XmQQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KYj5XmQQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05TMc2948526;
	Tue, 22 Sep 2026 09:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VXFUH1QxpK8/t3Xpc
	tOj61LOAq6u+jG5XBzfK9zF5nQ=; b=KYj5XmQQwbdH4Rf4uOp7+TyMR0x4S6TSa
	zZZlFV8u5UmLPZUXcB7DcD/3dDhdATDEVnB0LwCkLXcWgou9i8iCvmmeRXJSwj7J
	tPLXp8d3gSQcetKj9+0YpGyHl/4trOQAw2RDMZ7NLZwiimVctqD8DD0fwPQFhR2N
	TZzaGrVKF7sWUTsobT7yozeCyt6F1bEw8vwyDgK6WeghhIFgW1c64maLNzPOTefR
	YywgzjODLl5hVA34p1un7CK5fTUaL/OROXCbIFdLL6zNsnMrQhR2/AGxKj6nU28m
	d9THCHCX9kziy3Dri5O6uTLsf/bfIDf1ZCLm3+KYK03RoRwUu64uQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs530r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5cGec2045776;
	Tue, 22 Sep 2026 09:59:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gs7ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M9x5gt49873274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 09:59:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0BFE20043;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2CF82004B;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v2 1/2] s390/sclp: Introduce dedicated sclp-vt220 event buffer type
Date: Tue, 22 Sep 2026 11:59:02 +0200
Message-ID: <20260922095903.1595794-2-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922095903.1595794-1-maxbr@linux.ibm.com>
References: <20260922095903.1595794-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2516f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=62qZpib2f5YcqYSorq8A:9
X-Proofpoint-ORIG-GUID: GuLe9trP13ppl423Sglz7DN-mDqXBQ6J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfXwrdhJjimw7Il
 ZTnYlf0QmdSmy4Sis9cDOHWtVi9kK9/hHrzwWxf38POclC6F+ru39sK7/lKKlRHjzi4RHUZHgf2
 aIts7pwCWcosSLC/HSD74no2qXwe0q28O+njBIAMJt4feV1N+miR+rOCd/aycl6JCcU+ZI84fOX
 B7y9BKq2nuG5iDYE/TjNx6twb+lq1FIO9Kqo1HE/TBTdI0JzvanYtrnldw2InjLfblhOcopgB3r
 pPV5X8ZxfxI2F9zbc/SHrvrXBaGGJ2rjVoqEodv3tjEgJArEm9jGHoBOWnsY5+5tLpqSW89uc16
 HQONAtdcrxhe57M7jD04PZkUoMN/idjUoMsiMkhTy3ufM1dWSv93CxZS9kfUNct7FEzICET8hri
 Gb5ibMoHPMoX0Df+Osz45B6J+guBFvdeYCmmOK/pNAf8IzsINhuBv+rfcomdQEgHfHCoEw1GpZw
 GkyBS7X25NYasKwA9nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX5DwhD36R9bzV
 kyixIJ/IFs/6YGyjff58LBfjfKK0ZGMeuJc/PHFMRnmm3jrTwwbz7pmQcf0br3t8ZBqPx2mLUow
 ymLDa5xepETy9sI9jb54JDx0S5CORCY=
X-Proofpoint-GUID: Aue70sWQ0ufyvCLKe_KRNLmyXHCSkar_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220138

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

