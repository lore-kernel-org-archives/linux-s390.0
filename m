From: David Miller <davem@davemloft.net>
Subject: Re: Next 14: s390x defconfig build failure
Date: Tue, 14 Apr 2009 01:55:51 -0700 (PDT)
Message-ID: <20090414.015551.220726058.davem@davemloft.net>
References: <20090414160809.e92d9d3e.sfr@canb.auug.org.au>
	<49E44C15.4050208@in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49E44C15.4050208@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: sachinp@in.ibm.com
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Sachin Sant <sachinp@in.ibm.com>
Date: Tue, 14 Apr 2009 14:10:53 +0530

> Today's next tree build (defconfig s390x ) failed with following
> error.
> 
> In file included from kernel/panic.c:11:
> include/linux/debug_locks.h: In function __debug_locks_off:
> include/linux/debug_locks.h:15: error: implicit declaration of
> function xchg
> 
> Probably because of commit 9eeba6138cefc0435695463ddadb0d95e0a6bcd2.

I see that Stephen fixed this by adding a asm/system.h include
to asm/atomic.h on sparc.

I don't agree with this, and now we have yet another platform
broken in the same way.

If debug_locks.h needs xchg() I think it should include asm/system.h
which was always the traditional location from which to include that
declaration.

It is even the case on x86.

We get it via asm/atomic.h by accident on x86 and other platforms, not
because that's the canonical location from which to get xchg().
