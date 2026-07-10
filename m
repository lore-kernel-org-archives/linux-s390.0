Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373142882C
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688003; cv=none; b=jaqAuyvN8Wyrvk5OE85DntNSR/fJ24RJhV2URXcUBwRJ3EU0M0r++ya2PF6ejD1q59n0nfr80Avs2YKOc8/u7e/G2C6jYj8BSqXFEJxOshKLb/veXMthsKjS0NfVoB+UrBsO84wHsiADEsXxeEcoVTlTpbqciWYiOAa7dnKcNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688003; c=relaxed/simple;
	bh=sxv6a13OPgrK6TOsUQ/kBJYeYtA4hSsjpL/QVUw8MJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff14UT4OBEjLXP1iVEMS6o7Z2ggesijQ06mJlFwQgjzpI6FOgUHEu6iTGPo4YpP/+qT/sWBQlud64sQzyMBxKjHQaL4XHYoRQvGBrY55pEP103Sq5H3bRJLP8PwJuIruqFVFTM+pSFV5cdDWq2GOJi46VxS1B9drH1bynbRNoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2AA42wc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2AA42wc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783688000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxMckJ71iKdcnC625lbZ9WJQgTp+gyXuVTaxsSZYeA=;
	b=O2AA42wc0EFpHFaeTcNaA+5w2Vxj2dLQZ00YjfR5A3+JB1y4OPtfyeY1VNKeuyYVDjlqoy
	TzMenwjfF9q+zFqyZXi8XP+H48JHs7nMPojLVdTC4UG6U94iupybkM9uqpYd1CMMtl1uyc
	pySLQjyn0zU5XCWVDK7TvBD50TiZKnw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-duefXCb_NOaqJcpTJsNlCw-1; Fri,
 10 Jul 2026 08:53:17 -0400
X-MC-Unique: duefXCb_NOaqJcpTJsNlCw-1
X-Mimecast-MFC-AGG-ID: duefXCb_NOaqJcpTJsNlCw_1783687991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAE061801379;
	Fri, 10 Jul 2026 12:53:07 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AEF2180029C;
	Fri, 10 Jul 2026 12:52:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 14:53:07 +0200 (CEST)
Date: Fri, 10 Jul 2026 14:52:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <alDrGBMdTuoLcVyy@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
 <alDmTcgzMlKiio9H@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDmTcgzMlKiio9H@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/10, Michal Suchánek wrote:
>
> On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> >
> > I can only say that ptrace users do want to skip the syscall and set the
> > return value on entry.
> >
> > See
> > 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> > 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> >
> > The changelog explains that currently this doesn't work because
> > among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> > broken in this regard.
>
> Or it could be documented that setting the return value has to be done
> in the exit trace, and that would than work on any architecture AFAICT.

Well, ptrace users know the problem. And this what they have to do
currently.

> With ppc and s390 using the same register for the syscall number and
> syscall return value it's very much impossible to poke the return value
> on entry into a register using the generic register access function. As
> of now there is no place to store the value ot of the return value
> outside of the registers, either.

I know nothing about ppc and s390. Can't comment right now.

> And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
> arguments on entry and the syscall return value on exit, that
> disctincion is implemented.
>
> Not sure how the patchset you point out is relevant, it only adds
> changes in the exit case.

No. It allows to skip-and-set-retval on PTRACE_EVENT_SECCOMP.

But ENTRY -> EXIT transition is not yet allowed due to the problems
above.

Oleg.

