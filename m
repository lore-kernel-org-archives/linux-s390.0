Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3647351B
	for <linux-s390@vger.kernel.org>; Wed, 28 Feb 2024 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122105; cv=none; b=dNB9JQ4qWNsqiEy4dsgEHjsmFUYDBRJO2Q4SavN7gj3pR44j92ELjhHPA9I0WjOewh7eh2QNAny7jXAh8Nsc2Nl1CrX6uT8XbqQS3ijwK18mh3oQm6TJJ5TYuyIqxWb/zw/Fji1EZokdqxPGqKyWgCfBL2qUXIYWnyawTO2Stck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122105; c=relaxed/simple;
	bh=EumXJOpi+BwXWXdNByDMql+rqgc9RgisjlqNtXtQOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddtYefKPRdGkNJRh9r9Fmmi0AwLDhBN0HySWsBA3YzsYkhnupzJgY7laySE6paY0KlcG4rzJW6zrbB3ALKFk0wm9Xz4yWyc7sZntCub4CMjarolxIpapg/IMfe2aa4L5lFJXIRMkvt88S5Fh0bFgjAT3YySiyD/ThE66h6dU5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QkadKOx2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QkadKOx2"
Date: Wed, 28 Feb 2024 13:08:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709122101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWNPrUUilCiI4A3q8yMqr9KSZvx9P8q/blhjVSX5ACU=;
	b=QkadKOx2gNNgsq2yDwtob8FGSV90oxh/Mm9+dXDQWYRBbhRN2s+9CyfKASe6R0jXjDwhBf
	1CLyRhVsikkRtsk0zsmTjg6RAWAKZmYS2RPYAfdFbNLyhS7AiI8XcUy1a1CdOIJuEBBzzl
	+5wJ7NvO9qRVqytE1pirWcr63P6YX9U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH 29/32] configure: Fail on unknown arch
Message-ID: <20240228-d598a1eb6a25935f54aeaa01@orel>
References: <20240226101218.1472843-1-npiggin@gmail.com>
 <20240226101218.1472843-30-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226101218.1472843-30-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 08:12:15PM +1000, Nicholas Piggin wrote:
> configure will accept an unknown arch, and if it is the name of a
> directory in the source tree the command will silently succeed. Make
> it only accept supported arch names.
> 
> Also print the full path of a missing test directory to disambiguate
> the error in out of tree builds.
> 
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Andrew Jones <andrew.jones@linux.dev>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Nico Böhr <nrb@linux.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: kvmarm@lists.linux.dev
> Cc: kvm-riscv@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  configure | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 6907ccbbb..ae522c556 100755
> --- a/configure
> +++ b/configure
> @@ -45,7 +45,8 @@ usage() {
>  	Usage: $0 [options]
>  
>  	Options include:
> -	    --arch=ARCH            architecture to compile for ($arch)
> +	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
> +	                           arm, arm64, i386, ppc64, riscv32, riscv64, s390x, x86_64
>  	    --processor=PROCESSOR  processor to compile for ($arch)
>  	    --target=TARGET        target platform that the tests will be running on (qemu or
>  	                           kvmtool, default is qemu) (arm/arm64 only)
> @@ -321,11 +322,15 @@ elif [ "$arch" = "ppc64" ]; then
>  elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
>      testdir=riscv
>      arch_libdir=riscv
> +elif [ "$arch" = "s390x" ]; then
> +    testdir=s390x
>  else
> -    testdir=$arch
> +    echo "arch $arch is not supported!"
> +    arch=
> +    usage
>  fi
>  if [ ! -d "$srcdir/$testdir" ]; then
> -    echo "$testdir does not exist!"
> +    echo "$srcdir/$testdir does not exist!"
>      exit 1
>  fi
>  
> -- 
> 2.42.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
