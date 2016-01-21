Return-Path: <mpe@ellerman.id.au>
Message-ID: <1453348872.468.6.camel@ellerman.id.au>
Subject: Re: [PATCH 2/4] powerpc: enable text relative kallsyms for ppc64
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 21 Jan 2016 15:01:12 +1100
In-Reply-To: <1453280738-18721-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-3-git-send-email-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mmarek@suse.cz, rusty@rustcorp.com.au
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2016-01-20 at 10:05 +0100, Ard Biesheuvel wrote:

> This enables the newly introduced text-relative kallsyms support when
> building 64-bit targets. This cuts the size of the kallsyms address
> table in half, and drastically reduces the size of the PIE dynamic
> relocation section when building with CONFIG_RELOCATABLE=y (by about
> 3 MB for ppc64_defconfig)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Results for ppc64_defconfig:
> 
> BEFORE:
> =======
> $ size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 19827996	2008456	 849612	22686064	15a2970	vmlinux
> 
> $ readelf -S .tmp_kallsyms2.o
> There are 9 section headers, starting at offset 0x4513f8:
> 
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   ...
>   [ 4] .rodata           PROGBITS         0000000000000000  00000100
>        00000000001fcf00  0000000000000000   A       0     0     256
>   [ 5] .rela.rodata      RELA             0000000000000000  001fd1d8
>        0000000000254220  0000000000000018   I       7     4     8
>   [ 6] .shstrtab         STRTAB           0000000000000000  001fd000
>        0000000000000039  0000000000000000           0     0     1
>   ...
> 
> $ ls -l arch/powerpc/boot/zImage
> -rwxrwxr-x 2 ard ard 7533160 Jan 20 08:43 arch/powerpc/boot/zImage
> 
> AFTER:
> ======
> $ size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 16979516	2009992	 849612	19839120	12eb890	vmlinux
> 
> $ readelf -S .tmp_kallsyms2.o
> There are 8 section headers, starting at offset 0x199bb0:
> 
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   ...
>   [ 4] .rodata           PROGBITS         0000000000000000  00000100
>        0000000000199900  0000000000000000   A       0     0     256
>   [ 5] .shstrtab         STRTAB           0000000000000000  00199a00
>        0000000000000034  0000000000000000           0     0     1
>   ...
> 
> $ ls -l arch/powerpc/boot/zImage
> -rwxrwxr-x 2 ard ard 6985672 Jan 20 08:45 arch/powerpc/boot/zImage


Nice space saving, thanks very much.

I've booted this on a bunch of machines and it seems to be working fine.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
