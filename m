From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
Date: Fri, 8 Jun 2018 23:10:31 +0200
Message-ID: <cc0753ec-6d5a-8f97-1352-420a0770e7ee@linux.ibm.com>
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
 <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
 <20180608142022.7dd6a658.cohuck@redhat.com>
 <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
 <20180608164514.2e8248f4.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608164514.2e8248f4.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/08/2018 04:45 PM, Cornelia Huck wrote:
> On Fri, 8 Jun 2018 15:13:28 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>>>> My proposal is to do the same
>>>>> copying to scsw(r) again, which would mean we get a request with both
>>>>> the halt and the start bit set. The vfio code now needs to do a hsch
>>>>> (instead of a ssch). The real channel subsystem should figure this out,
>>>>> as we can't reliably check whether the start function has concluded
>>>>> already (there's always a race window).
>>>> This I do not agree scsw(r) is part of the driver.
>>>> The interface here is not a device interface anymore but a driver
>>>> interface.
>>>> SCSW is a status, it is at its place in QEMU device interface with the
>>>> guest
>>>> but here pwrite() sends a command.
>>> Hm, I rather consider that "we write a status, and the backend figures
>>> out what to do based on that status".
>>>    
>>
>> The status of what? Kind of a target status?
>>
>> I think this approach is the source of lots of complications. For instance
>> take xsch. How are we supposed to react to a guest xsch (in QEMU and
>> in the kernel module)? My guess is that the right thing to do is to issue
>> an xsch in the vfio-ccw kernel module on the passed through subchannel.
>> But there is no bit in fctl for cancel.
>>
>> Bottom line is: I'm not happy with the current design but I'm not sure
>> if it's practical to do something about it (i.e. change it radically).
> 
> It might make sense to keep this for ssch, maybe reuse it for hsch/csch,
> and think about something else for other things we want to handle
> (xsch, channel monitoring, the path handling stuff for which we already
> had a prototype etc.) It's probably not practical to do radical surgery
> on the existing code.
> 


I'm reluctant to have a strong opinion. As far as i can tell ssch is
functionally quite good (see in the other sub-thread the part about host
ssch cc being reflected in the guest cc). I have the feeling the
implementation is at places unnecessarily complicated and at places
confusing and misleading (e.g.  the stale comment you have mentioned).
That feeling obviously has an impact on my confidence, e.g. the
confidence of my  'quite good' above.

I definitely don't have the time for even evaluating the prospects of a
radical surgery, let alone for making it happen. IMHO the key is not
making things worse as we proceed.

But I try to keep in touch and at least voice concern when I disagree. I
have been neglecting this series of yours and I feel bad about it. I even
lost track of the discussion and the conclusions (mainly between You and
Pierre). Your scsw write-up gave me the opportunity to connect.

I will try to do more for the next version, but it really depends on what
else do I have to do in parallel.

> [Speaking of which: Is there any current effort on the path handling
> things?]
> 

Dong Jia is the person with the best answers for this question. I hope
he will give us a piece of his mind about the design questions discussed
here too -- as the author he should have the best understanding of the
design decisions made.

Regards,
Halil
