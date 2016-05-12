From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 12 May 2016 10:17:58 +0100
Message-ID: <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <5842999.Zgpfq4gkVz@wuerfel>
 <20160511165900.GM3051@e104818-lin.cambridge.arm.com>
 <4989778.Fs81NJurjH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4989778.Fs81NJurjH@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 11, 2016 at 09:30:07PM +0200, Arnd Bergmann wrote:
> On Wednesday 11 May 2016 17:59:01 Catalin Marinas wrote:
> > On Wed, May 11, 2016 at 12:55:01PM +0200, Arnd Bergmann wrote:
> > > On Wednesday 11 May 2016 11:04:38 Yury Norov wrote:
> > > > On Wed, May 11, 2016 at 10:04:16AM +0800, Zhangjian (Bamvor) wrote:
> > > > [...]
> > > > 
> > > > > >>Ok, I will test the ltp syscall test.
> > > > > >>With this changes, the issue I mentioned should be fixed. But we still
> > > > > >>use mmap2 syscall for ILP32 application when we pass the offset instead
> > > > > >>of page offset. Is it correct?
> > > > > >
> > > > > >I don't remember. It's probably not important whether we have the shift
> > > > > >in there, as long as it's independent of the actual kernel page size and
> > > > > >user space and kernel agree on the calling conventions.
> > > > > Well. I am ok with where to shift the pages size because we get the same
> > > > > result. I was just thinking if we should get rid of the name of mmap2 in our
> > > > > ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
> > > > > if they do not know the implementations.
> > > > > 
> > > > 
> > > > This is what generic unistd.h does. If you want to change it, you'd
> > > > change each arch that uses generic unistd.h.
> > > 
> > > Generic unistd.h has this:
> > > 
> > > #ifdef __SYSCALL_COMPAT
> > > #define __SC_COMP_3264(_nr, _32, _64, _comp) __SYSCALL(_nr, _comp)
> > > #else
> > > #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
> > > #endif
> > > 
> > > #define __NR3264_mmap 222
> > > __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
> > > 
> > > 
> > > #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
> > > #define __NR_mmap __NR3264_mmap
> > > #else
> > > #define __NR_mmap2 __NR3264_mmap
> > > #endif
> > > 
> > > So by default we get __NR_mmap2 and sys_mmap2 on 32-bit ABIs, but
> > > __NR_mmap and sys_mmap on 64-bit ABIs, as it should be.
> > > 
> > > The problem is that arch/arm64/kernel/sys_ilp32.c now overrides
> > > this to use __NR_mmap2 with sys_mmap, so we have a mismatch. I think
> > > we should either override both the implementation and the number,
> > > or neither of them.
> > 
> > I would vote for "neither of them" (so we use __NR_mmap2 and sys_mmap2)
> > to keep it close to new 32-bit architectures, even though we would have
> > some shifts by 12 in both glibc and kernel.
> 
> I don't think the shifts are a problem, the main downside would be
> the limit to 44 bits of file offsets (16TB files), but it's also
> unclear if that is a practical problem at all. If it is, we run
> into the same problem on all other 32-bit architectures too.

I hope people are seriously thinking of moving to an LP64 ABI if they
have such large file offset needs.

-- 
Catalin
