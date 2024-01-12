Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA82574F;
	Fri, 12 Jan 2024 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TB7WH5Qbhz29k9x;
	Fri, 12 Jan 2024 12:15:55 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 412421800D3;
	Fri, 12 Jan 2024 12:17:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 12:17:28 +0800
Message-ID: <7da39683-9b33-4f4e-baa5-69e63962943b@huawei.com>
Date: Fri, 12 Jan 2024 12:17:28 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] mm: swap: introduce pfn_swap_entry_to_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<david@redhat.com>, <linux-s390@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
 <20240111111239.2453282-2-wangkefeng.wang@huawei.com>
 <ZZ/9NZKf3X3TGDsa@casper.infradead.org>
 <ZZ/9n3gitoBnq8na@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZZ/9n3gitoBnq8na@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/11 22:39, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 02:37:41PM +0000, Matthew Wilcox wrote:
>> On Thu, Jan 11, 2024 at 07:12:32PM +0800, Kefeng Wang wrote:
>>> Introduce a new pfn_swap_entry_to_folio(), it is similar to
>>> pfn_swap_entry_to_page(), but return a folio, which allow us
>>> to completely replace the struct page variables with struct
>>> folio variables.
>>
>> I have the exact same patch in my tree except I called it
>> pfn_swap_entry_folio().  I also noted:
>>
>>      Thanks to the compound_head() hidden inside PageLocked(), this saves a
>>      call to compound_head() over calling page_folio(pfn_swap_entry_to_page())
>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Oh, and I converted a couple of callers ...
> migration_entry_wait_on_locked and change_huge_pmd.  Those should
> probably be added to this patch.
> 

Thanks for your update, and all above conversion in your v3, and I check
more callers,  eg, hugetlb_change_protection,break_ksm_pmd_entry could
be converted too, but we could send separate patch.
