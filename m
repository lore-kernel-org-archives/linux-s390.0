From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Wed, 25 May 2016 23:01:06 +0200
Message-ID: <6407614.fdv5XFSBue@wuerfel>
References: <20160525200327.GA22395@yury-N73SV> <6293194.tGy03QJ9ME@wuerfel> <20160525.135039.244098606649448826.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160525.135039.244098606649448826.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: ynorov@caviumnetworks.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 25 May 2016 22:47:33 +0200
> 
> > If we use the normal calling conventions, we could remove these overrides
> > along with the respective special-case handling in glibc. None of them
> > look particularly performance-sensitive, but I could be wrong there.
> 
> You could set the lowest bit in the system call entry pointer to indicate
> the upper-half clears should be elided.

Right, but that would introduce an extra conditional branch in the syscall
hotpath, and likely eliminate the gains from passing the loff_t arguments
in a single register instead of a pair.

	Arnd
