Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D532571DA;
	Mon, 31 Aug 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206494; cv=none; b=BkdMh9+Qt7oGMHDByyQo1mw//S3wg/LhNsianOPXgB2JL8ujFIdhXgxqzlyjI36ESi494hFC/4beXN7HowDNB/A0scyM38c5pRDRQk3qpUI1KWuIR0ZA6QFeD9pdwPNi/eSbndzp1Zzfoc0NwTxTLq/IieRSogA8r+naDHQ3Vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206494; c=relaxed/simple;
	bh=OeDDnqo1IRQEK4Js5nZgXclVX2MFMUyaSHTgtYCOrSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njkYA1k+ZugF+FEXl7H41FdDK//v8WgsTMQu88pQDcZWzSDn3lJOgnkwH5QLJYed6ubNo9OJFvzD+JJEYecctOiGVSzp6O+7EHGyER2c1R45arb0xRwhryBI1yGZ4tcyHVpe6uAgv5L72yQtj2UFgX6GVzupetlhW4qRiAgctho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hRWHGA+w; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hRWHGA+w"
Received: from [IPV6:2601:646:8081:8d71:2faf:8150:30da:aafd] ([IPv6:2601:646:8081:8d71:2faf:8150:30da:aafd])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67VJvbar3264483
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 31 Aug 2026 12:57:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67VJvbar3264483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1788206263;
	bh=Lfk4Zm0mu1VaJNyCW+feQLM2PduJnrH08+Q8uKNAglM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hRWHGA+w8FeyeULwEDoEDUDPGkwf8JT2eZmPRRthmhsNz9HWOb7HiXCTZLLUmuztp
	 lWRv7ug1Z+kxGR18u2FB1NAFu/6cVMaURG6BetJiHKBnIMtH9EfefRvmdaf5cQcfWS
	 Iv6R5AMN9t7OAQ114p39WCAynQY5oir3FFMoBbYdgUDXZtV4B07Wsr3e2OhubFmvQs
	 ktT4EOmqNjonvu8hUPE3i1g0T9wDBDboBsSqe9LwY819N+bvUhSesPS4zzwQuLkCru
	 dSZCFGqC+rA/gs0WgODW7ZBr87rVZStGsxS6+U65Nf/RVAnAJDMEX94B5D/OKkRTEH
	 BWNnKAFiy16zQ==
Message-ID: <1238a07e-ce04-47d9-b8ac-8b7f557b401f@zytor.com>
Date: Mon, 31 Aug 2026 12:57:32 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <ed8b99e6-4d90-4622-9d43-451bf6a8db2c@zytor.com>
 <20260831085056.34274A00-hca@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260831085056.34274A00-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-31 01:50, Heiko Carstens wrote:
> On Thu, Aug 27, 2026 at 03:22:35PM -0700, H. Peter Anvin wrote:
>> This isn't a hard thing to solve in any way: replacing the pointer argument
>> with a two-element structure return would do the trick. As far as I know,
>> *all* architectures that support Linux support returning structures with two
>> register-sized values in registers.
> 
> That is unfortunately not true. The s390 ABI defines that structures,
> regardless of size, are returned in a return value buffer allocated by
> the caller.

*Groan*

You guys should use an improved ABI for the kernel like i386 does (different
from the standard ABI used in user space)...

That being said, perhaps s390(x) isn't affected by the underlying problem, and
passing a pointer to a structure isn't any more expensive than passing a
pointer to a variable...

	-hpa

