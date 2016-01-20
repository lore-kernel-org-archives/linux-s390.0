Return-Path: <ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4/4] x86_64: enable text relative kallsyms for 64-bit targets
Date: Wed, 20 Jan 2016 10:05:38 +0100
Message-Id: <1453280738-18721-5-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

This enables the newly introduced text-relative kallsyms support when
building 64-bit targets. This cuts the size of the kallsyms address
table in half, reducing the memory footprint of the kernel .rodata
section by about 400 KB for a KALLSYMS_ALL build, and about 100 KB
reduction in compressed size. (with CONFIG_RELOCATABLE=y)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
I tested this with my Ubuntu Wily box's config-4.2.0-23-generic, and
got the following results:

BEFORE:
=======
$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
12972949	2213240	1482752	16668941	 fe590d	vmlinux

$ readelf -S .tmp_kallsyms2.o |less
There are 9 section headers, starting at offset 0x3e0788:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  ...
  [ 4] .rodata           PROGBITS         0000000000000000  00000040
       00000000001c7738  0000000000000000   A       0     0     8
  [ 5] .rela.rodata      RELA             0000000000000000  001c7950
       0000000000218e38  0000000000000018   I       7     4     8
  [ 6] .shstrtab         STRTAB           0000000000000000  001c7778
       0000000000000039  0000000000000000           0     0     1

$ ls -l arch/x86/boot/bzImage
-rw-rw-r-- 1 ard ard 6893168 Jan 20 09:36 arch/x86/boot/bzImage

AFTER:
======
$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
12604501	2213240	1482752	16300493	 f8b9cd	vmlinux

$ readelf -S .tmp_kallsyms2.o |less
There are 8 section headers, starting at offset 0x16dd10:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  ...
  [ 4] .rodata           PROGBITS         0000000000000000  00000040
       000000000016db20  0000000000000000   A       0     0     8
  [ 5] .shstrtab         STRTAB           0000000000000000  0016db60
       0000000000000034  0000000000000000           0     0     1
  ...

$ ls -l arch/x86/boot/bzImage
-rw-rw-r-- 1 ard ard 6790224 Jan 19 22:24 arch/x86/boot/bzImage
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4a10ba9e95da..180a94bda8d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -142,6 +142,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select IRQ_FORCED_THREADING
+	select KALLSYMS_TEXT_RELATIVE		if X86_64
 	select MODULES_USE_ELF_RELA		if X86_64
 	select MODULES_USE_ELF_REL		if X86_32
 	select OLD_SIGACTION			if X86_32
-- 
2.5.0
