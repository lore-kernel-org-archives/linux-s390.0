Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823298;
	b=BwPLC+dJbfYCAnkPTdtBq4hiuJ92q0YT2KHcPxSEdYEvRxmEwuCcGbSLKI473lkGtQ3d
	 ssRVlq8s1L5mvuT0LhsU1voOvU3oMJWimkhKnxppmndrnw3xi8g99mg6756izjcGth40T
	 SX7H2qyI6gaSpoMuPLibCYFijYBmnA3ZFhtdUfPnjpEThXDM11OyHBB2FHxCeIWT2x6ZQ
	 ZqwdEAJtc2LCOHoZMligrS3MVyuApYK/b8lGAVtyQJ9jpmktL81wQkaMsF9ydhi6RLD9N
	 R/YGzh4RarQuU8lwv0Kfxu84+6Zx8M/94S9nyFEYzXM5v5O33XxShXX6iBYYdELjRsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:
	 In-Reply-To:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
	b=byRj7teBtCVTNUt0ZSYxw0YBYHFHAt+6uwJPtddSrclsJHHAmCsMDMnFmIUPHJ1nmN6F
	 i4I3p2d4Lg74MN+w6iEmNVgaAGJjh+fTOrpJl8OdfKtVkfOx09TKaG2/M0rCwIxBU98mj
	 M/mjEKP3BUaafc9/nQ4Mqzlow4M4GzWLaMYSmPays55+JAx6kvZm08x78mcbghMX/dXYM
	 YYaUUk15y3JFuHz0arWZnvCmRJGQ/soZI2ekvdk0I5Go++RuFVfaX+jxzDsbyUdI4B57t
	 BWjx7JPCTRpUQe0a2iTQY7higR+kOS9g0HoeeZ8SmiFJRwfSak9FWaqsxC20RuKt/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WOmd94Mh;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0160A5BD7
	for <linux-s390@vger.kernel.org>; Wed,  4 Nov 2026 20:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A0160A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WOmd94Mh
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1961056eec.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2026 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793823296; x=1794428096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
        b=WOmd94Mh+1IsHCPkayZDec6JPAxqUizBUQICw7d1GTvFYhvGyIcRDUYVGA4mrhJ2Gw
         LlwBfvWxf6C/dkbd/wYeCVyGFNqSQNTNemKeHNozM+B3thODy6YTQUG8zPI+Zc0fLAsc
         ywPjVR6u2U7pkPrIYEEEE7pR/Fv2GUmpGF5C6hZYbFhN+xzjvjlTlZgt1yXCOuMk8ZV8
         7dgvN0RspKuuDt9X8QL4OxxBptYW7RdbVtxUU3AipSC6ioGA6dVwnv5HTegyIPEZQbol
         lNJjqnZui4CPRajfzE+ydyWOkaI+BYJB/fWwmMyfr6ch4/bN/0JzLGDra0aJW3LNaEPF
         9UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823296; x=1794428096;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
        b=ik01v/3P4MX319peM4UG6LduwgK4CSRmop84Jn+pZh9k5S9RR8un3F6J59EqRXgLiX
         XbmZB6ay5lWdWr83VNfRE0jEh5L3GUp4c7iYQ/qEfAxKSqbmOHTCfPTnVGXnxrS7DGUX
         d2W+S7Eik3ZBSWCOP8JEtWQVnSGAI6YMMPxAKw0x0+mtpHDg7+lhmesEM1IjRIBjGFSJ
         JWZDCFmnRBqtHv3go3+OrsUlpp6tE0V6I0Emzhqveqg5/uQ69gh+xHhXdEaSrEAsCD7a
         ZtziUTCj0oKRPbaLmrPY66VMOjGXRVsROYHiPCzQ2uXWx2WTqIqK0r+l3LlDrZs03PHc
         yXvg==
X-Forwarded-Encrypted: i=1; AKwUvByFhm/mmaxaMkZUJXzDkGZRPL0ZWx8NvjJOL+ZFOgaAjrEWeTpAE/DXorT3+sQRs5yyDaeXGp6CAQbD@vger.kernel.org
X-Gm-Message-State: APuU4Z86SFWvMyZYiBN8ZZkxbA59t1sruh84zx49IgLyd0+IXfGfVZ8y
	Uge90t6JLrCKf4ECkW13nF4W7emdLRHwvZnhDmaXBsGhjsW1PjqcMfDwgLZE9+e1kTtoCZEtl4Y
	ZcU/mVw==
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dybkf8.prod.google.com ([2002:a05:7301:3a88:b0:36a:e67:fbc2])
 (user=jeffxu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1608:b0:185:4ad4:3d15
 with SMTP id a92af1059eb24-1ac56302329mr19203878c88.1.1793823295901; Wed, 04
 Nov 2026 12:14:55 -0800 (PST)
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
Message-ID: <18e4f0c895c8d2ed.3137322e32382e342e3434.27cc5b.0000sendgmr@google.com>
Date: Wed, 04 Nov 2026 20:14:55 +0000
Subject: Re: [PATCH v2 0/8] mseal sysmap: Choose system mapping sealing at boot
From: Jeff Xu <jeffxu@google.com>
To: Chris Down <chris@chrisdown.name>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Kees Cook <kees@kernel.org>, Andrey Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Shuah Khan <shuah@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Tue, Nov 3, 2026 at 11:17:43PM +0800, Chris Down wrote:
> System mapping sealing is currently a build time choice. Hosts which
> want it and hosts which need to move or unmap these mappings therefore
> need separate kernels, which is not ideal. Let's allow the administrator
> to choose at boot time.

Thanks Chris for the updates and for adding the unsealed boot parameter
test coverage! The v2 series looks good to me.

Reviewed-by: Jeff Xu <jeffxu@google.com>
