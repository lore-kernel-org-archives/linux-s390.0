From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH-tip v2 2/6] locking/rwsem: Stop active read lock ASAP
Date: Wed, 15 Jun 2016 19:14:36 -0700
Message-ID: <20160616021436.GA7765@linux-80c1.suse>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-3-git-send-email-Waiman.Long@hpe.com>
 <20160615172242.GQ30921@twins.programming.kicks-ass.net>
 <5761A9DE.6040702@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5761A9DE.6040702@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <waiman.long@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Jun 2016, Waiman Long wrote:

>I think there will be a little bit of performance impact for a 
>workload that produce just the right amount of rwsem contentions. 

I'm not saying the change doesn't make sense, but this is the sort of
thing that will show nice numbers in one workload and go bite you in
another.

Thanks,
Davidlohr
