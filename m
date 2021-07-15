Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA1C07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4987561004
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 14:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhGOOlw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:41:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbhGOOlw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 10:41:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FEcXEL061781;
        Thu, 15 Jul 2021 10:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h9JBxXeLxWWQ9sCap/qOTvbfXuNQJBiH+4CvkUhVb+4=;
 b=iHslGimfgPX2wKpGsr0mLuv49WaAPDnk50DjET66z6ld/49VzXk4t8ATOnW6DaZnUZM/
 8Qm2j+ONpxMoEPg/0EsIakBFM1OtK2IRmRxNPSRCo/vnw5pz3GFwviFabXTK0EIVBghl
 J1RM4vdzbSCb5DbUEKZIX9Etidy58aIptap1BvITW408pp/wewCYImpUvmDDhLCw/W4x
 Z2jVq1Wx0xJf1LZ8V+E84pWPUJDB/yn7a3d+8IhEZt4gSGQmAqmR26uKDA8TVlDDfTDa
 SjLqKVjVZyCRiXodSme5uptuy3R/CNpZxP98A31r7MsxobMEPG69crwHuCaakXzI3Myv Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39t0735033-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 10:38:57 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FEcv5M064292;
        Thu, 15 Jul 2021 10:38:57 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39t0735029-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 10:38:57 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FEcSM6008128;
        Thu, 15 Jul 2021 14:38:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 39q36d54m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 14:38:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FEctWY39322080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 14:38:55 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B65BAE060;
        Thu, 15 Jul 2021 14:38:55 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 649A0AE063;
        Thu, 15 Jul 2021 14:38:54 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jul 2021 14:38:54 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210715154451.3f0c264e.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <0e5fae99-762e-8060-c9ed-36674effa68b@linux.ibm.com>
Date:   Thu, 15 Jul 2021 10:38:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210715154451.3f0c264e.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AoBOOyFr7VEgGkhvJhKoWsAf6hcuL6RO
X-Proofpoint-GUID: BkIqz9IG_MiJyaNvs-fHYzFlZUGEre4c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/15/21 9:44 AM, Halil Pasic wrote:
> On Wed,  7 Jul 2021 11:41:56 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
> First sorry for being this late with having a more serious look at the
> code.
>
>
>> @@ -270,6 +270,9 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>    * We take the matrix_dev lock to ensure serialization on queues and
>>    * mediated device access.
>>    *
>> + * Note: This function must be called with a read lock held on
>> + *	 vcpu->kvm->arch.crypto.pqap_hook_rwsem.
>> + *
>
> That is a fine synchronization for the pqap_hook, but I don't think it
> is sufficient for everything.
>
>
>>    * Return 0 if we could handle the request inside KVM.
>>    * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>>    */
>> @@ -287,22 +290,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>>   		return -EOPNOTSUPP;
>>
>>   	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>> -	mutex_lock(&matrix_dev->lock);
> Here you drop a matrix_dev->lock critical section. And then
> you do all the interesting stuff. E.g.
> q = vfio_ap_get_queue(matrix_mdev, apqn);
> and
> vfio_ap_irq_enable(q, status & 0x07, vcpu->run->s.regs.gprs[2]);.
> Since in vfio_ap_get_queue() we do the check if the queue belongs
> to the given guest, and examine the matrix (apm, aqm) I suppose
> that needs to be done holding a lock that protects the matrix,
> and to my best knowledge this is still matrix_dev->lock. It would
> probably make sense to convert matrix_dev->lock into an rw_semaphore,
> or to introduce a some new rwlock which protects less state in the
> future, but right now AFAICT it is still matrix_dev->lock.
>
> So I don't think this patch should pass review.

Good catch. In an earlier patch review, Jason G suggested locking the 
kvm->lock
mutex outside of the kvm_arch_crypto_set_masks() and 
kvm_arch_crypto_clear_masks()
functions to resolve the lockdep splat resulting from locking the 
matrix_dev->lock
mutex prior to the kvm->lock mutex. I believe this will allow me to remove
the kvm_busy/wait queue scenario without introducing a new rwsem.

>
> Regards,
> Halil
>
>>   	if (!vcpu->kvm->arch.crypto.pqap_hook)
>>   		goto out_unlock;
>>   	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
>>   				   struct ap_matrix_mdev, pqap_hook);
>>
>> -	/*
>> -	 * If the KVM pointer is in the process of being set, wait until the
>> -	 * process has completed.
>> -	 */
>> -	wait_event_cmd(matrix_mdev->wait_for_kvm,
>> -		       !matrix_mdev->kvm_busy,
>> -		       mutex_unlock(&matrix_dev->lock),
>> -		       mutex_lock(&matrix_dev->lock));
>> -
>>   	/* If the there is no guest using the mdev, there is nothing to do */
>>   	if (!matrix_mdev->kvm)
>>   		goto out_unlock;

