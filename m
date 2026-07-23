Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BD3EDE77
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797521; cv=none; b=T/eBIiNAyYMoo9Hs5XFkAA49H+/Yphz5nWdPpe4vyX+EOU3UksgNv5eXYMg6zHpwb8y52swYJIXfIrjOwilt6snsoDBPY2KWauHnzxNhV0UnA3LgSZJlJ6CID7ppu/RnRyK+6cpkl3VnUYuSk57J1wXnQS+IeI5fMrfaYFyz4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797521; c=relaxed/simple;
	bh=LuCbOJEq9s4gUkoOzNekTbMB6Teey7IN57xuRmPy9vY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/qH7R5y0W+2ZhNbDgo6pcR9NhbPZ8k2lUsOF7pw4u8f0dZmVFdRxPFDBJdluB3/RpcdaSo48j5KzsN60jXVtgmGqXRo3F29xHOJfgK/svRpqrEfLm+JgCEla/H55P3BfdGlgXSIxyauq6AnwXHobVcX34ybbCjGcqjUG8cwPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmAuAM6W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmAuAM6W"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacf197759so6334985ad.2
        for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784797520; x=1785402320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LuCbOJEq9s4gUkoOzNekTbMB6Teey7IN57xuRmPy9vY=;
        b=fmAuAM6WWBK5QASBQlc8a0v8P+QHB9x96gr4giWSCMWnqKmt2vCTq1Nkv6oUcQ3HVd
         BTfpLyJaaFScP4VEFWvq48hkAcwUygMWTSr+OSToAy6DCN6zZNOq+J13Jwesc4eN5WwK
         AtmAL2BG6Y1jR+r8sYeZf6Ar/gHT7Yy7xvUJEoGDd8n+wXThvkhlQ78IgdVZ5GpVhoiF
         MFs/aeQwzKeHtUCfPxCV3zSbINtBBk8UryfmbdqJdkW0pXjtAyH7tHrn9w/W6fBPlox4
         rY5axhEs7bV7SxRGXhh3QbIgQ9nLG/l4uCcTjHIgiyzs8Wbg0q2UgMYW7svR6YskKxDn
         +RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784797520; x=1785402320;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuCbOJEq9s4gUkoOzNekTbMB6Teey7IN57xuRmPy9vY=;
        b=ELV9z+hkhi0rKyvlICdzZs1ZuMDqzZDFqOwALWJHTkXvyaxUSX4YarXip372dMIabF
         gefydKzHCUPdpTDOwGFVFqhTm0DHJ//OtKceVJ0kg03SS6nIlC7WTmhwX6G/yIUl8MBm
         0OKi3+zk0mOXd/zZ/inMdYjdBmOdqfSHgyx+T4OjnQzRb2sMSMZ+3A5A3n31Ex5ojMgC
         T+CDeDuJtdGF0WQ6aIoM7DFG1muprRWmUTwVTwiikCScU5R9r/11MR+SSmXUKXH8jFX+
         UNUaX1B1WAO2d9QvPB5UPaLdaHAeigIa5FOvydAmgxTg7qvXFMEFS8K7Fh2aW3FgpSOk
         fNGg==
X-Forwarded-Encrypted: i=1; AHgh+RpFVj+ToDngT2GaJCoBM2n2iL/UQAgFrudq+kXEpJHkpjwS7EHE1NrVEtLy/eomdYzby/5ubCf51sxl@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2y9C4uInhcWXNRumtIpbS9WNZocCK59ga3OXRL2pHpj4zsME
	QuPch/xx8/na0BxmakLe+SjKg88kkfT/O0z1aVRWMclc++M3crSgFXOO
X-Gm-Gg: AR+sD13ka5yticVajAkqa5NVu1pAXvJdweTVtiCURivY7VSXWChrh5s4HAiLWfunjID
	GN/Ru8lLiJah7NcBsOqMMJZJ+FHGwfs3I/LW6BQ+9ukI9oW+QNaTBrHcEDK2ag24+Ov1utVl7R1
	ySUAQwiBzAuRB47/rMcM0mQLNqNw98KSHa/ybr3VqR9hiB4+RnV+D0CeRSYCj3mS9G1DkdJVhB+
	vMArSGeDHNIrMgDxtudCj1Suzk3USEmbPcC/0DoTOyJA7fqFtBFw2DlBGuetR2piKEDbh+p5CFs
	fydN0tzpITQrVfNy6caXftGah1Ty1yhIaMwlXSlnnacJDcFYDGl/x46u9A3GObCvWkaBLFJYSBU
	U3ARZGmNcww26rXhfeoBwtMWJIEbYxDsp0qyt8jMzvrgTBOy7ts8Zifk/awFz8tvgxckOgQ//Ne
	LSisGPzZGQik2/VjhlnWj7W7dLSFpZi0ys4S8UGTHM
X-Received: by 2002:a17:902:d54f:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2cfa74886a6mr25002765ad.23.1784797519561;
        Thu, 23 Jul 2026 02:05:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7fedsm29671005ad.24.2026.07.23.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:05:19 -0700 (PDT)
Message-ID: <71f6059ecc89d0b16f8542d73ad8b183a2a4db92.camel@gmail.com>
Subject: Re: [RESEND][REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch
 allows unprivileged kernel memory access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Min-gyu Kim <gimm78064@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Heiko Carstens	 <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 security@kernel.org
Date: Thu, 23 Jul 2026 02:05:16 -0700
In-Reply-To: <CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com>
References: 
	<CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 17:16 +0900, Min-gyu Kim wrote:

...

> Root cause
>=20
> The verifier records an ALU32 definition in subreg_def. A later 64-bit re=
ad
> causes mark_insn_zext() to mark that instruction for explicit zero extens=
ion.
> Before 107e16979905, a cache hit in is_state_visited() propagated the 64-=
bit
> read to the alternate path's ALU32 definition.

Hi Min-gyu,

Thank you for the report.

> Commit 107e16979905 removed that propagation when register-chain liveness=
 was
> replaced with static liveness. The static live-register mask does not tra=
ck
> read width or path-specific subreg_def information. In current states.c,
> regs_exact() compares only fields before id, while subreg_def follows id =
in
> struct bpf_reg_state.

Hm, the stack is tracked with 32-bit granularity and it should be easy
to adjust compute_live_registers() to track the width. I'll give it a try.

> The SCALAR_VALUE case in regsafe() also does not compare
> subreg_def. States with equal tracked scalar values but different ALU32
> definitions can therefore compare as equal, leaving the pruned path's ALU=
32
> instruction without a zero-extension mark.

This is orthogonal to liveness mechanism, this is also much older.
I think this is the true root cause and it should be possible to
construct a test case triggering false-pruning on <6.18.

Thanks,
Eduard

...
