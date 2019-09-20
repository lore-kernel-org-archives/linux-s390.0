Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392297AbfITPoM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 11:44:12 -0400
Subject: Re: [PATCH v6 04/10] s390: vfio-ap: filter CRYCB bits for unavailable
 queue devices
From: Tony Krowiak <akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
 <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
 <20190919123434.28a29c00.pasic@linux.ibm.com>
 <3c81ae10-79fc-d845-571f-66cb84e1227a@linux.ibm.com>
Message-ID: <a587f900-352b-ae82-0c86-6c0fb173315e@linux.ibm.com>
Date: Fri, 20 Sep 2019 11:44:05 -0400
MIME-Version: 1.0
In-Reply-To: <3c81ae10-79fc-d845-571f-66cb84e1227a@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com

On 9/20/19 10:24 AM, Tony Krowiak wrote:
> On 9/19/19 6:34 AM, Halil Pasic wrote:
>> On Fri, 13 Sep 2019 17:26:52 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> +static void vfio_ap_mdev_get_crycb_matrix(struct ap_matrix_mdev 
>>> *matrix_mdev)
>>> +{
>>> +    unsigned long apid, apqi;
>>> +    unsigned long masksz = BITS_TO_LONGS(AP_DEVICES) *
>>> +                   sizeof(unsigned long);
>>> +
>>> +    memset(matrix_mdev->crycb.apm, 0, masksz);
>>> +    memset(matrix_mdev->crycb.apm, 0, masksz);
>>> +    memcpy(matrix_mdev->crycb.adm, matrix_mdev->matrix.adm, masksz);
>>> +
>>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>> +                 matrix_mdev->matrix.apm_max + 1) {
>>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>> +                     matrix_mdev->matrix.aqm_max + 1) {
>>> +            if (vfio_ap_find_queue(AP_MKQID(apid, apqi))) {
>>> +                if (!test_bit_inv(apid, matrix_mdev->crycb.apm))
>>> +                    set_bit_inv(apid,
>>> +                            matrix_mdev->crycb.apm);
>>> +                if (!test_bit_inv(apqi, matrix_mdev->crycb.aqm))
>>> +                    set_bit_inv(apqi,
>>> +                            matrix_mdev->crycb.aqm);
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>
>> Even with the discussed typo fixed (zero crycb.aqm) this procedure does
>> not make sense to me. :(
>>
>> If in doubt please consider the following example:
>> matrix_mdev->matrix.apm and matrix_mdev->matrix.aqm have both just bits
>> 0 and 1 set (i.e. first byte 0xC0 the rest of the bytes 0x0). Queues
>> bound to the vfio_ap driver (0,0), (0,1), (1,0); not bound to vfio_ap is
>> however (1,1). If I read this correctly this filtering logic would grant
>> access to (1,1) which seems to contradict with the stated intention.
> 
> Yep, I see your point. I'll have to rework this code.

As I see it, we have two choices here:

1. Do not set bit 1 in the APM of the guest's CRYCB because queue
    01.0001 is not bound to the vfio_ap device driver. This would
    preclude guest access to any domain in adapter 1 - i.e., the
    guest would have access to queues 00.0000 and 00.0001.

2. Do not set bit 1 in the AQM of the guest's CRYCB because queue
    01.0001 is not bound to the vfio_ap device driver. This would
    preclude guest access to domain 1 in both adapters - i.e., the
    guest would have access to queues 00.0000 and 01.0000.

There are ramifications for either choice. For example, if only one
adapter is assigned to the mdev, then option 1 will result in the
guest not having access to any AP queues. Likewise, the guest will
not get access to any AP queues if only one domain is assigned to
the mdev. Neither choice is optimal, but option 1 seems to make sense
because it somewhat models the behavior of the host system. For example,
only AP adapters can be configured online/offline and in order to
add/remove domains, an adapter must first be configured offline.

> 
>>
>> Regards,
>> Halil
>>
>>
>>
> 
