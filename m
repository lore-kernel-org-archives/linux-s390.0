Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7DE55A;
	Tue, 16 Dec 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873659; cv=none; b=hQOBUD/qLv058UmIxc2jTVPqIiuEi5RwH5/cP4rXAwdBoclmnqRkYbJx9LImkIPjQtisrqnxqzdBa8AajL0vDqRN5MUDZL/8K4L0WkyPLryR/7aTKBIRyJDwESREXsqPK1c0xddMr7MSwnXs6YDTXpXMFouiTq5g4wW1P5eR/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873659; c=relaxed/simple;
	bh=rE9Ya5hAlvxFBkqWRdp1h1Tw4atfvwW4q7E/otCHqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcrilEhQmbgWf2hIZA0puSJdCc8dR4buVE+Xx2gcQHDd6KlVLzGrukaMcwH20gPrukzpW/60szYgNAtchYqoFmrJBfrQhCIVBjiBQMJRXNPpg9v1w8VbYWVuzu4EZRkmrEvrimvX9yzCJnkePDGuPV53sBGSYQaiY+UOPphcCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpH0ju1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpH0ju1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B5C4CEF1;
	Tue, 16 Dec 2025 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765873658;
	bh=rE9Ya5hAlvxFBkqWRdp1h1Tw4atfvwW4q7E/otCHqMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpH0ju1F8NUs3civI5pVZ0tGQuWRgVmJea/HUdFrdPkxzabRyvvWngSvPwbNCTYPM
	 LJhIccwNtxPnFVZsJpjcpGl6URl9HoPyZlVGLkXNQioxIxUlUHqExaKN17uE1o+paN
	 YIuIEHbyBtzPN2eAcDgL7HhmXY/jt4Sh4cJXRHafAOdEeo3X/RvSkX8KvfVxqYwkN0
	 JX856NBteLWPccrXuACAGyV7qGbQ2wZXIYL2a0xP9lOzCYR16+RdIzhXRdd/aRzbla
	 ShNeBUsczzSfo6Dy7whFpMq3VOLTjncclOgtP5L92fUVPRhMUtuHyyH7Dk+zoItnnq
	 rMHeQFc4RhbtA==
Date: Tue, 16 Dec 2025 00:27:38 -0800
From: Kees Cook <kees@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <202512160024.B688A8D0@keescook>
References: <20251215163520.1144179-1-ryan.roberts@arm.com>
 <20251215163520.1144179-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163520.1144179-4-ryan.roberts@arm.com>

On Mon, Dec 15, 2025 at 04:35:17PM +0000, Ryan Roberts wrote:
> [...]
> @@ -45,9 +46,22 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  #define KSTACK_OFFSET_MAX(x)	((x) & 0b1111111100)
>  #endif
>  
> +DECLARE_PER_CPU(struct rnd_state, kstack_rnd_state);
> +
> +static __always_inline u32 get_kstack_offset(void)
> +{
> +	struct rnd_state *state;
> +	u32 rnd;
> +
> +	state = &get_cpu_var(kstack_rnd_state);
> +	rnd = prandom_u32_state(state);
> +	put_cpu_var(kstack_rnd_state);
> +
> +	return rnd;
> +}
> [...]
> -static inline void random_kstack_task_init(struct task_struct *tsk)
> +static int random_kstack_init(void)
>  {
> -	tsk->kstack_offset = 0;
> +	prandom_seed_full_state(&kstack_rnd_state);
> +	return 0;
>  }
> +
> +late_initcall(random_kstack_init);

Doesn't this need to be run for every CPU? (And how does hotplug work
for such things?) And doesn't it need a get_cpu_var?

-- 
Kees Cook
