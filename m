Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F0BA2D;
	Thu, 13 Feb 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433004; cv=none; b=V76DZZHf+BJ3wSxYuJadJsdTdBBPpf8zPXdOKKntBX6nu9aJQQfgTYsqEolRLTV6JzCv89gHuWjLOs+02ZnsigO7rpyWvXvStqs8IkvV6uFKQ7dS0/rF28pm5LY5/yrXriLNcEV+ZdxSS/AZDBXbP8hF+fuPTZDFGTo+jTz8Fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433004; c=relaxed/simple;
	bh=8vEQPFHBDDR3kcrsGok7FxRUhuyD9I92bB1DBH+e6EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idtpHFCQiST4KF286iMVZfiP6CKUe8YhupB0SbmU356/tKbJSeYatRu4tPK/sZvL/2fhks9WRWAlFtmsF/BZM2fravTf54MoYiEBStTb3NfRJy8vS/eY0iwD0ABoQy0pTr06ok225Nz88lfDFGvLFfZXegR79kyHHYqopOutlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Ytn9Z50cpz9sSC;
	Thu, 13 Feb 2025 08:38:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zu_4Dd552sBQ; Thu, 13 Feb 2025 08:38:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Ytn9Z489bz9rvV;
	Thu, 13 Feb 2025 08:38:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 883988B770;
	Thu, 13 Feb 2025 08:38:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LjIk626zRboP; Thu, 13 Feb 2025 08:38:42 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E8148B763;
	Thu, 13 Feb 2025 08:38:41 +0100 (CET)
Message-ID: <4fa83d76-117f-41bc-9137-676fb0c204dd@csgroup.eu>
Date: Thu, 13 Feb 2025 08:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: steven.price@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-5-anshuman.khandual@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250213040934.3245750-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/02/2025 à 05:09, Anshuman Khandual a écrit :
> Platforms subscribe into generic ptdump implementation via GENERIC_PTDUMP.
> But generic ptdump gets enabled via PTDUMP_CORE. These configs combination
> is confusing as they sound very similar and does not differentiate between
> platform's feature subscription and feature enablement for ptdump. Rename
> the configs as ARCH_HAS_PTDUMP and PTDUMP making it more clear and improve
> readability.

For me GENERIC_PTDUMP is more explicit and similar to GENERIC_IOMAP or 
GENERIC_IOREMAP or GENERIC_GETTIMEOFDAY: The arch provides the necessary 
helpers to use the generic implementation.

For me ARCH_HAS_PTDUMP just mean't that an architecture implements 
PTDUMP, it doesn't mean it does it by using the generic infrastructure.

For instance, arm32 implements PTDUMP but without using the generic one 
so I would say that arm32 has PTDUMP and expect it to select ARCH_HAS_PTDUMP


