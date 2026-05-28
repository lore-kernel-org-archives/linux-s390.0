Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973425F7B9
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000450; cv=none; b=ughO1gYBWupBWO1SSz6LlLlYF8l0x1EFhyRIw/1sFPCbV4BpdFQfYvrBqUaw/TlfTi/YQWbtFFWqSMjRuMHhQ8FWOBMN2MjlBVYLu7w/8OiYwZWABXEBsmHSYg9WFHqM508POg+mwHEdrxhgd3yoD36m3SK28bjzgQAbJnCVYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000450; c=relaxed/simple;
	bh=05/CQI9qgZMjOcBooLCQlcjF6Z+wPRFM0NC4l1qSs0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCc9H+6/OdZBo9iOsY0S4gh/q95UE/S8RkT0zNs6dDT2RhqfjM03OVkmgf4W4rC5GEfmQQzal24hm6iQELfoAQZwFkuZj0xh/z2bU/UyYmBZlGISNuG4iF/8MAv8H/orSoB8CJz7NS3p9/uy6Did3P5YHWWn3qznxCIwnP/qt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjUY46Nt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjUY46Nt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso85161315e9.1
        for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000448; x=1780605248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O69T+9tlLsilbi/Ckdw96DPEbDw9wi6M5nFg+QzYeFM=;
        b=fjUY46NtrerPrPXituTOP1AczWGXVzmGOqENPrT1ASghVGXaGZ/x4iHh+tzLWcPyvD
         Y2J9gSUifG34zDuAAml8KqBtAC8fZymjEltOV2aNEaC/X2ewM/0J1ETpT3WipSMCa/MJ
         qbjEx7oVljefq0K0I5Y3QEMgQCP56icloQOqBNW0GtTwnuWTuD5rBDPFtSkw+I/MFYQg
         55DkjIDfPfgudiwK67pbIhoJeiKHx2DPb7vA0v+y8MpYumP46TRzhk2BJvn27cca93PZ
         Nxl9mJ4mnZJ8DOWOYwMkC8G9NLj0eToqLnnxMEw03zWpRickbff8Au4aZQ271hpPxNj2
         H5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000448; x=1780605248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O69T+9tlLsilbi/Ckdw96DPEbDw9wi6M5nFg+QzYeFM=;
        b=s+AHXY6KyyDCqcHxvhkRPRC2N0CJAiKYNdGVubK3zjsB/0lBPGzMuY4emFmd4DnAdg
         eZdMRpbxeK6FRxf54HZInpiVdjjrPTrl4KFM3xSng37v20gCRIHC9DnKal/lbp1CYWms
         EcHQc8XJWkLshxnw/fwNoGD3GjE4dbTNQOnQc4Um3U2XXB6CxnygspJAlFH5mugsBj1X
         FhYnUTOh5h/R6TzZXzTb2aIujM5PTIlf9ScdzpDWUwVek3qYc8B4tfu1F5KFgbIBqbM0
         b678KsSaH1KJQmALTpLntZe2cTDbzSDCuockYueXmmG3epQNEgzC0qQM0gguaLm9Xkhu
         DQSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OJ4Y9/5WrwdIyYlB/PBnDUwfJzcrbd455zlkFscrTMl3jaoNMz//Bf+IH/5S0bk6+W3VMXQABCTEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RNVUOIpYbsdGqM5HMX4RNfv3WfoVp+CCm7IyetFo2VmKLJP+
	YoPAvGHWWNrU6pkiXJUQqtlxdzJsVUgIEqaXNCyNHsZL953Uu0pr8z7a
X-Gm-Gg: Acq92OFpOcJD0cCzW0jK81oVnIEzRhtu/EdzORu/3FuNC/aoSoi6oB79gjF1trVO1Uk
	1LIJbWoKpV11247OFs03OqM8rSV8LH7Qol8ugXuAGphkVf0Cs/lQLcH1gOhH9Mkh1YCI2K4fG3y
	R2vY8wJNGFH41T0aNmRNlK9R/rafoBts7RsnJuIiBDq+1e4bGK+E1uGf9RltS8kFadmiDBG2bob
	yhU8KbiCtfbBByaXVhqV2LuU6iRYUgBh8LZbV2cUrNlVxMP2tEDB3vnDhZAmCDKRIAQwZ2dka5a
	LaxApNxQmVm/fseV+u3I4Z5mHnntEknXn9LEHc2n7URfs0TCiNLkfAsCa/eyiZhHaHiB8XA8H/Y
	EvXH/iHNTwPDXkK98S66fL3eHiPkDg5q/3N9HMS974jqPMhWHQIgSRDclR7+r8OWP4kE1gh7u5H
	y6KzcFciFyAFtIfT7TDYhObgCVyaPrWul7ZgJ9px75jV0OWkLWDlQ8NthOmHPF/+vXUvGQgro=
X-Received: by 2002:a05:600c:6287:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-4909c0ac81bmr962085e9.16.1780000447593;
        Thu, 28 May 2026 13:34:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490923613d0sm95054665e9.3.2026.05.28.13.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:34:07 -0700 (PDT)
Date: Thu, 28 May 2026 21:34:05 +0100
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
Message-ID: <20260528213406.134cf354@pumpkin>
In-Reply-To: <37aa12be-f3ee-4b6d-8fcc-33ccdec2725b@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521103742.9603C8c-hca@linux.ibm.com>
	<5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
	<20260522091805.18098A5c-hca@linux.ibm.com>
	<cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
	<20260528100346.1e790a53@pumpkin>
	<37aa12be-f3ee-4b6d-8fcc-33ccdec2725b@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 12:19:43 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/28/26 2:03 AM, David Laight wrote:
> > On Wed, 27 May 2026 16:44:31 -0700
> > Yang Shi <yang@os.amperecomputing.com> wrote:
> >  
> >> On 5/22/26 2:18 AM, Heiko Carstens wrote:  
> > ...  
> >>> It is amazing to see the performance improvements you see on arm64, however
> >>> I believe that is mainly because of the large amount of code which is
> >>> generated by the arm64 implementations of the preempt primitives
> >>> __preempt_count_add() and __preempt_count_dec_and_test().  
> >> Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one
> >> instruction is used to load current pointer, the other 3 instructions
> >> are used to RMW preempt_count). So I can remove 8 instructions in total
> >> for a single this_cpu ops. That's a lot. Given this_cpu ops are heavily
> >> used in kernel, we end up running fewer instructions and having better
> >> icache hit rate, the better icache hit rate also helps reduce cross node
> >> traffic for 2-socket system.  
> > Is 'current' kept in a cpu hardware register?  
> 
> Yes, sp_el0. But it is a special register, we need move it to a general 
> register before any ARM64 instructions can access it.

That is what I thought.
(Hmm... isn't that the userspace stack register?)

> 
> > With the process switch code updating current->per_cpu_data.
> >
> > That might mean that you can access per-cpu data without disabling
> > preemption (for single ops) using the same technique as s390.
> > So something like:
> > 	mov %ra, current
> > 	movb per_cpu_reg(%ra), $b
> > 	mov %rb, per_cpu_data(%ra)
> > 	// per-cpu access using %rb, process switch code will update %rb
> > 	movb per_cpu_reg(%ra), $255
> >
> > An add will need to use a cmpxchg loop.
> > For simplicity use a fixed register for %rb.  
> 
> TBH, I can't say I fully understand what you proposed. But it sounds 
> like this one 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=84ee5f23f93d4a650e828f831da9ed29c54623c5

Not really, although it does describe one way to do an atomic add.
For things like per-cpu stats you don't really care if the
'wrong' stats are changed, but the R and W (of the RMW) need to go to the
same address.

That proposal reserved a 'general register' for the per-cpu data all the time.

Like the s390 code this all started with, I'm suggesting that the code
tells the context switch code that a specific register contains the base
of the per-cpu data, on context switch that register is changed to be the
base address of the per-cpu data for the new cpu.
So outside of the code accessing per-cpu data the register can be used normally.

I don't think you need to look at the opcode if the process switch (the s390
code did), even checking that %rb (above) contains the per-cpu data address
is really optional.

I suggested using a fixed register meaning 'always use the same register'
to save the difficultly of generating $n from %rn.

-- David



 


> 
> Thanks,
> Yang
> 
> >
> > -- David  
> 

