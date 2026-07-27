Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5A2EC571;
	Mon, 27 Jul 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161142; cv=none; b=WLuUBs3wtjDY6f5YWUpI1BFOUp4+LEBuCl8KtDWugAgnWLTUiCTl1fh3c+nyAUyZBlRyB84Bp5ptkgd6TisnbXQDDIyVF+l6RkS0wml6OQ2pgZIvkHTYnhOA6hlToxcaOphuP6P92sPmJQqTVuBC01DXBGXSnFXaYhXiY3/RsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161142; c=relaxed/simple;
	bh=A7qJkMTjxRquoJ2QgBAWgqIF9D2mNKN7a7VRe8KIFvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeeNxySxPd4uOFP/b5HW0t2R66FwAW/+Gc4KDyX+PbYsyyLfBPvgYC+ehPT2vfyEvMs3aSeVHeNYFj9izKF8K2Dly4y1DBr6m8nLnPGR4IFOWxvuHMheL9WOcGVww/x5f2vr5F0EeRDU98WpCLjQcHtaUQpRlTNQSH7e7QoV8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiFuPbQt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiFuPbQt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn7K92407964;
	Mon, 27 Jul 2026 14:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4vCemSz3No9Aqz0xJ
	X38sw0uhRZr2ODZGpDlRpTd/Ig=; b=HiFuPbQtDEXLrKVBXBAoPIjqws+LmpXkF
	fzb6YqpH0TpXUWyO4zQU4jWLHNA2TEr+afZBCFVTTG1N2dcA1SLToZxXoEEiJcvh
	kIxdeSqZSawsuNufIrLbZJb4jpEugnbVz4+Lo6I7qhzLqePp2o4usOPMuUbFF1fU
	zCEt0rO4GiXeUO7v+7LCJLNTohsf0UdV49UIzq624D6o1M3Qp0rM7Na4g4oUQtWn
	QI7CpsCk1AAWNy0f10ItniYzE2RN+hbsgc7oXy8ogF4+Xh2zpr7R/QWegZolVy19
	UDOs1kkINDLiXzocYgjTjfMBfqxk4pe5Qp/ZjVBCSCSTVDzglPniQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgcpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDucAT024726;
	Mon, 27 Jul 2026 14:05:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwnqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RE5Ik629950242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:05:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183452007A;
	Mon, 27 Jul 2026 14:05:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8CD420076;
	Mon, 27 Jul 2026 14:05:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:14 +0000 (GMT)
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
Subject: [PATCH v2 2/6] s390/tools/relocs: Ignore __kcfi_typeid_ relocations
Date: Mon, 27 Jul 2026 16:05:09 +0200
Message-ID: <20260727140514.116501-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 35-atqU20jLTIT9wDLZo2DMPHSiSGyHq
X-Proofpoint-ORIG-GUID: hhrWXmcNDY5F8PupC9Emy9xkqW-xcoMT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX9Kw3c4xuRH/p
 VqbHjnJZCMOx5kxxlJ/V59f333P0meEOsH/dtHHyjhuMlYmreEr2neuoTBVFEK8DmMDbkIlgCtD
 NrQfVIqNY7m5fEUIddwOfFP74iiewGY=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6765a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=88w2KFz2_lgIV2xuEDwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX/EHKRpfRtGUI
 +oyRZqzXE8a5epkzrJPx9ixvVQYpP1KGLCo/+R1pNywYRRekqgiH/9HH4flBcJ+4PwmsyfF+ZJ3
 PrE+ecsn1QwGt1+vijxs973sWrbLz1YJRzZwqdsYoW2jika+fXSD72FlAAQNx9OYzBzz/nYNu9p
 3y80WT2hw2NjRdsL3ij1ApZpaq8IHJx2wEEXl12CHW9V2uIMjGLseL86vVdXBjmZp5/oPPD+Pd4
 0EN1x/q1/cPX1/z94oYg7DtvsQruaoXeyc9qLcOk85mVF3wlk6BLb4SFiQGoyWtxkUhF6SfxP5R
 ujOz5/RqGge+uwKIyfhVIhrIAGeWTxuAQCWvzVyCAgP2cB5LuZSxfY5gEYJnIulJOW0cYHs2Dlb
 cju3bJ5sCQux5ELeOwUnOJIneTWGJGxy8Qu6tDG+gxMGcay5uAMcVLChR7td1qNcN2KUWS1U+3Z
 WWhKr7DgFIkODbpU4Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270132

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

