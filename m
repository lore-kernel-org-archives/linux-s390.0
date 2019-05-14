Return-Path: <SRS0=Fa9J=TO=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization
 support
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-7-pasic@linux.ibm.com>
 <20190513114136.783c851c.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 14 May 2019 10:47:34 -0400
MIME-Version: 1.0
In-Reply-To: <20190513114136.783c851c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d0ffefec-a14e-ee83-0aae-df288c3ffda4@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 5/13/19 5:41 AM, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:41 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> As virtio-ccw devices are channel devices, we need to use the dma area
>> for any communication with the hypervisor.
>>
>> This patch addresses the most basic stuff (mostly what is required for
>> virtio-ccw), and does take care of QDIO or any devices.
> 
> "does not take care of QDIO", surely? (Also, what does "any devices"
> mean? Do you mean "every arbitrary device", perhaps?)
> 
>>
>> An interesting side effect is that virtio structures are now going to
>> get allocated in 31 bit addressable storage.
> 
> Hm...
> 
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ccwdev.h   |  4 +++
>>   drivers/s390/cio/ccwreq.c        |  8 ++---
>>   drivers/s390/cio/device.c        | 65 +++++++++++++++++++++++++++++++++-------
>>   drivers/s390/cio/device_fsm.c    | 40 ++++++++++++-------------
>>   drivers/s390/cio/device_id.c     | 18 +++++------
>>   drivers/s390/cio/device_ops.c    | 21 +++++++++++--
>>   drivers/s390/cio/device_pgid.c   | 20 ++++++-------
>>   drivers/s390/cio/device_status.c | 24 +++++++--------
>>   drivers/s390/cio/io_sch.h        | 21 +++++++++----
>>   drivers/s390/virtio/virtio_ccw.c | 10 -------
>>   10 files changed, 148 insertions(+), 83 deletions(-)
> 
> (...)
> 
>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>> index 6d989c360f38..bb7a92316fc8 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -66,7 +66,6 @@ struct virtio_ccw_device {
>>   	bool device_lost;
>>   	unsigned int config_ready;
>>   	void *airq_info;
>> -	u64 dma_mask;
>>   };
>>   
>>   struct vq_info_block_legacy {
>> @@ -1255,16 +1254,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>>   		ret = -ENOMEM;
>>   		goto out_free;
>>   	}
>> -
>>   	vcdev->vdev.dev.parent = &cdev->dev;
>> -	cdev->dev.dma_mask = &vcdev->dma_mask;
>> -	/* we are fine with common virtio infrastructure using 64 bit DMA */
>> -	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
>> -	if (ret) {
>> -		dev_warn(&cdev->dev, "Failed to enable 64-bit DMA.\n");
>> -		goto out_free;
>> -	}
> 
> This means that vring structures now need to fit into 31 bits as well,
> I think? Is there any way to reserve the 31 bit restriction for channel
> subsystem structures and keep vring in the full 64 bit range? (Or am I
> fundamentally misunderstanding something?)
> 

I hope I've understood everything... I'm new to virtio. But from what I'm understanding, 
the vring structure (a.k.a. the VirtQueue) needs to be accessed and modified by both host 
and guest. Therefore the page(s) holding that data need to be marked shared if using 
protected virtualization. This patch set makes use of DMA pages by way of swiotlb (always 
below 32-bit line right?) for shared memory. Therefore, a side effect is that all shared 
memory, including VirtQueue data will be in the DMA zone and in 32-bit memory.

I don't see any restrictions on sharing pages above the 32-bit line. So it seems possible. 
I'm not sure how much more work it would be. I wonder if Halil has considered this? Are we 
worried that virtio data structures are going to be a burden on the 31-bit address space?


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
