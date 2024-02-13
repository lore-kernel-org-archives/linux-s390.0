Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2382C689
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821251; cv=none; b=s9EiaZXlBcDJoEkeecIz7cws2HJZIsfMnPR4ziymzDQAc4cAP5bvYtMInvz886kWbet0ERRsnRUPqMWtIitxcz0UhXXe7lFxAoOoj7YUI/gUTSUftdPjtRlwvrcf3elh9ps1XhLmkjgvmaOcWjOM1/lGLdivZqnokUDHQvtApBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821251; c=relaxed/simple;
	bh=jm0Wr3MR3EiOXU1w4NByDGEYKQLpEki8m8njp0pfQ1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNf7VeYqHHiK1mNr2ZyY72l/rKjVu3XCu+alCrVWe2iyeDjgx8Py/KDJTwzPTRrRWiwBClkeGray/5msfrgiG+jB/uURfzGwEM7N5JuQh8Lj5xbW+pIv4yE4Kyn23lgrPsuHsXcPgzNdi8cyuOhQTLXWwu5j/7BDPCJYE8myzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tn6907gb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tn6907gb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAjudX021295;
	Tue, 13 Feb 2024 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=YNE4zwW+xm/AqwjuQhvJfQY+mw0P7eaf1SRUUi4ZQ1s=;
 b=tn6907gbcEK9gjmCkETU/04wTcwAchLi9yvvUFR5Cr2TxxT7qObxhq5cz6E0URAqFfjm
 TtKgCzmpxMYAZfR80o1eSJc7iU2+t/ykS+aaJ6u9phF43VSn5fOH9HLt1EmTS19/1Trh
 BtNeaO56G+lLLsmOBBDEsb9jEx6sLInhdGdTGzJ3E3si8y05aOG9VRPKHGCg+GMjiOP9
 BRBv/OLhLT6R7X9CzrM+OwBjabqv1RheB8bjvcXtoCfSbrtREbLLhkXZUHHvyjo3dXMj
 tfoptkCy7+rRdgEb41Bl1fz3cTFZIYL+wGQwVHYp48GuFfMs8jPs+BySS6tmwk8NGjFM ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w861fsjmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:25 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAkltI025437;
	Tue, 13 Feb 2024 10:47:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w861fsjma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAiAhM004251;
	Tue, 13 Feb 2024 10:47:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv070y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DAlKl721037636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 10:47:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD7620040;
	Tue, 13 Feb 2024 10:47:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28FE720043;
	Tue, 13 Feb 2024 10:47:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 10:47:20 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH 1/4] s390/vdso64: filter out munaligned-symbols flag for vdso
Date: Tue, 13 Feb 2024 11:47:04 +0100
Message-Id: <20240213104707.673053-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240213104707.673053-1-sumanthk@linux.ibm.com>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 36-5HEymy-dbYGPZ2wEpCVwTFY1uK5Fn
X-Proofpoint-GUID: rfcdxPS6JII36Bq7iYto_7XxAI89N_2t
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=992 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085

Gcc recently implemented an optimization [1] for loading symbols without
explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
symbols to reside on a 2-byte boundary, enabling the use of the larl
instruction. However, kernel linker scripts may still generate unaligned
symbols. To address this, a new -munaligned-symbols option has been
introduced [2] in recent gcc versions.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
[2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html

However, when -munaligned-symbols  is used in vdso code, it leads to the
following compilation error:
`.data.rel.ro.local' referenced in section `.text' of
arch/s390/kernel/vdso64/vdso64_generic.o: defined in discarded section
`.data.rel.ro.local' of arch/s390/kernel/vdso64/vdso64_generic.o

vdso linker script discards .data section to make it lightweight.
However, -munaligned-symbols in vdso object files references literal
pool and accesses _vdso_data. Hence, compile vdso code without
-munaligned-symbols.  This means in the future, vdso code should deal
with alignment of newly introduced unaligned linker symbols.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/vdso64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index caa4ebff8a19..ef9832726097 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -25,6 +25,7 @@ KBUILD_AFLAGS_64 += -m64
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
 ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
-- 
2.40.1

