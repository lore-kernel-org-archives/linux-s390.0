Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC404C79;
	Tue,  1 Jul 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751343389; cv=none; b=gLXMUoZvufVmoI8keHVE8whdqQPExvuiqlph8KYhpZrhyZTa+pqgMLVA996SeqXmyY7z+0CS1rhWKlrenUuZrZE1zACrFRWEHZ/niqc0RMlCkab0F/kEPYD03qgXiKH/pJSKjP2Dg476Yi1vLo1KlE/o7FQX/CA6n/rQs5h7dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751343389; c=relaxed/simple;
	bh=Z0Dw6txf8BKHwwKp68Wybqomt9gKIwcdlVokjkD3WJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYMdPQ/bydapYh9PRSdNo7RTbbljc2hElNBYXqZG01d1PNaprG2ZcGcMFHJrh/67oyI06Dskpnql6lPjtcyKVeKZxIybWyvyTpAfxCY736tNF64wEcYRx27yJeFkYEa0OYZIcfQK8TzL859ft4VULMhiAOOHyXc4/Yws82H37nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7598715A1;
	Mon, 30 Jun 2025 21:16:10 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63E83F58B;
	Mon, 30 Jun 2025 21:16:23 -0700 (PDT)
Message-ID: <26d65dc4-7594-4a5e-8c3d-9e19540ae25e@arm.com>
Date: Tue, 1 Jul 2025 09:46:20 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug_vm_pgtable: Use a swp_entry_t input value for
 swap tests
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand
 <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>
References: <20250630164726.930405-1-gerald.schaefer@linux.ibm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250630164726.930405-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/25 10:17 PM, Gerald Schaefer wrote:
> The various __pte/pmd_to_swp_entry and __swp_entry_to_pte/pmd helper
> functions are expected to operate on swap PTE/PMD entries, not on
> present and mapped entries.
> 
> Reflect this in the swap tests by using a swp_entry_t as input value,
> and convert it to a swap PTE/PMD for testing, similar to how it is already
> done in pte_swap_exclusive_tests(). Move the swap entry creation from
> there to init_args() and store it in args, so it can also be used in other
> functions.
> 
> The pte/pmd_swap_tests() are also changed to compare entries instead of
> pfn values, again similar to pte_swap_exclusive_tests(). pte/pmd_pfn()
> helpers are also not expected to operate on swap PTE/PMD entries at all.
> 
> Also update documentation, to reflect that the helpers operate on swap
> PTE/PMD entries and not present and mapped entries, and use correct names,
> i.e. __swp_to_pte/pmd_entry -> __swp_entry_to_pte/pmd.
> 
> For consistency, also change pte/pmd_swap_soft_dirty_tests() to use
> args->swp_entry instead of a present and mapped PTE/PMD.
> 
> Link: https://lore.kernel.org/all/20250623184321.927418-1-gerald.schaefer@linux.ibm.com
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
