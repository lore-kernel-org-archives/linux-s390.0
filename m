Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839751;
	b=irLxUmkgvbXYkYYtld3qepnH/ra9ZZF6KANSJNk+dxh+mUvAIxuqY5yWvocpegsi44PC
	 IQ8M4mN0Hx+Oqn0xmf2f8VkjIT+DD3/XeUK3Av4o6/2SACMXrridpZfbmKDGLucPM3+Zo
	 /l0vxS6nMaqmjm7zoYmA4WH3oYKYBAlzLCY7XBD5obG7lX6sdJyMQznsm4GtNa/03ki6M
	 vwAaY00gZOCWhJDDW4YgATmmfzso0OzBhKToo+d/xtHKj4y2IQIiVTKXW3IBvwGWCDJWg
	 aAMLD8fPYjQFxPOAdDGjtPtOrnVArXD0KCBpdPt2T1Ws4JcYj3ceRxbY9DryEwwgOQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839751;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gyu/FzqFFIBUOtIfaQbI+ret37PgTAwhx0DlrsqqXDk=;
	b=gq8qj10dQg3WLRQAuI6S5b+QEq2ltp4XV/TsaMyfqmtLVQs4nRk/y9UFqOY+Qhzgy4pA
	 +Z5O1qorLIM/QwyTRKvPV42ifr1p7f4rOeAkbFOLL4uQoTyxPgZp3JUOa1lc0Alxxo0yR
	 D+7u59hbmawPXg1xFGdyIhAfaBsCPiam8TUu226itVGFfcpZMZ+SrKaQDm9wFznT0c//f
	 xMohaUFkPHhO/+t9ibhkQ4UWBNjIXVZ/W2XJ/N8kI7YXywlw1Ga+ZGvQ1JlZLk2qJM3JX
	 m8UYECMUYvVPmziLE7QfVvyR1jZaK64zS00DqvppQKpuXXLpglG/POxsL4A33JlqmqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EzSAGDo5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7409606A31C;
	Mon, 16 Nov 2026 14:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7409606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EzSAGDo5
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDtiuO3454956;
	Mon, 16 Nov 2026 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gyu/FzqFFIBUOtIfa
	QbI+ret37PgTAwhx0DlrsqqXDk=; b=EzSAGDo5lCDg3AjSkA0Dt1w4FgycKbdHG
	XcnSfVZ/IqMizi7WtgNJ9M0pSlViIwchk/AyYnM6shCqSYNvn0whyhBjhteFF+JN
	NYURYuvfE8Fo9GMhbB5vqKTjMD13n1KqZbXzH1TDa3qFFzCEtrYS6l4K3d5CI6ei
	97bRJreUDGQsUShtNh/mn6vEZDAJWPayIaMQsfQA608N+eLLO7d8OTZjLPhcV/KQ
	Uq/3vDAAi1yGXjovd7G8rUggTKqD7WTWEJCmo/nggqhA1Ddt1N86ocRc5V8KaDAz
	3N4YCndm4S3YAL6yQF+GWcLM7996+buKUZmRSVpFHIgEEMTekbjxw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc4x4w1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54gp3095320;
	Mon, 16 Nov 2026 14:35:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df8e9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZbKi49086922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BB920043;
	Mon, 16 Nov 2026 14:35:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7FB2004B;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 06/15] s390/cert_store: Fix cs_keyring reference leak in fill_cs_keyring()
Date: Mon, 16 Nov 2026 15:35:25 +0100
Message-ID: <20261116143534.158375-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXxT7xxMnpSAXb
 STYN1tA5B/VcnLY6JClUUGqvabU0WAyBLe12Yk3aheKWEsId+XoO6/9K7dCY5V85iURXMOXjzPd
 3kga8FG6ThetcDvsIJ4BEOgIYkI/ed4=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afb14c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=axoWDcquyLvgfWuO3ucA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXyVO13agJitCE
 J4cMx9gImD/224tBJjcdDBlUawl88ygy3GmjuRhRsBVK512RGrCvR8lfvtA1Urjj9FlrLZVPNYd
 G+W/4mcAWEtSrXpmXBecETRSlqX0HeqsS8w/kqmKcMUE7uq+t5ScZtoIfP295beMicQBXfT3sxB
 4raMTKVAWWR5P/wkcEG3vslFSGgMWWP0/gmkbDjLgznMbWuvF2x33Tj+XrSAdnFD2oMsvqBBQm3
 sIkQ3bdstYN2dc3cJX+w9O7O4J1fnxM5ivoJNdCQ7Kez1sRNJPu6u3itJyn7tSTIu/HhG6SSkg4
 A1gl2I6tMRqqgdWuoLW6XFjOGpgbuZHJ4oC1zOXHiXkf203Tt5gY39aVCTKps4S/gsMtfDJVf+l
 WosX4Jj3MRdip2zM4CQ/3etA8Hu1HmsW4zAA6AE6ZkdfDNcl2g1AYPKglLAOCbC4FCt2hHbDx3Q
 3K6VXbtElmjb/hySTyQ==
X-Proofpoint-GUID: iQakbNFMTmT7UkFp5Kv-lATqurrecDwh
X-Proofpoint-ORIG-GUID: iQakbNFMTmT7UkFp5Kv-lATqurrecDwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

create_cs_keyring() returns cs_keyring with a reference held. On the
success path fill_cs_keyring() never drops it, leaking the reference.
The keyring is kept alive by its link to the session keyring.

Drop the reference after add_certificates_to_keyring() returns.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index a69eccf6affd..386fe39fe8bd 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -723,6 +723,7 @@ static int fill_cs_keyring(void)
 	if (rc)
 		goto cleanup_cs_keyring;
 
+	key_put(cs_keyring);
 	goto out;
 
 cleanup_cs_keyring:
-- 
2.56.1

