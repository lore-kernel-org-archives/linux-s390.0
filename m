Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1453280738-18721-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-5-git-send-email-ard.biesheuvel@linaro.org>
Date: Wed, 20 Jan 2016 11:12:39 -0800
Message-ID: <CAGXu5jJbgAJ32BVLe+nKrdjS1Xi=FZGbw8aNhHq9WinsE=t5og@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86_64: enable text relative kallsyms for 64-bit
 targets
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 1:05 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This enables the newly introduced text-relative kallsyms support when
> building 64-bit targets. This cuts the size of the kallsyms address
> table in half, reducing the memory footprint of the kernel .rodata
> section by about 400 KB for a KALLSYMS_ALL build, and about 100 KB
> reduction in compressed size. (with CONFIG_RELOCATABLE=y)
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> I tested this with my Ubuntu Wily box's config-4.2.0-23-generic, and
> got the following results:
>
> BEFORE:
> =======
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 12972949        2213240 1482752 16668941         fe590d vmlinux
>
> $ readelf -S .tmp_kallsyms2.o |less
> There are 9 section headers, starting at offset 0x3e0788:
>
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   ...
>   [ 4] .rodata           PROGBITS         0000000000000000  00000040
>        00000000001c7738  0000000000000000   A       0     0     8
>   [ 5] .rela.rodata      RELA             0000000000000000  001c7950
>        0000000000218e38  0000000000000018   I       7     4     8
>   [ 6] .shstrtab         STRTAB           0000000000000000  001c7778
>        0000000000000039  0000000000000000           0     0     1
>
> $ ls -l arch/x86/boot/bzImage
> -rw-rw-r-- 1 ard ard 6893168 Jan 20 09:36 arch/x86/boot/bzImage
>
> AFTER:
> ======
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 12604501        2213240 1482752 16300493         f8b9cd vmlinux
>
> $ readelf -S .tmp_kallsyms2.o |less
> There are 8 section headers, starting at offset 0x16dd10:
>
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   ...
>   [ 4] .rodata           PROGBITS         0000000000000000  00000040
>        000000000016db20  0000000000000000   A       0     0     8
>   [ 5] .shstrtab         STRTAB           0000000000000000  0016db60
>        0000000000000034  0000000000000000           0     0     1
>   ...
>
> $ ls -l arch/x86/boot/bzImage
> -rw-rw-r-- 1 ard ard 6790224 Jan 19 22:24 arch/x86/boot/bzImage
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4a10ba9e95da..180a94bda8d4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -142,6 +142,7 @@ config X86
>         select HAVE_UNSTABLE_SCHED_CLOCK
>         select HAVE_USER_RETURN_NOTIFIER
>         select IRQ_FORCED_THREADING
> +       select KALLSYMS_TEXT_RELATIVE           if X86_64
>         select MODULES_USE_ELF_RELA             if X86_64
>         select MODULES_USE_ELF_REL              if X86_32
>         select OLD_SIGACTION                    if X86_32
> --
> 2.5.0
>



-- 
Kees Cook
Chrome OS & Brillo Security
