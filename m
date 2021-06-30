Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DBC11F65
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DAF61474
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhF3Ofi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:35:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4973 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234913AbhF3Ofi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Jun 2021 10:35:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UE4x3P110700;
        Wed, 30 Jun 2021 10:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=shlLki/JXMN08E/puCPM+jYyshjdIkAtJt2x3bMGP5c=;
 b=jQ3PILjXwc8jc6Y6Zwbo1JrVsEQuph9DU/s1KGK8xECJ5NT2Fu8/EIejih4vXQXRQiw/
 9C65AXELKNl8WCqWhHfy/O9nCdpGV2pNNGfLF7lc4fPUJ07blJZmzKyJCqTDncpUQsmc
 M5P0SXSZhTfJedt5+Lm74sw6g6TeID7yKasqYXjjN5FFwSimZ6x8HVvnt0lk+g6zj2BK
 sSfre02c3uAp5r3KxoYUBgUHpF+62m6Q/8Z46pAzC7FG/dFIQvSVnQWhI7DrgWH3goMl
 m7CnQWr0gG/uKlSH2wQ0wbxjPmOJMemlJ0pv7N/1gHnNznEB019WMvftvQDPELhyc2sH HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gt2g0wc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:33:03 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UE6VLf120956;
        Wed, 30 Jun 2021 10:32:17 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gt2g0ves-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:32:17 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UELFbO022910;
        Wed, 30 Jun 2021 14:31:24 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 39duvcxyfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 14:31:24 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UEVNAf29163818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 14:31:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72774B2F97;
        Wed, 30 Jun 2021 14:31:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04238B2F96;
        Wed, 30 Jun 2021 14:31:22 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.148.193])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 14:31:22 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628222923.21a257c8.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
Date:   Wed, 30 Jun 2021 10:31:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628222923.21a257c8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p6aJyITZNgYWRsKEIZUESDhvQDuZ3zMz
X-Proofpoint-ORIG-GUID: xSyDolnr2m0E-2cVJHlZZsfBlxf_H_AZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_06:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/28/21 4:29 PM, Halil Pasic wrote:
> On Fri, 25 Jun 2021 18:07:58 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
> What is a suitable base for this patch. I've tried the usual suspects,
> but none of them worked.

I discovered what the problem is here. The patch is based on our
master branch along with the two pre-requisite patches that were
recently reviewed and are currently being merged. The two patches
of which I speak are:
* [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove 
callback invoked
    Message ID: <20210621155714.1198545-2-akrowiak@linux.ibm.com>

* [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception handler 
function pointer
    <20210621155714.1198545-3-akrowiak@linux.ibm.com>

I probably should have included those along with this one.

>
>> The fix to resolve a lockdep splat while handling the
>> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
>> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
>> A wait queue was employed to allow functions requiring access to the KVM
>> pointer to wait for the kvm_busy flag to be cleared. For the duration of
>> the wait period, the mdev lock was unlocked then acquired again after the
>> kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
>> really resolve the problem.
> Can you please elaborate on the last point. You mean that we can have
> circular locking even after 0cc00c8d4050, but instead of getting stuck in
> on a lock we will get stuck on wait_event_cmd()? If that is it, please
> state it clearly in the description, and if you can to it in the short
> description.

This patch was in response to the following review comments made by Jason
Gunthorpe:

* Message ID: <20210525162927.GC1002214@nvidia.com>
    "... the kvm_busy should be replaced by a proper rwsem,
     don't try to open code locks like that - it just defeats lockdep
     analysis".

* Message ID: <20210527112433.GX1002214@nvidia.com>
    "Usually when people start open coding locks it is often
    because lockdep complained. Open coding a lock makes
    lockdep stop because the lockdep code
    is removed, but it doesn't fix anything. The kvm_busy
    should be replaced by a proper rwsem, don't try to
    open code locks like that - it just defeats lockdep
    analysis."

I will paraphrase and include the information from Jason's
comments in the description.

>> This patch removes the the kvm_busy flag and wait queue as they are not
>> necessary to resolve the lockdep splat problem. The wait queue was
>> introduced to prevent changes to the matrix used to update the guest's
>> AP configuration. The idea was that whenever an adapter, domain or control
>> domain was being assigned to or unassigned from the matrix, the function
>> would wait until the group notifier function was no longer busy with the
>> KVM pointer.
>>
>> The thing is, the KVM pointer value (matrix_mdev->kvm) is always set and
>> cleared while holding the matrix_dev->lock mutex. The assignment and
>> unassignment interfaces also lock the matrix_dev->lock mutex prior to
>> checking whether the matrix_mdev->kvm pointer is set and if so, returns
>> the -EBUSY error from the function. Consequently, there is no chance for
>> an update to the matrix to occur while the guest's AP configuration is
>> being updated.
>>
>> Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

