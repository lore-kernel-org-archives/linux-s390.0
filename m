Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57134F48C
	for <linux-s390@vger.kernel.org>; Tue,  3 Mar 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529138; cv=none; b=kQs+pXmaCuRpB8qmKFg9NyrBX/oeQFKzDhleI4boBUCdea+s1oCuaR5cktMQZe+JXb1rlQornovzfIhhjaU078SWCNLm6Gi8gTniioQKog2qIAYbIwfSPV0azOH75tRfhw1M1lUtBkURklqZ17rh2AmVz6NJyDIBcaqWLQ5s694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529138; c=relaxed/simple;
	bh=ECc7z7tsidz26oiQwOHWeZRLOlNbNjwxKg4L1JltJrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7dL3ZOI4KmL15mQVAqR5kG0P/a7I8sdBrmFuXjgVNbcEgh1FoRalfXKXmOp0KzKd3wVUPeXk6Iz558XoIvdgryK3tHd+PCr0M9KnCv1J+FE4UVrN2+8qeA68N9oZsKdiHBvKV2jfWJrwCWGYVFXMzq1WPtGLY9btOFr3xVkzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6gbYfiq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6gbYfiq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso48065995e9.2
        for <linux-s390@vger.kernel.org>; Tue, 03 Mar 2026 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529135; x=1773133935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=D6gbYfiqZ9Rub9Nna+8CpTbHrvLLEBybstalgCCNYJt05H5XiJLBCCrkaJmEVbnx93
         0DeEZNj+JuPY305863XQwrg2W5OaLpXpiKDVn7ZgSmmvWJfk5840zZpwrBQoxGsVLr2V
         941nJYizTDY3i1Xx5kR8DX5eJuPf4xhvBWtjtqF28lloXnh68KfNtDSQSNkBBUKoUg/y
         75+9TOCLECMjRUoh9+A+fQk3sUCtJbO+hb0c3+hLPph8RtG3OlD/lEc8gK/my+ranH9o
         rvHNfk2gUF1JF9rJtRS/8mjTju073gBH6L927ZI6BGkoDsfJfUfkFC99zJXs7W7YsGdL
         7UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529135; x=1773133935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hy9xICo1EPoOGuMUjTJL88qGfqc1hJzlCloLKGWnZI=;
        b=DoQKTFUYIv/WegGKL9e1JkmR2A0OAmrYibY3dCRnlH/Wvhq8RWxPS7fgaSHD/2hUun
         x0LRF+5TTcVdLqO8FG1ajlb+3ld5XTQee96DIpe63w2OEjkKiqARy00sCxKamVak4m05
         SHzLgJuLEpuLqZK8/eJXH2SqyQAkZkJnWGkV1GDSq1dCbBs3vz4XAJZpBsXVYOxJpJQe
         ZhfosFo+dlAsH8CEXAYBPsqcLEqx9bL/gTb0NswLQxYy53CC+n4it/R58GH4SxL0Gr8h
         Gy4mqdAEIev2ST7Eaw7sb0e+uryF5rCHe1Dkb6x7SG3LFLEEB7WYvrP4QGM+WpjqIEAj
         exig==
X-Forwarded-Encrypted: i=1; AJvYcCXNEmvFf89N8kqorIZy+N3EqRWN+JWqBMSR1IHqdil/XT+2B4Y1ux8iNCIhHmTOOKYjT7UK5EfIGMv1@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFydXIo/jkA7C7/az2h6nejXDIvYlt+ustiEBukLjUR5bzuRN
	V9UCIBSiztZ8/SyCZz06H1RKj1q3rpY8U5xtETRLwCOSLKaVsqujU5Dz
X-Gm-Gg: ATEYQzx7M3ViDzvtn5sZn6npuSAri9p1EyOZcSMA28CdZgogvUIlTFNmHNPeXJNO1xj
	Alc8MuHoiTGmMRhwEUDlQSqhwT6c5SGTNzs/R0Z/c3sHzrj/yPVhPDjIOLUMmjdz9WZfyq6BDMZ
	Cx6QHZ2CiV3buma+BAXpxs4tlQls/48gxPjMyQ+5BZmN5B6sYy0Oy6kqRzvAWFHKN3lGgPWlF4H
	w18zPHu+OtxCuv/EGzwP8Vru8K5ZQZ+nA3b/4SoYOiqsjyrg6sQo/L52SKOY2O2yAnNHRbvPWO+
	rWhq3TluZD47PVqy5eNXw2Xb36/up0+/ns0Kt6rIjW8FnFApLePL7SoT2S37KE5xtQeSHpa+/hG
	Ca/7VeTE6bOKb+WA0ShCPII0feVJD3K+iYKaFPpH8DCrpqRID29tGTVNbbjuKqRHF+yb65aMZAk
	akbI/kiC9L6ERcBR/x2+JfGayqCSHHLOXhlH/8I92YcVWbK2kFn0iIpuHLpaIoD9kT
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr280473755e9.2.1772529134880;
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48512692c14sm13045615e9.7.2026.03.03.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:12:14 -0800 (PST)
Date: Tue, 3 Mar 2026 09:12:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner
 <brauner@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara
 <jack@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix
 <nicolas.palix@imag.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King
 <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in
 __scoped_user_access()
Message-ID: <20260303091212.620241c8@pumpkin>
In-Reply-To: <e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
	<20260302132755.1475451-5-david.laight.linux@gmail.com>
	<e54368a9-9118-476d-b999-bcd60847f0ce@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 16:00:26 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 02/03/2026 =C3=A0 14:27, david.laight.linux@gmail.com a =C3=A9crit=C2=
=A0:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > -Wshadow is enabled by W=3D2 builds and __scoped_user_access() quite
> > deliberately creates a 'const' shadow of the 'user' address that
> > references a 'guard page' when the application passes a kernel pointer.
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com> =20
>=20
> There is a problem with this patch:

(badly line-wrapped errors deleted)

It seems to need gcc 12.
(So Linus is in luck.)

Prior to gcc 12 the #pragma generated by _Pragma() act as the
controlled statement of the for () loop.

Trying to put the _Pragma() inside the for statement doesn't work at all.

	David
