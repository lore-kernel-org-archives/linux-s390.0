Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013DC4332F
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 15:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjKFPJE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 10:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFPJD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 10:09:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFEDB6;
        Mon,  6 Nov 2023 07:09:00 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPF653GN6zrSNy;
        Mon,  6 Nov 2023 23:05:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:08:56 +0800
Message-ID: <c4186f18-5a49-4fd6-ab19-6db77bcfc541@huawei.com>
Date:   Mon, 6 Nov 2023 23:08:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] mm: memory: use a folio in zap_pte_range()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>
References: <20231104035522.2418660-1-wangkefeng.wang@huawei.com>
 <20231104035522.2418660-7-wangkefeng.wang@huawei.com>
 <ZUZ9dg4YHZdUKDqO@casper.infradead.org>
 <e3c275c3-e09d-4495-8132-9464133db283@huawei.com>
 <ZUj2SCML4h7X5TWu@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUj2SCML4h7X5TWu@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2023/11/6 22:20, Matthew Wilcox wrote:
> On Mon, Nov 06, 2023 at 10:30:59AM +0800, Kefeng Wang wrote:
>> On 2023/11/5 1:20, Matthew Wilcox wrote:
>>>> -				page_remove_rmap(page, vma, false);
>>>> -			put_page(page);
>>>> +				page_remove_rmap(&folio->page, vma, false);
>>>> +			folio_put(folio);
>>>
>>> This is wrong.  If we have a PTE-mapped THP, you'll remove the head page
>>> N times instead of removing each of N pages.
>>
>> This is device private entry, I suppose that it won't be a THP and large
>> folio when check migrate_vma_check_page() and migrate_vma_insert_page(),
>> right?
> 
> I don't want to leave that kind of booby-trap in the code.  Both places
> which currently call page_remove_rmap() should be left as referring to
> the page, not the folio.

Sure, I will fix this, also page_try_dup_anon_rmap() for device private
entry in copy_nonpresent_pte of patch5.

