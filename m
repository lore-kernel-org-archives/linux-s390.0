Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76202EFD94
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190916; cv=none; b=jkUBVtkXqfuDBDOSMpk8TlAxx0jYAtD+n1tvti03N6AqR0kR+FkklgnjpbFph6TMsZtweK4a5Sjxp6tCdDkswvbd5Zp98DdWVK+Ujuzez1LxJG2+V+A63UJE8ITigdVSYJPmGs+42fGcdT/nCCFkTCf4PQr2UO5mk9l28Ul7UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190916; c=relaxed/simple;
	bh=NQoGyMTrLvZ94cQK6qr/U5S3n/jCYrB9gj8+lWNrtVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StaNQ3HrnrTLQlOTh2pgqdPsickI0As5IlOrakQRPeiV9oQNwdFgTA5ZF0D+ZUYYQtnCC3r5A8axCebZB0az6VBnpeuDDYR8duCpv7cDZXKk9nuLY2rAAaPvxF91LTnnH3FfKYhmCwOb1kdyJrbBkVAFMzzv83BMMzBxxpHHwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=acGJo568; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="acGJo568"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1014054866b.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750190912; x=1750795712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KANIOG1UnKUU5UjGnVcj73JF4ShRkYSB4zL4V2vR3Pc=;
        b=acGJo568fJcBkdPZqN89p/t9YQsxbjcU09JVjucGRM8wllvT3/mzd+JlFv6gTSrnKL
         6W8qFHAuKrtfPDVUtjS5hvF9TLNVRLsvvJ+t9D0lbf4Yi6cJoKg1glVnY0FIFWXeGaJR
         M04EciSYHSuJ7qLwtuyi6SWrbNNg/d2QnjDeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190912; x=1750795712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KANIOG1UnKUU5UjGnVcj73JF4ShRkYSB4zL4V2vR3Pc=;
        b=ZYK9YaEiTjNVMEyaWrWz2rQHSDEPhkinQ73WYlK/1wQlDzm6+C2wXv6R3sD1QyrWZ+
         EIAYzZDJHZe8j8Y4mCVIMZj6sHLv7rAF0jx9Tyy99jEidIgLThAuw1P5ootj7qYzAT1u
         aLo4StNuLpPU0SJaTXWJBX+DqIlTybgicNc4zX6qIalV6sOTHY/y6IwfL2bj7sRyGzkI
         KyS5FjLjsBE0pM/J3ljVVzQcw1lPi37K2gjdOV/IFCrbIfRdT56WkuOUz7dDrgBxLPGf
         Ny4Fk4NHuHjouScaZ3HOJWOKfKLpNCnTIojhunKSCt15v1VeaOKGCXHmdj8yGPF0KLzv
         h8uw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZNUg7Xey55m6iGFIH2G8dPNQCim5SzLfGKMANqBdJhURLW8sVBHW8TLzvl/4NXq+umbyCzI8GLhu@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCPzyKhvuk+vtr1mnIEqaoR8kcJ4xf0HSXzg6zlzCPZ6ysI/C
	6QbDKxEcxFMkeP6b2OOyTn4LK4Qiz2m+TBFnVHirk9KniSdI8HBVO3nERtqDwJNWS84V40/VDnK
	mYhvX00Y=
X-Gm-Gg: ASbGncvfZUQvjvZI3X5Vw2asMW1q1DgrWujlDFc/k0gsPjhIVHUBo9s6tfeMkdQ8ok6
	11kp6DymyuD3f3H2W+W0h8yW8+UQ7cq8/beBEPcr9Yt1gEPJgCkvx6KtTUWCgC7OnW83xs2dAxE
	edXdgWVgajzV5/pRdxrrBhG+qTOcgKJUa+Wkzu/A2tqtL/Hy7UBBqsVnizhzXwG8ENOWCMNPMUe
	MH2kIriPczHmxISV4SEu7N8STiKc9Yt5T9opjeEffDNXnPLpJAdcJZHpM3KsJH20aZ5VcrPJ45E
	cIpv9EgKb/5PCkHzAq2xL3teDUhrp40bU6QMbjSlo1ctCNnPwJUa4IWWPDpXdrpvAKf5q2vGKPr
	HT2UYajn/Sn+tKxZXvjrbXeRmdl9fbnWGYAWqwfECe7SCCTg=
X-Google-Smtp-Source: AGHT+IHJuanyBB3Ejl9Sc+v7zQiblpJX7ZQ1yaQeuekNLUvTTCU/Mh9j5ty8GV7FubcjyJvTqFJlPA==
X-Received: by 2002:a17:907:7f92:b0:ad8:959c:c55d with SMTP id a640c23a62f3a-adfad2a1efbmr1582602266b.2.1750190911782;
        Tue, 17 Jun 2025 13:08:31 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf2a174072sm836045766b.32.2025.06.17.13.08.30
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 13:08:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso10273253a12.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 13:08:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqS7Kge+ji2JmfjojEEZR0PVT0TG49kJFyrC7y3jvlR12u391WuTRtbPX+6zTB1K4yi0RZXTD2DPyt@vger.kernel.org
X-Received: by 2002:a05:6402:2550:b0:5f3:857f:2b38 with SMTP id
 4fb4d7f45d1cf-608d0948ae9mr13954090a12.17.1750190910438; Tue, 17 Jun 2025
 13:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
 <20250617192212.GA1365424@google.com> <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
 <20250617195858.GA1288@sol>
In-Reply-To: <20250617195858.GA1288@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 13:08:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
X-Gm-Features: AX0GCFuoL7ATRJ2CnwP4RNLTBvlSmkXnXI8fTIZk-24R8V3-BYf3WTK_tAsCN-o
Message-ID: <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 12:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Again, the tests depend on the code they test being added first.

Sure, and that's fine. We have lots of "this depends on that".

> I could do two pull requests, the first with all non-test code and the second
> with all test code, where the second depends on the first, i.e. it will have the
> last commit of the first as its base commit.  Is that what you want?

Yes.

Or if one single pull request, split out the diffstat with the
explanation (that's the "Or at the very least spell things out *very*
clearly" option). But two separate pull requests would actually be my
preference.

          Linus
