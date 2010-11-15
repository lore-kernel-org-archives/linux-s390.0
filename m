Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 4/7] taskstats: Add per task steal time
 accounting
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20101115184206.4463fd05@mschwide.boeblingen.de.ibm.com>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170815.024542355@linux.vnet.ibm.com>
	 <1289677083.2109.167.camel@laptop>
	 <20101115155057.15f3be35@mschwide.boeblingen.de.ibm.com>
	 <1289833883.2109.494.camel@laptop>
	 <20101115184206.4463fd05@mschwide.boeblingen.de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 Nov 2010 18:50:41 +0100
Message-ID: <1289843441.2109.520.camel@laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "jeremy.fitzhardinge" <jeremy.fitzhardinge@citrix.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2010-11-15 at 18:42 +0100, Martin Schwidefsky wrote:
> The steal time of a task tells us how much more progress a task could have
> done if the hypervisor would not steal cpu. Now you could argue that the
> steal time for a cpu is good enough for that purpose but steal time is not
> necessarily uniform over all tasks. And we already do calculate this number,
> we just do not store it right now. 

If you make the scheduler take steal time into account like Jeremy
proposed then you schedule on serviced time and the steal time gain is
proportional to the existing service distribution.

Still, then you know, then what are you going to do about it? Are you
going to avoid the hypervisor from scheduling when that one task is
running?

What good is knowing something you cannot do anything about.
