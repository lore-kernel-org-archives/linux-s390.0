Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73103176EF;
	Tue, 20 Jan 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926745; cv=none; b=Az4bBswOAiOabmyu6WCBgHETI7upMzsyzQsan/1B8AE/NQxUKp/bPQZHw0iU/L+sK5VQkZelpp7IKzg94SX7qEtsHmtZmmKuodpJUH3aPYY/FhfSwPESs5wS6sSJrjmCKCzwqCk8O1zNftjqWFOrAQ4ucJ/z4TIGfH9o2HDCgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926745; c=relaxed/simple;
	bh=MEfEaETuHARVD48KyuQmVhFNmOwX8YQiQSJrURCh6EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcZT4IhpB/ECiyrEGGkGtMkhSWGhXL/+cgSPIu6029kRkiV3tbzz8cRy5jlwEBdjkGlRyNFn6OG80GewPNRal2yX/k5eYAg+51clwk7GSY3LN3moz8FTQsLsAGLqXkg601GccP8iyfqTux9H8MSGOYkUxkG6h3FjeJxx/j6voYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3771476;
	Tue, 20 Jan 2026 08:32:16 -0800 (PST)
Received: from [10.1.39.200] (XHFQ2J9959.cambridge.arm.com [10.1.39.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFE823F694;
	Tue, 20 Jan 2026 08:32:18 -0800 (PST)
Message-ID: <785a7d90-babe-43af-93a6-c220c1877bcf@arm.com>
Date: Tue, 20 Jan 2026 16:32:17 +0000
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
To: Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 16:44, Kees Cook wrote:
> 
> 
> On January 19, 2026 8:00:00 AM PST, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 1/19/26 05:01, Ryan Roberts wrote:
>>> x86 (AWS Sapphire Rapids):
>>> +-----------------+--------------+-------------+---------------+
>>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng |
>>> |                 |              | rndstack-on |               |
>>> |                 |              |             |               |
>>> +=================+==============+=============+===============+
>>> | syscall/getpid  | mean (ns)    |  (R) 13.32% |     (R) 4.60% |
>>> |                 | p99 (ns)     |  (R) 13.38% |    (R) 18.08% |
>>> |                 | p99.9 (ns)   |      16.26% |    (R) 19.38% |
>>
>> Like you noted, this is surprising. This would be a good thing to make
>> sure it goes in very early after -rc1 and gets plenty of wide testing.
> 
> Right, we are pretty late in the dev cycle (rc6). It would be prudent to get this into -next after the coming rc1 (1 month from now).
> 
> On the other hand, the changes are pretty "binary" in the sense that mistakes should be VERY visible right away. Would it be better to take this into -next immediately instead?

I don't think this question was really addressed to me, but I'll give my opinion
anyway; I agree it's pretty binary - it will either work or it will explode.
I've tested on arm64 and x86_64 so I have high confidence that it works. If you
get it into -next ASAP it has 3 weeks to soak before the merge window opens
right? (Linus said he would do an -rc8 this cycle). That feels like enough time
to me. But it's your tree ;-)

Thanks,
Ryan


> 
>> But I don't see any problems with the approach, and the move to common
>> code looks like a big win as well:
> 
> Agreed; I think it's looking great.
> 

