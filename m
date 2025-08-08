Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618AC8F6E;
	Fri,  8 Aug 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639437; cv=none; b=KYjsqVeLMS6jm181j8hrnEOg5sSysx0K5o5T+d5X33IEl7C+VEL3bV6FN3qaoH02M/on+APG+5e9lUbl33LYw0Ye8TxxTjhgJqhEgdvBEeYku4ORNGzoFqPCjxqXVHPFtZwJu6QEhQSX/EZjsnMsuOMpbx7p3LjyDBIs6rdCFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639437; c=relaxed/simple;
	bh=PTBUnvgYofk3T2KvTUzNAupS8RDnaET+hh5Nt05Oem0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDKsxkWUL4R27MktGSGAS0HxZwTjaKvcfwBPd/BKFHBAkw7i36Mb5a15Fch2Gg8XjTRubD1ybfOkqYYKWMBe6skHZRlCoF+6akZg4JUG549+b7flwpz0nTEbntYkmQV/aQC+rWYULMVFsciqWDdy2wqZ5MpIiYvUfOaS6b0yzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bywkg3Mhqz9sS7;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-UTSoBBRo41; Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bywkg2Vk1z9sRy;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F40D8B770;
	Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UAt1KEdP_5VW; Fri,  8 Aug 2025 09:33:47 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F8218B763;
	Fri,  8 Aug 2025 09:33:46 +0200 (CEST)
Message-ID: <59ce87be-0a0a-4f6b-b439-bc7a4a037fc2@csgroup.eu>
Date: Fri, 8 Aug 2025 09:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com
Cc: bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 davidgow@google.co, glider@google.com, dvyukov@google.com, alex@ghiti.fr,
 agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250807194012.631367-1-snovitoll@gmail.com>
 <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu>
 <CACzwLxiVURgamkv2ws5sK9BQVMz7VPSWGy_aQb+MT8jtv03d3Q@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CACzwLxiVURgamkv2ws5sK9BQVMz7VPSWGy_aQb+MT8jtv03d3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2025 à 09:26, Sabyrzhan Tasbolatov a écrit :
> On Fri, Aug 8, 2025 at 10:03 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index 9083bfdb773..a12cc072ab1 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -5,6 +5,7 @@ menu "UML-specific options"
>>>    config UML
>>>        bool
>>>        default y
>>> +     select ARCH_DEFER_KASAN if STATIC_LINK
>>
>> No need to also verify KASAN here like powerpc and loongarch ?
> 
> Sorry, I didn't quite understand the question.
> I've verified powerpc with KASAN enabled which selects KASAN_OUTLINE,
> as far as I remember, and GENERIC mode.

The question is whether:

	select ARCH_DEFER_KASAN if STATIC_LINK

is enough ? Shouldn't it be:

	select ARCH_DEFER_KASAN if KASAN && STATIC_LINK

Like for powerpc and loongarch ?


> 
> I haven't tested LoongArch booting via QEMU, only tested compilation.
> I guess, I need to test the boot, will try to learn how to do it for
> qemu-system-loongarch64. Would be helpful LoongArch devs in CC can
> assist as well.
> 
> STATIC_LINK is defined for UML only.
> 
