From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper
 acquire/release barrier
Date: Wed, 15 Jun 2016 11:27:24 -0700
Message-ID: <20160615182724.GD2094@linux-80c1.suse>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
 <20160615165659.GC2094@linux-80c1.suse>
 <20160615171250.GO30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615171250.GO30921@twins.programming.kicks-ass.net>
Sender: linux-alpha-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hpe.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Jun 2016, Peter Zijlstra wrote:

>In any case, its fairly simple to cure, just add
>smp_acquire__after_ctrl_dep() at the end. If we bail because
>need_resched() we don't need the acquire I think.

I was just considering this for your smp_cond_acquire/smp_cond_load_acquire
rework, so yeah I guess an smp_acquire__after_ctrl_dep would be a nice
compromise. 

However, I was always under the impression that races with node->locked were
rather harmless (as indicated in the mentioned commit) -- which is why ->locked
are simple load/stores, with the exception of the unqueueing -- but yeah, that's
not even paired.

Thanks,
Davidlohr
