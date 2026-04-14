Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D13E8C69;
	Tue, 14 Apr 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177019; cv=none; b=VEhp3KdjrbPAbKYW+wjCeYwbGHJD/yZx3uPRei5kcHOFaiBxg2F7EzZnLj6ROPgvMJ0/mpPefw3cxy2Uu9DXCmcXf8U8yvuN+BKcznaQEktg4DKOjAt7Ard3zH680iRiNqoaNIza3hvognp1CcXkP6whI3YLt1Q9Q21EFFVTlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177019; c=relaxed/simple;
	bh=mhLwe7rhb27l/HdrKF1gzHFmrEeMIXkxvSA/h0P7cnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXkcaJy7klZtdpheEfZgDJXDZLEHP2lC0P1lMsogcjkzUjKG8tkvAZ5XU2MgWjo2GBllFzsu1Ty6ZR5XNmIsq9OBQA7oeab+xPAIGfN/TNddcM7EWTkKElBn43iXQDJ4ybjZVL2F0iKSCorFfe2AeECobFONIIzIyTuHWKN7VkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d57me9yp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d57me9yp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A3635ED;
	Tue, 14 Apr 2026 07:30:09 -0700 (PDT)
Received: from [10.57.33.35] (unknown [10.57.33.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A9F3F641;
	Tue, 14 Apr 2026 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776177015; bh=mhLwe7rhb27l/HdrKF1gzHFmrEeMIXkxvSA/h0P7cnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d57me9ypwIuAeo2BDArS47N/bQv23nqprOSE9DiGPHMe6WxMtnT9+ii+MNl8xxsiN
	 +HIT/OdY31VGaGIVMjXbR15Eq1BACXaUZkDgXLe2mRwy79bDHAgUiJ8xKAwpiGYxcX
	 sra3mtYusApDJKnzgAgLLEbTm2UgFuozTC/JsPI0=
Message-ID: <17505ac4-c5e5-4046-b362-830369b8d401@arm.com>
Date: Tue, 14 Apr 2026 16:30:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
 <896b3d93-8e60-42e2-b8bb-d3d4e8c99927-agordeev@linux.ibm.com>
 <534ed892-a6ab-454e-831b-e207930c35cc@kernel.org>
 <584f0f88-aef9-4a70-b0bb-abc797f741ed-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <584f0f88-aef9-4a70-b0bb-abc797f741ed-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2026 09:53, Alexander Gordeev wrote:
> /**                                                                             
>  * lazy_mmu_mode_enable_for_pte_range() - Enable the lazy MMU mode with a speedup hint.
>  * @mm: Address space the ptes represent.

Not sure that makes sense, maybe something like "Address space the PTEs
belong to"?

>  * @addr: Address of the first pte.

Isn't it the address of the underlying memory rather?

>  * @end: End address of the range.                                              
>  * @ptep: Page table pointer for the first entry.                               
>  *                                                                              
>  * Enters a new lazy MMU mode section; if the mode was not already enabled,         
>  * enables it and calls arch_enter_lazy_mmu_mode_for_pte_range().               
>  *                                                                              
>  * PTEs that fall within the specified range might observe update speedups.         
>  * The PTE range must belong to the specified memory space and do not cross         

s/do not/not/

>  * a page table boundary.                                                       
>  *                                                                              
>  * There are no requirements on the order or range completeness of PTE          
>  * updates for the specified range.                                             
>  *                                                                              
>  * Must be paired with a call to lazy_mmu_mode_disable().                       
>  *                                                                                  
>  * Has no effect if called:                                                     
>  * - While paused - see lazy_mmu_mode_pause()                                   
>  * - In interrupt context                                                       
>  */                             

Looks reasonable to me otherwise.

- Kevin
