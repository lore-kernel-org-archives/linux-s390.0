Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 1/7] taskstats: Add new taskstats command
 TASKSTATS_CMD_ATTR_PIDS
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <1289677184.2109.171.camel@laptop>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170813.527389224@linux.vnet.ibm.com>
	 <1289677184.2109.171.camel@laptop>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 15 Nov 2010 15:50:26 +0100
Message-ID: <1289832626.1916.16.camel@holzheu-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Peter,

On Sat, 2010-11-13 at 20:39 +0100, Peter Zijlstra wrote:
> On Thu, 2010-11-11 at 18:03 +0100, Michael Holzheu wrote:
> > +       if (cmd_pids->cnt > 1000) // XXX socket buffer size check
> 
> What's the implication of this limit? Does that mean that if there's
> more than 1000 tasks on the system the whole interface falls flat on its
> face or does that mean we get at most 1000 tasks worth of information
> per syscall?

In the final code I wanted to replace the check for 1000 by a check for
the available socket buffer. Currently I am not sure, if this is
possible.

"cmd_pids->cnt" is the number of taskstats that userspace requests from
the kernel. When the request is processed, the kernel sends cnt
taskstats structures to the netlink socket. This is buffered in the
netlink socket until userspace receives it. Because the socket buffer is
limited in size there is an upper limit for the number of taskstats
structures that can be received with one TASKSTATS_CMD_ATTR_PIDS
command. If the user wants to receive more than that limit, he has to
send multiple TASKSTATS_CMD_ATTR_PIDS commands.

Michael
