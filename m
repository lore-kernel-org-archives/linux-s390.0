Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD30188CB1
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617020; cv=none; b=M1ZB2R0OWzPPxOOWkZfdGlqjelUnIK2Jqhj6O3JQ2YwlzTiV8oNfsBfMksOVwo6hfwXDYWk64AGnMzWDmhtzISuf4A1QEaqOy/1a/59yTxEGZaC6Z1e9NlPqAFORiUaW2mHTSFW8woHIijIRoRy9/wwMIekIIQmidKjuJ5lphCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617020; c=relaxed/simple;
	bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJJwT4tFYj9YSNa1CUPRyNubffi4HjSL7r5PiYXWsdgSiywb1+WoGo0bZV8OWgPOaSxucU51DerLsTQxWJwW2Ckx06ZT0n3lcuZvCmZPFfC9VHpgFh7PjRCnFrja1thxhmmrRZeNLrUqrUXCS/OFoxebidcBxUgQPWjKHkeDeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV3TjGJ8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3TjGJ8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4f8050e031so22400a12.0
        for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617018; x=1758221818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
        b=gV3TjGJ8LnGmlHHPLpbBjReQu4ixKleZIm+ZD8DQT/YaZp907tWks6PDPJUebnRUnl
         P7wPAFvCMCGGG19H+7G5JfoBk+FNQhall+k6zD8FCOmGX4XIVcmoBc341XWlUAquZatm
         gRWw2/U+Vtdg6zPS2as7Ge1EkcwyMR2zd7HHoDYlNfAyz2bX3gVCv3Tq/5ng1glov7R0
         gaFdCr1T0pAErIV5vfcEAN5kAML54NnTTpFAs/iZ1pT5BlzEVS/x35DEyv25OJCA/3vd
         f8vhRBq6gMNy7aZpsCaE6kT0LS6ghj6GNR3Uz9uI7sDwpQCba1DkJcfNXPNcqizxVBAT
         5HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617018; x=1758221818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LCm/guDeyM1pbOuWuHtb4/FeaKd5L/pPsDtV39K60U=;
        b=c4MutxpVWV5j82pjjC7jTtCYo+6p5hjPN+bsarLlNxar6WMWyArUPN7ubkQkbKkmts
         7hQtQWZxFV/ahK2mYQOKYPPHP5LHkzwrWc4mpJYPM8CgP7tZClp53cpkGfhkQsSvNO/c
         rRn2o0lBufCFRTmSTfsM1m0QJmocIiRPC0V2bHoVdr8nRsp+dd7IQrCdsJ/YfhTC0ibR
         +SdsPrDGNjvIH23XU0MwmORY9p306tSAv7h/nupYjSMYMXIS5Vin5B45TQJ5D9VCnji5
         HYqwqfzKXIcp1ALkY8uFTMz++xbUMRhjyq9hN+NYC5tnYSKkZv8rRkqm5E1cmfDET+MW
         CGNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTgI960wvcdEHL9fRVpPXLFMHI36HaOiSwpySVbEyGVoMXJPDXyPEkaYwnpjgGxvaZNRrdEM6aqw8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmGxOUPyjreNE6LgtUtyrFkuTDFVz/ZZ+qn9R7AVRJGwWKXjh
	HZCAAy0/BgorspwBGuhXBD7OencxtzG4g6ytzATZuC9ez1WW+Jb+v+5998pZWdYZpF2PXY4v0S6
	MQERQ4hKr5Z9kWSrvjr6MGMpIvcmyDaU=
X-Gm-Gg: ASbGncsgiqnMjdcWOV/SIcVf0xA+6e5QBMKw66NPJ70hXM4QLDthUC+fTJWT6308McB
	M38fMFEIqy0PLXxmMZc8VPMmRQJYFRWk3HyqRbLRqEpckTJUh6thKdsimavFvNzMHpMv/iwsNlY
	A3je/6H1aFzL381hy8r+Em7Ph/lEGsKJo+aVTXnOOtmfivRE8Uf2oYn0ZLa7tB4FbuGkd4FxWxO
	2xpaUwW1mflb72KAHQytN7GJCEuUErXehnVqiR7CryfcAzExv+kG2uDFW8eIhpjTzXcgnMvRESL
	hGp63KCDnRL13aQvUaUeC+mk5429QViWOTk+
X-Google-Smtp-Source: AGHT+IHNFxuMr0HNx3D6r2wcpirNJhsmcZ57cU/PHQO1QLIR7pH1pxNHnnOqtqoIkCYjHEr/A+GFV0gytg3T57f+NhU=
X-Received: by 2002:a17:902:cf4d:b0:24d:5f38:ab67 with SMTP id
 d9443c01a7336-25d28f02f06mr1425645ad.11.1757617017970; Thu, 11 Sep 2025
 11:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910151216.646600-1-hca@linux.ibm.com> <20250910151216.646600-2-hca@linux.ibm.com>
 <20250911013243.GA292340@ax162>
In-Reply-To: <20250911013243.GA292340@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Sep 2025 20:56:45 +0200
X-Gm-Features: AS18NWAUx9lYss-jo7KrNo_jJvvrg-Q82uuHNeRXFQerGQpzkza6gztmm6xMjOU
Message-ID: <CANiq72mr96hE+7HUVedpqyg2jePYqeXGGgwpdPWb4Z_Dj7htYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:32=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> It may be worth noting that careful analysis should be performed when
> adding this attribute since clang's documentation [1] (more on that
> below...) notes that it could hurt optimizations just as much as it
> could help it.

Yeah, it can be tricky, and I assume it may depend on the compiler
version too, i.e. the result could change over time. At least for
"build asserts relying on optimizations" it is clear if it stops
working, but here I assume we may have new compiler versions getting
released that stop doing what the developer intended. But perhaps is
not a problem in practice for the cases we care? Does someone know?

> Looking at this link sent me down a bit of a rabbit hole :) Prior to
> Clang 19.1.0 [2], assume was an OpenMP attribute, which has completely
> different semantics and errors out when used in the way the series does:

Oh... :(

Cheers,
Miguel
