Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9584BC4743C
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF5160724
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 16:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUQHS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:07:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhFUQHR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 12:07:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LG3bVK125137;
        Mon, 21 Jun 2021 12:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xC2H3nWBOh29t3uOaRidY25D5ip6CSxMWk7FCVl2BvQ=;
 b=NfBcQGZa6F/deQLkw5nVXkYWfVqQzRiyJV+zxf2a1pi/RQSFoJP/4vQo1bqCECrXOh0k
 ycnB5rwzPzVSSpK9zcBZWdMTB7L3FeKCyqkOdk6xex6p44hLz5Zk99NEZapUu3RxY2CX
 2QeD8UQ+YlfeWMX2sswllI/IiABDL3NscpNxkP8/SNWZpQpvmrG3dUsyV17SjJQNiDI8
 RNZnxb3h3vQQgkdKCuLnmSO9tVPYa1ccoLDVCgBgZHgfopOax4mFIOi5uHEUs847JRXj
 JhJ+kPpdcXhXfMMUNSTRUSmZWb06fmeICmJIG211K8ZzpZTGCQGMnqBQsVjjVpn+SCUU 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39awsa8du2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 12:05:01 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LG3d5B125316;
        Mon, 21 Jun 2021 12:05:01 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39awsa8dsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 12:05:01 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LG3u8j024668;
        Mon, 21 Jun 2021 16:04:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uh901w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 16:04:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LG4tDI10748364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:04:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8677952069;
        Mon, 21 Jun 2021 16:04:55 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.79.141])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E5BE252050;
        Mon, 21 Jun 2021 16:04:54 +0000 (GMT)
Subject: Re: [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
To:     Tony Krowiak <akrowiak@linux.ibm.com>, jgg@nvidia.com
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-2-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <e809be5b-0b24-34dc-1eae-82b58dc54545@de.ibm.com>
Date:   Mon, 21 Jun 2021 18:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621155714.1198545-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OTr8WULTvhURx9TauMF4m4bEC0t2uQSS
X-Proofpoint-GUID: yaSt5xMNWnlEqjSvY4iHsCXWzz8YO5g7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_06:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 21.06.21 17:57, Tony Krowiak wrote:
> The mdev remove callback for the vfio_ap device driver bails out with
> -EBUSY if the mdev is in use by a KVM guest (i.e., the KVM pointer in the
> struct ap_matrix_mdev is not NULL). The intended purpose was
> to prevent the mdev from being removed while in use. There are two
> problems with this scenario:
> 
> 1. Returning a non-zero return code from the remove callback does not
>     prevent the removal of the mdev.
> 
> 2. The KVM pointer in the struct ap_matrix_mdev will always be NULL because
>     the remove callback will not get invoked until the mdev fd is closed.
>     When the mdev fd is closed, the mdev release callback is invoked and
>     clears the KVM pointer from the struct ap_matrix_mdev.
> 
> Let's go ahead and remove the check for KVM in the remove callback and
> allow the cleanup of mdev resources to proceed.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: stable@vger.kernel.org

This one is already queued on

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes

Jason. Do you want this in stable? Then we should write a mail after merging.
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index b2c7e10dfdcd..122c85c22469 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -366,16 +366,6 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
>   	mutex_lock(&matrix_dev->lock);
> -
> -	/*
> -	 * If the KVM pointer is in flux or the guest is running, disallow
> -	 * un-assignment of control domain.
> -	 */
> -	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
> -		mutex_unlock(&matrix_dev->lock);
> -		return -EBUSY;
> -	}
> -
>   	vfio_ap_mdev_reset_queues(mdev);
>   	list_del(&matrix_mdev->node);
>   	kfree(matrix_mdev);
> 
