Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/4] support for text-relative kallsyms table
In-Reply-To: <CAKv+Gu8Pzjt3e_CH0xiCqTk8b6kWV=7Wbiy2YsX99g0SQTW8Tg@mail.gmail.com>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <878u3jy0te.fsf@rustcorp.com.au>
 <CAKv+Gu95c84Pq=5FEAMkpym7HjmVpeGqy1B_RgWwd8eBe6b0qQ@mail.gmail.com>
 <CAKv+Gu8Pzjt3e_CH0xiCqTk8b6kWV=7Wbiy2YsX99g0SQTW8Tg@mail.gmail.com>
Date: Wed, 27 Jan 2016 14:16:41 +1030
Message-ID: <87a8nrvg4e.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au, Michal Marek <mmarek@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> On 21 January 2016 at 07:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 21 January 2016 at 06:10, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>>> This implements text-relative kallsyms address tables. This was developed
>>>> as part of my series to implement KASLR/CONFIG_RELOCATABLE for arm64, but
>>>> I think it may be beneficial to other architectures as well, so I am
>>>> presenting it as a separate series.
>>>
>>> Nice work!
>>>
>>
>> Thanks
>>
>>> AFAICT this should work for every arch, as long as they start with _text
>>> (esp: data and init must be > _text).  In addition, it's not harmful on
>>> 32 bit archs.
>>>
>>> IOW, I'd like to turn it on for everyone and discard some code.  But
>>> it's easier to roll in like you've done first.
>>>
>>> Should we enable it by default for every arch for now, and see what
>>> happens?
>>>
>>
>> As you say, this only works if every symbol >= _text, which is
>> obviously not the case per the conditional in scripts/kallsyms.c,
>> which emits _text + n or _text - n depending on whether the symbol
>> precedes or follows _text. The git log tells me for which arch this
>> was originally implemented, but it does not tell me which other archs
>> have come to rely on it in the meantime.
>>
>> On top of that, ia64 fails to build with this option, since it has
>> some whitelisted absolute symbols that look suspiciously like they
>> could be emitted as _text relative (and it does not even matter in the
>> absence of CONFIG_RELOCATABLE on ia64, afaict) but I don't know
>> whether we can just override their types as T, since it would also
>> change the type in the contents of /proc/kallsyms. So some guidance
>> would be appreciated here.
>>
>
> Digging a little deeper, it appears that it would be non-trivial to
> port this to ia64:
>
> ...
> a000000000040720 A __kernel_syscall_via_break
> a000000000040740 A __kernel_sigtramp
> a000000000040a00 A __kernel_syscall_via_epc
> a000000100000000 T ia64_ivt
> a000000100000000 T __start_ivt_text
> a000000100000000 T _stext
> a000000100000000 T _text
> ...
>
> The top three symbols are the absolute symbols that are explicitly
> whitelisted by scripts/kallsyms.c, and they are too far from 0 and too
> far from _text to be representable in 32 bits

How annoying.  OK, until ia64 is removed, we'll leave the option.

Thanks,
Rusty.
