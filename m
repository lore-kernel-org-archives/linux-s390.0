Return-Path: <SRS0=FZpJ=T4=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v2 8/8] virtio/s390: make airq summary indicators DMA
References: <20190523162209.9543-1-mimu@linux.ibm.com>
 <20190523162209.9543-9-mimu@linux.ibm.com>
 <20190527140018.7c2d34ff.cohuck@redhat.com>
 <20190528163342.335eea0b.pasic@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 28 May 2019 16:58:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190528163342.335eea0b.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f06a939d-0d80-a3b2-e69c-3bac9bb2c688@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 28.05.19 16:33, Halil Pasic wrote:
> On Mon, 27 May 2019 14:00:18 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Thu, 23 May 2019 18:22:09 +0200
>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>
>>> From: Halil Pasic <pasic@linux.ibm.com>
>>>
>>> Hypervisor needs to interact with the summary indicators, so these
>>> need to be DMA memory as well (at least for protected virtualization
>>> guests).
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>> ---
>>>   drivers/s390/virtio/virtio_ccw.c | 22 +++++++++++++++-------
>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> (...)
>>
>>> @@ -1501,6 +1508,7 @@ static int __init virtio_ccw_init(void)
>>>   {
>>>   	/* parse no_auto string before we do anything further */
>>>   	no_auto_parse();
>>> +	summary_indicators = cio_dma_zalloc(MAX_AIRQ_AREAS);
>>
>> What happens if this fails?
> 
> Bad things could happen!
> 
> How about adding
> 
> if (!summary_indicators)
> 	virtio_ccw_use_airq = 0; /* fall back to classic */
> 
> ?
> 
> Since it ain't very likely to happen, we could also just fail
> virtio_ccw_init() with -ENOMEM.

That is what I'm currently doing in v3.

> 
> Regards,
> Halil
> 
> 
>>
>>>   	return ccw_driver_register(&virtio_ccw_driver);
>>>   }
>>>   device_initcall(virtio_ccw_init);
>>
> 

Michael
