Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 02/17] kexec_file: Remove checks in kexec_purgatory_load
Date: Mon, 12 Feb 2018 11:07:39 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-3-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Before the purgatory is loaded several checks are done whether the ELF file
in kexec_purgatory is valid or not. These checks are incomplete. For
example they don't check for the total size of the sections defined in the
section header table or if the entry point actually points into the
purgatory.

On the other hand the purgatory, although an ELF file on its own, is part
of the kernel. Thus not trusting the purgatory means not trusting the
kernel build itself.

So remove all validity checks on the purgatory and just trust the kernel
build.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e5bcd94c1efb..0f044457b40c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,22 +880,8 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
-	if (kexec_purgatory_size < sizeof(Elf_Ehdr))
-		return -ENOEXEC;
-
 	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
 
-	if (memcmp(pi->ehdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || pi->ehdr->e_type != ET_REL
-	    || !elf_check_arch(pi->ehdr)
-	    || pi->ehdr->e_shentsize != sizeof(Elf_Shdr))
-		return -ENOEXEC;
-
-	if (pi->ehdr->e_shoff >= kexec_purgatory_size
-	    || (pi->ehdr->e_shnum * sizeof(Elf_Shdr) >
-	    kexec_purgatory_size - pi->ehdr->e_shoff))
-		return -ENOEXEC;
-
 	ret = __kexec_load_purgatory(image, min, max, top_down);
 	if (ret)
 		return ret;
-- 
2.13.5
