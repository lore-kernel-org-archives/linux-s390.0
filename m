Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C536242D90;
	Wed, 10 Sep 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517147; cv=none; b=RHxuAKE83bKBEq6SJaxBJ5gGsw4RKq9SLFpA34zot2njQfJUwjgJ/q52Mcu3sCbFvu65oyIxk6ywkmfrQJmd6hY2twotpfAoS5lUPwiSJqA50JSuvjGvAlDIVCkFaC/quxAtRPNnLqHzI34MvL68MYlNq91ni2WN0ngoyfSRZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517147; c=relaxed/simple;
	bh=Q2vC/XxEz8gl3mUeOl64e9la6IneBU/EUVHVpUwwGas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrXyClHR7MXFiNysBE6o5Oa9tkETqqmyvMxJM5SVahI7qm/Vw92B5+xtnFJIzBom1cUsfmEPI7q3cOBYaHJ513/7DqQubwgtvko06qKemDu158fc80IC7x2RtZOw085Uaaf+b9qVh9LRBN9GIoKbnpbZQdlcV3TucEvXu/xVrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qgEm5576; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qgEm5576"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AF3YvE026614;
	Wed, 10 Sep 2025 15:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iH5mjKTkEFLysNY0H
	Q/J7yJZHmeqEfvtSHSbtVxBK+0=; b=qgEm5576KXLToJobhvm5Pqhqnj49qFHNU
	mczui3vXvgZ/fN8D204tyCfX+hxIncD8quLHMlBt2cnxOFdlRHBzABGRsRZMKOAa
	yPidblVVB9JIwUnYsFOukagUD3m58GYPrqvBOJXehNkgK8+noJglsrnGa/ROrkP/
	utaVuBlxhK9weI5QGrMDyKt6mOLfjJEoljE1rzDfR+sBZBYN0DseL92ZO8cbsSuu
	lPywbBn+O6f6AxMvImOnXSiVxV6VIzJw2nF47JG86exjfl9g11edEwzDb2hhvX2t
	G2mM/ixzZnVlkpfc4OPC7AwVXIQF/67JTo8uDXVqXhPv+94wjHBxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsxkac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEW3Gs017163;
	Wed, 10 Sep 2025 15:12:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmgwbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 15:12:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AFCHSe50528710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 15:12:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90BD120040;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632892004B;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 15:12:17 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 3/3] s390/bitops: Remove volatile qualifier from flogr() inline assembly
Date: Wed, 10 Sep 2025 17:12:16 +0200
Message-ID: <20250910151216.646600-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250910151216.646600-1-hca@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX3pimfG3eK9lw
 1OSU5LyWTJ3iYt5ZwDuCgu79K7McnZfAwv+o3/T6i9bcMjEAidq2RHqS85iqZhA6tUDSHGyDFcH
 dxNXPKzxdSo6VL5FbJlpcstBTk1RDsrfFTvbF5kefaumru43r229PbEhoYpjMIEtHtCEcRPuyz0
 Qc+xyH3Fn5VzUQS/tQCD1804fv+0388A/87MfytlFdxlWWu07H3U9XvAPxK6p409qWNtGo07Mrl
 5dWGVPcJlPtMPwZoQXovb44aGF7NA8LeKhU/SglIjzD6QKDY/EdyuIlNPV2z2fa5fEkLqPFdzd1
 +fMMqmtOEL8QWe2j9rR08GoMYZ9kVpq+YBq7RkN49nBOzzJ9qWuVfILq/4AklRl/1mnbHbewwVO
 /CFnech6
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c19556 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=zaVKdjsgvaB1YBu5WxcA:9
X-Proofpoint-GUID: HQFA2pUHk5i-rNzxrknpqD8_CJKuoJ8c
X-Proofpoint-ORIG-GUID: HQFA2pUHk5i-rNzxrknpqD8_CJKuoJ8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

The flogr() inline assembly has no side effects and generates the same
output if the input does not change. Therefore remove the volatile
qualifier to allow the compiler to optimize the inline assembly away,
if possible.

This also removes the superfluous '\n' which makes the inline assembly
appear larger than it is according to compiler heuristics (number of
lines).

Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 46b90b545986..5e04836c9c8d 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -167,9 +167,8 @@ static __always_inline __attribute_const__ unsigned long __flogr(unsigned long w
 		union register_pair rp __uninitialized;
 
 		rp.even = word;
-		asm volatile(
-			"       flogr   %[rp],%[rp]\n"
-			: [rp] "+d" (rp.pair) : : "cc");
+		asm("flogr	%[rp],%[rp]"
+		    : [rp] "+d" (rp.pair) : : "cc");
 		bit = rp.even;
 		__assume(bit <= 64);
 		return bit & 127;
-- 
2.48.1

