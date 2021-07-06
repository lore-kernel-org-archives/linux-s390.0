Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8025FC07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 22:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FA161CA7
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 22:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFWqX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:46:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhGFWqW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 18:46:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166MY5Cp039007;
        Tue, 6 Jul 2021 18:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MTLF/iktgurESX2nGHjEtGHHzr6BAtGzZtB5nv43H5U=;
 b=g5tWmnfiW2NOO90R3HvhtmDIslLUuuxKAi+Njg+8bE0YSvo1nJ+ORaaVoUV0FU3vKwXY
 C5zwT4hZidemFMu3M4ajnHw6bJbWoi3UriZaXPVo7xpK6PDMMvcBmdZumk9rfOJpAd10
 Pe2vwvRchpMH6lwCcBnF+7wzN+zlzsqDG9kkMRPLiMdfXBCdIsErj6Ko3KXr/gh9ZIPi
 JjZO6hhg1oeAYrmbpAXCQhGDH08SJP7M8h8eUejtyAphyGYZZ9Z5IxXqg2Pyp9yu3Z4D
 GyGWOmeeM6z+0fJGDsBUdwiWV5sRmbnRblIlClWUM6cxMzqTw9O8VQCtwsF0nhRQtOVf 5A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39mts004dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 18:43:42 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166MbqVN024231;
        Tue, 6 Jul 2021 22:43:41 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 39jfhcd36x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 22:43:41 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166MheMs44499414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 22:43:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66D83B2066;
        Tue,  6 Jul 2021 22:43:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2361CB2068;
        Tue,  6 Jul 2021 22:43:40 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 22:43:40 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
 <20210628222923.21a257c8.pasic@linux.ibm.com>
 <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
 <20210701003941.685c524c.pasic@linux.ibm.com>
 <8b742188-d8a2-cf4e-e9de-0ca6f3d829b3@linux.ibm.com>
 <20210705141348.GN4459@nvidia.com>
 <11025fe5-0751-b7ab-9250-b21c10382edd@linux.ibm.com>
 <20210706134939.GX4459@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <f958be51-a5fd-a755-f1de-a580f9ccbace@linux.ibm.com>
Date:   Tue, 6 Jul 2021 18:43:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210706134939.GX4459@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Vm9dF-9DIevD65to1lZ8T0qNlDddDuV
X-Proofpoint-GUID: 3Vm9dF-9DIevD65to1lZ8T0qNlDddDuV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_13:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/6/21 9:49 AM, Jason Gunthorpe wrote:
> On Tue, Jul 06, 2021 at 09:39:29AM -0400, Tony Krowiak wrote:
>>
>> On 7/5/21 10:13 AM, Jason Gunthorpe wrote:
>>> On Thu, Jul 01, 2021 at 10:28:52AM -0400, Tony Krowiak wrote:
>>>
>>>>> I think Jason was talking about open coding locks in general.
>>>> That may be so, but his comments were in support of his
>>>> statement that the  mutex + wait_queue did not resolve
>>>> the issue reported vai the lockdep splat because it turned
>>>> off lockdep.
>>> Rgiht, if this used to be proper locks and lockdep complained then
>>> whatever potential deadlock it found is not magically removed by going
>>> to a wait_queue. It just removes the lockdep annotations that would
>>> identify the issue early.
>>>
>>> This is why people should not open code locks, it completely defeats
>>> lockdep. That alone is merit enough for this patch.
>> When you use the phrase "open code locks", to what are you
>> specifically referring? I am confused by the use of the phrase
>> "open code" in this context because open coding, at least as
>> I understand it, has to do with data analysis.
> "open code" here means you write the algorithm of a standard lock in
> your own functions instead of calling the standard library.
>
> Testing/setting the busy and sleeping on a wait_event is exactly a
> standard lock.
>
> Ie if I write
>
>     for (len = 0; str[len] != 0; len++)
>             ;
>
> Then I have open coded strlen()
>
> Jason

Thanks for the explanation.


