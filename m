Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01B6C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D160760F39
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhHTWFz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:05:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229760AbhHTWFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 18:05:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KM36vU020067;
        Fri, 20 Aug 2021 18:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1jDSUQxNlTGDTmW7UWd2Q1bW7p+I3Mrp3uwRF36kqog=;
 b=bhP+G/98G011ugeMxSlB8mc6Yp5fG6kYZKvqD5UMtGcsTfwTFGhgyeyFLepoez/nytAl
 I2SJIotLqO77vhBk25KO0e+6XWFCkkYomuHhQ8ER31rdNxqDpyaF9KH28D89Wfw5IaxE
 qf2QDOcnVKABx0g/K/HhNCPQBrbi6BnRQGhMIr5dxsR86kluD32eBjhEhrJ8NIOxn3DT
 prm5pjjX4ejvbd2pEUZczssn3lvWKWt0GUgdX1IOsvRN3S/+bClxdlv6WXmzqdlZz5dY
 o2pLSIJ4haemzmUbsYxqH2GG8gWVEle3OIkFGIUM29BMSaYUj2N/H/QSpvUT1BuNxJdh BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aj04u543m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 18:05:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KM5C6d034490;
        Fri, 20 Aug 2021 18:05:12 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aj04u5433-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 18:05:12 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KM2g0x006155;
        Fri, 20 Aug 2021 22:05:12 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 3ae5fgfy99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 22:05:12 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KM5A3s11862496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 22:05:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF8C136071;
        Fri, 20 Aug 2021 22:05:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E113136051;
        Fri, 20 Aug 2021 22:05:09 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 22:05:09 +0000 (GMT)
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
Message-ID: <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
Date:   Fri, 20 Aug 2021 18:05:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819175807.GC1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X9JEMAHYwhavx6CVqYp4Q58WnelX7ke7
X-Proofpoint-GUID: wfD9yNj887O8DlV17NjrCiaZZ2ADSWf2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_08:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200125
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

I navigated to this URL and clicked the green 'Code'
button. I was given the option to download the zip file or
use git to checkout the code at the URL displayed
'https://github.com/awilliam/linux-vfio.git'. I cloned the
repo at that URL and the code was definitely not in any
way similar to my code base. In particular, the
arch/s390/include/asm/kvm_host.h file did not have any
of the crypto structures.

I then downloaded the zip file and expanded it. The code
looked legitimate, but this was not a git repository, so I
had no way to cherry-pick my patches nor format patches
to post to this mailing list.

Next, I tried cloning from 
'https://github.com/awilliam/linux-vfio-next.git',
but I was prompted for uid/pw.

So, the question is, how to I get the linux-vfio-next repo upon which I
can rebase my patches? I apologize for my ignorance.

>
> And rebase + repost exactly the patches you need applied it would be
> helpful.
>
> Jason

