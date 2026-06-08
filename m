Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CA36F8EF
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897082; cv=none; b=e5bDc1fOM/t/UzHtVeJhUm5UH8FYtDuCz7D9CSi63WVzA8wuGVcOkmy/zg3dLlE8QxD/3Uc15qMGDDPrWHGurk9+1SdrQFx066kMtLGwIi3wRtd3hcz6/GDC8QG3lI2pzVEOZwymiXzL+j/iQJDLpwgR4zpBFT7SahqilAHWHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897082; c=relaxed/simple;
	bh=S8Z3U7y+0cQyVK41dLg8AQ8KP/4oNtU7iRiFRUazXHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuzO6yn5F/YggpprW09VCaXRYEKTK53iKn1/7rBMQzSDCfUpibL3ShBTL3Js4tNzNVDsnFgdu9YAxcvbFzPS1tZ1tqXC4xWugXEzdx3OIwuixvU01fhbGMgnb/07QB5zQjD99M1PegA8Buwy6Qi9KxSx3ZB2HEQfffKJ4YwscR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iUbEhSo6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iUbEhSo6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657KlhST3174993
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=No4JN21A6f89be9Wv
	PIEoiJEaB3WiJCC5zTcRenirKU=; b=iUbEhSo6PJJH0NwFfsjyrE7Wql2zIP/zS
	jFkkU21BxEoyDxPujApkm162GwNmb5011wnjERYzqgbTLc/qi2Ixb8lbGBLitXKZ
	aGkvHnPSPLdJzYErtNljqQGqYUehaOjgBE4uX3w/DoiT5OJuiZ8y9hm5DiSOHlt+
	sONwcJXGGtUJFG3ElaLWm1W11bnF3lNLiCbLnnNk2uWLy5zMPSUn4X0NBVMfxOdI
	4eiou1GUIik2u1qgjNfXoejdICC8N25olUj9ypj++geWp5IwvTZlvHaN5mcBVgip
	h5JXdyrl9m37YqbNIUyV40AgDw4NeYBOHBE3ZYrx13AbYAGP/HTtw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qdsfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:38:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585Jjpu009923
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkxfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585btfr43057580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D76820040;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC9F2004D;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 7/8] s390/memmove: Optimize backward copy case
Date: Mon,  8 Jun 2026 07:37:53 +0200
Message-ID: <20260608053754.571282-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a265538 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=JR0CvQFn8sAsJeSSqqQA:9
X-Proofpoint-GUID: at4uT0gEGOsgj_DtU9ZnxCjhv3TaGHpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX1ll3+ICaXACA
 9ZY55ki77ovUnQO9ZT25e68bcXKt4asIbAdrqwXe0eq/dZkElQ4t0CZB6DGzVsEQ7MhbdxENTS3
 ZZOiTTeVyqHBgutnHJRA67XO9gHvHpp6M8GXB7Tka5J5xQx0SxdbjncTBHEGWm8Z24I3zTp6upj
 6i15r6QmLmgoiCWcjo94hsPM89bp3d3uiScwbXTuow4kYdG0sDyzDNYy/e8NEzyDO8Z62mLgbEh
 pVRGjbTB5IUciG/GadTuEuCW6XNeeNKDskkMF0/DZKFC9RY78fBZ8QyIEaVbD7OnpcQXcM4LTU9
 d7NN/oJoAJALHIdWNPEUpTk1BLLAcdlOS86Qe7HpldkuoPy4K5lJT6anfujUaZSo+hvUJGdrDZE
 NSlXTOTDyJ4VNQReuHDMqm4DdbFOYAFWa9I8Jc3iqt4wX6bdJhkf8i/Zg8xs1G3QquJSmY6jym/
 OaPiaBWFKVAaQTbUi2g==
X-Proofpoint-ORIG-GUID: at4uT0gEGOsgj_DtU9ZnxCjhv3TaGHpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049

memmove() copies byte wise for the backward copy case, when the mvc
instruction cannot be used. This is quite slow, but can be optimized
with the mvcrl instruction, which is available since z15.

Some numbers (measured on a shared z16 LPAR) show that the new
implementation is nearly always faster, except for the non realistic
one and two byte cases:

size    old   new
   1    2ns   3ns
   2    4ns   5ns
   4    5ns   5ns
   8    8ns   5ns
  16   12ns   6ns
  32    8ns   7ns
  64   15ns   7ns
 128   31ns   9ns
 256   64ns  10ns
 512  129ns  18ns
1024  250ns  19ns
2048  498ns  38ns

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/string.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 2f9e9e886016..e93e1acd2ade 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/export.h>
+#include <asm/facility.h>
 #include <asm/asm.h>
 
 #define SYMBOL_FUNCTION_ALIAS(alias, name)		\
@@ -51,8 +52,29 @@ noinstr void *__memmove(void *dest, const void *src, size_t n)
 				: [d] "a" (d), [s] "a" (s), [n] "a" (n - 1)
 				: "memory");
 		}
+		return dest;
+	}
+	/* Backward copy */
+	if (test_facility(61)) {
+		/* Use mvcrl instruction if available */
+		while (n >= 256) {
+			asm volatile(
+				"	lghi	%%r0,255\n"
+				"	.insn	sse,0xe50a00000000,%[d],%[s]\n"
+				: [d] "=Q" (*(d + n - 256))
+				: [s] "Q" (*(s + n - 256))
+				: "0", "memory");
+			n -= 256;
+		}
+		if (n) {
+			asm volatile(
+				"	lgr	%%r0,%[n]\n"
+				"	.insn	sse,0xe50a00000000,%[d],%[s]\n"
+				: [d] "=Q" (*d)
+				: [s] "Q" (*s), [n] "d" (n - 1)
+				: "0", "memory");
+		}
 	} else {
-		/* Backward copy */
 		while (n--)
 			d[n] = s[n];
 	}
-- 
2.53.0

