Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F552204011
	for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523186; cv=none; b=oPzNVgwAW3sP4m1IAaBvICJ+16HjLvGmddh9HsSMDp0kBPD/jPV96jgVEXcHj3F5Gq6BAy1nBtK4+ldXEGVD0jTpliiS2XxWXIoASowLUF+ynlT6XlRtSxxHbgY/hcjiDT7auzSMlcTMyrF3wTMVhbjY1+bT7bB9dkVNUQwSX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523186; c=relaxed/simple;
	bh=ds+Byb6f/J+Uut9zVkz68U3HJ2rc8F2Zd4pX+KfWOxU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gZ5IcgysyOWlRDpOHc4UJyHVAabLvyifSXfV9M1Dq4SO8UNLCT8wNniNN1xk0rBQ1CQA7LyH2RUY97vglKB2euneLOpgdiN0WIvZ+MV40nRCAn80aonP0NyF8KBQSJ9+ZjgChPPP/nJ4TI/pDufr0g72JsE2xj1V+2bmdgayGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSFsUbko; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSFsUbko"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-83ab434c629so732238239f.1
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2024 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731523184; x=1732127984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fUPXvWv9v0Mh/WyGQgAC8FHYBBV253S8a6S2mHs2j8=;
        b=YSFsUbkodRxrkGWV91RmEh+jGbwHWMjNJDhcC6PYiOqj1E8XrNUjibmt3MWG5Hdf6l
         7Y+tHWf3V+x1qAPpgiTyRIp+1C7ZqpthuYVg2ZnGW5LG/w+StfUSMDVLSvTRJEbgpmlg
         A3oIsZRc/St+v16zUNhlI2pFDW6Dc3X4rQOKAW/r0Cl3xssN4KMB/m6+cjuynzhijCEL
         PX1+VK/l60FLWDJJS9cP2NMNamO8aar/gGejRpqGrE72Rmnves7nEqgUv0YkYHfArL/D
         42j2vu7UyoKULa4Y5emZdhpv/zWVC4c8FlkWI/vxdpc26C8Ohn8aLvvvUF8YDvfRXjER
         xhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523184; x=1732127984;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fUPXvWv9v0Mh/WyGQgAC8FHYBBV253S8a6S2mHs2j8=;
        b=js56MQ3QiFkh5UX2gDlZz+AE4+JPAGi4n8hHaIpk8BQJsH/Q5DrX8rFBMn65AoAIsr
         7iIgFLBuL5eULXaLzuPYO+7LRKy9nf9Y6P58C4gsppIrhO9Ub6MrxlFg2iUpDS6twG/E
         DMdaKHt3pmv6PCYd5FTj98JHqVEKG/BnlKpOru1jcfsCUu0HJsF/EfVNa8jSqjFMUQqH
         XJt/JJb1Js+alyvmCSHGA4SoJUtQndna65gmggD6MukO1mHTVMwdh+mkkVijRSPfE08g
         IJpObYbUiMvFkVyzU0i4TXhbK0Wmjd+IFTRbSKDymcYuNxKT/lNSnwSDAjyU7XlGC4e2
         QJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWqPv1jkl7vatvYmPFTjRk45kLdorSOLRFMdb25nMRoI4+0KA/DMVbMZ3I7+OhsT6Mj+vX/bmQiW0Zt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BAvh4lNZdGSChGmJp97shhcjlaO0R4zjtv8vxLY+gSBlVw4P
	OX4Hp4N0UgmsCKst/94tUagXO8miESlQac6afHOrPvfu/+q3Gb1fyix+Q7kyY4p4RfpeoCF9+aS
	uODjUYPplYCm0MPIo9iIjeQ==
X-Google-Smtp-Source: AGHT+IFqNa2jrXVUDfm9IE+oYt5yFt1zslo8K13JW/BJldIHrq7v5sp1QoU1+LNMj81fKDzjJdmH4l1lpTYb1/+IBg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:583:b0:83a:ac70:becf with
 SMTP id ca18e2360f4ac-83e03357885mr4245839f.3.1731523183650; Wed, 13 Nov 2024
 10:39:43 -0800 (PST)
Date: Wed, 13 Nov 2024 18:39:42 +0000
In-Reply-To: <gsnt34jv9el6.fsf@coltonlewis-kvm.c.googlers.com> (message from
 Colton Lewis on Wed, 13 Nov 2024 18:24:37 +0000)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntzfm37zbl.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 4/5] x86: perf: Refactor misc flag assignments
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: peterz@infradead.org, kvm@vger.kernel.org, oliver.upton@linux.dev, 
	seanjc@google.com, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	will@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Colton Lewis <coltonlewis@google.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:

>> On Fri, Nov 08, 2024 at 08:20:44PM +0100, Peter Zijlstra wrote:

>>> Isn't the below more or less what you want?

>>> static unsigned long misc_flags(struct pt_regs *regs)
>>> {
>>> 	unsigned long flags = 0;

>>> 	if (regs->flags & PERF_EFLAGS_EXACT)
>>> 		flags |= PERF_RECORD_MISC_EXACT_IP;

>>> 	return flags;
>>> }

>>> static unsigned long native_flags(struct pt_regs *regs)
>>> {
>>> 	unsigned long flags = 0;

>>> 	if (user_mode(regs))
>>> 		flags |= PERF_RECORD_MISC_USER;
>>> 	else
>>> 		flags |= PERF_RECORD_MISC_KERNEL;

>>> 	return flags;
>>> }

>>> static unsigned long guest_flags(struct pt_regs *regs)
>>> {
>>> 	unsigned long guest_state = perf_guest_state();
>>> 	unsigned long flags = 0;

>>> 	if (guest_state & PERF_GUEST_ACTIVE) {
>>> 		if (guest_state & PERF_GUEST_USER)
>>> 			flags |= PERF_RECORD_MISC_GUEST_USER;
>>> 		else
>>> 			flags |= PERF_RECORD_MISC_GUEST_KERNEL;
>>> 	}

>>> 	return flags;
>>> }

>>> unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
>>> {
>>> 	unsigned long flags;

>>> 	flags = misc_flags(regs);
>>> 	flags |= guest_flags(regs);

>>> 	return flags;
>>> }

>>> unsigned long perf_arch_misc_flags(struct pt_regs *regs)
>>> {
>>> 	unsigned long flags;
>>> 	unsigned long guest;

>>> 	flags = misc_flags(regs);
>>> 	guest = guest_flags(regs);
>>> 	if (guest)
>>> 		flags |= guest;
>>> 	else
>>> 		flags |= native_flags(regs);

>>> 	return flags;
>>> }

>> This last can be written more concise:

>> unsigned long perf_arch_misc_flags(struct pt_regs *regs)
>> {
>> 	unsigned long flags;

>> 	flags = guest_flags(regs);
>> 	if (!flags)
>> 		flags |= native_flags(regs);

>> 	flgs |= misc_flags(regs);

>> 	return flags;
>> }

> This isn't right because it is choosing to return guest or native
> flags depending on the presence of guest flags, but that's not what we
> want.

> See perf_misc_flags in kernel/events/core.c which chooses to return
> perf_arch_guest_misc_flags or perf_arch_misc_flags depending on
> should_sample_guest which depends on more than current guest state.

This is in the next patch. Excuse me for not clarifying.

> But I will take some of your suggestions to split the functions out
> more.
