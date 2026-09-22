Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D052FF672
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059392; cv=none; b=GLM6f25331Cgo+xNhvVYRubRSAHStnIFf8GOtPNx5UB5UKZ6njcCTWXJAp8Zzwjqd0ZYwsTsePR/OJ474msoSEPp3Vjrwl8z+v+gBZPRWs0DsusD7LaJyBhfGYsnVi4s6aAMpAXoCWCV8gyoE1VTLZt9MBZmJtL00Oxk7p0xFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059392; c=relaxed/simple;
	bh=sDaHgqjSm+r9IvlbvVyPTNRbRxEMSEU+t04g3/FgM7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVhSapJQ1/HXyzSigil3Z2rpscSUXqNlcb2QNdjnJ0huTJ/sWfnsuAd5UCzYSWurxydpBQ2skgIQsCe7IhEwvfYGu4e6ugHOlWOvlZthfF3/kK+Hp8schmta0gtjBx/skKLNpFeAE0WYL9EjcEgKo6Ma6o58FzE2eFhsW34oqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xxc3DEg1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xxc3DEg1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05WA62940065
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=53EA3tibfYnvtOZeJ
	xzZH+uSAZSQU/ba67hMUlghq3k=; b=Xxc3DEg1mKRosr9ThEFdRnoP3BcuF3eJT
	xNK2zi0LeWFpHaJtLm6f/GwtKrB6fqIDgjb01kLIJLOMX/aQeLjb/4zzoCe/N/o/
	qb2NHmvGlkT+wF7t6EVBaIIUWyJz4ORAYPBpqbfe+2VDwiGKCHDYQZrNLuj4onVP
	mppaf7nbJTXrVuoh1S1ekL0I0WMITF2kL0ZmX0yRuzOVEzRb0BO0tZUoHIIysO8O
	6wK3X02zj0LLwcFzArjOmfN1boot3zUawMpBV02OmfRrv7Slxmp80Fu3sK2ayqqt
	659tRUWRacXwfDYp7FQp5Te0mFIsHVHFMawTl/xde8cphm+Ofup6A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2cbqw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5I9gW2002230
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjrncj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h3A849217792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A346D20049;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85E672004D;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 06:43:03 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v6 1/5] s390/sclp: Make parsing of received event buffers more robust
Date: Tue, 22 Sep 2026 08:42:59 +0200
Message-ID: <20260922064303.524293-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922064303.524293-1-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uSSzqFFyxGe_BBYlnG6uL2VHuXybytVN
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2237e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0mq7_-0UZ_Kb3BqdX3gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfXwCrcGIcbF6kj
 /A6eYybJNNkKFZG/ruSfTsKKlj27lhC2450N7J3z5ZNzI5V7jM4K0MCYdoHAIMG51TRY5GBO5p1
 tLq2WCUbKoH6WTF/ANOlZ8yWUfDQH7u1EtQJ7fGChOhs17aNR7DZhH1oEPq5Yhywl62Q5zKy74s
 EbKIms4NP/62joekFO4Wi9kWAle0DesL9PGoH74yv0kOAy6Xwl5iB/pU6vG8mAhjNbgLIt5ktl5
 YHWX0sz4T/MyWo4iCZYZeqtyOTksFKatqAklyRvp+hZvlZkYMFqy0iWoAhq/qyIIfBHIva7AweM
 WQgDbgasFsFHxmY4YH/w6VOYqWr2fN1L7tDgm88puY5+dDWtKwkUc97CgwVE6o4ZMoucDMmaVtp
 yNjxGR4jxbwV31hZ/OKZIGzNa5kyTlvmEJrxOSyz04mLKx5eEF/PVm1LZyqf3rAowmnvgRa5imH
 s3BP9QFO0Hkk5wCHm4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX72xJt6VXLLzF
 +2wN6YlYSz7/mFe3mIDwI1SgAVWdj+o8nfp/IHfi/M1Jm/Kik+52p+fk6givLl82zm44zeq0E+r
 MAG7DRekqWb/LP3VFHx7LQhoZGxwzao=
X-Proofpoint-GUID: uSSzqFFyxGe_BBYlnG6uL2VHuXybytVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220093

Ensure that
* an event buffer does not cross the end boundary of the SCCB buffer it is
  part of
* the total length of an event buffer is not smaller than the size of
  its header

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/s390/char/sclp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..7be4acec9d6e 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -532,8 +532,7 @@ EXPORT_SYMBOL(sclp_add_request);
 
 /* Dispatch events found in request buffer to registered listeners. Return 0
  * if all events were dispatched, non-zero otherwise. */
-static int
-sclp_dispatch_evbufs(struct sccb_header *sccb)
+static int sclp_dispatch_evbufs(struct sccb_header *sccb)
 {
 	unsigned long flags;
 	struct evbuf_header *evbuf;
@@ -544,11 +543,13 @@ sclp_dispatch_evbufs(struct sccb_header *sccb)
 
 	spin_lock_irqsave(&sclp_lock, flags);
 	rc = 0;
-	for (offset = sizeof(struct sccb_header); offset < sccb->length;
+	for (offset = sizeof(struct sccb_header);
+	     offset < sccb->length && (sccb->length - offset >= sizeof(struct evbuf_header));
 	     offset += evbuf->length) {
 		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
 		/* Check for malformed hardware response */
-		if (evbuf->length == 0)
+		if (evbuf->length < sizeof(*evbuf) ||
+		    offset + evbuf->length > sccb->length)
 			break;
 		/* Search for event handler */
 		reg = NULL;
-- 
2.53.0

