Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05193A9013
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192372; cv=none; b=i83E3wLqbXk5e7ncfK4ScFowvuPi0U9QNuFjQcd8h7w/wyUcwQdfwjAhsCTCCbsdQAolQVxlYkrk2HJH7NaikDj6EqmllZFqxbQnjbz5BWRJRk4tYiMVkO15nlIFRBeXyHBlByE4hCH/bWI4SG/veSZ6y1Nk22LZZRF43droAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192372; c=relaxed/simple;
	bh=DjSs5oRw9rccbhTB4m6pdAGiet3QtdAO5qUM5zvUvsg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tuaeY3qd14JZ/BH6u6sBC6av/rTXEFR131ay7kB/TqAnGgJW8iDG1FzZASUie7vhmHY9rBGntnCJzZVvB1GfPSQtY3zSxjV3Cs5oMF60cAvwCmLSfLMdy7MU39RPIV0Zu+V3fJYm+NYgejY2Md+wPcUeqgW2RRq13c0U/xeVx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quAcfAc+; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quAcfAc+"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bf132969bso6540343eec.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192368; x=1782797168; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPvEzMllSbsUeGZyzSL2DVJCIDjlLydKz1PcX2CIArY=;
        b=quAcfAc+KwRbKomjlQ7OiNMV8QEi8jSn8Odt68rJIlULORthSyjOAwkegrYPyPZSq6
         hNf6IqAhMz0fcANJgjvfSnSAHnhgceyvvWnf7wyuKmSMgYyaHH2YqWX6ZhmbbHLRmqvr
         aKmBZTdtD/BANMu+hZghsaifUFfnGNhwX1TFrGRHih3MZ6O3P1qtDUlMx8FVFmHIe281
         rq9bqMojGlaogwe74714ZbAlhp7SST1U6jGkMiqC6ewdBTcDmASN8y/KV9NxUntnM+eb
         ShjHnLIYvBPb+SQP29yOuOOd4R7m9xXygN+EYVHWb8QHnjKIY+2iD5pB749zZcQeR2GA
         DJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192368; x=1782797168;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPvEzMllSbsUeGZyzSL2DVJCIDjlLydKz1PcX2CIArY=;
        b=ECO3/jr9u5Lw/nyCiVLZHjKSE0CTA9U9k2tfDwjXevDOWqpwQzXQhKZuj6K1YBu90I
         ojb1430WqjTWq3P7T0Tt1zRUUvqsGKu97+NAiUvWz88R8upKzxJO1FlwbxNFCkr6Vmm8
         i7vQ/9G/CqdfS499cw90c0YAyT7DkSnA4wCKTvOd5vxqwa+0Qzi6CWwStM1FIh+GHs3n
         H09eQsU+lclWK4lgIV2TABAcnzZyrc1W7TEy3rmPxjL2fUEUE81jQ79mHu9vywsNYC9m
         QiS1+UJvVGAZ9hzW31JNF+Ll3loC04zsjFflY1T/Iv6cvaP6r3pSxDW5H8TjwHVsQZ3d
         qntg==
X-Forwarded-Encrypted: i=1; AHgh+RpYzPpsG8XAUIWzJyC6UvtS1uvHUTrfb4z84psxC+ZtEOkPTtQzbjwFgDd8LRpahpCcD6LDrpKzF1K5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz803QWn+PlEVJGxFNg9jh7Lm/9CQj2s6YvkTYhzll1LqIkVV6U
	Rq6VWNv9rt1iNPAClqVB07QUWgcvwcflw1gWEfy1U18OL21Gsc8oMLyF
X-Gm-Gg: AfdE7cll/V3o2BK3mn7gEBHAYHizpkM+HSvZESafDL4Tsg4RQri/iunZR1EACdHIp8N
	mbfDRLr+B6NIW4DHunk0KpXt0pkyi3ESIom7wqRMM9pZ6bGrPU7pyWBwgjGcuo5PXjKtghbPsM7
	Y6tpSAS91NvY6A60k+4B+hjmAluHOrzaTSVTUdurPAtfaM1tKRRrmtSqC40ZXxGpDTCRhsmxBKH
	opahidK9o4Q88loswAb6aeon5NK/+aKC7BQYcoyqtTrstTdM64A/tu5PwBtl12RRhgdi+XQMYis
	EE0UZF+eByJUsHCJY8m7XLNCEFKqxhi0ptD8U8NUdgUB9HWCJW1XY4pR0GUboUEwBTwvU0uqCMg
	h29cEp/9lvs3zb4QdTZ+KDzg+L2pQmQyTczsB9/N568CAhj6cTAE53LIN4/DMZGi1rs1I+a57jq
	yFldeIo8w=
X-Received: by 2002:a05:7300:d507:b0:30c:1276:cdf7 with SMTP id 5a478bee46e88-30c5bc78138mr708393eec.25.1782192367703;
        Mon, 22 Jun 2026 22:26:07 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Charles Mirabile <cmirabil@redhat.com>
In-Reply-To: <20260430094730.31624-6-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-6-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229643.10927.7189200920480581019.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=1456;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=DjSs5oRw9rccbhTB4m6pdAGiet3QtdAO5qUM5zvUvsg=;
 b=Q7gZYCRpUNaR0P6LCnsW2BKyT1zjAR9X/QtNq425aoOkO4GWUw2wE2DMsLI9hCenc1NtUPLh0
 LKuQabhh/3jCnBFxJDuU/QtOQWYl5v1MrRasvhVADGKiAdB5C5B53hi
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Thu, 30 Apr 2026 09:47:27 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
> 
>   lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
>   addi  a0, a0, 0x678     # lower 12 bits
>   and   a1, a1, a0        # a1 = a1 & a0
> 
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. The final (__ret & val) operation
> is intentionally placed outside of asm block to allow compilers to
> further optimize it if possible.

If the mask fits in 12 bits, we can nop the lui and the addi and just
patch an "andi" instruction with the 12 bits of the mask. We already do
this with the lui+addi block and nop the lui if val fits in 12 bits. I
would be happy to help draft that optimization. 

But I think the better solution would be to take the power of 2
assumption since that will also benefit arm. We should still only emit
an andi if val fits in 12 bits, but if it doesn't we can patch in
shifts:

slli    a0,a0,x
srli    a0,a0,x

Where x is the constant (arch_size - _futex_shift - 1)

- Charlie

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>
