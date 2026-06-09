Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A13F4859
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001233; cv=none; b=ABYW4Lu0bEzv4ReaU8LAOW8/p1BCtKdwZ1laQoa8VU0mPZZ67iDN659tCgYqh/+HQpXD5P+tlKKYRCxnSllWoJB9W/IP8G7Ycl35BURz+/DM/wOOggTeOUONLtxwzdWTDYS4QfwtToIFTJOOYZkXos605kr7GvUvyozEzKHKk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001233; c=relaxed/simple;
	bh=yd8wrsM7RRXZhD2lBDrrd2kjkB8UE7Jn0VucPZoRnaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnXiGSGEzQrb3UWGY24PP18FXV5jvLG5sg6Zip50W69c69N/ZND/mZKqL7Mz8Up44/Qll84XOjZG6TdBgC2TsEJlnZLxN+OvW6g8tSKZqSLLh4vaMOGssjkWcNmcCtBZ3POJeUu1IsQvckvhDjSiAvjnzumRBCUiYjtlFpV5p7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWWdlrPb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWWdlrPb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LSAGU3159944
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gimksEmLt+ThcYTYc
	iJlD5wDMG0rdgb55KMimcyyKEg=; b=fWWdlrPbmteXDFYgc+bjvTpneg72rE2he
	Gvpk4upv0Tr/3BLI/bfKvA9IR3W9UIi4dOnFyZMVh8yZ5EFfWSfiMibVZ/Ya2NUV
	g7TsXC/NtcRQxWt7P7ck2pbSPCxgIFXo18qAFHikFL4L1xrfSjz/AgSPb0/chdel
	w1bpOWL25xGWUDjQLUXE6YYV2mxacbTbsHtezExISyuS2q2YpTVwhsqYwFyfKh0u
	k9HZT2U9jSJi5LPJpd4lqfwl0qf3dwhr7W7l7/s1tikGoLk2rDUH12lyOqm7y6oz
	GPYUx0joVp+l35DiaNUO7kj2pa5OQZDqQS2LvHOPswmeYZIGrMouw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye3h2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659A51kB005569
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w1n5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXjor25559510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676342004B;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B1A20043;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 8/9] s390/memmove: Optimize backward copy case
Date: Tue,  9 Jun 2026 12:33:42 +0200
Message-ID: <20260609103343.107325-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609103343.107325-1-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX4pUTNMOXuJ4P
 7YZYa3OUJFNxwFI1asvr3E3N+WjaAGMXm5jnagFIFwlC0yLJxX5VqSedHkeaqmph39jeyb77sK0
 k3S2lMw9lV8xt5GsxzN6//f4k0DYq0XOa3s7dGqSa/z/O0cbQ0La8oqXHq61+TgKkPIwMQfPFDk
 TW+vg+Q6O4aEFqATP1MMLa4daBZod1OOHXSA1kRwLlgJ3Y5SMZrZgfgfuzjaZl8Lu5d77z6g3v7
 OxSUESb3O7YpBcYGK/mnAUL7LNWFoENA6vVCKNDqcGRQuN9kQTovWc7jA+N140ONIVkUmIUPe4s
 DuiO0o+0Gg7kCu4rTSv5Fzvhf3N4yfu2OoxtJnsgQYHtpQ7OlFmnwuCknRB0RLVlLn5skwPVNz4
 8/vygAfMogxAvKQtXf249pj4cy//3cCd8wPWGBez+pzValnek4njz3O5LOlDq13+5Op/B0VCK73
 Od6jWSNY/YCYqe1Cxrw==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27ec0d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=JR0CvQFn8sAsJeSSqqQA:9
X-Proofpoint-GUID: BCr9T_sTsjIp8ioodMRPUDvRWnAWU88R
X-Proofpoint-ORIG-GUID: BCr9T_sTsjIp8ioodMRPUDvRWnAWU88R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

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

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
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

