From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 11:10:37 +0100
Message-ID: <20160527101036.GC7865@e104818-lin.cambridge.arm.com>
References: <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
 <20160526.124344.1660236473079504674.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526.124344.1660236473079504674.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 26, 2016 at 12:43:44PM -0700, David Miller wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 26 May 2016 15:20:58 +0100
> 
> > We can solve (a) by adding more __SC_WRAP annotations in the generic
> > unistd.h.
>  ...
> 
> I really think it's much more robust to clear the tops of the registers
> by default.  Then you won't be auditing constantly and adding more and
> more wrappers.

I think we could avoid adding a new __SC_WRAP by redefining __SYSCALL
for ILP32 to always invoke a wrapper. But given the wrapper overhead,
cache locality, I don't think we would notice any performance difference
in either case.

> You can't even quantify the performance gains for me in any precise
> way.  Whatever you gain by avoiding the 64-bit
> decompostion/reconstitution for those few system calls with 64-bit
> registers, you are losing by calling the wrappers for more common
> system calls, more often.

I hope Yury can provide some numbers. All being equal, I would go for
the lowest code maintenance cost (which is probably less annotations and
wrappers).

> "it's more natural to pass 64-bit values in a register" is not a clear
> justification for this change.

It's more related to how we went about the ILP32 ABI. We initially asked
for a 64-bit native ABI similar to x32 until the libc-alpha community
raised some POSIX compliance issues on time structures. So we decided to
go for a 32-bit-like ABI while keeping the syscall interface close to
the AArch64/ILP32 procedure calling standard (64-bit values passed in a
single register). And now we have this discussion, revisiting this
decision again (which is perfectly fine, we better get it right before
any merging plans; thanks for your input).

-- 
Catalin
