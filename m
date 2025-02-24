Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0A2571DA;
	Mon, 24 Feb 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404897; cv=none; b=Czs1Bsv9+Bn/S+4K1yvYU6QIE4yjfq4emaY6pOViPPnjvcF1hYdmZ49pl0oP55zH+g2jKMsmlSthTIIaTN71dTQnLHI12ziK8Fp7elm31AcTew6oA6wm5PfUYUCo4k3gr7pC6HL1GTR6/Qv6tNoGUpz7lxSL7oGlcpTirqV0GTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404897; c=relaxed/simple;
	bh=tL1+UhoAB+zhQZj2gjP8iNht2hSkHMqUXIe4VPji8jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7hS8hWNe9rQCrr50XOdN1kRmxm+lqU0zX2xnivhksuvYcgQW47505y5iDP+JX2PwBOSQBR/fGSwVF/oX81KkPnZP6euBNHOOb5XIT0qgRPCU3Mq7Vz+Qv2Mm9PKdliM174ul7cgW4UREkK8LFKODERky8IigkLtn89aGec2WwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990B31515;
	Mon, 24 Feb 2025 05:48:30 -0800 (PST)
Received: from [10.163.40.148] (unknown [10.163.40.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716D33F5A1;
	Mon, 24 Feb 2025 05:48:07 -0800 (PST)
Message-ID: <acc7eb95-a0d2-4f35-96a8-7a370cc1eff6@arm.com>
Date: Mon, 24 Feb 2025 19:18:02 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/5] arch/powerpc: Drop GENERIC_PTDUMP from
 mpc885_ads_defconfig
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc: steven.price@arm.com, Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20250217042220.32920-1-anshuman.khandual@arm.com>
 <20250217042220.32920-3-anshuman.khandual@arm.com>
 <93e96586-13a2-4800-9dc7-5b35177a328e@csgroup.eu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <93e96586-13a2-4800-9dc7-5b35177a328e@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/24/25 17:34, Christophe Leroy wrote:
> 
> 
> Le 17/02/2025 à 05:22, Anshuman Khandual a écrit :
>> GENERIC_PTDUMP gets selected on powerpc explicitly and hence can be dropped
>> off from mpc885_ads_defconfig.
>>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Just wondering - Should CONFIG_PTDUMP_DEBUGFS be added instead ?
> 
> Yes please do that as a fix to commit e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP")

Sure, does the following updated commit message look okay ?

arch/powerpc: Drop GENERIC_PTDUMP from mpc885_ads_defconfig

GENERIC_PTDUMP gets selected on powerpc explicitly and hence can be dropped
off from mpc885_ads_defconfig. Just add CONFIG_PTDUMP_DEBUGFS instead.

Fixes: e084728393a5 ("powerpc/ptdump: Convert powerpc to GENERIC_PTDUMP")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

> 
>>
>>   arch/powerpc/configs/mpc885_ads_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
>> index 77306be62e9e..ea6f836407d2 100644
>> --- a/arch/powerpc/configs/mpc885_ads_defconfig
>> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
>> @@ -78,4 +78,3 @@ CONFIG_DEBUG_VM_PGTABLE=y
>>   CONFIG_DETECT_HUNG_TASK=y
>>   CONFIG_BDI_SWITCH=y
>>   CONFIG_PPC_EARLY_DEBUG=y
>> -CONFIG_GENERIC_PTDUMP=y
> 
