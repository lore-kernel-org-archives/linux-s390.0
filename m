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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C8C433E0
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 22:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DFB64EB4
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBRW7f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:59:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49688 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBRW7c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Feb 2021 17:59:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMsuub109918;
        Thu, 18 Feb 2021 22:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bug/JRv/j0iKYVrdLcQWHRHUkefdQZwGyJpEi38gDhM=;
 b=ZXRf69Ej5tBpNpfJjbMS/z1hlvpILs/pb8rpCw9J3hujBgKcpY1TH59a+Agcaxbsb18j
 Zi7rChGKoQaDI0DYGIX3vbmlE5tu/XQ5LgsEVHmCunD7QiuboDC0Np4ZObXUDpq0lNAM
 +f4qxffm/1JkUnYT/Ac175Z1m2KZqVimIi0apUMyPO7zBF8Ed5ebaT0VwK6PHv3CH4Us
 JalTtDLeay4u8O9iP6FbESmasmZwjkl/0f9zgYh3hmmGq7tX5FSnROmKRLv+Bh9oFB7q
 HJlimSFLA4b1R6h0b4FWo/ZrVq9N0gkokgrThdbFemTy0E98hQyUst7N2gvFDczZboGq 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36pd9af5ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:58:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMuRr9006335;
        Thu, 18 Feb 2021 22:58:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 36prbrd0jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPJoeZoNUM2lO5KOjhgEkcSqfALXzNd3zW4PxXuEAR+hIuR7t8MTFYHN1oZcbONV1CMLX9WfPtZfBo0kAUrVVEC/cVWNOGCFwpwTM6wHCADVBuLnD/qhPz6CdKK+TpC/iwKvDGc76BAB8P4syYkaF+lIK7L6TGmD9rF0u0QoGUXmWE0B51tpRRf/K3WtvupHlnWcB5TICgn1jrVTuaU1PaB6zds89z3doeSKFuyDuNoYo1oO8IXAT1dMvfs0rR0Y+rKgn7aawK53iUis8z4nEEFHp5DxxuoyxVcccK4JGu2HBvoeikGr1p0FiZ+TbBZC8VvD7i6a+nbJQOyAiHwApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bug/JRv/j0iKYVrdLcQWHRHUkefdQZwGyJpEi38gDhM=;
 b=WiyxOKefdE3JUa5v+gNur9VEww8v9L56xh153JzC1Ouffkaw359fUz0SBrp5u1+bCxKoPSBEgegMcc1mBrublxh+4x3DQ6wGy+JqrHeYvAyzczTZC4ldDJWH1roJfLJpS4b717BxF/rwB7cIZQerKnbO3PLBu2gh4cmWDrFcRASOU/WPnkQ6eT1jb1EDcquCGev3OHkLi1M4FPRjiNR2mktlXEYWRR3fPf/92l8mEebOxj/3TLZa9PbDKDhHh+Zi/PEQxbffrm0ElETjSd3LTcxrE8DqwNj1AcvaFeIzhYZYGKUUT9mm7yseAfKy+UDCmGy5YD0TxK0fTGp0bOCG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bug/JRv/j0iKYVrdLcQWHRHUkefdQZwGyJpEi38gDhM=;
 b=VsXmPc/aHNDQ/RBFp/mNsZCKpQ6wzQmH6v/bl10HHLCah9j/CqE5qXEgWjZ1ByDa04NeLEVMSk1zfZYLmExkAvwgLvw10oBobVI/zq01gAVO8J2KIT4ECtiSut4fYs4T19O8UvWVlwbMdBT/n23+em/h6PR+x0PosyAteSvqnwM=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 18 Feb
 2021 22:58:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 22:58:34 +0000
Subject: Re: [RFC PATCH 1/5] hugetlb: add hugetlb helpers for soft dirty
 support
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
 <20210211000322.159437-2-mike.kravetz@oracle.com>
 <20210217162415.GA6519@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b884e37c-dd0c-a77b-962d-d8db0b0f2bdc@oracle.com>
Date:   Thu, 18 Feb 2021 14:58:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217162415.GA6519@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR19CA0019.namprd19.prod.outlook.com (2603:10b6:300:d4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 22:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fd2a06-4798-480c-7b26-08d8d460b7c1
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-Microsoft-Antispam-PRVS: <BY5PR10MB411491DB85D1AAD5B611B01DE2859@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsBKarsWFJ+vyBiOZieM8Js2O5QCAGnukObL23kCsm7+jEO7oV48mTC2jPD/vALZY7ZjN9p0y2uSERaYk1aAqqQOuauekOQDS7JWlfGb5Tn6fA/rvkiGkgOuKHZ4hIJqDdD8D64ELLRRtdeIfZpI/i3VgSFqEvZK+OOd9BkX4z3IzEFCY/5i7pu41xGP1sfXd+GxVFzxcQgEv0s72BjmhC083RGQJmVuP/9zthp2nf9puWisIffTr16Y0m/i+z2sQZ3/AwekMNvVD+71AgZYLh9QE00eSMu3b39mRoDv89Y4Q365oDxX+fL5rq9wHwYkK3xOG/MvGoFM56dj5t7laahqQspLTU+Y7TDWBCG7F0oHD6igG1uyLjQIyaa8oaJVN0XEuaQ8b0DF7yVozeN0RBAKacukiOnbC1C6c7ck8nhndcNx5ntg3YLBCXftNkf84H7wnG/iWQ6Z1zaqg/hScYQ2CqjvP3Y4CekWZ9hHZHs/49m6maSLhmDz5IIYagd4EjcPu0PgSe4gdFHID5aGrRhrPi8Qbt11T7qPookhRdb1PEkHAklDU8loLlRQyMln9JVLT6ncacHQflRWs5515bH7Y0kwnsHG4IfWraPTjYCQg3x0+exxz7VrsV4ycV+O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(86362001)(16576012)(66556008)(52116002)(316002)(66946007)(36756003)(44832011)(186003)(6916009)(7416002)(4326008)(478600001)(6486002)(8676002)(66476007)(31686004)(26005)(8936002)(956004)(53546011)(16526019)(83380400001)(2906002)(2616005)(31696002)(54906003)(5660300002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3NadlVvVjZTUFovck14ZDFsak44SVlSYUhIR3RRbmNMYmVON1g1K3k5Y29i?=
 =?utf-8?B?NWllcTllMU9vem9RM3RtTVRUMkxnNEVkODI2RTA5dW90bXpIMHd0OEpMK2d0?=
 =?utf-8?B?Sm9ZdjN1b3YwOGM4TEpHVFp5UkUybG1LaDl2dnJyeVZXMGE1MVNjN0J3dHpn?=
 =?utf-8?B?QjJQMnR1RUVad0pRM1dXaitHQzNVK1dMTnI1SC9DL2doNEdZYjlpMUNUOFNF?=
 =?utf-8?B?dnFEMXhqR3c3RXk2QkkxZU0xTGswamR0OTJUR2lNbThCRGY3eG9vNWRsSnBK?=
 =?utf-8?B?NVgzckQrd0cwbDUxOCtTVHhvcEZvalhjemoySTBnZ245a2dDTjh3RW5FT1lt?=
 =?utf-8?B?MnZFWTdmUVZwN3dobXlPczltdjQwYjR3YU01WjQrMGUyeXlaS2ZJZFBKclIw?=
 =?utf-8?B?WHpsSkNlREpHWWl0V1owM1hEQmxJeWxMQTNzK09YT1N4YndzRDJyRzkvb1hY?=
 =?utf-8?B?QnVhbi9MMzA5UGRJTXVYTENOcDVoMnVxYVRMbHN1dkZaNG9BdXcwOGRpOUFF?=
 =?utf-8?B?YWpyM0VPSlUyM1RhQ2EzVU5RS09xcnovTys5ZlBsUDJMUGlEL0NOK3YzaGVI?=
 =?utf-8?B?cHdMaGZtZ1pUeFl1ZUkrN0Z3N2dsVWF5anhZN3NDOVo3S1Bwdk51QzVSRDRO?=
 =?utf-8?B?OEllQ3g4dlMvd25nNEpnREhVUmczdFFiOW9lMFVPaHpUdTlvalRJRi90MEow?=
 =?utf-8?B?RWlKbU8vVWZ1b2NXOWlMS0hsdGRQTUZUT1VRdmFuOWRQYW5McldFVmVHR282?=
 =?utf-8?B?WGtsS2FucjQ4N0lXU05xRzBCMWU1VmpvaGZFby9Pb0QwdU5DTnBXaU9uaHVL?=
 =?utf-8?B?OXVjZWhyL0NFYkcrbjZnSXg5VU5EQlUrK1ByL0hjSnBiVlYvQWxrTEFBanRM?=
 =?utf-8?B?OWdGNU1mZExkS0dRRXZiTXZ5dUIyRE1YZzlMWmJNbUx0UmxhaStFYXJwdFlD?=
 =?utf-8?B?cHlXc3g5ZVNGYkx5TFlwc3hvTzhKQk1VaS9rNlYwMkFBaUJTM3I2UEVyTWdC?=
 =?utf-8?B?aGxMYTdUdmszeGRSUVdYM016ZUUwQXVnV2t5bndpQkluQkJCRDF1MS8vR2tu?=
 =?utf-8?B?ZXlKK2JqYXVGeEd6RHBNUE1LdUFscHhKNmpSMTJlOHR3b015WDBVeFAwZndo?=
 =?utf-8?B?N3IreEFHK3gwa1JRcmxVT2Nrc1JydXZNZkFOSmVhajJ4clJBanhpSDVGVlFt?=
 =?utf-8?B?OUNGMTdBQ1VGY0pndytWVnpWL3MwUWI5WGVoSFRyMy9idThtVnJ0Yjlqa3Zt?=
 =?utf-8?B?dFRYMk5UWXJwS08rTUlEMjZ1aGFnVVNxTjFETU5LblNGUGxtTGxlZVZWM0VQ?=
 =?utf-8?B?T3ZvSklqZ3ZTSVN1SGltNkpFUmhGOC9nVkhtS3ZzZ3o3Q09KNC8xa215UWpk?=
 =?utf-8?B?TVBlbEtWZms4SGlaTGVaSU9ROVA4MGFvMXFFdS9IeGJ2RFM3b0I3NTdkTGxX?=
 =?utf-8?B?UjB0L2lUSGRmMllHaXJwRktwdE9hT0Q5OWRQc0txUVh0Um5FOHFxbmZPT1Nk?=
 =?utf-8?B?WHdsSExFNWs5YXVqMHRXWmgvSTF4TVppbXliajBvT3o3SWJnWVdrVDB5V0w3?=
 =?utf-8?B?ellwbVkwL1haWFhiV25ZZk1lak85NGQwYStLSkhRS1BGUG9YN0w5eFFTcFov?=
 =?utf-8?B?dWs3bWJBYk1IOEQwc2hiaXBTNkJQQUlRR25YQnRrUHNiS09vNXRiYk52aW5U?=
 =?utf-8?B?cFRIc2VuQUtmVlBrYytYY1d5Zm1BNjRPVmxPVlNiNFNvOVFhdi9XWXl0RVJY?=
 =?utf-8?Q?hJWq5Qc5T5O2AL+ul3dFDDhBcYjts3yBw7vJutQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fd2a06-4798-480c-7b26-08d8d460b7c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 22:58:34.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLO3QmBU2xaNSN1b+hHlShBsc8z3xCEfuNhOyjS1Hhgi66jhOXRLxw1VKPdbgB67elMN+JP4JY+QpsCbaAHHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180192
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180191
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/17/21 8:24 AM, Peter Xu wrote:
> On Wed, Feb 10, 2021 at 04:03:18PM -0800, Mike Kravetz wrote:
>> Add interfaces to set and clear soft dirty in hugetlb ptes.  Make
>> hugetlb interfaces needed for /proc clear_refs available outside
>> hugetlb.c.
>>
>> arch/s390 has it's own version of most routines in asm-generic/hugetlb.h,
>> so add new routines there as well.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  arch/s390/include/asm/hugetlb.h | 30 ++++++++++++++++++++++++++++++
>>  include/asm-generic/hugetlb.h   | 30 ++++++++++++++++++++++++++++++
>>  include/linux/hugetlb.h         |  1 +
>>  mm/hugetlb.c                    | 10 +---------
>>  4 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
>> index 60f9241e5e4a..b7d26248fb1c 100644
>> --- a/arch/s390/include/asm/hugetlb.h
>> +++ b/arch/s390/include/asm/hugetlb.h
>> @@ -105,6 +105,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
>>  	return pte_mkdirty(pte);
>>  }
>>  
>> +static inline pte_t huge_pte_mkyoung(pte_t pte)
>> +{
>> +	return pte_mkyoung(pte);
>> +}
>> +
>>  static inline pte_t huge_pte_wrprotect(pte_t pte)
>>  {
>>  	return pte_wrprotect(pte);
>> @@ -115,9 +120,34 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>>  	return pte_modify(pte, newprot);
>>  }
>>  
>> +static inline bool huge_pte_soft_dirty(pte_t pte)
>> +{
>> +	return pte_soft_dirty(pte);
>> +}
>> +
>> +static inline pte_t huge_pte_clear_soft_dirty(pte_t pte)
>> +{
>> +	return pte_clear_soft_dirty(pte);
>> +}
>> +
>> +static inline pte_t huge_pte_swp_clear_soft_dirty(pte_t pte)
>> +{
>> +	return pte_swp_clear_soft_dirty(pte);
>> +}
>> +
> 
> Indeed asm/hugetlb.h of s390 didn't include asm-generic/hugetlb.h as what was
> normally done by asm/hugetlb.h of other archs.  Do you know why it's special?
> E.g. huge_pte_wrprotect() of s390 version is actually the same of the default
> version.
> 
> When I looked at the huge_pte_wrprotect() I also see that there seems to have
> no real user of __HAVE_ARCH_HUGE_PTE_WRPROTECT.  Not sure whether it can be
> dropped.  My gut feeling is that s390 should also include asm-generic/hugetlb.h
> but only redefine the helper only if necessary, since I see no point defining
> the same helper multiple times.

I do not know why s390 is special in this way.  However, I did cc some s390
people and the list.  Perhaps they know?

> 
>>  static inline bool gigantic_page_runtime_supported(void)
>>  {
>>  	return true;
>>  }
>>  
>> +#if !defined(__HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE) && !defined(MODULE)
>> +#include <asm/tlbflush.h>
>> +
>> +static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
>> +					unsigned long start, unsigned long end)
>> +{
>> +	flush_tlb_range(vma, start, end);
>> +}
>> +#endif
> 
> Similar question here, only ppc defined __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE, so
> IIUC it means s390 should simply use the default version, and it'll be great if
> we don't need to redefine it here.

Actually, your patch "mm/hugetlb: Move flush_hugetlb_tlb_range() into
hugetlb.h" makes this change unnecessary.  But, the question about ppc
remains.
-- 
Mike Kravetz
