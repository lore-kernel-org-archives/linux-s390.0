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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651BFC433DB
	for <linux-s390@archiver.kernel.org>; Fri, 19 Feb 2021 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102F064EB4
	for <linux-s390@archiver.kernel.org>; Fri, 19 Feb 2021 00:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSAPf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:15:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSAPe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Feb 2021 19:15:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J0EYWP041818;
        Fri, 19 Feb 2021 00:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JLPUdcOo/RAAH1k96SIt6pJu/lMdTbtjzkHGz8xWsmY=;
 b=oGxgyd/Ym90V/F9jgp4HGSNqBOa+SFHzLciRzXfD6lcPgq33AFPgAASVl91MHQsGjTXr
 0g6IPqkbGC6ZMk0GdMf6zIsl/zLG/PFgYR2C6eD88rDuFmMAmNslAZXg1YY+ctIqLOHR
 TP9YED1+B+wGCgBx5Zf/FDqL2mv30MhTQ/aZGxygntzjWgCI8dzq6DbFvZo4qBVu+MJj
 cTRoDnd2do+yjAxybjrvhB+VGf8DcjOE2edq15OOI9SmMlcox345P0rnbBosFUGSE63w
 Z2FqKjjf0bm/WaG+RYpD16lJhCDtAOVUprVOdLWfK4QMRx8y/76mYErQgeHa2ZPGMNFu RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9af9m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 00:14:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J09ilq082814;
        Fri, 19 Feb 2021 00:14:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 36prhuxp6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 00:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ+kLJfFTo7LLhlbURbJ5Eg4E1P4esderAQ07H5S7vAHG6FCId8ZerQ99q7afZgsFu6WrWhph7AkzEaLsKdSUqWF7GhEWFqcoLbwtVQslvcKAHxt2l9UqDtcxKXxK641BBWNU9OhJIbJxf6kbLrObyGODQIcTQXt5MMoVfbM9VsTZKVr/zBeQ725GXNCwLd8/NxabByWCBX8TLhKjxhpSkByMynWOdSEOG+gAjdZXbqsedOOeGQXH4B9VcWhaBGw1sikK0yUgKqOorggHtW35dRK6RL9WcjGg4Jq4rM6yHep5yUuPgpo2BepBZlC6Q3aEP0HTFuYiDmz2YibzT/mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLPUdcOo/RAAH1k96SIt6pJu/lMdTbtjzkHGz8xWsmY=;
 b=iqordXvm3mR82DdwvhakTGQqO4QkfFddgB/z13Cbl1fMb3IspT1OuEj3FUz9C5yUPQ3L4B+2/RCajYlJj40EgeQwMMAFBjOT5OatUC9/l78UV2WLrFItZl1CnPWLeZ5NYjPwbknuccDlocw6nspEjBJ+Aied1MEhoSmQZxxlgqxux6IRN+B42QQiNxSicQGcQiVcPJT3wX0Riy+uKmIG/QNTR0Tgjuz1b3erwsY262eCpvZG/SgQfSMZSWUcZxeDZFhOf2oTBoxdpNu9PnNp58+DgVbaUo3p77p3IgDJft0CdQ+FnALLLy7fkF4SXnb0h1xj9RcwvkorQY4LcrL9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLPUdcOo/RAAH1k96SIt6pJu/lMdTbtjzkHGz8xWsmY=;
 b=O3O1M4qAKm0mekOHAHwVzX9WpbknNw6lXeoFS1uKYtfr0gQVVgJv/JpzE5dWbL7kM64DZD/uswlpuskE9uWvxt/jouoUhn/BTDTBBDpGqyqh4MTNt10roWktCP61Gxm9shkZrXZyRJAtx0xm4yso1hHiZnPW/3c2CdACnl33drs=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 00:14:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 00:14:32 +0000
Subject: Re: [RFC PATCH 5/5] mm proc/task_mmu.c: add hugetlb specific routine
 for clear_refs
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
 <20210211000322.159437-6-mike.kravetz@oracle.com>
 <20210217202518.GA19238@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c356f931-8400-b3c8-73b0-2537815d7a6b@oracle.com>
Date:   Thu, 18 Feb 2021 16:14:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217202518.GA19238@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:300:6c::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR04CA0056.namprd04.prod.outlook.com (2603:10b6:300:6c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Fri, 19 Feb 2021 00:14:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ca4e845-d90d-4bb1-8d0c-08d8d46b5501
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41155E83882895E95488CF62E2849@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlA2IyYzv9ZRDVj497wY9l4i18lsN4V/rSrmLUTBd8Ccthhqm4YE7V85MvpaGrkssJgHKJOo7k5p3XZU1Vtyu7Po+GtheFinBchi/BXtF8S1SEugM2UfRnCmxhghTFPCmfoo+jjFZZAUTDNIMmz9HPkTbusMf73GYuqFetGpKxjqP17j2nucYaAKtRRvKigvBG0q4nqJtHmgxJnukHxjxTuhFxtI7cZ3eIXZkPna9ixq69M8gDyRMZeDur/6CKgV1wgMDMkO/svJMEwhEIbCufr/ZGbevg6PE8TsCuLnvhRaW1gtR7Q38nitPo4UJ0Za6cV8ui8ue7wMWaaCTdTKejk/ZiesKWyN660bj5ar3jA1/pzUZJY5gzArixT00l3dUiMnu+JPCxDaVQUxUFoYNyinWfXjiG+bYbK49QMWw7ytp5WYkzNEFBFxJF4UhNCkGJ4GwWQxxV3bUHNZk2Xgxsl79PnfT59G57UN2kbA7baC1a8suUgUGTQCWSQp5bYVBSf+nVHxYImJqa/j5sUFXqIU/n/KCDu7Z+FMue5mbEWOGpkmapsdtN1dkEbGeI16KvQb3tEfr9Ojmu+qmC487AXd9+DTit2izAWgpItWEiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(54906003)(186003)(956004)(31696002)(44832011)(66946007)(36756003)(26005)(86362001)(66476007)(478600001)(7416002)(16526019)(52116002)(6916009)(8676002)(2616005)(2906002)(6486002)(316002)(66556008)(16576012)(31686004)(8936002)(4326008)(83380400001)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MEhBOEdNUFhpR2FpOFpBYTcyamIxY2VNZnpCM3BxYVJvMVVNUnlHY1NGYzVV?=
 =?utf-8?B?R3RzMUo1K1pXNHF0cXZUSE5OZnN0cnRiaC9MM0ZvZDJobW5hNjJGVk00ODlt?=
 =?utf-8?B?YXBTeWNKOFh1a0ZOL0xxWEhwb0xmMDRRWmcwVVpud3RqZGpJYmY1aG1KZlpY?=
 =?utf-8?B?bDZ0SEhOL0dWSGZGb1N0UFlxYWhEV1p1QVRBakxJZkhEYWFGUjhzZmJsbkdX?=
 =?utf-8?B?VzcyanlxUklySnd5MTkxUU5CUlNPbW9rZFV3MmRmc0dpdnNkeVFpV1NiZDRv?=
 =?utf-8?B?MGlEL09MYXk5WDdRNk1Uckg4YjBKcTBUd2lLbUwvWUsrV0NqanVyTjVITGJr?=
 =?utf-8?B?NWxaVlZ5OXRuK2JFcXlpVWIrRDMxWVVuWXhUK0RhRUR5YU4ybi83NmI2aHcw?=
 =?utf-8?B?NWNlNWlwdVo2dHNWMEFQcEx6dmtoWnErSUEva2hUSExXUldpbW9PdTBWQ1Ur?=
 =?utf-8?B?aWkxakFDNG1CNkhlT0MxYXRvdStaakE1M3VlRHpXZ3FkY1ZqMUMrejRNYlVp?=
 =?utf-8?B?cEs2WTJ5bXlGZzJyN2hjMkFMMVYyL0RNUXZ0QkV1MUkyTERQVzdrclp3YU1G?=
 =?utf-8?B?dGgzbjZyblBsZWJsM0pTVEZROGt2TThUcHhXUUhrZWZ0WXFsM3NOREw2a25P?=
 =?utf-8?B?cWRZWDlpWDNhcE5GU2ZRUDZqbnlZWTE0cVY3SDZsOHZ0MTBOVzlyOTlIbDhM?=
 =?utf-8?B?Ry9PR2sySWVGRGtsTmxJODVIaUxjNlFzSmtmV0VSK1FOMzdnUWREU0xnV3Ro?=
 =?utf-8?B?eEdDNUx5THVhSnk3YzZDQ3RBMWhWdnd5Ny85ZXBkemMvQ3lxY1hURkpPZGg3?=
 =?utf-8?B?UnJHNksrZUtxdkxMeWJ2K3docXFEdWliT2gzWnFYMlE2dVhwTE5ENU9ybVRE?=
 =?utf-8?B?NEJ2YVRINktBaDR3SmlUUkl6aUkxS0ZsdG5XQWxMdytkRkNWcytXaURVU2xY?=
 =?utf-8?B?aXRYN2dtRmdTY3NFSFNXNWtpNWYzaFpIOS9ZMUFGQjVQWEhUVGw3ZmxrQ1Ju?=
 =?utf-8?B?VlpjZHR5MjR1YXA3VFJnODBlcWExR0R6cngreEMzY1ZoanR5TVlrcUoyRFpJ?=
 =?utf-8?B?a3M0U2tUYldhc2RVTy8zM1hiRTdXSXFJdzlFOGRZWlJUS1VQNnR3TjFKWnM0?=
 =?utf-8?B?WW5qeTNpVnJQR1QyVUpub0VLZXJjV05EQklQd3BKb3kreGlVZUpXSFBuTXdl?=
 =?utf-8?B?eHJnNTJaUGwzU1lDWWRhTUpGeGhTVlRySDBiSk1UWktYU2MzY3dORDVOVFdy?=
 =?utf-8?B?eFFvQVVzUnRUeWE1cUdVWHBNQmt2cWpvTzBGdUs4OXdsd2hFMys5cVFBNjRL?=
 =?utf-8?B?eVV2WXNWUWVvNTRBbXdSZTFuSzJFMWJvM0dKUG4wN0ZsNHU0ampidHJaMEFP?=
 =?utf-8?B?bkF6WklEZCtNY3AycjFHYTdDaUxDK0hnd3U0bU1aa3p3aStBYTRLUy8rK3M0?=
 =?utf-8?B?NHNxRmRwYnoxTHo2bk5PMnU2eGVDTzFRSWF5bVlIRHNZSE4yTlk2TlNEbWRT?=
 =?utf-8?B?bm4rYTlDanh2NFMwVXQzZTNBMmdoWlJNNDg5UTA2MWZ1Y3NkeE1wZUZvbHg0?=
 =?utf-8?B?MmZwQW9IeGxTZlM5U1dzUmNCS05YOTBPUU9PY3NhWUJKNlJJalJNTTZMSGIv?=
 =?utf-8?B?b3hyYmNhV0g2bjJ0QU1JZDZ3Zy81ZUI2eGFkdmlOOUFvc2JKYkdndjJ3dGFx?=
 =?utf-8?B?Tmh1aVlDOXN4WGJBVzlERldGUU15WHlNMEcxd0wxYlhFZ3A5N2pseUFtV01y?=
 =?utf-8?Q?yYpRdKuG9j7gE6Q211NyHz61Bm+zwFVVnNSgTtc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca4e845-d90d-4bb1-8d0c-08d8d46b5501
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 00:14:32.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5hm2z0Vq2TC3DVYaBfXttw+zDzW3K2u48XYFpIOjt4yIXA581cbSIJ+95B18cE7Uf1AEY81cGWKAbOQ/rk8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190000
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/17/21 12:25 PM, Peter Xu wrote:
> On Wed, Feb 10, 2021 at 04:03:22PM -0800, Mike Kravetz wrote:
>> There was is no hugetlb specific routine for clearing soft dirty and
>> other referrences.  The 'default' routines would only clear the
>> VM_SOFTDIRTY flag in the vma.
>>
>> Add new routine specifically for hugetlb vmas.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  fs/proc/task_mmu.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 110 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 829b35016aaa..f06cf9b131a8 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1116,6 +1116,115 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static inline bool huge_pte_is_pinned(struct vm_area_struct *vma,
>> +					unsigned long addr, pte_t pte)
>> +{
>> +	struct page *page;
>> +
>> +	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
>> +		return false;
>> +	page = pte_page(pte);
>> +	if (!page)
>> +		return false;
>> +	return page_maybe_dma_pinned(page);
>> +}
>> +
>> +static int clear_refs_hugetlb_range(pte_t *ptep, unsigned long hmask,
>> +				unsigned long addr, unsigned long end,
>> +				struct mm_walk *walk)
>> +{
>> +	struct clear_refs_private *cp = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	struct hstate *h = hstate_vma(walk->vma);
>> +	unsigned long adj_start = addr, adj_end = end;
>> +	spinlock_t *ptl;
>> +	pte_t old_pte, pte;
>> +
>> +	/*
>> +	 * clear_refs should only operate on complete vmas.  Therefore,
>> +	 * values passed here should be huge page aligned and huge page
>> +	 * size in length.  Quick validation before taking any action in
>> +	 * case upstream code is changed.
>> +	 */
>> +	if ((addr & hmask) != addr || end - addr != huge_page_size(h)) {
>> +		WARN_ONCE(1, "%s passed unaligned address\n", __func__);
>> +		return 1;
>> +	}
> 
> I wouldn't worry too much on the interface change - The one who will change the
> interface should guarantee all existing hooks will still work, isn't it? :)

Yeah, I can drop this.

> It's slightly confusing to me on why "clear_refs should only operate on
> complete vmas" is related to the check, though.

Mostly me thinking that since it is operating on complete (hugetlb) vma,
then we know vms is huge page aligned and a multiple of huge page in size.
So, all passed addressed should be huge page aligned as well.

> 
>> +
>> +	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, ptep);
>> +
>> +	/* Soft dirty and pmd sharing do not mix */
> 
> Right, this seems to be a placeholder for unsharing code.

Sorry, comment was left over from earlier code.  Unsharing is actually
done below, I forgot to remove comment.

> Though maybe we can do that earlier in pre_vma() hook?  That should be per-vma
> rather than handling one specific huge page here, hence more efficient imho.

Yes, let me look into that.  The code below is certianly not the most
efficient.

> this reminded me that I should also better move hugetlb_unshare_all_pmds() of
> my other patch into hugetlb.c, so that this code can call it.  Currently it's a
> static function in userfaultfd.c.
> 
>> +
>> +	pte = huge_ptep_get(ptep);
>> +	if (!pte_present(pte))
>> +		goto out;
>> +	if (unlikely(is_hugetlb_entry_hwpoisoned(pte)))
>> +		goto out;
>> +
>> +	if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
> 
> Maybe move this check into clear_refs_test_walk()?  We can bail out earlier if:
> 
>       (is_vm_hugetlb_page(vma) && (type != CLEAR_REFS_SOFT_DIRTY))
> 

Yes, we can do that.  I was patterning this after the other 'clear_refs'
routines.  But, they can clear things besides soft dirty.  Since soft
dirty is the only thing handled for hugetlb, we can bail earlier.

>> +		if (huge_pte_is_pinned(vma, addr, pte))
>> +			goto out;
> 
> Out of topic of this patchset, but it's definitely a pity that we can't track
> soft dirty for pinned pages.  Currently the assumption of the pte code path is:
> "if this page can be DMA written then we won't know whether data changed after
> all, then tracking dirty is meaningless", however that's prone to change when
> new hardwares coming, say, IOMMU could start to trap DMA writes already.
> 
> But again that's another story.. and we should just follow what we do with
> non-hugetlbfs for sure here, until some day if we'd like to revive soft dirty
> tracking with pinned pages.
> 
>> +
>> +		/*
>> +		 * soft dirty and pmd sharing do not work together as
>> +		 * per-process is tracked in ptes, and pmd sharing allows
>> +		 * processed to share ptes.  We unshare any pmds here.
>> +		 */
>> +		adjust_range_if_pmd_sharing_possible(vma, &adj_start, &adj_end);
> 
> Ideally when reach here, huge pmd sharing won't ever exist, right?  Then do we
> still need to adjust the range at all?

Right, we should be able to do it earlier.

Thanks again for taking a look at this.
-- 
Mike Kravetz

> 
> Thanks,
> 
