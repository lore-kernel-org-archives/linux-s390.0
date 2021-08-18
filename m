Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9ABC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50272610C7
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhHRQAg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 12:00:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239794AbhHRQAf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 12:00:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IFY4vN020806;
        Wed, 18 Aug 2021 11:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7G9jfFCwWY0CbhWjHN3sEy6ZO5yLoUp7zMMVFvKXlzk=;
 b=eok32icmS27SAb3TdsKSVZCYCARXmN4OYhjt54wAkI33W5bPL1M1sfn6n5Z7iMliWWTS
 a1Wkthv9qzLTeAt7g4ogjRZNbJGLB4KrEW7irJMbhApvFXIxFmVTpxZ777+DN2kXRh8m
 yDmZS+PRq2Idw+A+hzP5FX9v5Cd2ehBDqAIeLKnG/wmFQIrpdfGZQzFsUQlogNUGcqe2
 rwbq241kVXJhn+T5jgYxWkztnRCYfz45to9BW3v8OcILl6oywOSjKEilFoDX+bYlVMZs
 sRSzILlMynRGpkWbM/C5FCfPkgC0KtKSJ7xsDnWWowDGS3wSfJiGjFwvqKBwshQIlqY+ Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agc2guauq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 11:59:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17IFYeJ8023438;
        Wed, 18 Aug 2021 11:59:58 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agc2guatp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 11:59:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IFx61G032520;
        Wed, 18 Aug 2021 15:59:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3agh2xhbg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 15:59:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17IFxq7f27394558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 15:59:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A404611C054;
        Wed, 18 Aug 2021 15:59:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4E1011C04C;
        Wed, 18 Aug 2021 15:59:51 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.60.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Aug 2021 15:59:51 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, alex.williamson@redhat.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
 <20210802155355.22b98789.pasic@linux.ibm.com>
 <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
Date:   Wed, 18 Aug 2021 17:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9BcoIbM6isBU4-53oHwBOwQBW-QGQGnB
X-Proofpoint-GUID: ZoaA3gh3J8oSFsROW3JQG0oaTxJyrC8f
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_05:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02.08.21 18:32, Tony Krowiak wrote:
> 
> 
> On 8/2/21 9:53 AM, Halil Pasic wrote:
>> On Mon, 2 Aug 2021 09:10:26 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> PING!
>>>
>>> This patch will pre-req version 17 of a patch series I have waiting in
>>> the wings,
>>> so I'd like to get this one merged ASAP. In particular, if a KVM
>>> maintainer can
>>> take a look at the comments concerning the taking of the kvm->lock
>>> before the
>>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
>>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.
>> As far as I'm concerned, we can move forward with this. Was this
>> supposed to go in via Alex's tree?
> 
> I am not certain, Christian queued the previous patches related to
> this on:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> 
> Jason G., since this will need to be integrated with your other patches,
> where should this be queued?


This previous patch (s390/vfio-ap: clean up mdev resources when remove callback invoked) is
already in master.
Can you respin the series with all Acks and RBs?

Alex, can you then take these 2 patches via your tree? Thanks

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
for this series.
