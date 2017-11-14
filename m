From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 05/19] s390/zcrypt: base implementation of AP matrix device
 driver
Date: Tue, 14 Nov 2017 13:15:27 -0500
Message-ID: <d6cedf94-2e87-07e9-d77a-2db2e435bbfb@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114134040.3fcd6efd.cohuck@redhat.com>
 <06ddee4e-e1b8-ba17-5e3e-241e4dcf7cd0@linux.vnet.ibm.com>
 <20171114180036.262eff80.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171114180036.262eff80.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/14/2017 12:00 PM, Cornelia Huck wrote:
> On Tue, 14 Nov 2017 11:37:05 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 11/14/2017 07:40 AM, Cornelia Huck wrote:
>>> On Fri, 13 Oct 2017 13:38:50 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
>>>> index 4eb1e3c..66bfa54 100644
>>>> --- a/drivers/s390/crypto/ap_matrix_bus.c
>>>> +++ b/drivers/s390/crypto/ap_matrix_bus.c
>>>> @@ -75,10 +75,18 @@ static int ap_matrix_dev_create(void)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +struct ap_matrix *ap_matrix_get_device(void)
>>>> +{
>>>> +	return matrix;
>>> See the comments I had for the previous patch. In particular, I think
>>> it is better to retrieve a pointer to the matrix device via driver core
>>> methods.
>> I got some objections to creating a new bus and since there will only ever
>> be a single AP matrix device, I decided there really wasn't a need for an
>> AP matrix bus and got rid of it. I opted instead to create the matrix
>> device
>> in the init function of the vfio_ap_matrix driver. Rather than passing
>> around a
>> pointer, I put the following in vfio_ap_matrix_private.h:
>>
>>       struct ap_matrix {
>>           struct device device;
>>           spinlock_t qlock;
>>           struct list_head queues;
>>       };
>>
>>       extern struct ap_matrix ap_matrix;
>>
>> ... and declared the ap_matrix in  the driver (vfio_ap_matrix_drv.c)
>> file as:
>>
>>       struct ap_matrix ap_matrix;
>>
>> Does this seem like a reasonable approach?
> Getting rid of the bus as overhead is not unreasonable.
>
> I'm feeling a bit queasy about the extern, however. I'd prefer a getter
> function (that also makes sure refcounting rules are followed).
I now think I can avoid having to reference the ap_matrix device from
multiple places. The reason the device is referenced in vfio_ap_matrix_ops.c
is because there is a need for information about the AP queues that have 
been
bound to the vfio_ap_matrix device driver. If interfaces are provided by 
the
vfio_ap_matrix device driver to access the needed information, it
won't be necessary to reference the ap_matrix device directly in
vfio_ap_matrix_ops. I think this would be a better solution, don't you?
>
> We can't get around referencing this device from multiple files, can we?
The only way would be to roll up vfio_ap_matrix_ops.c into 
vfio_ap_matrix_drv.c. I followed the pattern established
by the vfio_ccw
>
