Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83B3BE144
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411017; cv=none; b=cfeSalZY9x7vfnaiTtFRXYX8O+nFkRE7r+d6J2pImet+jeEQA+bVXJrNWxineQhgKM25chztMWzyWWMZrSvDmASqSyL5qz3e5Doa0wjD8DqJQ+AaZX9BCxePMV5iigGEsgzgSZHQBNTbBYbo/ZSHVHw44Gu5aDmKrLoNpo8p0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411017; c=relaxed/simple;
	bh=8TDuoVkcu9gdj2cfN4RmPownLIzXANuybmdd+isc9jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1k7FCIcJ4JktGW2t58bYlpRFrZuXTdxSQjTlBE5ufTDtQSTn1vSxcw2IwtUjHXO/dsgDNuHggguzPw+Z1Bi0oKqwHGRPe9LO8NqpGEkhha6JG8+SbVLVeJG7T3PtPn7nepsl9mvzlpVhw+bOjm9bRSrXHuE6bDn5mn8FD2cNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUGlmAHr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUGlmAHr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ac357c55so21377855e9.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780411015; x=1781015815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBKguW3D/kCt3h7s27Q2mTTVZ4PVa9W86O/GL4rWP8g=;
        b=GUGlmAHrvVc3fq031mJgqqEIFJKfvtTXQETReE4nuRe/VFEp9bUzqc8WAob0z7YTZ7
         vbRnAsManh3TzXC5eZluDDXcp/+DAIRI2y3CVSqyzXEcsAGpg6VYFMF5b5Oi4QSB0SQy
         aCUg7lglQBpfA7x77KKiFngT9EfYyf7HLalVUKRIjwKEJTwg/9JaHbsAwehwS3VevPAt
         l8RCk9z0PVLTNo91SfnKg7R13WN1yTOkBL/D/If+8ylOhIAZT/c+vvdHeam9G9Fw8+So
         RVHT8fZI8OmEXhHwg4mIAPIW53EP96AjTjCIsXBpONtroGpYF5PASIilUv1pmH63xzh0
         S45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411015; x=1781015815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBKguW3D/kCt3h7s27Q2mTTVZ4PVa9W86O/GL4rWP8g=;
        b=AUmqmdrpjzxpTYbDqhFPWlnqaCYmJOuqD41h9lnL3C2mAcc1BRox1z2jqy1hHKbt92
         hh/MmwkUroT7kOjK+oo5pMv7n8AKL+RlV/EwQk/f9GzjdUrP5x1RGks4JIjdkaLw+61W
         YkdaLtp+H26dCR2Adpmf071EuSsbW11fKqAyv/acsqVhP2to1OdFfF7yWl3gRM6a/134
         tSyHdhxzVPFjEanyECMR/i8TaIzw47UZpiF2hKPDRohD7mwVXzRZj0hVR+nDRnMWuAoc
         EjF8qJonkY8f7EHe9217Qh9TE5UvDtaQJw6ZQ4UWLePsBHgiz/K3Cs3TL3LJqH/JRk/9
         cJ6A==
X-Forwarded-Encrypted: i=1; AFNElJ+QxSmebv1lqffkzj/k3UcAfRHUEaVUtojRTfmcftfqRTloCzDWTZ4Z5Hu25ZUPmAmyUY9mw47WDiQG@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/xNbMtglGkHdx4Hp9rF2dfJeD/VvQB6ggAMLH2/qTmjAgZqo
	qHArzLlPVec24+D3fA1EnQsnUDbE+kdztCDTpruIDdZI2j32yqBQcEcC
X-Gm-Gg: Acq92OHw3t+QOweXECkrZH5T4P1G2LuwtQjQbs87oMbKMjRRpoNtv5gCuRJCR2Vc2ag
	VcnFLEObtTkhk1l8Ht72c8qY9/QjcMiHrcxNlFOUhb2wUnQ6zdFG/DVRXyCO9fFFV9HcfNLZfp5
	gNG83qJJXuaMUgK/pd2pRkjNLC3YC/QtYIASPHdZ7TnVno39tlwUq03FEPx3Sku2/pN2KJlDONA
	3CiRzwxns+x6Wd0v/teDAOVHW//RdgLeULwrtu6bb47pnlM/kkVuw8ucrCwwWR9Rv8fsK4+nGC1
	DltepjKgLGBO4uHqUL1nN2WAiA0qSKUi3sze5L8t8kgc89EZ155aAbGHVJrjW2HKrPJVS7dD1Bm
	YzcCU9Ro6T0ykTGIBvqX0xDX+/7PAQN4DzRQ1pwvVNcXH4WvaqdCJ5pKMd07Y9zppYFRKfb/X3m
	sl2sfPGdVIv/75m2X8KXfomJvtdAAIctUnlEDK7NAF0EUkiSLVyjiILe437WNYXR0kaEbqWYY=
X-Received: by 2002:a05:600c:190b:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490a298f29bmr88226445e9.22.1780411014496;
        Tue, 02 Jun 2026 07:36:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c121d63sm101418795e9.29.2026.06.02.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:36:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 15:36:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Juergen Christ
 <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <20260602153652.6c2c02bc@pumpkin>
In-Reply-To: <20260602135436.10415A71-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
	<20260526055702.1429061-2-hca@linux.ibm.com>
	<403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
	<20260601132750.9109A3b-hca@linux.ibm.com>
	<491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
	<20260601150813.9109C90-hca@linux.ibm.com>
	<20260602143209.1ce024e3@pumpkin>
	<20260602135436.10415A71-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 15:54:36 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Tue, Jun 02, 2026 at 02:32:09PM +0100, David Laight wrote:
> > On Mon, 1 Jun 2026 17:08:13 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:  
> > > It is: the check makes sure this is an AG instruction, which adds the
> > > percpu offset from lowcore - by checking that the displacement is
> > > correct, as well as that the base register is zero.
> > > 
> > > There could be a different AG instruction within the inline assembly,
> > > for whatever reason.  
> > 
> > Do you actually even need to check the instruction?
> > 
> > This sequence can only work for simple per-cpu accesses, so I don't
> > see a reason to let the specified register point anywhere other than the
> > base of the per-cpu data.
> > 
> > That means the process switch code can just load the register with the
> > base of the per-cpu data for the new cpu.
> > If that happens before the 'AG' is executed it won't matter.
> > 
> > The only reason would be to support non-offsettable memory accesses.
> > But it looks like the 'laag    %r5,%r2,0(%r4)' in the example has an
> > offset (of zero).
> > Probably only stops you doing a direct access of an array.
> > 
> > That would mean that needs_fixup goes in the bin and percpu_exit() becomes:
> > 	...
> > 	reg = regs->percpu_register;
> > 	if (likely(!reg))
> > 		return;
> > 	lc->percpu_register = reg;
> > 	regs->gprs[reg] = lc->percpu_offset
> > }
> > 
> > I guess I'm missing something?  
> 
> The percpu register (in the above example %r4) first contains the base address
> of a percpu variable. To get the actual percpu address of the variable the
> percpu_offset of the corresponding cpu has to be added to that address, which
> is what the AG instruction is doing.

I knew my brain was fading.
I'm sure it should be possible to get the linker to put the offset of
the variable from the base on the per-cpu data area into the laag instruction.
(Looks like it has a 20bit offset field.)

Although I've no idea how per-cpu data works in loadable modules.

That might mean you need lc->percpu_address as well as lc->percpu_offset.
(If it isn't there already.)

-- David

> 
> What you propose would make a CPU's percpu_offset the address of any percpu
> variable, which most likely would result in a crash.

