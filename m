Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF4C433B4
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A79611AC
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 12:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhEEMcD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 May 2021 08:32:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhEEMcC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 May 2021 08:32:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145C2sZ4194231;
        Wed, 5 May 2021 08:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CzFPzFMsVF7E3BP/SwjVnMlPKW3qP1aV8Ju4dwSssdA=;
 b=Z5DbNpc4CxGyvsu9HZdxiGY+Bb+xh5kpDbOsk5B5UlRTXoL5TCib8G1cl0stNswF2WV/
 6eXZkWO95bNMHnWdpRmeVkY8I8/POQrjBzLFTRkOOYVfp74LS2MlzlP6dRezOlMG3ftU
 1RPnQ6iAnU+ZV0oMBA50sRN9nfVmpaUkOXbg1plw1zpEgUn7PqC20KeuP3wG+JwkpGgT
 Z//wlpLg68HyXqtEQ9I3MIa7/dj/95bjD/2E19jADQuokBBoStcaFTpJkxio69Yy4KsA
 In3BCiwwAul+P23npUN8Cb3pOTHaas1J5p+dwrbiGMvisBDvhXpG5R+oZiPk02X5pMXd xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bsjkk1ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 08:31:00 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145C3aZ8004858;
        Wed, 5 May 2021 08:30:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bsjkk1eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 08:30:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145CNqSS020245;
        Wed, 5 May 2021 12:30:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 38bedr42ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 12:30:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145CUuX328377436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 12:30:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2EC2136055;
        Wed,  5 May 2021 12:30:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404B7136051;
        Wed,  5 May 2021 12:30:55 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 12:30:55 +0000 (GMT)
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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
 <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
 <20210504173027.74552e19.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <92a0c58c-c891-bdd5-3c8d-3ce33a4d7d0e@linux.ibm.com>
Date:   Wed, 5 May 2021 08:30:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504173027.74552e19.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _-_a2UarmGnWRIzUiYABsCI0JUnlhHGb
X-Proofpoint-ORIG-GUID: IXNilmHzDCJFc1eriWCW-wHaNn6WwTnG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_06:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/4/21 11:30 AM, Cornelia Huck wrote:
> On Mon, 3 May 2021 16:14:43 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 4/26/21 1:48 PM, Cornelia Huck wrote:
>>> On Fri, 23 Apr 2021 20:03:03 -0300
>>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>   
>>>> This is straightforward conversion, the ap_matrix_mdev is actually serving
>>>> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
>>>> simple container_of().
>>>>
>>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
>>>>    drivers/s390/crypto/vfio_ap_private.h |   2 +
>>>>    2 files changed, 89 insertions(+), 50 deletions(-)
>>>>   
>>> (...)
>>>   
>>>> -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>>>> +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
>>>>    {
>>>> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
>>>>    
>>>> -	if (matrix_mdev->kvm)
>>>> -		return -EBUSY;
>>>> +	/* FIXME: Remove isn't allowed to fail */
>>>> +	if (WARN_ON(matrix_mdev->kvm))
>>>> +		return;
>>> This is a pre-existing problem, but the rework now makes it more
>>> obvious.
>> I agree, I was not aware that returning a non-zero return code
>> from this callback did not return the -EBUSY to userspace
>> when the mdev is removed.
>>
>>> Previously, the mdev code would only print a warning and then continue
>>> with device removal, even if a ->remove() callback returned an error.
>>> Now, it's quite clear that we'll end up in a weird half-dead state.
>> With the latest kernel from our tree, the remove hangs until the
>> guest is shutdown and the mdev fd is closed. During the hang, the
>> dmesg log has the following:
>>
>> "No mdev vendor driver request callback support, blocked until released
>> by user"
>>
>> So, it looks like nothing is done with the mdev until the fd for the
>> mdev is closed when the guest is shut down, at which time the
>> mdev is removed.
> You probably want to wire up the request callback and notify userspace.

Not sure what you mean by this, but I also don't think it matters.
After coding up the fix for this and testing it, I've learned that
if a user attempts to remove an mdev via the sysfs 'remove'
attribute while the mdev fd is still open (i.e., in use by the guest),
the mdev remove callback is not invoked until the fd is closed
(i.e., the guest is shut down). During that time, the mdev is
physically removed from sysfs so no further actions can be taken
on it; but, since the remove callback has yet to be called, the
guest will have access to the AP resources provided by the
mdev during that time. I also tested detaching the mdev device from the 
guest
(i.e., virsh detach-device) while the mdev was in the process of
being removed and this resulted in allowing the remove to
progress due to the mdev fd getting closed when it is detached.

>
> What happens today if the device in QEMU is removed via device_del?
> Does that already clean up things properly?

Hot plug/unplug is already supported, so yes, things get cleaned up
properly when the mdev fd is closed. This is handled by the mdev
release callback.

>

