Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
References: <20190529122657.166148-1-mimu@linux.ibm.com>
 <20190529122657.166148-3-mimu@linux.ibm.com>
 <20190603133745.240c00a7.cohuck@redhat.com>
 <035b4bd3-5856-e8e5-91bf-ba0b5c7c3736@linux.ibm.com>
 <20190603145730.3e45b8f5.pasic@linux.ibm.com>
 <20190603153420.671939c3.cohuck@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 3 Jun 2019 15:43:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190603153420.671939c3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7fa32979-b94f-ad71-3c1b-37b601c114e7@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 03.06.19 15:34, Cornelia Huck wrote:
> On Mon, 3 Jun 2019 14:57:30 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Mon, 3 Jun 2019 14:09:02 +0200
>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>
>>>>> @@ -224,6 +226,8 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>>>>>    	INIT_WORK(&sch->todo_work, css_sch_todo);
>>>>>    	sch->dev.release = &css_subchannel_release;
>>>>>    	device_initialize(&sch->dev);
>>>>
>>>> It might be helpful to add a comment why you use 31 bit here...
>>>
>>> @Halil, please let me know what comment you prefere here...
>>>    
>>
>> How about?
>>
>> /*
>>   * The physical addresses of some the dma structures that
>>   * can belong  to a subchannel need to fit 31 bit width (examples ccw,).
>>   */
> 
> "e.g. ccw"?
> 
>>
>>
>>>>      
>>>>> +	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
>>>>> +	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
>>>>>    	return sch;
>>>>>    
>>>>>    err:
>>>>> @@ -899,6 +903,8 @@ static int __init setup_css(int nr)
>>>>>    	dev_set_name(&css->device, "css%x", nr);
>>>>>    	css->device.groups = cssdev_attr_groups;
>>>>>    	css->device.release = channel_subsystem_release;
>>>>
>>>> ...and 64 bit here.
>>>
>>> and here.
>>
>> /*
>>   * We currently allocate notifier bits with this (using css->device
>>   * as the device argument with the DMA API), and are fine with 64 bit
>>   * addresses.
>>   */
> 
> Thanks, that makes things hopefully clearer if we look at it some time
> in the future ;)
> 

Applied both with with requested change.

Michael
