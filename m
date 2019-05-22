Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 047/244] s390/kexec_file: Fix detection of text segment in ELF loader
Date: Wed, 22 May 2019 15:23:13 -0400
Message-Id: <20190522192630.24917-47-sashal@kernel.org>
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Philipp Rudo <prudo@linux.ibm.com>

[ Upstream commit 729829d775c9a5217abc784b2f16087d79c4eec8 ]

To register data for the next kernel (command line, oldmem_base, etc.) the
current kernel needs to find the ELF segment that contains head.S. This is
currently done by checking ifor 'phdr->p_paddr == 0'. This works fine for
the current kernel build but in theory the first few pages could be
skipped. Make the detection more robust by checking if the entry point lies
within the segment.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/kexec_elf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 5a286b012043b..602e7cc26d118 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -19,10 +19,15 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 	struct kexec_buf buf;
 	const Elf_Ehdr *ehdr;
 	const Elf_Phdr *phdr;
+	Elf_Addr entry;
 	int i, ret;
 
 	ehdr = (Elf_Ehdr *)kernel;
 	buf.image = image;
+	if (image->type == KEXEC_TYPE_CRASH)
+		entry = STARTUP_KDUMP_OFFSET;
+	else
+		entry = ehdr->e_entry;
 
 	phdr = (void *)ehdr + ehdr->e_phoff;
 	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
@@ -35,7 +40,7 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 		buf.mem = ALIGN(phdr->p_paddr, phdr->p_align);
 		buf.memsz = phdr->p_memsz;
 
-		if (phdr->p_paddr == 0) {
+		if (entry - phdr->p_paddr < phdr->p_memsz) {
 			data->kernel_buf = buf.buffer;
 			data->memsz += STARTUP_NORMAL_OFFSET;
 
-- 
2.20.1
