Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF55C07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B1F6128E
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMTH0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:07:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229500AbhGMTHZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 15:07:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DJ47hX167016;
        Tue, 13 Jul 2021 15:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uaihiB6uGspX9Rt/mXJ3V4yuM7c61F+rcXJUUgxiIlE=;
 b=Jia9a5YxXm2e8nX2YB1hydkxRbDWzIJgpPh3FgEcA+S2WY0uiS852zQD5clTp1OIddL6
 M6Pv+gjx2wuLVAtMUPVl2ecxnazz1T406DIk2Yzms6nByjE+hs0G8GeVsIKmBmx3DImT
 8W2e4789O5OO45QnSZDyBuMq/qWhRpB/vRcTqyvDgCr8bG/PWSb007JZC1QMfqMa6jEv
 QQSEVR9+qpl4ngO1+rdcPlWTgRmZ9d2fghJYYOLcTfgAlK1S/4Zkg4voJR9q1i+J74Fg
 na4OiMDBbrYAUtu3pTycpzuWbouj6V6PXMwjvtBuzGYpsjIBmdhXKj1Is+HRSPsE9wOq 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs3cg346-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 15:04:34 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16DJ4XB0170049;
        Tue, 13 Jul 2021 15:04:33 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs3cg33s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 15:04:33 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16DJ0Mkk032061;
        Tue, 13 Jul 2021 19:04:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 39qt3beg4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 19:04:32 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16DJ4VA423986594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 19:04:31 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42F03136068;
        Tue, 13 Jul 2021 19:04:31 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A281113605D;
        Tue, 13 Jul 2021 19:04:28 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jul 2021 19:04:28 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Jason Gunthorpe <jgg@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
Date:   Tue, 13 Jul 2021 15:04:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210713170533.GF136586@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NRFBfKKzn4jvnDSsBmc2q_2plxQK1wCP
X-Proofpoint-ORIG-GUID: 0KLL-IszE5tVscu23fYsoVqA-QbvDQMI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_10:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130121
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/13/21 1:05 PM, Jason Gunthorpe wrote:
> On Tue, Jul 13, 2021 at 06:45:17PM +0200, Halil Pasic wrote:
>
>> Jason may give it another try to convince us that 0cc00c8d4050 only
>> silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
>> knowledge using condition variable and a mutex is one of the well known
>> ways to implement an rwlock.
> The well known pattern is to use a rwsem.
>
> This:
>          wait_event_cmd(matrix_mdev->wait_for_kvm,
>                         !matrix_mdev->kvm_busy,
>                         mutex_unlock(&matrix_dev->lock),
>                         mutex_lock(&matrix_dev->lock));
>
>
> Is not really a rwsem, and is invsible to lockdep.

The lockdep splat was due to holding the matrix_dev->lock
mutex while the kvm->lock was taken to plug the AP devices
into the guest. The same problem would occur whether an
rwsem or the mutex was used.

The lockdep splat was resolved by setting the
matrix_mdev->kvm_busy flag and unlocking the matrix_dev->lock
mutex while the AP devices were being plugged into the guest.
All other functions needing the matrix_dev->lock mutex would wait
on a queue until the matrix_mdev->kvm_busy flag is cleared before
locking the matrix_dev->lock mutex.

Now, I understand that this technique is invisible to lockdep,
but I don't see how we can ever end up in a deadlock with
this design since the matrix_dev->lock mutex will never get
locked as long as the matrix_mdev->kvm_busy flag is set.

>
> Jason

