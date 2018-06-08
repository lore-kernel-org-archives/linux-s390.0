From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
Date: Fri, 8 Jun 2018 22:40:39 +0200
Message-ID: <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
 <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
 <20180605151449.22aafbfc.cohuck@redhat.com>
 <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
 <20180606142131.74ea2eb7.cohuck@redhat.com>
 <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
 <20180607115442.6a779ed9.cohuck@redhat.com>
 <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
 <20180607183407.1ea5ab89.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607183407.1ea5ab89.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/07/2018 06:34 PM, Cornelia Huck wrote:
> On Thu, 7 Jun 2018 18:17:57 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 06/07/2018 11:54 AM, Cornelia Huck wrote:
>>> Hm, I think we need to be more precise as to what scsw we're talking
>>> about. Bad ascii art time:
>>>
>>> --------------
>>> |   scsw(g)  |  ssch
>>> --------------   |
>>>                    |                                       guest
[..]

>> (5) AFAIK this is how the current implementation works. We don't wait
>> for the I/O interrupt on the host to present a cc to the guest for it's
>> ssch.
> 
> But the vfio code does wait, no? We just signal the interrupt via
> eventfd as well.
> 

We have sorted this out in the other thread.

>>
>>>
>>> If the guest now does a hsch, it would trap in the same way as the ssch
>>> before. When qemu gets control, it adds the halt bit in scsw(q) (which
>>> is in accordance with the architecture).
>>
>> (7) Again it's when is fctl set according to the architecture...
> 
> Same comment as above. If we do a hsch for a subchannel with the start
> function set, we'll set cc 0.
> 
>>
>>> My proposal is to do the same
>>> copying to scsw(r) again, which would mean we get a request with both
>>> the halt and the start bit set.
>>
>> (8) IMHO when receiving the 'request' we are and should be in instruction
>> context -- opposed to basic io function context. So we should not set fctl
>> before we know what will our guest cc be. But since scsw(r) is not a real
>> scsw it is just strange.
> 
> I think what we are doing is really 'performing the start function' -
> it's just not asynchronous in the current implementation. 

The code is written as if, especially in QEMU. But this was in my current
understanding a bad decision. The why is the following. It makes reasoning
both about architectural correctness and the code a lot trickier compared
to the interpretation of the guest instruction finishes after the host
instruction finishes (unless we can prove we don't need any) approach.


> So we already know that ssch will return with cc 0.
> 

I will use your example, and another example to explain what I mean
by tricky.

One can probably argue that setting cc 0 even if the host device
responds to the host ssch with cc 3 because the device is not any more
on the given subchannel or simply just disabled. It is probably true
that the guest would not have any means to prove that we were 'lying'
to it.

But AFAIR this is not how the current implementation works. The pwrite
in qemu basically depends on the cc of the host ssch. So if the host
ssch completes with cc 3 the vfio-ccw kernel module map ist to pwrite
reporting -ENODEV and vfio_ccw_handle_request makes sure that the
guest instruction completes with cc 3 by mapping it to return code
IOINST_CC_NOT_OPERATIONAL.

I mentioned xsch in the other thread. I don't think we can tell if
cc 0 or cc 2. In my reading xsch in simple words xsch completes with
cc 2 and does nothing else if the channel subsystem already started talking
to the cu/device. If in time it makes sure we don't start talking to the
device, and clear away stuff. So if we don't consider cc of the xsch
to be issued by the host the only safe bet seems to be cc 2. But that's
effectively getting around implementing the desired functionality of
xsch and still staying architecturally correct. Which however might
be good enough for vfio-ccw. But I think I demonstrated it's kinda
tricky business.

I prefer to avoid tricky if there is no good reason not to.

[..]

> 
> Thanks for reading!
> 

Your welcome. The discussion is kind of taking place all over the
place. I'm actively trying to find the best place to answer, and avoid
overtalking topics -- but it does not seem to work. Please bear with me.

Regards,
Halil
  
[..]
