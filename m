Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFFC2B9F4
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB39613F8
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 09:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFQJD2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:03:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56014 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhFQJD0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 05:03:26 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H8ebU0191396;
        Thu, 17 Jun 2021 05:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FEeLf/q0OqT9c/q4+Ave8tvpYTbPmwXpMNYPsfzILjg=;
 b=CGRvs1FuIxlE0VTSa91aBBZQMxFW3e7FAgHyp1O6X3GHSecaBIJgUieT87kXJqeVQFuk
 JOHCMCTASwkbjzcsrVs9Ts1PrbOfT1h27zuao8+TOS+Y/mXyYfjzETuSmoIY+PUgAhkK
 qbDCbFLxXE0i4coiRKpiw5akpfnqmAumikBvcls25efdTzk6xSo4tGekc0ikVpHG9x+I
 urVnuItyauqaZvKiBMty3BivTHSLbQWqNRt7j0/EWI/SowEh3KBgNrlFIyk/9gGSZaN9
 bfU/qp9gOlNZ/1lwj89Y+XxwHx5TQFI1pJfplnH7E5AUQx9FXbT9rejEs8qvFfG1veUT +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3982quh4wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 05:01:15 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15H8flK1193870;
        Thu, 17 Jun 2021 05:01:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3982quh4up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 05:01:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15H8qviW023657;
        Thu, 17 Jun 2021 09:01:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8tk9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 09:01:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15H9185516908710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 09:01:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9FFF52075;
        Thu, 17 Jun 2021 09:01:07 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.46.143])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 87C1252069;
        Thu, 17 Jun 2021 09:01:06 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210616141618.938494-1-akrowiak@linux.ibm.com>
 <20210616141618.938494-2-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <182da44d-a621-3a55-03af-d705b8763501@de.ibm.com>
Date:   Thu, 17 Jun 2021 11:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616141618.938494-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RVM1G4k0nt2_PRt66VHE5Z9BWOiP5SbI
X-Proofpoint-ORIG-GUID: 54xWZnJ-MmDz6pOx8cU5WEv8-n68OKtO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170059
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 16.06.21 16:16, Tony Krowiak wrote:
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

queued. Do we need cc stable?

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
