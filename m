Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545F3F39C6
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001230; cv=none; b=aPxxZTUgqBaNx5vzRcH4tngNqYV53PgnYT/ZjZbIiSHaaiXuaPy2YvcNpgyy/IEYoz8FqkO1heRSAc7B/qXqsGVUhQnRUaECcUEJwrb0+GSthxrwkSxK+sKFEq3nm+T/bmSQecWrkoBxnWndcRsXwN4UWY+D46pIM35jbAUuyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001230; c=relaxed/simple;
	bh=Bf7aBJZkWvTkSKsh8Rrhe/UTJd559YmFW8Fj8eVFG9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rok8xioWE+oOiknVTtYCk5ybUEzMUtD6iQ4M3Zz3HVoOPdfa+Ul+D1otQw6BWNOTByaOe698lw6QX1yTxXQaDUiiw0hJUWT1Hm90f4VgEEFeVNDbv5zAJK/6RRw2UqwQnHqF4nuiktt5X0uXDENjic3mqgCHsnHv+BWBUd8T4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UF0985mq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UF0985mq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658JhO5e2817660
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J1hm5EJiVsqlUYtha
	RMIyYVGhuhpL4N3+/WyGU5styc=; b=UF0985mqac5wT3dhf0A7jnOGWLSUK6M6m
	dWL25QRnx74oIb6HmDkrNQVjVy9nt1aic+34SQl8I3Rh2Lj6SBkZ6cEytRKMEUPc
	/4N9dujUXp+uQ51obCAQG2ARgSn2qF3VYowDUyPzX/VoPMbGw1mCmQwrdqc++o7U
	XhjPOpJXEiqkq0khPH7XvdSo6bqC/P2hbi+9wdOTN2T97ArVj3Vom7rT1oh0C+76
	gaWRYyvrbCuxG9Ss35DcKzSHDeSZwv8B7tESWrhPGz1JnFjhL6bbrfwAjI1F0JUh
	P+msyXsd0mTt/damREiU68PUUyqSi0W1RJ4zheApupF3XVKZcXXvw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23upnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AJcMN009120
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 10:33:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1q19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 10:33:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659AXiTG47841730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E85020040;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FAE92004B;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 10:33:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 1/9] s390/purgatory: Enforce z10 minimum architecture level
Date: Tue,  9 Jun 2026 12:33:35 +0200
Message-ID: <20260609103343.107325-2-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a27ec0c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=foj3guEW7u1rp_cjtnkA:9
X-Proofpoint-ORIG-GUID: PUlvYb8oAkQnAcmiIwWhlryOQ_TIklCk
X-Proofpoint-GUID: PUlvYb8oAkQnAcmiIwWhlryOQ_TIklCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NCBTYWx0ZWRfX96KW6rClP6fM
 JrpRAh+JZ2Sxkfw2uGFCdhdXUi1B+rvnXtmqAqAMxmD772xa3sfub5sdthq2+jtvAIXKafL2j8K
 g+2bmhs+4l9BpGzQD/NRK9jsWueDq/k/Ab33uX8a1iln532Hf9l3/yvsfoo4z+bpY/C+f+2S9+d
 ux9dQJpWAApGE+HQsuGUiqKxDHNqkDoKaWp1Q1I/ZztsH7onjoFogKolaRmUFkAcmuFfIuvyEYm
 IrCSHWSQ1P7ULRDgFfPvRWET2ajmDAjrL/U5MEdQGz3o1iYc6GUpDhTIXx/xU73aRsk/Ul04Qwf
 ndzNFk3ZFQF7jHbzFgDnLduaSnCEvnM32MgXn6wnDwYslV7RTthZfPD1EpotlHjdXF1ZpdTGDpq
 2u1ChDqOV5q8XwBhaGX4b6ZzF/0HPyIIqogXnIiahTBw3Ho2LPzkcPgDACJTBColtfoxDZiYFgj
 AGjckaXnkhNT+NeiWmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090094

The purgatory code is compiled without the -march option. This means the
default architecture level of the compiler is used. This can cause
problems, e.g. if instructions used in inline assemblies are for a higher
architecture level than the default architecture level of the compiler.

Use z10 as minimum architecture level, similar to the boot code, to enforce
a defined architecture level set.

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/purgatory/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 95a8ac45b67e..f55764d0c49e 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,18 +13,20 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+CC_FLAGS_MARCH_MINIMUM := -march=z10
+
 KBUILD_CFLAGS := $(CC_FLAGS_DIALECT) -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-KBUILD_AFLAGS += -D__DISABLE_EXPORTS
+KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 
 # Since we link purgatory with -r unresolved symbols are not checked, so we
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-- 
2.53.0

