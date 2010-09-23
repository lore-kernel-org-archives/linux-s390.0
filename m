Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Sep 2010 19:33:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 03/10] taskstats: Split fill_pid function
Message-ID: <20100923173314.GB26623@redhat.com>
References: <1285249681.1837.28.camel@holzheu-laptop> <1285250467.1837.80.camel@holzheu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285250467.1837.80.camel@holzheu-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Suresh Siddha <suresh.b.siddha@intel.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/23, Michael Holzheu wrote:
>
> Subject: [PATCH] taskstats: Split fill_pid function
>
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>
> Separate the finding of a task_struct by pid or tgid from filling the taskstats
> data. This makes the code more readable.

I think this is nice cleanup.

Oleg.
