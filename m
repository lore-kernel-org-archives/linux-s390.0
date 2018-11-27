From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] vfio: ap: ioctl definitions for AP Queue Interrupt
 Control
Date: Tue, 27 Nov 2018 18:46:35 +0100
Message-ID: <b308d46a-45e1-d891-235b-3097e5dd2b08@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
 <1542906675-7949-3-git-send-email-pmorel@linux.ibm.com>
 <20181127102237.42d8e178@x1.home>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127102237.42d8e178@x1.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 27/11/2018 18:22, Alex Williamson wrote:
> On Thu, 22 Nov 2018 18:11:14 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We define two VFIO ioctl command to setup and clear
>> the AP Queues interrupt.
>>
>> Arguments passed by the guest are:
>> - the apqn, AP queue number
>> - the Notification by address
>> - the identifier of the previously associated adapter
> 
> 
> We have an extensible VFIO_DEVICE_SET_IRQS ioctl already, why does AP
> need its own?

For no good reason.
Sorry for this.
I will change for the use of the standard VFIO_DEVICE_SET_IRQS.

Thanks Alex.

Regards,
Pierre

> 
> 
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   include/uapi/linux/vfio.h | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8131028..9a1b350 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -866,6 +866,31 @@ struct vfio_iommu_spapr_tce_remove {
>>   };
>>   #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>>   
>> +/**
>> + * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
>> + *
>> + * Setup IRQ for an AP Queue
>> + * @cmd contains the AP queue number (apqn)
>> + * @status receives the resulting status of the command
>> + * @nib is the Notification Indicator byte address
>> + * @adapter_id allows to retrieve the associated adapter
>> + */
>> +struct vfio_ap_aqic {
>> +	__u32   argsz;
>> +	__u32   flags;
>> +	/* out */
>> +	__u32 status;
>> +	/* in */
>> +	__u32 adapter_id;
>> +	__u64 nib;
>> +	__u16 apqn;
>> +	__u8 isc;
>> +	__u8 reserved[5];
>> +};
>> +#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
>> +#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
>>   /* ***************************************************************** */
>>   
>> +
>>   #endif /* _UAPIVFIO_H */
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
