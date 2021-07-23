Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC1C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 05:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B28360E8B
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGWFLR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:11:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231949AbhGWFLR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 01:11:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N5aPQV039717;
        Fri, 23 Jul 2021 01:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XkZ3m0PigwT5WyRPg6Lt98un09CnDDNjG2ReWBa7yCQ=;
 b=AXzBLmP6qNsPlrAwS7I9oGm+TMsdG5ySnXn17dpRUk/xzWPLCT0mJUQEXNELOq6po+ob
 183ynsuo1uJKG/f8J8XAJqQDmwniuqpvVHG5eDrvNAIhPSu9YoZZKBHAeOHstIYLnXWd
 xqvzSmG0ETHzPNnqgHrNtgyKDIxAkEF+UzWXseM3aWtGIaWkEAtwQ4xciTFqg1SekOEy
 nXB1sUxL78ayCzbuE0Z3SamcCKG5/HLTyDYTsX1uAuYmJ/ikqG5AjDn/FmvqOVOMfOFl
 x0OWV+3k3dcSaNpggRimUZ4IUG2k7GEH4IHm/A9ok2q1BpjOOmzgpwNU3jHvmUDE5ZG6 Yg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39yq0w1cbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 01:51:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N5pBV8032258;
        Fri, 23 Jul 2021 05:51:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 39xhx4917w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 05:51:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16N5pO3c17891682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 05:51:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD84542042;
        Fri, 23 Jul 2021 05:51:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5141F4203F;
        Fri, 23 Jul 2021 05:51:24 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.25.128])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 05:51:24 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
 <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
 <20210723031252.655d6a83.pasic@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <62da6479-a000-0b1a-d251-c4e27616fbc2@de.ibm.com>
Date:   Fri, 23 Jul 2021 07:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210723031252.655d6a83.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JDL3fP8eBNYXkkJGbBGOgcZFzzxpE9S3
X-Proofpoint-ORIG-GUID: JDL3fP8eBNYXkkJGbBGOgcZFzzxpE9S3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_16:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230031
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 23.07.21 03:12, Halil Pasic wrote:
> On Thu, 22 Jul 2021 21:22:58 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 20.07.21 15:38, Will Deacon wrote:
>>> Hi again, folks,
>>>
>>> This is version two of the patch series I posted yesterday:
>>>
>>>     https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
>>>
>>> The only changes since v1 are:
>>>
>>>     * Squash patches 2 and 3, amending the commit message accordingly
>>>     * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
>>>
>>> I'd usually leave it a bit longer between postings, but since this fixes
>>> issues with patches in -next I thought I'd spin a new version immediately.
>>>
>>> Cheers,
>>
>> FWIW, I just bisected virtio-errors with secure execution mode
>> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
>>
>> to
>> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
>> Author: Claire Chang <tientzu@chromium.org>
>> Date:   Thu Jun 24 23:55:20 2021 +0800
>>
>>        swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
>>
>> Unfortunately this patch series does NOT fix this issue, so it seems that even more
>> things are broken.
>>
>> Any idea what else might be broken?
> 
> I've done some debugging, and I think I know what is going on. Since
> that commit we need to set force_swiotlb before the swiotlb itself is
> initialized. So the patch below should fix the problem.
> 
> --------------------8<-------------------------------------
> 
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Fri, 23 Jul 2021 02:57:06 +0200
> Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb
> 
> Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> before the swiotlb is initialised. Otherwise
> io_tlb_default_mem->force_bounce will not get set to true, and devices
> that use (the default) swiotlb will not bounce  despite switolb_force
> having the value of SWIOTLB_FORCE.
> 
> Let us restore swiotlb functionality for PV by fulfilling this new
> requirement.
> 
I would add:
Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
as this patch breaks things
and
Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")

to make the s390 init code more robust in case people start backporting things.

> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>

I can confirm that this fixes the problem. This also makes sense codewise.

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Konrad, Heiko, Vasily, any preference which tree this goes? I think s390
would be easiest, but that requires that the patches in the swiotlb tree have
fixed commit IDs.

> ---
>   arch/s390/mm/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 8ac710de1ab1..07bbee9b7320 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -186,9 +186,9 @@ static void pv_init(void)
>   		return;
>   
>   	/* make sure bounce buffers are shared */
> +	swiotlb_force = SWIOTLB_FORCE;
>   	swiotlb_init(1);
>   	swiotlb_update_mem_attributes();
> -	swiotlb_force = SWIOTLB_FORCE;
>   }
>   
>   void __init mem_init(void)
> 
