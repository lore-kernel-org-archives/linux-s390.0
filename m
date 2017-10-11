From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 00/11] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Date: Wed, 11 Oct 2017 20:48:40 +0200
Message-ID: <20171011184840.3uomgj3hxxzernfd@hirez.programming.kicks-ass.net>
References: <1507744922-15196-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507744922-15196-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Dave Chinner <david@fromorbit.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 11, 2017 at 02:01:51PM -0400, Waiman Long wrote:
>   # of Patches		   Reader 		  Writer
>     Applied		Locking Rate		Locking Rate
>   ------------		------------		------------
> 	0	5,155/    5,155/    5,155    5,154/248,852/346,281
> 	7	5,696/    5,697/    5,698  113,500/215,826/320,872
> 	8	4,827/    5,047/    5,215    4,826/176,797/284,069
> 	9     211,276/  509,712/1,134,007    4,894/221,839/246,818
>        11     884,513/1,043,989/1,252,533    9,604/ 11,105/ 25,225
> 
> It can be seen that rwsem changes from writer-preferring to
> reader-preferring.

A bit radically so, you almost starve the writers there.
