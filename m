Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533F13DDD6;
	Mon,  6 May 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035818; cv=none; b=SkkejeIULPk8pJHU7yyDOgBqws6lUuslcs6+Ic8wp5R6ndbAILR0n7lnbIXAizxgqk/vvkmYATWpP2oHAlqQpRpk16Yl5Ch3bREc4qjFb4GUro2BSYVSVssAxRKuxYI3tT/02Xr0S31FSLGPELcbfkX1YQf4s0S27loQCuFI57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035818; c=relaxed/simple;
	bh=HW1RkINGTg4M4Dd689Rj4QzJskWnTMP/SxEOVvrXQGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZCWQkRQ0rZujSVtmXSk10lzE2QaWNlmJVjjesUqv22hzoS4sjc43axzSbnm0W0Zl6N3n6sYpooJA1qpvnpuk9Lk5Weq/Fv7Qa6Jf8Rg27wcb121apJ8ug19tzYXrSRWq0WO7CI96k32k7NaheFxYggYuI9aLUVa21gfMyjOQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B1AC116B1;
	Mon,  6 May 2024 22:50:14 +0000 (UTC)
Date: Mon, 6 May 2024 18:50:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v3] kprobe/ftrace: bail out if ftrace was killed
Message-ID: <20240506185020.2f156bc8@gandalf.local.home>
In-Reply-To: <fd8283ac-232e-49e8-a5be-60e54d87b9eb@csgroup.eu>
References: <20240501162956.229427-1-stephen.s.brennan@oracle.com>
	<fd8283ac-232e-49e8-a5be-60e54d87b9eb@csgroup.eu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 14:46:57 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Isn't it safer to provide a fonction rather than a direct access to a 
> variable ?
> 
> By the way, wouldn't it be more performant to use a static branch (jump 
> label) ?

A static branch could work, but the point of this is that if ftrace
failed, it was likely due to an issue with text modification. Do we want to
stop it via text modification?

-- Steve
