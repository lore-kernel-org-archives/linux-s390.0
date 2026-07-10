Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD664189B0
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682218; cv=none; b=Vb4qM9SI8DQ8o0RiyoVLGP/27FFfs5+oXR8VXqnutkLxx9r/iX7rI71LxVRj3oCjbp64SLsoa2C78PehCt32ih4gH2b/3thD3pMA6J3h6aXhaexM8r0ieBDcAdGFrfPmoXho8CEr9tCgVy3fEYAuFO8mKolQeT4PGDVSQ0Peolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682218; c=relaxed/simple;
	bh=6CDOD3Tk8pnf7AZ/Om12tFpn8s2/8iaAbr5rRx3Ojjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6TpH3hHg7ZNJG473c1o4r1EZym2noiJzyZPoaKKLr0751nIyLhSQUOfGEe6pEqHAl4JDHk27YSx8om/TCNS9UU9NwC936sbA/ibNb5gzHi/KUrJw8FrLx88GvRaENYGFArBZpFNaN2fCwoX8WcqzO3A6c2fuj89L8dy+FGt0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiKBCJyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiKBCJyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783682213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hft+KFsru/NQK2GFVwrW+rNgrjQeb+hZeEo2ASl1/i4=;
	b=ZiKBCJyyRh1QDSgXHAhHhxlW1FNyf7Ep7K9ys5KUmHOPgG4nJ87zqzlpADMjXDNjYS9lx2
	orhTPa4/SQbV7dEs6FmOg8U6c42e5tcKkYQ+XDFPlb6lsfWszp5ilJW4KM+e7rId49cuQp
	tjoyAd1gF3CQDHYI23ELdMi7PmAAP/w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-1rPiqdCGMI-DqX1kFaFhcQ-1; Fri,
 10 Jul 2026 07:16:50 -0400
X-MC-Unique: 1rPiqdCGMI-DqX1kFaFhcQ-1
X-Mimecast-MFC-AGG-ID: 1rPiqdCGMI-DqX1kFaFhcQ_1783682205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3A3E1800BDF;
	Fri, 10 Jul 2026 11:16:41 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B2CE195419E;
	Fri, 10 Jul 2026 11:16:21 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 13:16:41 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:16:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 12/18] ptrace, treewide: Rename
 ptrace_report_syscall_entry() to ptrace_report_syscall_permit_entry()
Message-ID: <alDUhFt9eadC880v@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.280015701@kernel.org>
 <alDMlSYN1eKkjNCL@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDMlSYN1eKkjNCL@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/10, Michal Suchánek wrote:
>
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -375,7 +375,7 @@ asmlinkage unsigned long syscall_trace_e
> >  	struct pt_regs *regs = current_pt_regs();
> >
> >  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> > -		ptrace_report_syscall_entry(regs)) {
> > +		!ptrace_report_syscall_permit_entry(regs)) {
> >  		syscall_set_nr(current, regs, -1);
>
> Why is this done here?
>
> Presumably the ptrace_report_syscall_entry returns false here becasue
> the tracer put -1 into whatever register specifies the syscall number
> (or it was there to start with) which was then read back, compared to
> -1, leading to returning false.  Now it's set to -1 again?

I don't know why arch/alpha/ does syscall_set_nr(-1).

But note that ptrace_report_syscall_entry() doesn't even check whether
the syscall number was changed. It only checks fatal_signal_pending().

Oleg.

