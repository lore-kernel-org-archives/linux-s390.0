From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Mon, 17 Sep 2018 09:57:06 +0200
Message-ID: <8f5463ca-7a52-89a5-6d7f-12065484879a@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
 <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
 <20180823102447.05430368.cohuck@redhat.com>
 <1e0fc615-101c-7b9d-6dd1-de9a43fae734@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e0fc615-101c-7b9d-6dd1-de9a43fae734@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Am 12.09.18 um 19:42 schrieb Tony Krowiak:
> On 08/23/2018 04:24 AM, Cornelia Huck wrote:
>> On Thu, 23 Aug 2018 09:48:48 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Migration of AP devices is not supported by this patch series, so this
>>>> should
>>>> not be an issue.
>>> Might not be a problem now, but could be later. As I said in a different
>>> reply, the CPU model in QEMU does not care about KVM.
>>>
>>> I want the QEMU CPU model and the KVM interfaces to be clean and future
>>> proof. That's why my opinion is to handle PQAP(QCI) just like all the
>>> other "feature blocks" we already have.
>> +1 to that sentiment.
>>
>> It's better to try to get this correct now than having to hack around
>> should we want to implement things in the future.
> 
> Just so we're on the same page here as far as what to expect for v10 of
> this patch series, let me summarize the the very long series of private
> exchanges as well as this thread:
> 
> * The APXA facility indicated by a bit returned in the response to the
>    PQAP(QCI) function indicates only whether the APXA facility is available
>    on one or more APs installed on the system.
> * The only way to change the bit returned from PQAP(QCI) is to intercept the
>    instruction and emulate it, so it makes no sense for passthrough devices.
> * The AP(s) with APXA installed may not necessarily even be in the 
> configuration.
> * The only way to determine whether APXA is installed in a given AP is to
>    query it using the PQAP(TAPQ) instruction.
> 
> It was decided that APXA is better modeled as device configuration. If 
> and when
> emulation is implemented, APXA can be configured for any AP devices assigned
> to a guest. Since AP instructions will be intercepted when emulating AP,
> the PQAP(QCI) instruction can return the APXA bit according to whether any
> AP is configured with APXA installed. That matches the real architecture 
> much
> more closely. So, the bottom line is that we will not introduce a new 
> CPU model
> feature for APXA in v10 of this series.

Yes, that sounds sane to me. In addition, all other QCI indicated
"features/facilitites" are handled on a per-device basis and not on a
CPU-model basis.


-- 

Thanks,

David / dhildenb
