From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in kallsyms
 address table
Date: Fri, 22 Jan 2016 09:20:41 +0100
Message-ID: <CAKv+Gu8QvECRJ9DhEd=k-oTy=xVVFJSMaW0EOCxMMPsWsF2RMQ@mail.gmail.com>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	<1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
	<CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
	<20160121152045.82639ae577d816198607d650@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160121152045.82639ae577d816198607d650@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 22 January 2016 at 00:20, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 21 Jan 2016 14:55:00 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> IIUC, this means that the relocation work done after decompression now
>> doesn't have to do relocation updates for all these values, which
>> means a smaller relocation table as well.
>
> Makes sense, thanks.  I altered the changelog
>
> : Similar to how relative extables are implemented, it is possible to
> : emit the kallsyms table in such a way that it contains offsets relative
> : to some anchor point in the kernel image rather than absolute
> : addresses.
> :

Thanks for taking the patch, but the bit below does not make sense anymore:

"""
> : The benefit is that such table entries are no longer subject to dynamic
> : relocation when the build time so the relocation work done after
> : decompression now doesn't have to do relocation updates for all these
> : values, which means a smaller relocation table as well.
> :
> : Also, the runtime offsets of the kernel image are different.  Also, on
> : 64-bit architectures, it essentially cuts the size of the address table
> : in half since offsets can typically be expressed in 32 bits.
> :
"""

In addition to fixing the broken grammar, would it make sense to
mention that dynamic relocation only occurs under
CONFIG_RELOCATABLE=y? I.e., something like

"""
On 64-bit architectures, it cuts the size of the kallsyms address
table in half, since offsets between kernel symbols can typically be
expressed in 32 bits. This saves several hundreds of kilobytes of
permanent .rodata on average. In addition, the kallsyms address table
is no longer subject to dynamic relocation when CONFIG_RELOCATABLE is
in effect, so the relocation work done after decompression now doesn't
have to do relocation updates for all these values. This saves up to
24 bytes (i.e., the size of a ELF64 RELA relocation table entry) per
table entry, which easily adds up to a couple of megabytes of
uncompressed __init data on ppc64 or arm64. Even if these relocation
entries typically compress well, the combined size reduction of 2.8 MB
uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
data) results in a ~500 KB space saving in the compressed image.
"""

Thanks,
Ard.
