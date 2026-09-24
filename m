Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8B489884;
	Thu, 24 Sep 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246862; cv=none; b=UW8OzriUpL/XM6BffwKHTlnbH/P63BD7tUh9VdW7YuXrRgttOyTnsAgmcdDlMP4nWBTVZZWa9ZFxKsxVjOW6rAWecjXZEp+KoXofWWmaANVrW7dkX57my+Q8TehJSg58fu3vu3mN5mqL5j55WKQ/lkoCd/Ztp0+/Zm6NiOSzSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246862; c=relaxed/simple;
	bh=nxJAAMbhiNv90X0dwciHY1pWNa6855UsdEVf6SFJ4zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9/chC0TzmaalXW2QbFYS43x4pqHijoCBdLcePixxju9HYjcCwBrHpvFjDa0PpGZaNg4TdawZDyQqdzBHUbwEPkdlRK3gdeqNIF8aSZgNK876SdaGXPXRprD3bmF90SNfo/J2sDkVGEdM/hGw/UU/NU9C76jvaVP0JNybQqY0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bNdpR9Ke; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNdpR9Ke"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bPt01333887;
	Thu, 24 Sep 2026 10:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OKxdxL6S7UcXaYWgm
	itraURDi7XoeCuAolDi7oypycY=; b=bNdpR9KeB6OEbsaAsZZwB1GKI4R94E14j
	Fq/WwfxlV4W8PWqDaAoJC6xPvE1ASl5JTFRuOf1Xlm4tasIumvNJH4RUzstokZmc
	HviEjhBZOV9uNau0WhneQI0ncbniBir7lDoqXLmpBkDxYPZB3Nkw7Ert9O4JeCFe
	SssjMTRcnbQrN+kXkF8vNyNh1pMd5IueFDcf/PKHy7V2xlMZuj8W3AY/MtSj9zDd
	MTzyyShy/URqfYEd0NDPZ5r2luUwz0EQhz6AVG+7uAbkxgSKVPSpBJ8ONS6L6Bp4
	rpUvVdPuOi+Vpmdtd2sq7H9DjFUonpLTJPa7g0L3StTwr9zEclzDA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsge98-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OA8svZ1501455;
	Thu, 24 Sep 2026 10:47:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2w5k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OAlYD550856260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 10:47:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F2A20040;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98DEA2004B;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 1/2] s390/sclp: Introduce dedicated sclp-vt220 event buffer type
Date: Thu, 24 Sep 2026 12:47:31 +0200
Message-ID: <20260924104732.1978942-2-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924104732.1978942-1-maxbr@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4ffcc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=62qZpib2f5YcqYSorq8A:9
X-Proofpoint-ORIG-GUID: OqPqU1XC4qWpEB7gYI_yDO5ItD-qEM6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX1ce6NgDXAQ/3
 7VgWGlmisQQU0YBPSPwjY97iES9cX8CdPbAIBiBV5Ee9KmoW1bmBL3ze9JFYBoTDircUr97DarR
 k3dMuB7otwDzMpGrDVzU2fXqOUHpgcBtMzcG5H/mVx8d16Z0gv32VXtLyy7rV8DtSI4hcyJLhce
 7V1IaPrAK4xCqg0nJtboC1F9FGuoV9gocOLzUF+0Nu25LoPmtTsoLbvzGddYbcEiWbJ3wzQ4J1r
 XOp7PR88mNBb6gUtOXAZten4Kr60sn/qfNv6AIa1wGc1wzGbvM5cvKgR+irAodVkLY8BHrUfEde
 qAVZyOFy9H0yO4DP3NOCV2C6pnkqeHqcm+pRKlf6+RdulWU2LPm6C+xzrBd85IrF7Rg9a9QNBtM
 mojFeLbjGuDOxLpWswBrEa2f1uxptPTAOgHhJR/iliidNrlSlHlE77SK8qRvILW2hh5dMtgIKIC
 0iMqUdKig4fnkkBplxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX8ybiV0gNUYCk
 rmufUzFTZENFki3NFNoRBSALrXDpqMvIZzKajMsLpgMNFDpgJb3tWhiljO9Uw4bYz56jOWZoDd3
 +1hTEatf9jiq/vQvCuJ52bgB6dZgfB4=
X-Proofpoint-GUID: WKAoOdQ2tSXO_Fvl31Jggy_kUb-qO46w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240044

Introduce sclp-vt220 event buffer type to replace the
byte-manipulation behavior in the receiver function with well defined
primitives.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp_vt220.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 62979adcb..6de4e2e41 100644
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
@@ -522,25 +528,25 @@ static void sclp_vt220_handle_input(const char *buffer, unsigned int count)
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
+	if (evbuf->length < offsetof(struct sclp_vt220_evbuf, data))
+		return;
+
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

