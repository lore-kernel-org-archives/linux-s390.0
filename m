Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120E490C11;
	Tue,  1 Sep 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287672; cv=none; b=QwKh2OZqLfscHyQBoY2mfu03lsLrIYJAv+x6Wn9hDIZ0kBPzRvJCIUa+bI1ewfU4kz1ObdSShRu3v6tjTZBmUBN+xPud0SGBcbbome1lkeD/HmmMOI6z+APG9/Y7PIKJ88YLU7AJOfBF8SkQTpTG8ResqlJujlq2NmkXAoPFZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287672; c=relaxed/simple;
	bh=6A7lRGd1Nf8Eah3+weAvl77S4z3C4FqpM3ANeMmkBsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfWd1Luw7A84++GGIUBLWlntYLFdmqV2SExYUbHgk5cn9OH+X1X2CXFTL6aerYrzuWLJRoYXovnEm4Ux2QmKEcprPZQjsMtis31UeebmojsZpCM5NZk7ZHfP7Jfu4/dY0hCu8ExncGBULjO0/HQkpehSjhNPZW4EkeSGgnT6Nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ixn95t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ixn95t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDF1F000E9;
	Tue,  1 Sep 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788287671;
	bh=5NXgbY7RzU8g0Kf53Luap+wGnaz+b4K8573/iOsTQ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/ixn95taCRJGX4PAMNj/C2sqsS1ahSoeW9hr3nqYKv27L2TmqCZFfi1XeScTVlf+
	 cbstwnjn2a3/FJPdPre8LRomsAIgGvRkr30ufESK8Ikz1ihAT1e4EFZlbXk2zU8HLl
	 ICHHFQtXJZxvByz5b71CGGjk2IP+1XjSgOlMXEDq0LNZLLkh8BQHNzaOGHep5rMr7n
	 9ox1IiG5y5PYzg0A1y8r0QUfK0PPZkloaruwpOABRYG2htBc6Pz48lBnz1ZlV+utDZ
	 Iq+UfKLLwTr8PX+yV+aVmPr3HM7CzjtIchVC9ohRkL51kOj3+kssxJRDWicb2pXwkp
	 blNMtbtGrXCJQ==
Date: Tue, 1 Sep 2026 11:34:31 -0700
From: Kees Cook <kees@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>,
	Renzo Davoli <renzo@cs.unibo.it>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] seccomp: Fix syscall skip logic on ptrace
Message-ID: <202609011132.F4A3EB7103@keescook>
References: <20260707181957.433213175@kernel.org>
 <al9NlZi20xHMvla2@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9NlZi20xHMvla2@kunlun.suse.cz>

On Tue, Jul 21, 2026 at 12:44:37PM +0200, Michal Suchanek wrote:
> seccomp takes a shortcut here. When the syscall number is re-read after
> ptrace and the sign bit is set in the syscall number the syscall is
> skipped right away.
> 
> This works fairly well on x86 where the return value of the syscall is
> preset before seccomp is processed.
> 
> However, on some architectures the syscall return value overlaps with
> the syscall number or syscall arguments, and as a result the return
> value cannot be preset in advance.
> 
> For these architectures seccomp needs to exit without flagging the
> syscall as skipped. Then processing of invalid syscall number in the
> architecture code should set the return value to -ENOSYS and skip the
> syscall.
> 
> This introduces a change: If the syscall number has the sign bit
> set, such as -1, previously the filter re-check would not be done, not
> applying the filter after trace. Now the re-check is done both for
> syscall nubers with and without sign bit set. This would only make a
> difference if the syscall number or the filter was changed by the
> tracer. Otherwise the filter would be resolved the first time around.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kernel/seccomp.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 066909393c38..9e40a38aaedf 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1318,11 +1318,8 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
>  		 */
>  		if (fatal_signal_pending(current))
>  			goto skip;
> -		/* Check if the tracer forced the syscall to be skipped. */
> -		this_syscall = syscall_get_nr(current, current_pt_regs());
> -		if (this_syscall < 0)
> -			goto skip;
>  
> +		this_syscall = syscall_get_nr(current, current_pt_regs());
>  		/*
>  		 * Recheck the syscall, since it may have changed. This
>  		 * intentionally uses a NULL struct seccomp_data to force

Does the seccomp selftest still pass with this change? I _think_ it's
fine; this just induces more work on a tracer-induced skip path, which,
in theory, shouldn't be fast-path: kicking out to the tracer is going to
be the slowest part.

-- 
Kees Cook
