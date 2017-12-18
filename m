From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio/s390: fixup for implement PM operations for
 virtio_ccw
Date: Mon, 18 Dec 2017 09:59:14 +0100
Message-ID: <c5c804cd-bfba-e078-9ad4-6e9dea4c2404@de.ibm.com>
References: <201712171200.w6OAf5Jm%fengguang.wu@intel.com>
 <20171218083706.223836-1-borntraeger@de.ibm.com>
 <88011e21-2a91-5d18-d5c9-384decac3b79@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <88011e21-2a91-5d18-d5c9-384decac3b79@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, kbuild-all@01.org, kbuild test robot <fengguang.wu@intel.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/18/2017 09:52 AM, Thomas Huth wrote:
> On 18.12.2017 09:37, Christian Borntraeger wrote:
>> We need to disable the pm callbacks if CONFIG_PM is not set.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> Cornelia, you might want to squash this into the original commit.
>>
>>  drivers/s390/virtio/virtio_ccw.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>> index 330b3fa3430a..985184ebda45 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -1315,6 +1315,7 @@ static struct ccw_device_id virtio_ids[] = {
>>  	{},
>>  };
>>  
>> +#ifdef CONFIG_PM_SLEEP
>>  static int virtio_ccw_freeze(struct ccw_device *cdev)
>>  {
>>  	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
>> @@ -1333,6 +1334,7 @@ static int virtio_ccw_restore(struct ccw_device *cdev)
>>  
>>  	return virtio_device_restore(&vcdev->vdev);
>>  }
>> +#endif
>>  
>>  static struct ccw_driver virtio_ccw_driver = {
>>  	.driver = {
>> @@ -1346,9 +1348,11 @@ static struct ccw_driver virtio_ccw_driver = {
>>  	.set_online = virtio_ccw_online,
>>  	.notify = virtio_ccw_cio_notify,
>>  	.int_class = IRQIO_VIR,
>> +#ifdef CONFIG_PM_SLEEP
>>  	.freeze = virtio_ccw_freeze,
>>  	.thaw = virtio_ccw_restore,
>>  	.restore = virtio_ccw_restore,
>> +#endif
>>  };
> 
> Some other drivers rather seem to test CONFIG_HIBERNATE_CALLBACKS ...
> would that be a more appropriate config flag here?

The virtio code uses CONFIG_PM_SLEEP (and we call that code). 

See
include/linux/virtio.h

c6716bae52f97 (Michael S. Tsirkin 2014-10-14 10:40:35 +1030 155) #ifdef CONFIG_PM_SLEEP
c6716bae52f97 (Michael S. Tsirkin 2014-10-14 10:40:35 +1030 156) int virtio_device_freeze(struct virtio_device *dev);
c6716bae52f97 (Michael S. Tsirkin 2014-10-14 10:40:35 +1030 157) int virtio_device_restore(struct virtio_device *dev);
c6716bae52f97 (Michael S. Tsirkin 2014-10-14 10:40:35 +1030 158) #endif



So I think CONFIG_PM_SLEEP is the best fit.
