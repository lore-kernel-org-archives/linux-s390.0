Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807F22DA0A
	for <linux-s390@vger.kernel.org>; Mon,  2 Jun 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875579; cv=none; b=UA6DnhS/NlCt0VnoP0ivFyt5q3c6oy5WDWVV8265sT6LtG801RhjBsePVS1XLFbqoA8Uy/Yzv/cNjR3zM8Jc03NtSTqFhUWGfZ2HWuhJDRvD6bdTrSe0hbWOAGeRvlQ8Y+Pqnm5JByD1qxgOuIIhuXwuQNoV6oj0CRzZ8v9rXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875579; c=relaxed/simple;
	bh=BMdmqxyCVbd7fEc++ql37zNwaBo1D8/TV+gOsCFIGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6tNEtfDnzBn+P1VcntpGpA5H8O2OI24AJPCenokET0h/NayLUsT4CAkRQkbRieR6fnUnQlzGRpY1wcCMdjRseTFnuVVgf3AXGBJ/OrD7OSLwATBafJxIxDIxEE/O+6XSFmdLFdEB730e9XCTBSfvzKGAEchd2DJiOhPKX7Xt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pol2xe6i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pol2xe6i"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad88105874aso701577866b.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Jun 2025 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748875575; x=1749480375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=Pol2xe6iLWUjqw3z1pMZOI9UZRPPdcVHCR5cwytf/Up+ghsDXi75lM87IFF26FFZIh
         XVIySgqsN2xGMeRjBzAUwknaidY3P5uDebKmCr5pv0qIi3FBSHcll9Xi5x76Xge1OVdP
         xPJUuE8ihC25KVehmFitMIDIIRFxdCKWeYoG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875575; x=1749480375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=L342vJR4eSyV76SMM/FlV43u3Tf95aghSOzND5R2qz3Y5HDaYNZLPeXV42r8ipnNAW
         q3HJIhO12WvdP2TL2fpO/DBK9r65P6/Bt/kPR1wwF3dPsV7H++1DUey0Q0zDKqEhNw8+
         pkJUxBkdtCBx7GzADxA9xluEPl9sWNaHVzIjUfo3BhWtTNEnj3K5VkwiQkWsdeT35U71
         epTB7fxJWl6mmf7YKZu0hDjxvACS/lH0gR5qYZaVndEWf3nZr8NuVUrHM+AzMItHocEU
         hM/ErNvmvtMCb2U8PBJ0B0NRwKlOjlZM1u6vGYINQP8gkXVSQb3rjiZnBSb0tWBYDPMZ
         E/JA==
X-Forwarded-Encrypted: i=1; AJvYcCXafxa/ogZ4OuhVw57aC4B0hrFUhSZvBk6Jnfuov4Mgx92V+wjA24JLToJr9HGwRxL7Am/a1FsxSi2L@vger.kernel.org
X-Gm-Message-State: AOJu0YxZv0xhSwON9wCmv/xwtB917s9dhycD4OekOeuocAsAE5E/V3gT
	mo9wcilN04ggv5uzwDzLDYsKoOX8A3hgBoMJiraxWRz7TNZXxIwlsc9eO6ZYKdvovIWhwJ3eCBT
	U2ui4ViA=
X-Gm-Gg: ASbGncvCuXgzFw+nzF1NiEbGQJJn8WYarjc6vbKoV/o5z70zrZ+FyPAse6eqsquRSV4
	V1G4YY+fGQhp2/q/1bKxbpczz2fi/TuHQPlhlw6yWgv5aX4DfjZgjPPoWkSUSu9lx28fMig68Bt
	W0BjNackVQnql3WE87VPgfdk7bgsbApo5wL7k0OC3hQOR8IrCRKRpXDIhdEUl6A/KrGILvhr0Jp
	v0VkZpjWV7GTOVOazywSrb8f2DL8y7tK7x19IOChpGENk28EvpLqhiSPxUylpqHREqQ3G31/Q9Q
	rWkakRzDZDq3l413QwOghDfP/cs34IH4tNRZdM2TrmGJg5UUki7QBXbBeW+LJMHNB/x9G4MGo3c
	JEwWIYwbd5oQYUETOCVvmdpKW/w==
X-Google-Smtp-Source: AGHT+IH29XowJT7lFYZE1xujEc2UrVWi8zCMYi2RuZlqj8TUzGfB13cY/Uw/bJydvcbw65vQLN4pUg==
X-Received: by 2002:a17:907:3dac:b0:ad8:93c0:27a5 with SMTP id a640c23a62f3a-adb322b36ecmr1321496166b.5.1748875574656;
        Mon, 02 Jun 2025 07:46:14 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c756f5sm6277371a12.45.2025.06.02.07.46.13
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so6398958a12.3
        for <linux-s390@vger.kernel.org>; Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy7xMofE9/NJaE8Qlol++3VUkLYO+737WBBq4XGtbzM/Qj3JQCBvmj58RO/7oSsYScS1yR5xUoxYrl@vger.kernel.org
X-Received: by 2002:a05:6402:5205:b0:606:3146:4e85 with SMTP id
 4fb4d7f45d1cf-60631464feemr3563572a12.4.1748875572780; Mon, 02 Jun 2025
 07:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
 <20250529211639.GD23614@sol> <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
 <20250530001858.GD3840196@google.com> <20250601230014.GB1228@sol>
In-Reply-To: <20250601230014.GB1228@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Jun 2025 07:45:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
X-Gm-Features: AX0GCFuodXM8SKmhJCuuDQhW2iq8pjrSnsjy_QXiBCm4TA9D0azfhocKT2KWhmk
Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Jun 2025 at 16:00, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I implemented my proposal, for lib/crc first,

Ok, I scanned through that series, and it looks good to me. A clear improvement.

         Linus
