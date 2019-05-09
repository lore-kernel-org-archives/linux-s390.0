Return-Path: <SRS0=ZS0J=TJ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 09/10] virtio/s390: use DMA memory for ccw I/O and classic
 notifiers
From: Pierre Morel <pmorel@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-10-pasic@linux.ibm.com>
 <a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
Date: Thu, 9 May 2019 15:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <a873909a-9846-d6d3-f03e-e86d53fd9c75@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <db036887-c238-9795-5f47-cfeb475074e4@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/05/2019 16:46, Pierre Morel wrote:
> On 26/04/2019 20:32, Halil Pasic wrote:
>> Before virtio-ccw could get away with not using DMA API for the pieces of
>> memory it does ccw I/O with. With protected virtualization this has to
>> change, since the hypervisor needs to read and sometimes also write these
>> pieces of memory.
>>
>> The hypervisor is supposed to poke the classic notifiers, if these are
>> used, out of band with regards to ccw I/O. So these need to be allocated
>> as DMA memory (which is shared memory for protected virtualization
>> guests).
>>
>> Let us factor out everything from struct virtio_ccw_device that needs to
>> be DMA memory in a satellite that is allocated as such.
>>
...
>> +                       sizeof(indicators(vcdev)));
> 
> should be sizeof(long) ?
> 
> This is a recurrent error, but it is not an issue because the size of
> the indicators is unsigned long as the size of the pointer.
> 
> Regards,
> Pierre
> 

Here too, with the problem of the indicator size handled:
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
