Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C8299929
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198074; cv=none; b=NZMCpd/VoHWMMUqHWXZ8wnFGBhdZOPcz9zk4Uji0xwRxoEwIkO276lJFegq2YFx8qR+Dc9FOVT0O+SVywCo6/0EsVtNN3nPo0urLy4yFaL3Z402UlD4zpNhuQM+/9TjL3fiisHu3N7Voz8SsQAvgCNi2srgoMx+UCoglT3S+oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198074; c=relaxed/simple;
	bh=7eTid/Y/ZrFuJ9aQUGHjb+pKuO0yMAyOl/AKL5G3obA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWzdliIZ8gUtob/u84d4oK957IcnDTYJPUyJZHhwToHEGGz036NcDtImAIlnEgcIGM1ai1VsUF6c7idoQcPBsIUWJEOJLhTVQH0f9m6UmGG8coq8ObraVJ4IAjlq+Z9aA1/V4q99mQxeT2IYIYLECzcMp1TOB1Te6JDwYMwEvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQTOqSUb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQTOqSUb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30c6040aa54so133052eec.1
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782198072; x=1782802872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6Ap3YJUEuoJTFxCbawQ11i/jSYqTs+DIopPqv2NeZw=;
        b=WQTOqSUbPsS4Vsh+KdBzDd+sE2ej5BekmKaD9l7AJosNCGdtJgxo+yA4mZekkxkejw
         YghzOpaIzh9j8x2afrIWN7pizwCIL3QQ5amED4IPwYUaF3Kp+CkBroDbaldOqapwu0Em
         6LNwZYKaUdju0AJZW3YiFzj2exOJf++VRcoeQhTPb71oEgCmonMcjI+tNYFtPBZgX2/L
         HDSBR6fJTXyIeJkBztDBkcByUnF7vAZm6oENh83T5sXAG3ysaVmxhLjbP7iMAaj6wOlW
         OXGkrRvT9+Do5+GB9h7Qq2PXg4zfLG79m4Y7lJm//QYO8iQABtVbZ5mOr6LCXEzgsz0N
         ZPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198072; x=1782802872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6Ap3YJUEuoJTFxCbawQ11i/jSYqTs+DIopPqv2NeZw=;
        b=fxaXFibjD5xuUrzVrrso93PumPEzSG3JSkt7VSrYV+hbLKNCgHIYPNADAkr9LUNxnB
         4dszdMTOzIPSwxGbESRiQcGZDu3ICXsFl4g5hhBb//fuo8a1JBOLLtC1y0ZbT0CtQlw0
         IE8eF/NH63vfOQZCu6VrIsUkuubOCe+9hEwGVcztRZ5TbP761fKNctUYL/CWxvloVGur
         /oQu29EZPHJZeBNT3gmrBl6zeQEUqaLkzgBUPKahZ7rFi5icKt1xgwn37kAlfcBNmPiH
         32A2+k7ueOP1PUpal2JkRrQHvTWLfWHwiyqTPhN63SBeOotfotN6P4rf+xVcUIPxyL5g
         9NyA==
X-Forwarded-Encrypted: i=1; AHgh+RqXnJRMDu7UHjlqEkr2dwikwTWiy2f0HAjeMKfujtFmea6La8UuaWhi8cGU3nz+O6MswUXQbHtrRpTO@vger.kernel.org
X-Gm-Message-State: AOJu0YziJ+8Oz5x9IehOkIqiEC5UT5itf3dlc5nTBZub0PJrycQUK4o0
	GvUPaFvOOaUNDDdoN5rNOdnrtIbigqkXbHOz+e21rO9RYU84WAxXyJKa
X-Gm-Gg: AfdE7cnKEo09QEWbAgtnpPEqPLdvmgpcX039Z7+j7GqAPtgFdHyi8EWUGFMuadkEH+Y
	8dJvFUtwU/B5+pOoDKBp0jKA6AESM2YGul1Ef+G34mL9tZDPowaNZ5nq45n93nM/pLmH7ef0C3A
	f3bwY5ORrDRwuWDO+tYLkxOjXYkbpl3O5vgbhk1Hc4n/KXmVpv+qtLEGmOh4g4nOCSytylNnJF/
	9GWUK+SNkgvX0r3a3c/ay/SqnJepCLTciH9sy/JpZKpjwnbtg5Odhf9rtgVFkqmFEQSf3H4xdJt
	XPicJ7OPa5jw1vpxgHkvW2GWY6THtqA9nqM7uPD7wp57X6rQs1HduVI9li9RC1Voi37t+Z6Pcwx
	46xaLewcf8sTxtpmNg6SxVsBJnOZ6oNpXFs3Xv06HykguNo7aVfF0vPstBZgo+G6Dz8mhbj7O65
	EP
X-Received: by 2002:a05:7301:3f09:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30c06e2e675mr12844078eec.10.1782198071896;
        Tue, 23 Jun 2026 00:01:11 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm18003870eec.23.2026.06.23.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:01:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:01:08 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH v4 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <ajovNDH2uo6V4NJx@blinky>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-6-kprateek.nayak@amd.com>
 <178219229643.10927.7189200920480581019.b4-review@b4>
 <ff9678fb-4cca-4849-8ffb-7cb76db60e1a@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9678fb-4cca-4849-8ffb-7cb76db60e1a@amd.com>

On Tue, Jun 23, 2026 at 11:43:39AM +0530, K Prateek Nayak wrote:
> Hello Charlie,
> 
> On 6/23/2026 10:54 AM, Charlie Jenkins wrote:
> > On Thu, 30 Apr 2026 09:47:27 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >> Futex hash computation requires a mask operation with read-only after
> >> init data that will be converted to a runtime constant in the subsequent
> >> commit.
> >>
> >> Introduce runtime_const_mask_32 to further optimize the mask operation
> >> in the futex hash computation hot path. GCC generates a:
> >>
> >>   lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
> >>   addi  a0, a0, 0x678     # lower 12 bits
> >>   and   a1, a1, a0        # a1 = a1 & a0
> >>
> >> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> >> by Claude which is implemented here. The final (__ret & val) operation
> >> is intentionally placed outside of asm block to allow compilers to
> >> further optimize it if possible.
> > 
> > If the mask fits in 12 bits, we can nop the lui and the addi and just
> > patch an "andi" instruction with the 12 bits of the mask. We already do
> > this with the lui+addi block and nop the lui if val fits in 12 bits. I
> > would be happy to help draft that optimization.
> > 
> > But I think the better solution would be to take the power of 2
> > assumption since that will also benefit arm. We should still only emit
> > an andi if val fits in 12 bits, but if it doesn't we can patch in
> > shifts:
> > 
> > slli    a0,a0,x
> > srli    a0,a0,x
> > 
> > Where x is the constant (arch_size - _futex_shift - 1)
> 
> I can do that for the next version and use ubfx for ARM. I can just put
> in a BUG_ON() at the arch/ specific __runtime_fixup_mask() and if a
> new use case arises which hits that, we can perhaps move on the dynamic
> nop patching scheme that you mentioned earlier.
> 
> Let me know if that works and I can pivot to that scheme in v5 and send
> it out post -rc1 after some testing.

That sounds like a great plan :)

- Charlie

> 
> -- 
> Thanks and Regards,
> Prateek
> 
