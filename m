Return-Path: <SRS0=PCIz=SS=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 00/12] s390: virtio: support protected virtualization
References: <20190404231622.52531-1-pasic@linux.ibm.com>
 <ec7dd523-6277-7753-eb18-83d0896d8706@redhat.com>
 <20190416131005.6f3e05eb@oc2783563651>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9fdf86ac-2498-e315-5ed8-317d40cedc5f@redhat.com>
Date: Tue, 16 Apr 2019 13:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190416131005.6f3e05eb@oc2783563651>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 16.04.19 13:10, Halil Pasic wrote:
> On Fri, 12 Apr 2019 15:47:50 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 05.04.19 01:16, Halil Pasic wrote:
>>> Enhanced virtualization protection technology may require the use of
>>> bounce buffers for I/O. While support for this was built into the virtio
>>> core,  virtio-ccw wasn't changed accordingly.
>>
>> Can you elaborate some more about the general approach (Enhanced
>> virtualization protection technology, ultravisor, concept, issues, how
>> to squeeze it into QEMU/KVM/kernel) etc =
>>
>> For my taste, this cover letter misses some important context :)
>>
> 
> I'm aware. Unfortunately we don't have a decision yet about which parts
> of the protected virtualization architecture are going to be PoP
> material.

Oh, okay.

> 
> You can get some more context immediately by having a look at Martin's
> features branch and looking at the s390/protvirt  and s390/uv patches.

As I don't have time to dig through random branches to
discover/reverse-engineer the obvious, I won't be reviewing this patch
series. But as I am not an I/O expert, this might not be bad at all :)

Maybe other people can help.

> 
> I will try to provide more background information for v1. But having
> a remotely complete and reliable documentation will take some time. What
> I can offer at the moment is answers to specific questions.

Waiting for v1 then.

Cheers!

-- 

Thanks,

David / dhildenb
