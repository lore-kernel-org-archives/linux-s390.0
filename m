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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865EDC433E0
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A59464DF0
	for <linux-s390@archiver.kernel.org>; Thu, 18 Feb 2021 23:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBRX2H (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:28:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhBRX1y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Feb 2021 18:27:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11INOGp0098729;
        Thu, 18 Feb 2021 23:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+JCqzHzb3Qw19LnzdqBw1UafvHBO4nTBMsve/2xwxRM=;
 b=WGEV/mkOTc37/lJgnbd4VI9WeXfWK7tJpOhvSRkzqkXcps7KQ3LryP3kwq9t5X0aNV7J
 EWXc07uCIGInPbgicw2jYf5lSSe0d9u5kjCfauIDjxUCFznwyCZ2EnfpsMJnlyXjJgWX
 VwXyIs271i7rYP9V4rOKBqpsTuN7cYdEaVods264yVYR2buUj3R5yzeggasHyzcPXorh
 kjjpo+erNGmmw64HXKnU5ehq+WnYlUpbPj/1PhGn4EbOVHf0S1zgwrrfs6fd+P6EDLGJ
 mMUne1j0gMUUsTvQnu016qD6YlIwjo4+XjVMjxPUwOxfNJ6rpxyU3Kk9b4uMJBTQv4g4 ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36p7dnqm8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 23:26:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11INQB4O050674;
        Thu, 18 Feb 2021 23:26:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 36prq156d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 23:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt/0G8pU0q26Eagm2KkW/l7I+rLR2nzwtpDTsXdhgJDk4VMpSy6SkOLW374ohI2YQiys3dC657plQlTZ39RlX0qRW7LhTdI7OAYV0eey5J3xYBQU07oUhiK2sFA6mQpV9blE9rQjX93Einkb9loR6HUVBtT7bpQypHD1GrYItosrfF4H/jZhZ2rW2yfjhcdz1rtanxH3Bc4u7NM98eR42+EpLw0DPzQkdM7CNaVZI46qXgwLzuWgb13o46662oQsYBxeDQrEMdt+mhKKtJvb3WITCjtbuSCJkEWkPnEvmRnh9cPKZMiptAkE7E5Je5oIcnVnFj5gfkF4DCg1grqOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JCqzHzb3Qw19LnzdqBw1UafvHBO4nTBMsve/2xwxRM=;
 b=TSm2NG43jHmwVAj/cDxRLxutFVshFRZYpqEXyqXaKICQbICoUHc4/5m8gL66rx77FRURlDjH9oPg1wzbG4PdRIgp5goFecTszZ7sCwUPqKMjIvoNosrD84cfdWWnSXdhAsnojzwFAKoTKM7r21uTbpfRL7QGWTFw3SouAcMv0Owlhgn30LaPgfh8BLebEMDv8LO7IUtQzjXc320B0/Bp3tHS2MvS+EELeQxA+ByUgOyfNpG00taulxid5V7McnSSxLfDcwzoirHjv6uV0rKxaaBdJHIk3qvVC2Ygh2Qc5JfUX4tphN++0zd6nKHTTn9SjlzZRj18iqqAPAeix49cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JCqzHzb3Qw19LnzdqBw1UafvHBO4nTBMsve/2xwxRM=;
 b=mf8XWWcYRF5k1ZYWFLyQ+Amf/qqMWLo8tAY+8Nk2PHBm4EU3W6bekHLX5YMlGlPtP0XtBSCu7BVIUqGIGxK7yGesHDS00U/hN9aLa8jtgd8jKFaVlu9CfSDAzixKR95w8XkTwRHROxfOEOTrkRA4vu3g5dUR7imye61NqKoV0iM=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 23:26:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 23:26:55 +0000
Subject: Re: [RFC PATCH 2/5] hugetlb: enhance hugetlb fault processing to
 support soft dirty
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
 <20210211000322.159437-3-mike.kravetz@oracle.com>
 <20210217193233.GB6519@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1a1e5bac-a272-384b-9389-df0b3cccba4b@oracle.com>
Date:   Thu, 18 Feb 2021 15:26:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217193233.GB6519@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:26:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51351baf-c562-4bd8-7333-08d8d464adfc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4592:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4592BCC1965AB54D3DACC9DFE2859@SJ0PR10MB4592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K758QNTpNLAcbM/uEWjnquPrWEyTP7DzeLOrDY7kocmspSgGe71xGcWmuilQh6b4YjRvURVbWp/nhNISRnzqhRKbO3qikncX92stItwb+zXbRdudVhGw1xg6ihGoK6kbISbKGN3FvyB95IFeXxq8ftexQPScYHbz8O/NyVlKma3ofkTKYBuAtqF03enNejiw6dugLGKoTAKsj0onZsaZpOYAcrMuCgwwCxd2df3V0oUZhMEP0mZbb0CAcHa9/FxPo1YJ/5mIxc8pSabfyj+Q0SsWSWirJGlPvy6t0lkozo5PaaKu/A+17jwHg+1JnQm0cKzs9RyILRFc9nlaqIS5jpVPDLpajgirmMDLMdPb36Jp8N7zhSsDOJAUeNxnwR9WIXfXuCNXUYepQzll3tGI5kCrkcaIs9rWVd9z19ZwCxt0jWhIGLoZ4JAGUIb0YqbRA31QMc2smvHinMrWUY93pL7bFAi7rMg/XBMI/jL1ymVgvsN9Gv7zpVSJ0AhWr9DMz9eeNsBdVdN3nagohNwYZ69PM9aY6wnkpvuCc3Kf6/UcIAQpdTFnkxiId5miVCgDFPRehWsktBHCDPql0nCHGTDFcajlKe+ty2HGci1r8m/b8H3+GVcw7pvP7eb6NjnP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39860400002)(44832011)(31686004)(4326008)(16526019)(83380400001)(26005)(54906003)(86362001)(31696002)(2616005)(2906002)(8936002)(8676002)(66946007)(186003)(53546011)(5660300002)(66476007)(36756003)(52116002)(6916009)(66556008)(316002)(16576012)(7416002)(478600001)(6486002)(956004)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amVlWElNQzVrR3BsU0ZCZlRhYjVlR2RTS0VMYVdFa2tMenBUNklEcUNMNEcw?=
 =?utf-8?B?K3hnK1lTWW50bStnNzl1MTA1R0dEWElYcEQ4RncvOGRaU2wyUmN5ZFl5US9H?=
 =?utf-8?B?aHM0VDhHWEcxdDZiNlhGTFhWSWZ1N2V2Uk04NW11M0gwMkpLdEo4c3J0aVRX?=
 =?utf-8?B?UitaUDRTT0xOSElXZ205YmlkRU9GaGlpUmRVbmlOZUZRcURha1A4MUVPRmJ5?=
 =?utf-8?B?UHdLUlJycVNQbDM5Sy9Dd0xaRUgyVGgzVHBZTTU1Y0puai91VndldmFTUVNo?=
 =?utf-8?B?amxXbkMycEZKWU9GTG9GRkk5SlE0OGpLc0wzaUJUOEJ6bnhwN0tPOURYa1R4?=
 =?utf-8?B?b01HTXhuR3JKV0NwVERVU3NMU3lDMUVSUDEreUJDc3pEdEl1UnIvaTM3Rnls?=
 =?utf-8?B?WGxaSmFzam1ITDhzT1ZSMUtnazFxMHplN0tPMGdoTWNIY1I5QzhyelU0WTJa?=
 =?utf-8?B?a3JPVS82SW53ODNnaHRGNlU5eTAyM2t5QXBpdnBPZi9WNVlNdktkN2VVZTFD?=
 =?utf-8?B?U0E5OWMzTzFRaUQ1V3B3ZEFLMmtuS09DWUYvNVVWd2tiSGovbENWUnJWTnRK?=
 =?utf-8?B?ei9VU1NyUldwd3BrSUlUejl4RG9JdG1vWFRTSEJhWG4zanp3NHlJNUdCMnR1?=
 =?utf-8?B?akpJUmlaTmVtRFd3S3h6OGQ3WnF5UDJyTnp1ZnhScFZ2aEcwSmt1dkpMdkZ2?=
 =?utf-8?B?V0N1SlpNVjI0dStOUllrREd3dnU5TUs4NG9FcmRkdE5iY1ZDYjNNRjAwRmo1?=
 =?utf-8?B?eDFLUUxvSWhZNmQ5TStFYnQyckFsRXd0TXg5TVE5R2JpQmZGL28xczBiK1oy?=
 =?utf-8?B?THVVMHRkUmkzTWJHMUR5UHAxYVZVVDJqa3FUcFFGOGNobWRjNlBGYXorMDNS?=
 =?utf-8?B?MkV2ci9SMjZnMFl1Zi9DakRWbUtKbEVkQjlra2VMNjZvZ0J5VzZvRElwYnVv?=
 =?utf-8?B?UnZCRXhJa2I0cDI1ZW5yS2owM1lEcDNhenNVU3YyaTRuS2VxVDVYM0FWR1BS?=
 =?utf-8?B?SWFhbGE4TTVEYU5zUG4yQVZZOEJGQjIxM2Yrd0pSQTk5cHZlMWZTU21DYzJH?=
 =?utf-8?B?Nm1aZ3JqMVhXUlpRK21LWHhSbTBlUHNTblA0anRUMVhSSVV0OWZIZHBPTkly?=
 =?utf-8?B?OUtCeWtCMVhwdkVzUWF3cWVRRldiSHlzU3A2Sm1acFlSK3FLMGJhOGkrcUg1?=
 =?utf-8?B?TTZBMlhjWlNCK1FYT29rSkhZNVdYaVJzWGkvZEZDV1NzNFlhSnJ4Szk1T1U2?=
 =?utf-8?B?Ylo0aFlFNmRFMnZ1aDhwc0F3T2NGR1I5VlFhRkRPUllVancyZU10clZQQzJk?=
 =?utf-8?B?Q0crenlud01JWmJKZ0twd2hXMG1vZCtQckU2Wk9uRUpxVGN6NmRRNlRscXVG?=
 =?utf-8?B?UXEvMUx0bUdoVHpqZlpoa3BvTEFNbGx5cjBxMStoY0FNRjZmWE5zaGhIQTFT?=
 =?utf-8?B?ZlY4Q3QzdHJDdThhNFZUMkE4VFl2Qmo1V000dXhlbG9YektyTll0M2tEcWZs?=
 =?utf-8?B?VE4vWVRYb2dQVUp5UWNhL0RMRlB5TDEvZGJvVlVLbjh6ZU4ySmp2R3dqejhP?=
 =?utf-8?B?c3JKWkIxRmZlSERVcVdvMUtiSHd0by9hQ3hyVzlidEwxeC9Pd1hENWgwc01U?=
 =?utf-8?B?eHlCcThSUGRWZTdCanlHeG04Z3phTWdlMDZZeDhWUDQyYWUwalRZdDJ5ZFho?=
 =?utf-8?B?QWJiUHBWdHBndHNCTHZvY09qQ2RZam01WmFyN050V1dnODN2VGpBa3NiQjNY?=
 =?utf-8?Q?JlZvOMEOSEVqJ4QTUBRnWA8uscocTwB/uGaMz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51351baf-c562-4bd8-7333-08d8d464adfc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:26:55.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UtI6JrueHdy2peY/A9gic4JawOSaqxWH84DZb7Dv0o7KCSoEBads+b++9ujVU+QtYdxmL6BLNYqxAFxsFIQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180197
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180197
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/17/21 11:32 AM, Peter Xu wrote:
> On Wed, Feb 10, 2021 at 04:03:19PM -0800, Mike Kravetz wrote:
>> hugetlb fault processing code would COW all write faults where the
>> pte was not writable.  Soft dirty will write protect ptes as part
>> of it's tracking mechanism.  The existing hugetlb_cow  code will do
>> the right thing for PRIVATE mappings as it checks map_count.  However,
>> for SHARED mappings it would actually allocate and install a COW page.
>> Modify the code to not call hugetlb_cow for SHARED mappings and just
>> update the pte.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 47f3123afd1a..b561b6867ec1 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4584,8 +4584,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  	 * spinlock. For private mappings, we also lookup the pagecache
>>  	 * page now as it is used to determine if a reservation has been
>>  	 * consumed.
>> +	 * Only non-shared mappings are sent to hugetlb_cow.
>>  	 */
>> -	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
>> +	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry) &&
>> +					!(vma->vm_flags & VM_SHARED)) {
>>  		if (vma_needs_reservation(h, vma, haddr) < 0) {
>>  			ret = VM_FAULT_OOM;
>>  			goto out_mutex;
>> @@ -4593,9 +4595,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		/* Just decrements count, does not deallocate */
>>  		vma_end_reservation(h, vma, haddr);
>>  
>> -		if (!(vma->vm_flags & VM_MAYSHARE))
>> -			pagecache_page = hugetlbfs_pagecache_page(h,
>> -								vma, haddr);
>> +		pagecache_page = hugetlbfs_pagecache_page(h, vma, haddr);
> 
> Pure question: I see that the check actually changed from VM_MAYSHARE into
> VM_SHARE, then I noticed I'm actually unclear on the difference..  Say, when
> VM_MAYSHARE is set, could VM_SHARED be cleared in any case?  Or say, is this
> change intended?

The change was not intended.  I will use VM_MAYSHARE.

> 
> I see that vma_set_page_prot() tried to remove VM_SHARED if soft dirty enabled
> (which should cause vma_wants_writenotify() to return true, iiuc), however
> that's temporary just to calculate vm_page_prot, and it's not applied to the
> vma->vm_flags.  I failed to find a place where VM_SHARED of the vma is cleared
> while VM_MAYSHARE is set..

I am not 100% sure about differences.  Here is a snippet from do_mmap() where
you can have VM_MAYSHARE and not VM_SHARED

                        vm_flags |= VM_SHARED | VM_MAYSHARE;
                        if (!(file->f_mode & FMODE_WRITE))
                                vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
                        fallthrough;

> 
>>  	}
>>  
>>  	ptl = huge_pte_lock(h, mm, ptep);
>> @@ -4620,9 +4620,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  
>>  	if (flags & FAULT_FLAG_WRITE) {
>>  		if (!huge_pte_write(entry)) {
>> -			ret = hugetlb_cow(mm, vma, address, ptep,
>> -					  pagecache_page, ptl);
>> -			goto out_put_page;
>> +			if (!(vma->vm_flags & VM_SHARED)) {
>> +				ret = hugetlb_cow(mm, vma, address, ptep,
>> +						pagecache_page, ptl);
>> +				goto out_put_page;
>> +			}
>> +
>> +			/* write protected for soft dirty processing */
>> +			if ((vma->vm_flags & VM_WRITE) &&
> 
> This VM_WRITE check seems to be redundant.  As example, do_user_addr_fault() of
> x86 code will check this right after vma lookup by access_error().  So when
> reach here if "flags & FAULT_FLAG_WRITE", then VM_WRITE must be set, imho.

Thanks, that sounds reasonable.  I will check to make sure and drop the
redundant check.

> 
>> +					(vma->vm_flags & VM_SHARED))
>> +				entry = huge_pte_mkwrite(entry);
> 
> Same question to VM_SHARED, since "(vma->vm_flags & VM_SHARED)" is just checked
> above and we'll go hugetlb_cow() otherwise.

Yes, certainly redundant here.

> 
>> +
>> +			entry = huge_pte_mkdirty(entry);
> 
> There's another huge_pte_mkdirty() right below; likely we could merge them somehow?
> 

Yes,

Thanks for taking a look!

-- 
Mike Kravetz

> Thanks,
> 
>>  		}
>>  		entry = huge_pte_mkdirty(entry);
>>  	}
>> -- 
>> 2.29.2
>>
> 
