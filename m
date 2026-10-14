Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A33630BF;
	Wed, 14 Oct 2026 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999898; cv=none; b=Dc1TYLYG+fNLL87FnhtG13ALZqiONB0+tF1fWo03zLBNGw9n5iEsQkEq8gfnXVCVc+S7sDEijtkIsCilXPcYK8GokYEWTRd90+dN2tsduVkrIHitGHEqqW9ut27DVAgVNncqJGgdIVKwY8lcMnl5sxhzmURR7cviu7Dq80Vl0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999898; c=relaxed/simple;
	bh=4AbmuGaQmg8yTQKRE3P7KnMLvr6mh8Ei2C0jhRF37cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFyM7PKc95k5I4lS7+DWzH7JUT+y8I9oppGvPmdAcjTcKUOlkozhPLghs6o3ajntIJS29Ae5HyIN0fMSOw0uDGNyuccBThGaMTxJ/XLBkEy0A3TjftpIMiwLG9x3+svr71Q+esWlnsfqAOsZcOZaEs604gIbpcptj4VkR4MLm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/JbqQJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/JbqQJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F01F000C4;
	Wed, 14 Oct 2026 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791999896;
	bh=sTxxFIiD6mgFs2UdEY1I8MyQnekZZiyPvhQw7RuhHrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y/JbqQJUIEWFLFscjenxW9GCe5wNUa4lKG/qtufKEMdVe8I7JjwbgDqX5hbrhnbnk
	 g11pdaabApMfzBMkfpM3w5n1u6n4ty6P15W2DYuVy6e5rpnrYB4vdZc0i3KcsTyQQY
	 TKLv1ClTGNe42312p3oiyQs34X3dYVxDiKaB2oxQ=
Date: Wed, 14 Oct 2026 19:45:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>,
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
Message-ID: <2026101434-scam-padding-87a5@gregkh>
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
 <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>

On Wed, Oct 14, 2026 at 06:44:18PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 14, 2026 at 6:37 PM Kees Cook <kees@kernel.org> wrote:
> >
> > I'd really like to have the attribute available, and I've got at least
> > one user I can apply today that don't require fix-ups (seq_file), so
> > if Miguel is okay with it, I'd like to snag patch 1 and send it with
> > my seq_file "first user" for this coming merge window so it's available
> > starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> > other subsystems to be able to use it. And the kobj fixups can continue
> > in parallel. Does that sounds okay?
> 
> Of course, please feel free to pick it up (with the small tweak I
> requested) if you have a user.
> 
> And if you don't pick the user, I could still pick the first patch up
> through the compiler attributes tree if you and other folks want to
> use it after -rc1.
> 
> Greg: adding the attribute itself should be safe and would unblock
> others that may want to "protect" themselves, without having to wait
> for every potential user to get fixed (but of course I agree they
> should get fixed -- we should not forget about them, if that is your
> concern).

I agree, not a problem to add the attribute now as long as it doesn't
break the build.

thanks,

greg k-h
