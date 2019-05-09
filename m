Return-Path: <SRS0=ZS0J=TJ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 08/10] virtio/s390: add indirection to indicators access
From: Pierre Morel <pmorel@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-9-pasic@linux.ibm.com>
 <716d47ca-016f-e8f4-6d78-7746a7d9f6ba@linux.ibm.com>
Date: Thu, 9 May 2019 14:01:01 +0200
MIME-Version: 1.0
In-Reply-To: <716d47ca-016f-e8f4-6d78-7746a7d9f6ba@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a4bf1976-8037-63bb-2cf6-c389edbd2e89@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/05/2019 16:31, Pierre Morel wrote:
> On 26/04/2019 20:32, Halil Pasic wrote:
>> This will come in handy soon when we pull out the indicators from
>> virtio_ccw_device to a memory area that is shared with the hypervisor
>> (in particular for protected virtualization guests).
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/virtio/virtio_ccw.c | 40 
>> +++++++++++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/s390/virtio/virtio_ccw.c 
>> b/drivers/s390/virtio/virtio_ccw.c
>> index bb7a92316fc8..1f3e7d56924f 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -68,6 +68,16 @@ struct virtio_ccw_device {
>>       void *airq_info;
>>   };
>> +static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
>> +{
>> +    return &vcdev->indicators;
>> +}
>> +
>> +static inline unsigned long *indicators2(struct virtio_ccw_device 
>> *vcdev)
>> +{
>> +    return &vcdev->indicators2;
>> +}
>> +
>>   struct vq_info_block_legacy {
>>       __u64 queue;
>>       __u32 align;
>> @@ -337,17 +347,17 @@ static void virtio_ccw_drop_indicator(struct 
>> virtio_ccw_device *vcdev,
>>           ccw->cda = (__u32)(unsigned long) thinint_area;
>>       } else {
>>           /* payload is the address of the indicators */
>> -        indicatorp = kmalloc(sizeof(&vcdev->indicators),
>> +        indicatorp = kmalloc(sizeof(indicators(vcdev)),
>>                        GFP_DMA | GFP_KERNEL);
>>           if (!indicatorp)
>>               return;
>>           *indicatorp = 0;
>>           ccw->cmd_code = CCW_CMD_SET_IND;
>> -        ccw->count = sizeof(&vcdev->indicators);
>> +        ccw->count = sizeof(indicators(vcdev));
> 
> This looks strange to me. Was already weird before.
> Lucky we are indicators are long...
> may be just sizeof(long)


AFAIK the size of the indicators (AIV/AIS) is not restricted by the 
architecture.
However we never use more than 64 bits, do we ever have an adapter 
having more than 64 different interrupts?

May be we can state than we use a maximal number of AISB of 64 and 
therefor use indicators with a size of unsigned long, or __u64 or 
whatever is appropriate. Please clear this.

With this cleared:
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
