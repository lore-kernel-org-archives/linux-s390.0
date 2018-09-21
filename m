From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 06/26] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Fri, 21 Sep 2018 10:07:06 -0400
Message-ID: <f4033331-4bdf-53fb-6000-b70b36652102@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180921114009.24e928d9.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921114009.24e928d9.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/21/2018 05:40 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:56 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new sysfs attributes for the VFIO mediated
>> matrix device for assigning AP adapters to and unassigning
>> AP adapters from a mediated matrix device. The IDs of the
>> AP adapters assigned to the mediated matrix device will be
>> stored in an AP mask (APM).
>>
>> The bits in the APM, from most significant to least significant
>> bit, correspond to AP adapter IDs (APID) 0 to 255. On
>> some systems, the maximum allowable adapter number may be less
>> than 255 - depending upon the host's AP configuration - and
>> assignment may be rejected if the input adapter ID exceeds the
>> limit.
>>
>> When an adapter is assigned, the bit corresponding to the APID
>> will be set in the APM. Likewise, when an adapter is
>> unassigned, the bit corresponding to the APID will be cleared
>> from the APM.
>>
>> In order to successfully assign an adapter, the APQNs derived from
>> the adapter ID being assigned and the queue indexes of all domains
>> previously assigned:
>>
>> 1. Must be bound to the vfio_ap device driver.
>>
>> 2. Must not be assigned to any other mediated matrix device
>>
>> If there are no domains assigned to the mdev, then there must
>> be an AP queue bound to the vfio_ap device driver with an
>> APQN containing the APID, otherwise all domains
>> subsequently assigned will fail because there will be no
>> AP queues bound with an APQN containing the adapter ID.
>>
>> Assigning or un-assigning an AP adapter will be rejected if
>> a guest using the mediated matrix device is running.
>>
>> The relevant sysfs structures are:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ...............[$uuid]
>> .................. assign_adapter
>> .................. unassign_adapter
>>
>> To assign an adapter to the $uuid mediated matrix device's APM,
>> write the APID to the assign_adapter file. To unassign an adapter,
>> write the APID to the unassign_adapter file. The APID is specified
>> using conventional semantics: If it begins with 0x the number will
>> be parsed as a hexadecimal number; if it begins with a 0 the number
>> will be parsed as an octal number; otherwise, it will be parsed as a
>> decimal number.
>>
>> For example, to assign adapter 173 (0xad) to the mediated matrix
>> device $uuid:
>>
>> 	echo 173 > assign_adapter
>>
>> 	or
>>
>> 	echo 0xad > assign_adapter
>>
>> 	or
>>
>> 	echo 0255 > assign_adapter
>>
>> To unassign adapter 173 (0xad):
>>
>> 	echo 173 > unassign_adapter
>>
>> 	or
>>
>> 	echo 0xad > unassign_adapter
>>
>> 	or
>>
>> 	echo 0255 > unassign_adapter
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |  295 +++++++++++++++++++++++++++++++++++++
>>   1 files changed, 295 insertions(+), 0 deletions(-)
> (...)
>
>> +/**
>> + * vfio_ap_mdev_verify_no_sharing
>> + *
>> + * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>> + * and AP queue indexes comprising the AP matrix are not configured for another
>> + * mediated device. AP queue sharing is not allowed.
>> + *
>> + * @kvm: the KVM guest
>> + * @matrix: the AP matrix
>> + *
>> + * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>> + */
>> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	int nbits;
>> +	struct ap_matrix_mdev *lstdev;
>> +	unsigned long apm[BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1)];
>> +	unsigned long aqm[BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1)];
> Can you please convert this to use a fixed-size array? I think
> {apm,aqm}_max has an upper bound of 255?

Sure

>
> (Also, this can use DECLARE_BITMAP.)

Indeed it can.

>
>> +
>> +	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
>> +		if (matrix_mdev == lstdev)
>> +			continue;
>> +
>> +		memset(apm, 0, sizeof(apm));
>> +		memset(aqm, 0, sizeof(aqm));
>> +
>> +		/*
>> +		 * We work on full longs, as we can only exclude the leftover
>> +		 * bits in non-inverse order. The leftover is all zeros.
>> +		 */
>> +		nbits = sizeof(apm) * BITS_PER_BYTE;
>> +		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
>> +				lstdev->matrix.apm, nbits))
>> +			continue;
>> +
>> +		nbits = sizeof(aqm) * BITS_PER_BYTE;
>> +		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
>> +				lstdev->matrix.aqm, nbits))
>> +			continue;
>> +
>> +		return -EADDRINUSE;
>> +	}
>> +
>> +	return 0;
>> +}
