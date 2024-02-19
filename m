Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2E36122
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349281; cv=none; b=uSJbY0huC4A6ovLbooy7z2FRhL1RIzSGYRqnu2/wcKx+z9wDfzC4Jyq+EhQk7mFePAsqc0LULuemMgWX6Pjb5Ko1rKdVa3mBQuczvuHcBdxIdENg3+PxKDe+UXNsec3YLowtnC0NyKe1vFIFtuv8DwKycIQA4zgXni/ByE7MusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349281; c=relaxed/simple;
	bh=UGvygy7p5kHfxR3+jF0V2TbD3mphIqhuzLxOQrb3Fcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hc0+mcIk37y2ZH21wMcWCwvPMDEjCde7mUm0W/hX35k1Lc1YVVvJpOnBjdOf/r8/dl0/MGIh043Ub8XCmEUEQObldi0X1TJdGzZYImFt5Vqk8tVrs3KlSdVy4KPHoer+cBCgwrR5m0x1aQ3tU8t/mYD6wUeir7I0x9oVSxwSFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XQECU0/T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XQECU0/T"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCs0oq004835;
	Mon, 19 Feb 2024 13:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=om9KOMNfUwoxR4Xf/CBArkmg/Cm6V6Bfg8Lj3+ziwRQ=;
 b=XQECU0/TC6pxCOjKDw6BIYPZKZ97zKu9sEeLatmK/eouVll12+3Os7cpPATF3HMPfOKK
 uw8M1L0iwOYdNTa+yC5aHWT/sJ+Yo2L+gFH5jwjUA4zbHUt7qRyzvQ1oWVUhUi1ld+No
 uOuYC9pGmX9mqhm612VQU/x0Uo+DxGDZM+NxefGiLHmdqEGeOXztF7Ts45QjoeQmrDlt
 HijGoVOyi0BYzSqeYcLlt5AKGvhERbdBRn22jFEmJ/aFatZ1aJwpRvnGMpac5SLz0HjI
 iSjSTZ54vwH5Q0BqmoiPVbMTb5XDXWRVXNwgBu+fhsWpK+gwT4ReoDPIzAFHmH+2pj93 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7d3gx5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:27:56 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JCwFVS017340;
	Mon, 19 Feb 2024 13:27:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7d3gx4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:27:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDJGgR013472;
	Mon, 19 Feb 2024 13:27:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h01nk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:27:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JDRn0h64487906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:27:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBFE20043;
	Mon, 19 Feb 2024 13:27:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71D3820040;
	Mon, 19 Feb 2024 13:27:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 13:27:49 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, gor@linux.ibm.com
Cc: iii@linux.ibm.com, agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH v2 1/4] s390/vdso64: filter out munaligned-symbols flag for vdso
Date: Mon, 19 Feb 2024 14:27:31 +0100
Message-Id: <20240219132734.22881-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219132734.22881-1-sumanthk@linux.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CLYvPjohgnjjKKLH3VU1XIwTlWgu-fvP
X-Proofpoint-GUID: BGqw0gP4AnyVkc4cq5IO8pbNjXU754k3
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
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190100

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

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
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

