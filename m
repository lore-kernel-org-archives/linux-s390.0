Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6F279DCC;
	Fri, 20 Mar 2026 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975935; cv=none; b=Mj5+hI+NlAWbm1WTk9hqfJ6Oof3pxKfI8phBvU/F+VOWMf+b1ZlmCUImZweWU+OUv6Ien/MBcE+xfV8q6RVw/JtjE1R/zR43+EthJXbw9lmTI0k14ycofU1efeRoJMTu8gL2KFkakMoo0/wy1bIbyynFwWaHXCTnfaSRSMWpPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975935; c=relaxed/simple;
	bh=REQQnxXpsFhrNV0XxA255iDp5J0reo8ZClM1tnR/xVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpisCwLVKp/47K7iy01+GJ64NN6jZe+fXb/xKYJ0lHaa3drX/vvLKRV0CO+y8XtnySgUDJdliwOdUFR5FWeG5JJMBUcKx1mbbxT98qE3Tq2ozipQnPOkOyrE8Cony9Vbzxq80pc2zkA3YBdGlyuT9I1MYPTi5lkSC3Mpc0CoXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tl9JWpKM; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tl9JWpKM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773975929; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VGXqSdrjifGxcMcDlLu7ZKp792LHAscB7o5xF4jfDt0=;
	b=Tl9JWpKMuvMUj6dbpUf9LDoxR0iAIYwxdiZs8/USGg1SSggRidXogN1u3Khj0pcbEIIsyeJcfKPbonewgGEm2e0wZqMRSNbehsXS8M/6tc/OWzK34lZVwLad1na9a5stBbFpf++X6vbJxEkspasdAoJYxD8w6fOkIVh2rZnEsyI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.KE0mj_1773975927;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.KE0mj_1773975927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:05:28 +0800
Message-ID: <f7831736-f48f-4b5f-908d-4acda5829403@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:05:27 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mm: change to return bool for
 ptep_clear_flush_young()/clear_flush_young_ptes()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
 <46390a7c-164c-4ffb-a1b2-fad21e3829df@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <46390a7c-164c-4ffb-a1b2-fad21e3829df@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/26 7:30 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:01AM +0800, Baolin Wang wrote:
>> The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
>> the young flag and flush the TLB, returning whether the young flag was set.
>> Change the return type to bool to make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Couple nits but LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks.

>> ---
>>   arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
>>   arch/arm64/mm/contpte.c                      |  4 ++--
>>   arch/parisc/include/asm/pgtable.h            |  2 +-
>>   arch/parisc/kernel/cache.c                   |  8 ++++----
>>   arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>>   arch/riscv/include/asm/pgtable.h             |  4 ++--
>>   arch/s390/include/asm/pgtable.h              |  4 ++--
>>   arch/x86/include/asm/pgtable.h               |  4 ++--
>>   arch/x86/mm/pgtable.c                        |  4 ++--
>>   include/linux/pgtable.h                      |  8 ++++----
>>   mm/pgtable-generic.c                         |  7 ++++---
>>   11 files changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 8c651695204c..393a9d1873f6 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1299,10 +1299,10 @@ static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
>>   	return pte_young(pte);
>>   }
>>
>> -static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
>> -					 unsigned long address, pte_t *ptep)
>> +static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
>> +					    unsigned long address, pte_t *ptep)
> 
> I mean this is subjective stuff but can we just put 2nd line 2 tabs indented
> underneath? Makes it easier for changes like this to not propagate.
> 
> Same comment for all of these!

I usually use 2 tabs for indentation in the mm subsystem, but for other 
subsystems, I try to follow the existing style since I'm unsure of other 
maintainers' preferences:)

Anyway, I can do this if no other objections.
