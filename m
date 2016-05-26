From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Thu, 26 May 2016 12:43:44 -0700 (PDT)
Message-ID: <20160526.124344.1660236473079504674.davem@davemloft.net>
References: <6407614.fdv5XFSBue@wuerfel>
	<20160525.142821.1719403997976778673.davem@davemloft.net>
	<20160526142057.GA7456@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: catalin.marinas@arm.com
Cc: arnd@arndb.de, ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 26 May 2016 15:20:58 +0100

> We can solve (a) by adding more __SC_WRAP annotations in the generic
> unistd.h.
 ...

I really think it's much more robust to clear the tops of the registers
by default.  Then you won't be auditing constantly and adding more and
more wrappers.

You can't even quantify the performance gains for me in any precise
way.  Whatever you gain by avoiding the 64-bit
decompostion/reconstitution for those few system calls with 64-bit
registers, you are losing by calling the wrappers for more common
system calls, more often.

"it's more natural to pass 64-bit values in a register" is not a clear
justification for this change.

This looks way over engineered to me.
