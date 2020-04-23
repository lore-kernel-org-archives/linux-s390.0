Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDWUZo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 16:25:44 -0400
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
References: <20200417182939.11460-1-jrossi@linux.ibm.com>
 <20200417182939.11460-2-jrossi@linux.ibm.com>
 <20200423155620.493cb7cb.pasic@linux.ibm.com>
 <20200423171103.497dcd02.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <b6dc3d32-3e84-4ce1-59a2-d5de99716027@linux.ibm.com>
Date: Thu, 23 Apr 2020 16:25:39 -0400
MIME-Version: 1.0
In-Reply-To: <20200423171103.497dcd02.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 4/23/20 11:11 AM, Cornelia Huck wrote:
> On Thu, 23 Apr 2020 15:56:20 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Fri, 17 Apr 2020 14:29:39 -0400
>> Jared Rossi <jrossi@linux.ibm.com> wrote:
>>
>>> Remove the explicit prefetch check when using vfio-ccw devices.
>>> This check is not needed as all Linux channel programs are intended
>>> to use prefetch and will be executed in the same way regardless.  
>>
>> Hm. This is a guest thing or? So you basically say, it is OK to do
>> this, because you know that the guest is gonna be Linux and that it
>> the channel program is intended to use prefetch -- but the ORB supplied
>> by the guest that designates the channel program happens to state the
>> opposite.
>>
>> Or am I missing something?
> 
> I see this as a kind of architecture compliance/ease of administration
> tradeoff, as we none of the guests we currently support uses something
> that breaks with prefetching outside of IPL (which has a different
> workaround).>
> One thing that still concerns me a bit is debuggability if a future
> guest indeed does want to dynamically rewrite a channel program: the

+1 for some debuggability, just in general

> guest thinks it instructed the device to not prefetch, and then
> suddenly things do not work as expected. We can log when a guest
> submits an orb without prefetch set, but we can't find out if the guest
> actually does something that relies on non-prefetch.

Without going too far down a non-prefetch rabbit-hole, can we use the
cpa_within_range logic to see if the address of the CCW being fetched
exists as the CDA of an earlier (non-TIC) CCW in the chain we're
processing, and tracing/logging/messaging something about a possible
conflict?

(Jared, you did some level of this tracing with our real/synthetic tests
some time ago.  Any chance something of it could be polished and made
useful, without being overly heavy on the mainline path?)

> 
> The only correct way to handle this would be to actually implement
> non-prefetch processing, where I would not really know where to even
> start -- and then we'd only have synthetic test cases, for now. None of
> the options are pleasant :(
> 

And even if we knew where to start, it's quite a bit of effort for the
hypothetical.  From conversations I've had with long-time I/O folks,
non-prefetch seems to be the significant minority these days, dating
back to older CKD devices (and associated connectivity) in practice.
