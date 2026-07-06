Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F13859C3;
	Mon,  6 Jul 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351162; cv=none; b=Bwcr8f0Md7ztuO2Jylc8tscORP9a7ijUOLcISpzppypeZ9XSlkKhyQtaQLX0mIdZnOGtVBXW7FAo8e0VKdrlknYufYG107/pMVAPtOVKdK7SpTBjFpVPZr0QI5X5UtWCgT6AYgFJMCNmkdhOMPfeerjYsBE/wDhlcHn2LnEKdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351162; c=relaxed/simple;
	bh=crr6e92UYbnOiBmKRJFy1xTpM/eYRBJgLO5h43Q8XVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aepd7ibLSl5PBJ647RrQZAEO0ubOg4GZmCN5soMQhddcfdIdaJaLmQyMwJ962QbeR9kp8g2OhVo8cEzWWva6ejzzUToovSZYKNx0E9JDvslaPpP7SpLGUSZ/LN31sxaQ/v5p60DtkTzMXT5wTdIGIYIn5+LGt5HX3017Saj+fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZjSO+okR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZjSO+okR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIiPh4050270;
	Mon, 6 Jul 2026 15:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/5sUVAJrfq484lNgC
	e/cuhdckIM5By4Yk+SM35gOaNQ=; b=ZjSO+okRnyhQ94aIadIBT2+AHmvt0iyls
	xkXnESDmPGme/+N78HcT0ULzRICUMW1PqKvIWm9QD1Gx7fKG1lSy3GH9RldN4Nrs
	U3X9CgxoH0Qv+EtQJB83W30p8A2WxkUkPAzoFVAh3rhIFFmdmLEZFshtuVugRj4G
	6df+JgH5ejV5qR30SwfUDavh7D7sU0BC4J4VqVbn3Cg0uZLAvMuzHbD9A9S9q5dj
	9LGxnGkEalqQCE8VIeCPnzBPuzi6jgLD2q/bLSCyVPeBUrADLza8VZ8bluVrUdeB
	ou2zxQFSG1xnV4Gu554IcN5y2Q8+CrTd5nmPMmKxABSIXi15+l+KA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsjkav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666F4i2s021948;
	Mon, 6 Jul 2026 15:19:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xwsju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666FJAN343319652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 15:19:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D796E20040;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6BD2004B;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] s390/vdso: Pass --eh-frame-hdr to the linker
Date: Mon,  6 Jul 2026 17:19:08 +0200
Message-ID: <20260706151909.103539-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706151909.103539-1-jremus@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VPWIJbwtFuas-SJqqqqc2tmE-FKmiuco
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX1JUhVwl5xOZX
 IsRlWWlbeF5ALs+d4ma1QSbawm44sYhKK/+tZMh7WeW9gWWNabTTX4IWH31eGrchgKdM1a+t6h7
 QLDO0kmHIuedge+gl0ZCrABJVkaxSrc=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bc773 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OKAa83DCvVXqVi0mjNAA:9
X-Proofpoint-GUID: VPWIJbwtFuas-SJqqqqc2tmE-FKmiuco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX2EcL1QcEeM2D
 WW2nXoHQcvaKj5sb+Ed5ijxYRgtrlQT8vQJHe+LF2AqwjfCUJK4V6UUCNLOmZU+KcBJWeXKB9E8
 PB0GWK+dZlUY/nDb3PcokcGZKWoChYTbxy704ls7gVYOThB7lsy/x6XJ2YZO9i5S0xL6Wy5DMzn
 +B4fZeR17qxXVNhTg1aB6z6YrTazJ+MlY1Bxkt9mx5+iXjwC/CtUOi0g4UA03bc//ukuVwGCj2d
 f5Us+UHifdEfRXtYLf+ZKJH2OF+E6eeSe/upJvjMiZwVy8vp0FJiJYcPnnydkRB51UfMXTh3LST
 P5cD2Mek+JtQ0nQmJqDlv1zq9jinlSsFjIBWkAPDbKUQiJ58gcrCMz+IjdarweMhKr3jdHs7mrf
 6i5zv6AhuqxwMf29sz+K7rsczX0+23myNGwgzAfIoS0sn5QaVZnWEQlTcXvjLvucEEeRFXot1Kk
 xZLa8P52GnNGgnNd5/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060156

Commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link
vDSO") accidentally broke the GNU_PTR_EH_FRAME program table entry in
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
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
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

