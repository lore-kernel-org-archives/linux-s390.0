Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F2A47;
	Thu, 27 Feb 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614795; cv=none; b=KDgFylJJ0INcmwtz20TaGHKDOo2JNKrg8zzm3TLn8tVhI0JasAjwePZrxzlGoCtSvYiZ15j1Q/TdbeOiSqCFXon3HXTxGI13KC4bpX6yDS97B7p2bGGUT3xjrXGrnkFfMiucWiOr7B/v2KO/aCMTUyGI4fYBSwjQU3uVaieIR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614795; c=relaxed/simple;
	bh=ZV07Gpz815P4h6/dASi/XClt914gSIOcYIvsY0gmk7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl6kZixHzwvRR49Yibtd8tUbQzOp1k8Bu8TO/duWVo4TDsdMyoY1xeqAjWNFN36lccRaKZyvzz7F1+4n3lXX8xdJwhc0La/4fIuGLWJphvLDp68HTS3tBMx5CE7iRvZOPgPQJqN9sZfCWqqUEl5Ayqdnq4LtwiE62qSWDoqNNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5564812FC;
	Wed, 26 Feb 2025 16:06:48 -0800 (PST)
Received: from [10.163.39.237] (unknown [10.163.39.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2DD63F5A1;
	Wed, 26 Feb 2025 16:06:25 -0800 (PST)
Message-ID: <39986b7d-7a82-4f28-9289-5620a2bec2b5@arm.com>
Date: Thu, 27 Feb 2025 05:36:25 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/5] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
 <20250226122404.1927473-6-anshuman.khandual@arm.com>
 <Z79xK3xJWm0vH5jH@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z79xK3xJWm0vH5jH@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 

On 2/27/25 01:23, Catalin Marinas wrote:
> On Wed, Feb 26, 2025 at 05:54:04PM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>> index 6cf4aae05219..b2931d1ae0fb 100644
>> --- a/arch/arm64/include/asm/ptdump.h
>> +++ b/arch/arm64/include/asm/ptdump.h
>> @@ -7,7 +7,7 @@
>>  
>>  #include <linux/ptdump.h>
>>  
>> -#ifdef CONFIG_PTDUMP_CORE
>> +#ifdef CONFIG_PTDUMP
> 
> Do we need this #ifdef at all? I haven't tried but usually, if the
> feature is not enabled, the header file on its own should be harmless.

With or without the #ifdef CONFIG_PTDUMP in place here, this does not cause
any build warnings even without CONFIG_PTDUMP enabled. But dropping #ifdef
while renaming the config option itself, might have caused unrelated code
churn. So probably if required we could drop this later on.

> 
> For arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
