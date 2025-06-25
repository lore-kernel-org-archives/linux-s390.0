Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC112DAFAB;
	Wed, 25 Jun 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848647; cv=none; b=ddTGu6/NvOlLdr4TmPlL/OjFNFzizAvWy/hgrSYmiioCCxbkXacctUbwgJv7wefJ+sqUFDK74+RHzDv4b4svQcNeCx4by+A7yZfTf7ZTA9T9kdmAQ8ybJZjo7UErsvY5RzPBfJFi6XBJErSPJx6dfHVpUw5fNVnB4cKPpnk6dRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848647; c=relaxed/simple;
	bh=ApxE6M1Ke6N9jdaZibKhAIInp2ndrZn6PPTj4Ntr1CE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WpcAZOZG+HemUiZpAgaEOiGaXKPcHIUMespFFt5ecVd/QRfiS4i4+s151uqtDpFNtRwWUWbFy1K1kW6ygqwsmdqOUIffS4ZZriJMAvEJMGfiPIQi7mcRNZO2Okluww+GkHBeeYz1oaWSHCkpJnoYm3fUBoXYZYev043xyVnV4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRyfz3MTKz9vBt;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2o-Y-FdKUAQ; Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRyfz2RdKz9vBC;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 435058B7B7;
	Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vvosXbHhLt2e; Wed, 25 Jun 2025 12:27:07 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BC418B7A7;
	Wed, 25 Jun 2025 12:27:04 +0200 (CEST)
Message-ID: <750b6617-7abf-4adc-b3e6-6194ff10c547@csgroup.eu>
Date: Wed, 25 Jun 2025 12:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
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
 <20250625095224.118679-3-snovitoll@gmail.com>
Content-Language: fr-FR
In-Reply-To: <20250625095224.118679-3-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
> Drop checks where the caller is already under kasan_enabled() condition.

If I understand correctly, it means that KASAN won't work anymore 
between patch 2 and 9, because until the arch calls kasan_init_generic() 
kasan_enabled() will return false.

The transition should be smooth and your series should remain bisectable.

Or am I missing something ?

Christophe

