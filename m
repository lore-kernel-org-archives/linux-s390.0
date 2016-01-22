Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160122130718.8313ec9aefa654f33bd17792@linux-foundation.org>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	<1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
	<CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
	<20160121152045.82639ae577d816198607d650@linux-foundation.org>
	<CAKv+Gu8QvECRJ9DhEd=k-oTy=xVVFJSMaW0EOCxMMPsWsF2RMQ@mail.gmail.com>
	<20160122130718.8313ec9aefa654f33bd17792@linux-foundation.org>
Date: Fri, 22 Jan 2016 22:54:44 +0100
Message-ID: <CAKv+Gu9rgeWYgJ_0Rpx1DmvWP90O8r=MBN4YH4xZyn3r4wrUdg@mail.gmail.com>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in kallsyms
 address table
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160122215444.9z8-IA2p1zfvkpMVaNZaA6k4GvzP5zaf7CPUERen3SA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 22 January 2016 at 22:07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 22 Jan 2016 09:20:41 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> > : in half since offsets can typically be expressed in 32 bits.
>> > :
>> """
>>
>> In addition to fixing the broken grammar, would it make sense to
>> mention that dynamic relocation only occurs under
>> CONFIG_RELOCATABLE=y? I.e., something like
>>
>> """
>> On 64-bit architectures, it cuts the size of the kallsyms address
>> table in half, since offsets between kernel symbols can typically be
>> expressed in 32 bits. This saves several hundreds of kilobytes of
>> permanent .rodata on average. In addition, the kallsyms address table
>> is no longer subject to dynamic relocation when CONFIG_RELOCATABLE is
>> in effect, so the relocation work done after decompression now doesn't
>> have to do relocation updates for all these values. This saves up to
>> 24 bytes (i.e., the size of a ELF64 RELA relocation table entry) per
>> table entry, which easily adds up to a couple of megabytes of
>> uncompressed __init data on ppc64 or arm64. Even if these relocation
>> entries typically compress well, the combined size reduction of 2.8 MB
>> uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
>> data) results in a ~500 KB space saving in the compressed image.
>> """
>
> Yes, that sounds very good.  I'd buy one :)
>

Did I tell you about the extended warranty?

> Can you please send along a complete new changelog sometime?

Sure:

"""
kallsyms: add support for relative offsets in kallsyms address table

Similar to how relative extables are implemented, it is possible to emit
the kallsyms table in such a way that it contains offsets relative to some
anchor point in the kernel image rather than absolute addresses.

On 64-bit architectures, it cuts the size of the kallsyms address table in
half, since offsets between kernel symbols can typically be expressed in 32
bits. This saves several hundreds of kilobytes of permanent .rodata on
average. In addition, the kallsyms address table is no longer subject to
dynamic relocation when CONFIG_RELOCATABLE is in effect, so the relocation
work done after decompression now doesn't have to do relocation updates for
all these values. This saves up to 24 bytes (i.e., the size of a ELF64 RELA
relocation table entry) per value, which easily adds up to a couple of
megabytes of uncompressed __init data on ppc64 or arm64. Even if these
relocation entries typically compress well, the combined size reduction of
2.8 MB uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
data) results in a ~500 KB space saving in the compressed image.

Since it is useful for some architectures (like x86) to retain the ability
to emit absolute values as well, this patch adds support for both, by
emitting absolute addresses as positive 32-bit values, and addresses
relative to the lowest encountered relative symbol as negative values,
which are subtracted from the runtime address of this base symbol to
produce the actual address.

Support for the above is enabled by default for all architectures except
IA-64, whose symbols are too far apart to capture in this manner.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # powerpc
Tested-by: Kees Cook <keescook@chromium.org> # x86_64
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
"""

Thanks,
Ard.
