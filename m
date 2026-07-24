Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7C429033;
	Fri, 24 Jul 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902422; cv=none; b=H3KyJAio1fo2R1yNLCrC2wZbnlTnX4GNgP+6uoVF314s6x1hKa63yV4LZPc7de4DtsnrooLB4PGwQVgCdL8uHPB8IAvvOaUHlJNmWWGMZgZqo7qa9837KUGwjj8K78/xQqbUuap++rjScmFH64HdKGH/VnwCzEaQH7h47R1aINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902422; c=relaxed/simple;
	bh=A7qJkMTjxRquoJ2QgBAWgqIF9D2mNKN7a7VRe8KIFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6jPOGL0F7x/7AA5bT8jBO5NigYVPjc+/grcr79NQzYpAaTawjsS3Fw1rn6GxYHFJ27L4Ij2geqZNPFN875ldc0Fomjn+TKRj+eoGiq0luiLkTCnDGSKW+Yx3TvnpV8qgbvyGM/xuVG+2AoRzrqzQz/2x7ntEsDvepzliJh4Dic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xn3JmCdA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xn3JmCdA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfjd1100527;
	Fri, 24 Jul 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4vCemSz3No9Aqz0xJ
	X38sw0uhRZr2ODZGpDlRpTd/Ig=; b=Xn3JmCdAWuIjkMR1MKhZxD/cILYDF28tO
	0U7ZZ0sXDiojzhOfb4J1gpGCzcLnoYq9w4XvHMqmInhCqeeTyT9rlz7e136NpGVv
	N3vkqpA5iYeWYCxrjxsc8dzesfnu4lbcx9KuGmADXetLEuD0LNjLl/2dwj5udAaA
	AQrRtVEN2EHIFXw9ShRh8x2u4U3ZdRBnkHg5dASGUzoSEnl6unqbR2w6MFRpECRm
	Lrj8OKnaEN9X0BM1G2QR3KoQs9ZvbljENJZS5F92X2gtzUU6l7Q+ZXBGUbGvhMCQ
	vYU6gXYOQOyLiqAVI15czdjhKawpRdhCzSS4aq0JPfnxue6X5iOCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8arp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4lua014575;
	Fri, 24 Jul 2026 14:13:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk97gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDMft11600330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100D920116;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB42920128;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] s390/tools/relocs: Ignore __kcfi_typeid_ relocations
Date: Fri, 24 Jul 2026 16:13:14 +0200
Message-ID: <20260724141318.1037434-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724141318.1037434-1-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX+3SI6WCULHVZ
 1Ncy0jcP64StcVTb7TOBFWA0B52zcMz9SgVE1QEfehC6N2tVs7bukIEmMXfQQYf51RTu8SfXEL4
 Ty2WlUVMdDtCO3cf/1dMJNW4wiawuds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX84WQiSjz49c4
 1E/FSx2HxKGABuAvBll5ewoW/cng8dRHizmVLFg0WzOjSpbCZmvPqO/S8Nj5+wQ2sXvwq1pOF4i
 ZGpvt0rEFITX31u3Vk45DxZ/h0W4dloceyMAxh4vzWAjRdrpmDDAdZu6da/2lSgEGhyRE9bk2LK
 OXdQmMqh59CupQNBtwt2gONGvtSN1TAVN3YH0da+eOEn7BR9omdT6gMGG/BqiJrXvXmUJv+2koo
 EO8mr/nRg05XXcdzxIYaGW17ZZGyOZctyn7y4tBriT2iAREzP7rJY6INDqNiZm3ij3kiCW1kL7a
 nBrIg/iPr16Fugk97UzSct3bnREfMKSfhTx5I6Iea+q5Tv5zHPUb6iZSmz97TNoU1Flbkgn3YW5
 hjvfFSmJldLc6h9aTitulv6hSQ68qcQaZPt6zcGHw0/hGaWFLIpCLLi998naib6AZMBq1FA+aCy
 IP/cDDmWJxb+Po/kpbw==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a637307 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=88w2KFz2_lgIV2xuEDwA:9
X-Proofpoint-ORIG-GUID: JyU-SU_fQd40G7p_9rgmMaXi-HY18Xbl
X-Proofpoint-GUID: lxGROCQQ-laPD0cwlQYwmSaXCDpTcO3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

This is the s390 variant of commit ca7e10bff196 ("x86/tools/relocs: Ignore
__kcfi_typeid_ relocations"):

"The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be referenced
in assembly code and are resolved by the linker. Ignore them in relocs."

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/tools/relocs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
index a2774176d38f..72178dc90a4c 100644
--- a/arch/s390/tools/relocs.c
+++ b/arch/s390/tools/relocs.c
@@ -405,6 +405,22 @@ static int do_reloc(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_390_GOTPCDBL:
 	case R_390_GOTOFF64:
 		break;
+	case R_390_32: {
+		static const char kcfipfx[] = "__kcfi_typeid_";
+
+		if (sym->st_shndx != SHN_ABS)
+			die("Unsupported relocation type: %d\n", r_type);
+		/*
+		 * Symbols with __kcfi_typeid_ prefix have constant values,
+		 * which do not change if bzImage is loaded at a different
+		 * physical address than the address for which it has been
+		 * compiled.
+		 */
+		if (!strncmp(kcfipfx, symname, sizeof(kcfipfx) - 1))
+			break;
+		die("Invalid absolute R_390_32 relocation: %s\n", symname);
+		break;
+	}
 	case R_390_64:
 		add_reloc(&relocs64, offset);
 		break;
-- 
2.53.0

