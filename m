Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <20190219102204.5e050b76.cohuck@redhat.com>
 <c23816b4-e24d-7cf7-8018-a3c085eef9f3@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 21 Feb 2019 12:34:11 +0100
MIME-Version: 1.0
In-Reply-To: <c23816b4-e24d-7cf7-8018-a3c085eef9f3@de.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9c7bcc08-815f-5eac-5540-d3969b4ca33c@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 19/02/2019 10:44, Christian Borntraeger wrote:
> 
> 
> On 19.02.2019 10:22, Cornelia Huck wrote:
>> On Mon, 18 Feb 2019 19:08:48 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>

...snip...

>>> +static struct bus_type matrix_bus = {
>>> +	.name = "vfio_ap",
>>> +	.match = &matrix_bus_match,
>>> +};
>>> +
>>> +static int matrix_probe(struct device *dev)
>>> +{
>>> +	return 0;
>>> +}
>>
>> I don't think you need this (the important function is the match
>> function of the bus).
> 
> Yes, with
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 8e45559795429..8ceec41afe322 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -68,15 +68,9 @@ static struct bus_type matrix_bus = {
>          .match = &matrix_bus_match,
>   };
>   
> -static int matrix_probe(struct device *dev)
> -{
> -       return 0;
> -}
> -
>   static struct device_driver matrix_driver = {
>          .name = "vfio_ap",
>          .bus = &matrix_bus,
> -       .probe = matrix_probe,
>   };
>   
>   static int vfio_ap_matrix_dev_create(void)
> 
> on top things still look fine.

OK, simpler is better, I remove the probe.

Thanks,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
