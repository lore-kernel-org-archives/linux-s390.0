From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Fri, 13 May 2016 09:28:03 +0000
Message-ID: <20160513092802.GA13400@localhost.localdomain>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
 <20160512134431.GB30205@yury-N73SV>
 <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
 <20160512142457.GC30205@yury-N73SV>
 <20160512152805.GJ11226@e104818-lin.cambridge.arm.com>
 <57358C2B.1010106@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57358C2B.1010106@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, Nathan_Lynch@mentor.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwab@suse.de, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 13, 2016 at 04:11:23PM +0800, Zhangjian (Bamvor) wrote:
> On 2016/5/12 23:28, Catalin Marinas wrote:
> >On Thu, May 12, 2016 at 05:24:57PM +0300, Yury Norov wrote:
> >>On Thu, May 12, 2016 at 03:07:35PM +0100, Catalin Marinas wrote:
> >>>On Thu, May 12, 2016 at 04:44:31PM +0300, Yury Norov wrote:
> >>>>On Thu, May 12, 2016 at 02:35:34PM +0100, Catalin Marinas wrote:
> >>>>>On Thu, May 12, 2016 at 03:20:00AM +0300, Yury Norov wrote:
> >>>>>>I debugged preadv02 and pwritev02 failures and found very weird bug.
> >>>>>>Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
> >>>>>>of vector, and kernel reports successful read/write.
> >>>>>>
> >>>>>>There are 2 problems:
> >>>>>>1. How kernel allows such address to be passed to fs subsystem;
> >>>>>>2. How fs successes to read/write at non-mapped, and in fact non-user
> >>>>>>address.
> >>>>>>
> >>>>>>I don't know the answer on 2'nd question, and it might be something
> >>>>>>generic. But I investigated first problem.
> >>>>>>
> >>>>>>The problem is that compat_rw_copy_check_uvector() uses access_ok() to
> >>>>>>validate user address, and on arm64 it ends up with checking buffer
> >>>>>>end against current_thread_info()->addr_limit.
> >>>>>>
> >>>>>>current_thread_info()->addr_limit for ilp32, and most probably for
> >>>>>>aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
> >>>>>>It happens because on thread creation we call flush_old_exec() to set
> >>>>>>addr_limit, and completely ignore compat mode there.
[...]
> >>>>That's true, but USER_DS depends on personality which is not set yet
> >>>>for new thread, as I wrote above. In fact, I tried correct USER_DS
> >>>>only, and it doesn't work
> >>>
> >>>Ah, it looks like load_elf_binary() sets the personality after
> >>>flush_old_exec(). Looking at powerpc and x86, they set USER_DS to the
> >>>maximum 64-bit task value, so they should have a similar issue with
> >>>native 32-bit vs compat behaviour.
[...]
> >>>So what exactly is LTP complaining about? Is different error (like
> >>>EFAULT vs EINVAL) or not getting an error at all.
> >>
> >>It should be EINVAL, but it succeed. The other problem is that
> >>following fs routines does not complain on wrong address.
> >
> >I see. The test asks the kernel to write a single byte (out of maximum
> >64) to the user address 0xffffffff.
> 
> What address We should set for this limitation, TASK_SIZE or STACK_TOP?
> It is same for 64bit application. But STACK_TOP(0xffff0000) is below
> TASK_SIZE in 32bit application. The address above STACK_TOP is preserved
> for 32bit application.

The discussion is mainly around whether USER_DS for 32-bit compat apps
should be the same as USER_DS for native 32-bit apps. Even for native
32-bit kernels, we don't use STACK_TOP as addr_limit. A read/write from
0xffffffff would fail in both cases anyway. I think the LTP test doesn't
even try to access such memory but only to probe the range validity (I
haven't managed to build the latest LTP yet).

-- 
Catalin
