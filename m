Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D13EDE6E;
	Mon,  6 Jul 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325832; cv=none; b=EXopdJlxeRBqscAh0GNclKUMtPHUfDueelIWrZW0La43c0oubx0nSFURGdWjs/tbthPEkq63hi7uV4HB7tVeWZk3ssCtd/58PtxVcahgBnXK+rkbuDxrZIlY6HdvDkrqZ7ii1cJPt2qe0rPW4l274eyZWFNDngTPJjQ9Ws+DMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325832; c=relaxed/simple;
	bh=2gFskhsb6RmAA5VINJrK/A8SJPhRd6tZO5gS28To3ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uwquj7ZNECsM+RLjAtk6r2AXRRdFKarzGPCrn/1Hnf3G7w6d16wjhIQ/t+26H0PuwGzb7Zkzln0QX2iisu1TYgCodoYAYURO/sy5oU8dIGiS9zgwREEMUjXXwDqtGar4Nvfl0yP+RqhV1Ov8FjiCMLkxlwzEKMENvqlwKa3fnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfC9H2UV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfC9H2UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF91F000E9;
	Mon,  6 Jul 2026 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783325820;
	bh=r7+ah1vbGAvQLsR+3yUG/Iv1avIrbLDskfWMmANIMpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XfC9H2UVpNQGtHq/xKLEWuvy4dBFo+F8wnT4a3nMjIvGfHuzuoXWCWWpR3IRGACyX
	 ddDWKGu9BP+PsJvxUDK2bd/p/KeWLd0czr6A1n2oiorGfYOAORf0VSj4p8BpzPNLGs
	 Ks/289z7wkXWc1DnJ7LrjlkM5r3LLyPV2aysSVO7Va/BtZrxeY3rlf3iV2jR28XK6V
	 xvP1325V2CnieiUAnTaDerFyvnvz3so5txLMmGU2XfJvoVLUklK5D8L7xrnfvcxkuk
	 3Zu/60IEr5IZRUAZ6W1jaKJhtWOhQgEXUqGG56v4UZ08TQLLk8BNUS0lXkVaayTddt
	 u2lcP/zMPqcAw==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Donnellan
 <andrew+kernel@donnellan.id.au>, Mark Rutland <mark.rutland@arm.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Arnd Bergmann
 <arnd@arndb.de>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>, Lukas Gerlach <lukas.gerlach@cispa.de>, Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Date: Mon, 06 Jul 2026 10:16:57 +0200
Message-ID: <87ik6sjzwm.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01 2026 at 19:42, Michal Such=C3=A1nek wrote:
>=20=20
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall =3D trace_syscall_enter(regs, syscall);
> +		*syscall =3D trace_syscall_enter(regs, *syscall);
>=20=20
> -	syscall_enter_audit(regs, syscall);
> +	syscall_enter_audit(regs, *syscall);
>=20=20
> -	return ret ? : syscall;
> +	return 0;

That breaks trace_syscall_enter() because the probes/BPF muck attached
ot that can:

     1) set the return code
     2) set syscall to -1L

That works correctly today, but with your sloppy hackery the low level
x86 code falls into sys_ni_syscall() which sets the return code to
-ENOSYS.

