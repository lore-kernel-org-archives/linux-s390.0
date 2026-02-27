Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DA3624A3;
	Fri, 27 Feb 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184078; cv=none; b=lB7nVhJr9N4rDDfJUMAdY51J8KUI9DwVmhOyzW/pk42PzytwH0aV44IO5W+CO9KwxfNHlCY71w4nWNDUgIInPMNdbxsQU929LOTqyp05QQW1lK276Rk8vNmWGTyfh/9S/DM6uyKKyIC4iVmCc3adwJbTlvacBhMkkga01OjrW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184078; c=relaxed/simple;
	bh=J5BlJPpNzKGEPTM3aR/d2a49DEl+mSKAY46kUhvBVbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knAUe2TGlmeBCuUPMMtQLdxvGSNaZBppYoL8KarZft7SJyfqMsjcHq8t05q2AqL7+4qiFNr38Y11WpfFzJ5I3GuCqD3qKYM92cPGXGR+D/dsehlGqHazbT7YwnHX3J++iJsECt+u0Aoxw/+bAzRtmqvlYc5dvpXKqxPqrbUztCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lk/eL6yU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lk/eL6yU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R0QJ6K2347127;
	Fri, 27 Feb 2026 09:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DB39mHhxUx3sbcn61cGF7UuyCYc7v7LfXe8EZ3aVs
	t0=; b=Lk/eL6yU7wfGH9mpAfGBKvaCqI3eraIPWVTqf2jadInoLyKCc/K6oj6zC
	GawwgFZv2k2OZKaM5RRDoPlrJWSFJKD8TcxvXfdCP4homQMk4Wdg/BgAJeJUToAF
	K1qYJ5lKFNVF+g0st01Vf7APOGwc2S0nhrWAWfAmQjgqilpoAdM3eVm6K609JgHh
	HA5CC5ihyqX6iITH9kuMVaqCo4S/nxTbcvNE2CfnmmYT0M3kwYaaWaepIRn4Izdp
	5mvCWJxuVTguqZTKtL8mUAPGGvTE/HXhw1MD3kykcKgEpoQbyn0Fi68aq9RGL+jF
	Qi0HTMUjRIupZsv1rSpuMXXu334kA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8591aq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:21:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R84HN7030259;
	Fri, 27 Feb 2026 09:21:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhks7w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:21:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R9L74U16450002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 09:21:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC37020049;
	Fri, 27 Feb 2026 09:21:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850AB20040;
	Fri, 27 Feb 2026 09:21:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 09:21:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Fri, 27 Feb 2026 10:21:07 +0100
Message-ID: <20260227092107.1120216-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OCBTYWx0ZWRfXxKF2gyYLjPmn
 aRl4P1za8+n3adnufUtgLktWSBtGtslAtsp/4bDI5caN8S5TG7xpUicxlzgsQBRACaSnagqhj++
 vBBOfopebBc+8k9SUw4kvgo697Khc/z1ppjPcJankbN9LQDnXnYSJu1agDIaVZM1NasCBlLhJA4
 PCXfrxm2oh1cqMxnZBmV06hyR6w9l6Qkaea6WODfG8wh3XT+HDkeGOAqSBX6Kx6DyPaxpUrgn1s
 hhs4OlqvsYjKmOmksMirjIrETpR1nIV/Uj8qsgpXpY15M2a6m5+1UuTLr2hLsnuAlExi/7hXkWd
 h/5kZXkfqkkwjiuhPLauPElgi1d3q3MCHbWZNoLolOIci8jMaCQAjjEnUOVsoZGm4vFjVX7fZJz
 SSuImIMoucdeas2vJqQi1jcx32c0I/75igXV/tgnEuNRZ+D/NvGJu9aghx50IzXKqBIvLb7DjNh
 CUIT+BP011oyXFFbPQA==
X-Proofpoint-GUID: -nZHDk_hsYX90DYT3GfxpYMJNTY0Y5ld
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a16209 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=w_A7ZVS8W7fTsnOWK-QA:9
X-Proofpoint-ORIG-GUID: -nZHDk_hsYX90DYT3GfxpYMJNTY0Y5ld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270078

The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
"p1", and "p2" are input operands, while all three of them are modified
within the inline assembly. Given that the function consists only of this
inline assembly it seems unlikely that this may cause any problems, however
fix this in any case.

Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index 1721b73b7803..d703c44d5fd6 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,8 +28,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,
-- 
2.51.0

