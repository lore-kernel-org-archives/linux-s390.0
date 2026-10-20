Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515536;
	b=sp2/9tNkt1rUXA7MWT1b/l/34HpLyFVfyndJvfX6yDZD4l60mmtCx/DuBkp1AEhUCd6+
	 sLTm5mba8z8wpC3hy/DcEmwBvykCw5mFGkYeg+2TuhwqjJq5JzquWSJfiRu+kkYx2D2aA
	 0VyOsg4EI5jq3nGOSeCls2QjankdIrPK3LIa+72BitFKH/un/nypk/bBnqP7olpULNNZB
	 ZqMM/6hPEuHedV2RGvgzuxzuWcugxDM54zXg4WOVQnNiDPPFui8/eDGoByuGMcpMlm+o3
	 jGZyM54GS5PuYcfBrp5O3bpAYBCtVXn//DM4uDTjFg7bJOFwYlrYOpllXdXAQM7E/xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
	b=qFYNsV67QhfXMLB6MgPOS56jU8VD7CZJkXz0G3xKKpVZvKUBkkqZXgxN7ONn0NP4Kd52
	 OBx8N6Rrz+nkafDzhMMa3tEvTDjClnyr3k3DAeNki2ZVoshE8i4WTy7jwAQa+l2g/mXEd
	 s6DXawSc0xyFsrsFgwdV/9SewQUwbQyM5y3eEN4HAAW2uhGcZHYVbUerb5WG/sxaZiqni
	 4Tbu72FucF3+krAK1eigQDjZbjqBoSLkBvuVqacJzOSiNAb7hEjPd70ri5EsvXQZ0oKxB
	 s97yn+3jscT8ZdZEC4Fsc4Qqt0SC09SCnkNGyB0IeompyznqKSwE0P/b1dbHRd5UCow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJA16jB7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AF606A31E
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 16:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB7AF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJA16jB7
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fc7e0ab25so503201d50.0
        for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 09:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515535; cv=none;
        d=google.com; s=arc-20260327;
        b=r085drnC7RfpbCNJgtInpvRcpeI7bRaKisKStP8KnZttZc3YyQ9yKZnM4PU7E+4ovc
         c4qX4mQKexlA/e2gIiw/ZDh08EXJ7BWt9BjvmMILZq4/lnoi+X1WJp5PzT9D/o99tfX/
         sqqo3CpDTp+F5MV0CmvPaxl4XT5CRZOoK0FntTXxLyxAsl1cFLsEKRqMb+4FuL8k9KNP
         8cgvYhkOIReCPeP9kyMXqcYJ/cTmyiSxo4w4dX9Ta20Y5ZtfWiOecQCAjsXfLA4I5Elm
         e+x906it9epWzRbBVJzvXb68ja3+6YN9YlNww2H48lpNSn7EMPLI7ovhAJeYdgn+Gdwt
         XIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        fh=fWSRmLt9E7SL6XigKNSqWWPEyxrzUtXXWGSDvrCiqI4=;
        b=hSObwXRMNvNgxynJ5aOIA81kjHcHXQcOZHUEq++q+b92r2oFpCEB6FJ0/GFjuKd0+C
         QPR/S46oBO+bdJJw5D6ktH7UZIB6WU7SVNzB0Hle1Bd/YgxKbMPwN5Z9a7nUbMKGEt4n
         qq2rFe5B1hX5k0tQ6/Qlraji0z4t01bB2OzI6Gt4haTVYh7g9O9Px6ejB/UClcC0UFLi
         nXIdccX2FJBoUYuWwy+bBRRI2RgKe5PhtseLri4rJrO6gYUQ0nIf5vQHBi+tdM/O86S7
         F9jevhTTe6UvqGscmE/hW2WqxJldqKAG/RvPLQFE6wXfMNUT3aUAE3sfwxlKkb1ORGPe
         Ievw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515535; x=1793120335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=CJA16jB7gWCpEr8AZzawOzxdJb4z/YFbC4DXOKSP80dkmRfx9QH9UfwmDDMEnx6xrY
         ytWQXNUpYR16zu6JxHLJT920ExBMXHtB22zguBiRyWPN5R/seJsI2ALDFelxA3RynBnk
         k6SaPDm2PQdU8eyNp2gGkRKCMQyWXvj5KMKc+T/kzKmDhI71TQ91IFPyIi48S1AlBFtP
         pUjYL29NSRsLrDoc6mMsS3vPR0p537pzITgbBc7WHOZrxaeMGGfzpqx+5A0fwKsXo4l6
         vGu4aZ/5UhxApp19j+gWVxlx/pBPcFlASON9y7t2DhHQt4/qBBperU87oPXQvmT53Rfr
         nKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515535; x=1793120335;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=JhLkLT/HpFFwatoYJ7ihhN2xWGY4jdnV6wgxkIEj9jj9Sz6pQo/O7zm414M5ROUOqY
         HDrWjX3UJQYmiB9Qu19hE5dWrYfNEfaAuWN8y0RKZWqrf3TjR4fqrzzMrYjs57jfOpd/
         wj6u6xKJ37IByosUYf0ipmWGkmXQrMOi8JmT5JmkVrcraRT2vgzAtZXKEJ8i52T6fKol
         qBPl6XFIt6itrVr4zQCAqWTfaevegkZZY6xOOE9aj80oXW1evWwv+3/Vj6YrDHk137o7
         +Ll89n7mQiFZPQCq7+bUUCumY1mBDh2PHjbFNAP9Jqm6N1w4KP00A7ldchFT5w5A0dFI
         ovSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsSyd1mRJ9q9hGASmBZtRgYcwcnWQwbt3zlUnMglyZbanLli75lDqOXizveCrsKiu2QbxpuC06mFTT@vger.kernel.org
X-Gm-Message-State: AFq9FYLoyKygaLBywB7zvpyGOEaiIo7EuMUEdp6KP85uqPrbOqWTUSoc
	Q/lmAfppNAgYIuvBAY16cVLUsptkS171rdanpQYoO3b5P1HBFZbo50evAw4zu5OWE2/pICdnKzl
	YDCSCrkhjs85n2sIge4yZai47Hqbv7UQ=
X-Gm-Gg: AYBFou1coM9ITPM8YivDYb4qD5ZORAWOmAX0q7ngQ3KD2dwrb6Ktch3UQgefBEzpIHV
	RW4dTdbSexwSC8cadykHy66Q0U3hQFeJkHYeUHTQ1ZNpSFh9wDAre3GWvGXrVTMiDOql84DIVuz
	Vn85TA9AlDdLiBABjZMzhQRg8Kl5VxBFqDq3xVOs+SxPVlXkrC9RQ8KeaqQGh+lLuIHAGMBRpv8
	7NcGGgcB6BKFu/uv/TUt0Zab9dqCKZQobh/KM+2P8SkQ4b/BSZxjcUtsn+88qQkwQzGkgPzM7O3
	MysSmThygU74UFZH/to3v598i+3qmLUALJSkM3geTYGNQRbijGzHTQ==
X-Received: by 2002:a05:690e:138a:b0:679:b8df:29c with SMTP id
 956f58d0204a3-679ca54432bmr6769731d50.2.1792515534972; Tue, 20 Oct 2026
 09:58:54 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 12:58:54 -0400
X-Gm-Features: AclHuK_J27k-o8Ui6g8e3q8L_DReW_3vhUszXOZ3Ua6MjDZ1MkwzX1wkuw839aA
Message-ID: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
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
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>  	unsigned long ret, tmp;
>
> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */

Why it's open-coded ?

> +	kasan_check_read(addr, 1);
> +	kcsan_check_read(addr, 1);
> +
>  	/* Load word from unaligned pointer addr */
>  	asm(
>  	"1:	ldr	%0, [%2]\n"
