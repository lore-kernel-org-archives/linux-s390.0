Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310253;
	b=gsQ8e7dHawxX4jgmI8Hsg9Pn3AX4r0HyOzGNCmXVysNZ4mhZwqhafnMegol1cWobSRdn
	 WO1jObGYn8FCnqXIV+atmhNr2s/WJB6Kpi7jG/LzRZw6bYSmZq//MBIozfC5c39ayx2Cg
	 tgs+MJtN1V7X6A6sQ21z1A3atqtUu/TSqw5HjdxW+0uNyTM60DlCWeUVYVJmDqoDDBGpf
	 bW5IY+Z+1sPPk7E52yIca+mMqcogpVWF9wy1gDwLYFLdP87EzKb/osPJ3zZIX+gK5pF+8
	 0wp+ibjZPzBj9cIe6oFd7aqiCmY34rgb90hUzJ0t0eLWa26LXhZuMrO14TC97hvYT1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310253;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+ojyzcgYmEtf3OfSsDRs3oVaGefm/5H6qRtJtThMI8w=;
	b=5tjsGvDnwdK4c9tRRSPVWVGtUL5sNw7E+2Mz4JYHPHo1evKxztvOPn7phvyp+iiEIWN+
	 UPRnxVGPUfHUF0b39nxS+0/NOV/CoSDZo4cP2ovsrUUvjZEjgBQJQ+N9qHiq5Hz5EmdIl
	 ydgjhbzoAYzais/e8RL3T96oLOmRRkSaWVD0g2lN8ReSSiYtDnPtQPmeF8ddaEbmYkKnX
	 YHA9GaDpWgW1j6V74eryx5U7qPAhGnB8Z937PFCREFnj94yXBqLTm+9AV0RtItVbrIi3d
	 HZqOpwF9gjhL06w76++IIsp9f89KpkmFbqIMiJ6z/JfPe/c02LhgvMXpAwt4OqhzOlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WBc42pV6;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68389606A326
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68389606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WBc42pV6
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABF3RO2180214
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ojyzcgYmEtf3OfSs
	DRs3oVaGefm/5H6qRtJtThMI8w=; b=WBc42pV6dT4yfnuB/r7wna4msaT/njg6U
	SJwrDV4w9couyXohPByZpMc0ThOI0EgoPTj50CCftkRDwmzqv4C3DfowC/Dk5hzQ
	j8ZorTySEOAflyixEzltyaT033uv0TYyQZN9s0bjBbuFxbJ8DZqWAtPfdbS0/55E
	vrirBTIYMLlxY9OCgFsGA6kzjw+7CZe8RM06KDGmDSDLmlcBCFhsxtqAMJOjLexP
	4R5I9swKrmG0rD2mLsbeaDtynhW+Ve5RsLbp/nQ5TCxYbLFjpCocyXLGC2j/ebe+
	Kclp1WjeK6Y5oW33HKCOxqxe+6GltXBoXl0c2uGfVvjMCiBpcwrCQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6vjh6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABK1QE1679592
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq6jg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUm8D37617986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0FE520040;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D614A2004E;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 1/5] s390/sclp: Make parsing of received event buffers more robust
Date: Tue, 10 Nov 2026 12:30:43 +0100
Message-ID: <20261110113047.238367-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110113047.238367-1-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfXwdrE5dZqKgf+
 +e/nK1bmJYzkHXYDeuafKTMVizdfRN2N38jhlXfVO1VieIHro47C3lUU92AbQmD2mw+v0W/2rSE
 qnSXHHJO8IPDxvmd2nyH+FZ/5F6KV/o=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af3006c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vSaj_4tFx2hm58w1KeIA:9
X-Proofpoint-ORIG-GUID: RAiWTwkBkcObX6Ve2ohfnsgpycH4_H-s
X-Proofpoint-GUID: RAiWTwkBkcObX6Ve2ohfnsgpycH4_H-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX+2kJG4HVTlMt
 CpmX7EnTWTYQZLcTqB6RWoO4DhXtw8jnd/utdl9tqlihzS2Dnd+94LQGi6VyNG1vgi3IgENvbZj
 sjvnbeO9AHOGyfywYXy4srifUkwAtnbx6cCWesnYrGvXVn2fhA5sWxYxAmMz5Y+q2S+rVQ0RrVI
 gJ2HqXH1/l1nkXdSprkgYi/mjUaA9y1Z79ABug2Haz/PGG+3XXAIIeSDVxIwt+6bbz95VFjWOtp
 85kh+C62ly2X9xpPL7QBreermiwUdmU062asbKBBTBs8MyQHkxRAKvhe9WpzlikUt0y4Zk3HkH7
 WkokoZYM82Yqovelzf8MAEEPPLB9O3kYS1zsxAnMYXlz+VsMlzgD3ZWKnr7cBW7D6S5aNOT0dm7
 R8hp3Pk7j9o9xd9al5B8aKu/Qz3q0mqbhMVbByf0GtEIT2iBVfr3xeg56Zb9tNLi3d8/C6QAG45
 dX7EUw54lo9Mu6jtUpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100044

Validate header fields of SCCB and event buffers to protect from potential
out-of-range memory accesses which might be caused by malformed hardware
responses.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..5a4e4001dfa8 100644
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
@@ -542,14 +541,25 @@ sclp_dispatch_evbufs(struct sccb_header *sccb)
 	int offset;
 	int rc;
 
+	/* Check for malformed hardware response */
+	if (sccb->length > PAGE_SIZE)
+		return -EINVAL;
+
 	spin_lock_irqsave(&sclp_lock, flags);
 	rc = 0;
 	for (offset = sizeof(struct sccb_header); offset < sccb->length;
 	     offset += evbuf->length) {
-		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
 		/* Check for malformed hardware response */
-		if (evbuf->length == 0)
+		if (offset + sizeof(struct evbuf_header) > sccb->length) {
+			rc = -EINVAL;
 			break;
+		}
+		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
+		if (evbuf->length < sizeof(*evbuf) ||
+		    offset + evbuf->length > sccb->length) {
+			rc = -EINVAL;
+			break;
+		}
 		/* Search for event handler */
 		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
-- 
2.53.0

