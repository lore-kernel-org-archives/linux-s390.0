Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 06/11] kexec_file: Split up __kexec_load_puragory
Date: Mon, 26 Feb 2018 16:16:15 +0100
In-Reply-To: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180226151620.20970-7-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

When inspecting __kexec_load_purgatory you find that it has two tasks

	1) setting up the kexec_buffer for the new kernel and,
	2) setting up pi->sechdrs for the final load address.

The two tasks are independent of each other. To improve readability split
up __kexec_load_purgatory into two functions, one for each task, and call
them directly from kexec_load_purgatory.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 200 +++++++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 97 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 80c7f658afc0..d1c3ec8dc6b1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -649,39 +649,97 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
-/* Actually load purgatory. Lot of code taken from kexec-tools */
-static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
-				  unsigned long max, int top_down)
+/*
+ * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
+ * @pi:		Purgatory to be loaded.
+ * @kbuf:	Buffer to setup.
+ *
+ * Allocates the memory needed for the buffer. Caller is responsible to free
+ * the memory after use.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
+				      struct kexec_buf *kbuf)
 {
-	struct purgatory_info *pi = &image->purgatory_info;
-	unsigned long align, bss_align, bss_sz, bss_pad;
-	unsigned long entry, load_addr, curr_load_addr, bss_addr, offset;
-	unsigned char *buf_addr, *src;
-	int i, ret = 0, entry_sidx = -1;
-	const Elf_Shdr *sechdrs_c;
-	Elf_Shdr *sechdrs = NULL;
-	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
-				  .buf_min = min, .buf_max = max,
-				  .top_down = top_down };
+	const Elf_Shdr *sechdrs;
+	unsigned long bss_align;
+	unsigned long bss_sz;
+	unsigned long align;
+	int i, ret;
 
-	/*
-	 * sechdrs_c points to section headers in purgatory and are read
-	 * only. No modifications allowed.
-	 */
-	sechdrs_c = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	bss_align = 1;
+	bss_sz = 0;
+
+	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
+			continue;
+
+		align = sechdrs[i].sh_addralign;
+		if (sechdrs[i].sh_type != SHT_NOBITS) {
+			if (kbuf->buf_align < align)
+				kbuf->buf_align = align;
+			kbuf->bufsz = ALIGN(kbuf->bufsz, align);
+			kbuf->bufsz += sechdrs[i].sh_size;
+		} else {
+			if (bss_align < align)
+				bss_align = align;
+			bss_sz = ALIGN(bss_sz, align);
+			bss_sz += sechdrs[i].sh_size;
+		}
+	}
+	kbuf->bufsz = ALIGN(kbuf->bufsz, bss_align);
+	kbuf->memsz = kbuf->bufsz + bss_sz;
+	if (kbuf->buf_align < bss_align)
+		kbuf->buf_align = bss_align;
+
+	kbuf->buffer = vzalloc(kbuf->bufsz);
+	if (!kbuf->buffer)
+		return -ENOMEM;
+	pi->purgatory_buf = kbuf->buffer;
+
+	ret = kexec_add_buffer(kbuf);
+	if (ret)
+		goto out;
+	pi->purgatory_load_addr = kbuf->mem;
+
+	return 0;
+out:
+	vfree(pi->purgatory_buf);
+	pi->purgatory_buf = NULL;
+	return ret;
+}
+
+/*
+ * kexec_purgatory_setup_sechdrs - prepares the pi->sechdrs buffer.
+ * @pi:		Purgatory to be loaded.
+ * @kbuf:	Buffer prepared to store purgatory.
+ *
+ * Allocates the memory needed for the buffer. Caller is responsible to free
+ * the memory after use.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
+					 struct kexec_buf *kbuf)
+{
+	unsigned long curr_load_addr;
+	unsigned long load_addr;
+	unsigned long bss_addr;
+	unsigned long offset;
+	unsigned char *buf_addr;
+	unsigned char *src;
+	Elf_Shdr *sechdrs;
+	int entry_sidx = -1;
+	int i;
 
-	/*
-	 * We can not modify sechdrs_c[] and its fields. It is read only.
-	 * Copy it over to a local copy where one can store some temporary
-	 * data and free it at the end. We need to modify ->sh_addr and
-	 * ->sh_offset fields to keep track of permanent and temporary
-	 * locations of sections.
-	 */
 	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
 	if (!sechdrs)
 		return -ENOMEM;
-
-	memcpy(sechdrs, sechdrs_c, pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
+	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	pi->sechdrs = sechdrs;
 
 	/*
 	 * We seem to have multiple copies of sections. First copy is which
@@ -709,7 +767,7 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 	 * Identify entry point section and make entry relative to section
 	 * start.
 	 */
-	entry = pi->ehdr->e_entry;
+	kbuf->image->start = pi->ehdr->e_entry;
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
@@ -722,63 +780,19 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 		    ((sechdrs[i].sh_addr + sechdrs[i].sh_size) >
 		     pi->ehdr->e_entry)) {
 			entry_sidx = i;
-			entry -= sechdrs[i].sh_addr;
+			kbuf->image->start -= sechdrs[i].sh_addr;
 			break;
 		}
 	}
 
-	/* Determine how much memory is needed to load relocatable object. */
-	bss_align = 1;
-	bss_sz = 0;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			if (kbuf.buf_align < align)
-				kbuf.buf_align = align;
-			kbuf.bufsz = ALIGN(kbuf.bufsz, align);
-			kbuf.bufsz += sechdrs[i].sh_size;
-		} else {
-			/* bss section */
-			if (bss_align < align)
-				bss_align = align;
-			bss_sz = ALIGN(bss_sz, align);
-			bss_sz += sechdrs[i].sh_size;
-		}
-	}
-
-	/* Determine the bss padding required to align bss properly */
-	bss_pad = 0;
-	if (kbuf.bufsz & (bss_align - 1))
-		bss_pad = bss_align - (kbuf.bufsz & (bss_align - 1));
-
-	kbuf.memsz = kbuf.bufsz + bss_pad + bss_sz;
-
-	/* Allocate buffer for purgatory */
-	kbuf.buffer = vzalloc(kbuf.bufsz);
-	if (!kbuf.buffer) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	if (kbuf.buf_align < bss_align)
-		kbuf.buf_align = bss_align;
-
-	/* Add buffer to segment list */
-	ret = kexec_add_buffer(&kbuf);
-	if (ret)
-		goto out;
-	pi->purgatory_load_addr = kbuf.mem;
-
 	/* Load SHF_ALLOC sections */
-	buf_addr = kbuf.buffer;
-	load_addr = curr_load_addr = pi->purgatory_load_addr;
-	bss_addr = load_addr + kbuf.bufsz + bss_pad;
+	buf_addr = kbuf->buffer;
+	load_addr = curr_load_addr = kbuf->mem;
+	bss_addr = load_addr + kbuf->bufsz;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
+		unsigned long align;
+
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
@@ -810,24 +824,9 @@ static int __kexec_load_purgatory(struct kimage *image, unsigned long min,
 
 	/* Update entry point based on load address of text section */
 	if (entry_sidx >= 0)
-		entry += sechdrs[entry_sidx].sh_addr;
-
-	/* Make kernel jump to purgatory after shutdown */
-	image->start = entry;
-
-	/* Used later to get/set symbol values */
-	pi->sechdrs = sechdrs;
+		kbuf->image->start += sechdrs[entry_sidx].sh_addr;
 
-	/*
-	 * Used later to identify which section is purgatory and skip it
-	 * from checksumming.
-	 */
-	pi->purgatory_buf = kbuf.buffer;
-	return ret;
-out:
-	vfree(sechdrs);
-	vfree(kbuf.buffer);
-	return ret;
+	return 0;
 }
 
 static int kexec_apply_relocations(struct kimage *image)
@@ -897,16 +896,23 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 {
 	struct purgatory_info *pi = &image->purgatory_info;
 	int ret;
+	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
+				  .buf_min = min, .buf_max = max,
+				  .top_down = top_down };
 
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
 	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
-	ret = __kexec_load_purgatory(image, min, max, top_down);
+	ret = kexec_purgatory_setup_kbuf(pi, &kbuf);
 	if (ret)
 		return ret;
 
+	ret = kexec_purgatory_setup_sechdrs(pi, &kbuf);
+	if (ret)
+		goto out_free_kbuf;
+
 	ret = kexec_apply_relocations(image);
 	if (ret)
 		goto out;
@@ -916,7 +922,7 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 out:
 	vfree(pi->sechdrs);
 	pi->sechdrs = NULL;
-
+out_free_kbuf:
 	vfree(pi->purgatory_buf);
 	pi->purgatory_buf = NULL;
 	return ret;
-- 
2.13.5
