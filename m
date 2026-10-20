Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515960;
	b=VQZm4pT1oVR/HC6ETZE5RL7nK7DuoUqA+LXbKf7Hg39KL7dMcxXxbSkUt2Z5f7qhQIYR
	 xAtgVBG+OpqRwc2NPXIFDMYLTqLPiCndV95wsIrXE1v9VVzVd1lAfN8+juFTrJGJeFXBr
	 m4qlna03RjfkXjIY+PQo5ub4wF9BYmSX6R/iyN+Sfv6whPIljJV70ixYEEtgi96KfU0CF
	 3dbfygxGw1eUpndRrRg1AxoIZsmfqg/o8T42shllKHwlCcxCI0C9ZuoSa5JIT/zhJs4EK
	 KfHr9rHzyikmTiLo2lXTx4HrYBbeiHTfC7dctOpqWYx3SSldBjkhglRQpNxrzvp00RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
	b=f8TdTnMqKGCfuWZ8NYBeanW8NsdK2xLsY3v5nVjovm6xcywgPxcOvMxp/nO2J+jVZaos
	 mNmSjeRVExjuGIClP/pl2YciHjybIPnEi0aoM9D/mfO+yp6xQUhcMF1RK14J2CoVMNz49
	 nsbty/E7JizSp4zIW5QoWYm6qPCTJf7mjY0MPK113Nn85MieMcotWGnZ2kfqMu9USVYWd
	 m82suxcEI0gjO7g+CF8MmeoY7svXb2KAMASriMWhsxtTDtAQXlMmPVXClmRBhU4cjQFs5
	 TWzyMPNUAAu9Ppk296e5QRk4XGT7WwomT12/AEGjWkf+HI93MNlz1QWTO3yNKewhfdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EjiCtsY/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0906606A331
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 17:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0906606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EjiCtsY/
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8a376759900so7167827b3.3
        for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 10:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515959; cv=none;
        d=google.com; s=arc-20260327;
        b=DWolsCPeYZD48wSg6BFqOexgr47z1tt+DBINZ+X0AmcIfTARnOFXg8EnKzdcSzlkWz
         gkPIN3wUUK1ftAZ4IXia25lYr9j1yruzz/ktNkggnKeBsKHzRM1QIZ4PA9h+PsPmqOd+
         UCQSZqhTlXutCRojt1wqM8bKzoVFCHxdiGi872tVxB7Am4I+TJNjx1WSfSm89QX8UWKS
         CQKoVFd46JZXfLFyeQtyYE2hvTStDwQBcAXB/iMLz/NR1DL1CX7kxMwfpcijf6GFatwV
         ARLOgdTORhozGmhIBGCQUhBp75ZnA2+68P17QtpkyAotykKR3tHboR+m5Nfb49991/xR
         Mb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        fh=stGy0Ya/A+Q2sEakM1sFKQoU6I+aAlmCg58Cf9XzT1U=;
        b=Apr/CeSoTB/w230Gx2kae9XezuZ9S7zLiGPgIRrK31cgaeqpko7DBs22y7Ts1YkqRe
         Uyl0jDIk+SZzuc6vxUsODuzbV8W3r+2OgqXxvRkrbHY8SQj31/1z9/t7foyh/ZNivvm0
         yoGluMJP0cTkEHKFuZHVD0U/1aVWzJrGeKamPFuxjlkIzvjRqcd5bB0AUn181eG5v63+
         fH6iDsw8dq4K+gqaz5vf4a74EZv4G3k3FAeloYI7Uj4ttQ0svQFb/yS4QLvCqn6z0BaU
         b0tOv1CbLDW3z0to+/L4yhHlGbEXweC77yBpc2rEdAmhWmm+mD8jnD/TGg2EWyKDL7Js
         TePA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515959; x=1793120759; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=EjiCtsY/ZOF90gjCs/BDy14TUFvLnpqFVe7zF4DpPHBfTP6HnmeZFgtdMcb9BvlJTp
         4pxSbR5yKKYpyLVtBdpCBsvyBRD54nXnijUfOskpIyUAV1j2g35x18xFYvNJmyTIYgZt
         0iuxf+Px6JyXIGwyCSNSM6+QMU9PoDZyA990d3LGTuvOicsVF4XRBN0VpNObEKNthGjJ
         axPCwU/9cS7gMDkq+phYi5LAcbFA9Pi9h/h2LkktmB6IW4qqlRmTx/BLgILC5JIcw7dF
         bhbJlMjF2Utkn9qL1MppP7RH2+AGU3g8+qlJjopyhCLl6gosrso1m+nEzVxM4AKoFKV1
         xu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515959; x=1793120759;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=UtDPeXitxUe9IfCR79itwM5wFhfZQSS3rmcfcRv+FuaA2MLljBTwXnziHeuFWxVunC
         sn2j83DChJH7FlY3tu2JtSZOdNIKOBtnCDvRoDLt23S3TLQLx4cZVOoYkiFMWowqz/4O
         77VkcsMGzT/TrFt2sen9gBYca3ykJ3y6eYZafFaCFcGPXZW0+NA8qw0n8dQudWXZZhmR
         TAMliQQxQ2RjAYw0AIS0HaQzAdLdWnB1qQt+hZCYZg5xdQNGO0exwe1fnmpqk1EX7nsj
         8/qZwSosmZM7n5s+CIWodmw/z3nJacbc25Bj6p46+s3+lc0sBr+6SrC/bJWObSSG/snN
         ooPw==
X-Forwarded-Encrypted: i=1; AKwUvBy809YAzyEMFsit0lKEKCoK0gTAbQoLkbhF3rh9bWtqXdBi+IecZThmX5jgYhvBkfizFj9z2IqomkmR@vger.kernel.org
X-Gm-Message-State: AFq9FYKBaOtPWCjsn0VZAc1sC07LEzMtKk4yHqR6VSBMgkiB1lxs2E0m
	SV0uG62fqq+AESMQYElItpe4R4HQvx0NeMWcWeNq1HWzIsMJKEkDZTgV9f4oB044962opO7sp7l
	TZuOkBg8ZyeRV1JZKFbXILcPYTHFABkw=
X-Gm-Gg: AYBFou0Ljm+SgbPWaILYmoWL9ggLduLQe4iVwFnmBTalPbTFnGyRGa9Sz4ZyQG+kPjG
	PHW1rzXSOxSyLEeTFuKNtzIxTjcMx/irnJM5xCMo5GPF179AlQOfTSQjYp0rAcd4yrfq+xY8pbz
	2l2IhXf2GTl9F+mqlP45z34mFr3xSqMsv4LqqIUinzfcmldM/cWx9PyUPAssZpbvQp5Em40xGqf
	h5RNi857ILc9uecZJvb4HxwnTgEcth/kCUVHPno6gG5sGjUQya26JeUe0wl+50g5187d8Apo4fF
	QmU5d6O4aVknbM8CWctGQCAQrMwmZjKoGvsEeaD8AJfJHnldqSrMEg==
X-Received: by 2002:a05:690c:6087:b0:8b0:da84:d1c1 with SMTP id
 00721157ae682-8b0f1f1a89fmr64960787b3.0.1792515958898; Tue, 20 Oct 2026
 10:05:58 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:58 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:57 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 13:05:57 -0400
X-Gm-Features: AclHuK_DtrU2XCq8YwSMY07NqOt7wGt-hW6PGZPkgwrcRUr2dimhQIUPQ6PwL98
Message-ID: <CAPAsAGz89aKUHzm6U9PQZfkGq-GnWsm8AYHeo5+4u34LHk4uZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
> does the word loads of the dcache name compare and of path name
> hashing.
>
> None of the KASAN test cases reads memory through it, so nothing
> noticed that KASAN did not check these loads at all.
>
> Add a case that reads a freed object through load_unaligned_zeropad()
> and expects a report. Skip it with hardware tag-based KASAN, since
> arm64 turns tag checking off for this load:
>
>   kasan_load_unaligned_zeropad, x86_64, generic KASAN
>   without "word-at-a-time: check the first byte in
>   load_unaligned_zeropad()"                                 FAILED
>   with it                                                   PASSED
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
