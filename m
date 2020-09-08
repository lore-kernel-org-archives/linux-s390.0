Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v10 03/16] s390/vfio-ap: manage link between queue struct
 and matrix mdev
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-4-akrowiak@linux.ibm.com>
 <99581cee-65fd-a622-ddc9-1a30e4638668@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <64ca7c98-4798-35c4-307e-57c4ca4cfdb2@linux.ibm.com>
Date: Tue, 8 Sep 2020 15:03:25 -0400
MIME-Version: 1.0
In-Reply-To: <99581cee-65fd-a622-ddc9-1a30e4638668@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 9/4/20 4:15 AM, Christian Borntraeger wrote:
> On 21.08.20 21:56, Tony Krowiak wrote:
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index a2aa05bec718..57da703b549a 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -87,6 +87,7 @@ struct ap_matrix_mdev {
>>   	struct kvm *kvm;
>>   	struct kvm_s390_module_hook pqap_hook;
>>   	struct mdev_device *mdev;
>> +	DECLARE_HASHTABLE(qtable, 8);
>>   };
> Ah I think the include should go into this patch. But then you should revisit the patch description
> of 2 as it talks about hashtables (but doesnt do anything about it).

Got it.

>   
