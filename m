Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEEE2BEFEE;
	Wed, 25 Jun 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848637; cv=none; b=Fnh6xRb5gi4MH0CAIgZVAvwrMaCarYd8hpehQOMCvOdBaQS0LCxAMmP/EU8w7K53gfciUk4i9MKvdu9jmNkcknoUXUyTq9ujnDu8uKAcaBGi1GBP1TsbT3ySscUREn14pb4SsJYN3kobqXGpZPnPSE0nD9AQ9hrD/kggzNvdWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848637; c=relaxed/simple;
	bh=WUP8nXq5KsTHI2rcQ0k70+I98OUUvrsNTfGRLXCoSzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esxZXr/+IAYXE8Q1hGLsKtQnOdOnd9tffDSLIG2ep+abJgIKrmRf7NwgHUNYvQ1URn3xJ15T+TacL3juLA+dLErsc66y6ne5cBxcy8KgRt/1ppw5dH2a54sqEypEqeH/qvK+B+jMIcXE6vOVU58w12jvDcFM/GDDuW2ZG3d4Vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRys55D17z9vDH;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E-qPa8r-zWGB; Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRys54JGWz9vDF;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 87F7D8B7B7;
	Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Tp4ps0JWzqlx; Wed, 25 Jun 2025 12:35:53 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 942C38B7A7;
	Wed, 25 Jun 2025 12:35:51 +0200 (CEST)
Message-ID: <db30beb6-a331-46b7-92a3-1ee7782e317a@csgroup.eu>
Date: Wed, 25 Jun 2025 12:35:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] kasan: unify static kasan_flag_enabled across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
 tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 kevin.brodsky@arm.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-2-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250625095224.118679-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Historically the fast-path static key `kasan_flag_enabled` existed
> only for `CONFIG_KASAN_HW_TAGS`. Generic and SW_TAGS either relied on
> `kasan_arch_is_ready()` or evaluated KASAN checks unconditionally.
> As a result every architecture had to toggle a private flag
> in its `kasan_init()`.
> 
> This patch turns the flag into a single global runtime predicate that
> is built for every `CONFIG_KASAN` mode and adds a helper that flips
> the key once KASAN is ready.

Shouldn't kasan_init_generic() also perform the following line to reduce 
even more code duplication between architectures ?

	init_task.kasan_depth = 0;

Christophe

