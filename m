Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11A37A848;
	Wed, 14 Oct 2026 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956208; cv=none; b=T0g+xhR1620L0qTVmvVrHHnMOw4E+X+2DRoP/efLIiiM49N+znalhNtdzvNcyFuBVW50q3iXkIjDPFemB61BLIo5EgtIOAAIry40iMuhuGLV7lq26UKzRo3DkCQn1n8QeBm3XpGO+MpuNlvf4zPqLIq76adRNb3AJNICrHYVpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956208; c=relaxed/simple;
	bh=npUhiSYNmoDuuRpY+IxiD302CfzbjfJ7Hroh5NPmrW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A63sb8j5prUYlUUe/+JdM5iNI4Vb1hH5PC6e/wmuGJZ2DFSjErxTYQ1CU+069aV9u3i0eW29tWBkJd4D0hOEo5tcWY5eEzJHVt8zIjd+QAyvfVlKa0tC14B7icUq1rnmNT4NsQ2GWum0sZuPmJAj/840fmvSJlrMrmQgweBQuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qh2L+lns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qh2L+lns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E01F000FF;
	Wed, 14 Oct 2026 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791956207;
	bh=20IeJwlfbHOwAOqBybbPglj4DioVDbfCTggyOUmG6AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qh2L+lns+TC45tZ3ta2Bf3sHpQuD7ArGYrxTnkjJVsISJDd215cAUFX7buojC10XX
	 PxZbUFGpn526urHl9iW1zA+jq+Q49VIAoWCaSVIjSYQA+Pdp0aIxZO/l3JMBTZ5a0o
	 W38eNJtQMa+oY0XJ4+Fg38TXLC108OEL5jmzsnVI=
Date: Wed, 14 Oct 2026 07:36:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <2026101425-why-boring-4f2d@gregkh>
References: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>

On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to enforce that the field is explicitly initialized when an
> aggregate object is constructed, emitting -Wuninitialized-explicit-init
> (enabled by default) if the field is omitted.
> 
> Following discussion at the Linux Plumbers Conference [1], this series
> introduces __require_explicit_initialization in
> include/linux/compiler_attributes.h and applies it to
> struct kobj_type::release.

Cool, sorry I missed that talk.

> As Documentation/core-api/kobject.rst notes:
>   "One important point cannot be overstated: every kobject must have a
>   release() method, and the kobject must persist (in a consistent state)
>   until that method is called. If these constraints are not met, the code
>   is flawed."
> 
> Annotating struct kobj_type::release caught 30 struct kobj_type
> definitions across the tree that omitted .release:
> - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
>   allocated kobjects, ksets, or enclosing structures were either leaked on
>   kobject_put() or freed prematurely before kobject release (risking a
>   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
> - Patch 11 annotates struct kobj_type::release with
>   __require_explicit_initialization and explicitly sets .release = NULL
>   (with explanatory comments) on the remaining legacy struct kobj_type
>   definitions whose kobjects are static, per-CPU, or embedded in devm- or
>   parent-managed structures.

Sounds great, but let's fix up the users before adding the attribute.
Looks like some of these need another version so it might take a bit of
time to get them all merged.

thanks,

greg k-h
