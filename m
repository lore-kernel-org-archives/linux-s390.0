Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 16/17] s390/kexec_file: Add crash support to image loader
Date: Mon, 12 Feb 2018 11:07:53 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-17-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Add support to load a crash kernel to the image loader. This requires
extending the purgatory.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/kexec_image.c        |   6 +-
 arch/s390/kernel/machine_kexec_file.c |  45 ++++++++-
 arch/s390/purgatory/head.S            | 185 +++++++++++++++++++++++++++++++++-
 arch/s390/purgatory/purgatory.c       |   4 +
 4 files changed, 234 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
index 83cf5a9be3a4..60e03f7048b9 100644
--- a/arch/s390/kernel/kexec_image.c
+++ b/arch/s390/kernel/kexec_image.c
@@ -25,6 +25,8 @@ static int kexec_file_add_image_kernel(struct kimage *image,
 	buf.bufsz = kernel_len - STARTUP_NORMAL_OFFSET;
 
 	buf.mem = STARTUP_NORMAL_OFFSET;
+	if (image->type == KEXEC_TYPE_CRASH)
+		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
 	ret = kexec_add_buffer(&buf);
@@ -43,10 +45,6 @@ static void *s390_image_load(struct kimage *image,
 	struct s390_load_data data = {0};
 	int ret;
 
-	/* We don't support crash kernels yet. */
-	if (image->type == KEXEC_TYPE_CRASH)
-		return ERR_PTR(-ENOTSUPP);
-
 	ret = kexec_file_add_image_kernel(image, &data, kernel, kernel_len);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 052640220361..050ceab746ec 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -28,6 +28,14 @@ void kexec_file_update_kernel(struct kimage *image,
 		memcpy(data->kernel_buf + COMMAND_LINE_OFFSET,
 		       image->cmdline_buf, image->cmdline_buf_len);
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		loc = (unsigned long *)(data->kernel_buf + OLDMEM_BASE_OFFSET);
+		*loc = crashk_res.start;
+
+		loc = (unsigned long *)(data->kernel_buf + OLDMEM_SIZE_OFFSET);
+		*loc = crashk_res.end - crashk_res.start + 1;
+	}
+
 	if (image->initrd_buf) {
 		loc = (unsigned long *)(data->kernel_buf + INITRD_START_OFFSET);
 		*loc = data->initrd_load_addr;
@@ -42,9 +50,40 @@ static int kexec_file_update_purgatory(struct kimage *image)
 	u64 entry, type;
 	int ret;
 
-	entry = STARTUP_NORMAL_OFFSET;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		entry = STARTUP_KDUMP_OFFSET;
+		type = KEXEC_TYPE_CRASH;
+	} else {
+		entry = STARTUP_NORMAL_OFFSET;
+		type = KEXEC_TYPE_DEFAULT;
+	}
+
 	ret = kexec_purgatory_get_set_symbol(image, "kernel_entry", &entry,
 					     sizeof(entry), false);
+	if (ret)
+		return ret;
+
+	ret = kexec_purgatory_get_set_symbol(image, "kernel_type", &type,
+					     sizeof(type), false);
+	if (ret)
+		return ret;
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		u64 crash_size;
+
+		ret = kexec_purgatory_get_set_symbol(image, "crash_start",
+						     &crashk_res.start,
+						     sizeof(crashk_res.start),
+						     false);
+		if (ret)
+			return ret;
+
+		crash_size = crashk_res.end - crashk_res.start + 1;
+		ret = kexec_purgatory_get_set_symbol(image, "crash_size",
+						     &crash_size,
+						     sizeof(crash_size),
+						     false);
+	}
 	return ret;
 }
 
@@ -57,6 +96,8 @@ int kexec_file_add_purgatory(struct kimage *image, struct s390_load_data *data)
 
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
+	if (image->type == KEXEC_TYPE_CRASH)
+		buf.mem += crashk_res.start;
 
 	ret = kexec_load_purgatory(image, &buf);
 	if (ret)
@@ -79,6 +120,8 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
 
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
+	if (image->type == KEXEC_TYPE_CRASH)
+		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
 	data->initrd_load_addr = buf.mem;
diff --git a/arch/s390/purgatory/head.S b/arch/s390/purgatory/head.S
index 8735409d0280..6bfb13aa3f42 100644
--- a/arch/s390/purgatory/head.S
+++ b/arch/s390/purgatory/head.S
@@ -15,8 +15,52 @@
 /* The purgatory is the code running between two kernels. It's main purpose
  * is to verify that the next kernel was not corrupted after load and to
  * start it.
+ *
+ * If the next kernel is a crash kernel there are some peculiarities to
+ * consider:
+ *
+ * First the purgatory is called twice. Once only to verify the
+ * sha digest. So if the crash kernel got corrupted the old kernel can try
+ * to trigger a stand-alone dumper. And once to actually load the crash kernel.
+ *
+ * Second the purgatory also has to swap the crash memory region with its
+ * destination at address 0. As the purgatory is part of crash memory this
+ * requires some finesse. The tactic here is that the purgatory first copies
+ * itself to the end of the destination and then swaps the rest of the
+ * memory running from there.
  */
 
+#define bufsz purgatory_end-stack
+
+.macro MEMCPY dst,src,len
+	lgr	%r0,\dst
+	lgr	%r1,\len
+	lgr	%r2,\src
+	lgr	%r3,\len
+
+20:	mvcle	%r0,%r2,0
+	jo	20b
+.endm
+
+.macro MEMSWAP dst,src,buf,len
+10:	cghi	\len,bufsz
+	jh	11f
+	lgr	%r4,\len
+	j	12f
+11:	lghi	%r4,bufsz
+
+12:	MEMCPY	\buf,\dst,%r4
+	MEMCPY	\dst,\src,%r4
+	MEMCPY	\src,\buf,%r4
+
+	agr	\dst,%r4
+	agr	\src,%r4
+	sgr	\len,%r4
+
+	cghi	\len,0
+	jh	10b
+.endm
+
 .macro START_NEXT_KERNEL base
 	lg	%r4,kernel_entry-\base(%r13)
 	lg	%r5,load_psw_mask-\base(%r13)
@@ -47,18 +91,144 @@ ENTRY(purgatory_start)
 	larl	%r15,purgatory_end
 	aghi	%r15,-160
 
+	/* If the next kernel is KEXEC_TYPE_CRASH the purgatory is called
+	 * directly with a flag passed in %r2 whether the purgatory shall do
+	 * checksum verification only (%r2 = 0 -> verification only).
+	 *
+	 * Check now and preserve over C function call by storing in
+	 * %r10 whith
+	 *	1 -> checksum verification only
+	 *	0 -> load new kernel
+	 */
+	lghi	%r10,0
+	lg	%r11,kernel_type-.base_crash(%r13)
+	cghi	%r11,1		/* KEXEC_TYPE_CRASH */
+	jne	.do_checksum_verification
+	cghi	%r2,0		/* checksum verification only */
+	jne	.do_checksum_verification
+	lghi	%r10,1
+
 .do_checksum_verification:
 	brasl	%r14,verify_sha256_digest
 
+	cghi	%r10,1		/* checksum verification only */
+	je	.return_old_kernel
 	cghi	%r2,0		/* checksum match */
 	jne	.disabled_wait
 
+	/* If the next kernel is a crash kernel the purgatory has to swap
+	 * the mem regions first.
+	 */
+	cghi	%r11,1 /* KEXEC_TYPE_CRASH */
+	je	.start_crash_kernel
+
 	/* start normal kernel */
 	START_NEXT_KERNEL .base_crash
 
+.return_old_kernel:
+	lmg	%r6,%r15,gprregs-.base_crash(%r13)
+	br	%r14
+
 .disabled_wait:
 	lpswe	disabled_wait_psw-.base_crash(%r13)
 
+.start_crash_kernel:
+	/* Location of purgatory_start in crash memory */
+	lgr	%r8,%r13
+	aghi	%r8,-(.base_crash-purgatory_start)
+
+	/* Destination for this code i.e. end of memory to be swapped. */
+	lg	%r9,crash_size-.base_crash(%r13)
+	aghi	%r9,-(purgatory_end-purgatory_start)
+
+	/* Destination in crash memory, i.e. same as r9 but in crash memory. */
+	lg	%r10,crash_start-.base_crash(%r13)
+	agr	%r10,%r9
+
+	/* Buffer location (in crash memory) and size. As the purgatory is
+	 * behind the point of no return it can re-use the stack as buffer.
+	 */
+	lghi	%r11,bufsz
+	larl	%r12,stack
+
+	MEMCPY	%r12,%r9,%r11	/* dst  -> (crash) buf */
+	MEMCPY	%r9,%r8,%r11	/* self -> dst */
+
+	/* Jump to new location. */
+	lgr	%r7,%r9
+	aghi	%r7,.jump_to_dst-purgatory_start
+	br	%r7
+
+.jump_to_dst:
+	basr	%r13,0
+.base_dst:
+
+	/* clear buffer */
+	MEMCPY	%r12,%r10,%r11	/* (crash) buf -> (crash) dst */
+
+	/* Load new buffer location after jump */
+	larl	%r7,stack
+	aghi	%r10,stack-purgatory_start
+	MEMCPY	%r10,%r7,%r11	/* (new) buf -> (crash) buf */
+
+	/* Now the code is set up to run from its designated location. Start
+	 * swapping the rest of crash memory now.
+	 *
+	 * The registers will be used as follow:
+	 *
+	 *	%r0-%r4	reserved for macros defined above
+	 *	%r5-%r6 tmp registers
+	 *	%r7	pointer to current struct sha region
+	 *	%r8	index to iterate over all sha regions
+	 *	%r9	pointer in crash memory
+	 *	%r10	pointer in old kernel
+	 *	%r11	total size (still) to be moved
+	 *	%r12	pointer to buffer
+	 */
+	lgr	%r12,%r7
+	lgr	%r11,%r9
+	lghi	%r10,0
+	lg	%r9,crash_start-.base_dst(%r13)
+	lghi	%r8,16	/* KEXEC_SEGMENTS_MAX */
+	larl	%r7,purgatory_sha_regions
+
+	j .loop_first
+
+	/* Loop over all purgatory_sha_regions. */
+.loop_next:
+	aghi	%r8,-1
+	cghi	%r8,0
+	je	.loop_out
+
+	aghi	%r7,__KEXEC_SHA_REGION_SIZE
+
+.loop_first:
+	lg	%r5,__KEXEC_SHA_REGION_START(%r7)
+	cghi	%r5,0
+	je	.loop_next
+
+	/* Copy [end last sha region, start current sha region) */
+	/* Note: kexec_sha_region->start points in crash memory */
+	sgr	%r5,%r9
+	MEMCPY	%r9,%r10,%r5
+
+	agr	%r9,%r5
+	agr	%r10,%r5
+	sgr	%r11,%r5
+
+	/* Swap sha region */
+	lg	%r6,__KEXEC_SHA_REGION_LEN(%r7)
+	MEMSWAP	%r9,%r10,%r12,%r6
+	sg	%r11,__KEXEC_SHA_REGION_LEN(%r7)
+	j	.loop_next
+
+.loop_out:
+	/* Copy rest of crash memory */
+	MEMCPY	%r9,%r10,%r11
+
+	/* start crash kernel */
+	START_NEXT_KERNEL .base_dst
+
 
 load_psw_mask:
 	.long	0x00080000,0x80000000
@@ -89,8 +259,21 @@ kernel_entry:
 	.global kernel_entry
 	.quad	0
 
+kernel_type:
+	.global kernel_type
+	.quad	0
+
+crash_start:
+	.global crash_start
+	.quad	0
+
+crash_size:
+	.global crash_size
+	.quad	0
+
 	.align	PAGE_SIZE
 stack:
-	.skip	PAGE_SIZE
+	/* The buffer to move this code must be as big as the code. */
+	.skip	stack-purgatory_start
 	.align	PAGE_SIZE
 purgatory_end:
diff --git a/arch/s390/purgatory/purgatory.c b/arch/s390/purgatory/purgatory.c
index fec67b58b8be..67ded81e0430 100644
--- a/arch/s390/purgatory/purgatory.c
+++ b/arch/s390/purgatory/purgatory.c
@@ -16,6 +16,10 @@ struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX];
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE];
 
 u64 kernel_entry;
+u64 kernel_type;
+
+u64 crash_start;
+u64 crash_size;
 
 int verify_sha256_digest(void)
 {
-- 
2.13.5
