From: Tejun Heo <tj@kernel.org>
Date: Fri, 18 May 2018 15:12:20 +0000
Subject: Re: [PATCH 15/25] workqueue,zfcp: set description for port work items with their WWPN as context
Message-Id: <20180518151220.GF1718769@devbig577.frc2.facebook.com>
In-Reply-To: <20180517171507.18237-16-maier@linux.ibm.com>
References: <20180517171507.18237-16-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 17, 2018 at 07:14:57PM +0200, Steffen Maier wrote:
> As a prerequisite, complement commit 3d1cb2059d93 ("workqueue: include
> workqueue info when printing debug dump of a worker task") to be usable
> with kernel modules by exporting the symbol set_worker_desc().
> Current built-in user was introduced with commit ef3b101925f2 ("writeback:
> set worker desc to identify writeback workers in task dumps").
> 
> Can help distinguishing work items which do not have adapter scope.
> Description is printed out with task dump for debugging on
> WARN, BUG, panic, or magic-sysrq [show-task-states(t)].

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
