Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBAC07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E6B619B8
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhGFNmO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:42:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231964AbhGFNmM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 09:42:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166DYHVT186609;
        Tue, 6 Jul 2021 09:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BveKaaC1d5NphBm8v+8GVme47evTO/VVNHFPkrppu74=;
 b=BNeLq2UQuNvlODahX7zDiX4AaBk+7TE3+1iP0Gw4jiH4nltQMMSRlh5sqkF9ac8vANHs
 OSdjCaB3tmr990XN0OUD44qVyqy5LGtEbih6aBZvz1l6RYh6AHRccLCW0FwBvqozu2k1
 vJoXOO8mB9BtFXc+ZhpKYpsNUryOCwTTMAZ/S0WJU9LU7r9UphaEZhW43augs2GXeeuw
 Vlf/Ks9LTLIgPXmfVfocUgIrWmqGD4X9/q96e4j9Ch687QiLGJfvnzPkmEPaDo8JBy2u
 23mumlITmZQcBhgtDQEaM7F4cZNnsIBKTmWOxbCOTRsqWK9ikl537AK8XVte7WXrAfgF Mg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39mkpurfav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 09:39:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166DbpXQ005104;
        Tue, 6 Jul 2021 13:39:31 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 39jfhbxdu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 13:39:31 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166DdUm951642682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 13:39:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5128FB2066;
        Tue,  6 Jul 2021 13:39:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 204F2B2068;
        Tue,  6 Jul 2021 13:39:30 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 13:39:30 +0000 (GMT)
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
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <11025fe5-0751-b7ab-9250-b21c10382edd@linux.ibm.com>
Date:   Tue, 6 Jul 2021 09:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705141348.GN4459@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zA6KCiXhkl4isTqwx3j3Bh11nx3jP56n
X-Proofpoint-GUID: zA6KCiXhkl4isTqwx3j3Bh11nx3jP56n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_06:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/5/21 10:13 AM, Jason Gunthorpe wrote:
> On Thu, Jul 01, 2021 at 10:28:52AM -0400, Tony Krowiak wrote:
>
>>> I think Jason was talking about open coding locks in general.
>> That may be so, but his comments were in support of his
>> statement that the  mutex + wait_queue did not resolve
>> the issue reported vai the lockdep splat because it turned
>> off lockdep.
> Rgiht, if this used to be proper locks and lockdep complained then
> whatever potential deadlock it found is not magically removed by going
> to a wait_queue. It just removes the lockdep annotations that would
> identify the issue early.
>
> This is why people should not open code locks, it completely defeats
> lockdep. That alone is merit enough for this patch.

When you use the phrase "open code locks", to what are you
specifically referring? I am confused by the use of the phrase
"open code" in this context because open coding, at least as
I understand it, has to do with data analysis.

>
> Jason

