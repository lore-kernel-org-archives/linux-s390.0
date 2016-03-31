From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] locking, rwsem: introduce basis for
 down_write_killable
Date: Thu, 31 Mar 2016 10:44:12 +0200
Message-ID: <20160331084412.GF3430@twins.programming.kicks-ass.net>
References: <1456750705-7141-1-git-send-email-mhocko@kernel.org>
 <1456750705-7141-4-git-send-email-mhocko@kernel.org>
 <20160330132549.GU3408@twins.programming.kicks-ass.net>
 <20160331083336.GA27831@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160331083336.GA27831@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 31, 2016 at 10:33:36AM +0200, Michal Hocko wrote:
> > __mutex_lock_common() has it before the call to schedule and after the
> > 'trylock'.
> > 
> > The difference is that rwsem will now respond to the KILL and return
> > -EINTR even if the lock is available, whereas mutex will acquire it and
> > ignore the signal (for a little while longer).
> > 
> > Neither is wrong per se, but I feel all the locking primitives should
> > behave in a consistent manner in this regard.
> 
> Agreed! What about the following on top? I will repost the full patch
> if it looks OK.

Yep, that seems to have the right shape to it.

Thanks!
