Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-3-david@redhat.com>
 <20180808144733.507ba955.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f5d7528d-66f5-af47-a1e8-880eef9f4081@redhat.com>
Date: Wed, 8 Aug 2018 14:53:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180808144733.507ba955.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08.08.2018 14:47, Cornelia Huck wrote:
> On Tue,  7 Aug 2018 14:51:31 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> When we change the crycb (or execution controls), we also have to make sure
>> that the vSIE shadow datastructures properly consider the changed
>> values before rerunning the vSIE. We can achieve that by simply using a
>> VCPU request now.
> 
> Is this actually a concrete problem right now, or does this only become
> a real concern with vfio-ap?

The use case I implemented is not a real problem right now, at least not
in practice.

In QEMU, s390_crypto_reset() triggers this code, but it is only called
when all VCPUs are stopped (== no one in vSIE).

So this change is the right thing to do ("who knows what user space
does"), but not critical (we're only dealing with wrapping masks right
now). It is a problem once we allow to access adapters (vfio-ap).

> 
>>
>> This has to be a synchronous request (== handled before entering the
>> (v)SIE again).
>>
>> The request will make sure that the vSIE handler is left, and that the
>> request will be processed (NOP), therefore forcing a reload of all
>> vSIE data (including rebuilding the crycb) when re-entering the vSIE
>> interception handler the next time.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 1 +
>>  arch/s390/kvm/kvm-s390.c         | 7 ++++++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 


-- 

Thanks,

David / dhildenb
