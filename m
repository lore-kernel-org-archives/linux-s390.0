Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 16 Jul 2016 12:35:26 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/cio/chp : Remove deprecated
 create_singlethread_workqueue
In-Reply-To: <20160716084834.GA7728@Karyakshetra>
References: <20160716084834.GA7728@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1607161234360.1961@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 16 Jul 2016, Bhaktipriya Shridhar wrote:
> The workqueue "chp_wq" is involved in performing pending
> configure tasks for channel paths.
> 
> It has a single work item(&cfg_work) and hence doesn't require
> ordering. Also, it is not being used on a memory reclaim path.
> Hence, the singlethreaded workqueue has been replaced with the use of
> system_wq.
> 
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Applied, thanks!

Sebastian
