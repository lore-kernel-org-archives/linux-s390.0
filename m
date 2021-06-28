Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A3C11F7B
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41B061C7B
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 18:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhF1SXd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:23:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234751AbhF1SX3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Jun 2021 14:23:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SI3tDM064448;
        Mon, 28 Jun 2021 14:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dc/S/1/PMhO2CDdPI1HX9wC2D1Doj3jFVx5qGJjnfU0=;
 b=Tj6jg/mh1Lg8RbDAydWKw6JMFoZhRFKg/7ugV5R+AzV2wxu9fWqgAK+R4Pz+Hz4Ieg62
 cMVeZVN7ssu/ZXy3OvwZkSWW0Kln/OuF7tWu+JGvaiwkpTOz9yYRYx02ebvvHXeF7lia
 vQa074cyrdff0+496b7Uik9agjcyetkY76FzIaVL3OpbjZ+1BJCBejQNqCT1/WTIsufk
 7X1fHP5MA/f0kuAL7QfM0AXAw/QuW49ywoIHVUPQ2SWhQmd3f7r8c8vWYBsJuzJqcyAA
 +kTKSmVyxdM5gd3Ksa9XlC8j/2hyzWcmPCPp8kwRUOgFRMnGeUtVux3+UxAnuw1I2UiM Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fjn99q4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:21:00 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SI4xTi072144;
        Mon, 28 Jun 2021 14:21:00 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fjn99q41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:21:00 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SIAUXj015727;
        Mon, 28 Jun 2021 18:20:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 39ejyx3tp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:20:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIKwcl29360432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:20:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2322078064;
        Mon, 28 Jun 2021 18:20:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB2A780B4;
        Mon, 28 Jun 2021 18:20:56 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.148.87])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:20:56 +0000 (GMT)
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
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <cc14f238-ba11-e388-06ec-027912fc313c@linux.ibm.com>
Date:   Mon, 28 Jun 2021 14:20:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628173448.GG4459@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hNTyB1T5iBMZMzJMtrOAOcJXFWvBdtCu
X-Proofpoint-GUID: BJjxR1E-k7zVg-Ci6nEbnT0iBTQAFzEQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280118
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/28/21 1:34 PM, Jason Gunthorpe wrote:
> On Fri, Jun 25, 2021 at 06:07:58PM -0400, Tony Krowiak wrote:
>>   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   {
>> +	mutex_lock(&matrix_dev->lock);
>>   
>> +	if ((matrix_mdev->kvm) && (matrix_mdev->kvm->arch.crypto.crycbd)) {
>>   		mutex_unlock(&matrix_dev->lock);
>> +		down_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>> +		up_write(&matrix_mdev->kvm->arch.crypto.pqap_hook_rwsem);
>>   
>> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>   
>>   		mutex_lock(&matrix_dev->lock);
>>   		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>>   		kvm_put_kvm(matrix_mdev->kvm);
>>   		matrix_mdev->kvm = NULL;
>> +		mutex_unlock(&matrix_dev->lock);
>>   	}
> Doesn't a flow exit the function with matrix_dev->lock held he

How can that happen? What flow?

>
> Write it with 'success oriented flow'

I'm not sure what you mean, can you clarify this statement?

>
> I didn't check if everything makes sense, but it sure looks clean.
>
> Jason

