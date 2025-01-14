Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68201AA1DC
	for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874213; cv=none; b=XySa+l4wOEhHX59Go5FZJNpxqrNAwocwepUSTtjZmx47Ggnx4sfYH/cZHcDjA//w5w7rkF/H8qRCw3sUHELH0Ak9I2hMMk9XaZ0NLlLs5HMlm8LsEwih71gRz2NIv2vVolviIrWdM8mokmFTR2hasdt+2A+oJJrG+Y57RurxJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874213; c=relaxed/simple;
	bh=E7C2qke9pcIDbouOlEpTwUDcyYJIYRp/sYKk1DLbDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYf0PWp3MnmSSjDlAgvXn0HpAbQpBbf8xkKMVUtUh7fW75k3FAvxSh3gR7uFxSK4Bm5LnagNAp4iy9mWBTHrz0nC/DaLwiUCXc2+NCuBosMgm6inSA7V5x5UaC9JMvMA3hAkzyPg5WnTJK/8v6sdIUB8NKyZWYZGX2NFVL2vzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DF012FC;
	Tue, 14 Jan 2025 09:03:57 -0800 (PST)
Received: from arm.com (e134078.arm.com [10.32.102.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610723F673;
	Tue, 14 Jan 2025 09:03:25 -0800 (PST)
Date: Tue, 14 Jan 2025 17:03:20 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
	david@redhat.com, pbonzini@redhat.com, kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 1/5] configure: Document that the
 architecture name 'aarch64' is also supported
Message-ID: <Z4aY2AKSaxKDY5Hq@arm.com>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-2-alexandru.elisei@arm.com>
 <20250113-0fe04c6089726d1d06a254ec@orel>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-0fe04c6089726d1d06a254ec@orel>

Hi Drew,

On Mon, Jan 13, 2025 at 04:01:58PM +0100, Andrew Jones wrote:
> On Fri, Jan 10, 2025 at 01:58:44PM +0000, Alexandru Elisei wrote:
> > $arch, on arm64, defaults to 'aarch64', and later in the script is replaced
> > by 'arm64'. Intentional or not, document that the name 'aarch64' is also
> > supported when configuring for the arm64 architecture. This has been the
> > case since the initial commit that added support for the arm64
> > architecture, commit 39ac3f8494be ("arm64: initial drop").
> > 
> > The help text for --arch changes from*:
> > 
> >    --arch=ARCH            architecture to compile for (aarch64). ARCH can be one of:
> >                            arm, arm64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> > 
> > to:
> > 
> >     --arch=ARCH            architecture to compile for (aarch64). ARCH can be one of:
> >                            arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> > 
> > *Worth pointing out that the default architecture is 'aarch64', even though
> > the rest of the help text doesn't have it as one of the supported
> > architectures.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 86cf1da36467..5b0a2d7f39c0 100755
> > --- a/configure
> > +++ b/configure
> > @@ -47,7 +47,7 @@ usage() {
> >  
> >  	Options include:
> >  	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
> > -	                           arm, arm64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> > +	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> >  	    --processor=PROCESSOR  processor to compile for ($arch)
> >  	    --target=TARGET        target platform that the tests will be running on (qemu or
> >  	                           kvmtool, default is qemu) (arm/arm64 only)
> > -- 
> > 2.47.1
> >
> 
> I'd prefer to support --arch=aarch64, but then always refer to it as only
> arm64 everywhere else. We need to support arch=aarch64 since that's what
> 'uname -m' returns, but I don't think we need to change the help text for
> it. If we don't want to trust our users to figure out arm64==aarch64,

I sincerely dislike the fact that in the help text the default architecture on
arm64 is not among the list of supported architectures.

> then we can do something like
> 
> @@ -216,12 +197,12 @@ while [[ $optno -le $argc ]]; do
>             werror=
>             ;;
>         --help)
> -           usage
> +           do_help=1
>             ;;
>         *)
>             echo "Unknown option '$opt'"
>             echo
> -           usage
> +           do_help=1
>             ;;
>      esac
>  done
> 
> And then only do
> 
>  if [ $do_help ]; then
>     usage
>  fi
> 
> after $arch and other variables have had a chance to be converted.

That still doesn't work if displaying the help text on an arm64 board:
$arch=aarch64 if compiling natively, because that's what uname -m prints, and
$arch gets converted to 'arm64' later in the script. We could move the
conversion before calling usage, but at that point I wonder if it wouldn't be
better to never set $arch to 'aarch64' in the first place.

If you don't want to modify the help text to say that aarch64 is supported, even
though it's displayed as the default architecture on arm64, we could modify
$arch to never be set to 'aarch64', i.e:

diff --git a/configure b/configure
index 86cf1da36467..1362b68dd68b 100755
--- a/configure
+++ b/configure
@@ -15,8 +15,8 @@ objdump=objdump
 readelf=readelf
 ar=ar
 addr2line=addr2line
-arch=$(uname -m | sed -e 's/i.86/i386/;s/arm64/aarch64/;s/arm.*/arm/;s/ppc64.*/ppc64/')
-host=$arch
+host=$(uname -m | sed -e 's/i.86/i386/;s/arm64/aarch64/;s/arm.*/arm/;s/ppc64.*/ppc64/')
+arch=$(echo $host | sed -e 's/aarch64/arm64/')
 cross_prefix=
 endian=""
 pretty_print_stacks=yes

and keep the conversion from aarch64 to arm64 where it is, and still keep it
undocumented, just in case someone is using that.

($host still needs to be aarch64, because that's the name of the qemu
executable).

Thanks,
Alex
