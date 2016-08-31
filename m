Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 31 Aug 2016 10:31:10 -0400
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] s390: Remove deprecated create_singlethread_workqueue
Message-ID: <20160831143110.GT12660@htj.duckdns.org>
References: <20160830202720.GA31494@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160830202720.GA31494@Karyakshetra>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 31, 2016 at 01:57:20AM +0530, Bhaktipriya Shridhar wrote:
> The workqueue "appldata_wq" has been replaced with an ordered dedicated
> workqueue.
> 
> WQ_MEM_RECLAIM has not been set since the workqueue is not being used on
> a memory reclaim path.
> 
> The adapter->work_queue queues multiple work items viz
> &adapter->scan_work, &port->rport_work, &adapter->ns_up_work,
> &adapter->stat_work, adapter->work_queue, &adapter->events.work,
> &port->gid_pn_work, &port->test_link_work. Hence, an ordered
> dedicated workqueue has been used.
> 
> WQ_MEM_RECLAIM has been set to ensure forward progress under memory
> pressure.

I have no idea what these drivers do.  s390 folks, can you please shed
some light on whether these workqueues can be depended on during
memory reclaim?

Thanks.

-- 
tejun
