Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988C1BD006;
	Thu, 20 Jun 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908464; cv=none; b=WSugg8Wb/2s9TfWvUy/jF8dkD0+low0+3ySq1vizqWMsfElyYQhJznWWZ3tzbzK3mL4E6userBlMpCy1KY9ZxKYtTbHu35PliDHWOPpri7ZDm1KpMFqG737a7mMgV4pq8nFSc/0SL1bU/9UOHxEWcNPZlaf04Hp90+/umY/x8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908464; c=relaxed/simple;
	bh=X8RvfZsDwX1HuokLfVZANOU/YZgt7uFrJznkcLH5SG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmH/YRHaGMYRB5+Jic9713BdZZEazVJNWLYFyQ6p9dSNWvZsYqHlR+0TgoE7TI8/nvAPa3Y4FswFne4gBMLLoUzyY5+0ZsFVyn23z0eCNgPpAdh7W0uWDjbDr6VBrI/OcNPXpZHLONe3qHTN7kZ8Ze52912jrX2QHLe58h670Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQghWg9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQghWg9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78444C4AF16;
	Thu, 20 Jun 2024 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718908463;
	bh=X8RvfZsDwX1HuokLfVZANOU/YZgt7uFrJznkcLH5SG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQghWg9qBgi4835TbD+dPoOdmgJcCwq9mlXvsmUA5UqG5jEoEuaxyHuX9X2YcRouC
	 A1Nv9w5Rl2T/rNm14ozxUBc5HEkT3vHZtpk43c5gEDldDEstHPZb61w9H5czlvEyTD
	 bDCooPk7HICkrbcdtJ3uNbfyoUw3LCrUAwjPDLOkM4pgbe7y38CgotR9e4Z4c0ZWwE
	 VBuJar8XPjHFYFcmhXr17Sv64Hps4i0NIjiDJahymIKgcpuM/LBkPzHZ/w+opZY+JG
	 rZBzohwRkUmMAnkTypKTuwVJM1flNglFcrWA53kdh4PjqTK5SiIfiPh9Y4PE6GqMGe
	 VijAp1Lor/9vA==
Date: Thu, 20 Jun 2024 11:34:22 -0700
From: Kees Cook <kees@kernel.org>
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
Message-ID: <202406201127.17CE526F0@keescook>
References: <20240619214711.work.953-kees@kernel.org>
 <98381dbf-f14e-4b6c-8c96-fb6b97ed46e1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98381dbf-f14e-4b6c-8c96-fb6b97ed46e1@huawei.com>

On Thu, Jun 20, 2024 at 11:47:58AM +0800, liuyuntao (F) wrote:
> 
> 
> On 2024/6/20 5:47, Kees Cook wrote:
> > An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> > Improve entropy diffusion") was that the per-architecture entropy size
> > filtering reduced how many bits were being added to the mix, rather than
> > how many bits were being used during the offsetting. All architectures
> > fell back to the existing default of 0x3FF (10 bits), which will consume
> > at most 1KiB of stack space. It seems that this is working just fine,
> > so let's avoid the confusion and update everything to use the default.
> > 
> 
> My original intent was indeed to do this, but I regret that not being more
> explicit in the commit log..
> 
> Additionally, I've tested the stack entropy by applying the following patch,
> the result was `Bits of stack entropy: 7` on arm64, too. It does not seem to
> affect the entropy value, maybe removing it is OK, or there may be some
> nuances of your intentions that I've overlooked.
> 
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -79,9 +79,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>  #define choose_random_kstack_offset(rand) do {                         \
>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                 &randomize_kstack_offset)) {            \
> -               u32 offset = raw_cpu_read(kstack_offset);               \
> -               offset = ror32(offset, 5) ^ (rand);                     \
> -               raw_cpu_write(kstack_offset, offset);                   \
> +               raw_cpu_write(kstack_offset, rand);                     \
>         }                                                               \
>  } while (0)
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */

I blame the multiple applications of the word "entropy" in this feature. :)

So, there's both:

- "how many bits CAN be randomized?" (i.e. within what range can all
  possible stack offsets be?)

and

- "is the randomization predictable?" (i.e. is the distribution of
  selected positions with the above range evenly distributed?)

Commit 9c573cd31343 ("randomize_kstack: Improve entropy diffusion") was
trying to improve the latter, but accidentally also grew the former.
This patch is just trying to clean all this up now.

Thanks for testing! And I'm curious as to why arm64's stack offset
entropy is 7 for you when we're expecting it to be 6. Anyway, that's not
a problem I don't think. Just a greater offset range than expected.

-Kees

-- 
Kees Cook
