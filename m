Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FC39A802
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358669; cv=none; b=ZObuYZ5yQ715XwoOoFmpp7LTxlAuPj4VVU4WerDS/8ssI5lHfKfEJx2im0OCpqXsZQBjFUKVtsm+/XYvDKD/J/5SfzzUgXU+4LKebJ8kbibc+24D1eBKGWUb92fADpCYyO14Fc3pCSQimHU919MKlHCs25p/C7MFg2rCVLBvIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358669; c=relaxed/simple;
	bh=T0AC2RLZO2FvAGgXWsA1p0OEHbPV653/BhLwcO14bUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQOwseCmP0cTiln0gKo7nC/X6683P6UlQ4389qhSw3HZw8y6JvYKO9BK5+w3NbGLh0Z1ouOoAtudd3VYfAz+l8stIajV402XwvgdfJgeHGUHhCd175e5/jRur9+XP32xsCd6EDfoGqNzvTaESaP54nlfvT9e5FCUtBRN2rPJ/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY273OTq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY273OTq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso54287435e9.1
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358666; x=1779963466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9JtDvnoEiL8KOvk77pr/XeEJrx6UWi6Hyo1/Hy2b1A=;
        b=jY273OTqQtxnZR/WDjR0uv8QD12vHvu5JZAtve2n0oll3R5kY4hxFPurmgT5zIqO4I
         A9DvAYB8p8GLg3inOvPYyxFAnza+sPq6Xb/v+pbp+UezhS7oA8/LBY9nKgjrMjMo53Zm
         wu45MmmLI/Gz9pIEQGAD6l8ofiS+bswB9QKE+H9qfxDLxZgUIVXIDQX8I/TYSPqW6YRh
         D6oQBnc68nPVwAxrtUNrStKoK+ZxVgKheX2hQ41Ie79WGCPzPMz43hGZlyE1MOnJZGbM
         hZnrX7ZMPHJuDdy3WhBmX/THLCjVkAyqY8Qy9aUx9a+aDfHyTnGmnmbhGJnSpjIUjCdG
         /EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358666; x=1779963466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9JtDvnoEiL8KOvk77pr/XeEJrx6UWi6Hyo1/Hy2b1A=;
        b=Fq15Wmw+U3LFrNla+MxQf/53d8xoRJ/V01PN1EiSv034VLInkRPH1sLZ60fc0QoqnT
         ex1cAbeeRih7QCl/2/QzoLE2ZP4x84QpBvn68QURuqTYh3e3PTq11oU6L4pzMj/cpUY5
         eB2Vk0weWU3mBu4n9W4VSW58C772lUbFVPJe+I12aq7MC0V7x/FfQu6gnPJ64eDom5FB
         n8bIVq8DgU/0Fs9FpMMDpLK5Ya3M9H/Wa2zqnmnbL+aFlRePHSrQOkP4n2DUms2U/3Mc
         T6GQSVIGDI6nGllIJAoeDdZoj8b+ci7aRnTforFtiBd/5lZjiTxs9CREv0GcU/qRS9jx
         mb+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EzMnmDMNfpQGSCLBW23TGZs2/syz8VVkB+6ovipfMGYd1u2raj1JDPnwJ3oeAnnovYPWvsoTu0N9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RX4P7SccGGjRng2uMME504Ha5uglWkC8G2bZOKPPaPzYj49Y
	4qSfmKlmxTJuCnCk1mL1hjKxpZdesFl4/oR4XT7wJIHIMidDqjrZopcB
X-Gm-Gg: Acq92OELxgiFAWRDQkkp2yOFhOCKPuJ/IZEj+7PE60/lC7hNdlOmRvvETyVszl0bRDi
	HC4hgCiUSPFiKTwhVEMzcQnE03WLveum5NAsZvLqHU0r0grkt6UIO8ZI2ekg2fYl7vi039wLee+
	QysrLEg6q5lN7eJfZbE6/bIRq3H+7iK71lKH7amjMtX2ZKbWuFRDQF0PlWRzzxAcJ09kN6IeaL0
	5kL2zBrVr5ZiaHtOesFiX9+HYOelMwlqlYVFXX5xEnABUh2qjzyE067EE1S2RiqLOycMzdVzTW/
	W2JeSr7gnd4E1ZwRFMA20G9qwCEtzf9KHwVgGK39akmmH87k2VyaslQLkEjh2RGKynLht8d9W7f
	XecHDCG8O4YHaXK7B63uEVq3S/XqnEkKcvW/bRw8oNT8HN/scbAlMtAQIZyXoJPfxokXqlebIw+
	4zF8i2ZEX+YgZ05TQZT6kyiw4pD9iPRJ4HlbTZpGiiGnAWT/hApkpPMNHVoVxXVWE1
X-Received: by 2002:a05:600c:1c1d:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-4903607fd1emr27914435e9.7.1779358666080;
        Thu, 21 May 2026 03:17:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm17210435e9.14.2026.05.21.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:45 -0700 (PDT)
Date: Thu, 21 May 2026 11:17:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260521111744.6e58bfd6@pumpkin>
In-Reply-To: <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 17:23:37 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/20/26 3:34 PM, David Laight wrote:
...
> >
> > But I'm sure I remember that some cpu don't like having the same
> > physical address at different virtual addresses (and not just those
> > with VIVT caches like some sparc cpu).  
> 
> Yeah, VIVT cache doesn't like it due to cache alias. But the mapping is 
> really percpu, so the mapping to the physical address belonging to 
> another CPU should never pollute the current CPU's cache if I don't miss 
> something.
>
> > I'm sure code can end up accessing the current cpu's percpu data
> > using the same address that other cpu use - there are definitely
> > places where it needs that address.  
> 
> No, it is not. In the percpu page table approach, we use different 
> address for this_cpu_*() and per_cpu_ptr() which is mainly used to 
> initialize percpu data for all CPUs.

You missed something.

Look, for example, at kernel/locking/osq_lock.c
The code uses this_cpu_ptr() and then both dereferences the pointer
and writes it to places that other cpu will use.
It also uses per_cpu_ptr() to get an address it can use for the per-cpu
data of another cpu.
(That code all assumes preemption is disabled.)

-- David

> Thanks,
> Yang
