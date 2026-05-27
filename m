Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47C3EE1F7
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876535; cv=pass; b=ipMPSv1VLt60UdjfEqZP/ztaATWUrgSheRwLVs5PLVGWSZCcj973WEDVa859HSr1EXR08QGfDBLL4SxCjQNVyjeIvjXJb8JGvUVVUU3aurMg5kgEnN2CEkaQqYNk+aDUpnBHHjQaG9J/4ggZlTLUgHQnSjZ/eduKqqw9yRZcelA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876535; c=relaxed/simple;
	bh=hT/+UCuuo+DvFfXXo+F6kaaBMNv1f6p/5PzMcFn/hSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEo7Y6gHd09OPIZSccDAzgDdMvrIwNGLTUXrZZvuvz6VuucHJP7A0etKCRk3xixqysYZ+Pr+jBfbwIwnqGvZRLHi9PpUB3PtinNpIfJealnylGJ95jHkFZ86h/2YCNV/eugnQa0gqw9VeYquh4ou4HiznSMDfoH2gBxuQmKlYnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5kc9Zxz; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5kc9Zxz"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-303da604df1so1071767eec.3
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 03:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779876532; cv=none;
        d=google.com; s=arc-20240605;
        b=EAThwNjRuItIp+qS5p+jTVOKOw0KOVT86r3EP5z4TCZMykVxnALD+ax4e4XmFVHrtb
         vsvYCFA5IvTudJsWszwY32zk7dkGO+w0U+AZRF8mgTrhlonD7r7hQ1mZ0Wrv97raG3HX
         mrhhV9VPi3qxQ1UmiqttmGMuZbS1uZ62c3J4JwC7DZNBTsNZzuWnBsDXzMjhOxVrxPrp
         P/XcV4pGZo8pNRK3j1scUw78l8ZLDnI8LfZ11ifvYDIsOi68VFXzpRicAix6ZuYva9jm
         iosi2+G9+YvuLZ6aarMkC0ENrNWMJnoca5UDNtqZe74TcOYJ35tOHQVL25rS+Gac9/rZ
         3ZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70BoTdN1xe6Q1QjPEAxC8jYGA2tUpZrPUCZd2Vm5ygg=;
        fh=MuiCX0A1itiZuq91Z+ZRYE9/TlTSA2bB4Nk3RjYz3TI=;
        b=J2pTipN2XlGNtkreYhojkt1DesPtKCSLEyJ7ygSzozl6tpbnKiaOGGcg4wseD8xm3R
         sYnzmeGzOgt/X0zHU2Oe1Z2cIU1gimsAxoEOn6BtrZ6UwqIjINaRPVgTnNYKBXmAaqce
         YrfY8vPm1S5ry3bHgnj0bBlaMCb1pRea8cQxPaUU7P7KLCndz2OLpvmU5pCITTubeBaJ
         W9UcYVPNg1gdKBRgu87XMYTw7xxpv1wtIgLX00RDf//n0JPQWddnjgFJi7Vt7AdjEwHw
         Vuz+QuuRVwefFwPGLxSIEpzHVuwLZ0uwP0gq4sCbq28EEApGWzJD10W06gap9UanEaUt
         7mGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779876532; x=1780481332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70BoTdN1xe6Q1QjPEAxC8jYGA2tUpZrPUCZd2Vm5ygg=;
        b=O5kc9ZxznxtsMD0ebeCu3v6boLrwb3ebaQir6e71XXoY81Mjh7pClZ7b8uEfHnnvmK
         MRlY2hmevo+xe115SqCDCoCcZsqyqXRuRWcrN4vu28AEdsahuZBcFUHf5HPQXgLsE/gW
         mu6dZduNOedAEFMggkO33speP0Cl8ewHguEnecXImg8E0m77iZFjiyNDyYvqC7J4Wlvt
         x9OKYXkFUfzUVO65sHPyFjXToG+WdWiWW9ffjPTDHxMY4Fkru48Gfp684o5Z1LnY6Yz4
         37zUZzwDgjtxtL0jOL9Gf8u4pyAcwXlpiwgPsSnB7f7QLXv7m89GrGE5UvJuzFItOpDr
         oiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779876532; x=1780481332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70BoTdN1xe6Q1QjPEAxC8jYGA2tUpZrPUCZd2Vm5ygg=;
        b=jJ3lcayasqBC+F2D6KyneOrKn9T7V//DSS6iuy8wPVEV7ZAg/f63ZVf6CxHySjXs75
         clAgZxERWgyJnK5PbnsFZPZNXuGl03aQmsWFRvCV6z2pNTbXyovUFtCtLfBX4sl1QApG
         uuCTWdk37bc+G3hsguFI2N+VuguBU6/6rSd38ELXSX6WrBrMiKt4VfDXx/0Ux29E0hwU
         bi3MCH+LdDcIM720xWxfmNGHCHo5U9c5iIZ9G9Pzw3y9NxU83w99kVqpSOH8NvNZRFzr
         8snxa/bZLxidibo9NGJnBWyUHs3XMk9KDxKFVDgP6x7lVKgnlUT3x60Lb5S8Lm4yqyYU
         qTQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YwVOHIsbCvq3/QZ+VrSrA3Cd2WI3Pf1Vvtw9b9udbgKRhcYoFToGLa3TYjKisAXygbr/n1ByeOHLo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw592gcjOsEzkpVtxs2ZXS/5QsjL/c0f9wcXKep9B3up4NmpZv9
	UjICJG8AZfX1Ga2Aly+FfPE3czUsmzuNS4NDC5CXHx08qMcvaFpapgqQDOAXGNdHYWgRO6xajX6
	shFdCIMTkfvCrGUxKLaJexVG/9luAYFo=
X-Gm-Gg: Acq92OGbwEuZvnuvhMzhc/MBWFaRIkeRzrvn2D0snp8tVIgP1sS/zRClkruL2hkut8i
	hqu61Bs487lkSc5ie+XmDOmIoELo9w61/6+uPKfs2xnhEsmomzAVDhYb4TRBUvw9KRTq9plhl6v
	y+braYDH8kWSQeMpj1nJ80VRQvvzX3pJS1UYbxigm18iIqruAAPsUlbT2Y8YoXNq8i+MZk4iChc
	jDtwcqx9hOMvXvaVUxjlm/5BPaWWmjqhWc2uwRoYvZqy5FgRoXqzkAk5kdO1FehRjoaq01VvXVS
	gUIUN89qMKvMfBn84ZsxWrJf7xU6JD57/RsbT/Z5WOohIHjgbuUA68dfxxOhArsLPDze8hnhozu
	JWdWghyWdmdcvgPP+WBvYwkIqWGb2owcx0A==
X-Received: by 2002:a05:7300:681e:b0:304:8860:74dd with SMTP id
 5a478bee46e88-3048860771fmr1656163eec.8.1779876531528; Wed, 27 May 2026
 03:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
In-Reply-To: <20260526161312.19291A8f-hca@linux.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 12:08:38 +0200
X-Gm-Features: AVHnY4Lhc9XY1ZU87Y4GDJJb8ZsmhkoBAt44lJKGQPBXxXSclSwjwRb2dwDmwVA
Message-ID: <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
To: Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:13=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> An Ack from you would be appreciated, even though you made it already
> clear that this series looks ok.

I did a quick `LLVM=3D1` test and booted it in QEMU. That worked and I
could see the KUnit tests, though we get the:

  warning: unstable feature specified for `-Ctarget-feature`: `backchain`

But I assume you are OK with that for now (and if you are, then
avoiding a custom target is worth it, I would say).

I also found a couple bits: in a KASAN build, I got [1] -- Cc'ing
Boqun in case he is interested:

  [    5.323670] ok 5 rust_allocator
  [    5.324134]     KTAP version 1
  [    5.324194]     # Subtest: rust_atomics
  [    5.324251]     # speed: normal
  [    5.324367]     1..8
  [    5.332184]     # atomic_basic_tests.speed: normal
  [    5.332356]     ok 1 atomic_basic_tests
  [    5.340797]     # atomic_acquire_release_tests.speed: normal
  [    5.341054]     ok 2 atomic_acquire_release_tests
  [    5.344127]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [    5.344584] BUG: KASAN: stack-out-of-bounds in
rust_helper_atomic_i8_xchg+0xb2/0xc0
  [    5.345283] Read of size 4 at addr 001bff7ffdbefcf0 by task
kunit_try_catch/142
  [    5.345493]
  [    5.346499] CPU: 2 UID: 0 PID: 142 Comm: kunit_try_catch Tainted:
G                 N  7.1.0-rc4-00009-g60c6b4b89923 #10 PREEMPTLAZY
  [    5.347065] Tainted: [N]=3DTEST
  [    5.347124] Hardware name: QEMU 8561 QEMU (KVM/Linux)
  [    5.347323] Call Trace:
  [    5.347408]  [<001bfffffcb9c6b0>] dump_stack_lvl+0x80/0xa0
  [    5.347663]  [<001bfffffcb90846>] print_report+0xd6/0x310
  [    5.347784]  [<001bfffffd596e08>] kasan_report+0xe8/0x110
  [    5.347895]  [<001bfffffde5a042>] rust_helper_atomic_i8_xchg+0xb2/0xc0
  [    5.347983]  [<001bfffffde917fe>]
_RNvNtNtNtNtCseBLeUu9QniM_6kernel4sync6atomic9predefine5tests36kunit_rust_w=
rapper_atomic_xchg_tests+0x5be/0x4f90
  [    5.348088]  [<001bfffffdf59e50>] kunit_try_run_case+0x150/0x3d0
  [    5.348194]  [<001bfffffdf60500>]
kunit_generic_run_threadfn_adapter+0x90/0x130
  [    5.348257]  [<001bfffffccf9fde>] kthread+0x33e/0x410
  [    5.348309]  [<001bfffffcba122e>] __ret_from_fork+0x9e/0x3c0
  [    5.348357]  [<001bfffffec96faa>] ret_from_fork+0xa/0x30
  [    5.348531]
  [    5.349184]
  [    5.349261] The buggy address belongs to a vmalloc virtual mapping
  [    5.349620] The buggy address belongs to the physical page:
  [    5.350145] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x791f
  [    5.350563] flags: 0x1ffff00000000000(node=3D0|zone=3D0|lastcpupid=3D0=
x1ffff)
  [    5.351563] raw: 1ffff00000000000 0000000000000000
001b913b001e47c8 0000000000000000
  [    5.351694] raw: 0000000000000000 0000000000000000
ffffffff00000001 0000000000000000
  [    5.351808] page dumped because: kasan: bad access detected
  [    5.351912]
  [    5.351989] Memory state around the buggy address:
  [    5.352240]  001bff7ffdbefb80: f2 f2 f8 f8 f8 f8 f8 f8 f2 f2 f2
f2 f8 f2 f2 f2
  [    5.352338]  001bff7ffdbefc00: f8 f2 f2 f2 f8 f8 f2 f2 f8 f2 f2
f2 f8 f8 f8 f8
  [    5.352428] >001bff7ffdbefc80: f8 f8 f2 f2 f2 f2 f8 f2 f2 f2 f8
f2 f2 f2 01 f3
  [    5.352553]                                                           =
   ^
  [    5.352762]  001bff7ffdbefd00: 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00
  [    5.352862]  001bff7ffdbefd80: 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00
  [    5.352976]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I also tried a GCC one without KASAN/KUnit, and got:

  error[E0425]: cannot find function `memchr` in crate `bindings`
       --> rust/kernel/str.rs:857:38
        |
    857 |         let ptr =3D unsafe {
bindings::memchr(buf.as_ptr().cast(), 0, f.bytes_written() - 1) };
        |                                      ^^^^^^
        |
       ::: rust/bindings/bindings_generated.rs:20572:5
        |
  20572 |     pub fn memcmp(s1: *const ffi::c_void, s2: *const
ffi::c_void, n: usize) -> ffi::c_int;
        |     -------------------------------------------------------------=
-------------------------
similarly named function `memcmp` defined here
        |

So we likely want a Rust helper here in `rust/helpers/`.

Up to you which configs you want to support initially and how clean
you want everything to be, of course, so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I hope this helps!

Cheers,
Miguel
