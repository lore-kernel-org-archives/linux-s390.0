Return-Path: <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160120094326.GD3395@osiris>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160120094326.GD3395@osiris>
Date: Wed, 20 Jan 2016 11:04:24 +0100
Message-ID: <CAKv+Gu_nvdBqp50MZ+wHGn-nP3P3HBo_XeabqCCebEUBeVtUFQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] s390: enable text relative kallsyms for 64-bit targets
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <linux-s390.vger.kernel.org>

On 20 January 2016 at 10:43, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> On Wed, Jan 20, 2016 at 10:05:37AM +0100, Ard Biesheuvel wrote:
>> This enables the newly introduced text-relative kallsyms support when
>> building 64-bit targets. This cuts the size of the kallsyms address
>> table in half, reducing the memory footprint of the kernel .rodata
>> section by about 250 KB for a defconfig build.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index dbeeb3a049f2..588160fd1db0 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -149,6 +149,7 @@ config S390
>>       select HAVE_REGS_AND_STACK_ACCESS_API
>>       select HAVE_SYSCALL_TRACEPOINTS
>>       select HAVE_VIRT_CPU_ACCOUNTING
>> +     select KALLSYMS_TEXT_RELATIVE if 64BIT
>
> Please remove the "if 64BIT" since s390 is always 64BIT in the meantime.
> Tested on s390 and everything seems still to work ;)
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>

Thanks! Did you take a look at /proc/kallsyms, by any chance? It
should look identical with and without these patches
