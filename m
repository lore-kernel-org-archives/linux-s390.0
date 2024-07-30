Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAC1AA3ED
	for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376847; cv=none; b=H6aRZNbC1JV0OIzRCcwH8RF7s4G9KRR9GbnQ+ZkovxPSOllnG2xnY00U5A5ey9ZPlDHCJHQtp197Zt/FjK8qnUKk2URIW3/FS4TUPagjJ0Y0Xw4gMql3sqigF2v0yl35Y5OBYsKLjVO/Up8Lv3cOfRcHVObfiP0XDkWGBe76fX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376847; c=relaxed/simple;
	bh=x2SmapH/wHIMam6YSDSdYmxNd2TYCeoGfZw98Y7pFB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcmh2jyUM7S4Xnwf6Kh563HX+AaBP1SU8Fmp8IsW4NNKM2CJJ4SV/Lqm8R7AWn4tNoxDYGcLW9GhJxnllJhAgO4W7i4hi2MMCkoVn+iUokc4/r4UDn+KC5uzkuxZuFCKF2FFnc4aHwypq7EZuj7RThxDpTkCev1wqXSyT9vFrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdFDRwtU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdFDRwtU"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so4923a12.1
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2024 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722376844; x=1722981644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0zp/PZK1hqhhla6gYIN9ymMRT/WA95vOpDBdsQdGHc=;
        b=WdFDRwtUkkhm/rVIVML/nE8rrkP2ESQHSaBQKSJJXfYestVJbbvmu4ln67WJcr/p2L
         OBAZAEGS9+mV4XwvPQwOhErRrxlgRweb5DGFQc8iDZPQJ0rcdV00rMfZ62K1/TGwk9ob
         T1kz8Xw0LRDJVcqttdzw7zFDPTfApNIpM0zheSeoThIL0qTurHQanQ4z4VWF0HMb1yQT
         2ZgC4YQXWkz1zf6DjI4tlfRdomMH/xNWH7syiat3tLQU/YhAWTBGih+70rqiEEDxTVYC
         8UdUpJVvLLThw+IMMgmVWLSkFET5Ky7rAYfpQBxIIgRB6+lAMKrogFBVT0wZo2b+psfM
         LrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376844; x=1722981644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0zp/PZK1hqhhla6gYIN9ymMRT/WA95vOpDBdsQdGHc=;
        b=hzE8gbLmK9b60sB9Uue2D+CUdINj+miWwukwGkjOdo4ZVcy6ooopNuPqE4/08JBNLm
         0ir4ecJfIPidz0EptJbpCVOh1ZoeNnGwEqA4gSRxFvXPp+0jzDOAJ6L1PWyekyBn7oTR
         7NoD75J/X3RdhlwLgbYJkvZIcxWHLu8NMId8xwlR4H1kOsB+H1Csca054LCxB8M793rU
         BQVrp/cUJN5ScOF4SaOMO5lffcfUpJKTQ2aoxUe4XJJWmIFb1bUsNG/qvEsI9v0gItco
         hrMJHRiMT2nY/dixjMrV8pUxM+hGlO0sjgkwfKSPpaWsGHjWw2n7z0IlPVDBsghWIyJn
         Z/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWb4usXXueCd8HM6vmX+W9x4Wx9JR9wZYJSXcNr+zPSIoYm/smppLblsqU27ylBFCKaTOU5Jq9Ps4m3/OuBomSAeSCv61kUBUrBtQ==
X-Gm-Message-State: AOJu0Yy4rnz4sqJlUCxfXS+K/0r5A/7OtcqWcuE1KNkYEw2rZwuxXSmL
	Cj7fW5+Aepd/ePF+vUaPCGlJ73auqwMmfjFlgPJi7ijrjfWyvtrqebWyqWfoKy7iHW1755SoeCB
	byPFF0RJUc1Lok+0k0CcrFv9yGWWEuaN0CGam
X-Google-Smtp-Source: AGHT+IG1zvAf88kvECpwWuAK4aUDUCUYd+tbv9v+ciRfmZouVijML/NxH84fWbcGu3kLWdsAzcV3tyF57vtGTsFC+Oo=
X-Received: by 2002:a05:6402:11cd:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b58ea443d5mr64632a12.6.1722376843313; Tue, 30 Jul 2024
 15:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com> <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com>
In-Reply-To: <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 31 Jul 2024 00:00:07 +0200
Message-ID: <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> > Refactor the list of constant variables into a macro.
> > This should make it easier to add more constants in the future.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I'm not sure whose tree this has to go through - I guess Arnd's?
>
> This is for 6.12, right?

Yeah.

> I can take it through the asm-generic
> tree if that helps, but someone else should review it first.
>
> If you have any other patches that would depend on this patch,
> you can also take it through the other tree and add
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> for cross-architecture bits.

Thanks!

I was thinking of maybe trying to write a patch based on it that'd
have to go through the MM tree (for using this in kfence), though I'm
not sure whether I'll actually do that yet. So your suggestion makes
sense, maybe hold off on putting this in a tree for now...

>
>     Arnd
