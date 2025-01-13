Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AA1FBBD9
	for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781087; cv=none; b=NK24ZH+Ij1E1pSJolMWErvNptcv+gPhna+ELGwCtJtT+XGHvQgXhI+RU/B4RU8+/O+tqwfb9Mta8M8wGP8RIU7dVubF7FSC+gRvDyJJ/tUW81/8ZaT/yvD26bWGGlRL4fyWlobpe3dPTRioAIn31qjcoxjS7V/xcuKt89BZ1cvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781087; c=relaxed/simple;
	bh=Srll5vISOStViqEFRHRuz5l1tVr8nZ6oxdB4N0twGR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgPUDvU7A+ephQ99MVQ6aQJK9LcOyNImSi4kVrxZeg3Zc0vt9GibL5ioeYRZtwttv3RmKUiApdO/Dqa38aJSzvZHoyDdBJpBV8hoqW1+k2tqUDfSDDw2+NUA9ZQ7aZvALkkizeE0vdbVwEkBzfI0MkV8CbllpQsJmYJP0Dul/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2aSCgBu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2aSCgBu"
Date: Mon, 13 Jan 2025 16:11:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736781068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLwBznsIvWChVrWyQ/Y1KottiOWCI/F91TbjA2wc0AA=;
	b=a2aSCgBuFAUHHZ2qluxkDCW1r86/Jn2YuYdQd1tk+HuQfMVxRj6nw2X0GwNzCVRZStipgo
	X3/zlLiG44z1iH1iU39ygCG6LXbI/5HFyRI8oWtDfGRHRlV6dUWYp7H2CUmGS9UvyPoFFX
	JHNYyxBmVcqUwbNF9KwURzWYO1EG/gs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 2/5] configure: Display the default
 processor for arm and arm64
Message-ID: <20250113-45b57478be2241a35ffa1b67@orel>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-3-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110135848.35465-3-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 10, 2025 at 01:58:45PM +0000, Alexandru Elisei wrote:
> The help text for the --processor option displays the architecture name as
> the default processor type. But the default for arm is cortex-a15, and for
> arm64 is cortex-a57. Teach configure to display the correct default
> processor type for these two architectures.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  configure | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index 5b0a2d7f39c0..138840c3f76d 100755
> --- a/configure
> +++ b/configure
> @@ -5,6 +5,24 @@ if [ -z "${BASH_VERSINFO[0]}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ] ; then
>      exit 1
>  fi
>  
> +function get_default_processor()
> +{
> +    local arch="$1"
> +
> +    case "$arch" in
> +    "arm")
> +        default_processor="cortex-a15"
> +        ;;
> +    "arm64" | "aarch64")
> +        default_processor="cortex-a57"
> +        ;;
> +    *)
> +        default_processor=$arch
> +    esac
> +
> +    echo "$default_processor"
> +}
> +
>  srcdir=$(cd "$(dirname "$0")"; pwd)
>  prefix=/usr/local
>  cc=gcc
> @@ -33,6 +51,7 @@ page_size=
>  earlycon=
>  efi=
>  efi_direct=
> +default_processor=$(get_default_processor $arch)
>  
>  # Enable -Werror by default for git repositories only (i.e. developer builds)
>  if [ -e "$srcdir"/.git ]; then
> @@ -48,7 +67,7 @@ usage() {
>  	Options include:
>  	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
>  	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> -	    --processor=PROCESSOR  processor to compile for ($arch)
> +	    --processor=PROCESSOR  processor to compile for ($default_processor)
>  	    --target=TARGET        target platform that the tests will be running on (qemu or
>  	                           kvmtool, default is qemu) (arm/arm64 only)
>  	    --cross-prefix=PREFIX  cross compiler prefix
> @@ -283,13 +302,8 @@ else
>      fi
>  fi
>  
> -[ -z "$processor" ] && processor="$arch"
> -
> -if [ "$processor" = "arm64" ]; then
> -    processor="cortex-a57"
> -elif [ "$processor" = "arm" ]; then
> -    processor="cortex-a15"
> -fi
> +# $arch will have changed when cross-compiling.
> +[ -z "$processor" ] && processor=$(get_default_processor $arch)

The fact that $arch and $processor are wrong until they've had a chance to
be converted might be another reason for the $do_help idea. But it'll
always be fragile since another change that does some sort of conversion
could end up getting added after the '[ $do_help ] && usage' someday.

Thanks,
drew

>  
>  if [ "$arch" = "i386" ] || [ "$arch" = "x86_64" ]; then
>      testdir=x86
> -- 
> 2.47.1
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
