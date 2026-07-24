Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6928030E
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855018; cv=none; b=Rnq9/obJIuqJCOGNQZkqgDc36DidqwXXKhZGm62OwpIk4/ybLexjYCRZu2/2Zb75zM9q7ILy7xMVZu7X4n2+IE1KkPEAMAlUeN1AbS/5OTTUE3oXJKpad7MzEeW+HLmqIrZ7I7DOn9s05hL4ISZkgc/Ce63k5XgcAeHtFRuHy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855018; c=relaxed/simple;
	bh=EYtGon2mOKRyQA+SWDxFLaacgRtfy4ZbfR/vRYaeE9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSj6srnsNPCalZnNSJUTJHgvI16JhG7f3W/4LTKiKgA4IvqJEeOv8HnTs3bydA6v+lH+DWJjPwqmpJ6KzfP3iuJ1b5kwGYTataZkvCMnKUpW8ShJFErF/FOgG9G57iLwp8EqitWNJj3MOCzaO1TvePRYNfncZ5+g+J7e38qiBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSwFR4KA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSwFR4KA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487088510aso1187611b3a.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784855017; x=1785459817; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EYtGon2mOKRyQA+SWDxFLaacgRtfy4ZbfR/vRYaeE9U=;
        b=GSwFR4KAaBa9gTSClEOTmu0NIxCLZpKhRIvCfN+n/o4jym0LpATzNEuSIe/uoMnooP
         WABaIfpkEVyvquUsfr2XYPgY3dAIUTgW1bp7n6l1dfbDL96GZTwy9hO9SZcqKbg/hf1a
         EJbnUgBvlk0bECdeBuXAW2TtvGmB2U6LR0Fag/c2h+mPb9AKWxaAZh5T/xugTOKqhytk
         yBdfGX9Qa2hKt6lukHafK8hZRWBwxFENUYKDnsabz9Ari+m+Y3BBA4tECtK2EcG4mcye
         AvEtpzo4IdP4KFfphJm3HVYIdOePjIPC3wfWuh5n0azuo2y81tBLjVRm9M0eVuG/wrof
         Gy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784855017; x=1785459817;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYtGon2mOKRyQA+SWDxFLaacgRtfy4ZbfR/vRYaeE9U=;
        b=nFU805vuVDtdwc/eZYypV6fLNfNy7/vQo6hnzNqIXFeArROxZ8IZfkwMN6Dmk2PGhW
         9lX/OSgqYbKZbc4ijTARqWcL8QTSWMNS8MO2G8OTyJWH6bDaqGZfZWgx5RHkeUYKb56q
         CzCyLWBpCinIdieLKisPJO1IVIDbR9k5btbMv2jFVQ8l38+sbhjTEp4LKm8HmX8PAPBv
         t2eAZIEJsAO7cUveN/zkRHgtgL0SE3u10mxG+5I6NZbjJ6NKVlWisww5sr0xXKZXv1Te
         HhBn0e0vv/V5zhxwYsm9Gf63GkntXxb/RtZO8uk9bxDpZ/EGfrpTbMHs7wcxy6xSGcKE
         LbGw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5PY9H149jkpYxc0yv+iZ8wj5/2rlUuOvXNpldFTwUPY2LXrv1jq61x4yZx3GDiOpbolrzs6N3Um+X@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhWLoZQO7tiDornGlZnCvaTt4VjSL05vaUYC4vvE/NUFlJk20
	8Jc7kU1V9UzML2c3aMS8ETsrYTIlTdMlnVQIAi4G3/hgAzDs0hQ2jQcy
X-Gm-Gg: AR+sD12i+dEUteGQuiHiYaYstK8jIDL7N03N9LS2cH/1WuHHAGyknQ/ZhgjbChG1+R/
	1RawK/jTTB3hzxEuvgcqp03LEmnM9ZtEwwAtBQ0R8YC31OXeF14N5vk8D/OY8T4gAxZan+z2PCL
	JJgS29ztBmfLaOU8O1RlxRRcC5nY6a+Ph7l4g0ax3B/ay0HYu7gJol4cc8AbR4neGZe3lM5yQgj
	RPzG6wZKeB43t/AZ1jk4OiE0VLZifcupRTC4efhbQPJv/XO3o/5lESFzHTSeDfthOvyIcJCRO25
	Tg2/1v5oFXMnwEofKKYIw8QXwoKS3C5SFZKdvUgPtft5734yPWBbZzzQZ4JbOVnNKININNl89Tl
	FJdgLCWKeYm749JyEMdCXP3mwz1JJQm95XdynQ9wKbxohPDgnCuHzk9ttWv8ClIgMlQRFcJEllb
	azZpXRUV9Ue1bP3o9bJh9mVm+I79FROVEyfYFUGDsOCjU/mueS7uhmKcXGCZU=
X-Received: by 2002:a05:6a21:2d46:b0:3c3:83e8:c211 with SMTP id adf61e73a8af0-3c44b25397fmr6112121637.63.1784855016691;
        Thu, 23 Jul 2026 18:03:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c221:d012:6e37:77f9? ([2620:10d:c090:500::2:8dac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9f2f0sm25307955eec.13.2026.07.23.18.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 18:03:36 -0700 (PDT)
Message-ID: <4fc7fef5d38839b5f01e80b05de908d95af8f3c8.camel@gmail.com>
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
Date: Thu, 23 Jul 2026 18:03:34 -0700
In-Reply-To: <71f6059ecc89d0b16f8542d73ad8b183a2a4db92.camel@gmail.com>
References: 
	<CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com>
	 <71f6059ecc89d0b16f8542d73ad8b183a2a4db92.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 02:05 -0700, Eduard Zingerman wrote:
> On Thu, 2026-07-23 at 17:16 +0900, Min-gyu Kim wrote:
>=20
> ...
>=20
> > Root cause
> >=20
> > The verifier records an ALU32 definition in subreg_def. A later 64-bit =
read
> > causes mark_insn_zext() to mark that instruction for explicit zero exte=
nsion.
> > Before 107e16979905, a cache hit in is_state_visited() propagated the 6=
4-bit
> > read to the alternate path's ALU32 definition.
>=20
> Hi Min-gyu,
>=20
> Thank you for the report.
>=20
> > Commit 107e16979905 removed that propagation when register-chain livene=
ss was
> > replaced with static liveness. The static live-register mask does not t=
rack
> > read width or path-specific subreg_def information. In current states.c=
,
> > regs_exact() compares only fields before id, while subreg_def follows i=
d in
> > struct bpf_reg_state.
>=20
> Hm, the stack is tracked with 32-bit granularity and it should be easy
> to adjust compute_live_registers() to track the width. I'll give it a try=
.

I figured out the repro and am working on the fix.
The plan is to extend compute_live_registers() to statically infer
which upper 32-bit subregisters are alive and use this information
to fixup zero extensions, and drop the reg->subreg_def altogether.

...
