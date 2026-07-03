Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982F36A341;
	Fri,  3 Jul 2026 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111967; cv=none; b=fWJeNc/ITi0T/TlAs2jIOubPQg3oDMaIaAdUBk5w9iAeKEi7Mj2GpdLsC+qk6fTCVir3t30iI5kJuIV31NOmSc8EUgUHK/W71boD7kNkXlApZ1BRXgCcWTtntqILcCitQHfQGSRVgRQhj4UeCNUuBbyQxJfAH8Rqk4+xEKsTPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111967; c=relaxed/simple;
	bh=xnBU3ce/vpLN9V3n2dw5RmzeomvK81+Van+F8Cle4zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c71j+n+SVCcJnTphP52WkImR0PatWcLUaLm7TEVP3d0bbV9o/xElRj/xyCJmD0dr16GyRBYIB0Vulc2mIK8UHQz8HkMfoEjx/TYoWDAJZ/6LFdSfEWYdDFQLPn6OrbAYSUxrjz8/xNs8yn7W4rLMsQLGSrmMRiQHEOoFDEwQSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/AEFhD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/AEFhD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A6E1F00A3E;
	Fri,  3 Jul 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111965;
	bh=qc6RQIMJ3TCgtwMlpFywp2lkPnh2VJAI6hIxptvIyMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m/AEFhD/QQMVr60LVSSrHBJhZzSHloaCLPk21mBJcgCOInHXk9skqaY/SzJJ84tEX
	 UmT6M2g7SmZe+Xfl7u66KmHjHFowNBAw9iuDKrQPpkA0d+AKOFoNGiI4ScRdGq9tzV
	 5Bw71e6tMbrrNqTc7h68y+P8wFXYypmrKhsg4IoUL3B2t/kFt2ZfrsDK6qF5Axq7m+
	 0X+YpoR5DWk7RItGPbLuh218SieWYIlmdker7qyk9wbsyvgoZgAjV4Uu3czl1MVLAt
	 DcAB4UvUtBhMMozkhoRv21B/k0znEvzlBngIXWCHw9H0yTbipW6aseVsPvTnj3WZDs
	 DRMEjZMu/EqhQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Mark Rutland <mark.rutland@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com,
 ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
 richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org,
 wad@chromium.org, thuth@redhat.com, ada.coupriediaz@arm.com,
 linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
 james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
 yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de,
 thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
 andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org,
 x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
In-Reply-To: <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13>
 <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz>
 <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
Date: Fri, 03 Jul 2026 22:52:43 +0200
Message-ID: <87echjlrs4.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03 2026 at 13:59, Kevin Brodsky wrote:
> On 03/07/2026 12:27, Michal Such=C3=A1nek wrote:
>>> If we're changing the return type, it might be worth renaming the
>>> function something like:
>>>
>>> 	seccomp_permits_syscall()
>> Then not only it is clear which way the boolean value should be
>> interpreted, it also pervents the accidental inversion of existing
>> calls. Overall great.
>
> Totally agreed, if we have the opportunity to rename a completely
> undescriptive function name like "secure_computing" we should take it.

Absolutely no objections from my side on that.
