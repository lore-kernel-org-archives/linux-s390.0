Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728880AbfJOOAR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 10:00:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FDsD4N130984
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 10:00:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnd4wwkw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Oct 2019 10:00:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 15 Oct 2019 15:00:13 +0100
Subject: Re: [RFC PATCH 2/4] vfio-ccw: Trace the FSM jumptable
References: <20191014180855.19400-1-farman@linux.ibm.com>
 <20191014180855.19400-3-farman@linux.ibm.com>
 <96431f2f-774c-0be2-54ef-ebcaa4ae7298@linux.ibm.com>
 <20191015155339.0d714c75.cohuck@redhat.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Tue, 15 Oct 2019 16:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <20191015155339.0d714c75.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4d9b1e87-18be-24f3-5f4d-796442b882a5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On 10/15/19 3:53 PM, Cornelia Huck wrote:
> On Tue, 15 Oct 2019 12:01:12 +0200
> Steffen Maier <maier@linux.ibm.com> wrote:
> 
>> On 10/14/19 8:08 PM, Eric Farman wrote:
>>> It would be nice if we could track the sequence of events within
>>> vfio-ccw, based on the state of the device/FSM and our calling
>>> sequence within it.  So let's add a simple trace here so we can
>>> watch the states change as things go, and allow it to be folded
>>> into the rest of the other cio traces.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> ---
>>>    drivers/s390/cio/vfio_ccw_private.h |  1 +
>>>    drivers/s390/cio/vfio_ccw_trace.c   |  1 +
>>>    drivers/s390/cio/vfio_ccw_trace.h   | 26 ++++++++++++++++++++++++++
>>>    3 files changed, 28 insertions(+)
> 
> (...)
> 
>>> diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
>>> index 2a2937a40124..24a8152acfdf 100644
>>> --- a/drivers/s390/cio/vfio_ccw_trace.h
>>> +++ b/drivers/s390/cio/vfio_ccw_trace.h
>>> @@ -17,6 +17,32 @@
>>>
>>>    #include <linux/tracepoint.h>
>>>
>>> +TRACE_EVENT(vfio_ccw_fsm_event,
>>> +	TP_PROTO(struct subchannel_id schid, int state, int event),
>>> +	TP_ARGS(schid, state, event),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__field(u8, cssid)
>>> +		__field(u8, ssid)
>>> +		__field(u16, schno)
>>> +		__field(int, state)
>>> +		__field(int, event)
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__entry->cssid = schid.cssid;
>>> +		__entry->ssid = schid.ssid;
>>> +		__entry->schno = schid.sch_no;
>>> +		__entry->state = state;
>>> +		__entry->event = event;
>>> +	),
>>> +
>>> +	TP_printk("schid=%x.%x.%04x state=%x event=%x",
>>
>> /sys/kernel/debug/tracing/events](0)# grep -R '%[^%]*x'
>>
>> Many existing TPs often seem to format hex output with a 0x prefix (either
>> explicit with 0x%x or implicit with %#x). Since some of your other TPs also
>> output decimal integer values, I wonder if a distinction would help
>> unexperienced TP readers.
> 
> I generally agree. However, we explicitly don't want to do that for
> schid formatting (as it should match the bus id). For event, it might
> become relevant should we want to introduce a high number of new events
> in the future (currently, there's a grand total of four events.)

Yeah, thanks for clarifying. I meant just state and event, not schid.

> 
>>
>>> +		__entry->cssid, __entry->ssid, __entry->schno,
>>> +		__entry->state,
>>> +		__entry->event)
>>> +);
>>> +
>>>    TRACE_EVENT(vfio_ccw_io_fctl,
>>>    	TP_PROTO(int fctl, struct subchannel_id schid, int errno, char *errstr),
>>>    	TP_ARGS(fctl, schid, errno, errstr),
>>>    
>>
>>
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
