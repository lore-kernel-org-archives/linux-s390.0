Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUMDY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 08:03:24 -0400
Subject: Re: [PATCH v3 5/8] vfio-ccw: Introduce a new CRW region
References: <20200417023001.65006-1-farman@linux.ibm.com>
 <20200417023001.65006-6-farman@linux.ibm.com>
 <20200421114114.672f35a4.cohuck@redhat.com>
 <e24dfccc-d2b7-9a47-3cef-323c01797ee1@linux.ibm.com>
 <20200421130829.49144c72.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <51ab4052-7958-2968-b91f-c7e06f1f1a2c@linux.ibm.com>
Date: Tue, 21 Apr 2020 08:03:05 -0400
MIME-Version: 1.0
In-Reply-To: <20200421130829.49144c72.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>



On 4/21/20 7:08 AM, Cornelia Huck wrote:
> On Tue, 21 Apr 2020 07:02:03 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 4/21/20 5:41 AM, Cornelia Huck wrote:
>>> On Fri, 17 Apr 2020 04:29:58 +0200
>>> Eric Farman <farman@linux.ibm.com> wrote:
> 
>>>> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
>>>> index 98832d95f395..3338551ef642 100644
>>>> --- a/Documentation/s390/vfio-ccw.rst
>>>> +++ b/Documentation/s390/vfio-ccw.rst
>>>> @@ -247,6 +247,22 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_SCHIB.
>>>>  Reading this region triggers a STORE SUBCHANNEL to be issued to the
>>>>  associated hardware.
>>>>  
>>>> +vfio-ccw crw region
>>>> +---------------------
>>>> +
>>>> +The vfio-ccw crw region is used to return Channel Report Word (CRW)
>>>> +data to userspace::
>>>> +
>>>> +  struct ccw_crw_region {
>>>> +         __u32 crw;
>>>> +  } __packed;
>>>> +
>>>> +This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_CRW.
>>>> +
>>>> +Currently, space is provided for a single CRW. Handling of chained
>>>> +CRWs (not implemented in vfio-ccw) can be accomplished by re-reading
>>>> +the region for additional CRW data.  
>>>
>>> What about the following instead:
>>>
>>> "Reading this region returns a CRW if one that is relevant for this
>>> subchannel (e.g. one reporting changes in channel path state) is
>>> pending, or all zeroes if not. If multiple CRWs are pending (including
>>> possibly chained CRWs), reading this region again will return the next
>>> one, until no more CRWs are pending and zeroes are returned. This is
>>> similar to how STORE CHANNEL REPORT WORD works."  
>>
>> Sounds good to me.
>>
>> Hrm...  Maybe coffee hasn't hit yet.  Should I wire STCRW into this, or
>> just rely on the notification from the host to trigger the read?
> 
> Userspace is supposed to use this to get crws to inject into the guest,
> no stcrw involved until the guest actually got the machine check for it.
> 

Ah, yes.  Thanks!
