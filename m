From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Wed, 25 May 2016 13:21:45 -0700 (PDT)
Message-ID: <20160525.132145.1271448744307448631.davem@davemloft.net>
References: <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
	<20160525.123017.1597296248000772613.davem@davemloft.net>
	<20160525200327.GA22395@yury-N73SV>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160525200327.GA22395@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: ynorov@caviumnetworks.com
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

From: Yury Norov <ynorov@caviumnetworks.com>
Date: Wed, 25 May 2016 23:03:27 +0300

> On Wed, May 25, 2016 at 12:30:17PM -0700, David Miller wrote:
>> From: Yury Norov <ynorov@caviumnetworks.com>
>> Date: Tue, 24 May 2016 03:04:30 +0300
>> 
>> > +To clear that top halves, automatic wrappers are introduced. They clear all
>> > +required registers before passing control to regular syscall handler.
>> 
>> Why have one of these for every single compat system call, rather than
>> simply clearing the top half of all of these registers unconditionally
>> in the 32-bit system call trap before the system call is invoked?
>> 
>> That's what we do on sparc64.
>> 
>> And with that, you only need wrappers for the case where there needs
>> to be proper sign extention of a 32-bit signed argument.
> 
> It was discussed as one of possible solutions. The downside of it is
> that we cannot pass 64-bit types (like off_t) in single register.

Wrappers can be added for the cases where you'd like to do that.

> The other downside is that we clear top halves for every single
> syscall, and it looks excessive. So, from spark64 and s390 approaches
> we choosed second.

It's like 4 cpu cycles even on crappy sparc64 cpus which only dual
issue. :)

And that's a pretty low cost for the benefits if you ask me.
