Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CD34F27B;
	Thu,  5 Feb 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280793; cv=none; b=ci4c6V9gGOiG3gbmDkorXQsU7ofqUoKM9vNSgyUT/fTljJlW7hB1KwmMGZfLIR8teSySS0qm+paKKI+1A/9e7X+EiGOx7TmCuVEOa4J+SmM1TA4yry5MmNSaSlhJZ0rHLvKrgTwWGVHzcyy70GbITNRXOV+Tp/RbDja2CL0x8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280793; c=relaxed/simple;
	bh=vZ9a0nKUmCYcn7DfvYPN6ExSS1v9vungJj4KM43Jl5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbRCLu9udn4KrrG0/4LfTFJl+oyPz8ubK+DewkRuVWNd8ToogignKPGCKT/mShjOvyfIPQSJnjVLsTpTUJU41gQ1xfV5Bx533bsnBhrRKHXxlGB47nVun1Rj044PdoI3rH11TEd0uVzWTa5DvPDn64bmqueP2yMXHo5uWdaSQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YFfwJBaK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFfwJBaK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8UqNmiqy/+DVRkRvDg0YgIjJhg5UJoRJjVfp0oSweMA=; b=YFfwJBaKby6FBHyytTEpsoArfs
	O78Vdb8Decqf6jUN13LUS7cTTND5NslHu/VB30zjdc4hbz1aNS+Z8DJOnd57tto6L/N5pyPItTJ9h
	pO581nm/xW23SxJ50BV+yU8vmLkyAFqgjd8dVBDQfloq06X0ybdZJg3qkyc1Pu7kW5AClDor5IZg4
	3VgYACeNbSJa6g0A1+yp5RW5xHg4yxww1N5HyEu9x0BHzgtIWqWRiSFG/TzdvWRgY0L+XTmrwAw7b
	9VWkT0hapR/CSI8g8NEtQdOL4M+OjnDfpkEpNOQQiSk/yIjHE4AkqiXqrlLwnvpLoYqgDTgqQ9bHB
	lYNU82/w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnutw-00000001mo1-2uHt;
	Thu, 05 Feb 2026 08:39:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE6D2300BD2; Thu, 05 Feb 2026 09:39:47 +0100 (CET)
Date: Thu, 5 Feb 2026 09:39:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: remove kvm_types.h from Kbuild
Message-ID: <20260205083947.GC232055@noisy.programming.kicks-ass.net>
References: <20260203184204.1329414-1-rdunlap@infradead.org>
 <20260205074643.7870A22-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205074643.7870A22-hca@linux.ibm.com>

On Thu, Feb 05, 2026 at 08:46:43AM +0100, Heiko Carstens wrote:
> On Tue, Feb 03, 2026 at 10:42:04AM -0800, Randy Dunlap wrote:
> > kvm_types.h is mandatory in include/asm-generic/Kbuild so having it
> > in another Kbuild file causes a warning. Remove it from the arch/
> > Kbuild file to fix the warning.
> > 
> > ../scripts/Makefile.asm-headers:39: redundant generic-y found in ../arch/s390/include/asm/Kbuild: kvm_types.h
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  arch/s390/include/asm/Kbuild |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > --- linux-next-20260202.orig/arch/s390/include/asm/Kbuild
> > +++ linux-next-20260202/arch/s390/include/asm/Kbuild
> > @@ -5,6 +5,5 @@ generated-y += syscall_table.h
> >  generated-y += unistd_nr.h
> >  
> >  generic-y += asm-offsets.h
> > -generic-y += kvm_types.h
> >  generic-y += mcs_spinlock.h
> >  generic-y += mmzone.h
> 
> This should go via perf/core from the tip tree, since Peter's not-yet upstream
> commit 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated
> APIs") adds the mandatory-y statement to include/asm-generic/Kbuild.
> 
> Peter?

Let me see if I can manage to apply a patch I don't have ;-)
