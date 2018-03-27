From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 4/4] vfio: ccw: add traceponits for interesting error
 paths
Date: Tue, 27 Mar 2018 12:07:23 +0200
Message-ID: <20180327120723.192f7577.cohuck@redhat.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-5-bjsdjshi@linux.vnet.ibm.com>
        <20180326155902.12bed785.cohuck@redhat.com>
        <20180327075114.GK12194@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180327075114.GK12194@bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Mar 2018 15:51:14 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-03-26 15:59:02 +0200]:
> 
> [...]
> 
> > > @@ -131,6 +138,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  
> > >  		io_region->ret_code = cp_prefetch(&private->cp);
> > >  		if (io_region->ret_code) {
> > > +			trace_vfio_ccw_cp_prefetch_failed(get_schid(private),
> > > +							  io_region->ret_code);
> > >  			cp_free(&private->cp);
> > >  			goto err_out;
> > >  		}
> > > @@ -138,6 +147,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  		/* Start channel program and wait for I/O interrupt. */
> > >  		io_region->ret_code = fsm_io_helper(private);
> > >  		if (io_region->ret_code) {
> > > +			trace_vfio_ccw_ssch_failed(get_schid(private),
> > > +						   io_region->ret_code);
> > >  			cp_free(&private->cp);
> > >  			goto err_out;
> > >  		}
> > > @@ -145,10 +156,12 @@ static void fsm_io_request(struct vfio_ccw_private *private,
> > >  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
> > >  		/* XXX: Handle halt. */
> > >  		io_region->ret_code = -EOPNOTSUPP;
> > > +		trace_vfio_ccw_halt(get_schid(private));
> > >  		goto err_out;
> > >  	} else if (scsw->cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
> > >  		/* XXX: Handle clear. */
> > >  		io_region->ret_code = -EOPNOTSUPP;
> > > +		trace_vfio_ccw_clear(get_schid(private));
> > >  		goto err_out;  
> > 
> > Hmmm.... perhaps better to just trace the function (start/halt/clear)
> > in any case?
> >   
> I agree trace the function in any case is good. @Halil, opinion?
> 
> But the traces for cp_prefetch() and fsm_io_helper() should also be
> kept, since they are helpful to debug problem. So I tend to trace the
> following in any case:
> - cp_prefetch()
> - fsm_io_helper()
> - start
> - halt
> - clear

OK, I was unclear :) I'd argue to keep the others, just replace the
halt/clear tracing with tracing the function.

> 
> > >  	}
> > >  
> > > diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
> > > new file mode 100644
> > > index 000000000000..edd3321cd919
> > > --- /dev/null
> > > +++ b/drivers/s390/cio/vfio_ccw_trace.h
> > > @@ -0,0 +1,86 @@
> > > +/* SPDX-License-Identifier: GPL-2.0
> > > + * Tracepoints for vfio_ccw driver
> > > + *
> > > + * Copyright IBM Corp. 2018
> > > + *
> > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > + *            Halil Pasic <pasic@linux.vnet.ibm.com>
> > > + */
> > > +
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM vfio_ccw
> > > +
> > > +#if !defined(_VFIO_CCW_TRACE_) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _VFIO_CCW_TRACE_
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +TRACE_EVENT(vfio_ccw_cp_prefetch_failed,
> > > +	TP_PROTO(struct subchannel_id schid, int errno),
> > > +	TP_ARGS(schid, errno),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field_struct(struct subchannel_id, schid)
> > > +		__field(int, errno)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__entry->schid = schid;
> > > +		__entry->errno = errno;
> > > +	),
> > > +
> > > +	TP_printk("(schid 0.%x.%04X) translation failed (errno: %d)",
> > > +		__entry->schid.ssid, __entry->schid.sch_no, __entry->errno)
> > > +);
> > > +
> > > +TRACE_EVENT(vfio_ccw_ssch_failed,
> > > +	TP_PROTO(struct subchannel_id schid, int errno),
> > > +	TP_ARGS(schid, errno),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field_struct(struct subchannel_id, schid)
> > > +		__field(int, errno)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__entry->schid = schid;
> > > +		__entry->errno = errno;
> > > +	),
> > > +
> > > +	TP_printk("(schid 0.%x.%04X) ssch failed (errno: %d)",
> > > +		__entry->schid.ssid, __entry->schid.sch_no, __entry->errno)
> > > +);
> > > +
> > > +DECLARE_EVENT_CLASS(vfio_ccw_notsupp,
> > > +	TP_PROTO(struct subchannel_id schid),
> > > +	TP_ARGS(schid),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field_struct(struct subchannel_id, schid)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__entry->schid = schid;
> > > +	),
> > > +
> > > +	TP_printk("(schid 0.%x.%04X) request not supported",
> > > +		__entry->schid.ssid, __entry->schid.sch_no)
> > > +);  
> > 
> > Especially as I don't plan to leave this unsupported for too long :)
> > 
> > Just tracing the function is useful now and will stay useful in the
> > future.  
> If we agree with ideas given above, we could:
> 1. DECLARE_EVENT_CLASS as vfio_ccw_schid_errno
> 2. DEFINE_EVENT:
>    vfio_ccw_fam_io_helper
>    vfio_ccw_cp_prefetch
>    vfio_ccw_io_start
>    vfio_ccw_io_clear
>    vfio_ccw_io_halt

Use a vfio_ccw_io_fctl tracepoint instead?

> 3. add trace points in coresponding places
> 
> > 
> > Another idea: Trace the fsm state transitions. Probably something for
> > an additional patch.  
> Considering Pierre is refactoring the fsm, we can add trace points in
> that series (or as following on patch).

Yes, while poking around I also wondered whether we should tweak the
fsm in places. So adding tracepoints there looks like a good idea.

> 
> > 
> >   
> > > +
> > > +DEFINE_EVENT(vfio_ccw_notsupp, vfio_ccw_clear,
> > > +        TP_PROTO(struct subchannel_id schid), TP_ARGS(schid));
> > > +
> > > +DEFINE_EVENT(vfio_ccw_notsupp, vfio_ccw_halt,
> > > +	TP_PROTO(struct subchannel_id schid), TP_ARGS(schid));
> > > +
> > > +#endif /* _VFIO_CCW_TRACE_ */
> > > +
> > > +/* This part must be outside protection */
> > > +
> > > +#undef TRACE_INCLUDE_PATH
> > > +#define TRACE_INCLUDE_PATH .
> > > +#undef TRACE_INCLUDE_FILE
> > > +#define TRACE_INCLUDE_FILE vfio_ccw_trace
> > > +
> > > +#include <trace/define_trace.h>  
> >   
> 
