Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727165AbfIRVWH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Sep 2019 17:22:07 -0400
Subject: Re: [PATCH v6 04/10] s390: vfio-ap: filter CRYCB bits for unavailable
 queue devices
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
 <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
 <20190918190433.713f4a93.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <be5bea2c-b849-ad94-b866-1ebf5467af70@linux.ibm.com>
Date: Wed, 18 Sep 2019 17:22:01 -0400
MIME-Version: 1.0
In-Reply-To: <20190918190433.713f4a93.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com

On 9/18/19 1:04 PM, Halil Pasic wrote:
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
> 
> I guess you wanted to zero out aqm here (and not apm again)!

Cut and paste without edit. I'll fix it.

> 
>> +	memcpy(matrix_mdev->crycb.adm, matrix_mdev->matrix.adm, masksz);
> 
