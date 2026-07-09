Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C033AD531
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621969; cv=none; b=OznM6/QS1tmNMbQmA++5DMN5plGbyzkRBYm0yu3pJOTjac37/ejXDV1R3LF5kqAMVoCrRq+d5tVDI/srjHzzau+6Ejl8ACuTcOsIwv87H3J4d3rFbtWQOixKdPrDNI7vdWkl8rzbuii2zBX2tRdZKJuly6rvf9MzUGPL2Snvv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621969; c=relaxed/simple;
	bh=CuadLq4gnh6A+s/YbTQsNOibHt22WuOTEhntcyj5qbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VggngBifPitcmTxJM6bL+r1A66hpUBAePPW+XvVAdlXSE1SnO91zTMKfqqFNLSD3/dfuFK9EvgLGwdYSJ9TQNtncL1V2aIA8LwkJx06/IpXRP1fhC//7rnu/q+oTQ2/67+myVbBOtqAqwq2xGZl4+2RyE6jUzgAWbej8jUmN8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKKjRbzx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKKjRbzx"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso111836a12.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621966; x=1784226766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=aKKjRbzxD3VvkX91f450mu0qGzh3MkTWZxZjFpU8QBS9RJ2aHXRao0+SBr364fUzLy
         MoMKNfl17ck57HG5myXTcazs5gPo7G/JvCpWah3WwIu9GMxwM+5Wwe8niZ7S9JuP8Omb
         AFV46zyJO1SaPeVrpXoylVLJpj49CmvC2NljFxVsEAA6dSIhEEf+CKaHLPuU2RRs/uSR
         V+eZn/QCT14zwbZ1pVC2O54LdOMhECIpBrhjsmaJClG8+lNfnDuWMWHNg0qyRyGQtYtZ
         tXP4pk91IiSv2h30ITACZdmvMPCmZOLP6Ewksq5pghVwyrs+e/IWmQsqRtxsVLStc5vr
         BdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621966; x=1784226766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=jfb7yxMiIXxKCSt+4We+7A9tWF7fdH5BW1HvEgcyXP2uEG6pihz6NSPaqh2UQpler4
         G/YfrajoGoQY+8+FTEqV8tflQAdWEuZKyMyWR+NgSaT3/Jud7qjkrA3b7hlaYqRRMnDs
         6Q8XVOuB48dJ4E0Fi1JjBqAFZudWCM0NShgQ/fsGW3pZrtS9qFqMBFphj2OPSeAFPZmU
         ZEeZ+exjaHc8zYAWdpy/uS8fkM8jHUuAKMfp935WZSPQLwmFm6Ph9iB1/KTiEa0+WU9R
         BwS8mLhLiVzE9CDpV/PaZ9Ge6qxhdtUe95UXm2kR93zXvlEWqyaGiV8ZAmVFScXOmURw
         3kSw==
X-Forwarded-Encrypted: i=1; AHgh+RpJkIrepcq8+tySEw3J+mDOh86jEvXzPLCtkhaTSq/X5OtB8kMTTo80wv4V9iDfc1GXrndugD0Dh9Za@vger.kernel.org
X-Gm-Message-State: AOJu0YznZ7MPEnFkEqdv727WA3DhkdaJHVkEPQgGJmArdyAhZrIWGRK2
	cZ+vTxYBpX3s1OVeqbYnF4bQt87VoECHIGWh8URbfusV0FfjiMpCj7Nk
X-Gm-Gg: AfdE7cmaq2Mg7pmTQiHiHFSa0j4kKHxSzqt32RfoGsAdD9Sz6y6J8RElYYmdqRK9h42
	g5j2+1JU4I2I9iCVMlQyAUH5A+yf7smue0VTYxlAGpUUyoHHL070p7LMDfgAad+YftLDfh/4hgf
	hW5j3kx2P2C4nWmgFLnh1RdJKK74IrYkYIwvk0aTgJt6kuCy9IxxpYKOiueb+8mPBEqorHD/rXR
	JwSVRZ6U4db2VFyNjQXbkxtuSPtKn7K8E6xY/L+RefhlAkGJP2t54mrWipS9Nh0WwgN51+E5Av1
	xwikqHVyTL5JfSgP4mNr1TS7eHQhOgargU3wDNyKjSSnzFLudY5WnbG0VkiVNfSZG5lYrzslUtq
	AwE1V9Gfs5c0Oweup5KJ+T3BziBZz3++467VqAfzdVpiUbX22Wcfn5SuQWQ+EcyRPh8xOPyGTzr
	zdvnzAINLJ1phXBgrM1TuxUeQrNppeaAYWcYFhEhywBR5iWXWJgDoMKH7tyJaAglD9hdcXLmE=
X-Received: by 2002:a05:6a21:3295:b0:3c0:9c18:d5a7 with SMTP id adf61e73a8af0-3c0bd1c4948mr10580989637.68.1783621966489;
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm55669365c88.14.2026.07.09.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:02:27 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
Message-ID: <ak_pE64J_xnLQBMd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.718191130@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.718191130@kernel.org>

On Tue, Jul 07, 2026 at 09:05:58PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Thanks for fixing this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

[...]
