Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47258313290;
	Tue, 20 Jan 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927539; cv=none; b=k3xr9RXQ1SZkzeO1d4u6Aj1flx5Tf8XqYf5WxMIS+HBj82j7J/j5H0IAQymVpazT1lJUx9mtwCrD6GLIk4ubK3srBKDkJYAUcFE3hKZRqLgfcEFyfNUrEY9igMDcDncsnHiyN0ejTPdzcgKk1ESLXrj/OgCIPrZPd4uTPn6ppw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927539; c=relaxed/simple;
	bh=EktYAkt/rHqN46GzGHWmpJQENSXTbh6gia76OHdxpfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLPyJyhUnNvt0CBFFOcfT6Evn22OiGNQqFRLbrC7sbS+80ahOpyYRjJZ88Y3eppVEJ+1pjghvROVBFhTuKM/q+470zpS20yeQj6RKONlBBstwekWypSVM2WLLLvsmnHypJJcFe6pRQ5r3iN98WPo0PKfrJhe2iUslg0l1yOq3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55491476;
	Tue, 20 Jan 2026 08:45:30 -0800 (PST)
Received: from [10.1.39.200] (XHFQ2J9959.cambridge.arm.com [10.1.39.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600763F694;
	Tue, 20 Jan 2026 08:45:33 -0800 (PST)
Message-ID: <c5922290-f01c-4c77-995a-9a0ef89053a1@arm.com>
Date: Tue, 20 Jan 2026 16:45:31 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix bugs and performance of kstack offset
 randomisation
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>, Kees Cook <kees@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
 <C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
 <785a7d90-babe-43af-93a6-c220c1877bcf@arm.com>
 <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a8ca3483-d61a-41bd-9b1b-17a8f3ac03eb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/01/2026 16:37, Dave Hansen wrote:
> On 1/20/26 08:32, Ryan Roberts wrote:
>> I don't think this question was really addressed to me, but I'll give my opinion
>> anyway; I agree it's pretty binary - it will either work or it will explode.
>> I've tested on arm64 and x86_64 so I have high confidence that it works. If you
>> get it into -next ASAP it has 3 weeks to soak before the merge window opens
>> right? (Linus said he would do an -rc8 this cycle). That feels like enough time
>> to me. But it's your tree 😉
> 
> First of all, thank you for testing it on x86! Having that one data
> point where it helped performance is super valuable.
> 
> I'm more worried that it's going to regress performance somewhere and
> then it's going to be a pain to back out. I'm not super worried about
> functional regressions.

Fair enough. Let's go slow then.
