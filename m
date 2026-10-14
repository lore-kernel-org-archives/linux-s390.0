Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C755625E4
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996286; cv=pass; b=tqJ/cgYXeTsHKsjtFIpQmPSPc2BW1vXyClvMZX2fBh8dbMDSQCwwj3Y0nVJKeZp9Uf0U5X3RVaHxjTwK2UB6TE4Z35/Pn0Iq4yBxjc3nbq7HDE4PeBymwjUWE8exWu2JRPo5DxafNXk1tM9uoRZBObcxd8bfk/Pil4BUo3jw9rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996286; c=relaxed/simple;
	bh=aCsxctc/xcnHv1pMHQu5CMpv8HUZNsqkMA91yRiQJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWR06swWaT2Nf9YeN/UIZ+tmroWT1foqy2wzA7RRmHfEB1YO5u2P206F35m4YSofCTP2zbDLud3XQ9XqPvWlNOqkD8XpJLcOI8Jg/Z3xDBiJuXQ6bBOLFPjcjku8Hhy62rse0gqjhxEao2QoMpiLUIqPr0QpETAtRLiPKqWDFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVy1VTdz; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVy1VTdz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so38177005e9.3
        for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996283; cv=none;
        d=google.com; s=arc-20260327;
        b=QWTa2kuLD26+XWl/UESeu3WRNlLXwniG86jqaAL6H4PKJAR3K6aluq4GxscNx3plWY
         7cG4Z5np+4X/dbaBzS/EuUG/VdE4RzJlC8qE1lmYcdYxO5hFDBS/F3qRInF5ooQMw6vb
         caFChwE4ZMSD1rZyqnwNmyVHiakJenJLhiwUpL4Z9wYuJqODtGK2sDASaE+qSubD4Ft8
         EoEJmsYsj8Cg/daMXmrx+sTcIiUfpvPoGJN8ycQtYRx5Fg1muoMcvlYCK1i4/YjFW4WZ
         zbfeN5a7ggybDnp6uOS4fsXKd+4y6+P6gVhWoeBs2VpHyNzcvzMUBB2I06UvVSD6Jfyi
         Wi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=73z9GBPS1mRqayuHWhC8zC7HyA3ESDVGffjm0LgWylI=;
        b=Tff27/KBnvz5Gux2vAMYPFOWDI4x6A3oTtoTjF6DulwIWIqGj9lRv9zsT+VRn0mR97
         jYi8ti5Rzo+nQrUJKhxSa2fZ+MkFMnG/hQE1fqZe9PvsiqmRMW09HQj218Vo6EH+pLxf
         8heuMcETq4GOdUj8dMaEaABo5FtGZzCcT0MLEGLA7SPcIGUpGd0VHwYx0IkoTX78zSS1
         ztPwe7RMGPwFqGKilfKsFo+EyCK/a6IH2wOjksQz1X/oLWwSMfuErfR4SiQbuFTPNFR3
         6+c57QNH13mxvJGLTzUhoDoCo0m/hqd58NeJdWm2UzwNbdVv/afl0LDJA9N4Ga/ri8Js
         7bDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996283; x=1792601083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=XVy1VTdzq25mUFFqhWjSZoYY6RB8T8Sfq9yzmXB8hctLA1wT5xxF79ySOTctmXPkvg
         pxBZANS8TYnM1kcpylPDuknUwRsmTpt4bmVkw9CeY/0Am+QRFEuOtZhf1FKSu93lfedk
         dsPqeLZuW9lq4l2+YpXGZJ1nJCAy2cV/gzhdLu5Us9BpEn8c9wjPOtHz8+KelWtdoTpo
         gZczbRT5vgc2YCEp3uVt8zABLCW1XvsmAsticJ2r0HU3/61uCpy9w+78S3X9Tom8IOmd
         5AFjVudJTP5S6D8uV0qO07uty7hprnis9+zWgB9onASYfWAj6+bVQUD1KIH1xYz2o14c
         D/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996283; x=1792601083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=Hm0sjwzdRJMRJlrR004s0XejsHrz3ncvzstb+3sk/n8CZjDUw+HpwakdhU2B6MRe20
         XGAwox2bP4oBI4qvq0cP2SZ7I+Gmv7VtFBqzL/b5/BGoTuaLpej97RUBPLJkLgQci9Oi
         sqIKKvohxhoP3yb/PL4W35WoQtu2AI9UC8iL8jb2CnlEt/yM/Hc7Fk3V6KitQTFc9c/O
         UKQBdB/55Zr33GZMqHAFM6UOU3QGiPYnzP4zbR0p4h1xlNmCvgAcQJVfkvN1RS/HEyQk
         0sQ5y04UpmhXu6yIi3AM+XeTbzVTDyCeGV3ukHw2j0/lYVzZSMTIPqw9CiNsiLOny+Dh
         BFEA==
X-Forwarded-Encrypted: i=1; AKwUvByBRK33jTJLAZr6CCMz1jvhf8Iz73qzY9NbxGBIXHHHHMjksQqcRb6aWwkW+pwuOH3LMh0rn93hpaUE@vger.kernel.org
X-Gm-Message-State: AFq9FYJWYQfIBYpfeN+GFgolYNqDIONlrkGvhca+cnzx8u7iTShRO5SK
	Mz5iAqVQpG8RwaYw+7UYyaf7GuYX0xYSSrXP1eq6lkJ1Zkre8Ycbgpbz4XCPC1xabBwAzMzcrZk
	Ekcvf3mqQ70uTOe6jW06u0D7jMv6+IZ8M47E30Nql
X-Gm-Gg: AYBFou1mQSA5RJ5bMLrQNMj85BNonzmUdMOCP7AzJDiV2TGC1sr4nkWrUdVbZQlfz0E
	cBlqHyEaEU4a+dXv+JmvnEs3vX6qu1QgMbQh4yUUXdynBhcUn+vUWWJOKRDjd1p1IsYoz0JiJoW
	IdT4cLhBDhWol5AwWEL4RSpP5hbtcPY0vYG4FpkZplhysM0wLDm+ggOdUfYm49LRNxoFYcTA77L
	/GsA4n5aGtQL4udjRJD8qt3Isw/U87BT96roxohBOVutTNU+940TvyJmNZ8TQyRUUbA1lBVzfEn
	8Cv59B6TACoP+jCd+G6Wpn5yDNdXqH3Tp9LXOJS6Ic8fpUoBfAUzI3GIuIy+LZB7157gG1jOCEx
	TgSwJpY0E+CYTpTXsbc51Zm2fi67CaUQfS5FlGguY1RV6SRcNEGENpaYoUGRma/SZ2g97vcT7Nr
	kcoB9nXa3p5ss8Qv84f3qL70oV2DPmsuDEftgxQNdNS0bxU0pU3cuk
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
