Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249E313E02;
	Mon,  5 Jan 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609010; cv=none; b=mVHxo4JVgWknCKJEVaxhToJg4FtguCVnS83hx5a6xr8oNOTnYib1kXac6JrBHajb0OOyGkKMNMbDlAkuvyB07GmDqMBPJlPfEQ0ESKrBKl4eQT+r8NeCmCDZ6A/+q74X71I686cj5e0TpS0jlPi/X7jKsozCBh8EqW8ctlUebmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609010; c=relaxed/simple;
	bh=hmC/fEh5Y3cGVFt4ebDm4DtwX1ROeVu94xmGiHcSwjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEoYmkyfd6yrfmoCcczujkBhG9pySKUmlEFjm07nBQdseIW6Q8RHef4EXoVCSmntxP0MYMp7eENdzWiWd7lAcgbAf/+MDPZfeonT+wIK70zITqN/Ck5YHDm6oL8GucEJrkYAjAW5Y5xYU11Az7cV/d7llXthZds4O/29KONDBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45673497;
	Mon,  5 Jan 2026 02:30:00 -0800 (PST)
Received: from [10.1.38.150] (XHFQ2J9959.cambridge.arm.com [10.1.38.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA473F6A8;
	Mon,  5 Jan 2026 02:30:03 -0800 (PST)
Message-ID: <19a0da52-5322-40b0-9195-5d191f582bc5@arm.com>
Date: Mon, 5 Jan 2026 10:30:02 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] randomize_kstack: Maintain kstack_offset per task
Content-Language: en-GB
To: David Laight <david.laight.linux@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 stable@vger.kernel.org
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
 <20260102131156.3265118-2-ryan.roberts@arm.com>
 <20260102224432.172b1247@pumpkin>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260102224432.172b1247@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2026 22:44, David Laight wrote:
> On Fri,  2 Jan 2026 13:11:52 +0000
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> kstack_offset was previously maintained per-cpu, but this caused a
>> couple of issues. So let's instead make it per-task.
>>
>> Issue 1: add_random_kstack_offset() and choose_random_kstack_offset()
>> expected and required to be called with interrupts and preemption
>> disabled so that it could manipulate per-cpu state. But arm64, loongarch
>> and risc-v are calling them with interrupts and preemption enabled. I
>> don't _think_ this causes any functional issues, but it's certainly
>> unexpected and could lead to manipulating the wrong cpu's state, which
>> could cause a minor performance degradation due to bouncing the cache
>> lines. By maintaining the state per-task those functions can safely be
>> called in preemptible context.
>>
>> Issue 2: add_random_kstack_offset() is called before executing the
>> syscall and expands the stack using a previously chosen rnadom offset.
>                                                            <>
> 	David

Cheers; will fix in next version.

Thanks,
Ryan
