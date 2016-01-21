From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in
 kallsyms address table
Date: Thu, 21 Jan 2016 14:50:08 -0800
Message-ID: <20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
	<1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Jan 2016 18:19:43 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Similar to how relative extables are implemented, it is possible to emit
> the kallsyms table in such a way that it contains offsets relative to some
> anchor point in the kernel image rather than absolute addresses. The benefit
> is that such table entries are no longer subject to dynamic relocation when
> the build time and runtime offsets of the kernel image are different. Also,
> on 64-bit architectures, it essentially cuts the size of the address table
> in half since offsets can typically be expressed in 32 bits.
> 
> Since it is useful for some architectures (like x86) to retain the ability
> to emit absolute values as well, this patch adds support for both, by
> emitting absolute addresses as positive 32-bit values, and addresses
> relative to the lowest encountered relative symbol as negative values, which
> are subtracted from the runtime address of this base symbol to produce the
> actual address.
> 
> Support for the above is enabled by default for all architectures except
> IA-64, whose symbols are too far apart to capture in this manner.

I'm not really understanding the benefits of this.  A smaller address
table is nice, but why is it desirable that "such table entries are no
longer subject to dynamic relocation when the build time and runtime
offsets of the kernel image are different"?
