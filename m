Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD0331EB6;
	Fri,  3 Jul 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070845; cv=none; b=lkt3B5Vrs1W7uns9h+r6eP5Bd0etrmXrYubO0Gx+5dwF5EYL0nDMQUtRk1iSVpVe1/AvctHELRoiZkZ97hu/r9dU2rdRcYOtFp1+f2ZfNpzerEfBu36/4nLfPWs3YcFe8bZWo4yTvx4bUzHwC8xFmK8+/kl88gb3JBpZrNwLCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070845; c=relaxed/simple;
	bh=QuasMf+Z9Xub/CzQGz8vCZq23/KL14xhcuPnFpaaICs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J8uHYI0D7IYqXtPJEqnnD2ZKPORYBtpFH+6VfsnbrP6x93a5gSAjY7i6bceLzBIh8o3BUT7y5mQkHc+s9eOH4s49pTg0eYin6ZVvnj7IFgkcTeHE27XL3AIQQovBjLBIWaFjkxDulDrp0uCHdP2Spm9Z+q6cTt8YpnUkAKaKWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OczjT20v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OczjT20v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9809D1F000E9;
	Fri,  3 Jul 2026 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783070844;
	bh=QuasMf+Z9Xub/CzQGz8vCZq23/KL14xhcuPnFpaaICs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OczjT20v15qvKEkXq5ZHLpZYNZQbovIf6GEuPtND2QuFezSfQYQeZgytKgqGJBzBr
	 B/jp4SWOj8u567yywz+pCgFHT+1jxob9zbEppMKh6/CEdrWFR/R55FZPUnta67mUb+
	 m3TbZnSVzp0CFisk1WJPySMlAQjUMxUqwWaMnBMsgJO+20nwPVsHNeNOf4yF2r2KpS
	 j3CHRJ6QYQa0gaj/f3FSiryAtMLoKRmQ4vEf+vp5e8tYaIU+a3OkLLl9qtKy9X+TNj
	 EsAtb4Bwg5hiVNKlW+NG6+ZS5AuqKREn5z6ilhF+RiuFF2ddQJWJzDmlhoNddH2HvW
	 KKjExXgWni8bA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Andy Lutomirski
 <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun
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
In-Reply-To: <yt9dwlvca8rn.fsf@linux.ibm.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
Date: Fri, 03 Jul 2026 11:27:21 +0200
Message-ID: <87ldbsmnie.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 03 2026 at 08:26, Sven Schnelle wrote:
> Thomas Gleixner <tglx@kernel.org> writes:
>> It's less than obvious and I have no objections to clean that up and
>> make it more intuitive, but I still fail to see what Michal is actually
>> trying to solve and what the magic flag is for. If s390 requires it,
>> then that's an s390 problem, but definitely x86 does not.
>
> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> used for both the syscall number and the syscall return value.
> That was a design mistake early in the begin about 25 years ago, but
> it's ABI now, so it cannot be changed.

Cute.

> When seccomp decides to skip a syscall, it write a return value into
> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> returns this number. If it's negative all is good - the 'if (likely(nr <
> NR_syscalls))' conditiion would just catch it and skip the syscall.
>
> But if it's a positive number, the code cannot distinguish whether
> that's a return value or a syscall number.
>
> So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
> entry. This flag tells the syscall code that a return value was set in
> ptregs and the syscall should be skipped.

You also could have added a 'syscall_ret' member to pt_regs, operate
on that for the return values (seccomp, syscall...) and swap it into
gprs[2] right before returning to user space.

> I'd like to see something like the change from Michal going in - cleaned
> up of course. It would allow us to get rid of PIF_SYSCALL_RET_SET.

I have no objections against cleaning it up and making it less
convoluted.
