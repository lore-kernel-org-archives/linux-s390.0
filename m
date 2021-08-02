Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E4C4338F
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1996261050
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 16:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhHBQc2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:32:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhHBQc1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Aug 2021 12:32:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172GSf3n119024;
        Mon, 2 Aug 2021 12:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GtLTfRBHosk2HT8mQPlaf8TOULtvJoT93/CHLSAgRUk=;
 b=NmotiHD/tgKQkp+hKuavQhWXHz28YvZbZHlotnijlO7Gd22EXx2oJeO/rZYG2wF6HTxu
 6hZ9vpz53KrUYx9K1tYCiagd++6T9QdF8s3NHURcaT3DpcLrgHM9ff2NhTz74u8tzf43
 FmolZxHk5R06bo/7VP2i6kaBf1BKNgSzKsYnrL8rC5C4D0c1sjlE1xZ9Xi6mVcGPAH7e
 NKB6y0bmvXWmXeGbdwfxOkPUoF+x0Ak5wJBw4YUdVnncl+Cg6whYp3D+Fe5b2boKoeg0
 JhESBFX06NKZ+sGag1LUsGT5EYcy1T8swOTbdAx9nMC7MVLHnrIlqJKFMFO6lkCa3qdA lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a6ke11qn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 12:32:16 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 172GU5Dh124259;
        Mon, 2 Aug 2021 12:32:15 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a6ke11qmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 12:32:15 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 172GLUsi020455;
        Mon, 2 Aug 2021 16:32:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3a4x5bcudy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 16:32:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 172GWD6Y38600986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Aug 2021 16:32:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92CA72806A;
        Mon,  2 Aug 2021 16:32:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D02BE28060;
        Mon,  2 Aug 2021 16:32:12 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.77.143.250])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Aug 2021 16:32:12 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
Date:   Mon, 2 Aug 2021 12:32:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802155355.22b98789.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WiTV7pKfkeqiIUP4XlEuJXFQBEoIPWBv
X-Proofpoint-GUID: h2CbDX1y9GhcFqqssswQlGyr2SDFkHIF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_07:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/2/21 9:53 AM, Halil Pasic wrote:
> On Mon, 2 Aug 2021 09:10:26 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> PING!
>>
>> This patch will pre-req version 17 of a patch series I have waiting in
>> the wings,
>> so I'd like to get this one merged ASAP. In particular, if a KVM
>> maintainer can
>> take a look at the comments concerning the taking of the kvm->lock
>> before the
>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
> As far as I'm concerned, we can move forward with this. Was this
> supposed to go in via Alex's tree?

I am not certain, Christian queued the previous patches related to
this on:


https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes

Jason G., since this will need to be integrated with your other patches,
where should this be queued?

>
>> On 7/19/21 3:35 PM, Tony Krowiak wrote:
>>> This series is actually only comprised of a single patch to replace the
>>> open coded locks used during VFIO_GROUP_NOTIFY_SET_KVM notification. The
>>> first patch is included because it is a pre-req slotted to be merged but is
>>> not yet available in the kernel.
>>>
>>> Tony Krowiak (2):
>>>     s390/vfio-ap: r/w lock for PQAP interception handler function pointer
>>>     s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
>>>       notification
>>>
>>>    arch/s390/include/asm/kvm_host.h      |   8 +-
>>>    arch/s390/kvm/kvm-s390.c              |  28 +++++-
>>>    arch/s390/kvm/priv.c                  |  10 +-
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
>>>    drivers/s390/crypto/vfio_ap_private.h |   4 +-
>>>    5 files changed, 77 insertions(+), 100 deletions(-)
>>>   

