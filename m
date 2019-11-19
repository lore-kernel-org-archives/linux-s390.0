Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727509AbfKSPpV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 10:45:21 -0500
Subject: Re: [RFC PATCH v1 02/10] vfio-ccw: Register a chp_event callback for
 vfio-ccw
References: <20191115025620.19593-1-farman@linux.ibm.com>
 <20191115025620.19593-3-farman@linux.ibm.com>
 <20191119134809.75ba276b.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <077147ec-39c3-7d00-5ee1-fc290ab7fd1a@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:45:17 -0500
MIME-Version: 1.0
In-Reply-To: <20191119134809.75ba276b.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>



On 11/19/19 7:48 AM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 03:56:12 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> Register the chp_event callback to receive channel path related
>> events for the subchannels managed by vfio-ccw.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v0->v1: [EF]
>>      - Add s390dbf trace
>>
>>  drivers/s390/cio/vfio_ccw_drv.c | 44 +++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 91989269faf1..05da1facee60 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -19,6 +19,7 @@
>>  
>>  #include <asm/isc.h>
>>  
>> +#include "chp.h"
>>  #include "ioasm.h"
>>  #include "css.h"
>>  #include "vfio_ccw_private.h"
>> @@ -257,6 +258,48 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>>  	return rc;
>>  }
>>  
>> +static int vfio_ccw_chp_event(struct subchannel *sch,
>> +			      struct chp_link *link, int event)
>> +{
>> +	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>> +	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
>> +	int retry = 255;
>> +
>> +	if (!private || !mask)
>> +		return 0;
>> +
>> +	if (cio_update_schib(sch))
>> +		return -ENODEV;
> 
> It seems this return code is only checked by the common I/O layer for
> the _OFFLINE case; still, it's probably not a bad idea, even though it
> is different from what the vanilla I/O subchannel driver does.

cio_update_schib() itself can only return -ENODEV so it seemed sane.

> 
>> +
>> +	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
>> +			   mdev_uuid(private->mdev), sch->schid.cssid,
>> +			   sch->schid.ssid, sch->schid.sch_no,
>> +			   mask, event);
> 
> If you log only here, you're missing the case above.

Ah, yes.  I'll move that up.

> 
>> +
>> +	switch (event) {
>> +	case CHP_VARY_OFF:
>> +		/* Path logically turned off */
>> +		sch->opm &= ~mask;
>> +		sch->lpm &= ~mask;
>> +		break;
>> +	case CHP_OFFLINE:
>> +		/* Path is gone */
>> +		cio_cancel_halt_clear(sch, &retry);
>> +		break;
>> +	case CHP_VARY_ON:
>> +		/* Path logically turned on */
>> +		sch->opm |= mask;
>> +		sch->lpm |= mask;
>> +		break;
>> +	case CHP_ONLINE:
>> +		/* Path became available */
>> +		sch->lpm |= mask & sch->opm;
>> +		break;
>> +	}
> 
> Looks sane as the first round.
> 
>> +
>> +	return 0;
>> +}
>> +
>>  static struct css_device_id vfio_ccw_sch_ids[] = {
>>  	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
>>  	{ /* end of list */ },
>> @@ -274,6 +317,7 @@ static struct css_driver vfio_ccw_sch_driver = {
>>  	.remove = vfio_ccw_sch_remove,
>>  	.shutdown = vfio_ccw_sch_shutdown,
>>  	.sch_event = vfio_ccw_sch_event,
>> +	.chp_event = vfio_ccw_chp_event,
>>  };
>>  
>>  static int __init vfio_ccw_debug_init(void)
> 
