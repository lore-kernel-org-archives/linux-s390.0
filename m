Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0291514E4
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668441; cv=none; b=ugVUg1icTq/SpcSvTDnHPcgUnk7a134fPL2lkJ1BpE8vQWeIovm82p55lHNtK1CPTFYsDCvWbtqigl4+gmE3SeW886FwOZwLw7IyrfB9pYtq55kOq13l/qLtlNPunw3h1PMrWTCXZE/ANcR/cWXNyct8QbmNb/3BNqyyPWKg6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668441; c=relaxed/simple;
	bh=OTM6b8wUF9rw6fOXlIOEcqaTwYbvDfucC0gkj/2fKZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrXRc9QDXyKi3we782par6dX1n6cifZq51ihpLj/o/hjI2w/zGiL6JXvqlNmuDG5Rz1a/L+1f8uuXR5iJVKgOCKmMLRzzsw0PtEYjIHAUjemnodI097s5SDF5WdJ3of0ninnY0ns+HMkfEbkUBBa3eL4ZEt0PqrbA6kloRgLNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LB06GuRz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LB06GuRz"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d3effe106so1383352466b.2
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761668436; x=1762273236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=LB06GuRzayOKRaM/QD99rGp0SlCaNCn7Kjw8BZXMhz8WWp89uABDhLzawEOH7wEcon
         Jafboc0N/z3IR8ckJKvSREhTZH+6dCAHipF37VR4NZgSr1HcmcWX9hP2f1rALTkQ+v5I
         zITxahCjLsvlCuCL6Br+ohlHInQzB5MTGqLpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668436; x=1762273236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7vxW2qYHkfek8BcuNGNfNSQ19bugBoHjwa49fBWcYE=;
        b=N/utPtr8+xIMvhEBDBVJZXnRjsakmFcHdKtEvYVlsOXb1Wdw4KnpLCZZi6F9Exea9m
         1Uk0IMqrrt+APksLU3qUrItBI33KUprftj4QaYKtHV+tqO72zcvftwd2+Pst7wngGg8V
         HDOoJfU9ZfycTT6ahQgPoo7Tiy2I1LUS5yvrAPI+HGnsN9OoxDQLIJ+dJZj1a2ldCQtH
         ZXrAtbgTEPOcN3Lz1+uEuSSpQ/5YKsSuDGKaUlbrrnZPEqgg69U2on6yZk7k0hvxCXNk
         ZCc3Hr6FjAbIzKTAb7XkNAY0OnTJmaOIFKgxiqfmHEw7CRZLqAMIohd4nLP4SGXnm66S
         iraw==
X-Forwarded-Encrypted: i=1; AJvYcCXA0X4eO53St3qqbZD+PnTtXvbm4W9zUqSZFl2oJpZDpFGMMUqWXnJ0ODAIdHWArO1RVwVE9fix8Tt7@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWoBfvrqZDOmkuARdcDgm1aDCOc4Tw2f5uJREehKFBFty8/tt
	w9SJuzjX4vceoEEej/7dcV/vmitRMtzfOOp8Po+NlGadwSUkAa1Su44TCeBBceKrPsGPG5CJJp2
	NyEBIzUtq9w==
X-Gm-Gg: ASbGncvjjmpaM8B6xaDXZuPKXiUz+iRS1kh49O/H++Vvhx9iUI22PJ63I3do38Txca4
	nC1vEkhiE5Uq885UI0qENFMxQ23gJrdNss0U281BsQtNGxtSHYutWQXiXo4ODm+Mys8ER+mVsBL
	IdMR7OeL3eN79Tp52+PZCAure797y4jyjXwon4ycV8H3mIKlk+f8t/7P1epQErXaKGUHh+j4ftF
	+zuG7kcvvd7oDG6QqjWmNNV7X/KCIjIJDAG0L1ksSrUXm5y/XWNgJrQuTtHzy2ef2yjR6cTRRRn
	RApg8wQdX8068W+psoqz9PFaWySuxu/jCV146KyF/yeNsjlp/+WnCD8NK24gax01giBigzgh5Bh
	mUNmzMHkj2S7y77R8Fv91vOgf31fkZekF+n5IeMt6RyXWsr9rAQJfme5EXft9PiR0/jwvEytUJi
	qLTNjkoTFLfzj7b2ArcBsi+8xOMXTgl6uLxN7vd9i+6NvxBAGMMA==
X-Google-Smtp-Source: AGHT+IF2t3QtDqmLqYrmhmN3iHmuw4gl5NFb65kgu2Z8Dgu8bXwQy5UEpK6oFIb+rqsCY6rJrs/hYQ==
X-Received: by 2002:a17:907:9627:b0:b6d:6950:a7b7 with SMTP id a640c23a62f3a-b6dba5b1173mr393478766b.44.1761668436624;
        Tue, 28 Oct 2025 09:20:36 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm1132134666b.6.2025.10.28.09.20.36
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:20:36 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5c18993b73so1072905566b.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 09:20:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWSChX2k1cTeabOxmhc6SXEYVonMo77MLajzU8Mluix4d+HxOZtgh8a1Tr+6qRLEMNWxM7dMTIm8LT@vger.kernel.org
X-Received: by 2002:a05:6402:358a:b0:63c:4d42:993f with SMTP id
 4fb4d7f45d1cf-63ed826ace7mr3748960a12.3.1761668033009; Tue, 28 Oct 2025
 09:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.736737934@linutronix.de>
 <0c979fe0-ee55-48be-bd0f-9bff71b88a1d@efficios.com> <87frb3uijw.ffs@tglx>
In-Reply-To: <87frb3uijw.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 09:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
X-Gm-Features: AWmQ_bkZ4DVtg-fqS9oPLAcmx2bmXbpg5s6Qki9Q4422mgDG3jAT_1tXHLLXals
Message-ID: <CAHk-=wjZ39CSZwN3W6n5kSAqL-OhJghygh3-dRsrJKpOa9nTwg@mail.gmail.com>
Subject: Re: [patch V5 10/12] futex: Convert to get/put_user_inline()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight <david.laight.linux@gmail.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 08:56, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There was not justification for the open coded inline either and
> converting it to get/put must be a completely seperate change.

Actually, there's some justification in the original: see commit
43a43faf5376 ("futex: improve user space accesses") which talks about
the original impetus for it all: avoiding the very expensive barrier
in __get_user(), and how __get_user() itself couldn't be fixed.

So then it was converted to the modern user access helpers - including
address masking - and the inlining was mostly incidental to that, but
the commit message does point out that it actually makes the address
generation a bit cleaner in addition to avoiding the function call.

But I doubt that the extra instructions are all that noticeable.

That said - this code *is* in a very hot path on some loads, so it is
entirely possible that the inlining here is noticeable. I$ patterns in
particular can be a real thing.

(There was an additional issue of just making those user accesses -
get, put and cmpxchg - look a bit more similar)

           Linus
