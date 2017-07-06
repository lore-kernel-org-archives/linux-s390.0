From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/7] rwsem-spinlock: Add killable versions of
 rwsem_down_read_failed()
Date: Thu, 6 Jul 2017 10:04:47 +0200
Message-ID: <20170706080447.a7emouoysilqex4p@hirez.programming.kicks-ass.net>
References: <149789463636.9059.16943955939303454611.stgit@localhost.localdomain>
 <149789534632.9059.2901382369609922565.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149789534632.9059.2901382369609922565.stgit@localhost.localdomain>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 19, 2017 at 09:02:26PM +0300, Kirill Tkhai wrote:

> Subject: [PATCH 2/7] rwsem-spinlock: Add killable versions of rwsem_down_read_failed()

>  kernel/locking/rwsem-xadd.c |   33 ++++++++++++++++++++++++++++++---

Fixed that subject for your ;-)
