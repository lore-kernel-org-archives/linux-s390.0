From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/11] introduce down_write_killable for rw_semaphore
Date: Wed, 30 Mar 2016 15:32:17 +0200
Message-ID: <20160330133217.GV3408@twins.programming.kicks-ass.net>
References: <1456750705-7141-1-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456750705-7141-1-git-send-email-mhocko@kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 29, 2016 at 01:58:14PM +0100, Michal Hocko wrote:
> I have tested on x86 with OOM situations with high mmap_sem contention
> (basically many parallel page faults racing with many parallel mmap/munmap
> tight loops) so the waiters for the write locks are routinely interrupted
> by SIGKILL.

Aside from the one niggle (as per the other email) they look good to me
and I would take them through the tip/locking tree.

Thanks!
