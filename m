Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 05/11] kexec_file: Use read-only sections in arch_kexec_apply_relocations*
Date: Mon, 26 Feb 2018 16:16:14 +0100
In-Reply-To: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180226151620.20970-6-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

When the relocations are applied to the purgatory only the section the
relocations are applied to is writable. The other sections, i.e. the symtab
and .rel/.rela, are in read-only kexec_purgatory. Highlight this by marking
the corresponding variables as 'const'.

While at it also change the signatures of arch_kexec_apply_relocations* to
take section pointers instead of just the index of the relocation section.
This removes the second lookup and sanity check of the sections in arch
code.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/x86/kernel/machine_kexec_64.c | 56 ++++++++++++---------------------
 include/linux/kexec.h              | 12 +++++---
 kernel/kexec_file.c                | 63 +++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3b7427aa7d85..51667c8b5c9b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -422,52 +422,36 @@ int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
 /*
  * Apply purgatory relocations.
  *
- * ehdr: Pointer to elf headers
- * sechdrs: Pointer to section headers.
- * relsec: section index of SHT_RELA section.
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELAs.
+ * @symtabsec:	Corresponding symtab.
  *
  * TODO: Some of the code belongs to generic code. Move that in kexec.c.
  */
-int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
-				     Elf64_Shdr *sechdrs, unsigned int relsec)
+int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+				     Elf_Shdr *section, const Elf_Shdr *relsec,
+				     const Elf_Shdr *symtabsec)
 {
 	unsigned int i;
 	Elf64_Rela *rel;
 	Elf64_Sym *sym;
 	void *location;
-	Elf64_Shdr *section, *symtabsec;
 	unsigned long address, sec_base, value;
 	const char *strtab, *name, *shstrtab;
+	const Elf_Shdr *sechdrs;
 
-	/*
-	 * ->sh_offset has been modified to keep the pointer to section
-	 * contents in memory
-	 */
-	rel = (void *)sechdrs[relsec].sh_offset;
-
-	/* Section to which relocations apply */
-	section = &sechdrs[sechdrs[relsec].sh_info];
-
-	pr_debug("Applying relocate section %u to %u\n", relsec,
-		 sechdrs[relsec].sh_info);
-
-	/* Associated symbol table */
-	symtabsec = &sechdrs[sechdrs[relsec].sh_link];
-
-	/* String table */
-	if (symtabsec->sh_link >= ehdr->e_shnum) {
-		/* Invalid strtab section number */
-		pr_err("Invalid string table section index %d\n",
-		       symtabsec->sh_link);
-		return -ENOEXEC;
-	}
+	/* String & section header string table */
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	strtab = (char *)pi->ehdr + sechdrs[symtabsec->sh_link].sh_offset;
+	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
 
-	strtab = (char *)sechdrs[symtabsec->sh_link].sh_offset;
+	rel = (void *)pi->ehdr + relsec->sh_offset;
 
-	/* section header string table */
-	shstrtab = (char *)sechdrs[ehdr->e_shstrndx].sh_offset;
+	pr_debug("Applying relocate section %s to %u\n",
+		 shstrtab + relsec->sh_name, relsec->sh_info);
 
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+	for (i = 0; i < relsec->sh_size / sizeof(*rel); i++) {
 
 		/*
 		 * rel[i].r_offset contains byte offset from beginning
@@ -490,8 +474,8 @@ int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
 		 * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
 		 * these respectively.
 		 */
-		sym = (Elf64_Sym *)symtabsec->sh_offset +
-				ELF64_R_SYM(rel[i].r_info);
+		sym = (void *)pi->ehdr + symtabsec->sh_offset;
+		sym += ELF64_R_SYM(rel[i].r_info);
 
 		if (sym->st_name)
 			name = strtab + sym->st_name;
@@ -514,12 +498,12 @@ int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
 
 		if (sym->st_shndx == SHN_ABS)
 			sec_base = 0;
-		else if (sym->st_shndx >= ehdr->e_shnum) {
+		else if (sym->st_shndx >= pi->ehdr->e_shnum) {
 			pr_err("Invalid section %d for symbol %s\n",
 			       sym->st_shndx, name);
 			return -ENOEXEC;
 		} else
-			sec_base = sechdrs[sym->st_shndx].sh_addr;
+			sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
 
 		value = sym->st_value;
 		value += sec_base;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 10842eece180..f15446be0e25 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -290,10 +290,14 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image);
 int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
 int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 					unsigned long buf_len);
-int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
-					Elf_Shdr *sechdrs, unsigned int relsec);
-int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-					unsigned int relsec);
+int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
+					    Elf_Shdr *section,
+					    const Elf_Shdr *relsec,
+					    const Elf_Shdr *symtab);
+int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
+					Elf_Shdr *section,
+					const Elf_Shdr *relsec,
+					const Elf_Shdr *symtab);
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2072b288ec53..80c7f658afc0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -53,19 +53,35 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
-/* Apply relocations of type RELA */
+/*
+ * arch_kexec_apply_relocations_add - apply relocations of type RELA
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELAs.
+ * @symtab:	Corresponding symtab.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
 int __weak
-arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-				 unsigned int relsec)
+arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
+				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {
 	pr_err("RELA relocation unsupported.\n");
 	return -ENOEXEC;
 }
 
-/* Apply relocations of type REL */
+/*
+ * arch_kexec_apply_relocations - apply relocations of type REL
+ * @pi:		Purgatory to be relocated.
+ * @section:	Section relocations applying to.
+ * @relsec:	Section containing RELs.
+ * @symtab:	Corresponding symtab.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
 int __weak
-arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-			     unsigned int relsec)
+arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
+			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {
 	pr_err("REL relocation unsupported.\n");
 	return -ENOEXEC;
@@ -818,14 +834,19 @@ static int kexec_apply_relocations(struct kimage *image)
 {
 	int i, ret;
 	struct purgatory_info *pi = &image->purgatory_info;
-	Elf_Shdr *sechdrs = pi->sechdrs;
+	const Elf_Shdr *sechdrs;
+
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
 
-	/* Apply relocations */
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		Elf_Shdr *section, *symtab;
+		const Elf_Shdr *relsec;
+		const Elf_Shdr *symtab;
+		Elf_Shdr *section;
+
+		relsec = sechdrs + i;
 
-		if (sechdrs[i].sh_type != SHT_RELA &&
-		    sechdrs[i].sh_type != SHT_REL)
+		if (relsec->sh_type != SHT_RELA &&
+		    relsec->sh_type != SHT_REL)
 			continue;
 
 		/*
@@ -834,12 +855,12 @@ static int kexec_apply_relocations(struct kimage *image)
 		 * symbol table. And ->sh_info contains section header
 		 * index of section to which relocations apply.
 		 */
-		if (sechdrs[i].sh_info >= pi->ehdr->e_shnum ||
-		    sechdrs[i].sh_link >= pi->ehdr->e_shnum)
+		if (relsec->sh_info >= pi->ehdr->e_shnum ||
+		    relsec->sh_link >= pi->ehdr->e_shnum)
 			return -ENOEXEC;
 
-		section = &sechdrs[sechdrs[i].sh_info];
-		symtab = &sechdrs[sechdrs[i].sh_link];
+		section = pi->sechdrs + relsec->sh_info;
+		symtab = sechdrs + relsec->sh_link;
 
 		if (!(section->sh_flags & SHF_ALLOC))
 			continue;
@@ -856,12 +877,12 @@ static int kexec_apply_relocations(struct kimage *image)
 		 * Respective architecture needs to provide support for applying
 		 * relocations of type SHT_RELA/SHT_REL.
 		 */
-		if (sechdrs[i].sh_type == SHT_RELA)
-			ret = arch_kexec_apply_relocations_add(pi->ehdr,
-							       sechdrs, i);
-		else if (sechdrs[i].sh_type == SHT_REL)
-			ret = arch_kexec_apply_relocations(pi->ehdr,
-							   sechdrs, i);
+		if (relsec->sh_type == SHT_RELA)
+			ret = arch_kexec_apply_relocations_add(pi, section,
+							       relsec, symtab);
+		else if (relsec->sh_type == SHT_REL)
+			ret = arch_kexec_apply_relocations(pi, section,
+							   relsec, symtab);
 		if (ret)
 			return ret;
 	}
-- 
2.13.5
