Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBDC11F64
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DAD61C7E
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhF1Sa3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:30:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236486AbhF1SaB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Jun 2021 14:30:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SIHgNO176957;
        Mon, 28 Jun 2021 14:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yhI9Htr+Isf+QMPOa+/1CcKkeoTijDFM9CPPE8eUNqY=;
 b=HVufB39nUYZcFTQ5RkjYEjlmUT4GTCaytG/FPmVwlp+5/4mzRAlaTYStogEj8g9ahzts
 zvsga3aGgolTdNIaizwotWcdvuAlcd3ZFYduXQwpm2crNa6VgvW2cTeg/CJNH9uDgUOQ
 bTbet9rvX6Jw35n/yAWmKp+SVRWnoxg35sC2GL7rxm8xdHtqg2xHA1lP4SUP+knTtgHc
 qDjlNOFTxu7PiRJHsf4AqgE2ZN3r2SByo8AdxX6xhp4Y9C+pBj2YdGWtQEO8YOuBVrXe
 4PHclmybhnRnCyynAJHR1rxPlpzNXs3B0lx79sXgQ8Xi2+k8fXVSKwwxt+PzTWkBrQS7 jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fkk0r7cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:27:34 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SIOVHf028356;
        Mon, 28 Jun 2021 14:27:33 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fkk0r7c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:27:33 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SIMNw1031904;
        Mon, 28 Jun 2021 18:27:32 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 39ejyx41h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:27:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIRVpv31588682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:27:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5280D7890E;
        Mon, 28 Jun 2021 18:27:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC96D788E2;
        Mon, 28 Jun 2021 18:27:27 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.148.87])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:27:27 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628173448.GG4459@nvidia.com>
 <cc14f238-ba11-e388-06ec-027912fc313c@linux.ibm.com>
 <20210628182248.GH4459@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <f098fc11-d328-8130-bab9-bf38e18a7400@linux.ibm.com>
Date:   Mon, 28 Jun 2021 14:27:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628182248.GH4459@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nv96jAtlyoKi5Tc2FgpF9Z1TjRAVqDqe
X-Proofpoint-ORIG-GUID: gng92e5pMiaR7jyLm9gPHSGWaVH_OnzP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280118
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/28/21 2:22 PM, Jason Gunthorpe wrote:
> On Mon, Jun 28, 2021 at 02:20:55PM -0400, Tony Krowiak wrote:
>>
>> On 6/28/21 1:34 PM, Jason Gunthorpe wrote:
>>> On Fri, Jun 25, 2021 at 06:07:58PM -0400, Tony Krowiak wrote:
>>>>    static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>>>    {
>>>> +	mutex_lock(&matrix_dev->lock);
>>>> +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
>>>>    		mutex_unlock(&matrix_dev->lock);
>>>> +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>>>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>>> +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>>>> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>>    		mutex_lock(&matrix_dev->lock);
>>>>    		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>>>>    		kvm_put_kvm(matrix_mdev->kvm);
>>>>    		matrix_mdev->kvm = NULL;
>>>> +		mutex_unlock(&matrix_dev->lock);
>>>>    	}
>>> Doesn't a flow exit the function with matrix_dev->lock held he

Yes, you are correct. Stupid mistake.

>> How can that happen? What flow?
> When the if isn't taken
>
>>> Write it with 'success oriented flow'
>> I'm not sure what you mean, can you clarify this statement?
> Basically, don't write the bulk of the function under an if statement
>
> mutex_lock(&matrix_dev->lock);
> if (!matrix_mdev->kvm || !matrix_mdev->kvm->arch.crypto.crycbd) {
>      mutex_unlock(&matrix_dev->lock);
>      return;
> }

Sure.

>
> Jason
>

