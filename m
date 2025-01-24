Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D614B956;
	Fri, 24 Jan 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721836; cv=none; b=og/6n9G61kHMUSg797GMvzf6I8aN/JoFQqU/jKp7ix0fxOPAHfzvvyg1fcOvybxKkiwIG61n7/wltVwdqWBlyCrRy4qfAJglJuPa2noxmb8CLop+15D38zu2/60s1REamPpu6RQSFpnavEMFFmwHXsl88Qllueecl53JWDAZ2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721836; c=relaxed/simple;
	bh=JJY6BC+GNGScwChn19EDi80x7FNmCvQxXN/56YSiocM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL19zflo8RD4R3Sgc5RFwcMWQh/RHCuLlHe7g7j7PP82Suu+kI98w1myjURUJKq7fsCaPrqDu/N5IdZkim0gEkknVjrjnTCZxiD5hhwNXdm1v1bUqTasf6H27vBgRwAx4e0OW9Wi0dh596NQzjj9J93cHLDZ83HRthTBRZs6/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA101497;
	Fri, 24 Jan 2025 04:31:00 -0800 (PST)
Received: from [10.57.95.170] (unknown [10.57.95.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D8E3F5A1;
	Fri, 24 Jan 2025 04:30:30 -0800 (PST)
Message-ID: <512914f2-1df7-4c24-ab4b-6a246060d537@arm.com>
Date: Fri, 24 Jan 2025 13:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
 <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
 <Z5NOWvrOln4T0RCH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Z5NOWvrOln4T0RCH@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2025 09:24, Alexander Gordeev wrote:
>>>  	}
>>>  	if (end > _REGION1_SIZE) {
>>>  		pgd = crst_table_alloc(mm);
>>>  		if (unlikely(!pgd))
>>>  			goto err_pgd;
>>>  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
>>> +		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
>> I was hoping this might be equivalent to pgd_alloc() but it does not
>> include a call to crst_table_init(). Since adding it would be apparently
>> undesirable (having read the other thread), it seems reasonable to add
>> the explicit constructor call.
> We were thinking about a follow-up cleanup that addresses it all, but this
> patch is a targeted fix to catch up your and Qi Zheng series in the still
> open merge window.

Sure that's fair, this patch does fix the issue and the cleanup can wait
until the next cycle.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin
