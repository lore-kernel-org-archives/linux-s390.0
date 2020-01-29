Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Jan 2020 10:36:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page
 table helpers
Message-ID: <20200129103640.GA668562@arrakis.emea.arm.com>
References: <20200128174709.GK655507@arrakis.emea.arm.com>
 <69091BA4-18C4-4425-A5E2-31FBE4654AF9@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69091BA4-18C4-4425-A5E2-31FBE4654AF9@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Mark Rutland <Mark.Rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Michael Ellerman <mpe@ellerman.id.au>, Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, Kees Cook <keescook@chromium.org>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, Jan 28, 2020 at 02:07:10PM -0500, Qian Cai wrote:
> On Jan 28, 2020, at 12:47 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > The primary goal here is not finding regressions but having clearly
> > defined semantics of the page table accessors across architectures. x86
> > and arm64 are a good starting point and other architectures will be
> > enabled as they are aligned to the same semantics.
> 
> This still does not answer the fundamental question. If this test is
> simply inefficient to find bugs,

Who said this is inefficient (other than you)?

> who wants to spend time to use it regularly? 

Arch maintainers, mm maintainers introducing new macros or assuming
certain new semantics of the existing macros.

> If this is just one off test that may get running once in a few years
> (when introducing a new arch), how does it justify the ongoing cost to
> maintain it?

You are really missing the point. It's not only for a new arch but
changes to existing arch code. And if the arch code churn in this area
is relatively small, I'd expect a similarly small cost of maintaining
this test.

If you only turn DEBUG_VM on once every few years, don't generalise this
to the rest of the kernel developers (as others pointed out, this test
is default y if DEBUG_VM).

Anyway, I think that's a pointless discussion, so not going to reply
further (unless you have technical content to add).

-- 
Catalin
