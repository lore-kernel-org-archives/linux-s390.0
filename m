Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233693DC4DC;
	Mon, 18 May 2026 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090314; cv=none; b=NdEQFeZwe7UD4kyXCzGA7KB0TbrI8UmUwt4sA+9mRoYrUbg8AyJHBNdcqSXle84/UtLbfsx1cZTB2W/HBX+vxef08li1ssx1kZyw2ikrl1LRBOcUDV+HGFp3JClcBKEKewlgD1mApM3bHtkgVz3NZpvhZ2qGX6I/6OtH2jUZi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090314; c=relaxed/simple;
	bh=QJqelUl577WCFj/Tzkydza7+d0YsaiPx/vfBgnx0wTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEvJqkp9RJ736y2Jbla6f4iZP3/GflMnETFjCfvWeXGy947FyBg7JymLFDAUwn5zc8sdFHx7WEICbcEKB8lWP5uW7r2KMZvJagVhATvTmRg2tJW3k69WU7LAg6QoMSCkTKwRJT06NsuN67p7zPlUX6VSncLbslOt27LhaTxjThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aUl0eIP2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUl0eIP2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9SNy0PSQLDBEdWaWsi8e1WsxaDfOs/5iKk51l3if+ks=; b=aUl0eIP2Xay9XsKzYBAdXd+45c
	RVnY2Rb8MNw0C3V2PoQXyeCIzwuS/Q5eWsd5Tk6Hu9K0S6tvVMTh8hlNX4RvdwVsmKP+rxrydE8pz
	XskZEruC7dyvdUHnEq4u7PnKeuN0Psms1EzFOuDsTp3YNjeZquMPV+F8bNqihrokpDwr2tICgYJsL
	IFPKbYQrEJsBmZ114svVnyI4/qP3dOfkpIg3rXMeLWRskOfauqqVRs1Rw6tdr+KG8sM54EzSru0tm
	v2tx3ovAvrfuwS7Zj/Qi70gAKhhW2i3IBlkKd+1qpGWp4KHAseEOAYo4M0q8PoghyrsIimwS8lIm+
	xhN6ngLw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOsew-0000000AERb-3EAT;
	Mon, 18 May 2026 07:45:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52B863007A4; Mon, 18 May 2026 09:45:06 +0200 (CEST)
Date: Mon, 18 May 2026 09:45:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-hardening@vger.kernel.org,
	linux-s390@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>
Subject: Re: [PATCH] [RFC] ubsan: turn off UBSAN_ALIGNMENT on s390
Message-ID: <20260518074506.GS3102624@noisy.programming.kicks-ass.net>
References: <20260515092057.810542-1-arnd@kernel.org>
 <20260515165357.10935D74-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515165357.10935D74-hca@linux.ibm.com>

On Fri, May 15, 2026 at 06:53:57PM +0200, Heiko Carstens wrote:
> On Fri, May 15, 2026 at 11:19:54AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Testing randconfig builds on s390 with gcc-15, I came across a number of
> > seemingly unrelated build failures that ended up all being caused
> > by the -fsanitize=alignment option:
> > 
> > s390-linux-ld: kernel/sched/build_policy.o: in function `thread_group_cputime':
> > include/linux/seqlock.h:1286:(.text+0x1f738): undefined reference to `__scoped_seqlock_bug'
> 
> Does this only happen with __scoped_seqlock_bug()?
> I just enabled UBSAN_ALIGNMENT, and with gcc-16 I can see this too.
> 
> > What I observe here is a huge increase in generated calls to
> > __ubsan_handle_type_mismatch_v1() that ends up thowing off a number of
> > compiler optimizations that the kernel relies on.
> > 
> > I have not been able to figure out why this happens on s390 but not arm64,
> > arm or x86, if other toolchain versions are affected by the same thing,
> > and if this is a problem in gcc or in the kernel itself, e.g. some
> > variable being identified as unaligned when it should be aligned.
> > 
> > This clearly needs more investigation to figure out properly what is
> > going on, but turning it off is currently required for randconfig testing.
> ...
> > ---
> >  lib/Kconfig.ubsan | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 1ecaae7064d2..3fc03a6b5af4 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -152,6 +152,7 @@ config UBSAN_ENUM
> >  
> >  config UBSAN_ALIGNMENT
> >  	bool "Perform checking for misaligned pointer usage"
> > +	depends on !S390 || BROKEN
> 
> Wouldn't it be more appropriate to extend the ifdef at __scoped_seqlock_bug()
> which emits an empty function for exactly this reason for some gcc versions
> and kernel configs?
> 
> That is: add CONFIG_UBSAN_ALIGNMENT to the list (copy-pasted - white space
> damage below)?
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5a40252b8334..18affa4d21a6 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1259,7 +1259,7 @@ static __always_inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
>  
>  extern void __scoped_seqlock_invalid_target(void);
>  
> -#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN)
> +#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN) || defined(CONFIG_UBSAN_ALIGNMENT)

Right, so I have a GCC bug and some mail with Kees about all of this.

I wanted to add: CONFIG_UBSAN

But for 'raisins' the whole bounds checking thing is mangled into UBSAN,
so everybody + dog has UBSAN on in their .config :/

IIRC Kees was going to look at untangling bounds checking from UBSAN and
make UBSAN pure debugging stuff (again). But I don't think he's managed
to find time for this.

Anyway, yes, I suppose we can do as proposed.
