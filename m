Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A44C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7BC61373
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHWUwd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:52:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232237AbhHWUwd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 16:52:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NKWkLF024230;
        Mon, 23 Aug 2021 16:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tx6WJXx4Qg6DcWSkc5MWS3/xUeu1B5M5t3tCihPoCwE=;
 b=hUeqHYGQi4MlmsYMbFq70mCH3M43qqVK2i6iu7ch6UDydSMeRxkVLOt58/1orN55yFY6
 sLTGzXgJSPLee+BzphVdWYn8tzyacfHrkQBEQlAfjUad2wuLKQ6TAcmmHRRsFfoDyPMa
 vzHt2Py4r26IuXReLIPvurevRqjAL8xMnAmh1nqQaVIG59y2LYwUSfpzRJ66mgUX+wQ+
 UguYzQFRYzRWOTVPl0/RXIZVttZZd9IXminwvonoqgo/+jAcplAWw/iT/jb036A/iHNS
 lmimnCZJ5tID5xpu0lHaTf3tK5kCGuXrygm7SnE4tSOKuYDYDu7amhLVra/Jy5Xnb47z FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ameuyq48r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:51:48 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NKg1tK057327;
        Mon, 23 Aug 2021 16:51:48 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ameuyq486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:51:48 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NKhFMK014244;
        Mon, 23 Aug 2021 20:51:47 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3ajs4b3xm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 20:51:47 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NKpjJ623003446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 20:51:46 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E03C8136061;
        Mon, 23 Aug 2021 20:51:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6B4D13605E;
        Mon, 23 Aug 2021 20:51:44 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 20:51:44 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
 <20210819115433.76153ae4.alex.williamson@redhat.com>
 <20210819175807.GC1721383@nvidia.com>
 <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
 <20210820164142.1dcea352.alex.williamson@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <bda77025-e287-4f73-ecef-ba6cd9df8a02@linux.ibm.com>
Date:   Mon, 23 Aug 2021 16:51:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210820164142.1dcea352.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HytNPE2TXqxdzI7CABvGNFi0O1xJQ4_x
X-Proofpoint-ORIG-GUID: WMHdJ2xhhFb82f-nIgLOhVirZSeo-fw1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230140
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/20/21 6:41 PM, Alex Williamson wrote:
> On Fri, 20 Aug 2021 18:05:08 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 8/19/21 1:58 PM, Jason Gunthorpe wrote:
>>> On Thu, Aug 19, 2021 at 11:54:33AM -0600, Alex Williamson wrote:
>>>   
>>>> Nope.  The only requests for merges through my tree that I'm aware of
>>>> were [1] and what I understand was the evolution of that here now [2].
>>>> Maybe you're thinking of [3], which I do see in mainline where this was
>>>> 2/2 in that series but afaict only patch 1/2 was committed.  I guess
>>>> that explains why there was no respin based on comments for this patch.
>>>> Thanks,
>>> Tony,
>>>
>>> If you take Alex's tree from here:
>>>
>>> https://github.com/awilliam/linux-vfio/commits/next
>> I navigated to this URL and clicked the green 'Code'
>> button. I was given the option to download the zip file or
>> use git to checkout the code at the URL displayed
>> 'https://github.com/awilliam/linux-vfio.git'. I cloned the
>> repo at that URL and the code was definitely not in any
>> way similar to my code base. In particular, the
>> arch/s390/include/asm/kvm_host.h file did not have any
>> of the crypto structures.
>>
>> I then downloaded the zip file and expanded it. The code
>> looked legitimate, but this was not a git repository, so I
>> had no way to cherry-pick my patches nor format patches
>> to post to this mailing list.
>>
>> Next, I tried cloning from
>> 'https://github.com/awilliam/linux-vfio-next.git',
>> but I was prompted for uid/pw.
>>
>> So, the question is, how to I get the linux-vfio-next repo upon which I
>> can rebase my patches? I apologize for my ignorance.
> You can use git fetch to download the objects, ex:
>
> $ git fetch git://github.com/awilliam/linux-vfio.git next
> $ git checkout FETCH_HEAD
>
> Or you could add a remote, ex:
>
> $ git remote add vfio git://github.com/awilliam/linux-vfio.git
> $ git remote update vfio
> $ git checkout vfio/next
>
> The former might be easier and add a lot less crufty objects to your
> local tree if this is a one-off activity.  Thanks,
>
> Alex

Thanks Alex, I was able to get the repo, cherry-pick my patches and
build and test the kernel. Barring any anomalies, I will be posting the
patches today.

>

