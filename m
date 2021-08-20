Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1F7C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037ED6103C
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhHTQAE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:00:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241039AbhHTP77 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 11:59:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KFjXVI128518;
        Fri, 20 Aug 2021 11:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k8eET66fJzgd3wK0Dvuic+CKwmXqYog1kRzcwzhimHs=;
 b=MB4H35kBGm9T7zbzKfUnEKG09smygBQ5OtF39rK11OhaMx9wZhj87KW7jF0nXD+yF1WG
 R0O9kcPVjSz8dHggCL6AclG+1Lc5A2nFqh2TZjCwFdU0fwP1l4iXCwbaQXbx/O1uRKb8
 Jsz+VxsUbixVcyPcORgFknfKTC1lwXQzEFVwcj0ZD8R23xUZzFE6GTSVo1PTBo0rucp3
 qGuNtI3dK5W8It0q/jrqgivlkIU0Mq/C0IVL5pYUp0+pg2n3geMQpScuMfv2/ew6vBGh
 hfVGRSrbSWL2BUG7VPdqtk2froUlIg8C2ws0cBycVGZE/YXLidG+ivAu077/KPqo0wA3 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahp9y9742-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 11:59:19 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KFk36E130781;
        Fri, 20 Aug 2021 11:59:19 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahp9y973s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 11:59:19 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KFpYPv024144;
        Fri, 20 Aug 2021 15:59:18 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3ae5fhm1eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 15:59:18 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KFxGgs13042018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 15:59:16 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B6C136059;
        Fri, 20 Aug 2021 15:59:16 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EC3136063;
        Fri, 20 Aug 2021 15:59:15 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 15:59:14 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
 <20210819115433.76153ae4.alex.williamson@redhat.com>
 <20210819175807.GC1721383@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <ad84bc55-07c6-2edf-bc5c-0cf3f452b60b@linux.ibm.com>
Date:   Fri, 20 Aug 2021 11:59:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819175807.GC1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4hdLupkrbgYybXS0964wGHx2lr1diald
X-Proofpoint-GUID: mlzPpxxgaB9tj_3vN5WJapiFWMqyqXa2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_06:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/19/21 1:58 PM, Jason Gunthorpe wrote:
> On Thu, Aug 19, 2021 at 11:54:33AM -0600, Alex Williamson wrote:
>
>> Nope.  The only requests for merges through my tree that I'm aware of
>> were [1] and what I understand was the evolution of that here now [2].
>> Maybe you're thinking of [3], which I do see in mainline where this was
>> 2/2 in that series but afaict only patch 1/2 was committed.  I guess
>> that explains why there was no respin based on comments for this patch.
>> Thanks,
> Tony,
>
> If you take Alex's tree from here:
>
> https://github.com/awilliam/linux-vfio/commits/next
>
> And rebase + repost exactly the patches you need applied it would be
> helpful.

Will do.

>
> Jason

