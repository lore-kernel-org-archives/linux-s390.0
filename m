Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbfJPLgR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Oct 2019 07:36:17 -0400
Subject: Re: [PATCH v2 3/4] vfio-ccw: Add a trace for asynchronous requests
References: <20191016015822.72425-1-farman@linux.ibm.com>
 <20191016015822.72425-4-farman@linux.ibm.com>
 <20191016121543.2b3f0a88.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <6c559ea3-4abd-d83b-4a20-d022a188545e@linux.ibm.com>
Date: Wed, 16 Oct 2019 07:36:09 -0400
MIME-Version: 1.0
In-Reply-To: <20191016121543.2b3f0a88.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 10/16/19 6:15 AM, Cornelia Huck wrote:
> On Wed, 16 Oct 2019 03:58:21 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> Since the asynchronous requests are typically associated with
>> error recovery, let's add a simple trace when one of those is
>> issued to a device.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>  drivers/s390/cio/vfio_ccw_fsm.c   |  4 ++++
>>  drivers/s390/cio/vfio_ccw_trace.c |  1 +
>>  drivers/s390/cio/vfio_ccw_trace.h | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 35 insertions(+)
> 
> (...)
> 
>> diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
>> index 5005d57901b4..23b288eb53dc 100644
>> --- a/drivers/s390/cio/vfio_ccw_trace.h
>> +++ b/drivers/s390/cio/vfio_ccw_trace.h
>> @@ -17,6 +17,36 @@
>>  
>>  #include <linux/tracepoint.h>
>>  
>> +TRACE_EVENT(vfio_ccw_fsm_async_request,
>> +	TP_PROTO(struct subchannel_id schid,
>> +		 int command,
>> +		 int errno),
>> +	TP_ARGS(schid, command, errno),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u8, cssid)
>> +		__field(u8, ssid)
>> +		__field(u16, sch_no)
>> +		__field(int, command)
>> +		__field(int, errno)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->cssid = schid.cssid;
>> +		__entry->ssid = schid.ssid;
>> +		__entry->sch_no = schid.sch_no;
>> +		__entry->command = command;
>> +		__entry->errno = errno;
>> +	),
>> +
>> +	TP_printk("schid=%x.%x.%04x command=%d errno=%d",
> 
> I'd probably rather print the command as a hex value.

I'm fine with that too.  Want me to send an update?

> 
>> +		  __entry->cssid,
>> +		  __entry->ssid,
>> +		  __entry->sch_no,
>> +		  __entry->command,
>> +		  __entry->errno)
>> +);
>> +
>>  TRACE_EVENT(vfio_ccw_fsm_event,
>>  	TP_PROTO(struct subchannel_id schid, int state, int event),
>>  	TP_ARGS(schid, state, event),
> 
