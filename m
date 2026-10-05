Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F64A0912
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209676; cv=none; b=CLBh+qDt8Xc+IzQTcfAFT8qFI8sycoNFdyww+PfWvF9D++ijwPMzU9PeevLvFgfvXXl7DwXF27ssB1kXHKZiCokrvmvtj1+zcJiIXq7DTNsKtwt1XohFuWW7SZlH2vSfOeazO+ZGUxLOa4LI69bqrYL3l6lb8EtqjrmY+D8efNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209676; c=relaxed/simple;
	bh=ITr4+J6/5QOQxrkDoCC6oou5BFLLJq2PyFhI3hVTURM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcVlhrJyZ3rbEgoXqtJP45Lbf0q3KhVwFwX40AxEyfiW489XvdV3+F4GqSfHfu9HA0Y/DkQ4KiD9olq35AaHHFLTwbqjHVUCbBTV3fchhhqLo1bkcvTLRgu1mjpUu1/YeseZLLAWt0pakD3RS4BOWiomMznT4JHlXdObPFUENXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxPIwv6K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxPIwv6K"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CZUa33033308
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JSZ2OcytqY8kBpBkL
	+Ep8boNqZcI0dWpAeymf4KiNhs=; b=fxPIwv6K8MfyYSdI+wXmUO8uL97YcZ33L
	DAr4K+95m6Jy4CJdAs7CZ/XwaEBWBu1xzZmkM4+JVeWVaCr3aO7vJzjij2qudlfL
	9Jzle+iAZZtByV+tSHqEQSzy+evCnfnBr1gnIeoNLIcDbKJ3sDBFyIXpoNGOiZuO
	WBtrqKWKl2Zckgz1vE06xFEgZ4NWfvtuh73+9wGrCgmYu80o9SBpdqPXhKimOS5P
	02630sZkjNzeWsnDEMEKONxHCZ1BiKCCPGKQhm1tG5BCS8bUTnHJ/2JIfYtPGGu1
	Ns+bA495weRI5mx6aIvlydEntH/N8DeHLaOyHgdwjAGjliCUvaswg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrapbu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695CHq062900871
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pny60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695EEHui55705948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:14:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A18520043;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6922004D;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 2/2] s390/crypto: Handle cpacf_kma() return code
Date: Mon,  5 Oct 2026 16:14:16 +0200
Message-ID: <20261005141417.65822-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005141417.65822-1-freude@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfX2zg0zli6jspt
 amSHgfraKfW4La9MM7y0Ks1Hj8hK2Ojd48+pmKvJdaG9oWplGCxOBNWoKx9hlywyoTuMNcVdf3h
 ulQRTPfALHoSm7k8JlJ4Y4Ep72/VfAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfXxzMuRuQl44GS
 2ASRmS76ZMNOl3uI1Wb3wR221Q8ckX+LNIU3Hubbw8cKwvFJaHtGx7MxqP1noACqrgeMBFU15KM
 P3RW8aUFZgOn/dqRzNozDGtUqQTzAxSrFSuIN5Z2AfOmEtaoEY0tLsy+qTewcOaTZESTiMKdgpf
 QBs3J7Do3gBaMpt4oejr0V7RzRs22cbe0RG63wuvm9xySK5WnI3fdtW8Bj+3JctqcnIUQ2Gxp+c
 yIYJcqn3N4tvBFKKVJWVyWeJ8hBzA82H+Q2r/xa2Lg70GBT3BoyitkvdPAqGB/NnxL+2DOwd62y
 oUtaMnVENKmZQChURB1xtTwbWZmcLk9stQ/THR9Ei2YDZTCtOMz6Lc2R0dSscRC9ShSUczpLGQe
 uTpJJIjdhU7nczxzY5ZneTP1fupKn1BL6mQgtqFFzwsZjru+juCsrcimeXtu1FGhXR2jSl942Ve
 6VaH8uObHjj2kD5z7tA==
X-Proofpoint-GUID: iEhXYVUGCNKaeTKchDgQmtDP1VcR6jSY
X-Proofpoint-ORIG-GUID: iEhXYVUGCNKaeTKchDgQmtDP1VcR6jSY
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3b0bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_ealZ5zhq6rR3i9ucnoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050055

Now that cpacf_kma() returns the condition code, check it and bail out
with -EIO on any non-zero result. In practice CC 1 and CC 2 cannot
occur: the GCM function codes are clear-key only, and the scatterwalk
loop ensures block-aligned chunks with LAAD/LPC set on the final call.
However, it is a defensive improvement, not a bug fix.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/aes_s390.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 0be6fa779d2c..ec88ce88f3ef 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -905,10 +905,13 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 		if (aad_bytes > 0)
 			memcpy(gw_out.ptr, gw_in.ptr, aad_bytes);
 
-		cpacf_kma(ctx->fc | flags, &param,
-			  gw_out.ptr + aad_bytes,
-			  gw_in.ptr + aad_bytes, pc_bytes,
-			  gw_in.ptr, aad_bytes);
+		if (cpacf_kma(ctx->fc | flags, &param,
+			      gw_out.ptr + aad_bytes,
+			      gw_in.ptr + aad_bytes, pc_bytes,
+			      gw_in.ptr, aad_bytes)) {
+			ret = -EIO;
+			goto out;
+		}
 
 		n = aad_bytes + pc_bytes;
 		if (gcm_in_walk_done(&gw_in, n) != n) {
-- 
2.43.0

