Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE53396E6
	for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059543; cv=none; b=fOkD02da1HJtlwCCBr0e4JLLo+tw/OPxwJ3x3jcgLG5ogNguxImpRYbLcIE96CayJm0sEM5bmxrEmxrEZWjhk+LI0QEVzV9ZdejpghUA4HdtGqzMM+s4itDoDSyaXirhKUl9VnEjP/BJj/DurVzsdPDvlkOF5sPKuucmZChsqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059543; c=relaxed/simple;
	bh=OBPNoahtqLQlrv9m+tCXzf5F3/neltQCeKhi/sO8Jc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx9WQBdFSErb4VyQT9zXe8hc26bPDUSY9nf5gd3zemaz92mIu9+l+SQKRYyhyzjDvaQ83jljWaB8wKY1rm33bkYaAy7pIWqlO1KYihSmmZRUtF+rM3qRhEyP6/r6ctjYDHlfuOqriBxpO2Lh1zyeeYUdeYVNaZeecrtHyiE9Kl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LcxY5cXS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LcxY5cXS"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3737d0920e6so61415521fa.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761059539; x=1761664339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=LcxY5cXSxcD+bd9fo260LBQC6NlDuXditLU+dpVo7api2D4b/EURNlD542ZzX/NOkh
         bJZ2MN9vSk6a7lqsgsgV1zCMndZLDQl8qkH74YfmIBPfX14vxxnVFjUueO2Qs7PM+BkR
         Km7byf7TSLNYFZGhvR8xsv2XyJqx/ktYdNYxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059539; x=1761664339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=DZX9KADqhJ13cuFr/MuwUAHhrIDuc2reUQQx/B8H53XaPYvI+h1GTO3Bz1Cfq97yWf
         3JtXgRdIt+HVoSR3RjRG+yXYw8JkhA09u61zGuFh89FNZjdYZ/R0qlrAp8Q4a00gKSAu
         QqQtfZJyFtZHeNPhd/O87s44Zlfv+Bo3Tj3qT8hZPCH+nGb6V7ojGixmHDGUJDcWE7wM
         kSQmEzSnT4+lKzPVICaf7Lro7cUXEf+aGAUe6dQlQR08DpcCW3ZxjORR4OnhYn3tYREy
         pT9iIrM4TpeaZG13fCSL1cgniC4FyEnBOlf1fg23ozcv9cGwU4ZFTa88o/49S28Pj8hj
         fbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLXNqhOdFDM4LrXRUczjhHxlfxBWxhQrjV74ukcArGigj7OykRmX8AoeHN33J3HSmZUl3ls7/MAVjZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lss6etyACJS+qkUmQAWN6TK4rWau6qqBDJrudFXUdhEZacBp
	bqTUiDXBFBqBCWp5hl/VzdwjyziQaToLMryTHJW7YDec82Zy3eGLVSRtfyvxjwn8M2dGQMkY440
	ku7ep0KzZAA==
X-Gm-Gg: ASbGncsnH6rICmAtlHPywFAe/yd3pm++j2feQfmQ8j9bRjRYPIAGLIlFC9e13idGCcE
	NUi5VjHf/CNDW5wgAY6P+Uh8WmbBfGCe7ps1gB9WMwWPqZxzSUZgtSoc/0bK7mS21+HbPtnN166
	UGACnHsiEDhasZhgizITvPzt6kyOajzgyYynyglwSdTAC/MtjEG1p5DhU3EU5Kf3SVpCf5xD40Q
	voWZ35VmZP+MLcFlitro7J0YZD8OgE+Mu3iUCKUToTKyxmBGWvpMJ7YGECUQ6bc9nPLhBy+qeLX
	2PxpbihaVZy2WP/lU3tuxGPju4HnxjYjS2FXp0aN0pDw896DjPue8PloEgyezuIYCpEgg5T+O7B
	1/xGDYgQHt2g6gKKZTPQjCFXYh2Y877+6JVnALrkvc+lOaWCEgfHeCwx2Yods90uPAvbxwgAZD0
	V8zlLRqkaglvIGDJCw9r25nI3G6vs13FBDGi9gTQk+gD0kLYssEA==
X-Google-Smtp-Source: AGHT+IFi+BgHjge6JzHGoq8RYrTishnPSjW5L9ypYyf9wRdICKJNY6DWCMkmGG+YA4Tx89G/rTLRbA==
X-Received: by 2002:a2e:bd17:0:b0:372:58f1:19a8 with SMTP id 38308e7fff4ca-37797a391f6mr54850141fa.30.1761059538751;
        Tue, 21 Oct 2025 08:12:18 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91b70d6sm28867021fa.1.2025.10.21.08.12.18
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:12:18 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-579363a4602so5777225e87.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 08:12:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz7+CHFijQ/HohryVIpOoyexZr4y0kk607KNJXIYzX7vlRmcZ5lM6nvtYTl6IcIhmOFOFu0gKnnSte@vger.kernel.org
X-Received: by 2002:a05:6402:1ed2:b0:631:cc4f:2ff5 with SMTP id
 4fb4d7f45d1cf-63c1f6c39a0mr15531402a12.25.1761059216055; Tue, 21 Oct 2025
 08:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx>
In-Reply-To: <877bwoz5sp.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:06:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
X-Gm-Features: AS18NWA4hFVtubdvPHiqdyKph2ZRKrwMfjnw6C6eEZqbhQOMaKTPF5q4gpdDvSA
Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 04:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
> >
> > (I don't like the word 'masked' at all, not sure where it came from.
>
> It's what Linus named it and I did not think about the name much so far.

The original implementation was a mask application, so it made sense
at the time.

We could still change it since there aren't that many users, but I'm
not sure what would be a better name...

                   Linus
