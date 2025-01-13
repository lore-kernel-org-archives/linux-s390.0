Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1924025F
	for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782170; cv=none; b=qxMclApmOQ3e+w6hIIVu1sU70PgrZQj/evMx4ID0ngtfRJRzaxLlAnkfej0GWrUbU0ghBlz+BXo4WOIwgIPNW/LsTMnTNwyCB9Vmc9kEkaw3FPZPdPBjaN7WwjnXxTlRrjaYyacek2H5giPGjvUS791KYuPOYwLBJrhymKg9b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782170; c=relaxed/simple;
	bh=y0gHRClRmOHchgJy4s4ISmgVSvPE8gz6DBLQ5ez3Cpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Roh4iwY/OZUbrteJQ0T9Ty59gBkvH+aqeTY+XuMx0k0Ye9XnHb4/KekafYGhUMebsZK4GHd0d8dbrSz3j21O7POW0p5zkZ3wgQr9Ed+KwxbZ5XXJlD1Oxb7xSqvf3h8GHera4ICqItLxJFrRCUfnvYsaq6i4Z4gu7RtdL/zMo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQEGUKFI; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQEGUKFI"
Date: Mon, 13 Jan 2025 16:29:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736782164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSA+hNOyAkcLqPBtZ57pM1gCyD3g1ELMOtUcZw34bIg=;
	b=UQEGUKFI8PzrtF1awGKC1+UN8EXl+LliNVAFCiprEQoOfIHy5va7+W4MlnEdWWNcLmpDsz
	wYZNGBL+YidgdfYdiBT/c/xX40vXVBQ9PUZcUtGG+3YpfU++G1qEUPptM+FXTwU6n4cito
	z3guQdmmPa9/29n366iCvVlmeT2WITc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 5/5] configure: arm64: Make 'max' the
 default for --processor
Message-ID: <20250113-f6e1c55d5200410161aa61b5@orel>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-6-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110135848.35465-6-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 10, 2025 at 01:58:48PM +0000, Alexandru Elisei wrote:
> Newer architecture features are supported by qemu TCG on newer CPUs. When
> writing a test for such architecture features, it is necessary to pass the
> correct -cpu argument to qemu. Make it easier on users and test authors
> alike by making 'max' the default value for --processor. The 'max' CPU
> model contains all the features of the cortex-a57 CPU (the old default), so
> no regression should be possible.
> 
> A side effect is that, by default, the compiler will not receive a -mcpu
> argument for compiling the code. The expectation is that this is fine,
> since support for -mcpu=$PROCESSOR has only been added for arm64 in the
> last commit.
> 
> The default for arm (cortex-a15) has been kept unchanged, because passing
> --processor=max will cause compilation to break. If the user wants the qemu
> CPU model to be 'max', the user will also have to supply a suitable compile
> CPU target via --cflags=-mcpu=<cpu> configure option.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 46964d36a7d8..3ab0ec208e10 100755
> --- a/configure
> +++ b/configure
> @@ -14,7 +14,7 @@ function get_default_processor()
>          default_processor="cortex-a15"
>          ;;
>      "arm64" | "aarch64")
> -        default_processor="cortex-a57"
> +        default_processor="max"
>          ;;
>      *)
>          default_processor=$arch
> -- 
> 2.47.1
>

Another reason to introduce a new parameter (qemu_cpu) is that we can also
change arm32 to 'max', reducing divergence between arm32 and arm64.

Thanks,
drew
