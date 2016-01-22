From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Date: Fri, 22 Jan 2016 14:44:42 +1100
Message-ID: <1453434282.21683.2.camel@ellerman.id.au>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	 <1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
	 <20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
	 <CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2016-01-21 at 14:55 -0800, Kees Cook wrote:
> On Thu, Jan 21, 2016 at 2:50 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Thu, 21 Jan 2016 18:19:43 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > 
> > > Similar to how relative extables are implemented, it is possible to emit
> > > the kallsyms table in such a way that it contains offsets relative to some
> > > anchor point in the kernel image rather than absolute addresses. The benefit
> > > is that such table entries are no longer subject to dynamic relocation when
> > > the build time and runtime offsets of the kernel image are different. Also,
> > > on 64-bit architectures, it essentially cuts the size of the address table
> > > in half since offsets can typically be expressed in 32 bits.
> > > 
> > > Since it is useful for some architectures (like x86) to retain the ability
> > > to emit absolute values as well, this patch adds support for both, by
> > > emitting absolute addresses as positive 32-bit values, and addresses
> > > relative to the lowest encountered relative symbol as negative values, which
> > > are subtracted from the runtime address of this base symbol to produce the
> > > actual address.
> > > 
> > > Support for the above is enabled by default for all architectures except
> > > IA-64, whose symbols are too far apart to capture in this manner.
> > 
> > I'm not really understanding the benefits of this.  A smaller address
> > table is nice, but why is it desirable that "such table entries are no
> > longer subject to dynamic relocation when the build time and runtime
> > offsets of the kernel image are different"?
> 
> IIUC, this means that the relocation work done after decompression now
> doesn't have to do relocation updates for all these values, which
> means a smaller relocation table as well.

Yep. If I remember the figures rightly it saves ~250K of relocations for the
powerpc build.

cheers
