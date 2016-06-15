From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH-tip v2 2/6] locking/rwsem: Stop active read lock ASAP
Date: Wed, 15 Jun 2016 19:22:42 +0200
Message-ID: <20160615172242.GQ30921@twins.programming.kicks-ass.net>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-3-git-send-email-Waiman.Long@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465944489-43440-3-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 14, 2016 at 06:48:05PM -0400, Waiman Long wrote:
> Currently, when down_read() fails, the active read locking isn't undone
> until the rwsem_down_read_failed() function grabs the wait_lock. If the
> wait_lock is contended, it may takes a while to get the lock. During
> that period, writer lock stealing will be disabled because of the
> active read lock.
> 
> This patch will release the active read lock ASAP so that writer lock
> stealing can happen sooner. The only downside is when the reader is
> the first one in the wait queue as it has to issue another atomic
> operation to update the count.
> 
> On a 4-socket Haswell machine running on a 4.7-rc1 tip-based kernel,
> the fio test with multithreaded randrw and randwrite tests on the
> same file on a XFS partition on top of a NVDIMM with DAX were run,
> the aggregated bandwidths before and after the patch were as follows:
> 
>   Test      BW before patch     BW after patch  % change
>   ----      ---------------     --------------  --------
>   randrw        1210 MB/s          1352 MB/s      +12%
>   randwrite     1622 MB/s          1710 MB/s      +5.4%
> 
> The write-only microbench also showed improvement because some read
> locking was done by the XFS code.

How does a reader only micro-bench react? I'm thinking the extra atomic
might hurt a bit.
