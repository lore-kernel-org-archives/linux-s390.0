Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD33F166A
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878330; cv=none; b=t8Ve6oxQlECi/iV2KjSv0EoAmbRa8FDj/gcR30V3veAZMVJ+FHjulgsYSArijW3QP41hEGfui2h5UkSoHYRhBctKgamheqILUHf4whD1CH7um/LwWvbPxMLfBGer+mmtsL1ReI0uyX2CpBES0K7ouXXJK5h53KGOgKRlAu9e+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878330; c=relaxed/simple;
	bh=01kFOQrwVRf+JLmBdfXxkS2C+l95NPVSn1mPKlEBq6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvw6Z5Rlb1eAQd7ZCrWyFgb6KO39TtBub1tV7CnZJf1Tbm1mGJbdEumI+Io6pCL1CT1kuEoc/UwnY708l1gkylHWFoKDkkDycyo6XrRxb3NfWbPcJefOQ3Myi4m3Wc3Mm/lBNmGBEvxXveX/VVhet1Z+GRMFqPjbxO6UPt9cGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKBZxNa4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKBZxNa4"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49043386b3fso49709815e9.3
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779878327; x=1780483127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCde4fHeeq7SCl+NtOBYmWodX1wXHkF9bNO8MUFMaHI=;
        b=nKBZxNa4ivHut9VfLpsQX/QihHEeHH5EP86i9mjgUsdlZVgM3uu9eVyv8pNag8U8V+
         edkvgkVLgEmmdSTt0L3DETS88mJakmFWzwXSBS4JbBhF4SCDD8crag/leGKHVIZvlmcf
         3O7PXPJxUpJiXqbsyPKaPBPTgeKCAZtIpdisgNWmzTE3VIFHSAp3yvKHFMNNs6LeoeRb
         UDn9bmxN4Mcj3ufGaIWS1DA2MpraedHCurRd84F7MBItloOPUYWWEDTcpefhXW4oycRk
         0MCtdcK3XmGSqA+mM33RxvKw9UZbpDSrGD/GXX1EYr5o6QTZtKf51iNDiZEGLcZouOsn
         /Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779878327; x=1780483127;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCde4fHeeq7SCl+NtOBYmWodX1wXHkF9bNO8MUFMaHI=;
        b=KkY2JHsyBbArHejhmCXUtYxTp4EG6NlGw/oZQvIPTXIKnjYw3CHF3nTHR+uc07REgC
         rtvYltDRiflpfVlf3rd0W2aRxhNg5z4ocdzY28D/uVT8NQy2BLeJ/Ct/12EFqPw6uBOI
         Y7lBgMKcQN3CyKeq147h7EzYwYMiTLi4C8M7Cky5OS+SIl45VLKX7YUvf0Cirs7PfniP
         L0WlcLkbeVajL1wbEJJ+jyU64M5wE6DQZDb7UibO1Lw9pGfpTxMeLah6gi8rDpjff2KR
         h8Hz5HcOSaj/Ee18UBJ8L5rhK+K2knbCMwlsy1ZBDKPpA0gVQPGwpPHgEwnSwP/vJhYa
         8Stg==
X-Forwarded-Encrypted: i=1; AFNElJ/c1rmA1YmHf1rGq0HZ4KREu5qdE86j8d7zskTNiQvJqnmpoY5Rr6PgbhzTweHOc+MpWt9hVgaBUo7s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51PmuR+IgepG4T5uozDvTSA7FgpBpEmO1AKUM+piWkKoNLrPi
	QKGE/KhnJrEIiZhK8XM+NCf0UnKINWXDdSelZSHk9oHs+rU+YHo0dXR9WgJ0oPhNfDBdLVLuz0J
	AbYFNU5QWgWmFsxU+XQ==
X-Received: from wmbe15.prod.google.com ([2002:a05:600c:590f:b0:48f:e178:4b87])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a402:b0:490:4033:d3df with SMTP id 5b1f17b1804b1-490426d7223mr271542435e9.23.1779878326354;
 Wed, 27 May 2026 03:38:46 -0700 (PDT)
Date: Wed, 27 May 2026 10:38:45 +0000
In-Reply-To: <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com> <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
Message-ID: <ahbJtRzeJUqpj3Ux@google.com>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch glue
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>, 
	Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:08:38PM +0200, Miguel Ojeda wrote:
> On Tue, May 26, 2026 at 6:13=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com=
> wrote:
> >
> > An Ack from you would be appreciated, even though you made it already
> > clear that this series looks ok.
>=20
> I did a quick `LLVM=3D1` test and booted it in QEMU. That worked and I
> could see the KUnit tests, though we get the:
>=20
>   warning: unstable feature specified for `-Ctarget-feature`: `backchain`
>=20
> But I assume you are OK with that for now (and if you are, then
> avoiding a custom target is worth it, I would say).

Based on some very quick research, it looks like enabling the backchain
target feature does not affect the ABI in the sense that mixing together
object files with and without this option will still work. If that's the
case, we can add this to the list of known target features for this
target in rustc, which will silence this warning.

(If it affects the ABI in a breaking manner, it needs to be added as a
separate flag rather than being added as part of the -Ctarget-feature
flag.)

Alice
