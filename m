Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614B1C433ED
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4710161159
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECUPt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 16:15:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229595AbhECUPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 16:15:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143K3IV1093575;
        Mon, 3 May 2021 16:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xvRgvr2w6GyYNXwJ+/J7CAF+iZqRTzvjfoWLdKm+owA=;
 b=Cz+J3GkcDohnsZDwf/iJxYsCc9M+NkJg6FebuHzshI4kYl4rGdU37zmUMVxayA2+cHUL
 8/J/vPbCxw7YTEvnPDsjcy+wNBbkQeuKi0ABPjFGJS+3HaJCKrASOI3KRxQMMRIjHI6T
 OMPQ/4iOuF2qQc8SAGEwFz+0ZAobbdE68vtJFV86Vu4Ek2TRgknq+PgbEXsQ7t/DUOwh
 nomuDn6A+AW83DRwLbfBiU72HbmR7HJr2eSRTPgkn0JHt98tCLyK+j9X3nlDNwYLD6oe
 TArP9fgVBQ4F+NdsGmEZl/Stx29zwhvYcMEI/wjqS0Tr0z/gnnXcrEGHYk2gGZ7//vzm Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38aq58sep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:14:48 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143K49R8103010;
        Mon, 3 May 2021 16:14:48 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38aq58senv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:14:48 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143KCPXF019918;
        Mon, 3 May 2021 20:14:47 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 388xm94mhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 20:14:47 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143KEj6k14287228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 20:14:46 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9D713605E;
        Mon,  3 May 2021 20:14:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6683A136051;
        Mon,  3 May 2021 20:14:44 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 20:14:44 +0000 (GMT)
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
To:     Cornelia Huck <cohuck@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
Date:   Mon, 3 May 2021 16:14:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210426194859.1665730d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WLZCcKjbYlT-6WIn5fZ2aYkuiTpgAtnL
X-Proofpoint-ORIG-GUID: IdlRKkgcetVDee3sS9UdovfBAVwAJ3xB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_16:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030137
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 4/26/21 1:48 PM, Cornelia Huck wrote:
> On Fri, 23 Apr 2021 20:03:03 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>> This is straightforward conversion, the ap_matrix_mdev is actually serving
>> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
>> simple container_of().
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
>>   drivers/s390/crypto/vfio_ap_private.h |   2 +
>>   2 files changed, 89 insertions(+), 50 deletions(-)
>>
> (...)
>
>> -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>> +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
>>   {
>> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
>>   
>> -	if (matrix_mdev->kvm)
>> -		return -EBUSY;
>> +	/* FIXME: Remove isn't allowed to fail */
>> +	if (WARN_ON(matrix_mdev->kvm))
>> +		return;
> This is a pre-existing problem, but the rework now makes it more
> obvious.

I agree, I was not aware that returning a non-zero return code
from this callback did not return the -EBUSY to userspace
when the mdev is removed.

>
> Previously, the mdev code would only print a warning and then continue
> with device removal, even if a ->remove() callback returned an error.
> Now, it's quite clear that we'll end up in a weird half-dead state.

With the latest kernel from our tree, the remove hangs until the
guest is shutdown and the mdev fd is closed. During the hang, the
dmesg log has the following:

"No mdev vendor driver request callback support, blocked until released 
by user"

So, it looks like nothing is done with the mdev until the fd for the
mdev is closed when the guest is shut down, at which time the
mdev is removed.

>
> IIRC, the check for matrix_mdev->kvm is intended to protect against
> ripping out the device under a running guest (I think it needs to
> manipulate some crypto control blocks?)

This is correct.

>
> So my question for the vfio-ap maintainers is: Can we actually end up
> in this case? If yes, is there any way to gracefully shut down the
> device?

This case will occur whenever a user removes the mdev
by echoing a '1' into the mdev's sysfs 'remove' attribute
file. I'm not sure it can be considered graceful to take away
all of the crypto devices from a guest while it is running,
but there is a way to process the remove callback without
leaving things in a "weird, half-dead state".

Up to this point, the onus for ensuring the proper procedure
is followed when managing pass-through crypto devices
for a KVM guest is left to the system administrator. In
other words, we don't prevent an admin from shooting
him/herself in the foot when doing things such as removing
an mdev while a KVM guest is using it. With this in mind,
I will handle this case in the follow-on patches implementing
dynamic AP configuration support for KVM guests.

>
>> +
>> +	vfio_unregister_group_dev(&matrix_mdev->vdev);
>>   
>>   	mutex_lock(&matrix_dev->lock);
>> -	vfio_ap_mdev_reset_queues(mdev);
>> +	vfio_ap_mdev_reset_queues(matrix_mdev);
>>   	list_del(&matrix_mdev->node);
>>   	mutex_unlock(&matrix_dev->lock);
>>   
>>   	kfree(matrix_mdev);
>> -	mdev_set_drvdata(mdev, NULL);
>>   	atomic_inc(&matrix_dev->available_instances);
>> -
>> -	return 0;
>>   }
> (...)
>

