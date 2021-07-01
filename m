Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3BDC11F64
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFFB61405
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 14:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhGAOb3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:31:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59804 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231698AbhGAOb3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 10:31:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161EStVv048609;
        Thu, 1 Jul 2021 10:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0dbB2p9crVKU9Dil6C/b6hHgLiPWCUpCbq3fmaFy7wY=;
 b=cAUCLoaOU5Ajmaly3/4qFMeyl/0d9Q2T7/9EPptHRrQAO58ccUY2NvKI3CmjWl8XkVVt
 +qCwT9Bo3AEfII1DeuugKvgxiDwc6SIftB83Aswrv39DC4YJlikq8/elPOoGydbQap8r
 Pw6L4f9DF2ksscgUiHsx35EcOssTnUG5734Kn5ZAVn/yTfi7HFyEvWij2d0tmafF8GbE
 EX0rbq7fHhfG3RtAm/m3K/Z+aU+0jH/mVCWmGe1EfOPp4CO4kja+RLCDe5prVv3n+fJE
 ER8j/wFMpj4fTofac5SaNBWjdjZfIVL9N0ZAr5TXIVwc8l/AUeqSq77SmL2jhaoXmLC3 jQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hf9h8f44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 10:28:56 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161EBoEi023517;
        Thu, 1 Jul 2021 14:28:54 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 39duve2ewd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 14:28:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161ESr3F40305096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 14:28:53 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AB1D78070;
        Thu,  1 Jul 2021 14:28:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C7FE7805F;
        Thu,  1 Jul 2021 14:28:52 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 14:28:52 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628222923.21a257c8.pasic@linux.ibm.com>
 <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
 <20210701003941.685c524c.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8b742188-d8a2-cf4e-e9de-0ca6f3d829b3@linux.ibm.com>
Date:   Thu, 1 Jul 2021 10:28:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210701003941.685c524c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T38m7f7PXam7t7_GdRiTfjnfInv8HYDw
X-Proofpoint-ORIG-GUID: T38m7f7PXam7t7_GdRiTfjnfInv8HYDw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/30/21 6:39 PM, Halil Pasic wrote:
> On Wed, 30 Jun 2021 10:31:22 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 6/28/21 4:29 PM, Halil Pasic wrote:
>>> On Fri, 25 Jun 2021 18:07:58 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>
>>> What is a suitable base for this patch. I've tried the usual suspects,
>>> but none of them worked.
>> I discovered what the problem is here. The patch is based on our
>> master branch along with the two pre-requisite patches that were
>> recently reviewed and are currently being merged. The two patches
>> of which I speak are:
>> * [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove
>> callback invoked
>>      Message ID: <20210621155714.1198545-2-akrowiak@linux.ibm.com>
>>
>> * [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception handler
>> function pointer
>>      <20210621155714.1198545-3-akrowiak@linux.ibm.com>
>>
>> I probably should have included those along with this one.
> Either that, or state in the cover letter that those are prerequisites.
>
>>>   
>>>> The fix to resolve a lockdep splat while handling the
>>>> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
>>>> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
>>>> A wait queue was employed to allow functions requiring access to the KVM
>>>> pointer to wait for the kvm_busy flag to be cleared. For the duration of
>>>> the wait period, the mdev lock was unlocked then acquired again after the
>>>> kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
>>>> really resolve the problem.
>>> Can you please elaborate on the last point. You mean that we can have
>>> circular locking even after 0cc00c8d4050, but instead of getting stuck in
>>> on a lock we will get stuck on wait_event_cmd()? If that is it, please
>>> state it clearly in the description, and if you can to it in the short
>>> description.

I created this patch in response to Jason G's review comments I copied
below. He did not mention anything about getting stuck in a 
wait_event_cmd(),
so you may want to ask him about that. To answer your
question, I don't see how we can get stuck in a wait_event_cmd() unless
one of the functions that set the matrix_mdev->kvm_busy flag does not
complete for some reason.

You asked for me to elaborate on the last point in the preceding paragraph;
I did so in my response to your comments/question above.

>>>    
>> This patch was in response to the following review comments made by Jason
>> Gunthorpe:
>>
>> * Message ID: <20210525162927.GC1002214@nvidia.com>
>>      "... the kvm_busy should be replaced by a proper rwsem,
>>       don't try to open code locks like that - it just defeats lockdep
>>       analysis".
>>
>> * Message ID: <20210527112433.GX1002214@nvidia.com>
>>      "Usually when people start open coding locks it is often
>>      because lockdep complained. Open coding a lock makes
>>      lockdep stop because the lockdep code
>>      is removed, but it doesn't fix anything. The kvm_busy
>>      should be replaced by a proper rwsem, don't try to
>>      open code locks like that - it just defeats lockdep
>>      analysis."
>>
>> I will paraphrase and include the information from Jason's
>> comments in the description.
>>
> This does not answer my questions.

See above.

>
> I'm in favor of Jason's proposal, because it is much easier to
> comprehend simple rwsem protected than a mutex + wait_queue dance.

That is a matter of opinion. I have no trouble understanding
the "mutex + wait_queue dance", but then again, I wrote the
code, so maybe that is why.

>   
>
> I think Jason was talking about open coding locks in general.

That may be so, but his comments were in support of his
statement that the  mutex + wait_queue did not resolve
the issue reported vai the lockdep splat because it turned
off lockdep.

> I don't
> consider it as proof of commit 0cc00c8d4050 not doing what it
> advertised.

I think I agree with this statement. Maybe I misunderstood what
Jason meant by "open coding locks like that". Since that comment
directly related to replacing the kvm->busy, I assumed that he
was referring to the "mutex + wait_queue dance" as you called it.
I probably should have probed deeper to discern exactly what
Jason meant by "open coding locks". I took Jason at his word
that "the kvm->busy ... just defeats lockdep analysis" because
I don't have deep knowledge about lockdep.

Even if the kvm->busy does defeat lockdep analysis, I still believe
it fixes the problem for which commit 0cc00c8d4050 was created.
If we don't hold the matrix_dev->lock while the kvm->lock is held
during update of the guest's matrix, lockdep does not report a
problem. That is proven by the tests of this patch.

If commit 0cc00c8d4050 does in fact resolve the issue for which
it was created, then there really is no need for this patch. It
certainly would reduce the amount of change that will be required
to integrate this patch with the "s390/vfio-ap: dynamic configuration
support" patch series currently under review.

> You can add a Suggested-by tag if you like, but you should
> be able to tell us what is the merit of your patch.

The patch removes the matrix_mdev->kvm_busy flag and the
wait_queue. The reason for removing them was because, as
Jason stated, "the kvm->busy ... just defeats lockdep analysis".

>
> Regards,
> Halil
>

