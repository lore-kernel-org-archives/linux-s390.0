Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03231522F
	for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704766; cv=none; b=omauMEU5ICe0dcApljzpq3iLg1rmhS+4YijWuZoaWUKqcvWj0xqhu7cfxMN7MngERRG1SZqw1/DyTawYhms+ax6IE+U01aa2jhwTvqCw672Ym4ftwIzR5tQ1pPSKPnRL70tET1QLHZ+5vfpUdrfsqJjrQ82O38Hm/mTHNxrB5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704766; c=relaxed/simple;
	bh=hV6pVJCy88z+Ez46hm5FvsCmrpZWxYrT9wmMYgVLqLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIXJLynhip4MBTX3QLxpJLmNIlyHvL+W3Ii8Tb8jDj1Z95U+JxTwUJZq6Rv8QIvzJcTUXiRPj7ahInbM0DmuL0Od/t4ZpE0Esd4cSzXZzdcQ29N0Vpaw/1UPaidlpTjjpk1AokhJ39XqfxoZP6z7icNE1Pd1Uckjto/IBm2oI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=No3ZD47h; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="No3ZD47h"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so4679103e87.2
        for <linux-s390@vger.kernel.org>; Wed, 24 Sep 2025 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758704762; x=1759309562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxEUHbOZ6w2gZYBHft0CTA/ULDWZ/SYwd+sBl17eLJY=;
        b=No3ZD47hjgaFPxmRksDyPOSDuAyjKgEYOYNinXh3OjHiQNH4kHujlG20smGHMAi3lK
         YdqoxHKNnhVY8heTbGBk3G6MGzS63YlJ34CWeGYlNjYdmDqJFXiqMKwRO6iXd/zFjmrf
         Os607w95KHMvEGNTbN2Yz7DBXVMK6rj56iliKsP1Yf+LnLYkjqtaD5N4Ir0vmxiMfiYg
         Wo4b2JNxDGFN4jPIBd2Lt3ngYNQbTXT/bEiVtN+yvFJkYVGAJEQUFHgaUavHj+AQWhTy
         wIFb/WWKqZ9MzYWsPf/4XUS/SzZjjQ5hiA1rgPQfekmSW0mZhx+80sNM7lwqPxeIcu6H
         8iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758704762; x=1759309562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxEUHbOZ6w2gZYBHft0CTA/ULDWZ/SYwd+sBl17eLJY=;
        b=qDlXXmMtrkgx2yjhOoCE+zxzkZglWAh2ChJECYhJK74iEDZzSxq0IfLg97zfZuDD4G
         3BxPryCORUyBy90gyYmuSqcSmK7Ba53CFMIHtyDpJgmoy0xw/O9lrwTGxO3ihea1wgAs
         vL4yLRZgaJ9Ao7U3U+gMQiM7bMWjnbbMG9zHWQcIBdy80oLFeMAkTvf2Ap6SMcKqxroY
         tlXRtEB9JQh5n0RjQw6E9Ezf4x5K7o0oj/emYxvshqyUU5W7hEyJh58mpxtGkL/yQexh
         zHXAd9hHTMmZI5rGzRkSML2RBxJR3i9XTqK+1R2j3VO5kcq3TwyjdYWDeYONnZBsO4+8
         OxfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqapV50U7rG1JitvYLPbPjMXWQb0E3fJn3vehTZU9h2uMrU4tsxA9VuCR22b4dnzQgIbWvI7+xLk34@vger.kernel.org
X-Gm-Message-State: AOJu0YxEul3kONgF+Hk9uTRVghMmylKZn5xgXLYc4j6ZUbOjAJek+5D7
	phJKxaSplYzeJ6RKYxmEIUHMrBVV+Dp3OHCIdkL6eFLxYrnE411oagp0TYp3WgN7SZKRbFGPOEp
	uDZKOCBQXVgqb3wY+lxSwxjxlC/S/YJMzAghzZN9CYg==
X-Gm-Gg: ASbGncvAKlLzuhwv2SqczK2uICBY539tPjTNRx4JfqstufxxfceKZc6yNeAfqfFIbzT
	kaN8OwpgvRMoBb5r3jDjkpZVXr/1QKmLAZ+bOwN35YH8qNrgat3CGgefpBvTVkN2jFJepWxIILx
	UkWkxmRd60O8El7sFYQxOZxhcgQuJAZCkI+D7R4jwIH0DBVlSpn4K3y3W02LDf2AWKRiLiHqJH0
	Epceq2i1DuS3EAiM3OQhphjNdIKLt4bjYoTZ+LK
X-Google-Smtp-Source: AGHT+IH7Nmy3mld+qkzUDRq6dwD3hmciCwsBuq9DPFIP04OaJHup0AtZbCzJqBcnwyE12Mfaz2q5Ei5fZhlAOCiBhtM=
X-Received: by 2002:a05:651c:234c:20b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-36d16bf698dmr16950931fa.26.1758704761910; Wed, 24 Sep 2025
 02:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153859.363593-1-marco.crivellari@suse.com> <20250924090330.7748Aaf-hca@linux.ibm.com>
In-Reply-To: <20250924090330.7748Aaf-hca@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Sep 2025 11:05:50 +0200
X-Gm-Features: AS18NWBgeCvLLAozlxVxWa0adq5AECdaXGbqHkUSh_nmAZ-djbth6cAkpVPaTbs
Message-ID: <CAAofZF7gqhoQzRZh0=O8oAzCabMrGZ-rZkt18Vpc5BkNywVj2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] s390: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:03=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
> > Marco Crivellari (3):
> >   drivers/s390: WQ_PERCPU added to alloc_workqueue users
> >   s390/diag324: replace use of system_wq with system_percpu_wq
> >   s390: replace use of system_wq with system_dfl_wq
> >
> >  arch/s390/kernel/diag/diag324.c  | 4 ++--
> >  arch/s390/kernel/hiperdispatch.c | 2 +-
> >  drivers/s390/char/tape_3590.c    | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
>
> Series applied, thanks!

Many thanks, Heiko!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
