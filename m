Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1F14A609
	for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875057; cv=none; b=V7XsiCMkQgsS/wAJH3F55lVF8OubqsAiLzTFkW9CnuqCOLevBeylSKs2G0eUsbP+s3kpmD7fUmwzrijhkxxISD+ghG4Uyf56UrdMcrVfDOU0mM3EmQar+s6LPdmlOr/xDbI4/XanYRzp4dKsQcW2mdcNb+8hqwO4Xg8Vi5jKKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875057; c=relaxed/simple;
	bh=HHI8djYmgn/+mITEJ/8Y7Yavvy4MsTn5DQefyXYfLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAlyKSmplM/AniRVBE+7pumnnn/QXDPqDynP2DPJYpe2K7L5/IG8jBWD1sYn++Euo/tA20LJje8KbFca6g5xSZVjyIf7W1G57vhTsr7YFDJmxicvLf0SWbDFjd3/ff9JGLf+MUqEZ30Zrsd3FVgfeKARhud8XGch2m70b6iyBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D06512FC;
	Tue, 14 Jan 2025 09:18:03 -0800 (PST)
Received: from arm.com (e134078.arm.com [10.32.102.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8E03F673;
	Tue, 14 Jan 2025 09:17:31 -0800 (PST)
Date: Tue, 14 Jan 2025 17:17:28 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
	david@redhat.com, pbonzini@redhat.com, kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 2/5] configure: Display the default
 processor for arm and arm64
Message-ID: <Z4acKHEn/dE0yLM2@arm.com>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-3-alexandru.elisei@arm.com>
 <20250113-45b57478be2241a35ffa1b67@orel>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-45b57478be2241a35ffa1b67@orel>

Hi Drew,

On Mon, Jan 13, 2025 at 04:11:06PM +0100, Andrew Jones wrote:
> On Fri, Jan 10, 2025 at 01:58:45PM +0000, Alexandru Elisei wrote:
> > The help text for the --processor option displays the architecture name as
> > the default processor type. But the default for arm is cortex-a15, and for
> > arm64 is cortex-a57. Teach configure to display the correct default
> > processor type for these two architectures.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  configure | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/configure b/configure
> > index 5b0a2d7f39c0..138840c3f76d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5,6 +5,24 @@ if [ -z "${BASH_VERSINFO[0]}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ] ; then
> >      exit 1
> >  fi
> >  
> > +function get_default_processor()
> > +{
> > +    local arch="$1"
> > +
> > +    case "$arch" in
> > +    "arm")
> > +        default_processor="cortex-a15"
> > +        ;;
> > +    "arm64" | "aarch64")
> > +        default_processor="cortex-a57"
> > +        ;;
> > +    *)
> > +        default_processor=$arch
> > +    esac
> > +
> > +    echo "$default_processor"
> > +}
> > +
> >  srcdir=$(cd "$(dirname "$0")"; pwd)
> >  prefix=/usr/local
> >  cc=gcc
> > @@ -33,6 +51,7 @@ page_size=
> >  earlycon=
> >  efi=
> >  efi_direct=
> > +default_processor=$(get_default_processor $arch)
> >  
> >  # Enable -Werror by default for git repositories only (i.e. developer builds)
> >  if [ -e "$srcdir"/.git ]; then
> > @@ -48,7 +67,7 @@ usage() {
> >  	Options include:
> >  	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
> >  	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> > -	    --processor=PROCESSOR  processor to compile for ($arch)
> > +	    --processor=PROCESSOR  processor to compile for ($default_processor)
> >  	    --target=TARGET        target platform that the tests will be running on (qemu or
> >  	                           kvmtool, default is qemu) (arm/arm64 only)
> >  	    --cross-prefix=PREFIX  cross compiler prefix
> > @@ -283,13 +302,8 @@ else
> >      fi
> >  fi
> >  
> > -[ -z "$processor" ] && processor="$arch"
> > -
> > -if [ "$processor" = "arm64" ]; then
> > -    processor="cortex-a57"
> > -elif [ "$processor" = "arm" ]; then
> > -    processor="cortex-a15"
> > -fi
> > +# $arch will have changed when cross-compiling.
> > +[ -z "$processor" ] && processor=$(get_default_processor $arch)
> 
> The fact that $arch and $processor are wrong until they've had a chance to

$processor is never wrong. $processor is unset until either the user sets it
with --processor, or until this line. This patch introduces $default_processor
only for the purpose of having an accurate help text, it doesn't change when and
how $processor is assigned.

> be converted might be another reason for the $do_help idea. But it'll
> always be fragile since another change that does some sort of conversion
> could end up getting added after the '[ $do_help ] && usage' someday.

configure needs to distinguish between:

1. The user not having specified --processor when doing ./configure.
2. The user having set --processor.

If 1, then kvm-unit-tests can use the default $processor value for $arch,
which could have also been specified by the user.

If 2, then kvm-unit-tests should not touch $processor because that's what the
user wants.

Do you see something wrong with that reasoning?

Also, I don't understand why you say it's fragile, since configure doesn't
touch $processor until this point (and unless the user sets it, of course).

Thanks,
Alex
