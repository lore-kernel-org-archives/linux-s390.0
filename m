Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DC2F25F0
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407134; cv=none; b=UyHfFz566EIO2ZYBrL0RBEE7gpmcckIgV2M9A7rC49MkBagPp0ByONdD7AueNqpHv1FhxNfHzLBOi8Qf4ZyMNh+dBfSLjc+9d9oUMGJOpf5SNkn4FMYbJJGWHsLxKyi9EFMQWZu/zOfHvUHaBfHgjGrWgQVk8TZXLP5bQrB3T7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407134; c=relaxed/simple;
	bh=jynD3yUTlDArcHaCCEAh03CFBlEY+s9gPtQlqi9vkU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXLZb/up3zjkptptp+Lm7f09StSQrYQTO/xRfD37G6qLerIgHjmHGoqnsRtRsPMU3TmQDw11X5b315GUms40U2wE02YjFJtpfPUo3nGf+kdCi8R5ebpG9mQEr+G/mBeKUfAefFlaT334vO1QfA8JUPqqskGkd6Wn6l3GJ7PjZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCT8g6nF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCT8g6nF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b3637b90so4819105e9.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407132; x=1781011932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjzkBWrPpM9SZEJma07PplalHKDy0GBcQrn3xADEOEI=;
        b=FCT8g6nF4pDH//jEY7UL4l2FBw63paxgTue2u3GyCs7AMQXuUVxeA6zvpNiJMjheE0
         ePyVB0NCJU7SSk0cr0JFZ6nbWXBLArycvQbHXOek9ouBEpCUQnb5DJDOY2n9adVMQFrL
         uYe1YwBlEioJl8N2EqLUjTtKqyDPhoN/VFyY9mc7lvAIcA6frwRx/kHPly68pTE8a//T
         DXs/1yGiNMkEZf3l9GFsvsZ3SGiTrY5sic8DxccS4lDXxTuYQZ75Q8rykIuek0H0pPSR
         QYem/5C5CBZYYhBEY73v5o0XajY4gAGjlJ0Wyi2F3pH8/HPA6ugat7HUilXDW0ItiKDU
         +0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407132; x=1781011932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DjzkBWrPpM9SZEJma07PplalHKDy0GBcQrn3xADEOEI=;
        b=TjCOllj4JoYEq7zWuhPMDkvXgxnn8oVMLXVTOKSPoV1/HOSoUks7uoT1fgYUTnhsm2
         c940zt8UNGX4ZrnwMLZZvHqJWOt3pKeObuomV2yFBqD/B8mzvG/n2lI1uDfI2aOoF9HP
         4k1/TpZw+VfcRpiFbwtWvyZOWmB9P0qKPVj+ilcMHb/Ojp2h843kPZGVuEwOhEWibGnX
         i72QI3+Rd+S27CRK96xG/p0Sut4/Df0mAdkczh8hFtGdUh6gz6nlRfEL5Op6DCSzmzde
         b1t+RM4ECQOS+p1FiEOGjSCM3O0/DO3u5jz/gz+i0SAErhXxJ/7irJpHsUiLScQE1MAI
         +pcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZS3AIWnDJRcwWPYmd/CQcowtPq99MLEQshYXk7aeTYJ4fCSQq0iMNAgaObiQDk4xBcrZiRH8w2e9l@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAyoXPowPu8DJEySmbl3lbIdpqyX1ak9IDpaz2SB8teUFhKUT
	1Awr5zdybBF9DH8KERxyg1b1hv+t93q+ipGFwkF3uXa/ZB6iby+Vcb9dZgHydbhO
X-Gm-Gg: Acq92OH0RiiV/J5NN7u+JJo9GtRwLjbp3vBpuFdjWuMSRZoLJdgJFy2aVo3723R8TUs
	mQUkyshO5a4EOMnuXj5tyvN/+Q0gj6bLOMG4G0Vrc7l2Y6QDAVEXBDQoczEq2CI0ia4t4Zdc+px
	op1gwtk+5IGWRy0mhzbhyDKvoccnqFVdI85opcIPPrHU6N0qJYzndpDgJCK1dtdL9wQGUYcwno4
	wyUucGUG+57J+W9lU/QUzA8SF8C/nnCm5Eb4QH+T0qI+Yl1/Uuq86E7Hr7Ns22fY9T7zuE4V3Fc
	nNRVqCXyWBTPpBnwfS6g/psru2r1vtkhqNF9Zr6TOKEHNBatV1D/8+TMC8Gju+2bQA/Gc4xup50
	mswaMl59xUsQ1Ct+dZ571TUJLGlASJ6D7kME15fNRzViTA4740jJct3DbuxqvlWpPdtwraBiWeG
	zNaaDDQqXc0eB20m6NIldZpXqi3IXndRVIH4+X2wY8L/98Qv3NHqri8ev6Sq4vHUf+MUkhcPzbE
	q3akV+Dow==
X-Received: by 2002:a05:600c:4e92:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490a2900dacmr288018105e9.3.1780407131698;
        Tue, 02 Jun 2026 06:32:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm30190163f8f.2.2026.06.02.06.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:32:11 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:32:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Juergen Christ
 <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <20260602143209.1ce024e3@pumpkin>
In-Reply-To: <20260601150813.9109C90-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
	<20260526055702.1429061-2-hca@linux.ibm.com>
	<403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
	<20260601132750.9109A3b-hca@linux.ibm.com>
	<491a0085-9ba1-431b-9752-c1ac3fd602be-agordeev@linux.ibm.com>
	<20260601150813.9109C90-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 17:08:13 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Mon, Jun 01, 2026 at 04:49:35PM +0200, Alexander Gordeev wrote:
> > On Mon, Jun 01, 2026 at 03:27:50PM +0200, Heiko Carstens wrote:
> > ...  
> > > > > +	if ((insn & 0xff0f) != 0xe300)  
> > > > 
> > > > Any reason mask/not to check the register number as well?  
> > > 
> > > Just to save code. If there would be a mismatch with the percpu
> > > register, something serious would be wrong..  
> > 
> > Is it worth checking the disp then? ;)  
> 
> It is: the check makes sure this is an AG instruction, which adds the
> percpu offset from lowcore - by checking that the displacement is
> correct, as well as that the base register is zero.
> 
> There could be a different AG instruction within the inline assembly,
> for whatever reason.

Do you actually even need to check the instruction?

This sequence can only work for simple per-cpu accesses, so I don't
see a reason to let the specified register point anywhere other than the
base of the per-cpu data.

That means the process switch code can just load the register with the
base of the per-cpu data for the new cpu.
If that happens before the 'AG' is executed it won't matter.

The only reason would be to support non-offsettable memory accesses.
But it looks like the 'laag    %r5,%r2,0(%r4)' in the example has an
offset (of zero).
Probably only stops you doing a direct access of an array.

That would mean that needs_fixup goes in the bin and percpu_exit() becomes:
	...
	reg = regs->percpu_register;
	if (likely(!reg))
		return;
	lc->percpu_register = reg;
	regs->gprs[reg] = lc->percpu_offset
}

I guess I'm missing something?

-- David

> 
> > > > > + * Inline assemblies making use of this typically have a code sequence like:
> > > > > + *
> > > > > + *   MVIY_PERCPU(...) <- start of percpu code section
> > > > > + *   AG_ALT(...)      <- add percpu offset; must be the second instruction
> > > > > + *   atomic_op	      <- atomic op  
> > > >                  \t here, but should be spaces?  
> > > 
> > > I can't follow? We have tabs in comments all over the place in s390 code.  
> > 
> > The other '<-' comments below and above use spaces, but this one
> > mixes spaces with '\t'.  
> 
> Because it is not possible to use tabs there. We put tabs in our
> comments whenever possible.
> 
> > > > Probably it worth noting that no extra instructions between atomic_op
> > > > and MVIY_ALT may exist (e.g. in the future), especially ones that use
> > > > the percpu_register.  
> > > 
> > > That's not true. There may be additional instructions, they may just
> > > not use the same register that is used for the percpu variable.  
> > 
> > That is what I tried to say, but I also thought it is intentionally
> > only two instructions between mviy brackets allowed: ag + atomic_op.
> > Am I wrong here?  
> 
> Yes, you are wrong. You can use as many instructions as you want, as
> long as the inline assembly follows the rules with respect to the
> register which contains the percpu variable.
> 
> But seriously: all of this works only with atomic ops, so I don't see
> reason why one put more instructions there. We actively try to keep
> our inline assemblies as small as possible.
> 
> Even though with relocatable lowcore and alternatives the C code looks
> huge, while it only generates very few instructions.
> 
> > > But that was true before this patch as well, even though it might not
> > > have been "obvious".  
> > 
> > Hmm.. I do not get it. We would not get scheduled away before this patch,
> > aren't we?  
> 
> True. What I tried to say: before and after this patch there was and
> is no code which _uses_ the pointer of the percpu variable more than
> once. Accessing the percpu variable twice within such a section would
> be potentially broken, since between two accesses an interrupt / nmi
> could happen, which could modify the percpu var contents, which again
> could result in loss of information.
> 

