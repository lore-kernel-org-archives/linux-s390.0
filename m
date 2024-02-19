Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16744282E2
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349288; cv=none; b=O0g33cP88euJ/BMTn4OrpXW/N+acrjHjO33veF0O952LTL8QIyfBo0j5I6VIt/sPhCiadWXj7RjY94x6lATR1DLQdzLfTOuTesltEeQE5gpcgMAEhmlFgfCM8FPUKE26ZHieNILXuHNbcNldGV4MiKxFbEMOAIRkGC1NkWXd7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349288; c=relaxed/simple;
	bh=XLvpkIzQ511VY3Iji26JVgw6VXbFzwhm2gxVJYRJXi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkfEtwV+lON4DDRNEXPYaSmilfpXunWpLhrYLlqpowCPEEW84EhtuOOMhZNN+m67ErtCL9tkTxAED+Gjwruew+dC/PcqmuJbFhTy5rfIni847S5NwBbs0Zq/zYb3F7OoJ9nQ8qxy/RTqln6RdLZlV4NOi4QpZclPcIMQO8YpDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OkjCHwLw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OkjCHwLw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDNGrn016712;
	Mon, 19 Feb 2024 13:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RQYHJMEfzmzeDN+QZu51I8qO0dY1+R/IlZz4JFAaOKI=;
 b=OkjCHwLwuOOCyObs8SFqpeMBCOTVw5vL5iWujhM0Ng308XXlRaZt2/K8EUY++ZpWOVEB
 xrmfnW/Ju6UkbcA/Hli9IcqHLOUDY+I8b3XaqywJV5plgHfXWqe74SOMginR7b2ayv8y
 AYdmY93Zwh+FOJZ7CV8KDBGQvSZlrnnJugtN11reKwZUC8dVuN+G5NMyXsEJF/vkW99e
 Iv+pQc5ZPDoa9RWURJytmaKS0NCv+mp3g3mAi0iCoF7ueT5/6IeA8rT3uwVHVqKG2G7f
 THclMEWWFf1x0DAmRnWcf1xtpAJC0teN4iKAZLZx9aJQ27yZLqyHGWZO+woble8kZ959 cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7tt030d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:02 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDNmvF018083;
	Mon, 19 Feb 2024 13:28:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc7tt02yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JAtq6W009541;
	Mon, 19 Feb 2024 13:28:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1dev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 13:28:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JDRt8D44368352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:27:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E9E20043;
	Mon, 19 Feb 2024 13:27:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875162005A;
	Mon, 19 Feb 2024 13:27:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 13:27:55 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, gor@linux.ibm.com
Cc: iii@linux.ibm.com, agordeev@linux.ibm.com, sumanthk@linux.ibm.com
Subject: [PATCH v2 2/4] s390: Add relocs tool
Date: Mon, 19 Feb 2024 14:27:32 +0100
Message-Id: <20240219132734.22881-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219132734.22881-1-sumanthk@linux.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o5RQo90v2rqS0zDqPQZ8RAdSNAoiCvsi
X-Proofpoint-ORIG-GUID: uuV7tYuLcs1h7vrxD-8stDiD8ohefcxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190100

From: Josh Poimboeuf <jpoimboe@kernel.org>

This 'relocs' tool is copied from the x86 version, ported for s390, and
greatly simplified to remove unnecessary features.

It reads vmlinux and outputs assembly to create a .vmlinux.relocs_64
section which contains the offsets of all R_390_64 relocations which
apply to allocatable sections.

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
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

