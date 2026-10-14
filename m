Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3601414400;
	Wed, 14 Oct 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995833; cv=none; b=cteATwv31FuPonr3oYuPISEx3+nyqPNXTj0ggD4XBX8LSQLnjME6P65aTJzmPIcQz8Yr4r5y5v7rUYLHsW9l3sjPlW55lMAoXIAWXyLVcc/9JyU7IFk116uROxu+mPU+TDoUmlwrWK/ZUpNyorrh/WN0KvvxDc26oVLy8MGr2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995833; c=relaxed/simple;
	bh=xvcQd7gINQECA0pEoMrNUQEomIL78zM5m7K4ujDNY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUoMlX6zOxnT019lxR2ZJFeu+JOU+B0nrl4diRJC1dbPejGZwX0QTP1h8I5RUFRT8AC+AbZSgofD0/lgGZxHpKyjo2kYQgblDugYRqXUxForNZCpvJB2dkCeXOreSlqn3/2gEysjC5UXQTzj6bmb2fSvYM97rjHwqDkQTTObDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9IplbiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9IplbiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258481F000C4;
	Wed, 14 Oct 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995832;
	bh=D0qFplMD3JegnW7i3iVJkwgfMDmyoOPsyHFrtj+nxBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9IplbiX+93nceH23XmnKeZ5oYecY++a3sP1FSp8/eoJQHlwosXybufpa8S8KQDs4
	 JSOYDlE3dW0Tstqig9001fDQnyF55nygDlSOHNkJdYmGR6xIoM+nl1dQhuyjrtkVwj
	 EuXqe73P+3VZ6BDKW7wiUBDkX32NJU8qFo902yMRcaug/7BAm5oKbDw4gxCh7LxUqC
	 Y7NxYDYR/y/z28DqpEx8zGTH0dUYz2jKMESyevlBsADLYmloXFD5sbjroBfTPOb1YO
	 EAaIr8VM2TPJc/hDXYqOW71XwpeyatwvwVWF6WB1T2qG0eJVVmvgIrJgOh3HFB8l/2
	 2qpSERGwTKhRA==
Date: Wed, 14 Oct 2026 09:37:11 -0700
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	David Teigland <teigland@redhat.com>,
	Alexander Aring <aahringo@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	driver-core@lists.linux.dev, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
Message-ID: <202610140932.5F9CFCE5@keescook>
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101425-why-boring-4f2d@gregkh>

On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > Clang supports the 'require_explicit_initialization' attribute on struct
> > fields to enforce that the field is explicitly initialized when an
> > aggregate object is constructed, emitting -Wuninitialized-explicit-init
> > (enabled by default) if the field is omitted.
> > 
> > Following discussion at the Linux Plumbers Conference [1], this series
> > introduces __require_explicit_initialization in
> > include/linux/compiler_attributes.h and applies it to
> > struct kobj_type::release.
> 
> Cool, sorry I missed that talk.

Yeah, I'm really liking these compile-time checks. :)

> 
> > As Documentation/core-api/kobject.rst notes:
> >   "One important point cannot be overstated: every kobject must have a
> >   release() method, and the kobject must persist (in a consistent state)
> >   until that method is called. If these constraints are not met, the code
> >   is flawed."
> > 
> > Annotating struct kobj_type::release caught 30 struct kobj_type
> > definitions across the tree that omitted .release:
> > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> >   allocated kobjects, ksets, or enclosing structures were either leaked on
> >   kobject_put() or freed prematurely before kobject release (risking a
> >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
> > - Patch 11 annotates struct kobj_type::release with
> >   __require_explicit_initialization and explicitly sets .release = NULL
> >   (with explanatory comments) on the remaining legacy struct kobj_type
> >   definitions whose kobjects are static, per-CPU, or embedded in devm- or
> >   parent-managed structures.
> 
> Sounds great, but let's fix up the users before adding the attribute.
> Looks like some of these need another version so it might take a bit of
> time to get them all merged.

I'd really like to have the attribute available, and I've got at least
one user I can apply today that don't require fix-ups (seq_file), so
if Miguel is okay with it, I'd like to snag patch 1 and send it with
my seq_file "first user" for this coming merge window so it's available
starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
other subsystems to be able to use it. And the kobj fixups can continue
in parallel. Does that sounds okay?

-- 
Kees Cook
