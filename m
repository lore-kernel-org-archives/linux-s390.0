Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115A320A04
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375102; cv=none; b=FDa+NpOVFc1cBoGa/50/g2uD2zSYIY+1JB7TEEJRQ7vzTf57mprHyq6v+8RuIc+1ixGQCuPexSlt9DhMN7OTCQw1+8AFfkev9WMuNX0pHXrx0a2vDv/EVw9+IplHhHlE0LyyOquEo+DzIJOpNC+k6BWgjXK6L/Ru32TfvBWljDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375102; c=relaxed/simple;
	bh=IvgpY5vdVqEpCEAsZKzoB7BbMpzUVF8+3uNWD1OUHNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WqDZVpzw2/d5QHntv9jYGIHzRA0CbFxJ19mLns2tF3/B8mH7u3XzMhpJWILHORLytVOy6XQELYhZUIMoq9uOH/0ehkxUExkOdO+/le+/yZ7unHqmoTlAokzde4Q/0/exnHuFRA3JIbzsFJ5e/kyYoYUdltvER7StK27jOvChRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cndT/ivD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cndT/ivD"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-17bc533fda3so1736903c88.1
        for <linux-s390@vger.kernel.org>; Sun, 18 Oct 2026 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375101; x=1792979901; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=cndT/ivDicq5kDK3cPUhETpzYzGDIDiSeFFuKde5Q97EeoxUYr2TTWIRJ1cRzieW7o
         tO5tatlKgakdZrxY4q7zVjPH5LYdTyH2tefyLiQWQXRC3xW9ZuauFq+goFKdQa7HwxoQ
         J+lqPjAEbtSfaS6ofD9Cnok7iY2/yhvmeYCDteshy0zrv7347A0yMmO/5gzWT4AHFB2a
         uNZxX3EOI3aSjnTNSqK9bHxMbw4PsnLG7qfntKUxZJO2I6fDCLr/vCY+jlLAgb+cgihh
         4baB9B9uithiQUZqHU366ycEoW90URbZfhoGoleIZYKNmMV9a+KssQeTHISo9VVZAq/o
         f1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375101; x=1792979901;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=Y/tbkthddCdhErDO+3xKcvBIhG3HHBwrR/UoaD/RfpP6PG4WgYnpiaUuoiNnMq0xTg
         coqignolcXWU4Bh8KtxxIJ/egP5h1qGQHL6U4YKlib7Tdw84LsponRnXsMVBXork0plp
         KJ6ItKMyYmojh1CuFEqEQSDeK8/Tk0eQ2DpHAQp/zHRwvo8ga3kGsZQhH5JW/JZVWaKX
         P0wvV5mIqaT0JLqXH7pfN/8/O8f3xsTNnJ3fVp/V1cXOxGTo+r3603rk7CiMtW14Wfta
         +xR5gn9DgqRyBmrKZWfqqJpmwAMrq0ePKLZSDgve4v7JrD70hh8qPwCRiWKkOushh7PM
         fjeQ==
X-Forwarded-Encrypted: i=1; AKwUvByKRSrQgR8SZVCrjN9A3ylYKGpy+A1JoukZbt03PSf1xOSn5t0jxUqHgRE5EANMDe4fmj9UiQ4AWJT2@vger.kernel.org
X-Gm-Message-State: AFq9FYJuoJIuGZGyhfWsvAIY9eY+RotPYdsak16uBHIrjmK79rCI9mJp
	m/Y8lY83ukW49FYVjr/FXB69WHp4P2pcLdqzaOKwWHAbkcE/O+mHqAIp
X-Gm-Gg: AYBFou1NbNuj6nplFFrMX/q0MP69gB11jRHdbNdDfifqLNXhrHhjD1RKVCeOzmq3JDN
	Yja9rFEJ8IA1Dki+A46VjcGlFKuvce9TuMbhT3uyK7BRFoDkne81NsgeLT54TMgAs5/8bsZsSL5
	1xadW61HwqGiUsvGr15ZbBdp4qmFz44fTiYIC5QmlE89yllqYsH6BqsIGoQsztpET6dkN1/uPCC
	3a2KLaqw1AkAJJvDAiL/yHhtM1/1PQ0XGV30lvgrPfF3MNC12Q3UQMtcYV2Dgpiba4+3wAwy/dR
	8nKp4IHcYX3vWSCtVcIP1xe9me8EpXxBfcfJldA329O41dlIqlPzjJ9tPacqJP7v+nB8DVZXOEl
	ZxxicCMhdNSNRJ8dt5Qybsey4d0hiYDaR8Tu6c+JHa9Vt0BuQxvi8/ya9nC7Wt44GrFqrMmopS/
	f0H9RAHNSI1CwpLfSalG4XF2ea4Nw+3lfPkY6rxsK0AWmMnjGiTV7FGl6/YID8dkS7iwU=
X-Received: by 2002:a05:7022:150e:b0:141:b2c3:d84e with SMTP id a92af1059eb24-185120a8bb4mr10990864c88.11.1792375100720;
        Sun, 18 Oct 2026 18:58:20 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:19 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] word-at-a-time: let KASAN see load_unaligned_zeropad()
Date: Mon, 19 Oct 2026 09:58:08 +0800
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADB51WoC/x3NwQqDMAyA4VeRnBdoiwT0VcYOmY0aZK2kTsfEd
 1/Z8bv8/wlFTKVA35xgsmvRnCr8rYFh5jQJaqyG4AJ55zt8vic8skXkDRk3fQl+xfLKERcunJD
 H0JJriUQIamY1GfXzX9wf1/UDDOF2FXIAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0

load_unaligned_zeropad() is inline assembly, so KASAN and KCSAN never
see the word loads that sized_strscpy(), the dcache name compare, path
name hashing and x86 csum_partial() do through it. While reviewing a
strscpy() KASAN fix, Peter Collingbourne suggested checking the first
byte inside load_unaligned_zeropad() itself, as read_word_at_a_time()
does [1].

Patch 1 adds that check on the six architectures that implement
load_unaligned_zeropad(). Patch 2 adds a KASAN KUnit case for it.

This is independent of the strscpy() fix, which makes sized_strscpy()
copy byte by byte under software KASAN so that every byte it reads is
checked. Either can be applied without the other.

[1] https://lore.kernel.org/r/CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      word-at-a-time: check the first byte in load_unaligned_zeropad()
      kasan/test: cover load_unaligned_zeropad()

 arch/arm/include/asm/word-at-a-time.h              |  7 +++++++
 arch/arm64/include/asm/word-at-a-time.h            |  7 +++++++
 arch/powerpc/include/asm/word-at-a-time.h          |  6 ++++++
 arch/riscv/include/asm/word-at-a-time.h            |  6 ++++++
 arch/s390/include/asm/word-at-a-time.h             |  6 ++++++
 arch/x86/include/asm/word-at-a-time.h              |  6 ++++++
 mm/kasan/kasan_test_c.c                            | 24 ++++++++++++++++++++++
 .../powerpc/primitives/linux/kasan-checks.h        |  3 +++
 .../powerpc/primitives/linux/kcsan-checks.h        |  3 +++
 9 files changed, 68 insertions(+)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-bug-word-at-a-time-zeropad-kasan-af2460466ee6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

