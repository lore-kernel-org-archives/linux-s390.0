Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839749;
	b=q+36E89dT1JGRgvtqqWP4ZfgXwCZutpSafV9rW41shGheemUYgbNwzNP65aD/4Ad4wYR
	 Cb3LcS2Votm4zxlSr21LpJdun2XylBRgwh51bf5ldrQvJLzSBwRDbqnJHR5zCS7JpI354
	 3dkdNdabUYl8cgzF8gGNDAf1vMF+NU6twPyo0eywdF+69ImKHcy9gesJQcPxHKBHEX/da
	 tdeEFxBUBTHEf3cXxPv5eoSZCrdY8GM8pBDNBbnXuNKRN9V4iC8H5k/gnnj5+prgvR2do
	 UtWniUKFNWnXj8gC1feVucoiMFZGOrvA+nb9fQW9WeKJ+jxbIqYv7rnlefCFB5J2m5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839749;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FndiHb0ztTKiuKG6vScDNqlN2WrEsRLFs3/jgSFry6c=;
	b=oIBthb9Q8/1Cf7tCaQ0daIdQaHD02TOso34kPkRcDOngMUFkOMXDsv2KXdeSuXCfR6DP
	 7O39SMMvC6vdrF8k99y4eyMRe04Et8ydLkniuQxee9wz2EzyBD0edJbpYcAd9Eelm5hvX
	 1HvJzhN4hkXPSPPW89evzRGXvbmocnnhhN69d698VBXyMz9NLNXxg7XpBCUKQ3B6sqc9O
	 WMrr8LiRfqkAYku62Y7SYFWPi619f79V3an+KwcmPGAiZPb7XlJ6ekvq6czqbGhoh35jE
	 2KuiSeBgnCYpzlLn0CVYmSm2BRaBfMXI25kIwtbPkqDGSzuHup9bcj1kSZYl4cKBavQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IVPiQUKG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174E606A31C;
	Mon, 16 Nov 2026 14:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E174E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IVPiQUKG
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDtio43454902;
	Mon, 16 Nov 2026 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FndiHb0ztTKiuKG6v
	ScDNqlN2WrEsRLFs3/jgSFry6c=; b=IVPiQUKGvSnWQHKlhra9E1RxC5XbUcp1Z
	F7JK098M6/D8mzASRCe6DekrntHk9NfIw45qd/kteJwo1jg019VJWwLI6M43IHqW
	2WDMHJzu/Ga+rMZFYR5yA36VJfJI1C1zY0tUIBes8J3PXOepFrglfCwgQNR0CpWN
	in8VjSSNH+cRrDZPKEVUviyK+I94whU6CfDB+velmbU6dN0vIJK8xZKMXvEaKZxe
	lB6dWHMrHHkbUJAra3qTrkj7wyjVB/6e2jUxZ9PJIiBP+ZG47BLbmr6fM6A1luyY
	ONm5aJRyfc1oZjhl6LUfLKxp8uY9HEyqAcmSfd69ogJNKvq+Pc/6w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc4x4vr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54xC3095352;
	Mon, 16 Nov 2026 14:35:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df8e97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZerR45678912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31372004D;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2912004B;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 14/15] s390/cert_store: Fix out-of-bounds read in pr_dbf_vce()
Date: Mon, 16 Nov 2026 15:35:33 +0100
Message-ID: <20261116143534.158375-15-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXzInr0RcJdmcd
 hgRd0cnbvzBn6a9lKF5dBe8PYVYDfI4c87kD6tGjPhnZbDkC+t80AapxxEIT8iXBsnXmlw3NHoc
 Da9wzECyBRYS4jxOlCCPEKNwF5nE3dk=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afb14c2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wTn7Xx-em-bW4XuYkk0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX5nQUNoflk5cm
 Yay8BHRTi7DCypeu/nSwFV92oP0GhSHVz9qhIK4FmD/Vc39YxH2cChtb5Fd5YSh5XKzMOJoq3lB
 u+tiEb8NgfaSq2S/1jCJiEESDgHv7Nxs0OspTrPiRjlQgSkTpX0OAIs+/2g3nlKM25HfM945Osf
 jWHNXeFEfDIWRDAbmR3v9RFW6YSe16zyV16XPRjgPU6B5KH3Wc+W/ZstqrZY0VK5GQLmUPIHaS3
 CcOnXvOVdzIQiIbiU1GrbtkEWsu9kNXZpzp76clTdZBDMY6FWRU87co+2YhjG3QR1U75u8HR27C
 5VaENbXO3bHfxOKxTCf51jv5T7oj+hWJ87Rm3ozTGsH38/Fw55QFSeraHkVeQnzKYKGfBkA+iCC
 Da5wWRu6ZWAcC76RTIETktOF4IOHMimUhGeKRAjHSqvRHTvA5EJhNUA7VaWJ7XKoUmJ8A4vdxzM
 U1VananV0IFgKPhf4fg==
X-Proofpoint-GUID: CFI-R1CFWvfqFWjGlVc73uMUrOFWCLVd
X-Proofpoint-ORIG-GUID: CFI-R1CFWvfqFWjGlVc73uMUrOFWCLVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

pr_dbf_vce() dumps the last 128 bytes of the certificate data of a
Verification Certificate Entry (VCE) into a debug area.
However the address calculation is wrong: vce_length is the length of
the whole entry including the header, while cert_data_buf starts
behind the header. Therefore the dump starts at the end of the entry
and starts reading behind it.

Dump the last 128 bytes of the entry like intended. Limit dumps to the
data length.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 996ca3025629..12fc0ee87f3b 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -181,6 +181,7 @@ static void pr_dbf_vce(const struct vce *e)
 {
 	unsigned char vc_name[VC_NAME_LEN_BYTES + 1];
 	char log_string[VC_NAME_LEN_BYTES + 40];
+	u32 data_len = 0;
 
 	pr_dbf_msg("VCE Header:");
 	pr_dbf_msg("vce_hdr.vce_length: %d", e->vce_hdr.vce_length);
@@ -206,11 +207,13 @@ static void pr_dbf_vce(const struct vce *e)
 	debug_text_event(cert_store_hexdump, 3, log_string);
 
 	/* Certificate data. */
+	if (e->vce_hdr.vce_length > sizeof(e->vce_hdr))
+		data_len = e->vce_hdr.vce_length - sizeof(e->vce_hdr);
 	debug_text_event(cert_store_hexdump, 3, "VCE: Certificate data start");
-	debug_event(cert_store_hexdump, 3, (u8 *)e->cert_data_buf, 128);
+	debug_event(cert_store_hexdump, 3, (u8 *)e->cert_data_buf, min(data_len, 128U));
 	debug_text_event(cert_store_hexdump, 3, "VCE: Certificate data end");
-	debug_event(cert_store_hexdump, 3,
-		    (u8 *)e->cert_data_buf + e->vce_hdr.vce_length - 128, 128);
+	if (data_len > 128)
+		debug_event(cert_store_hexdump, 3, (u8 *)e + e->vce_hdr.vce_length - 128, 128);
 }
 
 static void pr_dbf_vcssb(const struct vcssb *s)
-- 
2.56.1

