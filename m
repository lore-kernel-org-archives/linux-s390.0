Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67A2E717B;
	Mon, 13 Jul 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953761; cv=none; b=TwN6+rOphVtlG0uTt3/AvpFm3mF7a7v9AMQjMk/uXqWv5T7hysU0aqHtUR9atb2UF3ERk0UOB1T3FIcRvdPECNKknJDFs9TNc2wbbnqjERjYUGYEIPt5YMt915QSm8WoMOGRBk80yKXeeSjHsjE3vCiA1zrs12VBGcYK1BQupss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953761; c=relaxed/simple;
	bh=iabG4KaHMAFgIP/hl9Tw8UiinIMFdIcE0Acb2x5Cva0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFB+HUgL6SiygY+f3gz7L78vWBRQqZW3hzKzPKY0ecHLMs2/iGc96Jo4lmR/N5LsyiC2yaHZZNDbA860tqluZk2Wjqq3SWAHPtbdiUVcw0a84K58YLhncA6zC3XIkaGeIqX4bpRZkrj0r8CHxMo9VJkU8jId49B9LRFeY1KFqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f2Dqx75M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f2Dqx75M"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCCtT32436836;
	Mon, 13 Jul 2026 14:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hPWEe1LZgxgXeLb6M
	6ajmP41gT9kJJFafTJpnDDJCPg=; b=f2Dqx75MoskAQI2Up3hIBZxKSXptLGIIT
	dkvr6Wcjo2hKt3lVuF1ccke+321CCue+vLKntR5uJEKwrzTTg6wSacNYHa7Pe5DI
	IgRd/GnNAT7uJcLKNmXka69IiQe0VYCWhKOOi2QW2g5nUy6CoZepYonxy3lEkiWV
	u6G8dFX4YSJFf26qWpBxmO2y2kiWhmPH/Opufquwkv37Afo1k2/iJQ5QjE2+OQWe
	GZOolbAfKmWfxz5u9IRQeyXCFpzykQLJJ+XWN15fXYzADqv7gNCDU7BFcQNN1dME
	cyXFwSP3ZyhpFmXw6UuyINuJuVVlUJW6Rpjkj716oN9V67ko/XX+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx968f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DEYbDs017251;
	Mon, 13 Jul 2026 14:42:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg5wbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DEgYob40567048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 14:42:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7C6620040;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4D92004F;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/vdso: Pass --eh-frame-hdr to the linker
Date: Mon, 13 Jul 2026 16:42:30 +0200
Message-ID: <20260713144231.1251145-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713144231.1251145-1-jremus@linux.ibm.com>
References: <20260713144231.1251145-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bod-sMdfoxY0UXp8dKt_1Csx2xG6rszC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX46dthGslH3eg
 zLAf+IXRLA366p7ZNP/yvdU/rQi+Pl8tT/AjugYvyCCisZat52DAdJdZqoF9ti2dwiX5/KYZETl
 P6A+k0YnxdW/ID54+/YQktwTqKoLM2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX4IhRa7Wsduq0
 1hJUBGi7KeIkTBC7di/GPKhKyVP0j7whhwgXQ+MTqQlMJnaMPPUtl4KxpzWT0UZyFkAmoVW786L
 keGOCzY8lJUfJBVCucRe2lWxBEvygbFL0y+1POIRMW3YUJxZd5wRZYPTja/0SFlSfkIVpxVyi6R
 X0i/V2yhg50V34Vt2SShqqDJHCmsjUjxSyNdJ0vXWAtz+uQapKvX7AC6d9R/bjkKvYyi/jCRK9/
 iDGi0sPfIKlhmxZSiCSZyT3ZWO+YEZo5twWu9bqJ9JdysfOKIM6WKE2Ovmr4z8Rje4/3PHOLacX
 3euZ25Ee6mjoKz4EY/LRKwBnrRqerjjRdRVToj4Yq1AFSaQS6EwAMSBwTW+MASNHoWAaXjX/9ss
 JwCwm1849sPcrjRFVNojO9+PDb0qga6B9fC0jRxR2X7f3bHgIaPYZwObBNwBoU5Y8klFONCzKy3
 tebuqaE2v+U7zgIwpNw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54f95e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dYg8pFQ3rrFs5WubTz0A:9
X-Proofpoint-ORIG-GUID: bod-sMdfoxY0UXp8dKt_1Csx2xG6rszC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

Commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link
vDSO") accidentally broke the GNU_EH_FRAME program table entry in
the vDSO, causing it to be empty:

  $ readelf --program-headers arch/s390/kernel/vdso/vdso.so
  ...
  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
  ...
    GNU_EH_FRAME   0x0000000000000000 0x0000000000000000 0x0000000000000000
                   0x0000000000000000 0x0000000000000000         0x8
  ...

Originally, the compiler would implicitly add --eh-frame-hdr when
invoking the linker, but when this Makefile was converted from invoking
the linker via the compiler, to invoking it directly, the option was
missed.

This is the s390 variant of x86 commit cd01544a268a ("x86/vdso: Pass
--eh-frame-hdr to the linker").

Fixes: 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v2:
    - Correct GNU_EH_FRAME PHDR name in commit message.

 arch/s390/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index fece5d975eaf..35c834b895ec 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLA
 KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
 KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
 ldflags-y := -shared -soname=linux-vdso.so.1 \
-	     --hash-style=both --build-id=sha1 -T
+	     --hash-style=both --build-id=sha1 \
+	     $(call ld-option, --eh-frame-hdr) -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_VDSO)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_VDSO)
-- 
2.53.0

