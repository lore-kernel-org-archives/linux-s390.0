From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Date: Sun, 24 Jan 2016 00:21:34 +1100
Message-ID: <20160124002134.192eb470@cotter.ozlabs.ibm.com>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	<1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
	<CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
	<20160121152045.82639ae577d816198607d650@linux-foundation.org>
	<CAKv+Gu8QvECRJ9DhEd=k-oTy=xVVFJSMaW0EOCxMMPsWsF2RMQ@mail.gmail.com>
	<20160122130718.8313ec9aefa654f33bd17792@linux-foundation.org>
	<CAKv+Gu9rgeWYgJ_0Rpx1DmvWP90O8r=MBN4YH4xZyn3r4wrUdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu9rgeWYgJ_0Rpx1DmvWP90O8r=MBN4YH4xZyn3r4wrUdg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.cz>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Jan 2016 22:54:44 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> 
> """
> kallsyms: add support for relative offsets in kallsyms address table
> 
> Similar to how relative extables are implemented, it is possible to emit
> the kallsyms table in such a way that it contains offsets relative to some
> anchor point in the kernel image rather than absolute addresses.
> 
> On 64-bit architectures, it cuts the size of the kallsyms address table in
> half, since offsets between kernel symbols can typically be expressed in 32
> bits. This saves several hundreds of kilobytes of permanent .rodata on
> average. In addition, the kallsyms address table is no longer subject to
> dynamic relocation when CONFIG_RELOCATABLE is in effect, so the relocation
> work done after decompression now doesn't have to do relocation updates for
> all these values. This saves up to 24 bytes (i.e., the size of a ELF64 RELA
> relocation table entry) per value, which easily adds up to a couple of
> megabytes of uncompressed __init data on ppc64 or arm64. Even if these
> relocation entries typically compress well, the combined size reduction of
> 2.8 MB uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
> data) results in a ~500 KB space saving in the compressed image.
> 
> Since it is useful for some architectures (like x86) to retain the ability
> to emit absolute values as well, this patch adds support for both, by
> emitting absolute addresses as positive 32-bit values, and addresses
> relative to the lowest encountered relative symbol as negative values,
> which are subtracted from the runtime address of this base symbol to
> produce the actual address.
> 
> Support for the above is enabled by default for all architectures except
> IA-64, whose symbols are too far apart to capture in this manner.

snip

I still don't get the 2GB limitaiton, because of the 32 bit address
does it imply that modules load with -2GB to +2GB of the kernel base
address of the kallsyms address table?

Balbir Singh.
