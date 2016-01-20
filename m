Return-Path: <ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 3/4] s390: enable text relative kallsyms for 64-bit targets
Date: Wed, 20 Jan 2016 10:05:37 +0100
Message-Id: <1453280738-18721-4-git-send-email-ard.biesheuvel@linaro.org>
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
section by about 250 KB for a defconfig build.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

BEFORE:
=======
$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
12329586	3107008	14727792	30164386	1cc45a2	vmlinux

$ readelf -S .tmp_kallsyms2.o
There are 9 section headers, starting at offset 0x125b50:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  ...
  [ 4] .rodata           PROGBITS         0000000000000000  00000040
       0000000000125ad0  0000000000000000   A       0     0     8
  [ 5] .rela.rodata      RELA             0000000000000000  00125f28
       000000000015ead8  0000000000000018           7     4     8
  [ 6] .shstrtab         STRTAB           0000000000000000  00125b10
       0000000000000039  0000000000000000           0     0     1
  ...

$ ls -l arch/s390/boot/bzImage
-rwxrwxr-x 1 ard ard 5234224 Jan 20 08:22 arch/s390/boot/bzImage

AFTER:
======
$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
12088114	3102912	14727792	29918818	1c88662	vmlinux

$ readelf -S .tmp_kallsyms2.o
There are 8 section headers, starting at offset 0xeb428:

Section Headers:
  [Nr] Name              Type             Address           Offset
  ...
  [ 4] .rodata           PROGBITS         0000000000000000  00000040
       00000000000eb3b0  0000000000000000   A       0     0     8
  [ 5] .shstrtab         STRTAB           0000000000000000  000eb3f0
       0000000000000034  0000000000000000           0     0     1
  ...

$ ls -l arch/s390/boot/bzImage
-rwxrwxr-x 1 ard ard 5224256 Jan 20 08:23 arch/s390/boot/bzImage
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index dbeeb3a049f2..588160fd1db0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -149,6 +149,7 @@ config S390
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select KALLSYMS_TEXT_RELATIVE if 64BIT
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
 	select OLD_SIGACTION
-- 
2.5.0
