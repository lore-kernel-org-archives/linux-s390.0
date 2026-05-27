Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF53283FDC
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861589; cv=none; b=iopsG4689/RBtMRz6b6e2kmT9snKZU54Zh/fYVQKDYS8k0ISA5oMRcqhdOXCo3eygzx8HuGASvHQF9hQvZ2b+AywpgF+mkcJ0tyxli8v/Auc91ejyh3gE9TLPSIjBzRp4HGWk/FleR8NyWhLronDjitMxTluvW+fcr1o8ib1mJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861589; c=relaxed/simple;
	bh=uYSNtIPBdPAmo6t77BQul6Ldc+T8yPkkOv6hcDKrzNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1k+6AhZTItyP+MsVMWbEQb+IemOkPcOGnH9AOQ0LU7Ugxtypm5ZCu9V+JYD3M7ebqjq3Bo+kPOcXzAMVBErCOUImYyc6YNfCLmXWBZV2Uzx+b/pvxZqqJkm95fpFN8JZKchQ5m0DhWrKg9z0EJWZgETdHNeEbq+InlMB1YW8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z++BhpPf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z++BhpPf"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so73157055e9.2
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779861585; x=1780466385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2hQNIjzUAzNKjF5a10PA5EGoBATFq7mHnm3HpuSFqE=;
        b=Z++BhpPfq/VfG293ucE/P8LE1JbANRLRCjjhX5EkkpDIfRLpqsIe3sfQwBBWb/Fnw6
         l+fdh+XT69zmacX+MCFFOW30Eu2iiQFerFSwqr86uh0TbIMz/RmssjsortyHxM3K4ewo
         OVGtiv7KwEVSEhKgvhq0HMr4mpKtuAPXi3kUPcabUZcVqQO6R71u/Wdm2ePqIgV/y1aA
         BOTdPxUeGrRNxROaAgHcV6OTtzHbQfvcwktrcZWkv1uHounh5j9Rpkfr6XvDKa60suhv
         O2q0G+RzFVBcZyPO+Z0GxaE8WMerIvt6FMDUOFfwLJKC3dHfLjhg04BrdQmrUmC4NLLR
         dr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861585; x=1780466385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2hQNIjzUAzNKjF5a10PA5EGoBATFq7mHnm3HpuSFqE=;
        b=QGYOzCLCq7dQjShgp3uJ4/vdS9Ln0plhH2R84OBwd7z9a+GdfjU/vXBZ3xmckvXwPy
         mbX4B3kf1nN8wliCjCsCuEoK8jC6rwLjJtYQQM3Slq48bdPcP5Rax2b51WTNrq7ALP1A
         5zlgKtVm7PxhROJTzJthp9I/63bcwRfFMRxSfVOWg/fm9wMac0C41ABYdIfUsNGT6Vqz
         LXICxoWysGwHPKd7w5nmOr33qdcr+TFgy1x6xr2Zd9awR6E5YMuNx65xiaBCPSif6Ubn
         5VfN+i0KKSoS518HyLxkjOs2qnGXOzS7q1BXpPGzX01mgTc0mTUjVLNbBCBdIZL/MPdi
         H/4A==
X-Forwarded-Encrypted: i=1; AFNElJ9YexP8GWYgolUpMs7y7SS39ilLH80D5/depv39ndtkm9qfosuzjFr7tQhPOhccUYZE7VL2PQ0rFg00@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4BxXmvVJrxxdTrjf1uP0vZg2WnCqYIHi+8QD8bCcHcWX9fclQ
	g/4dbpPJ1rusEsbFpCUn2BNAb0u7td7RTLgclkW9RIPj8sxyXEP6ajNv/Na91Rk9snq6Z3FRVSF
	8aAan+Ba4mxmol2Zm4g==
X-Received: from wmbjs3.prod.google.com ([2002:a05:600c:5643:b0:490:3f7b:9cf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr270384815e9.9.1779861584952;
 Tue, 26 May 2026 22:59:44 -0700 (PDT)
Date: Wed, 27 May 2026 05:59:43 +0000
In-Reply-To: <20260521165622.279953-5-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <20260521165622.279953-5-japo@linux.ibm.com>
Message-ID: <ahaIT7BV-gMqcVh1@google.com>
Subject: Re: [PATCH v3 4/4] s390: Enable Rust support
From: Alice Ryhl <aliceryhl@google.com>
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, May 21, 2026 at 06:56:22PM +0200, Jan Polensky wrote:
> Enable building Rust code on s390 by wiring the architecture into the
> kernel Rust infrastructure.
> 
> Add s390 to the Rust arch support documentation, provide the s390 Rust
> target and required compiler flags, and set the bindgen target for
> arch/s390. Adjust the Rust target generation and minimum rustc version
> gating so the s390 setup is handled explicitly.
> 
> The Rust toolchain uses the "s390x" triple naming for the 64 bit target.
> 
> Rust support is currently incompatible with CONFIG_EXPOLINE, which
> relies on compiler support for the -mindirect-branch= and
> -mfunction_return= options. Therefore, select HAVE_RUST only when
> EXPOLINE is disabled.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index b96ec2d379b6..296acf8f71aa 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -31,7 +31,11 @@ llvm)
>  	fi
>  	;;
>  rustc)
> -	echo 1.85.0
> +	if [ "$SRCARCH" = "s390" ]; then
> +		echo 1.96.0
> +	else
> +		echo 1.85.0
> +	fi

For other version constraints we have listed them in the Kconfig file to
guard the select HAVE_RUST or similar annotations instead of here. Is
this the best place to add this constraint?

Alice
