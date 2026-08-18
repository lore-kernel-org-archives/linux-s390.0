Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63663A6EF1;
	Tue, 18 Aug 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064635; cv=none; b=gycN40MVUJY5f/ZaS8wTiJCwqWshadtt+8joF1gPkK5iFZFlAKeeVSJYrr8H0gnK7gJYHaN7e7ZDGTkFw8Kat0unVjKPb0x+ZxPaYOcfO4/m6KgTFhXbAwjQIpNw2c5f7bh76HXRQu8KktSpld4XKYm4fkKHz4yhgDTv1ro4JbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064635; c=relaxed/simple;
	bh=qpBGjOnxWJLwyFcNvJwhqaVYz+desv9IYZrg0vuSDec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3mMMssLrpO+IFHDR4MTQdYquZ8VQCzW9ScBZvJ01LL5buftfwYWazSGxMNuftZKd014xVUiwKmhL+ms6zLCoaszAGpZFQj76DPGdCC5rlkHawgHoBOA9tdylayQk1l6aeV+36HE8nUZx3eRb4kumDrFRKfYQJgPMkZmw+XClHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p/AOatu/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p/AOatu/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3e4V542451;
	Tue, 18 Aug 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g/+KIf6HT7LAHqydz
	XWIC4dBo6t+5n60IaqJJ2BxEOc=; b=p/AOatu/sVYTYKHcQCFF/FvKhal8zkRNz
	75zdHM30v9FT3T33oYIfYgFg5Zw6/gXhnzrnwJR6v6j0CgfTiQzp9AsROBJAHfY4
	s/W/CFBKJj5xIQuux0aAJKl6L3eswXA964w8/Kj71vAWQwl8hAdC3JTDz5mN3KkU
	QK2KLSgxpGBW/z8WYeEcOQQp6GpgkgIpR+qsfRyYiwERyx/6eo58rCxx1Mo6GLy0
	nD53bfgFI3ZZ+tOOQ2puwxsPuog91jPntgAnnGdZ+xxHwnJRvCYqrawCe1h1shIm
	CQT/dxi7sdm+pSQpiZ9iOV1QU4THNDLZkOkrheembKRVe7DSmCaLQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfH1K032407;
	Tue, 18 Aug 2026 14:50:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo2Dp51577226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6889C20040;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194E32004B;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 16/25] unwind_user/eh_frame: Add linear .eh_frame search fallback
Date: Tue, 18 Aug 2026 16:49:45 +0200
Message-ID: <20260818144954.2320378-17-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JWffoVpnokn7fAIjgvMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX58kMGnRX9DxH
 J29qCD6Zt8FCCJcCNvfx+NxaP7RstjEPHr6iiOV+RHCtQM/K3vXX0jURK3JDZaQanEbwFRteClA
 QRlXE+0rxpHzXu4SMHHN9maI5HzvmPg=
X-Proofpoint-GUID: jlny5mab30eI5TDpItJVE9F8eGd83IqE
X-Proofpoint-ORIG-GUID: 3IrNanoOas1yxJNJWARNXtw9jGYIUlfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX+plWV7bkeD8F
 iucRRXNXqCV5TXdHOQK9oWYvgCcpVCgjvgvxjTQQhioKdZ/bBdDLOW1uiDKCGvmaKQzZoyzls4N
 5tWVziIj5rypWDFRcKRehb/N8uv9t1u6FUn5GI8q1hD3k4amkU5RkAakC9LLdKUsqtmdvEtkRNw
 6be/yD5+dDe1OrdLTCEYT3YhERq5e3JPj8a2xcBfzYTx1OE/zOhwET/Kqqxp1OcmcWw3jWvHCh8
 JsMCxNValS3GU23TCP8JooQEGoPfGD8XMqglyuR8r9NoN/NvPN8/ZOdHlK2scLP2+7wOnEd4Nxw
 Lh0Hl2gweQErB99lBmyYLM3vAwrh9cqmDsDam+rpbKCcD++Y/zooRfhPkWYhg+9kcD+f0zLH/Ux
 OvwbOZBn2fTqoT0bfsdwyW4SRmKOu4naGSuSZji2FLPvj1evFpPxaFIKhtsWoMMQJPza0MD9cpJ
 MC2Lsr1yqAKVQPsHcpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

Fallback to a linear .eh_frame search when .eh_frame_hdr does not
contain a binary search table.  Add validation of the referenced
.eh_frame section as well.

While testing the .eh_frame validation, it was observed that many
ELF binaries contain .eh_frame sections without a zero terminator
("ZERO terminator" in readelf -wf output).

For linear search, this is problematic because .eh_frame_hdr only
provides a pointer to the start of the .eh_frame section and does
not describe its extent.  In the absence of a zero terminator,
__find_fde_lsearch() may walk beyond the end of the section when
there is no FDE for the IP.  This was discovered, as it causes the
added validation logic in eh_frame_validate_eh_frame() to read past
the section boundary.

Therefore linear .eh_frame search is guarded by config option
EH_FRAME_LINEAR_SEARCH.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch highlights a potential issue in the linear .eh_frame search
    path:  FDE iteration may read beyond the bounds of the section if it
    lacks a zero terminator.
    
    That said, .eh_frame_hdr sections without a binary search table do not
    appear to exist in practice, so I currently favor dropping this patch
    in a follow-up revision.
    
    It is not clear under what circumstances .eh_frame is generated without
    a zero terminator.  There have been several GNU linker commits related
    to the .eh_frame zero terminator over the years, including:
    - f60e73e9fc09 ("Drop unwanted zero terminators")
    - 4de1599bcf04 ("ld -r abort in _bfd_elf_write_section_eh_frame")
    - 2e0ce1c84d32 ("Align eh_frame FDEs according to their encoding")
    - af471f828cc7 ("PR22048, Incorrect .eh_frame section in libc.so")
    - 9866ffe25a0f ("Remove .eh_frame zero terminators")
    
    Perhaps the zero terminator is expected to originate from crtend.o,
    though this remains to be verified.
    
    IIUC, GCC's libgcc unwinder appears exhibit similar out-of-bounds
    behavior in its linear .eh_frame search path, if the zero terminator
    is absent.

 arch/Kconfig                   |   9 ++
 include/linux/eh_frame.h       |   1 +
 kernel/unwind/eh_frame.c       | 183 +++++++++++++++++++++++++++++++--
 kernel/unwind/eh_frame_debug.h |   4 +
 4 files changed, 188 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 30d9e876f28a..191baf01e948 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,15 @@ config HAVE_UNWIND_USER_EH_FRAME
 	bool
 	select UNWIND_USER
 
+config EH_FRAME_LINEAR_SEARCH
+	bool "Enable .eh_frame linear search fallback"
+	depends on HAVE_UNWIND_USER_EH_FRAME
+	help
+	  When a .eh_frame_hdr section has no binary search table, fallback
+	  to linear search of the .eh_frame section for a FDE for an IP.
+
+	  If unsure, say N.
+
 config EH_FRAME_VALIDATION
 	bool "Enable .eh_frame[_hdr] section debugging"
 	depends on HAVE_UNWIND_USER_EH_FRAME
diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index 65f87c2714d8..de68f21e1050 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -27,6 +27,7 @@ struct eh_frame_section {
 	unsigned long	binary_search_table_end;
 	unsigned long	fde_count;
 	u8		binary_search_table_enc;
+	bool		has_binary_search_table;
 };
 
 #define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, 0),
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 7f572d1711d3..ac288cec8021 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -509,10 +509,9 @@ static __always_inline int __read_fde(struct eh_frame_section *sec,
 	return -EFAULT;
 }
 
-
-static __always_inline int __find_fde(struct eh_frame_section *sec,
-				      unsigned long ip,
-				      struct eh_frame_fde *fde)
+static __always_inline int __find_fde_bsearch(struct eh_frame_section *sec,
+					      unsigned long ip,
+					      struct eh_frame_fde *fde)
 {
 	void __user *table_start_ptr;
 	unsigned long table_size;
@@ -590,6 +589,82 @@ static __always_inline int __find_fde(struct eh_frame_section *sec,
 	return -EFAULT;
 }
 
+#ifdef CONFIG_EH_FRAME_LINEAR_SEARCH
+
+static __always_inline int __find_fde_lsearch(struct eh_frame_section *sec,
+					      unsigned long ip,
+					      struct eh_frame_fde *fde)
+{
+	unsigned long start = sec->eh_frame_start;
+	unsigned long vma_end = sec->eh_frame_vma_end;
+	unsigned long cur;
+	int ret;
+
+	/* Linear search through .eh_frame */
+	cur = start;
+	while (cur >= start && cur < vma_end) {
+		unsigned long entry_start = cur, entry_end;
+		u32 length, cie_id;
+		struct eh_frame_fde _fde;
+
+		/* Read CIE/FDE length */
+		ret = GET_USER_INC(length, cur, vma_end);
+		if (ret)
+			return ret;
+		if (!length)
+			break;			/* End marker */
+		if (length == EH_FRAME_DWARF64_LENGTH)
+			return -EINVAL;		/* DWARF64, remove .eh_frame */
+		entry_end = entry_start + 4 + length;
+		if (entry_end > vma_end)
+			return -EFAULT;
+
+		/* Read CIE ID / FDE CIE pointer */
+		ret = GET_USER_INC(cie_id, cur, entry_end);
+		if (ret)
+			return ret;
+		if (cie_id == EH_FRAME_CIE_ID) {
+			/* This is a CIE, skip it */
+			cur = entry_end;
+			continue;
+		}
+
+		/* This is an FDE, check if it covers the IP */
+		ret = __read_fde(sec, entry_start, &_fde);
+		if (ret)
+			return ret;
+		if (ip >= _fde.func_addr && ip < _fde.func_addr + _fde.func_size) {
+			*fde = _fde;
+			return 0;
+		}
+
+		cur = entry_end;
+	}
+
+	return -ENOENT;
+}
+
+#else /* !CONFIG_EH_FRAME_LINEAR_SEARCH */
+
+static __always_inline int __find_fde_lsearch(struct eh_frame_section *sec,
+					      unsigned long ip,
+					      struct eh_frame_fde *fde)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_EH_FRAME_LINEAR_SEARCH */
+
+static __always_inline int __find_fde(struct eh_frame_section *sec,
+				      unsigned long ip,
+				      struct eh_frame_fde *fde)
+{
+	if (sec->has_binary_search_table)
+		return __find_fde_bsearch(sec, ip, fde);
+	else
+		return __find_fde_lsearch(sec, ip, fde);
+}
+
 /* Helper to convert DWARF register number to index (FP=0, RA=1) */
 static inline int reg_to_index(unsigned int reg)
 {
@@ -1165,7 +1240,7 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
 
 #ifdef CONFIG_EH_FRAME_VALIDATION
 
-static int eh_frame_validate_section(struct eh_frame_section *sec)
+static int eh_frame_validate_eh_frame_hdr(struct eh_frame_section *sec)
 {
 	void __user *table_start_ptr;
 	unsigned long table_size;
@@ -1246,6 +1321,90 @@ static int eh_frame_validate_section(struct eh_frame_section *sec)
 	return -EFAULT;
 }
 
+static int eh_frame_validate_eh_frame(struct eh_frame_section *sec)
+{
+	unsigned long start = sec->eh_frame_start;
+	unsigned long vma_end = sec->eh_frame_vma_end;
+	unsigned long cur;
+	int ret;
+
+	cur = start;
+	while (cur >= start && cur < vma_end) {
+		struct eh_frame_cie cie;
+		struct eh_frame_fde fde;
+		unsigned long entry_start = cur, entry_end;
+		u32 length, cie_id;
+
+		/* Read CIE/FDE length */
+		ret = GET_USER_INC(length, cur, vma_end);
+		if (ret) {
+			dbg_sec_ehf(cur, "failed to read CIE/FDE length\n");
+			return ret;
+		}
+		if (!length)
+			break;			/* End marker */
+		else if (length == EH_FRAME_DWARF64_LENGTH) {
+			dbg_sec_ehf(cur, "invalid CIE/FDE length (DWARF64)\n");
+			return -EINVAL;
+		}
+		entry_end = entry_start + 4 + length;
+
+		/* Read CIE ID / FDE CIE pointer */
+		ret = GET_USER_INC(cie_id, cur, entry_end);
+		if (ret) {
+			dbg_sec_ehf(cur, "failed to read CIE ID / FDE CIE pointer\n");
+			return ret;
+		}
+
+		if (cie_id == EH_FRAME_CIE_ID) {
+			/* This is a CIE */
+			ret = __read_cie(sec, entry_start, &cie);
+			if (ret) {
+				dbg_sec_ehf(entry_start, "failed to read CIE\n");
+				return ret;
+			}
+
+		} else {
+			/* This is a FDE */
+			ret = __read_fde(sec, entry_start, &fde);
+			if (ret) {
+				dbg_sec_ehf(entry_start, "failed to read FDE\n");
+				return ret;
+			}
+		}
+
+		cur = entry_end;
+	}
+
+	return 0;
+}
+
+static int eh_frame_validate_section(struct eh_frame_section *sec)
+{
+	int ret;
+
+	/*
+	 * Validate .eh_frame_hdr binary search table
+	 * (incl. all referenced FDE and CIE in .eh_frame).
+	 */
+	ret = eh_frame_validate_eh_frame_hdr(sec);
+	if (ret)
+		return ret;
+
+	/*
+	 * Validate .eh_frame CIE and FDE.  Skip if linear search
+	 * is disabled, as many .eh_frame sections lack a zero
+	 * terminator and the section end if unknown.
+	 */
+	if (IS_ENABLED(CONFIG_EH_FRAME_LINEAR_SEARCH)) {
+		ret = eh_frame_validate_eh_frame(sec);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 #else /* !CONFIG_EH_FRAME_VALIDATION */
 
 static int eh_frame_validate_section(struct eh_frame_section *sec) { return 0; }
@@ -1266,6 +1425,7 @@ static int eh_frame_read_header(struct eh_frame_section *sec)
 	unsigned long eh_frame_start, eh_frame_vma_end, table_start, table_end;
 	u8 version, eh_frame_ptr_enc, fde_count_enc, table_enc;
 	unsigned long fde_count;
+	bool has_table = false;
 	int entry_size;
 	int ret;
 
@@ -1287,16 +1447,17 @@ static int eh_frame_read_header(struct eh_frame_section *sec)
 		UNSAFE_GET_USER_INC(fde_count_enc, cur, end, Efault);
 		UNSAFE_GET_USER_INC(table_enc, cur, end, Efault);
 
-		/* .eh_frame_hdr without binary search table is not supported */
-		if (fde_count_enc == DW_EH_PE_omit || table_enc == DW_EH_PE_omit)
-			return -EINVAL;
-
 		/* Read pointer to .eh_frame */
 		ret = read_encoded_pointer(sec, NULL, &cur, end,
 					   eh_frame_ptr_enc, &eh_frame_start);
 		if (ret)
 			return ret;
 
+		/* Handle binary search table if provided */
+		if (fde_count_enc == DW_EH_PE_omit || table_enc == DW_EH_PE_omit)
+			goto end;
+		has_table = true;
+
 		/* Read FDE count */
 		ret = read_encoded_pointer(sec, NULL, &cur, end,
 					   fde_count_enc, &fde_count);
@@ -1327,6 +1488,9 @@ static int eh_frame_read_header(struct eh_frame_section *sec)
 
 	sec->eh_frame_start		= eh_frame_start;
 	sec->eh_frame_vma_end		= eh_frame_vma_end;
+	sec->has_binary_search_table	= has_table;
+	if (!has_table)
+		return 0;
 	sec->binary_search_table_start	= table_start;
 	sec->binary_search_table_end	= table_end;
 	sec->binary_search_table_enc	= table_enc;
@@ -1464,6 +1628,7 @@ static void __eh_frame_dup_section(struct eh_frame_section *sec,
 	sec->binary_search_table_end	= oldsec->binary_search_table_end;
 	sec->fde_count			= oldsec->fde_count;
 	sec->binary_search_table_enc	= oldsec->binary_search_table_enc;
+	sec->has_binary_search_table	= oldsec->has_binary_search_table;
 
 	dbg_dup(sec, oldsec);
 }
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index e72e011ba539..e03fc8bfed86 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -17,6 +17,9 @@
 #define dbg_sec_ehfh(addr, fmt, ...)					\
 	dbg_sec(".eh_frame_hdr+%#lx: " fmt, ((addr) - sec->eh_frame_hdr_start), ##__VA_ARGS__)
 
+#define dbg_sec_ehf(addr, fmt, ...)					\
+	dbg_sec(".eh_frame+%#lx: " fmt, ((addr) - sec->eh_frame_start), ##__VA_ARGS__)
+
 static inline void dbg_init(struct eh_frame_section *sec)
 {
 	struct mm_struct *mm = current->mm;
@@ -57,6 +60,7 @@ static inline void dbg_free(struct eh_frame_section *sec)
 #define dbg(args...)			no_printk(args)
 #define dbg_sec(args...)		no_printk(args)
 #define dbg_sec_ehfh(args...)		no_printk(args)
+#define dbg_sec_ehf(args...)		no_printk(args)
 
 static inline void dbg_init(struct eh_frame_section *sec) {}
 static inline void dbg_dup(struct eh_frame_section *sec, struct eh_frame_section *oldsec) {}
-- 
2.53.0

