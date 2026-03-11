Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D8231A3B;
	Wed, 11 Mar 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245642; cv=none; b=TNaXxflF1sCG/8ix3bDB/t2sF3l7AdD4DiFp6C9WdZcnoSVfLtfItN6oXTWQLm/ZzdgPT8LF76do1YedhdBnF6N5vkY6/VnH7gilp6OtdEkdhlxvKob7SfPSm14OjYQCgZu/Jaf8/aHlvSMTfKvfBQ9+ufl7oehCuiZEcHck5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245642; c=relaxed/simple;
	bh=EWd4ZsmWD6TfSvkaA4M0KPy7jTIjbz23bQQ6WrdVXTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyDb4llXapnfXeGV+k3fwjRDX12ot6FWRH19Tm7Un8oc3YQdp0GaLuNIvTX9tFISzfDdGDW3HJwKQgR1QGqIn2dABb9mANpSlcxjkcT0q6xGNMe2jAYV2VwXvCfEuZPvOiDeDqg8dZj3ujpyVNhgge0CofQf/GMsxYRtWsN2A78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix9N1L9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix9N1L9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB3C19424;
	Wed, 11 Mar 2026 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773245642;
	bh=EWd4ZsmWD6TfSvkaA4M0KPy7jTIjbz23bQQ6WrdVXTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ix9N1L9JowfKXqQWX1hK64r60rXDu9pK7wA7+XPOGU71nGSVBTZeSbzPi0Bha+wep
	 RDAwQ6JdKvtXp60NYh22EWCd5vzfzdjjU33a1dYvyNQPaw6h8a8miweYN41Dod3Z5R
	 UbYoGj/6+Dz4tINq1SOwcv0oo5b2EYkDfBq7cq+l7yLkHH+/1HXTpt4aoBvaqKxVAz
	 ZMe4fosBJOivAJd/PUN0qa76Qj246c6+wiwY7vNGclUqZqcq+qKqUhwo5JW7Sy4HG3
	 GXnG4RxhRun/EVgquilz6ksDgbY/ZXYnjBYAC8frMCxU89jnq7s21WaOyhZjNG6fcG
	 E93PbzJVblVLA==
Date: Wed, 11 Mar 2026 17:13:59 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] s390/idle: Provide arch specific
 kcpustat_field_idle()/kcpustat_field_iowait()
Message-ID: <abGUxzhVmz2YOaEj@localhost.localdomain>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
 <20260225145146.1031705-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225145146.1031705-3-hca@linux.ibm.com>

Le Wed, Feb 25, 2026 at 03:51:45PM +0100, Heiko Carstens a écrit :
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 4873fe9d891b..19fd1541a0f3 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -378,8 +378,13 @@ SYM_CODE_END(pgm_check_handler)
>  SYM_CODE_START(\name)
>  	STMG_LC	%r8,%r15,__LC_SAVE_AREA
>  	GET_LC	%r13
> -	stckf	__LC_INT_CLOCK(%r13)
> +	lg	%r12,__LC_IDLE_DATA(%r13)
> +	asi	__IDLE_SEQUENCE(%r12),1
> +	stcke	__LC_INT_CLOCK(%r13)
>  	stpt	__LC_SYS_ENTER_TIMER(%r13)
> +	mvc	__IDLE_CLOCK_EXIT(16,%r12),__LC_INT_CLOCK(%r13)
> +	ALTERNATIVE "bcr 15,0", "bcr 14,0", ALT_FACILITY(45)
> +	asi	__IDLE_SEQUENCE(%r12),1

Would it be possible to instead do that with &kc->idle_sleeptime_seq ?
This should sum up to a simple increment as well. This way you don't need
those nested seqcounts.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
