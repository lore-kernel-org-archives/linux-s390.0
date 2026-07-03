Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0F3B14C3;
	Fri,  3 Jul 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071283; cv=none; b=AkFu9O9PfX/kmNJW3xHmg4XRPrWtDU4qYK9CmKi8j7wp7biXlKDpP3jAylJsacX3RxyzXAzS2KEUr9MwOug0T4DYV9cYK4/TzOJdb+bkE/yMKA4/+RupRZeVrDFLoM3JOz+2ebWlks6SdtC10XnF3VchEJDfy0oLyNU7wavdr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071283; c=relaxed/simple;
	bh=4zwQCRVYGR5FArRVyRpUCs5bDBdQqJdKupIYXwMv/aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BD333vYTeYI2+x/m8D9oZt+3M2PGX82Osp4g2NZGjWZM+ZiCMODiSwXxw4GbI46dyVOdwIOe1SLv+uwXDrQDH0XEq+X5hF031UqlZsxcquZ4SwqAiU8Q1dsNzKnJM9mX6KWIP5aTLipSLk0rygDhlLsxZRZoEX7dlUcI4zdnAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4JQ6Zc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4JQ6Zc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B011F000E9;
	Fri,  3 Jul 2026 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071282;
	bh=nMY8UZyvI/HF5Rdv1bSkWyNbGRbx1G27seV2ZaZUbN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K4JQ6Zc8TPguGmkEN1toHL2v5PXz61h6EWt7zZ8rNB04Nv/OFyWtRbIK7/fVYv1YG
	 B2iavueYbkcwMfN5GGnSDuP3/Y2ypQOlduP9C9EH0oHedTCI4eVb8GN99XZ7K3gk2U
	 mKiWTX7nFzp9NihhXbgvqGtv6EZe36azyYLF8fKo4DpnPtV9M5EwlFIg4kabWNJ5dR
	 ivYvj8LWnh2+s/7LGPHBUsOszJO62d4z94v7KFjNFI2CueHXILKryvycsxAeIyGtSG
	 s98h3rggiuosCqsSmQ0MRnvTtW2Y2rrZ6VdGUVtB9Peojv9MYzNR0W2Zxz87hN6G4/
	 UM7w31V/ebUew==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
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
In-Reply-To: <akdqlO0eJ6jKH-wU@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <878q7tprau.ffs@fw13>
 <akZPakNl6JT_jgGd@kunlun.suse.cz> <87jyrdnmrh.ffs@fw13>
 <akdqlO0eJ6jKH-wU@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 11:34:39 +0200
Message-ID: <87ik6wmn68.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03 2026 at 09:53, Michal Such=C3=A1nek wrote:
> On Thu, Jul 02, 2026 at 10:45:54PM +0200, Thomas Gleixner wrote:
>> > When the syscall number was -1 to start with it's not possible to
>> > determine if the syscall was fileterd from the return value. s390
>> > returns the filtered state in a flag it sets on the regs structure,
>> > avoiding this problem.
>>=20
>> What needs to determine whether the syscall was filtered or not?
>
> The code that executes syscall_enter_from_user_mode() needs to determine
> that.
>
> After syscall_enter_from_user_mode() returns the syscall needs to be
> executed or skipped.
>
> 'Executing' an invalid syscall boils down to setting the return value to
> -ENOSYS.
>
> But if the syscall number returned is -1 was the syscall filtered and
> the return value set by syscall_enter_from_user_mode() or should it be
> set by the caller to -ENOSYS?

See the explanation I gave to Peter. It's conclusive, but admittedly not
intuitive.

The fact, that s390 decided to have the syscall number and the return
value in the same register is a different problem, but as I pointed out
to Sven it could have been solved completely without that flag.

Thanks,

        tglx
