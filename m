Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8619C4332F
	for <linux-s390@archiver.kernel.org>; Sat,  4 Nov 2023 03:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKDD7A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 23:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377973AbjKDD7A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 23:59:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F21AA;
        Fri,  3 Nov 2023 20:58:57 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMkPQ15y9zVlM1;
        Sat,  4 Nov 2023 11:58:50 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 4 Nov 2023 11:58:55 +0800
Message-ID: <61c0f155-1cdd-4865-b047-88fbdc661ac3@huawei.com>
Date:   Sat, 4 Nov 2023 11:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 00/18] mm: convert to use folio mm counter
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>
References: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
 <ZUUEAbs6/GlZmV+Q@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUUEAbs6/GlZmV+Q@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2023/11/3 22:30, Matthew Wilcox wrote:
> On Fri, Nov 03, 2023 at 10:01:01PM +0800, Kefeng Wang wrote:
>> Convert mm counter page functions to folio ones.
>>
>>    mm_counter()       ->	mm_counter_folio()
>>    mm_counter_file()  ->	mm_counter_file_folio()
>>
>> Maybe it's better to rename folio mm counter function back to mm_counter()
>> and mm_counter_file() after all conversion?
> 
> I deliberately didn't do this because it's mostly churn.
> Once all callers of mm_counter() and mm_counter_file() have been
> converted to use folios, we can do one big patch to convert all
> callers to pass a folio instead of a page.
> 
I re-order the patches as you say, please help to check v2, thanks.
