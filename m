Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 3 Sep 2016 12:53:34 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Remove deprecated create_singlethread_workqueue
References: <20160830202720.GA31494@Karyakshetra>
 <20160831143110.GT12660@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160831143110.GT12660@htj.duckdns.org>
Message-Id: <20160903105334.GA3917@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 31, 2016 at 10:31:10AM -0400, Tejun Heo wrote:
> On Wed, Aug 31, 2016 at 01:57:20AM +0530, Bhaktipriya Shridhar wrote:
> > The workqueue "appldata_wq" has been replaced with an ordered dedicated
> > workqueue.
> > 
> > WQ_MEM_RECLAIM has not been set since the workqueue is not being used on
> > a memory reclaim path.
> > 
> > The adapter->work_queue queues multiple work items viz
> > &adapter->scan_work, &port->rport_work, &adapter->ns_up_work,
> > &adapter->stat_work, adapter->work_queue, &adapter->events.work,
> > &port->gid_pn_work, &port->test_link_work. Hence, an ordered
> > dedicated workqueue has been used.
> > 
> > WQ_MEM_RECLAIM has been set to ensure forward progress under memory
> > pressure.
> 
> I have no idea what these drivers do.  s390 folks, can you please shed
> some light on whether these workqueues can be depended on during
> memory reclaim?

The appldata device driver is only needed to gather statistical data and
therefore my wait when memory reclaim is in progress.

The zfcp device drivers is a SCSI-over-FC device driver and hence we depend
on it during memory reclaim. So setting WQ_MEM_RECLAIM is the right thing
to do here.

The patch looks ok, and I applied it.

Thanks!
