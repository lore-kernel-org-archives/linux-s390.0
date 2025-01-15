Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB71F9A81
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941633; cv=none; b=qjDuQyKm5qTdQF+Y2Yt7t66ZxNRAmA3z4rs6RDM9ZdO/8auDuedEr1Wq3vbEaA0IZc9HSl24Ke/V+OWJSW7JsvyY5SMbNOQqEn9M13ETGxxIK/0D1sHG+uMZp0OmYNIy8CSTQWuLTiybUasv4HJ8yC00YhpMXtCYwcYVdQ2eIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941633; c=relaxed/simple;
	bh=lOJ3NGWQGevXcacL3czT9BSD6SpO6SDkYJLBDKharjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7MrhZTO2xvMM64dWsST6e9DRtPNCPSjd9kSW37CAYBBLgUMoO2dpVZUXLNl2juCW1+0hMjldC2BiGNESVVVn5T1JKb4nM1sDgw3DAMTd+AOZnNauNpXVzT95TkH3Bbw7Q/xC/j6cmtYCvfBYuGF29Z45mhFglahEosZqE1c+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8eo6yZT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8eo6yZT"
Date: Wed, 15 Jan 2025 12:47:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736941628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8XOo0FW0vTE1WDVQEvU4KsWOEVRC4l+3gRa0NCsvGY=;
	b=e8eo6yZTgL/aZFbN0VN9rSnSZflP1y47RQdu57cyuFOMsBqkyjBVyZm86w8eRsC8MTZgHj
	AkN5Y1dfiLRu4c8S9cVfY6uyQPhnBSrm2mtBM0UKH46KPW+nhN8mg82cqHKsO+fubSQnZD
	7yARFQU7gaG9mTSRZZdF8gWQFytNrWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, vladimir.murzin@arm.com
Subject: Re: [kvm-unit-tests PATCH v1 2/5] configure: Display the default
 processor for arm and arm64
Message-ID: <20250115-dde4d782f94a79819c861c3b@orel>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
 <20250110135848.35465-3-alexandru.elisei@arm.com>
 <20250113-45b57478be2241a35ffa1b67@orel>
 <Z4acKHEn/dE0yLM2@arm.com>
 <20250114-a36510d222fc3410b9b7654e@orel>
 <Z4eGAl7kah6vfHle@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4eGAl7kah6vfHle@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 15, 2025 at 09:55:14AM +0000, Alexandru Elisei wrote:
> Hi Drew,
> 
> On Tue, Jan 14, 2025 at 07:51:04PM +0100, Andrew Jones wrote:
> > On Tue, Jan 14, 2025 at 05:17:28PM +0000, Alexandru Elisei wrote:
> > ...
> > > > > +# $arch will have changed when cross-compiling.
> > > > > +[ -z "$processor" ] && processor=$(get_default_processor $arch)
> > > > 
> > > > The fact that $arch and $processor are wrong until they've had a chance to
> > > 
> > > $processor is never wrong. $processor is unset until either the user sets it
> > > with --processor, or until this line. This patch introduces $default_processor
> > > only for the purpose of having an accurate help text, it doesn't change when and
> > > how $processor is assigned.
> > 
> > I should have said "The fact that $arch and $default_processor are wrong..."
> > 
> > > 
> > > > be converted might be another reason for the $do_help idea. But it'll
> > > > always be fragile since another change that does some sort of conversion
> > > > could end up getting added after the '[ $do_help ] && usage' someday.
> > > 
> > > configure needs to distinguish between:
> > > 
> > > 1. The user not having specified --processor when doing ./configure.
> > > 2. The user having set --processor.
> > > 
> > > If 1, then kvm-unit-tests can use the default $processor value for $arch,
> > > which could have also been specified by the user.
> > > 
> > > If 2, then kvm-unit-tests should not touch $processor because that's what the
> > > user wants.
> > > 
> > > Do you see something wrong with that reasoning?
> > 
> > If we output $default_processor in usage() before it's had a chance to be
> > set correctly based on a given cross arch, then it won't display the
> > correct name.
> > 
> > > 
> > > Also, I don't understand why you say it's fragile, since configure doesn't
> > 
> > I wrote "it'll always be fragile" where 'it' refers to the most recent
> > object of my paragraph ("the $do_help idea"). But, TBH, I'm not sure
> > how important it is to get the help text accurate, so we can just not
> > care if we call usage() with the wrong strings sometimes.
> 
> Got it now, thanks for explaining it.
> 
> My opinion is that a help text is there to help the user, and in my experience
> an inaccurate help text can be very frustrating - think comments that say
> one thing, and the code does something else.
> 
> How about this:
> 
> diff --git a/configure b/configure
> index 3ab0ec208e10..5dbe189816b2 100755
> --- a/configure
> +++ b/configure
> @@ -51,7 +51,6 @@ page_size=
>  earlycon=
>  efi=
>  efi_direct=
> -default_processor=$(get_default_processor $arch)
> 
>  # Enable -Werror by default for git repositories only (i.e. developer builds)
>  if [ -e "$srcdir"/.git ]; then
> @@ -61,13 +60,14 @@ else
>  fi
> 
>  usage() {
> +    [ -z "$processor" ] && processor=$(get_default_processor $arch)
>      cat <<-EOF
>         Usage: $0 [options]
> 
>         Options include:
>             --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
>                                    arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
> -           --processor=PROCESSOR  processor to compile for ($default_processor). For arm and arm64, the
> +           --processor=PROCESSOR  processor to compile for ($processor). For arm and arm64, the
>                                    value 'max' is special and it will be passed directly to
>                                    qemu, bypassing the compiler. In this case, --cflags can be
>                                    used to compile for a specific processor.
> 
> Should be accurate enough, as far as I can tell. And I don't think there's
> a need for $do_help: if the user does ./configure --help --arch=arm64, then
> I think it's reasonable to expect that --help will be interpreted before
> --arch is parsed.
>

Sounds good.

Thanks,
drew
