Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228C3B19B7;
	Tue, 26 May 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812357; cv=none; b=itxdztiWLroq5jADMuo3NCHnl6vGkc9bC3WNnuzhjmY2xfTfgW03rnyC7ldGzn6Ie4UABa/Hc0zZDUKP2unMPAOPAblpWfYhX9o5J/HPm7zkA9brxU5/eUHzc5gYooh2X4MuqQaYSTdCg9m6fDu6VP7/bTbDepp4Vl5C2qMWLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812357; c=relaxed/simple;
	bh=dXTt1/BNFKEIsvObIYoVeEbSzI6qvqdsnRC5y7Qr5eI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HjxvNhv+wVNEcR6Kq8U9A0D2US6GIwBv1LQZ66VXaNEci5uhqX2jAO6qIpz8jtKgFLvxJqY3KjMzdNve5zihJGICCszRBAiBRtZvw4RKHmNp1xVQmS824wIW9lx5KdpAxHMJ1/2bi5l5Uc9zb4qx7/rEK41Q78aDNtJV0/LJRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sglml3+h reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sglml3+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C251F00A3A;
	Tue, 26 May 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812353;
	bh=5SkN1TCAV3N8KFPanxpJeqssiy4h9kR0l/w2B37WK8E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sglml3+haM8qJZ9vSTtJSlZa5SxfhKaBRf9IdPeA6oEpPtA8GEFOK5svfmw27mTab
	 Gseoc94vtic5LZ6qdEiGdamwlxAUk4fpVI97K/xIvEisLoqM+K/NnAwg444GpVnOrC
	 nXl/M0mOvYDTzFTLxvkbiqhGpv+PABEgVAyZW/bvBNKVH3D91649Vm/BaNneH8xOFX
	 WOL84NTnT17Tp9MZSkbBCsUqV0xIj7jc0QiwRKHCTCUva2HNYUeS2rVWcJtu7r3YNw
	 qkA+kGp4rxNWrEOdS6ogbef8ulrRKU7ORKjBjZD/h1fNxGsi3BRZpbOArGM5BcuaMM
	 Lx70DZzjgyFYw==
Content-Type: multipart/mixed; boundary="===============0782269710716244881=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b24386ec0b31b63dc8c46477712fd4946306034ec9d17c461e59c2132e4f1bf@mail.kernel.org>
In-Reply-To: <20260526152148.30514-6-boqun@kernel.org>
References: <20260526152148.30514-6-boqun@kernel.org>
Subject: Re: [PATCH v2 05/12] irq & spin_lock: Add counted interrupt disabling/enabling
From: bot+bpf-ci@kernel.org
To: boqun@kernel.org,peterz@infradead.org
Cc: catalin.marinas@arm.com,will@kernel.org,jonas@southpole.se,stefan.kristiansson@saunalahti.fi,shorne@gmail.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,arnd@arndb.de,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,boqun@kernel.org,longman@redhat.com,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,ojeda@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ruanjinjie@huawei.com,lyude@redhat.com,thuth@redhat.com,sohil.mehta@intel.com,xin@zytor.co
 m,pawan.kumar.gupta@linux.intel.com,nikunj@amd.com,joelagnelf@nvidia.com,andriy.shevchenko@linux.intel.com,rdunlap@infradead.org,ynorov@nvidia.com,bigeasy@linutronix.de,linux-kernel@vger.kernel.org,linux-openrisc@vger.kernel.org,linux-s390@vger.kernel.org,linux-arch@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,rust-for-linux@vger.kernel.org,work@onurozkan.dev,daniel.almeida@collabora.com,boqun.feng@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 16:19:12 +0000 (UTC)

--===============0782269710716244881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 241277cd34cf..9d6012ac929d 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h

[ ... ]

> @@ -427,6 +444,11 @@ static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned lon
>  }
>  #define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flags))
>
> +static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
> +{
> +	return raw_spin_trylock_irq_disable(&lock->rlock);
> +}
> +

Should spin_trylock_irq_disable() include the sparse and clang
context-analysis annotations that all other spin_trylock_* variants
carry?

Looking at the other trylock variants in the same file:

spin_trylock():
    static __always_inline int spin_trylock(spinlock_t *lock)
        __cond_acquires(true, lock) __no_context_analysis

spin_trylock_bh():
    static __always_inline int spin_trylock_bh(spinlock_t *lock)
        __cond_acquires(true, lock) __no_context_analysis

spin_trylock_irq():
    static __always_inline int spin_trylock_irq(spinlock_t *lock)
        __cond_acquires(true, lock) __no_context_analysis

_spin_trylock_irqsave():
    static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
        __cond_acquires(true, lock) __no_context_analysis

The RT counterpart in include/linux/spinlock_rt.h has the
__cond_acquires(true, lock) annotation:

    static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
        __cond_acquires(true, lock)

And the underlying _raw_spin_trylock_irq_disable() in spinlock_api_smp.h
also has __cond_acquires(true, lock):

    static __always_inline bool _raw_spin_trylock_irq_disable(raw_spinlock_t *lock)
        __cond_acquires(true, lock)

The wrapper spin_trylock_irq_disable() in spinlock.h is the only place
where these annotations are missing. This would break sparse static
analysis and clang's thread-safety analysis for this function, causing
inconsistent static-checking behavior compared to all peer trylock APIs.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26458754996
--===============0782269710716244881==--
