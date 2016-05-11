From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Wed, 11 May 2016 12:55:01 +0200
Message-ID: <5842999.Zgpfq4gkVz@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <57329320.1000500@huawei.com> <20160511075438.GA15628@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160511075438.GA15628@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 11 May 2016 11:04:38 Yury Norov wrote:
> On Wed, May 11, 2016 at 10:04:16AM +0800, Zhangjian (Bamvor) wrote:
> [...]
> 
> > >>Ok, I will test the ltp syscall test.
> > >>With this changes, the issue I mentioned should be fixed. But we still
> > >>use mmap2 syscall for ILP32 application when we pass the offset instead
> > >>of page offset. Is it correct?
> > >
> > >I don't remember. It's probably not important whether we have the shift
> > >in there, as long as it's independent of the actual kernel page size and
> > >user space and kernel agree on the calling conventions.
> > Well. I am ok with where to shift the pages size because we get the same
> > result. I was just thinking if we should get rid of the name of mmap2 in our
> > ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
> > if they do not know the implementations.
> > 
> 
> This is what generic unistd.h does. If you want to change it, you'd
> change each arch that uses generic unistd.h.
> 

Generic unistd.h has this:

#ifdef __SYSCALL_COMPAT
#define __SC_COMP_3264(_nr, _32, _64, _comp) __SYSCALL(_nr, _comp)
#else
#define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
#endif

#define __NR3264_mmap 222
__SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)


#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
#define __NR_mmap __NR3264_mmap
#else
#define __NR_mmap2 __NR3264_mmap
#endif

So by default we get __NR_mmap2 and sys_mmap2 on 32-bit ABIs, but
__NR_mmap and sys_mmap on 64-bit ABIs, as it should be.

The problem is that arch/arm64/kernel/sys_ilp32.c now overrides
this to use __NR_mmap2 with sys_mmap, so we have a mismatch. I think
we should either override both the implementation and the number,
or neither of them.

I think what happened is that you chose to override sys_mmap because
sys_mmap2 sometimes takes an off_t argument, however the kernel
just treats it as 'unsigned long', with a range of 44 bits for the
offset. Using sys_mmap with a __kernel_loff_t argument gives
us 64-bit range, but if we do that, I think it should be __NR_mmap.

	Arnd
