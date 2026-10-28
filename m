Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793211145;
	b=tJI6S2q9ODP3s9i04IPSCN4J9Oe0EkxhtZ6oUCkmu8YDZpjX7G7ipo+9SM/oLws7ZrH5
	 ieMyYkhvmWsLIfeJgmnkSzCFa/BMyHJLNiLrewQtG5TelaetYjn6WlKwNzPdkqws6wyvg
	 hRbyrNGCulxvQ/RC6SfRtstlgUm30bt/Kw7KJRle8Ljo/DPxXkIDnLtTmJsBmcz8Dje6K
	 aJscwxgHrGE5Q5tFWtUPuraio/fAlGMFy7eQG5PuHsnrhNhKCGrsKBLNacPiDyERtaCzm
	 UwvSFDM/yN+z8je0wcYEk50DxYggwuQYybrKAShOX1X7aHhFB1dYdouDFiFacneoGgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
	b=0kVRhLKtDNvFjQFE6grFs0LR6mfznWr82+OmjsfB3AueE/PNpK6A/DeSHWwCmFa9NkBO
	 rpLjid5s++YsFyFmdl52YDx7Jb0239NcsLp4/9cBfbeiQLUy64OR6CwrEHpLru+l0axUA
	 VAvGoitLk+0ubgPOaMGLzdOP6LiVUpbolaRNak2HMAD9exg0Afjrbr/oEt0+tAiZ4XKk/
	 lZvyuLF0kzdhJeXcQMjcM3FZzi9pqb9Gvzi7qNjPgqwVY/B9b3shZSVUmuJ8w23GYCWdA
	 KbRdyK/JuBMHdOd4kBmYpusP4YeVqc3jc2M2M3t8GGFrnL//dR1DMOSWlz7VrJOtOCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSf6WKa;
	arc=fail smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52878606A97C
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 18:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52878606A97C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSf6WKa
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6790c2eb033so219564d50.3
        for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 11:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793211144; cv=none;
        d=google.com; s=arc-20260327;
        b=miPtgJSJNbU2xJgMyshFZ2hvoifGIUKEJ22ZbR5ZW9BC4uT9Zb8jhaXKN3b3XE78nt
         eHfxucyRDgjGTZ3D7DKwBB7qn3wrBOYRKR0o9yTGwwkm7K/vzhpRmopr+GUNTBTh7y8O
         MS8b0HcqTPxnp9r3IIgql4UT2O9NWSwUSGYYrP0cHTX9/XeNdlAI0NfeD5FqFMxWdoxy
         AzoMvCQ0LrB4hrpc9AWu20CIHRzF/4DNEwGu/qc1ZIUqmjMRCDYeJ83v6bbN9vK8uAwf
         PX52M0i9gusA4Kfvc6ouOisAnvQekhdqROkFZr0EAx9ulD3u1NDYLe9u+jGWtbrWNSCs
         55Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        fh=/zrBGykAIIFpihfUlQiTYUxhLFeWYIxAEsow0oEy/QY=;
        b=JCFZIxCov/g0HFEmmrfsJ1kEaHylXxN6UOFmo2FMNM1uVbmsOcbaYEdwYqOQlxUZhQ
         pPlzGdjLtpAMcoD/sAUdrLpuL0iLv8i3mwkMAKJCtCzaj/l/cIHs0nD8sNuiaBJan+1A
         DtZeFb38lCEz+G2TOSpkP+uzXeDB6MZOu/lprctHjP4Z3zTVVry7YaohO2RE5SVEf3Lm
         wFKqHQ6MXk/afOHu5H22TVuZeUtrnMsSJ84k6zkLSfakwfVTLiZ6nMrNcszIAL9pfOnM
         2dVusavXr5OaNrGrq6uWHzIR/98Z19OSkVJLyAvl6oZiAMIeYvWX1qUIi7MNRAEzUTsu
         nYGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211144; x=1793815944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=ALSf6WKanFx5JvmwlsLgV8fFdqXM6xTDgPgW9yrrFjM6/vBGqYK5MP8vdjEFd6Sd98
         NBVXpxDxP5phBJEQbTM6ZF819Et3/utRfYgAYvVe1/7CPYGeKwjbZCJN2+eWDd+DPgOJ
         /JYgpa/2NylgB+nTergZPvZ1EvWvqMF606I1SYcSYUg7ByrEMXm1mMsFZ652rdG5agyO
         B7s01u4kNZ/56+zsY+mpL/w7IdzRejnSTJl0usSaFROTaNzSYew6f1rFzZzNTYa/jteU
         Duz/k0QuEMkQ11mraTPIuGOS/qrwrzXXpBwPJitSAC/lEqMeD/uihh/wLI3vDBA6yzMf
         CDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211144; x=1793815944;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/wxxGxoBJyhbGLsecA52KNGsy8WsqvTWX50Wr5bw0M=;
        b=wK6+cJW7w8IPEnmo0/s2aB/Tqo4j2PEyJUjbyty9gRbttUJgkCJDKlVTM+9lz3gAd0
         xe+1NNUn0v6L7ST7xc4/2rPX0JwGMIVbn+bo9zRfOOFBYRxmkeRShcEIFYpBZQR40wor
         6VxrgtqrJMnPU9IZKHzKy68fEtkpU3hwXcb7stH0HayTZw+Ktg78VqH9Bz1lEE7ICdxS
         c7mkgW5QSPd0Kgyjee6SlUSQI+lQlT/vXTHvAtc9iTHenmZZm3yvIJyrjaJLakbbrM/D
         A3PmVysNm5Rq6V2HZg8yQUto+6fJIo8Yl/ukAuWAtSoJtJT/se0C2G1hXeF4Qs2u4HGJ
         h54g==
X-Forwarded-Encrypted: i=1; AKwUvBxGDCIEY2CWRsYZPyuvU7+OMVxv+eO9MdBb9a0c3nMhevI6z+uBWwKB1Un3AlYgn/vh/Sz0FpW+EaZx@vger.kernel.org
X-Gm-Message-State: AFq9FYIViB7ihOXlzLpxxF6XD6E7zSZYGjBeDLMVa6yY/Yb0cmHWZB7o
	UhbnpPKm1sLrAo08GOpMUcpeOEP27KmcC3rb0RGzV4+B3pQARyl3qhTTACSpN2srYPmiLsY0EeI
	z+nCovfBHGRNchJbomtZyou8HVaJoBos=
X-Gm-Gg: AYBFou1Rjos/XUupYOrfvycby6+8Iwl6E6qfTCedpQ+pQ7vMPaO790YGBvOBCaJSDzL
	UtXz/LVc92DrBjfdeoeZsP7wEfb6XzbOiQOs/gCf7HzmJdEvpT5UnHiYytErH4zlK0hsKiOXn7x
	KOksDPkQ51vysureerXH4PFiWV5bZvMUOk2ZgynPND5Ned3Jixxs5heeNXJ5Yw2/+mVecTLeLcx
	40tROx7URUxt2QcXHVZIv7dsN8l/PFWkSq060+b2rtl3hmi8ZjWQjcWem3BtHyoANOXeG5WpGD7
	rR9AXNiI+UydnvV/PU3EXhqLshPyJ4eBHrE0y4Rgi/kyE5aPn1jNZ0ZyFI9zxVeNm/ON7ixW4Ko
	5eaM/rBW2gOcttxCd0V0GcA1f/pbqARspQXU=
X-Received: by 2002:a05:690e:a4e:b0:675:6f06:5642 with SMTP id
 956f58d0204a3-67a7b9945d2mr4650525d50.1.1793211144098; Wed, 28 Oct 2026
 11:12:24 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:12:22 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
 <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 11:12:22 -0700
X-Gm-Features: AclHuK-o5YV67AfwlA9WNsjqOxV_ScugEYWYzUg986KltKOOqPQjM_oQFfVaIog
Message-ID: <CAPAsAGyEUL1fj2-1=NGBDDO-z47cOHmcFDFexY9T_1_1LCMQJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
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

> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=n              1        0
>   CONFIG_FORTIFY_SOURCE=y              1        0
>
> Check the first byte with instrument_read() at the start of
> load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
> does. All callers only load a word whose first byte belongs to the
> string or buffer they read, so the check does not flag their intended
> reads past the end. Add a no-op instrument_read() for the powerpc
> selftest that builds the header in user space.
>
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
