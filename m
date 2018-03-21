Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH v2 03/11] kexec_file: Make purgatory_info->ehdr const
Date: Wed, 21 Mar 2018 12:27:43 +0100
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180321112751.22196-4-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The kexec_purgatory buffer is read-only. Thus all pointers into
kexec_purgatory are read-only, too. Point this out by explicitly marking
purgatory_info->ehdr as 'const' and update the comments in purgatory_info.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 17 +++++++++++------
 kernel/kexec_file.c   |  4 ++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7bae5e87bf0d..10842eece180 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -99,14 +99,19 @@ struct compat_kexec_segment {
 
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
-	/* Pointer to elf header of read only purgatory */
-	Elf_Ehdr *ehdr;
-
-	/* Pointer to purgatory sechdrs which are modifiable */
+	/*
+	 * Pointer to elf header at the beginning of kexec_purgatory.
+	 * Note: kexec_purgatory is read only
+	 */
+	const Elf_Ehdr *ehdr;
+	/*
+	 * Temporary, modifiable buffer for sechdrs used for relocation.
+	 * This memory can be freed post image load.
+	 */
 	Elf_Shdr *sechdrs;
 	/*
-	 * Temporary buffer location where purgatory is loaded and relocated
-	 * This memory can be freed post image load
+	 * Temporary, modifiable buffer for stripped purgatory used for
+	 * relocation. This memory can be freed post image load.
 	 */
 	void *purgatory_buf;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0f044457b40c..06fc9fdd2474 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,7 +880,7 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
-	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
+	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
 	ret = __kexec_load_purgatory(image, min, max, top_down);
 	if (ret)
@@ -904,9 +904,9 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 					    const char *name)
 {
+	const Elf_Ehdr *ehdr;
 	Elf_Sym *syms;
 	Elf_Shdr *sechdrs;
-	Elf_Ehdr *ehdr;
 	int i, k;
 	const char *strtab;
 
-- 
2.13.5
