Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29D4C97;
	Tue,  1 Jul 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328346; cv=none; b=GplYKt5zKLvyXDHPl/1rpx/t4l/8F/FjN6r0qe4nUr7PCXIEEali9KYGYjtbmK+DO+DxX333LBEWKyFUdIEGJvhl9awM3137VmMYeQuvoP80LLgVfy0NMMDnK98wRkeGGpOGJVjoycGXZGuPQXwKjidkxHg4+7C19wAsumqBMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328346; c=relaxed/simple;
	bh=qPg3TzNq6BpmYEZilw7ZTkiMjD24Iia3o39EQ4M66Vw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bW8WD71yxOIuMJmN6ZMGY7ho6z9GMzcvv9yzPT1lQb9h2FnKPH9BpfK/e4IIRE2AlE77TM+ijuu4AfpbFoOfNgFhTZzLyXecUlxch1m5evyR2MlSVdQM4kqVN/vHR+2M0xKLdvGClwbU3Fbjy0cmiNSxccIDYj3jLSZOBgJHmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XbWONMuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XbWONMuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDDC4CEE3;
	Tue,  1 Jul 2025 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751328345;
	bh=qPg3TzNq6BpmYEZilw7ZTkiMjD24Iia3o39EQ4M66Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbWONMuUrvz7T0Gq7YshVCh4gFQdvVevhuOhWKtFa8TmjgHwkc/w8ws5DNH5TGSks
	 Up2E/6UPAIGTQbT/oyMflhWrYdheKmsjDkuf1SuGhV56uHAYqrE1Pj+gCiIWQWTtKV
	 XJRP+qO/YfjkDDyNSfnZEETNqJc3s8u5cN7tglT8=
Date: Mon, 30 Jun 2025 17:05:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 arnd@arndb.de, rppt@kernel.org, geert@linux-m68k.org, mcgrof@kernel.org,
 guoweikang.kernel@gmail.com, tiwei.btw@antgroup.com, kevin.brodsky@arm.com,
 benjamin.berg@intel.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/11] kasan: unify static kasan_flag_enabled across
 modes
Message-Id: <20250630170542.f4da6e3908f66b822408e699@linux-foundation.org>
In-Reply-To: <aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
	<20250626153147.145312-2-snovitoll@gmail.com>
	<aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 14:31:00 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> > +/*
> > + * Initialize Generic KASAN and enable runtime checks.
> > + * This should be called from arch kasan_init() once shadow memory is ready.
> > + */
> > +void __init kasan_init_generic(void)
> > +{
> > +	static_branch_enable(&kasan_flag_enabled);
> 
> s390 crashes at this line, when the whole series is applied.

oop.  Thanks, I'll demote this seres to the mm-new branch for now, which
takes it out of linux-next.
