Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 07/17] kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
Date: Mon, 12 Feb 2018 11:07:44 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-8-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

To update the entry point there is an extra loop over all section headers
although this can be done in the main loop. So move it there and eliminate
the extra loop and variable to store the 'entry section index'.

Also, in the main loop, move the usual case, i.e. non-bss section, out of
the extra if-block.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 kernel/kexec_file.c | 76 +++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d1c3ec8dc6b1..bb31a3b627c2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -731,7 +731,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned char *buf_addr;
 	unsigned char *src;
 	Elf_Shdr *sechdrs;
-	int entry_sidx = -1;
 	int i;
 
 	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
@@ -763,32 +762,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 						sechdrs[i].sh_offset;
 	}
 
-	/*
-	 * Identify entry point section and make entry relative to section
-	 * start.
-	 */
-	kbuf->image->start = pi->ehdr->e_entry;
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		if (!(sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		/* Make entry section relative */
-		if (sechdrs[i].sh_addr <= pi->ehdr->e_entry &&
-		    ((sechdrs[i].sh_addr + sechdrs[i].sh_size) >
-		     pi->ehdr->e_entry)) {
-			entry_sidx = i;
-			kbuf->image->start -= sechdrs[i].sh_addr;
-			break;
-		}
-	}
-
 	/* Load SHF_ALLOC sections */
 	buf_addr = kbuf->buffer;
 	load_addr = curr_load_addr = kbuf->mem;
 	bss_addr = load_addr + kbuf->bufsz;
+	kbuf->image->start = pi->ehdr->e_entry;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
@@ -797,34 +775,40 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			continue;
 
 		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			curr_load_addr = ALIGN(curr_load_addr, align);
-			offset = curr_load_addr - load_addr;
-			/* We already modifed ->sh_offset to keep src addr */
-			src = (char *) sechdrs[i].sh_offset;
-			memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
-
-			/* Store load address and source address of section */
-			sechdrs[i].sh_addr = curr_load_addr;
-
-			/*
-			 * This section got copied to temporary buffer. Update
-			 * ->sh_offset accordingly.
-			 */
-			sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
-
-			/* Advance to the next address */
-			curr_load_addr += sechdrs[i].sh_size;
-		} else {
+
+		if (sechdrs[i].sh_type == SHT_NOBITS) {
 			bss_addr = ALIGN(bss_addr, align);
 			sechdrs[i].sh_addr = bss_addr;
 			bss_addr += sechdrs[i].sh_size;
+			continue;
+		}
+
+		curr_load_addr = ALIGN(curr_load_addr, align);
+		offset = curr_load_addr - load_addr;
+		/* We already modifed ->sh_offset to keep src addr */
+		src = (char *)sechdrs[i].sh_offset;
+		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
+
+		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
+		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
+		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
+					 + sechdrs[i].sh_size)) {
+			kbuf->image->start -= sechdrs[i].sh_addr;
+			kbuf->image->start += curr_load_addr
 		}
-	}
 
-	/* Update entry point based on load address of text section */
-	if (entry_sidx >= 0)
-		kbuf->image->start += sechdrs[entry_sidx].sh_addr;
+		/* Store load address and source address of section */
+		sechdrs[i].sh_addr = curr_load_addr;
+
+		/*
+		 * This section got copied to temporary buffer. Update
+		 * ->sh_offset accordingly.
+		 */
+		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
+
+		/* Advance to the next address */
+		curr_load_addr += sechdrs[i].sh_size;
+	}
 
 	return 0;
 }
-- 
2.13.5
