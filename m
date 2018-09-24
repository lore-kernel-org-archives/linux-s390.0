From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 12/26] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO
 ioctl
Date: Mon, 24 Sep 2018 12:29:01 -0400
Message-ID: <13d5ac07-3c89-1a93-ce62-e3c44b3bf0ba@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924134310.29fb9d1d.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924134310.29fb9d1d.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/24/2018 07:43 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:43:02 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces ioctl access to the VFIO AP Matrix device driver
>> by implementing the VFIO_DEVICE_GET_INFO ioctl. This ioctl
>> provides the VFIO AP Matrix device driver information to the
>> guest machine.
> 
> What about the following?
> 
> "Add support for the VFIO_DEVICE_GET_INFO ioctl to the VFIO AP Matrix
> device driver. This is a minimal implementation, as vfio-ap does not
> use I/O regions."

Sounds good, I'll change it.

> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |   38 +++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h         |    1 +
>>   2 files changed, 39 insertions(+), 0 deletions(-)
> 
> Anyway,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
