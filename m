Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5C433DB
	for <linux-s390@archiver.kernel.org>; Fri, 19 Feb 2021 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EEF64E15
	for <linux-s390@archiver.kernel.org>; Fri, 19 Feb 2021 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBSAAy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:00:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBSAAw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Feb 2021 19:00:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11INsjsa146086;
        Thu, 18 Feb 2021 23:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=r8CvnFNuAyh3w4CYvbW1FP7CRBLp7Kvp4DHVaRuoyr0=;
 b=i00YpH64mS4MLyhJ8k21xlvlbgVTMNMo3l8jVqQaZp8BeG5GhnEKr8pqyexCxcPs998L
 +frBQKT9VCfpdtEzu0FPAAjcz5ippco11pdKxU0YbEpt12x/XaWBzXKKgfjmnaSQkD//
 l7Bjd9rbFyfVOQPH7vyVngVKHJ5VNoL2CggxU5tXEEIvjbLIVArJ1MrkrXU0cX3Pz87O
 kquXx/ErRctMiax/1UzEVhIPgW/Zw7n9zSrAZnqcRXMF0b8s/O7kEAi323mqrcdpnoLg
 ptJudaJXq3N+urDtDE2LYJNJFfGYPBxSxRZ/vPgrFHp290cZyUsJLIwXH6Z7vU6+ahaQ og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dnqnwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 23:59:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11INxj3W039686;
        Thu, 18 Feb 2021 23:59:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 36prhux3qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 23:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8GVNZBqNQwELeWDAFdbQ4Q5nS5yUdeB9sEbIPdsEYhxvVsoeMP41q9VbzhyC1e+KHmwAYUqhYL0J9SMecG9wAVMGwaDm7UbvDdYUhFX2+PTcOXxaWUyi5HJ4OBY2gYrEDmptLxkNFhyzY/IlXP8guwQ921+i7+LtgdppcC6zu9NJWsKWp07zoslpVVLKJlDOdRxhw7HAnKGJkc+ccFcdwOeR9EzpGfdHCXM58RoP42wKa/VSfxQ1jtY0u55FnOjWm8INKnp4746H3qKZHic8AQbZHgCypdtP25WNt7YxCVE94blkWGYWy5eVLHb8ekU5aNjF4erNfu+LjMqbMUG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8CvnFNuAyh3w4CYvbW1FP7CRBLp7Kvp4DHVaRuoyr0=;
 b=DS64AsO1wGG3ze/bY7Ka6MiR5fdpGQpqpDKGOun9/zuXd22WOE5v+deSe2WaEuEt4f02lPFasxaQQOoc0z4z5F2d3GHvlNDP2/Au9R8medlu99UL8SIY9JPqJlodvyfVxLwha34vzLy5+uydWUZwuDIJtqesc/v8jeModuW7OeVuR50kljWcwdPtRAKzgX5YYrkpWCPres7dtINociWfV9ac6/pJK4Fh5tm+Vx+mbN9oST+athPMpdCUVsPb+y7YFRvz3FFDpliAk6wArTOYyBZlGCRLkCWL1182JW0fitwqgbwTwxt3XtnukaVmviUmPsCQp5zVz2ImgTO8UmJlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8CvnFNuAyh3w4CYvbW1FP7CRBLp7Kvp4DHVaRuoyr0=;
 b=OjH/hMukmrtEa+XEnmIly9BCtFSKYelaRY4gAVvLG6JjTBVnDcv/BND+5us1AVicmOFOysYxWLsfGZSRI1hW75sSTnHiSQmRkG+HrcYN9/FVK5zxZT55AMdMp0zGNlb1nt4pR8DB0YHKId2yJ7W0ZB70zmJxoXVmRdhURqRbr5A=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.41; Thu, 18 Feb
 2021 23:59:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 23:59:52 +0000
Subject: Re: [RFC PATCH 3/5] mm proc/task_mmu.c: add soft dirty pte checks for
 hugetlb
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-4-mike.kravetz@oracle.com>
 <20210217193550.GC6519@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <008f5ebc-6547-9244-24e0-710e3fe82b5e@oracle.com>
Date:   Thu, 18 Feb 2021 15:59:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217193550.GC6519@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0032.namprd21.prod.outlook.com
 (2603:10b6:300:129::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0032.namprd21.prod.outlook.com (2603:10b6:300:129::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.2 via Frontend Transport; Thu, 18 Feb 2021 23:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f58f721-2036-41d3-5063-08d8d469482c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4512:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB451277E51BB0A87E7C9436C9E2859@SJ0PR10MB4512.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9Qlfusefdpx4qlfks94/LysCDzv2B5Va65TMSVE4o9W9mbh4d37mN0AOwW85yX10nVkHpycTV55J7j7Os/owJbYpTDx/+e36Rp7bBfFvinqSBkY1DAQ5YxD+mDuT2JkfgGiixwnKJ4dWmVfefVJUsHtI9jXzScsYehNMbWZidDlrTnIgPHVff4ug7L1sfb4VzH2VbN24rwaYq1pSuGshyq75rvs7C8+Np2BD4Ip3ic44KYh8hFaPLTB8WzIBmPRmpnVb3WwauzsQaVR5rm1xuGrMGefDI4AtGR87hF+Bs0z26pfZq6rY8Uq8+btRPZjJYJXrZzBPvGUPe1PT8iozf7WKkv1dm0QvjNjmJ/h82kRM4XHvTctcLXoMfyfUYspiaGZYp0N+2dYmkq8jvkQxKqmxP3/0PyWxH7NuSLgAHMhvydQp9qKF1IZbG2ilz638wcnN42IKVcofuq//ZRMScdKEX0+M7mWvKMZswSH48LWu1YR1HRipKxcou9Ur/fg399+clrn/LjbezxnTl+kDddJdTnKC3XedDKo5O+H/GOq3UtlN1ZiTgtT9XKSzdDRuLD4Oh1EY03XEhXtCG1ccxbt+wx9cQfITv169CgZIwn0tBr4Qvh/tt4elQeiJXgI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(396003)(136003)(6916009)(8936002)(26005)(478600001)(31696002)(36756003)(8676002)(186003)(316002)(2906002)(16576012)(52116002)(6486002)(956004)(5660300002)(53546011)(4326008)(86362001)(16526019)(44832011)(54906003)(31686004)(7416002)(66476007)(2616005)(66946007)(66556008)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGdnTVJiRGRYZlFrZmNvUnlucEs4bEh2bWMySVExWnByMm5McjJjUjJxd3Iy?=
 =?utf-8?B?d0JYZlphREYxbXpWSnBvS2hEaVBORXJIQWRkWU1WeTBqTmJkVDlFNkc0WnZ0?=
 =?utf-8?B?OEVnNlpLTTAvOHQ5cC8zdkdVd1N4N2JpbForNFNIZEJjM0xwdklwR2FPbTl4?=
 =?utf-8?B?dXFlU0NWajlaVi81L2NNT0gvTFVhRWtnMm9CYlltZDJvT0FLT1JkWGdVS0RT?=
 =?utf-8?B?SmxhejZDbERZc0dmV2FuUThxYUkyUXlERzV1TVNTeDlUa29RZmhTc3lwUFhE?=
 =?utf-8?B?emVqV0p5Z2ZKVVlRd3lOd3NUWnV2MmE5V25xV1VnM2w3Vy9ZLzRNeUpPcVZr?=
 =?utf-8?B?ZWRPWXFLK2duUVY5MDR2bU1OelJIeFRhb2p6NjE0TDNNeVQvMlErc2hGSVJo?=
 =?utf-8?B?QWhBWFJPdnY0N2xHeU5JdkJsd1g0R2J6SXFnc2xIb2tRSVVKMEZQQlU0UVQ1?=
 =?utf-8?B?Vkkya1BoRnhxeVYvTkdwS3BnSW9JMUE2b3haZHBERy96UStLZllsWDlCUWda?=
 =?utf-8?B?a3AzeWc0dTFYcXVlT0d5LzFsR3BTcFNGYmcwVkhFb3NGVXFUNEphRnpFaVNr?=
 =?utf-8?B?dWR6UXJVM3U2ekQrS3NwU2lLMGQ3eVRxYUJqa0NMVmljYS93Q2p2UzdnMXlx?=
 =?utf-8?B?TkpXVkkyaGFNNE42Y3JmZ2k0Y2ZvazZ6UnQ0aUhVdWhpMVhkWElnUVBNczMz?=
 =?utf-8?B?ZjdIYmY5eE5hWEVpaENPSDdFd0FRZ2tDS3VhazVSaHg0Q1YvTVg5TTY1RElH?=
 =?utf-8?B?c3d0aDJIdnFaL0hJWkw5cEZrUTlMcjE3Ri91SXJXdjNOMWlITUxjdExYOEli?=
 =?utf-8?B?cWFUZGJHMFF0cVJZcCtSMzF4aW1FNVUycWdRSUtIckFmZHltbzA0VmFIbjJr?=
 =?utf-8?B?NElydkFDcmNUQWdEZk1KQU4wYXgxSTBIRmlPcEI5UVNLLzJQR2xEWS91UUNy?=
 =?utf-8?B?WVZqcGhNOHlIUFNFcWZSbVJSOE8wTVZ2Zm95cWZkcWtjbGNBTmw3TDZSWFZw?=
 =?utf-8?B?bmF5VGZuTkdNb1pyUFNtSTJLLzhJN1ZaZUxneWcwSm41anM1UHc1bnRLMW15?=
 =?utf-8?B?dkIwbUtLV0VKellOYlhBZVFTeXpuMDFJR3hNVnMvdWRrYm9nN1JRRGNWYUoy?=
 =?utf-8?B?SWEvMC9Vb2JZWXJYUkh1ZU1vaTZ5SWdWTlNXTkF5OFhsZWZIUjdpTWw0Z3U0?=
 =?utf-8?B?QnZFOTE4NGs0cmVYQ2VxbXNxQUdZK0p0SGJ4TnFqOHVkTU1EQStIK09FUVp5?=
 =?utf-8?B?YWxCcFYyNE01NGgrSURtWEFDamdEVEhrc3liWW5hbTZDSHpLSVFvWFE4OWIw?=
 =?utf-8?B?OGhmam52N3ZDcmRCczZOd2RuUUdLUTJHb3pjRFRlY0tHZGROeUh2UDFHb3dX?=
 =?utf-8?B?VWJBQ3RhWk9Vb3FzajBYSFBXZVpvT25LRGdiVWhkczRJb2pCd2wyL0xxdFRl?=
 =?utf-8?B?UWIxYTBVWmRCVDdZTHZoY2FRc0paRmg1SlpzZC9lQmlyMk5FSnVlMmJxZzdL?=
 =?utf-8?B?aG11d3F1UGJ1SVZSczJMMjlKTHlia2QwTUVwR3ZJemxJTXQrY1NEZ1lNWWR1?=
 =?utf-8?B?bUhFVEtxaFcxUjlYekNMRzlsNWVWbk82MUx4Q0djS1BvWnJEZUJjWi9EZHNs?=
 =?utf-8?B?N3hYWU1aRDNkKzRYY28yN1dEbE1FYWlmMDZOUVcvSkJNZDltU2hkQm9yaXhQ?=
 =?utf-8?B?MTJ0RHhxbWlFWkszd2d3WTJVZ0JMajZDQUZaQUN3azNLS2N1YXNkRVBiZ0d6?=
 =?utf-8?Q?gE0zp+fheIxMvnelYglRWlYYkYAcpaZXVRaE/ob?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f58f721-2036-41d3-5063-08d8d469482c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:59:52.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7poFz4EpDySX/rMgUwIIJnPMKEk07AsJrkDw4rKUbpMWjJsbYphyvZjECHzoA+FIqSXlHFjUrrvpcyRGbBdu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180203
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180202
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/17/21 11:35 AM, Peter Xu wrote:
> On Wed, Feb 10, 2021 at 04:03:20PM -0800, Mike Kravetz wrote:
>> Pagemap was only using the vma flag PM_SOFT_DIRTY for hugetlb vmas.
>> This is insufficient.  Check the individual pte entries.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  fs/proc/task_mmu.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 602e3a52884d..829b35016aaa 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1507,6 +1507,10 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>>  		flags |= PM_SOFT_DIRTY;
>>  
>>  	pte = huge_ptep_get(ptep);
>> +
>> +	if (huge_pte_soft_dirty(pte))
>> +		flags |= PM_SOFT_DIRTY;
> 
> Should this be put into pte_present() chunk below?  Since I feel like we'd need
> huge_pte_swp_soft_dirty() for !pte_present().  Say, _PAGE_SOFT_DIRTY and
> _PAGE_SWP_SOFT_DIRTY can be different.
> 

Yes this should be moved below, and it should check for both.

Thanks,
-- 
Mike Kravetz

>> +
>>  	if (pte_present(pte)) {
>>  		struct page *page = pte_page(pte);
>>  
>> -- 
>> 2.29.2
>>
> 
