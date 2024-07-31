Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13141208D1
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461164; cv=none; b=nyTNPtabAWqLxfXQHB2RY+QgbukiJgcnUQeklS15UsvYxLHbAjZMtZw8XXl5dTcfOA4qIoDdz9oS9KrfLXz+PtDfCO02C99j8+zOfx31Iq9LdjvUFnMeSICjQFW+go75LaIGR1/PO+9ecl/VVMHVUHrPcqPb7u1RrdHRrMT4PyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461164; c=relaxed/simple;
	bh=YzqqHah0Kpz3UbF2fztwMnEVk3VdHYrzvKgv3Lijiuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8JW1mZ3KcWfV+fIcI++00MronWBr5oFNQJhrewapwyxlw9twOQBtTGruynF12Ibt5MtOcQtBeGnbWxYEdr4Hq7+sGfKteuLCfXEc8zSn8I5GFwXHgZOQ96ihbfMKduXtBewZLpVDeapjXvYv38yBZxSGRsAVlb/MI8TdERA4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dFIfQdzU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dFIfQdzU"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so5189883a12.2
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722461161; x=1723065961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=dFIfQdzU8+d8vRXF7zdAjDrM9FNoLSUYLIJRbApmFLWRldEaLJw3qPXcRU4DKEwHpJ
         KXTDWwaCtJsEFHDVR2gX07kOMkTTIRCadVbyz0Szkqg6aBFf7AVWEXUTUsvvEkXS7nam
         6tv1obFQoRxUF8Z1K4X2E2j3pzoJbdrLAjpNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461161; x=1723065961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=FHuk1k9Ut+byOR+lsRfzs1DeqGkQqmiL7aCOto68OfRO/l/gYCK73pjh0spE4JcHQK
         k8nwySfUWCAmjJr624WJpzsss7RCUFjMBt1/vYZx/4LdwtTN2rTxBeYePXRSnBxiGdY6
         JjG05sDdstA2sah0yv56n54aDVjsCknRbYuhgNO965v5jKQc7OuFYW+VRzIQUpnXxHpV
         EzpcdgOhHLErKzUVxq1B0n3cykpuFYQUXnCV+t87OjBZFJm+VapA9+EaWPXqt6QtHRxR
         Hx3JGc9QulRC/BP2xlwQjiuNkM4ctEgOh9XVAW7FWh4fk0j2TSu4ozJMsUa8P4GoTWzk
         Zb+g==
X-Forwarded-Encrypted: i=1; AJvYcCXS4MAT/3j6CKxVRkL0jmCXX9YCXDYt/3PA1TjxeCYSjrqoCioD9tti1eBB1dEGXnCtN7R6M+B/NHBSfXgUFz3oNVRe1wrX/B1lag==
X-Gm-Message-State: AOJu0Yz3HD1vkHQu7h+35w9oEiATEPpLZUZQk6dr5cll2HdbPZscEVGJ
	9UGtViaRz3K5Cr0SgwDLJeHR8AvsBJgr6LnIYc5FlqXugvYZToa+Mnzfhz6v/O5mzQIQd3P+Ek/
	J/lrshg==
X-Google-Smtp-Source: AGHT+IHATLpMtyP32GoN7FBZ8j0pQQYuVpA7+ijy9C5034fOXJD4VMsF/RVQWoqH189HEUptjbRrHw==
X-Received: by 2002:aa7:d658:0:b0:5a3:18a6:6988 with SMTP id 4fb4d7f45d1cf-5b6ff3ea0aemr293348a12.17.1722461161249;
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b6de1044c9sm246206a12.18.2024.07.31.14.26.00
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab63a388bso475468666b.1
        for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 14:26:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6lc3z3Tvi7Do4BmgUyHY82Khf08o7Mwh345OZ540avM6jCksdjabnn1s6lm/x7HvY0efa1AKTCwc5ccWAvrattnKw4aYtqyC6fQ==
X-Received: by 2002:a05:6402:a41:b0:5a1:2ce9:f416 with SMTP id
 4fb4d7f45d1cf-5b700f83fc8mr263651a12.37.1722461160632; Wed, 31 Jul 2024
 14:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:25:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 13:15, Jann Horn <jannh@google.com> wrote:
>
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.

LGTM too.

          Linus
