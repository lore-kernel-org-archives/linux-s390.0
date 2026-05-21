Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFB385D85
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386140; cv=none; b=SZf7FVXT1kxtYQ095V4jCNjV3a+/2bEX8LQ8bgVCDrX3ND0uYeAe6dVI+aMnJoUwoo2LTEkcbjxlvI+B6TETx65BkU4flIhUtVqiA2V0UgFTDexVqxKS7mIISYXZlnjH5FnhKCQ4V/Yn1sl+fpvZJvJlwnxIEwOVoOYslKgB9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386140; c=relaxed/simple;
	bh=EO2fnvuaKoscY2L4JyD1Bdt5TLbDzJ378wpNGeBH4iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjy4Q/86XWNNxYG5kdjAbBbfYGay0rVp3lfUcqGVmQzn2J0e6j1A+8oTz7/1bmXcigqbOLsBiMseFnaq2P5rVgQ2t0jtdYASAnFMufGk8lZlUvlbTjwXrSHy6HUpCHZ6LJfVyo34PGfg0HssYDcz5auwNfx7AmkEgNhrx7Mntng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdUUgkFa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdUUgkFa"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7645adbdso4385231f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779386135; x=1779990935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ES1LlsZhSSlyiciDjUxQWzgR4KGihFsWMpz7snkbg=;
        b=ZdUUgkFafA6VdWerIXrrGrjo4V/y0+i0O+MK1Es5639+xSSmfeMEPphxctdrqtmWdx
         QVEBi+hKFjDKfACHQJRepcJbgSrBYlXAblOVRdTcZHA/8BNZTuAJNmuJ8kxA92ieMJN2
         9H+9yXDXl87hwmABSuPr/pcJwD3uyJHIjwNdf025h9jaoESkp94Fy/p888y71mBSpX8D
         XPuGICECgaegcCbmRWxdwA6hdtXeLrdgXatPsPmnkz6choq1t4eexI4daHP1SElxaxaM
         cMaa1pM3QDQ/sjpqJazpK6FrIE/DA2o5EFPaL9caE48aagjWJ1glPvTCaALldxMyYSmX
         yrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386135; x=1779990935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08ES1LlsZhSSlyiciDjUxQWzgR4KGihFsWMpz7snkbg=;
        b=ALLk/900c/jmxs3HPP6xTeITTaTjiEk4jx9lMt5AMHk/Zcvhs9jMjCQGuLMBN6DR7Z
         lE6LP3tS4W3glAPB8plwbEqioQHtXDcR/ZpGo8cAEQ/hbeGQ2/EcsTLLCcOZrpF2pXx7
         a3QN06BLrt8/9PoWgzEqTbXtBUB/8lc2pJgrAKNgDX7cCNV0WH3WzJ8kKY+ODkk8fKwF
         QMj3OEuV7m8kY71nQ8Xuly/ZH9EqkT7dljSmKNckdyAbLxbnCU80U1ADY45Q6e2KxSQ4
         QwPjU95BWzATxRU3p8VKK3I4RNABTFWbtDzu0Lv01TmxrolWxjPPUw1eNvQC1NmRrsFM
         e3xw==
X-Forwarded-Encrypted: i=1; AFNElJ9AEM2JyLPVm4KRvDRlZVv1nDXgCzDFuc7a+AgvC9TZK/e84T2Iw8LgIIFxn2LyUq9s1N1luxQMUboY@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYJ4riJjIXCMltdYO8sKIWHAkB8xXvBq1fE9M20GvHCjSflG/
	1f93QqYtQlQQwKhlJhhHSvK2zYQL5GfpiknC8L38QE5E5CcVXcRMvY9FmcqUMvmH5rI=
X-Gm-Gg: Acq92OGWaZqT7rqOIDvBtdSSl9orUuHJ2DbX8FWUFzQtB4HUYeRgUn6F1Xp69rue98m
	cBr1fFcRH4GhQ98GHnZUNQbTkDoBoEYKx0PK0tshhuYIsYQfE+Xpxw/8hcm083a1ekOOgQOy+iG
	SIwdm5kDdCsH4jo+BEqgXz+0GrtYHENedzGbI8Djf4M8Bmte6aGwuFAkTA7tlcJ76MyV8aDk6BW
	gsH8yUeoUAZ0wFqJ+yWIEPwtcyqzcsuPDAuN8BpLRhHkarb8UvlxKnR35GbVSxG2RDWwE0PKFBT
	vsqcmGSnHMd5TAiKwD21iytTmX22diGnWPCJg7VXtkQ1rGrWSbLXjaQUr6iFTvhCXcds+bxzPgb
	EqQpDqMvtOlJl+0F0sV7ivUSPY6DjH9uS/1GeOWGn1n73rdSiDoP0tKSKvFZbUE52rWmWZiAP3v
	ALsPpRz15PR8lA//ODyO4dHbovAfZo5y30ZDG411PWSdOQvmDPJCWai39028YC53zs
X-Received: by 2002:a05:6000:220d:b0:451:2157:6291 with SMTP id ffacd0b85a97d-45ea413afb3mr6462615f8f.41.1779386134661;
        Thu, 21 May 2026 10:55:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7d0a36sm4184810f8f.2.2026.05.21.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:55:33 -0700 (PDT)
Date: Thu, 21 May 2026 18:55:32 +0100
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
Message-ID: <20260521185532.002541c6@pumpkin>
In-Reply-To: <592ea7fb-b836-4c47-a0cb-248a185cbaa8@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521111744.6e58bfd6@pumpkin>
	<592ea7fb-b836-4c47-a0cb-248a185cbaa8@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 09:57:37 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/21/26 3:17 AM, David Laight wrote:
> > On Wed, 20 May 2026 17:23:37 -0700
> > Yang Shi <yang@os.amperecomputing.com> wrote:
> >  
> >> On 5/20/26 3:34 PM, David Laight wrote:  
> > ...  
> >>> But I'm sure I remember that some cpu don't like having the same
> >>> physical address at different virtual addresses (and not just those
> >>> with VIVT caches like some sparc cpu).  
> >> Yeah, VIVT cache doesn't like it due to cache alias. But the mapping is
> >> really percpu, so the mapping to the physical address belonging to
> >> another CPU should never pollute the current CPU's cache if I don't miss
> >> something.
> >>  
> >>> I'm sure code can end up accessing the current cpu's percpu data
> >>> using the same address that other cpu use - there are definitely
> >>> places where it needs that address.  
> >> No, it is not. In the percpu page table approach, we use different
> >> address for this_cpu_*() and per_cpu_ptr() which is mainly used to
> >> initialize percpu data for all CPUs.  
> > You missed something.
> >
> > Look, for example, at kernel/locking/osq_lock.c
> > The code uses this_cpu_ptr() and then both dereferences the pointer
> > and writes it to places that other cpu will use.
> > It also uses per_cpu_ptr() to get an address it can use for the per-cpu
> > data of another cpu.
> > (That code all assumes preemption is disabled.)  
> 
> this_cpu_ptr() uses different addresses for different CPUs. It is a 
> special case, it is not due to VIVT, but because it may confuse list 
> API. Because list API determines list is empty by comparing pointers 
> (head->next == head). this_cpu_read/write/add/sub, etc, are fine.

But you could quite easily get code that manages to mix accesses through
this_cpu_ptr() with direct accesses to per-cpu variables in the same
cache line.
I'm sure some arm cpu really don't like you doing that.
(But it is a foggy memory from somewhere.)

You can use per-cpu page tables, but it really only helps for a
few items.
Anything that is RMW (eg add on pretty much everything except x86)
either has to disable preemption or use a compare and exchange loop.
Variables like 'current' can be written into the per-cpu page table
data area by the process switch code (as I believe s390 does).

The 'trick' here will work for reading/writing values if you don't
care that the value read is stale (or might have been written to
the memory for a different cpu).
It might work for updating the preemption disable count - because
you can only be preempted while it is zero.

-- David

> 
> And per_cpu_ptr() also uses different addresses for different CPUs.
> 
> The lwn article explained it. 
> https://lwn.net/SubscriberLink/1073395/12c08f128e515809/
> 
> Thanks,
> Yang
> 
> >
> > -- David
> >  
> >> Thanks,
> >> Yang  
> 

