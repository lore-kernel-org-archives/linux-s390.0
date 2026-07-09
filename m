Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5F44999A
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623070; cv=none; b=nVeh6u5zLVUxOKbOmofNSQOFQKui2UL9s+n4IQ+PLlvyZbz3mefvb3Yd2Eky2upfBuwoQpHqM1hZFKg+byF0fzW6z7Zn4CmeltIazPgS+KcP/ZOCwrlHDPpfuKeqk/106hWnFRXl35Bo+4kM8eFrLxnbsg9uPxuiPnQncHjAFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623070; c=relaxed/simple;
	bh=lzP8p16U25+AihhB4pAY2jVwlzeYDWG3z6Eulu2pBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHlJw/n44eAi+aAXd6XMISczYJdMEjld9AIbpO2TreYcBcKXYNZukzf8nD8ccde1vmZjbU6GvKc5ZKBjv24zpUcfh5wHL2vxkfZ7u5iFGn8UQw4SxrcWBFbFmkJEctC63Vrz0tS8/MAmg9QST4AFNBgQpk1NVCtsA2e39R9wRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN4Lxdbu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN4Lxdbu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so142467a91.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623067; x=1784227867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=nN4LxdbuQkIm1frIFQ2Xjm7NJy9RsZ9CPtSEjIprcsRUGu7BdvaAxFR8/rNHO8YA8a
         X1woSb1Nu/xrs8OHOa4JqGM5iSzdNhmHwQxKYmpIasulAW8/8O7le9XWzN1AFwp1WRj5
         8IP7olcUdeE+dttzz+QppekbyWD4pWzL2Y6Frw6JWKkXpOY6G3ZmgAuptd/imHU0UcG2
         CR6IUAA8Iz2OvsZLLSO59oKvCw2zeV/49J75QyROZlz9Qilh8bKGCQrp/MD5+HjNt3H0
         ViN6guEja5TuF6yY0NsB8cmMFWB7pXxfMLxJ2DIo48GamyBpm0M56vpJlJ55xZvSJAOJ
         LOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623067; x=1784227867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=ShrZlPbwxcY+RJetXmbFxjxAlLdQhuuF5NE+cKSaWednl8F8F3h/9uLp4+PMZWkOK/
         sG+cjoulUe+nDoJvbNdbi0mApA7ZH82bWXw5Je62Mc4cdKuozfKRBDib1PQxuVfXjzt7
         yWe9z5ikbOQsi9zV5elbw8Rfv74Wk0HhGCsCceCerqV3rPbuOFdDm5KW7HGQ/2PgXvhN
         FEYLpVmFB+sUEOwHEYihbwUFTG9vfCr5kysEm+MOxI4iAEENsZjQxxWp0OOkhBUEDPVd
         wKZhzaPAR5/PKBZ8vD8cUZAZioZAJVvAa881RY8ZFQ9mol4+IN89EOaa3vXj2+KIE9o+
         4pBw==
X-Forwarded-Encrypted: i=1; AHgh+RqEfwwLJ2lUF+ACUQ81P3nICaqHR5ayFNOyAc3WE8e1yNCV8OIQp5t7yUuCR4K63Vdlxo8pUn4FqSMm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9/WjcMKksYAJoehcUYQZEFQSItzC4T+kBgMyEGbuIK4s2uN4R
	lvXcR7Gw/1L5XeGlu1F02hcJ2xs2XEOIrJIs0RucSAFF59oZpXzqxMJA
X-Gm-Gg: AfdE7cmbPrFq3NLRutJP9Ua4mmP0v4pP8NfUEh0ssEIRirwkxvb/jq/E50Kf/AwU/Hi
	Vjn7vse8OAslO0YavVO6MgWU5piZDQr2IxIpfUdcBucksCPm+5JWQlecSMzjRf1GUsn7Z+yWftG
	5o70OUTgdCT5NAqM6cDfk5ei5Kno4h7jS0H71R43lavVEaNWB95JFIJWm+s8tcOdbH2s127qPmQ
	0SYCgHrMNgPvI4lESFjgMh9qbxmhGQyumedp+uy4j2eGjMu9IvCYYd/BxiAe73DM9YQUNbslK+0
	4LJL8J7XJNj+4o5FoZQp1jNEDnJx9PKnvOqFWBu0GjKU9GyugPWThvHgDfw8LG7t9GD5n3ZVg0y
	lNf1XsPQZ+kB2GaPqXZGXEwzF9KGjmvxRoaIlWGUm7UyldfSginqeXXWgzv7Oa+IqZJshTNDYz0
	LQBDx5+tMoROYBXHaoz8O9STyx9uKl+1WPVK4eiPCzS7KbXCDoADVdXze/PCBX
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38d15876f4amr425299a91.15.1783623066680;
        Thu, 09 Jul 2026 11:51:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33415688eec.2.2026.07.09.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:51:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:20:46 +0530
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
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Message-ID: <ak_tgBEhNxX5m700@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.181086755@kernel.org>

On Tue, Jul 07, 2026 at 09:06:36PM +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long syscall)
>  {
> -	long syscall, ret = 0;
> +	long ret = 0;
>  
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
>  	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work);
> +		syscall = syscall_trace_enter(regs, work, syscall);
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
