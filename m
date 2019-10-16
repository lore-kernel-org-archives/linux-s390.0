Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392300AbfJPKPr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 06:15:47 -0400
Date: Wed, 16 Oct 2019 12:15:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/4] vfio-ccw: Add a trace for asynchronous requests
Message-ID: <20191016121543.2b3f0a88.cohuck@redhat.com>
In-Reply-To: <20191016015822.72425-4-farman@linux.ibm.com>
References: <20191016015822.72425-1-farman@linux.ibm.com>
        <20191016015822.72425-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Wed, 16 Oct 2019 03:58:21 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Since the asynchronous requests are typically associated with
> error recovery, let's add a simple trace when one of those is
> issued to a device.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++++
>  drivers/s390/cio/vfio_ccw_trace.c |  1 +
>  drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)

(...)

> diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
> index 5005d57901b4..23b288eb53dc 100644
> --- a/drivers/s390/cio/vfio_ccw_trace.h
> +++ b/drivers/s390/cio/vfio_ccw_trace.h
> @@ -17,6 +17,36 @@
>  
>  #include <linux/tracepoint.h>
>  
> +TRACE_EVENT(vfio_ccw_fsm_async_request,
> +	TP_PROTO(struct subchannel_id schid,
> +		 int command,
> +		 int errno),
> +	TP_ARGS(schid, command, errno),
> +
> +	TP_STRUCT__entry(
> +		__field(u8, cssid)
> +		__field(u8, ssid)
> +		__field(u16, sch_no)
> +		__field(int, command)
> +		__field(int, errno)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cssid = schid.cssid;
> +		__entry->ssid = schid.ssid;
> +		__entry->sch_no = schid.sch_no;
> +		__entry->command = command;
> +		__entry->errno = errno;
> +	),
> +
> +	TP_printk("schid=%x.%x.%04x command=%d errno=%d",

I'd probably rather print the command as a hex value.

> +		  __entry->cssid,
> +		  __entry->ssid,
> +		  __entry->sch_no,
> +		  __entry->command,
> +		  __entry->errno)
> +);
> +
>  TRACE_EVENT(vfio_ccw_fsm_event,
>  	TP_PROTO(struct subchannel_id schid, int state, int event),
>  	TP_ARGS(schid, state, event),
