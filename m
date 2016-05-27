From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 19:58:06 +0300
Message-ID: <20160527165806.GA20966@yury-N73SV>
References: <6293194.tGy03QJ9ME@wuerfel>
 <13240365.okADkKsTBJ@wuerfel>
 <20160527093052.GB7865@e104818-lin.cambridge.arm.com>
 <5422652.7gdoDlB8u0@wuerfel>
 <20160527130446.GD7865@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160527130446.GD7865@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 27, 2016 at 02:04:47PM +0100, Catalin Marinas wrote:
> On Fri, May 27, 2016 at 12:49:11PM +0200, Arnd Bergmann wrote:
> > On Friday, May 27, 2016 10:30:52 AM CEST Catalin Marinas wrote:
> > > On Fri, May 27, 2016 at 10:42:59AM +0200, Arnd Bergmann wrote:
> > > > On Friday, May 27, 2016 8:03:57 AM CEST Heiko Carstens wrote:
> > > > > > > > > Cost wise, this seems like it all cancels out in the end, but what
> > > > > > > > > do I know?
> > > > > > > > 
> > > > > > > > I think you know something, and I also think Heiko and other s390 guys
> > > > > > > > know something as well. So I'd like to listen their arguments here.
> > > > > 
> > > > > If it comes to 64 bit arguments for compat system calls: s390 also has an
> > > > > x32-like ABI extension which allows user space to use full 64 bit
> > > > > registers. As far as I know hardly anybody ever made use of that.
> > > > > 
> > > > > However even if that would be widely used, to me it wouldn't make sense to
> > > > > add new compat system calls which allow 64 bit arguments, simply because
> > > > > something like
> > > > > 
> > > > > c = (u32)a | (u64)b << 32;
> > > > > 
> > > > > can be done with a single 1-cycle instruction. It's just not worth the
> > > > > extra effort to maintain additional system call variants.
> > > > 
> > > > For reference, both tile and mips also have separate 32-bit ABIs that are
> > > > only used on 64-bit kernels (aside from the normal 32-bit ABI). Tile
> > > > does it like s390 and passes 64-bit arguments as pairs, while MIPS
> > > > and x86 and pass them as single registers.
> > > 
> > > AFAIK, x32 also requires that the upper half of a 64-bit reg is zeroed
> > > by the user when a 32-bit value is passed. We could require the same on
> > > AArch64/ILP32 but I'm a bit uneasy on trusting a multitude of C
> > > libraries on this.
> > 
> > It's not about trusting a C library, it's about ensuring malicious code
> > cannot pass argumentst that the kernel code assumes will never happen.
> 
> At least for pointers and sizes, we have additional checks in place
> already, like __access_ok(). Most of the syscalls should be safe since
> they either go through some compat functions taking 32-bit arguments or
> are routed to native functions which already need to cope with a full
> random 64-bit value.

It's not a good idea to rely on current implementation. Implementation
may be changed and it's impossible to check each and every patch
against register top-halves correctness.

> 
> On arm64, I think the only risk comes from syscall handlers expecting
> 32-bit arguments but using 64-bit types. Apart from pointer types, I
> don't expect this to happen but we could enforce it via a
> BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)) in __SC_DELOUSE as per
> the s390 implementation. With ILP32 if we go for 64-bit off_t, those
> syscalls would be routed directly to the native layer.
> 

64-bit off_t doesn't imply we'd rout it directly. At first glance it's
looking reasonable but there are other considerations like simplicity and
unification with aarch32 that may become more important. That's what
David pointed out.

So, we have 3 options for now:
1. Clear top halves in entry.S which means we pass off_t as a pair.
   The cost is performance (didn't measure it yet and doubt about it
   makes serious impact). The advantage is simplicity and unification with
   aarch32, as I mentioned above. And David likes it. And it mininizes
   the amount of changes on glibc side.
2. Clear top halves in in separated file hosted wrappers.
3. Clear top halves in I-cache and tail optimization friendly in-site wrappers.

2 and 3 are the same from ABI point of view.

2 is the worst for me as it is the most complex in implementation and 
I-cache and tail optimization non-friendly. But Heiko likes it.
 
3 is what Catalin is talking about, and it was my initial approach.
Though I didn't made compiler to do tail optimization, I think we can
do it.

But 2 is what we have now. And I'd choose it. We'll never get ilp32 done
if will roll back previously agreed decisions again and again.

Yury.

> -- 
> Catalin
