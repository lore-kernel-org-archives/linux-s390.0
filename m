Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jun 2016 11:00:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/oprofile: Remove deprecated create_workqueue
References: <20160607215912.GA19722@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160607215912.GA19722@Karyakshetra>
Message-Id: <20160609090056.GC3250@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>, William Cohen <wcohen@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jun 08, 2016 at 03:29:12AM +0530, Bhaktipriya Shridhar wrote:
> A dedicated workqueue has been used since the workqueue hws_wq with
> workitem &cb->worker, is involved in hardware based sampling
> on System z processors.
> 
> Since, these are long-running work items and aren't involved in memory
> reclaim in any way, system_long_wq has been used.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> ---
>  arch/s390/oprofile/hwsampler.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)

Besides that your patch doesn't compile... ;)

Removing the flush_workqueue is probably wrong, since the oprofile module
can now be unloaded while there could still be a reference to a worker
structure owned by the oprofile module.

However I'm wondering if we shouldn't simply remove at least the s390
specific hwswampler code from the oprofile module. This would still leave
the common code timer based sampling mode for oprofile working on s390.

It looks like the oprofile user space utility nowadays (since 2012) uses
the kernel perf interface instead of the oprofile interface anyway, if
present. So the oprofile module itself doesn't seem to have too many users
left.

Any opinions?

> 
> -		if (hws_wq)
> -			flush_workqueue(hws_wq);
> -
>  		mutex_lock(&hws_sem);
> 
>  		if (hws_state == HWS_STOPPED) {
> @@ -1059,10 +1048,6 @@ int hwsampler_shutdown(void)
>  			hws_alert = 0;
>  			deallocate_sdbt();
>  		}
> -		if (hws_wq) {
> -			destroy_workqueue(hws_wq);
> -			hws_wq = NULL;
> -		}
> 
>  		unregister_external_irq(EXT_IRQ_MEASURE_ALERT, hws_ext_handler);
>  		hws_state = HWS_INIT;
> --
> 2.1.4
> 
