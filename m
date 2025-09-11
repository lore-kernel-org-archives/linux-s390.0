Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0531863E
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617490; cv=none; b=RXJVYSqBwgIMvcNkZh7m3PXZJS8AsxtXedGDS0fXClI3v5C6Yp4L9b+mI5rXTfAJGE2KONrd+zEMOprTf+WejEnpVc3fp6YEzurGEZlgSndOyFrmJM2Hm4Ldkrtdnj9KJHqdrDthXMz/PmL8LJFoQ8G8ABKFg9iNA+luBcdAB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617490; c=relaxed/simple;
	bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHny7TEppExo+ocAufcH/t9g5FoXu8PNWv7fcSHhhVnYNo+5/ZuZ7xVLfdcLt4D/zvdQwcLhvj1DI5MQ7mY6BbgReB8ae7gS2GARITDq2VWxgqOWgDF2uARvWtJcLUENfgDOV2Ll6ExC0sPYvM7x+dDmJ+HgnYqvaSTfCgMt4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsR495xm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsR495xm"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25bf9dda1fdso1669305ad.2
        for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617488; x=1758222288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
        b=RsR495xmfdTYp3+BHA/jh+uxCl+a5wbTBnasvdT+q2uCjZcsnP4JUJ4fW0aYZO2llh
         IOPcZVsn2kuKJbjOfOqQZZhvNVupevRIlzNYfcGQ43NnuhiKZD0yr1RIgwZ8wg2F4FjD
         LyvRGI05t/o+D2oo68QSy1HMuN82hWx2f1Q1ZSyG/ehhhS1QkLQDYCHlp3YmGXxmk1V5
         Te/AnoII/V7NQC2yAds5hNq3ApJ43xjtkeIy0OLEMy8I2i9d0ubM4lIViwCvcrxATo6H
         BGTyVyiblXGwjHoZnyzbwEaUY8z8KtBwPivvs9qrAAitIWx8+BwaNNhgvs32T2TPJS6D
         P6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617488; x=1758222288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXkH7IG5itXt2SmPip8bJaP++ykY/AEN0S8D5dtt3i4=;
        b=GqIoJjxXCGtHcl1UlG9owvYf/bNy47aV6rlzhm9a5kXDdAmPkz1D9jzgcdC1RLv6fj
         izkAV6nu33enF+z7m12xvtsy41v2+OPx8NQbF5L8FOIFlbzLpyNzMWUASoK7qBh9raxN
         SwfHuXVRE8MA4qS7lYvuJo3bGEaBN7PqVn2YBWRaxsOoc0Ea7uNw5nI0PgYLUl65wmur
         oEVxvYB+TOdYw88fqcYR2QZiXlmrinHRYuw3ibRkVk6C0UwIHCIceAYw9K/fD/EKRuJn
         tZSNCLQ8c0T9OvHK8JkO7ANZNeR4Y4XCOVvaDtAe8OCkq0JS1h5wuLYDZpIg2WF9vXMx
         rxcA==
X-Forwarded-Encrypted: i=1; AJvYcCUi+lWXi+B16t+54LirxEFdctOPHkSyo8o9n5ytx7IyMBbwS/ipuKfT98nxdwruRVnUFiHQ7/VO28zw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0eVVf6XbXb9TNcwxpX4tSC3/o6II7+N+cUYtn4HTgLofeu7p
	Pw99gBkS/KlAeVf4/qkcQGtx8pwm2k1xWmW0eefsuykqGK3tUh2Ch2zG+z5NAN5hcN5ix3V9CMr
	Q+7UbcCQnK4RBeBjFb1QLQTuFPAB0s0I=
X-Gm-Gg: ASbGncsKnTlvS0qqGjPuJGxoPOCMEveACTbsCwsKsYYUfVMmqAtegG+VDyJaITdR0Hr
	2JZt0Uf46juJy766xBOjK3+eYaa1K5gugZkIQlOTgOtMVfrDhd5ZVyttT2YdYiN6bm/kEgWImFc
	M9LqxjkYXyKSSNIHVnUzlcSTC4UgLO85cw6JoJAC30nN577nAOiXyW3AEb74rsej0PBi7v09pvS
	qtz0kTewLChfGi6+0XvmA/2ELTnTiJd1YQaHIiegzUNLEWGN++W1I8VU1om0ejPL0fk/PbD/znU
	KzGbQjwzjMigAtRUAXRu2AyYrw==
X-Google-Smtp-Source: AGHT+IFtOJr7VY+2LEhl5aMk2PoyrpBKl+Pkp7GBG6r4rETx5wsdCdKzGprePS6AckZkoCNRk1yoqNC5tcIfdBwa6VA=
X-Received: by 2002:a17:902:eccb:b0:24c:b69d:5929 with SMTP id
 d9443c01a7336-25d243ec0cfmr2539275ad.2.1757617488573; Thu, 11 Sep 2025
 12:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162> <20250911145659.8894Dea-hca@linux.ibm.com> <20250911184429.GA2395987@ax162>
In-Reply-To: <20250911184429.GA2395987@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 21:04:36 +0200
X-Gm-Features: AS18NWAwft7HpNthq0uaNRzFRK30ynGsG36xk3t_FH_3eH4Ssso_enqZ-_f86rA
Message-ID: <CANiq72kJ9L_Kpv9+z5=xZvbWxLRYXpKS-76XwwvQP+wMWsMJtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:44=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I do not think anyone really owns compiler_types.h so unless Miguel has
> any objections from the compiler attributes perspective, I think you can
> just take this via the s390 tree with the other two changes.

No objections from me, and thanks for spotting the OpenMP thing above.

I would say, though, that this is a fairly general and subtle tool to
have around, so it would be nice to have others chime in. In other
words, do we want to start using `assume`s? Should we constrain its
use a bit, e.g. say its use should really be justified etc.? (In the
Rust side, a tool like this would require a SAFETY comment on top with
a justification, which may give a developer pause).

Thanks!

Cheers,
Miguel
