Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD41F12E0;
	Tue,  7 Jan 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256649; cv=none; b=FZNJcfKX/TCOpexQZNFztcYk8ddNERCGuCQYpvGcYLFMAFr+Ly6sfzUB1fQ2WkwgSuUPQvdZuKdYV8WIBWa3kBthdckrEniICXWn6chlvnm5GasLOIWaweEBdXX24W6LXbGcHN0pnAIsfi5c7RkyJc4ZBmDaBjnBWpmAAe4Cd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256649; c=relaxed/simple;
	bh=2II28rDnm/JjA1uReOOKsrlbl9iJobUJwyfrFihf/nM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gy6lMGE561l10jGjukBVYWgIaCuNsGJWCUhq14by2Mw5VYGcgY7Nv7+2aRmt0emY7uSbidqBNrTHjZlYHc4jadH5oy+cQam7o5lf9iziA3INzbGuzStnj7Eh59t68WDKxDm/RGGp/8AlGbwC49H5LE8Cobvy0eCnu/kvUnzA/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1938C4CEDD;
	Tue,  7 Jan 2025 13:30:46 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:32:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC][PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at build for arm64
Message-ID: <20250107083214.5a29d429@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The mcount_loc section holds the addresses of the functions that get
patched by ftrace when enabling function callbacks. It can contain tens of
thousands of entries. These addresses must be sorted. If they are not
sorted at compile time, they are sorted at boot. Sorting at boot does take
some time and does have a small impact on boot overhead.

x86 and arm32 have the addresses in the mcount_loc section of the ELF
file. But for arm64, the section just contains zeros. The .rela.dyn
Elf_Rela section holds the addresses and they get patched at boot during
the relocation phase.

In order to sort these addresses, the Elf_Rela needs to be updated instead
of the location in the binary that holds the mcount_loc section. Have the
sorttable code, allocate an array to hold the function addresses, load the
addresses from the Elf_Rela entries, sort them, then put them back in
order into the Elf_rela entries so that they will be sorted at boot up
without having to sort them during boot up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Note, this is based on top of my sorttable clean up code:

  https://lore.kernel.org/linux-trace-kernel/20250105162211.971039541@goodmis.org/
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git sorttable/for-next

I tested this on a arm64 VM (running on x86 host), with
CONFIG_FTRACE_SORT_STARTUP_TEST enabled, which verifies the mcount entries
are sorted at boot up.

I wonder if this will also work for s390? But I do not know s390 Elf layout.

 arch/arm64/Kconfig  |   1 +
 scripts/sorttable.c | 157 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5..e922622a9571 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -214,6 +214,7 @@ config ARM64
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index cd3b2145a827..bb1cf94b942f 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
@@ -79,10 +80,16 @@ typedef union {
 	Elf64_Sym	e64;
 } Elf_Sym;
 
+typedef union {
+	Elf32_Rela	e32;
+	Elf64_Rela	e64;
+} Elf_Rela;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
+static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
@@ -199,6 +206,31 @@ SYM_ADDR(value)
 SYM_WORD(name)
 SYM_HALF(shndx)
 
+#define RELA_ADDR(fn_name)				\
+static uint64_t rela64_##fn_name(Elf_Rela *rela)	\
+{							\
+	return r8((uint64_t *)&rela->e64.r_##fn_name);	\
+}							\
+							\
+static uint64_t rela32_##fn_name(Elf_Rela *rela)	\
+{							\
+	return r((uint32_t *)&rela->e32.r_##fn_name);	\
+}
+
+RELA_ADDR(offset)
+RELA_ADDR(info)
+RELA_ADDR(addend)
+
+static void rela64_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w8(val, (uint64_t *)&rela->e64.r_addend);
+}
+
+static void rela32_write_addend(Elf_Rela *rela, uint64_t val)
+{
+	w(val, (uint32_t *)&rela->e32.r_addend);
+}
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
@@ -278,6 +310,16 @@ static void wle(uint32_t val, uint32_t *x)
 	put_unaligned_le32(val, x);
 }
 
+static void w8be(uint64_t val, uint64_t *x)
+{
+	put_unaligned_be64(val, x);
+}
+
+static void w8le(uint64_t val, uint64_t *x)
+{
+	put_unaligned_le64(val, x);
+}
+
 /*
  * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
  * the way to -256..-1, to avoid conflicting with real section
@@ -344,17 +386,20 @@ static uint8_t (*sym_type)(Elf_Sym *sym);
 static uint32_t (*sym_name)(Elf_Sym *sym);
 static uint64_t (*sym_value)(Elf_Sym *sym);
 static uint16_t (*sym_shndx)(Elf_Sym *sym);
+static uint64_t (*rela_offset)(Elf_Rela *rela);
+static uint64_t (*rela_info)(Elf_Rela *rela);
+static uint64_t (*rela_addend)(Elf_Rela *rela);
+static void (*rela_write_addend)(Elf_Rela *rela, uint64_t val);
 
 static int extable_ent_size;
 static int long_size;
 
+#define ERRSTR_MAXSZ	256
 
 #ifdef UNWINDER_ORC_ENABLED
 /* ORC unwinder only support X86_64 */
 #include <asm/orc_types.h>
 
-#define ERRSTR_MAXSZ	256
-
 static char g_err[ERRSTR_MAXSZ];
 static int *g_orc_ip_table;
 static struct orc_entry *g_orc_table;
@@ -447,6 +492,9 @@ static void *sort_orctable(void *arg)
 
 #ifdef MCOUNT_SORT_ENABLED
 static pthread_t mcount_sort_thread;
+static bool sort_reloc;
+
+static char m_err[ERRSTR_MAXSZ];
 
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
@@ -455,6 +503,92 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
+/* Sort the relocations not the address itself */
+static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	unsigned int count;
+	int shentsize;
+	void *vals;
+	void *ptr;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
+		pthread_exit(m_err);
+		return NULL;
+	}
+
+	ptr = vals;
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (ptr + long_size > vals + size) {
+					free(vals);
+					snprintf(m_err, ERRSTR_MAXSZ,
+						 "Too many relocations");
+					pthread_exit(m_err);
+					return NULL;
+				}
+				if (long_size == 4)
+					*(uint32_t *)ptr = rela_addend(rel);
+				else
+					*(uint64_t *)ptr = rela_addend(rel);
+				ptr += long_size;
+			}
+		}
+	}
+	count = ptr - vals;
+	qsort(vals, count / long_size, long_size, compare_extable);
+
+	ptr = vals;
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (long_size == 4)
+					rela_write_addend(rel, *(uint32_t *)ptr);
+				else
+					rela_write_addend(rel, *(uint64_t *)ptr);
+				ptr += long_size;
+			}
+		}
+	}
+	free(vals);
+	return NULL;
+}
+
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
 static void *sort_mcount_loc(void *arg)
 {
@@ -464,6 +598,9 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
+	if (sort_reloc)
+		return sort_relocs(emloc->ehdr, emloc->start_mcount_loc, count);
+
 	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
@@ -813,12 +950,14 @@ static int do_file(char const *const fname, void *addr)
 		r2	= r2le;
 		r8	= r8le;
 		w	= wle;
+		w8	= w8le;
 		break;
 	case ELFDATA2MSB:
 		r	= rbe;
 		r2	= r2be;
 		r8	= r8be;
 		w	= wbe;
+		w8	= w8be;
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
@@ -834,8 +973,12 @@ static int do_file(char const *const fname, void *addr)
 	}
 
 	switch (r2(&ehdr->e32.e_machine)) {
-	case EM_386:
 	case EM_AARCH64:
+#ifdef MCOUNT_SORT_ENABLED
+		sort_reloc = true;
+#endif
+		/* fallthrough */
+	case EM_386:
 	case EM_LOONGARCH:
 	case EM_RISCV:
 	case EM_S390:
@@ -885,6 +1028,10 @@ static int do_file(char const *const fname, void *addr)
 		sym_name		= sym32_name;
 		sym_value		= sym32_value;
 		sym_shndx		= sym32_shndx;
+		rela_offset		= rela32_offset;
+		rela_info		= rela32_info;
+		rela_addend		= rela32_addend;
+		rela_write_addend	= rela32_write_addend;
 		long_size		= 4;
 		extable_ent_size	= 8;
 		break;
@@ -913,6 +1060,10 @@ static int do_file(char const *const fname, void *addr)
 		sym_name		= sym64_name;
 		sym_value		= sym64_value;
 		sym_shndx		= sym64_shndx;
+		rela_offset		= rela64_offset;
+		rela_info		= rela64_info;
+		rela_addend		= rela64_addend;
+		rela_write_addend	= rela64_write_addend;
 		long_size		= 8;
 		extable_ent_size	= 16;
 
-- 
2.45.2

