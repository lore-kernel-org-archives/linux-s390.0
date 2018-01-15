From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3] vfio: ccw: basic channel path event handling
Date: Mon, 15 Jan 2018 11:21:47 +0100
Message-ID: <bd035cc2-1859-91da-9051-660caec6ac0f@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
 <20180111115422.201987ee.cohuck@redhat.com>
 <20180115085741.GB12499@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115085741.GB12499@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/01/2018 09:57, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2018-01-11 11:54:22 +0100]:
>
>> On Thu, 11 Jan 2018 04:04:18 +0100
>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>
>>> Hi Folks,
>>>
>>> Background
>>> ==========
>>>
>>> Some days ago, we had a discussion on the topic of channel path virtualization.
>>> Ref:
>>> Subject: [PATCH 0/3] Channel Path realted CRW generation
>>> Message-Id: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
>>> URL: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg08414.html
>>>
>>> Indeed that thread is not short and discussed many aspects in a
>>> non-concentrated manner. The parts those are most valuable to me are:
>>> 1. a re-modelling for channel path is surely the best offer, but is not
>>>     possible to have in the near future.
>>> 2. to enhance the path related functionalities, using PNO and PNOM might
>>>     be something we can do for now. This may be something that I could improve
>>>     without model related arguments.
>>>
>>> So here I have this series targeting to add basic channel path event handling
>>> for vfio-ccw -- no touch of the channel path modelling in both the kernel and
>>> the QEMU side, but find a way to sync path status change to guest lazily using
>>> SCSW_FLAGS_MASK_PNO and pmcw->pnom.  In short, I want to enhance path related
>>> stuff (to be more specific: sync up path status to the guest) on a best effort
>>> basis, which means in a way that won't get us invloed to do channel path
>>> re-modelling.
>> The guest should also get the updated PIM/PAM/POM, shouldn't it?
>>
> Yes. The following values will be updated for the guest:
> PMCW:
>    - PIM/PAM/POM
>    - PNOM
>    - CHPIDs
> SCSW
>    - PNOM bit
>
> See vfio_ccw_update_schib in patch #4 of the QEMU series.
>
>>> What benifit can we get from this? The administrator of a virtual machine can
>>> get uptodate (in some extent) status of the current using channel paths, so
>>> he/she can monitor paths status and get path problem noticed timely (see the
>>> example below).
>>>
>>> I think we can start a new round discussion based on this series. So reviewers
>>> can give their comments based on some code, and then we can decide if this is
>>> we want or not.
>>>
>>> As flagged with RFC, the intention of this series is to show what I have for
>>> now, and what could the code look like in general. Thus I can get some early
>>> feedbacks. I would expect to see opinions on:
>>> - is the target (mentioned above) of this series welcomed or not.
>> It certainly makes sense to have a way to get an updated schib.
>>
> :)

I think so too, if the guest's administrator wants to be able to do 
something.

But I would like to see something about path virtualization.
Having more accurate information on hardware without virtualization is a
big handicap for migration and hotplug.

Regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
