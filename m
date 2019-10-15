Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728880AbfJONmp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 09:42:45 -0400
Subject: Re: [RFC PATCH 2/4] vfio-ccw: Trace the FSM jumptable
References: <20191014180855.19400-1-farman@linux.ibm.com>
 <20191014180855.19400-3-farman@linux.ibm.com>
 <96431f2f-774c-0be2-54ef-ebcaa4ae7298@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <b9d59763-4052-2dbb-ffc7-32f6cec9c426@linux.ibm.com>
Date: Tue, 15 Oct 2019 09:42:37 -0400
MIME-Version: 1.0
In-Reply-To: <96431f2f-774c-0be2-54ef-ebcaa4ae7298@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 10/15/19 6:01 AM, Steffen Maier wrote:
> On 10/14/19 8:08 PM, Eric Farman wrote:
>> It would be nice if we could track the sequence of events within
>> vfio-ccw, based on the state of the device/FSM and our calling
>> sequence within it.  So let's add a simple trace here so we can
>> watch the states change as things go, and allow it to be folded
>> into the rest of the other cio traces.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_private.h |  1 +
>>   drivers/s390/cio/vfio_ccw_trace.c   |  1 +
>>   drivers/s390/cio/vfio_ccw_trace.h   | 26 ++++++++++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_private.h
>> b/drivers/s390/cio/vfio_ccw_private.h
>> index bbe9babf767b..9b9bb4982972 100644
>> --- a/drivers/s390/cio/vfio_ccw_private.h
>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>> @@ -135,6 +135,7 @@ extern fsm_func_t
>> *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
>>   static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
>>                        int event)
>>   {
>> +    trace_vfio_ccw_fsm_event(private->sch->schid, private->state,
>> event);
>>       vfio_ccw_jumptable[private->state][event](private, event);
>>   }
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_trace.c
>> b/drivers/s390/cio/vfio_ccw_trace.c
>> index d5cc943c6864..b37bc68e7f18 100644
>> --- a/drivers/s390/cio/vfio_ccw_trace.c
>> +++ b/drivers/s390/cio/vfio_ccw_trace.c
>> @@ -9,4 +9,5 @@
>>   #define CREATE_TRACE_POINTS
>>   #include "vfio_ccw_trace.h"
>>
>> +EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
>>   EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
>> diff --git a/drivers/s390/cio/vfio_ccw_trace.h
>> b/drivers/s390/cio/vfio_ccw_trace.h
>> index 2a2937a40124..24a8152acfdf 100644
>> --- a/drivers/s390/cio/vfio_ccw_trace.h
>> +++ b/drivers/s390/cio/vfio_ccw_trace.h
>> @@ -17,6 +17,32 @@
>>
>>   #include <linux/tracepoint.h>
>>
>> +TRACE_EVENT(vfio_ccw_fsm_event,
>> +    TP_PROTO(struct subchannel_id schid, int state, int event),
>> +    TP_ARGS(schid, state, event),
>> +
>> +    TP_STRUCT__entry(
>> +        __field(u8, cssid)
>> +        __field(u8, ssid)
>> +        __field(u16, schno)
>> +        __field(int, state)
>> +        __field(int, event)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __entry->cssid = schid.cssid;
>> +        __entry->ssid = schid.ssid;
>> +        __entry->schno = schid.sch_no;
>> +        __entry->state = state;
>> +        __entry->event = event;
>> +    ),
>> +
>> +    TP_printk("schid=%x.%x.%04x state=%x event=%x",
> 
> /sys/kernel/debug/tracing/events](0)# grep -R '%[^%]*x'
> 
> Many existing TPs often seem to format hex output with a 0x prefix
> (either explicit with 0x%x or implicit with %#x). Since some of your
> other TPs also output decimal integer values, I wonder if a distinction
> would help unexperienced TP readers.

Fair enough.  Since they're just enumerated values, they are probably
better as %d; I don't have a good reason for picking %x (with or without
a preceding 0x).

> 
>> +        __entry->cssid, __entry->ssid, __entry->schno,
>> +        __entry->state,
>> +        __entry->event)
>> +);
>> +
>>   TRACE_EVENT(vfio_ccw_io_fctl,
>>       TP_PROTO(int fctl, struct subchannel_id schid, int errno, char
>> *errstr),
>>       TP_ARGS(fctl, schid, errno, errstr),
>>
> 
> 
