Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34D13BAE3;
	Wed, 26 Feb 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574206; cv=none; b=tR6/C0KIMBVrdO5m11npcIr5K+FlidLP93hKF1FSXMGLYCAxVzlmKOaYyon6ktKxpL+1lemkhju3MKWCWL/h1Y4YB6EzyzTdwklCV82sQmYBc21UPowVLBFdLppQaezz5fuYAiuAY/j4HyAdaTv+7mP+oW6GQ3dQUz+zwx04a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574206; c=relaxed/simple;
	bh=D4CfnLGRRWil1JbQ8gsJ3k6bmBQY0jBa0w65O6jptmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msKMJumw0Ru4SNsOnwNHbb/cn/ymZRcREtTCQBo+y5l/khU7FGZI2kMeGxHc8EMsB0FMAGHqbOc59NhJV9Pgf/0mvI1DG/FXdD6VRy/K31pYFM08djQNLbzQSlbV5uTVerEcwWnEE5tnNi5uIGE/P7iV6praMa8At2GLE6M3VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z2v3t6vSKz9sSN;
	Wed, 26 Feb 2025 13:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPLDBYGk5ZSX; Wed, 26 Feb 2025 13:31:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z2v3t62h2z9sSL;
	Wed, 26 Feb 2025 13:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BBC958B78B;
	Wed, 26 Feb 2025 13:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ep8JbNxoBOZU; Wed, 26 Feb 2025 13:31:54 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 85E558B77C;
	Wed, 26 Feb 2025 13:31:54 +0100 (CET)
Message-ID: <c58f3fef-82a6-43a4-a222-1cc8ab62a93b@csgroup.eu>
Date: Wed, 26 Feb 2025 13:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/5] mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Steven Price <steven.price@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
 <20250226122404.1927473-5-anshuman.khandual@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250226122404.1927473-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/02/2025 à 13:24, Anshuman Khandual a écrit :
> DEBUG_WX selects PTDUMP_CORE without even ensuring that the given platform
> implements GENERIC_PTDUMP. This problem has been latent until now, as all
> the platforms subscribing ARCH_HAS_DEBUG_WX also subscribe GENERIC_PTDUMP.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   mm/Kconfig.debug | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 41a58536531d..a51a1149909a 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -186,6 +186,7 @@ config ARCH_HAS_DEBUG_WX
>   config DEBUG_WX
>   	bool "Warn on W+X mappings at boot"
>   	depends on ARCH_HAS_DEBUG_WX
> +	depends on GENERIC_PTDUMP
>   	depends on MMU
>   	select PTDUMP_CORE
>   	help

