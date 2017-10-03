From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH REBASED 0/6] rwsem: Implement down_read_killable()
Date: Tue, 3 Oct 2017 11:03:03 +0200
Message-ID: <20171003090303.aclppj3jozdirtxl@hirez.programming.kicks-ass.net>
References: <150670038738.23930.7190484711222807884.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150670038738.23930.7190484711222807884.stgit@localhost.localdomain>
Sender: linux-alpha-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, heiko.carstens@de.ibm.com, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, rientjes@google.com, viro@zeniv.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 29, 2017 at 07:05:45PM +0300, Kirill Tkhai wrote:
> The series introduces new down_read_killable() primitive, which
> is similar to down_read(), but it may be interrupted by a signal.
> The most touched is architectures code. Also, it marks a new user
> of the primitive, which is iterate_dir().
> 
> ---
> 
> Kirill Tkhai (6):
>       alpha: Add __down_read_killable()
>       ia64: Add __down_read_killable()
>       s390: Add __down_read_killable()
>       x86: Add __down_read_killable()
>       rwsem: Add down_read_killable()
>       fs: Use killable down_read() in iterate_dir()
> 
> 
>  arch/alpha/include/asm/rwsem.h |   18 ++++++++++++++++--
>  arch/ia64/include/asm/rwsem.h  |   22 +++++++++++++++++++---
>  arch/s390/include/asm/rwsem.h  |   18 ++++++++++++++++--
>  arch/x86/include/asm/rwsem.h   |   35 +++++++++++++++++++++++++----------
>  arch/x86/lib/rwsem.S           |   12 ++++++++++++
>  fs/readdir.c                   |   11 +++++------
>  include/asm-generic/rwsem.h    |    8 ++++++++
>  include/linux/rwsem.h          |    1 +
>  kernel/locking/rwsem.c         |   16 ++++++++++++++++
>  9 files changed, 118 insertions(+), 23 deletions(-)

thanks!
