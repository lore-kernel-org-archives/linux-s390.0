Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727770AbgCZSvs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 14:51:48 -0400
Subject: Re: [RFC PATCH v2 7/9] vfio-ccw: Wire up the CRW irq and CRW region
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-8-farman@linux.ibm.com>
 <20200214143400.175c9e5e.cohuck@redhat.com>
 <75bb9119-8692-c18e-1e7b-c7598d8ef25a@linux.ibm.com>
 <20200324173431.6ad09436.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <49d9d798-a90b-3384-ea83-9c8e7e201203@linux.ibm.com>
Date: Thu, 26 Mar 2020 14:51:43 -0400
MIME-Version: 1.0
In-Reply-To: <20200324173431.6ad09436.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 3/24/20 12:34 PM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 11:24:39 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 2/14/20 8:34 AM, Cornelia Huck wrote:
>>> On Thu,  6 Feb 2020 22:38:23 +0100
>>> Eric Farman <farman@linux.ibm.com> wrote:
> 
>>> (...)  
>>>> +static void vfio_ccw_alloc_crw(struct vfio_ccw_private *private,
>>>> +			       struct chp_link *link,
>>>> +			       unsigned int erc)
>>>> +{
>>>> +	struct vfio_ccw_crw *vc_crw;
>>>> +	struct crw *crw;
>>>> +
>>>> +	/*
>>>> +	 * If unable to allocate a CRW, just drop the event and
>>>> +	 * carry on.  The guest will either see a later one or
>>>> +	 * learn when it issues its own store subchannel.
>>>> +	 */
>>>> +	vc_crw = kzalloc(sizeof(*vc_crw), GFP_ATOMIC);
>>>> +	if (!vc_crw)
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * Build in the first CRW space, but don't chain anything
>>>> +	 * into the second one even though the space exists.
>>>> +	 */
>>>> +	crw = &vc_crw->crw[0];
>>>> +
>>>> +	/*
>>>> +	 * Presume every CRW we handle is reported by a channel-path.
>>>> +	 * Maybe not future-proof, but good for what we're doing now.  
>>>
>>> You could pass in a source indication, maybe? Presumably, at least one
>>> of the callers further up the chain knows...  
>>
>> The "chain" is the vfio_ccw_chp_event() function called off the
>> .chp_event callback, and then to this point.  So I don't think there's
>> much we can get back from our callchain, other than the CHP_xxxLINE
>> event that got us here.
> 
> We might want to pass in CRW_RSC_CPATH, that would make it a bit more
> flexible. We can easily rearrange code internally later, though.
> 

This is true...  I'll rearrange it so the routine takes the rsid as
input instead of the link, as well as the rsc, so we don't have to do
that fiddling down the road.
