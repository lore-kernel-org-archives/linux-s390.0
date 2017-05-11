From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 12/13] vfio/ccw: update sense data if a unit check is
 pending
Date: Thu, 11 May 2017 15:49:15 -0600
Message-ID: <20170511154915.75d7f4b1@w520.home>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
        <20170505020352.8984-13-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170505020352.8984-13-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 May 2017 04:03:51 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Concurrent-sense data is currently not delivered. This patch stores
> the concurrent-sense data to the subchannel if a unit check is pending
> and the concurrent-sense bit is enabled. Then a TSCH can retreive the
> right IRB data back to the guest.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---


Acked-by: Alex Williamson <alex.williamson@redhat.com>


>  hw/vfio/ccw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 3c8b518..73f326f 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -94,6 +94,7 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
>      CcwDevice *ccw_dev = CCW_DEVICE(cdev);
>      SubchDev *sch = ccw_dev->sch;
>      SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
>      IRB irb;
>      int size;
>  
> @@ -143,6 +144,12 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
>      /* Update control block via irb. */
>      copy_scsw_to_guest(s, &irb.scsw);
>  
> +    /* If a uint check is pending, copy sense data. */
> +    if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
> +        (p->chars & PMCW_CHARS_MASK_CSENSE)) {
> +        memcpy(sch->sense_data, irb.ecw, sizeof(irb.ecw));
> +    }
> +
>  read_err:
>      css_inject_io_interrupt(sch);
>  }
