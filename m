Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87872DC32C;
	Tue, 16 Sep 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030494; cv=none; b=tnUEfpgBRqerQXQuXmMB4RFe+Y6k82kK9fK4WyqseDum5MLXTCHbRsEjf7J7CdoajJ37nWz1TevHOU7ScMQnKMNstt5bU2P2Nim2CUgOkewaEGcgVlpvau/vjaYX7B6mfrOlUFAXShwVQF4nSbDdhsS4tZDiGErhbIiipjLxnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030494; c=relaxed/simple;
	bh=6Te0A/HxYb2Wmmqfbdsc/Ho4Azn1wnefUl8kPiuBKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFzxSZHrVK00aWUnwt8ssRwjaQ4SIu9fBab2O1XbwUxexpGQVGmadnm1UyVAbq+/yhTNHLsJUg+eO86XSd196li5t6IXj2emNFUQo5fFO7ucb/rcLybif/Cf1zOGmdyCRRSsvN8llsowY9c3TPmpbpcPd+X/QoUl5J+cbaetGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buhrPN73; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buhrPN73"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCexVW024184;
	Tue, 16 Sep 2025 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EHXEDI2WgkqNo0RKN
	slt7Uqa08bTL1E7gZv7NNEuB4E=; b=buhrPN73a5veN7tASqNtoi5fyEdJfKrbi
	EfPty1VIQwsVlQuZaBigVfVu5IO5SlBltVFalwu8+ikPqkg7mxvP20zkU4lIqUpI
	jf4PslOmhoURuMXuR7YM6tgsgczqv+GzLf83bQyjoSWjbVMfjoqvh9odB8LahNBc
	QBXK6e92317tFhoBf703rdtr3J58se24ck+FkV1K1vclvLIeILIGujfJ0+/f5/Eu
	Sa5j58tJhQdfPzTxsJcf1GM8d2KVO0lmB5JZUdpg78G0FXbEtGiA+R0fqKolEZHk
	b+mls26aw0MO4tNLonrNorOMXkbujnUy/GPKQw0xz/CVZ5lcqPGag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnsg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GDYLLY015867;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnsg0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA01HX005940;
	Tue, 16 Sep 2025 13:48:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu4aaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:48:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDm42A61211058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:48:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CB4B2004B;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B15720043;
	Tue, 16 Sep 2025 13:48:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:48:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 3/4] s390/bitops: Use __assume() for __flogr() inline assembly return value
Date: Tue, 16 Sep 2025 15:48:02 +0200
Message-ID: <20250916134803.874580-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916134803.874580-1-hca@linux.ibm.com>
References: <20250916134803.874580-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d2Lu6QABVV3NnEJxsGYgiwh7t09f_DcZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfX+TRxmcBOLB6C
 3WDBP9a5kQC0yB/oXvVIwCUo1UXLpQEc4YqbB1qilrlIBjNP7Usb32J7CBYj6ytKtO+HfPc1F87
 s6JN+E6OAYjExFFIYWSnBAeZLv0rW6lqjQiIlQpXK+SSiAsNzLyr4gHsaNvRxweNJnZ58ZKM+gV
 bcsT44tFPCJuESku1cENID3kegZNXzES6+kWV0jP5Ekbrr4vENwcJs2owcGJQWcszBwiVE+uYJZ
 rmIiLr6Je/LLCqkRmvdbkJ9QP9/oaefgCTHggxXSNNRCqFeUEv97Pk/uhyh/yW8dcpR44BPkCGm
 XR+bVw52GdxDxdI7DFd2DDo5UG7ifcCFoY7jv6M7epnPL1ZKQOw7bFPtaCsJw5D9U3tpURijWK+
 D2nHLWuq
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c96a9a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=fHZr4GHcFT0B1fRYICcA:9
X-Proofpoint-GUID: eCI8pRIXPvwHEdp8DKYjxpFruzMBOuJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150028

Use __assume() to tell compilers that the output operand of the __flogr()
inline assembly contains a value in the range of 0..64. This allows to
optimize the logical AND operation away.

This reduces the kernel image size by 2804 bytes (defconfig, gcc 15.2.0).

Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index a1dd72b16f54..5ff069fe9526 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -132,9 +132,10 @@ static inline bool test_bit_inv(unsigned long nr,
  */
 static __always_inline unsigned char __flogr(unsigned long word)
 {
-	if (__builtin_constant_p(word)) {
-		unsigned long bit = 0;
+	unsigned long bit;
 
+	if (__builtin_constant_p(word)) {
+		bit = 0;
 		if (!word)
 			return 64;
 		if (!(word & 0xffffffff00000000UL)) {
@@ -169,7 +170,14 @@ static __always_inline unsigned char __flogr(unsigned long word)
 		asm volatile(
 			"       flogr   %[rp],%[rp]\n"
 			: [rp] "+d" (rp.pair) : : "cc");
-		return rp.even & 127;
+		bit = rp.even;
+		/*
+		 * The result of the flogr instruction is a value in the range
+		 * of 0..64. Let the compiler know that the AND operation can
+		 * be optimized away.
+		 */
+		__assume(bit <= 64);
+		return bit & 127;
 	}
 }
 
-- 
2.48.1

