Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47115616C3
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=qah57tFcmG/sPFTPAnxc0ZU3OdtgTJW9GAMhePx6dPo+52sJzj/qJV1vvHh6mfBvftwpCqVDJpv0Tm1Dp0F7BAUdnsSIuh5iU0ME/LdZfG/ppOf99Lyq8osgWkc5nfyCI+/5QdwXrfyENNQ5joQWW5iHdDvGl54a1k0rgk7xnkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5LMeCX; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5LMeCX"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bb5afa736so522833eec.1
        for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=nEBH2Ven4hrBXtRyo7y2mKWA7FxogTklCMMQFSSyEYAtcUa2lDf0NHh69e8WRIo6JV
         cmRXSrOe5hhDN+NBgttvX3yeYNusTnlFglFBI7fPcvegIkmbgl39dLIZRvhw0HIgdTQ9
         geyqs+F9p3xkl3sK4lGUyrcnoo+XbjhrDfZZoGddLBNrrJ7LqkmzcXOx9hsC3owAJTPe
         k8D9dOqxf8eIejLbh4Ppu/7lqlYrZWNcAMrmzEV39Q9n9+SjxMAoetCJjx4dFcmfiT4h
         zUOk+vzjQSBth/xJYRygYq1ZZ/CRsTYJVM1MrRfdmJSJEKeOiYv0+pmkNGEDHCmIG/sH
         ks/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=JaZ5LjSd8+yPmgif9e2NtBC5MO939sUIJqU0Q6PM3QQ=;
        b=Ae1L9pYbnx4plxVgrlLu8vB7zZcxvp5RJSbLpQPrbbBXeoRWVLCDWVCuTynQoSn+2y
         JnnP+p9fJQcfRXTjYKQk06QBu7gSw/4HFw3BYHb5ICaCGXrt35ln5dTteQI7zkrzJN25
         SJPrT/+BvAvlocA7YKfCXsht6qIoZHQSu/8YKJDqH9HiR670+IJDtg+8whNhjdTCIWOU
         U1uiniIivEeEAI3a8cG9xcPQul0YjkB/8g4XNSoBgJUlrIAbj1OL1MDIoOhElHGPiF8D
         wd2/WSiEnskY8UjRrzkGMMjUY3MPl5RkJqgJhAW8PLpVcGXWKiQ/oXSZpyij7kRzBbc7
         8xpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dG5LMeCXSiSbpubk/BTMkvWJ2dvIK7jFfkGhSVKuiPvEccVQI9eRP/pY4aiG8kSDk8
         sybScDEKYa9pUjoob3fVfnbNdFtdkBXsSjpfjP+bPyBK5Chd00x6HJJ7X+HteLAY7JfU
         o4429zXiiE7e1UOccLBxgzcZh+G/nI2B8bjb9YKWi7iAEGL16Iblz9B6MpdkbUl3G+Fk
         3lPFokI++jDRZ0Cwvj1/64bOOygK5BR8VGYFxRHD7siF53FrkARVocKqUOcShcj0hkn2
         gYiKlI7ykCQvFk94TVoBL/XLbOsKN6gefpMbeBOS/eufSnZP21bV5ckiClL1WUdGnm6v
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=D4Kaq2d30Z1tMKyDx9MkxvnTIhPvaW46hgf2DLftxOCoDfa1XZA14SSylhqG+465DG
         aDjmGLpg8S3JFmftvy+I5rnduWcFfU/Ujze1xcRvtOT49iVhB78P1zF/AY8UPiJ+vlck
         CHK3MkhviF6TxovDdgCOJBTNRQoQTpn/6jDDkihnnKVrVcnQMP8yikDrUAU3rSN3wdQd
         O3tihL7BZk+bOs46v+W4POQd13vsFcV63Rm59ILQnwP54hG0c+aGsXLpKVgbnyX+tdFu
         SC8OXhBEx/gGg6lI22YbHauurt/RJYBs30kVh2S1+36hkXRwkukzgl1h0LEYGq5ifTBg
         5jJA==
X-Forwarded-Encrypted: i=1; AKwUvBzIGPkV2Y9kgUr57gIlQu9JJ15yeJSG+ZbWFrFxExMfBQxtjwTzBTmJMkU4j50iTr6WA6Z90+VBhMlH@vger.kernel.org
X-Gm-Message-State: AFq9FYKU2KZ9RwZLtJvjgwyk5p3mtKAY8FfbmFLOBLxd9/m4fB3zL4Zj
	ZbSVD8zPzj7RdVVdOChV61wEbMCNc2ZfpIUWtCnU2r5J3MEUgcF7qe9ajlKMLZmwDVp3gS8kyE+
	B550lKBlrEdp/SOF9Jpzk9saROR24ky8=
X-Gm-Gg: AYBFou0gOG/W1AOebgI9Baz9xGovx8QmUeToP3TDSEW4qirgoWze9Uc8PwzzQF/1BRf
	INaBGxOeTqAtnOd6ROyAYhUEQ+zQv3xqVf61pn/rSZY8XrNqtkIX8GgSe93w02j93oAaTf4DHok
	M2wONTOqDrOITGlUtMZ1iKPXiPct+rJR13K36rxDIIqlnZLWBroQ8EvKwz/9p5K43cvPpFeGqZu
	4+UAtkfSovZnWUNQxgzIcpJLExT5mhUk8lA8G2Ev76KJTfU+mf8VrTdF7KbDmUjIta17nY0j5Tg
	gBBja3222E0ysC206kn7LWGqidyWudf0NBOKIIgPM9Z64WZSVSSrpMjf/SN7EDXoMc5bfTYgo9j
	3A0cuxAK4EJtJ8e5fDExjmPIMQhLf/kM0Gci6FRAmbqVsj2G1qgGVQj4w93htZ0VgchhuXae3uJ
	4kqaGVLFTNoG8Vv2GW80oP+Germly+o6Ql9Qm9hl4Jusl33zSZt70=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
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

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
