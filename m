Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727564AbgCZCJp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 22:09:45 -0400
Subject: Re: [RFC PATCH v2 2/9] vfio-ccw: Register a chp_event callback for
 vfio-ccw
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-3-farman@linux.ibm.com>
 <20200214131147.0a98dd7d.cohuck@redhat.com>
 <459a60d1-699d-2f16-bb59-23f11b817b81@linux.ibm.com>
 <20200324165854.3d862d5b.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <302a0650-99b0-22ef-b95d-cecdeb0f9f04@linux.ibm.com>
Date: Wed, 25 Mar 2020 22:09:40 -0400
MIME-Version: 1.0
In-Reply-To: <20200324165854.3d862d5b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 3/24/20 11:58 AM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 11:35:21 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 2/14/20 7:11 AM, Cornelia Huck wrote:
>>> On Thu,  6 Feb 2020 22:38:18 +0100
>>> Eric Farman <farman@linux.ibm.com> wrote:
> 
>>> (...)  
>>>> @@ -257,6 +258,48 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>>>>  	return rc;
>>>>  }
>>>>  
>>>> +static int vfio_ccw_chp_event(struct subchannel *sch,
>>>> +			      struct chp_link *link, int event)
>>>> +{
>>>> +	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>>>> +	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
>>>> +	int retry = 255;
>>>> +
>>>> +	if (!private || !mask)
>>>> +		return 0;
>>>> +
>>>> +	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
>>>> +			   mdev_uuid(private->mdev), sch->schid.cssid,
>>>> +			   sch->schid.ssid, sch->schid.sch_no,
>>>> +			   mask, event);
>>>> +
>>>> +	if (cio_update_schib(sch))
>>>> +		return -ENODEV;
>>>> +
>>>> +	switch (event) {
>>>> +	case CHP_VARY_OFF:
>>>> +		/* Path logically turned off */
>>>> +		sch->opm &= ~mask;
>>>> +		sch->lpm &= ~mask;
>>>> +		break;
>>>> +	case CHP_OFFLINE:
>>>> +		/* Path is gone */
>>>> +		cio_cancel_halt_clear(sch, &retry);  
>>>
>>> Any reason you do this only for CHP_OFFLINE and not for CHP_VARY_OFF?  
>>
>> Hrm...  No reason that I can think of.  I can fix this.
>>
>>>   
>>>> +		break;
>>>> +	case CHP_VARY_ON:
>>>> +		/* Path logically turned on */
>>>> +		sch->opm |= mask;
>>>> +		sch->lpm |= mask;
>>>> +		break;
>>>> +	case CHP_ONLINE:
>>>> +		/* Path became available */
>>>> +		sch->lpm |= mask & sch->opm;  
>>>
>>> If I'm not mistaken, this patch introduces the first usage of sch->opm
>>> in the vfio-ccw code.   
>>
>> Correct.
>>
>>> Are we missing something?  
>>
>> Maybe?  :)
>>
>>> Or am I missing
>>> something? :)
>>>   
>>
>> Since it's only used in this code, for acting as a step between
>> vary/config off/on, maybe this only needs to be dealing with the lpm
>> field itself?
> 
> Ok, I went over this again and also looked at what the standard I/O
> subchannel driver does, and I think this is fine, as the lpm basically
> factors in the opm already. (Will need to keep this in mind for the
> following patches.)

Just to make sure I don't misunderstand, when you say "I think this is
fine" ... Do you mean keeping the opm field within vfio-ccw, as this
patch does?  Or removing it, and only adjusting the lpm within vfio-ccw,
as I suggested in my response just above?

(It's long in the day, and should not look at vfio-ccw at this hour.)

> 
>>
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static struct css_device_id vfio_ccw_sch_ids[] = {
>>>>  	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
>>>>  	{ /* end of list */ },  
>>> (...)
>>>   
>>
> 
