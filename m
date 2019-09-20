Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387915AbfITOY3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 10:24:29 -0400
Subject: Re: [PATCH v6 04/10] s390: vfio-ap: filter CRYCB bits for unavailable
 queue devices
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
 <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
 <20190919123434.28a29c00.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <3c81ae10-79fc-d845-571f-66cb84e1227a@linux.ibm.com>
Date: Fri, 20 Sep 2019 10:24:19 -0400
MIME-Version: 1.0
In-Reply-To: <20190919123434.28a29c00.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com

On 9/19/19 6:34 AM, Halil Pasic wrote:
> On Fri, 13 Sep 2019 17:26:52 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> +static void vfio_ap_mdev_get_crycb_matrix(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	unsigned long apid, apqi;
>> +	unsigned long masksz = BITS_TO_LONGS(AP_DEVICES) *
>> +			       sizeof(unsigned long);
>> +
>> +	memset(matrix_mdev->crycb.apm, 0, masksz);
>> +	memset(matrix_mdev->crycb.apm, 0, masksz);
>> +	memcpy(matrix_mdev->crycb.adm, matrix_mdev->matrix.adm, masksz);
>> +
>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>> +			     matrix_mdev->matrix.apm_max + 1) {
>> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>> +				     matrix_mdev->matrix.aqm_max + 1) {
>> +			if (vfio_ap_find_queue(AP_MKQID(apid, apqi))) {
>> +				if (!test_bit_inv(apid, matrix_mdev->crycb.apm))
>> +					set_bit_inv(apid,
>> +						    matrix_mdev->crycb.apm);
>> +				if (!test_bit_inv(apqi, matrix_mdev->crycb.aqm))
>> +					set_bit_inv(apqi,
>> +						    matrix_mdev->crycb.aqm);
>> +			}
>> +		}
>> +	}
>> +}
> 
> Even with the discussed typo fixed (zero crycb.aqm) this procedure does
> not make sense to me. :(
> 
> If in doubt please consider the following example:
> matrix_mdev->matrix.apm and matrix_mdev->matrix.aqm have both just bits
> 0 and 1 set (i.e. first byte 0xC0 the rest of the bytes 0x0). Queues
> bound to the vfio_ap driver (0,0), (0,1), (1,0); not bound to vfio_ap is
> however (1,1). If I read this correctly this filtering logic would grant
> access to (1,1) which seems to contradict with the stated intention.

Yep, I see your point. I'll have to rework this code.

> 
> Regards,
> Halil
> 
> 
> 
