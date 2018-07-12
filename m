Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 01/18] x86: text_poke() may access uninitialized struct pages
Date: Wed, 11 Jul 2018 20:04:02 -0400
Message-Id: <20180712000419.5165-2-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

It supposed to be safe to modify static branches after jump_label_init().
But, because static key modifying code eventually calls text_poke() we
may end up with accessing struct page that have not been initialized.

Here is how to quickly reproduce the problem. Insert code like this
into init/main.c:

| +static DEFINE_STATIC_KEY_FALSE(__test);
| asmlinkage __visible void __init start_kernel(void)
| {
|        char *command_line;
|@@ -587,6 +609,10 @@ asmlinkage __visible void __init start_kernel(void)
|        vfs_caches_init_early();
|        sort_main_extable();
|        trap_init();
|+       {
|+       static_branch_enable(&__test);
|+       WARN_ON(!static_branch_likely(&__test));
|+       }
|        mm_init();

The following warnings show-up:
WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:701 text_poke+0x20d/0x230
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc1_pt_t1 #30
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.11.0-20171110_100015-anatol 04/01/2014
RIP: 0010:text_poke+0x20d/0x230
Code: 0f 0b 4c 89 e2 4c 89 ee 4c 89 f7 e8 7d 4b 9b 00 31 d2 31 f6 bf 86 02
00 00 48 8b 05 95 8e 24 01 e8 78 18 d8 00 e9 55 ff ff ff <0f> 0b e9 54 fe
ff ff 48 8b 05 75 a8 38 01 e9 64 fe ff ff 48 8b 1d
RSP: 0000:ffffffff94e03e30 EFLAGS: 00010046
RAX: 0100000000000000 RBX: fffff7b2c011f300 RCX: ffffffff94fcccf4
RDX: 0000000000000001 RSI: ffffffff94e03e77 RDI: ffffffff94fcccef
RBP: ffffffff94fcccef R08: 00000000fffffe00 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000040 R12: 0000000000000001
R13: ffffffff94e03e77 R14: ffffffff94fcdcef R15: fffff7b2c0000000
FS:  0000000000000000(0000) GS:ffff9adc87c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9adc8499d000 CR3: 000000000460a001 CR4: 00000000000606b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? start_kernel+0x23e/0x4c8
 ? start_kernel+0x23f/0x4c8
 ? text_poke_bp+0x50/0xda
 ? arch_jump_label_transform+0x89/0xe0
 ? __jump_label_update+0x78/0xb0
 ? static_key_enable_cpuslocked+0x4d/0x80
 ? static_key_enable+0x11/0x20
 ? start_kernel+0x23e/0x4c8
 ? secondary_startup_64+0xa5/0xb0
---[ end trace abdc99c031b8a90a ]---

If the code above is moved after mm_init(), no warning is shown, as struct
pages are initialized during handover from memblock.

Use text_poke_early() in static branching until early boot IRQs are
enabled, at which time switch to text_poke. Also, ensure text_poke() is
never invoked when unitialized memory access may happen by using:
BUG_ON(!after_bootmem); assertion.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        |  7 +++++++
 arch/x86/kernel/jump_label.c         | 11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 2ecd34e2d46c..e85ff65c43c3 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -37,5 +37,6 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763a3776..014f214da581 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -668,6 +668,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	local_irq_save(flags);
 	memcpy(addr, opcode, len);
 	local_irq_restore(flags);
+	sync_core();
 	/* Could also do a CLFLUSH here to speed up CPU recovery; but
 	   that causes hangs on some VIA CPUs. */
 	return addr;
@@ -693,6 +694,12 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	struct page *pages[2];
 	int i;
 
+	/*
+	 * While boot memory allocator is runnig we cannot use struct
+	 * pages as they are not yet initialized.
+	 */
+	BUG_ON(!after_bootmem);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..eeea935e9bb5 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -37,15 +37,18 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
-static void __jump_label_transform(struct jump_entry *entry,
-				   enum jump_label_type type,
-				   void *(*poker)(void *, const void *, size_t),
-				   int init)
+static void __ref __jump_label_transform(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 void *(*poker)(void *, const void *, size_t),
+					 int init)
 {
 	union jump_code_union code;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
+	if (early_boot_irqs_disabled)
+		poker = text_poke_early;
+
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			/*
-- 
2.18.0
