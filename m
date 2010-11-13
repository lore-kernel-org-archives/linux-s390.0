Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 1/7] taskstats: Add new taskstats command
 TASKSTATS_CMD_ATTR_PIDS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20101111170813.527389224@linux.vnet.ibm.com>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170813.527389224@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Sat, 13 Nov 2010 20:39:44 +0100
Message-ID: <1289677184.2109.171.camel@laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2010-11-11 at 18:03 +0100, Michael Holzheu wrote:
> +       if (cmd_pids->cnt > 1000) // XXX socket buffer size check

What's the implication of this limit? Does that mean that if there's
more than 1000 tasks on the system the whole interface falls flat on its
face or does that mean we get at most 1000 tasks worth of information
per syscall?
