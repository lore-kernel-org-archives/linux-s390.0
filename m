Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38076227EB4;
	Thu, 13 Feb 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449207; cv=none; b=Pe0fqFNyOGEU//g/LVTnukcMx0nqdghUC+lSmwdZBZTClR62ipKFgXkPEpai5udyQjIKVL7I8AViv3jUsYYU6gBa+TuT/5MbL7ggXroEwUAvyI23CVh0g64Fr3E7Zdf8wuXUHkMdciMez6GjJHOLt/olbQOFCa47TaEbNI4q/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449207; c=relaxed/simple;
	bh=gwLcUsDw7xA/2Q1IvCXJOzT7YL+8moGeHio9YFBywVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5LOfn9YUfArECmlg36rf86L+RFU/0Hq1bdz8ja6MdPzPIoqtuO7Z3Gr6ZV9oQLGzRKx3Xkb1kKJ7S/e3UhK0Oqnj9A9doqucjNaZmXF2687+o6hprwjeMokzd4+Gh5X8HhLjXjLxgO1fB+NXIyKrXS0mQTo0syzhJrm5kRQTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Yttkn0dgsz9sSd;
	Thu, 13 Feb 2025 12:49:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULQcwcXgFYio; Thu, 13 Feb 2025 12:49:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Yttkm6p6Zz9sSL;
	Thu, 13 Feb 2025 12:49:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D2E088B770;
	Thu, 13 Feb 2025 12:49:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TnojPLtBnGgu; Thu, 13 Feb 2025 12:49:20 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8115F8B763;
	Thu, 13 Feb 2025 12:49:19 +0100 (CET)
Message-ID: <6e1201a1-60c1-40a3-951f-d603b6341a11@csgroup.eu>
Date: Thu, 13 Feb 2025 12:49:19 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Steven Price <steven.price@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-5-anshuman.khandual@arm.com>
 <8e75c5ff-a97b-4a6f-9c8b-ac2598eafe60@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8e75c5ff-a97b-4a6f-9c8b-ac2598eafe60@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/02/2025 à 12:23, Steven Price a écrit :
> On 13/02/2025 04:09, Anshuman Khandual wrote:
>> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
>> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
>> is confusing as they sound very similar and does not differentiate between
>> platform's feature subscription and feature enablement for ptdump. Rename
>> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
>> readability.
> 
> [...]
>> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
>> index 77306be62e9e..db005618690b 100644
>> --- a/arch/powerpc/configs/mpc885_ads_defconfig
>> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
>> @@ -78,4 +78,4 @@ CONFIG_DEBUG_VM_PGTABLE=y
>>   CONFIG_DETECT_HUNG_TASK=y
>>   CONFIG_BDI_SWITCH=y
>>   CONFIG_PPC_EARLY_DEBUG=y
>> -CONFIG_GENERIC_PTDUMP=y
>> +CONFIG_PTDUMP=y
> 
> I'd suggest dropp this from the defconfig too, just like patch 1 dropped
> it from debug.config.
> 

Thanks for spotting that.

That one is wrong. Was introduced by commit d210ee3fdfe8 
("powerpc/configs: Update config files for removed/renamed symbols") 
which aimed at fixing commit e084728393a5 ("powerpc/ptdump: Convert 
powerpc to GENERIC_PTDUMP") but it did it wrong.

It is CONFIG_PTDUMP_DEBUGFS that is wanted.
