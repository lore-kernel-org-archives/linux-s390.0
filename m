Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64654707F;
	Thu, 17 Sep 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668813; cv=none; b=KyxWhDVW2fEBWplc69G+5pxs+THO3OglI9jXS1ghBHO+eDdTGo8keCBlK2dY0WzBrYtdCtUYs43RGmUgKTOQ74BtcjVkEOpH7lL0YvtBYHb/KnMWaprGE+hwgGbF9LJdaOChXrLvi6hpAAtqEPd84H1WrVNGjuUahW7Ebf7yieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668813; c=relaxed/simple;
	bh=QAr23lhx8wGsXT6yVi+oXiSZp/vetZhFYtO/kqi1324=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oa1qLkO9/nd28kqGtT9PdF0pFJbkcpGD4w6z5uWo65zeKqCZK3vENxs/QLVPJEamSRf+7jjFwDePc5Tj7V8fNk74gBsTxKNR/5G/e9q0HhQIDUk3DZLOka5VQ7Hibp7Tweg50szlvYiswVFng8/2s/lMIKYGGzgGadGLk5GJAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aYA7qe3T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aYA7qe3T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB24D1F91;
	Thu, 17 Sep 2026 11:13:25 -0700 (PDT)
Received: from [10.57.7.135] (unknown [10.57.7.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69F63F86F;
	Thu, 17 Sep 2026 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789668809; bh=QAr23lhx8wGsXT6yVi+oXiSZp/vetZhFYtO/kqi1324=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYA7qe3TJmI5eXy7zuCDNvjC424BNkx9TqHpOMlyNEkNvwpgRn5lsECsH9o7hC0RG
	 5jIxS0q8ZHaQOP2dIWzY39HZw+w/QDzFAaZ5etprv7QyoTOG2UkZgMUVBbr0E0ztmK
	 wHMiHRGdA5HaFJ3DgcETN41w6QqxGhhxvHgViRbE=
Message-ID: <685fa7b1-af6d-4dc0-8764-5bcb169b39ae@arm.com>
Date: Thu, 17 Sep 2026 20:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
 allocations
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
 Will Deacon <will@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-5-949b64a9f755@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-5-949b64a9f755@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 11:28, Mike Rapoport (Microsoft) wrote:
> Initially execmem completely removed direct map alias for the memory
> allocated for the ROX cache in PMD_SIZE chunks. When that memory was
> freed, its direct map was restored also in PMD_SIZE chunks to avoid
> fragmentation of the direct map caused by vmalloc::vm_reset_perms().
>
> This required execmem to implement the wrappers for set_direct_map APIs for
> proper sequencing of removal and restoration of the direct map aliases.
>
> Since then x86's CPA gained support for collapsing the direct map page
> tables for ROX pages and execmem switched from removing ROX caches from the
> direct map to making them ROX there, so execmem only needs to update direct
> map alias permissions when freeing the ROX cache memory.
>
> vmalloc already handles those updates for areas with VM_FLUSH_RESET_PERMS
> set and vmalloc::vm_reset_perms() does not force split of the direct map
> for PMD_SIZE chunks.
>
> Set the area permissions with set_vm_flush_reset_perms() when populating
> the execmem cache just before flipping the area to ROX.
>
> This way freeing an allocated area on an error path won't incur two
> updates of the direct map alias of that area and TLB flushing in
> vm_reset_perms().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
