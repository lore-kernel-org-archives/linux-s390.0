Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0938225DE
	for <linux-s390@vger.kernel.org>; Tue, 13 Feb 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821258; cv=none; b=DapbCWmUDvyOSjrqZo7ryhEyv/mjdCidHvuxamoePKwIpDYNK94oIHC5GnunsPds7WKf2WHuVPp/2mqr5AxSBQZW6vTBlmy2KZvoPor0DJ9/FytqiMwewn7UOe+sHjwSHlR6Tj9wsp/uKn9o/PQyAP/IpCSoZfpzCaePS5h+bkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821258; c=relaxed/simple;
	bh=AsO4hkjSzbvdlZWTEokWEVTAZkGaaqQtxNORk8MNPEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtzW+hgVYR6xQKeO3jten00jC3RZp5azYp5tdos5zPu0jUD5LYj+rLPPtjUB/3o7YKgfh12NDjnnM3Alz8XDC3lgBBBM14Q/IOXAd+klOX6uce6iaG9VV8v7D1XTCFcNzlE37DpbmVO/boxwy+rmE8tix77ja8CjcxiaYBZMTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qu0afVyg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qu0afVyg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DARLns029325;
	Tue, 13 Feb 2024 10:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W5VCVuKmu0b2agIIb5gxu28oDOJnR/IYzw00PHvGzoM=;
 b=qu0afVyg5w223JKUaWxzOT/FIt3+lWQg0+CQWQQdb2KspYyTOwkBt7bJhvs0O+63h5CF
 nFRxQog5Zoi8iXaFtxdRFsqem7QvRbKFV1tXXLVB+TmpbBpUlUwNUzIOI91EYzkhHhWV
 KsiQ3f9ixHm629pZfStVN0QqXJw3I2Xt3mF3/RXFgDsxEGDkmEiNfoPLCvefVGDWzybK
 sXGXZjWOrtJfUCb39aTs+Myh0mOvymdrBRR67DejyCQ6amBpOd3SkZ0nlsIxf9uDPoSN
 RQZHwB0R6FgaAS5dHsQTekjVpJKNQMEkHZ2/96a3fGToe0Lx/Ivwv8j+rRj318JF95a3 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w861fsjpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DAlWcx028024;
	Tue, 13 Feb 2024 10:47:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w861fsjpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9FunF009694;
	Tue, 13 Feb 2024 10:47:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkpfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:47:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DAlQLM20316758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 10:47:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 025B520043;
	Tue, 13 Feb 2024 10:47:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD9B820040;
	Tue, 13 Feb 2024 10:47:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 10:47:25 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
        agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH 2/4] s390: Add relocs tool
Date: Tue, 13 Feb 2024 11:47:05 +0100
Message-Id: <20240213104707.673053-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240213104707.673053-1-sumanthk@linux.ibm.com>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0EgSHLWmGKxfUmo6SjCCI7TACYSylwsD
X-Proofpoint-GUID: 3BcE8y1RQwqthsaRTdr9kKR6AfWDLL75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130085

From: Josh Poimboeuf <jpoimboe@kernel.org>

This 'relocs' tool is copied from the x86 version, ported for s390, and
greatly simplified to remove unnecessary features.

It reads vmlinux and outputs assembly to create a .vmlinux.relocs_64
section which contains the offsets of all R_390_64 relocations which
apply to allocatable sections.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/s390/tools/.gitignore |   1 +
 arch/s390/tools/Makefile   |   5 +
 arch/s390/tools/relocs.c   | 390 +++++++++++++++++++++++++++++++++++++
 3 files changed, 396 insertions(+)
 create mode 100644 arch/s390/tools/relocs.c

diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
index ea62f37b79ef..e6af51d9d183 100644
--- a/arch/s390/tools/.gitignore
+++ b/arch/s390/tools/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gen_facilities
 gen_opcode_table
+relocs
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f9dd47ff9ac4..f2862364fb42 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -25,3 +25,8 @@ $(kapi)/facility-defs.h: $(obj)/gen_facilities FORCE
 
 $(kapi)/dis-defs.h: $(obj)/gen_opcode_table FORCE
 	$(call filechk,dis-defs.h)
+
+hostprogs	+= relocs
+PHONY		+= relocs
+relocs: $(obj)/relocs
+	@:
diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
new file mode 100644
index 000000000000..d3ae25e3c3a4
--- /dev/null
+++ b/arch/s390/tools/relocs.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <elf.h>
+#include <byteswap.h>
+#define USE_BSD
+#include <endian.h>
+
+#define ELF_BITS 64
+
+#define ELF_MACHINE             EM_S390
+#define ELF_MACHINE_NAME        "IBM S/390"
+#define SHT_REL_TYPE            SHT_RELA
+#define Elf_Rel                 Elf64_Rela
+
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ENDIAN		ELFDATA2MSB
+#define ELF_R_SYM(val)          ELF64_R_SYM(val)
+#define ELF_R_TYPE(val)         ELF64_R_TYPE(val)
+#define ELF_ST_TYPE(o)          ELF64_ST_TYPE(o)
+#define ELF_ST_BIND(o)          ELF64_ST_BIND(o)
+#define ELF_ST_VISIBILITY(o)    ELF64_ST_VISIBILITY(o)
+
+#define ElfW(type)		_ElfW(ELF_BITS, type)
+#define _ElfW(bits, type)	__ElfW(bits, type)
+#define __ElfW(bits, type)	Elf##bits##_##type
+
+#define Elf_Addr		ElfW(Addr)
+#define Elf_Ehdr		ElfW(Ehdr)
+#define Elf_Phdr		ElfW(Phdr)
+#define Elf_Shdr		ElfW(Shdr)
+#define Elf_Sym			ElfW(Sym)
+
+static Elf_Ehdr		ehdr;
+static unsigned long	shnum;
+static unsigned int	shstrndx;
+
+struct relocs {
+	uint32_t	*offset;
+	unsigned long	count;
+	unsigned long	size;
+};
+
+static struct relocs relocs64;
+#define FMT PRIu64
+
+struct section {
+	Elf_Shdr       shdr;
+	struct section *link;
+	Elf_Rel        *reltab;
+};
+static struct section *secs;
+
+#if BYTE_ORDER == LITTLE_ENDIAN
+#define le16_to_cpu(val) (val)
+#define le32_to_cpu(val) (val)
+#define le64_to_cpu(val) (val)
+#define be16_to_cpu(val) bswap_16(val)
+#define be32_to_cpu(val) bswap_32(val)
+#define be64_to_cpu(val) bswap_64(val)
+#endif
+
+#if BYTE_ORDER == BIG_ENDIAN
+#define le16_to_cpu(val) bswap_16(val)
+#define le32_to_cpu(val) bswap_32(val)
+#define le64_to_cpu(val) bswap_64(val)
+#define be16_to_cpu(val) (val)
+#define be32_to_cpu(val) (val)
+#define be64_to_cpu(val) (val)
+#endif
+
+static uint16_t elf16_to_cpu(uint16_t val)
+{
+	if (ehdr.e_ident[EI_DATA] == ELFDATA2LSB)
+		return le16_to_cpu(val);
+	else
+		return be16_to_cpu(val);
+}
+
+static uint32_t elf32_to_cpu(uint32_t val)
+{
+	if (ehdr.e_ident[EI_DATA] == ELFDATA2LSB)
+		return le32_to_cpu(val);
+	else
+		return be32_to_cpu(val);
+}
+
+#define elf_half_to_cpu(x)	elf16_to_cpu(x)
+#define elf_word_to_cpu(x)	elf32_to_cpu(x)
+
+#if ELF_BITS == 64
+static uint64_t elf64_to_cpu(uint64_t val)
+{
+	return be64_to_cpu(val);
+}
+#define elf_addr_to_cpu(x)	elf64_to_cpu(x)
+#define elf_off_to_cpu(x)	elf64_to_cpu(x)
+#define elf_xword_to_cpu(x)	elf64_to_cpu(x)
+#else
+#define elf_addr_to_cpu(x)	elf32_to_cpu(x)
+#define elf_off_to_cpu(x)	elf32_to_cpu(x)
+#define elf_xword_to_cpu(x)	elf32_to_cpu(x)
+#endif
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static void read_ehdr(FILE *fp)
+{
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
+		die("Cannot read ELF header: %s\n",
+			strerror(errno));
+	}
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0)
+		die("No ELF magic\n");
+	if (ehdr.e_ident[EI_CLASS] != ELF_CLASS)
+		die("Not a %d bit executable\n", ELF_BITS);
+	if (ehdr.e_ident[EI_DATA] != ELF_ENDIAN)
+		die("ELF endian mismatch\n");
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT)
+		die("Unknown ELF version\n");
+
+	/* Convert the fields to native endian */
+	ehdr.e_type      = elf_half_to_cpu(ehdr.e_type);
+	ehdr.e_machine   = elf_half_to_cpu(ehdr.e_machine);
+	ehdr.e_version   = elf_word_to_cpu(ehdr.e_version);
+	ehdr.e_entry     = elf_addr_to_cpu(ehdr.e_entry);
+	ehdr.e_phoff     = elf_off_to_cpu(ehdr.e_phoff);
+	ehdr.e_shoff     = elf_off_to_cpu(ehdr.e_shoff);
+	ehdr.e_flags     = elf_word_to_cpu(ehdr.e_flags);
+	ehdr.e_ehsize    = elf_half_to_cpu(ehdr.e_ehsize);
+	ehdr.e_phentsize = elf_half_to_cpu(ehdr.e_phentsize);
+	ehdr.e_phnum     = elf_half_to_cpu(ehdr.e_phnum);
+	ehdr.e_shentsize = elf_half_to_cpu(ehdr.e_shentsize);
+	ehdr.e_shnum     = elf_half_to_cpu(ehdr.e_shnum);
+	ehdr.e_shstrndx  = elf_half_to_cpu(ehdr.e_shstrndx);
+
+	shnum = ehdr.e_shnum;
+	shstrndx = ehdr.e_shstrndx;
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN))
+		die("Unsupported ELF header type\n");
+	if (ehdr.e_machine != ELF_MACHINE)
+		die("Not for %s\n", ELF_MACHINE_NAME);
+	if (ehdr.e_version != EV_CURRENT)
+		die("Unknown ELF version\n");
+	if (ehdr.e_ehsize != sizeof(Elf_Ehdr))
+		die("Bad Elf header size\n");
+	if (ehdr.e_phentsize != sizeof(Elf_Phdr))
+		die("Bad program header entry\n");
+	if (ehdr.e_shentsize != sizeof(Elf_Shdr))
+		die("Bad section header entry\n");
+
+	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
+		Elf_Shdr shdr;
+
+		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+			die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
+
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot read initial ELF section header: %s\n", strerror(errno));
+
+		if (shnum == SHN_UNDEF)
+			shnum = elf_xword_to_cpu(shdr.sh_size);
+
+		if (shstrndx == SHN_XINDEX)
+			shstrndx = elf_word_to_cpu(shdr.sh_link);
+	}
+
+	if (shstrndx >= shnum)
+		die("String table index out of bounds\n");
+}
+
+static void read_shdrs(FILE *fp)
+{
+	int i;
+	Elf_Shdr shdr;
+
+	secs = calloc(shnum, sizeof(struct section));
+	if (!secs)
+		die("Unable to allocate %ld section headers\n", shnum);
+
+	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+		die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
+
+	for (i = 0; i < shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot read ELF section headers %d/%ld: %s\n",
+					i, shnum, strerror(errno));
+
+		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
+		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
+		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr.sh_flags);
+		sec->shdr.sh_addr      = elf_addr_to_cpu(shdr.sh_addr);
+		sec->shdr.sh_offset    = elf_off_to_cpu(shdr.sh_offset);
+		sec->shdr.sh_size      = elf_xword_to_cpu(shdr.sh_size);
+		sec->shdr.sh_link      = elf_word_to_cpu(shdr.sh_link);
+		sec->shdr.sh_info      = elf_word_to_cpu(shdr.sh_info);
+		sec->shdr.sh_addralign = elf_xword_to_cpu(shdr.sh_addralign);
+		sec->shdr.sh_entsize   = elf_xword_to_cpu(shdr.sh_entsize);
+
+		if (sec->shdr.sh_link < shnum)
+			sec->link = &secs[sec->shdr.sh_link];
+	}
+
+}
+
+static void read_relocs(FILE *fp)
+{
+	int i, j;
+
+	for (i = 0; i < shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
+			continue;
+
+		sec->reltab = malloc(sec->shdr.sh_size);
+		if (!sec->reltab)
+			die("malloc of %" FMT " bytes for relocs failed\n", sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+
+		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
+			Elf_Rel *rel = &sec->reltab[j];
+
+			rel->r_offset = elf_addr_to_cpu(rel->r_offset);
+			rel->r_info   = elf_xword_to_cpu(rel->r_info);
+#if (SHT_REL_TYPE == SHT_RELA)
+			rel->r_addend = elf_xword_to_cpu(rel->r_addend);
+#endif
+		}
+	}
+}
+
+static void add_reloc(struct relocs *r, uint32_t offset)
+{
+	if (r->count == r->size) {
+		unsigned long newsize = r->size + 50000;
+		void *mem = realloc(r->offset, newsize * sizeof(r->offset[0]));
+
+		if (!mem)
+			die("realloc of %ld entries for relocs failed\n", newsize);
+
+		r->offset = mem;
+		r->size = newsize;
+	}
+	r->offset[r->count++] = offset;
+}
+
+static int do_reloc(struct section *sec, Elf_Rel *rel)
+{
+	unsigned int r_type = ELF64_R_TYPE(rel->r_info);
+
+	ElfW(Addr) offset = rel->r_offset;
+
+	switch (r_type) {
+	case R_390_NONE:
+	case R_390_PC32:
+	case R_390_PC64:
+	case R_390_PC16DBL:
+	case R_390_PC32DBL:
+	case R_390_PLT32DBL:
+	case R_390_GOTENT:
+		break;
+	case R_390_64:
+		add_reloc(&relocs64, offset);
+		break;
+	default:
+		die("Unsupported relocation type: %d\n", r_type);
+		break;
+	}
+
+	return 0;
+}
+
+static void walk_relocs(void)
+{
+	int i;
+	/* Walk through the relocations */
+	for (i = 0; i < shnum; i++) {
+		struct section *sec_applies;
+		int j;
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
+			continue;
+
+		sec_applies = &secs[sec->shdr.sh_info];
+		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC))
+			continue;
+
+		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
+			Elf_Rel *rel = &sec->reltab[j];
+
+			do_reloc(sec, rel);
+		}
+	}
+}
+
+static int cmp_relocs(const void *va, const void *vb)
+{
+	const uint32_t *a, *b;
+
+	a = va; b = vb;
+	return (*a == *b) ? 0 : (*a > *b) ? 1 : -1;
+}
+
+static void sort_relocs(struct relocs *r)
+{
+	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+}
+
+static int print_reloc(uint32_t v)
+{
+	return fprintf(stdout, "\t.long 0x%08"PRIx32"\n", v) > 0 ? 0 : -1;
+}
+
+static void emit_relocs(void)
+{
+	int i;
+
+	walk_relocs();
+	sort_relocs(&relocs64);
+
+	printf(".section \".vmlinux.relocs_64\",\"a\"\n");
+	for (i = 0; i < relocs64.count; i++)
+		print_reloc(relocs64.offset[i]);
+}
+
+static void process(FILE *fp)
+{
+	read_ehdr(fp);
+	read_shdrs(fp);
+	read_relocs(fp);
+	emit_relocs();
+}
+
+static void usage(void)
+{
+	die("relocs vmlinux\n");
+}
+
+int main(int argc, char **argv)
+{
+	const char *fname;
+	FILE *fp;
+	unsigned char e_ident[EI_NIDENT];
+
+	fname = NULL;
+
+	if (argc != 2)
+		usage();
+
+	fname = argv[1];
+
+	fp = fopen(fname, "r");
+	if (!fp)
+		die("Cannot open %s: %s\n", fname, strerror(errno));
+
+	if (fread(&e_ident, 1, EI_NIDENT, fp) != EI_NIDENT)
+		die("Cannot read %s: %s", fname, strerror(errno));
+
+	rewind(fp);
+
+	process(fp);
+
+	fclose(fp);
+	return 0;
+}
-- 
2.40.1

