Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6473279DAF;
	Fri, 24 Jul 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902422; cv=none; b=SwKOs1VE1O1uKSVvT12dQApI1mU4JvkAAiQ2x10IEL91QcnBYygX9aWV6+V22x3UrAtyqUb6QzTn93z/9PNgC+EnkbhBk6uxPQ2D16XqE14XhTruVnJDCIuLn9YFrwSP+hJzmig9R9dHAVvYLB7l7TnOfLoEaIKjsG5NqpH1m+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902422; c=relaxed/simple;
	bh=3bz4Glex7N1UYZWnG5jVz83BObsAfGnpJDklLS5i8qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFLvi+O+sUyupT/rb3Dhq5sfbsFjTrmrAo7F1kKwiAGZhG2oS8HgI5U151nh01Y3WdRPOQeGMsTaFh27BAVCzbyRvzjl5WDKASEy+ujF8Xsv7bLBn50xAiWVV7U3YyZUk3/xznZQjHbW6Lleodn7AeDAQpYnyHq1RoR2LIbOBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qd0hAQT7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qd0hAQT7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg7e21899369;
	Fri, 24 Jul 2026 14:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s+FbP8iilqbfDcR7W
	lrCS/djUmnvqqT7NDu6cH9dAbE=; b=qd0hAQT7tt0l7Mg2u6OWLqXMoRvEXS0MX
	DmDTVZxNjdVGtTzdDBUkrwmcbSnV1nQHJvJ3u9W6oq/R4yReUhiXnoDghk8W64qf
	nj77ByKfe/kGLvcydTnujpmL2wqhREOviHTChHX+OD86/l4JZVOHJcW2I17ztbe3
	yclVm3QsvPAxkuB5m/qsw1G5sfaVQ1SNdfdgMYEDpSH3MS5vswZ2FGvokniDxQmo
	PNVqrp16ARs4roABy6h5+SKiTr1DK1M3Jp4uYOSOP8xfpL9VMhJ3imNVa2sx4cqJ
	60d2pryAW7PuhXI7j1umxSkTkH3HThROMLP0QW92v049DCizcUwdQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmf2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4fG3029170;
	Fri, 24 Jul 2026 14:13:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gs1nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDLNR45416784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5E1320116;
	Fri, 24 Jul 2026 14:13:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D1442012D;
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
Subject: [PATCH 1/6] s390/tools: Pass symbol name to do_relocs()
Date: Fri, 24 Jul 2026 16:13:13 +0200
Message-ID: <20260724141318.1037434-2-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a637306 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TSwsfb3K8UwMknoMj3EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX70bWpBERlUOQ
 rgDDDIQEsJrzxBJaOYtGLTwFGUC8jrnUmqH4U+er+DcTvciBfI/skvIaTV3mmq/QLGajGzvXKdh
 1smW+Te5EBNwUUOKD+8fjCKgj0r1N1K7uKtkZoEIFp7Qfz7Xl3RCK4yTk55CZydGipmyWlZ/lyQ
 F3UQ3jePCCz0lGrO+aH8DyFHXkSXsaUFaEAY/dnBH3d6r9lPGOLBWlUlm2AQkpmpwM3D0t5YQND
 Dzz5YXqLhCVaxm1+TGWOWlzEbKDs8dPJSeTXgvAaYMOnhZsjcYrW2AxWuw1TnI1ZR+4rJywVkt4
 ggQJ2J7HT73Px42bKzbZPNsK92C8dzMLY5un2J/yZfOSJd2o20CmlGspj/6X1QOx0Qo12/76KfL
 jwbBMd7E5hLV8BgZcq4UZH8FECKulKgZFhqnG0WDAjlpeqn2QMkh8732lcE7YON6t9ZNIy3FWo1
 eVw1uDTv3w0yp2KcXkw==
X-Proofpoint-ORIG-GUID: hyChGusyD4HRjsoqhjcshdARpIue5eUY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX+4lTQzPH4g8g
 Zsr0Kxsn5xSWERLkTRDYBwBjXctdjr4S+49cQ5p/14vzW07IZlU+gPxbUqapFPD1QCOYz4F8T27
 qFSmNU609geyp3EZ8vRB5G5CpNisjrs=
X-Proofpoint-GUID: E5x2NFA0KmEOoTN1gd4cBSZMl2Ld0KCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

Pass the symbol symbol name which corresponds to a relocation to
do_relocs(). This is preparation for kcfi support.

Given that the s390 specific relocs tool is a stripped down version of the
x86 version, add more code from the x86 version to the s390 version, while
keeping coding style, etc. in order to add the required functionality.

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/tools/relocs.c | 142 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
index 30a732c808f3..a2774176d38f 100644
--- a/arch/s390/tools/relocs.c
+++ b/arch/s390/tools/relocs.c
@@ -41,6 +41,10 @@
 static Elf_Ehdr		ehdr;
 static unsigned long	shnum;
 static unsigned int	shstrndx;
+static unsigned int	shsymtabndx;
+static unsigned int	shxsymtabndx;
+
+static int sym_index(Elf_Sym *sym);
 
 struct relocs {
 	uint32_t	*offset;
@@ -54,11 +58,40 @@ static struct relocs relocs64;
 struct section {
 	Elf_Shdr	shdr;
 	struct section	*link;
+	Elf_Sym		*symtab;
+	Elf32_Word	*xsymtab;
 	Elf_Rel		*reltab;
+	char		*strtab;
 };
 
 static struct section *secs;
 
+static const char *sec_name(unsigned shndx)
+{
+	const char *sec_strtab;
+	const char *name = "<noname>";
+	sec_strtab = secs[shstrndx].strtab;
+
+	if (shndx < shnum)
+		name = sec_strtab + secs[shndx].shdr.sh_name;
+	else if (shndx == SHN_ABS)
+		name = "ABSOLUTE";
+	else if (shndx == SHN_COMMON)
+		name = "COMMON";
+	return name;
+}
+
+static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
+{
+	const char *name;
+
+	if (sym->st_name)
+		name = sym_strtab + sym->st_name;
+	else
+		name = sec_name(sym_index(sym));
+	return name;
+}
+
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define le16_to_cpu(val)	(val)
 #define le32_to_cpu(val)	(val)
@@ -105,6 +138,23 @@ static uint64_t elf64_to_cpu(uint64_t val)
 #define elf_off_to_cpu(x)	elf64_to_cpu(x)
 #define elf_xword_to_cpu(x)	elf64_to_cpu(x)
 
+static int sym_index(Elf_Sym *sym)
+{
+	Elf_Sym *symtab = secs[shsymtabndx].symtab;
+	Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return sym->st_shndx;
+
+	/* calculate offset of sym from head of table. */
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
+
+	return elf32_to_cpu(xsymtab[index]);
+}
+
 static void die(char *fmt, ...)
 {
 	va_list ap;
@@ -216,6 +266,81 @@ static void read_shdrs(FILE *fp)
 
 }
 
+static void read_strtabs(FILE *fp)
+{
+	int i;
+
+	for (i = 0; i < shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_STRTAB)
+			continue;
+
+		sec->strtab = malloc(sec->shdr.sh_size);
+		if (!sec->strtab)
+			die("malloc of %" FMT " bytes for strtab failed\n", sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+	}
+}
+
+static void read_symtabs(FILE *fp)
+{
+	int i, j;
+
+	for (i = 0; i < shnum; i++) {
+		struct section *sec = &secs[i];
+		int num_syms;
+
+		switch (sec->shdr.sh_type) {
+		case SHT_SYMTAB_SHNDX:
+			sec->xsymtab = malloc(sec->shdr.sh_size);
+			if (!sec->xsymtab)
+				die("malloc of %" FMT " bytes for xsymtab failed\n", sec->shdr.sh_size);
+
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+				die("Cannot read extended symbol table: %s\n", strerror(errno));
+
+			shxsymtabndx = i;
+			continue;
+
+		case SHT_SYMTAB:
+			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
+
+			sec->symtab = malloc(sec->shdr.sh_size);
+			if (!sec->symtab)
+				die("malloc of %" FMT " bytes for symtab failed\n", sec->shdr.sh_size);
+
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+				die("Cannot read symbol table: %s\n", strerror(errno));
+
+			for (j = 0; j < num_syms; j++) {
+				Elf_Sym *sym = &sec->symtab[j];
+
+				sym->st_name  = elf_word_to_cpu(sym->st_name);
+				sym->st_value = elf_addr_to_cpu(sym->st_value);
+				sym->st_size  = elf_xword_to_cpu(sym->st_size);
+				sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
+			}
+			shsymtabndx = i;
+			continue;
+
+		default:
+			continue;
+		}
+	}
+}
+
 static void read_relocs(FILE *fp)
 {
 	int i, j;
@@ -263,7 +388,8 @@ static void add_reloc(struct relocs *r, uint32_t offset)
 	r->offset[r->count++] = offset;
 }
 
-static int do_reloc(struct section *sec, Elf_Rel *rel)
+static int do_reloc(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
+		    const char *symname)
 {
 	unsigned int r_type = ELF64_R_TYPE(rel->r_info);
 	ElfW(Addr) offset = rel->r_offset;
@@ -296,21 +422,29 @@ static void walk_relocs(void)
 
 	/* Walk through the relocations */
 	for (i = 0; i < shnum; i++) {
-		struct section *sec_applies;
+		char *sym_strtab;
+		Elf_Sym *sh_symtab;
+		struct section *sec_applies, *sec_symtab;
 		int j;
 		struct section *sec = &secs[i];
 
 		if (sec->shdr.sh_type != SHT_REL_TYPE)
 			continue;
 
+		sec_symtab  = sec->link;
 		sec_applies = &secs[sec->shdr.sh_info];
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC))
 			continue;
 
+		sh_symtab = sec_symtab->symtab;
+		sym_strtab = sec_symtab->link->strtab;
+
 		for (j = 0; j < sec->shdr.sh_size / sizeof(Elf_Rel); j++) {
 			Elf_Rel *rel = &sec->reltab[j];
+			Elf_Sym *sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
+			const char *symname = sym_name(sym_strtab, sym);
 
-			do_reloc(sec, rel);
+			do_reloc(sec, rel, sym, symname);
 		}
 	}
 }
@@ -349,6 +483,8 @@ static void process(FILE *fp)
 {
 	read_ehdr(fp);
 	read_shdrs(fp);
+	read_strtabs(fp);
+	read_symtabs(fp);
 	read_relocs(fp);
 	emit_relocs();
 }
-- 
2.53.0

