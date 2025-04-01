Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D559B71;
	Tue,  1 Apr 2025 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475909; cv=none; b=T0zE13VQRlfJJA9StOi4hPiXs94ocn6w0bltDI4duuzQAka2kwukUaHFIxiAzb91DcV7zyHONCJ1prr4zm9wH6H1Pk20xvIIOQvmaJ8eKaTBD1OhOvDiFGsTGykHDHf4O4o22Uw4wEXRPnlc8xqWXAQ0Ai1KiV0Q5ZSJWu069qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475909; c=relaxed/simple;
	bh=RItUkqRKucQWp7MFuyOxMmqREl9gCnkIuNph40EdEFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1FAOR8v1lkooEojcB60ew/5FTXFDiG7QO7BdKRC35/yVn3X6czTaop8OG5uhtxspzsHeiq177sK2x82F4QFeScuqljL2aXKCdD60n7TWbvsjgYWB+4De04f6BL+bHcxD9h4zyOanDTFKW/f5YytTQ+9OnPfFnhwMSaAeGMcAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F36714BF;
	Mon, 31 Mar 2025 19:51:49 -0700 (PDT)
Received: from [10.162.16.153] (unknown [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018F23F59E;
	Mon, 31 Mar 2025 19:51:39 -0700 (PDT)
Message-ID: <86a276d6-afe3-4c70-aa85-7cafe33b8e5c@arm.com>
Date: Tue, 1 Apr 2025 08:21:36 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/ptdump: Split note_page() into level specific
 callbacks
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20250317061818.16244-1-anshuman.khandual@arm.com>
 <20250317061818.16244-2-anshuman.khandual@arm.com>
 <Z+pZX2QmFnNnnjZ5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z+pZX2QmFnNnnjZ5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 14:29, Alexander Gordeev wrote:
> On Mon, Mar 17, 2025 at 11:48:17AM +0530, Anshuman Khandual wrote:
> 
> Hi Anshuman,
> 
> ...
>> --- a/include/linux/ptdump.h
>> +++ b/include/linux/ptdump.h
>> @@ -11,9 +11,12 @@ struct ptdump_range {
>>  };
>>  
>>  struct ptdump_state {
>> -	/* level is 0:PGD to 4:PTE, or -1 if unknown */
>> -	void (*note_page)(struct ptdump_state *st, unsigned long addr,
>> -			  int level, u64 val);
>> +	void (*note_page_pte)(struct ptdump_state *st, unsigned long addr, pte_t pte);
>> +	void (*note_page_pmd)(struct ptdump_state *st, unsigned long addr, pmd_t pmd);
>> +	void (*note_page_pud)(struct ptdump_state *st, unsigned long addr, pud_t pud);
>> +	void (*note_page_p4d)(struct ptdump_state *st, unsigned long addr, p4d_t p4d);
>> +	void (*note_page_pgd)(struct ptdump_state *st, unsigned long addr, pgd_t pgd);
>> +	void (*note_page_flush)(struct ptdump_state *st);
>>  	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);
> 
> Should you treat effective_prot() similarly?

Agreed. effective_prot() also uses pxd_val() derived data type in generic MM and
might cause the same problem later going ahead. Will split the helper into level
specific callbacks as well.

> 
>>  	const struct ptdump_range *range;
>>  };
