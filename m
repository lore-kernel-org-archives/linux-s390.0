Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429DD33E36D;
	Tue, 20 Jan 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910510; cv=none; b=Ko+YEUs3jcqMQkjpacGIJtDBLiLkUaBhVEGGbSdNMPz+Lqf0ST31IWSpSsmA3g2rrBCYU7fO95QuB04fqs413//SJzKFe+QG7ltb/hAaz2i4HFNS7YDBgj7hqQPwoF0K6uD6+x9rqa5hHZJ0vDq9jzSIB3kIIuU+hS/R7K14KH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910510; c=relaxed/simple;
	bh=A/88BX6WHXgwt4c8NHPI2rYuIJ+ge6nx0nDRL1TMRoY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g9yI90xpLhEEZPXoskQMeeVASpg1jDACCxQAto3d7qK+JwOxm+YvpYLTkKoOHqzDqDMfXWO/KrSRuD2lvseg9ujoGeh9nfNFrZS3OIXJ713QEtuJ43d9zJVdCnC85lunGnRPS9c+IrmJXkqPbFpdWtjTWAcQgTJrs8JZES6C/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=c9U1FUOf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c9U1FUOf"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KC19LM3649757
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Jan 2026 04:01:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KC19LM3649757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768910471;
	bh=KO8ul0X7dWGEIi2sHNkJt/YDkwbyDctLAsFNAcFTbiw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=c9U1FUOfBmmQ/Lt/dqq7lwtswx8Ydv2sG16JfNt+MIj6GOHWB7sSAYU2BPyzbXmAD
	 kf4Fgl1n4jry+C/ZK3YjgQQxCXjTflEa/K2eEtaXpDcsCYkTGjpdKFSfht72XkOl+J
	 vuHYWgx2i9gNBbWjEC0jExFX7+iMHVDFkULU0FWzHNal3/ERclr2XGt4TOaTtvMLD4
	 E5BXqwo35txoQ7wY5vohqn4KyYsPAe6PoGd+o5VoAeXhsnj/zJU351+iwbGYyMpJbD
	 JkgYGsL8oYd2TYXNpRFsQSV5XX54sBcO3gTiKL9SgGdy+lYua5rgbBwv7ujdG4SEdP
	 YXu7y2Qw+QbAQ==
Date: Tue, 20 Jan 2026 04:01:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_asm-generic/bitsperlong=2E?=
 =?US-ASCII?Q?h=3A_Add_sanity_checks_for_=5F=5FBITS=5FPER=5FLONG?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260120100331.1f57aa99@pumpkin>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de> <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de> <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com> <20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de> <f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com> <7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com> <20260120100331.1f57aa99@pumpkin>
Message-ID: <DCF1A7F6-727F-4094-8DB9-0B566D0970BA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 20, 2026 2:03:31 AM PST, David Laight <david=2Elaight=2Elinux@gm=
ail=2Ecom> wrote:
>On Mon, 19 Jan 2026 22:39:53 +0100
>"Arnd Bergmann" <arnd@arndb=2Ede> wrote:
>
>> On Mon, Jan 19, 2026, at 22:12, H=2E Peter Anvin wrote:
>> > On 2026-01-19 07:39, Thomas Wei=C3=9Fschuh wrote: =20
>> >>>
>> >>> Do we actually support any compilers which *don't* define __SIZEOF_=
LONG__? =20
>> >>=20
>> >> When building the kernel not=2E I used this pattern because it is us=
ed
>> >> further up in the file=2E There it makes sense as it is actually a u=
serspace
>> >> header which needs to support all kinds of compilers=2E
>> >> But this new check is gated behind __KERNEL__ anyways=2E=2E=2E
>> >> For the next revision I will move it into the regular kernel-interna=
l
>> >> bitsperlong=2Eh=2E That will be less confusing and still handle the =
vDSO build,
>> >> due to the way our header hierarchy works=2E
>> >>  =20
>> >
>> > The point is that we can simply do:
>> >
>> > #define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)
>> >
>> > =2E=2E=2E and it will always be consistent=2E =20
>>=20
>> We have discussed this before, but decided it was too early to
>> assume that userspace compilers are recent enough for that=2E
>> According to godbolt=2Eorg, gcc-4=2E1 lacks __SIZEOF_LONG__ while
>> gcc-4=2E4 has it, as do all versions of clang=2E Not sure what other
>> compilers one may encounter using Linux kernel headers=2E
>
>For instance MSVC doesn't define __SIZEOF_LONG__ or __x86_64__=2E
>Unlikely to be used, but=2E=2E=2E
>
>So you can use __SIZEOF_LONG__ if it is defined, if not hunt for
>something else (possible just fixed in the installed headers)=2E
>But in the latter case (at least) a compile-time check that the
>value is correct makes sense=2E
>And that can be done portably - probable with a negative array size=2E
>
>	David
>
>>=20
>>      Arnd
>>=20
>
>

If it doesn't define __x86_64__ it isn't API compliant at all, so it doesn=
't make any sense to talk about it=2E=20

The most portable way to do it in standard C is to use <limits=2Eh>, but t=
hat of course has the header pollution problem=2E
