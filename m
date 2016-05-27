From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 07:52:54 +0200
Message-ID: <20160527055254.GA3820@osiris>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
 <20160525.123017.1597296248000772613.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525.123017.1597296248000772613.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: ynorov@caviumnetworks.com, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 25, 2016 at 12:30:17PM -0700, David Miller wrote:
> From: Yury Norov <ynorov@caviumnetworks.com>
> Date: Tue, 24 May 2016 03:04:30 +0300
> 
> > +To clear that top halves, automatic wrappers are introduced. They clear all
> > +required registers before passing control to regular syscall handler.
> 
> Why have one of these for every single compat system call, rather than
> simply clearing the top half of all of these registers unconditionally
> in the 32-bit system call trap before the system call is invoked?
> 
> That's what we do on sparc64.
> 
> And with that, you only need wrappers for the case where there needs
> to be proper sign extention of a 32-bit signed argument.

That would probably also work for arm. On s390 we still have these odd 31
bit pointers in compat mode which require us to clear 33 bits instead of 32
bits. That makes up for appr. one third of all system calls.

The additional wrappers are only for zero/sign extension, where I count a
total of 27 on s390.

The reason for doing this in C was the constant copy-paste error rate, when
adding new system calls plus I got a rid of a lot of unnecessary asm code.
