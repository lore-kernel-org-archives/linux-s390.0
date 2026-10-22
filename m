Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692290;
	b=U9pLtiUxBEniFSeuL3xfTihqUng0NyGF4ARSzRjF/G5MNk4WvAfdNwHNgxrMo1LNOOB2
	 XpNZ3hKisqo7eJzPI4kVR3qPyuw+Y8LkKcydH6cBzPl4LsAGl9xn/rTFR/ya+2BQwhG16
	 W4hXRzyP5Q5zPFfEzTrVdTERSlm/6FrSLjEm+q4imwBq36Eloz3+Vixs9SlkYpQg6FMc/
	 gaMI2Y88xoTMpQ54Q4GwCYBdUu+UxKX0QwycJSM64YTubEHuxtK0swfHezjly5zR1deAT
	 O/oZAd01uBRJjnJU304qoW5BwAYLBb5Sxsu3laswYt25bL8fVYVPrYZVPdb63nU7Whg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692290;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RhnfvKmfoxy+HUbDsORpInOXf0Z9ck2xlJJLmjkZQrQ=;
	b=wKlFg5x+9IXxaqIqGze0znFrnDDWrdJLKX9zysd/fUOAIj/6I0bTUkeAS7pcyOsF6jN+
	 d13sGMHbPzDSOpXNeCatRTqMSurXUet2tRqZX/y/NyIvPYbpD9AxRd4TeLdY2t+YhsxS9
	 S839MWwjt1pOEmQfN3BbK70eCUlogtRAUhA7+Ht4YoYfQk6biCQIzJhrmJqBFnLhp6hzd
	 6EplL86cYKNQv5biB2InnVQHXtLfwkdwHqwBqKeXwwIUUDH7yvlNx4KZ/Ph/mJL6Nyuqx
	 bvo1FXqD9W95+qWeQhATG+K1MW/OBxdP0YMYMMJZiWgxEcZvQMzgAAnQS9y0H4SNHPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=wS32jOje;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58917606A31B;
	Thu, 22 Oct 2026 18:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58917606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=wS32jOje
Received: from [172.27.3.124] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69MI2jre822700
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 Oct 2026 11:02:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69MI2jre822700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792692174;
	bh=RhnfvKmfoxy+HUbDsORpInOXf0Z9ck2xlJJLmjkZQrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wS32jOjeFWsFEs7/XC2lmhjx+vaso38Aa1yvVUAkT9A1W3myWjPjlKJ97J5iL0Ywq
	 bPF69gGCe7jooHw6vT1puqfAAMWwIenPVsBB0BtjXDHBnYwO13DlDPhjiEozTqjEHM
	 Tnne7bJIubMKnpcLaITiN/m+5GZf8SNZmR76JFs4RsiRgOXjXb7KnOu57Xbk4+jf0R
	 res/2bYXDI5YQACu5N7auw0s2PeA2biV4pFQrygkfChnNdCyphEU5uiDFSgPKPiKVV
	 mrz+yPrxO0ZpIXSlYj8frGR29U2PsHFm2Ceilf5VQYeo3Indd2RWAuBubWzuARjG4V
	 DyvcySggronVQ==
Message-ID: <9d875fab-fdad-413e-9737-6160fac2a406@zytor.com>
Date: Thu, 22 Oct 2026 11:00:24 -0700
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
 <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de>
 <20261022150235.V2CSdtmu@linutronix.de>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20261022150235.V2CSdtmu@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-10-22 08:02, Sebastian Andrzej Siewior wrote:
> On 2026-10-22 16:24:30 [+0200], To Thomas Gleixner wrote:
>> The test could be updated via the hunk below in case the new behaviour
>> is what is expected. hpa made the extension to the test in commit
>> 795e2a023b808 ("selftests/x86/syscall: Add tests under ptrace to
>> syscall_numbering_64").
>>
>> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
>> index ca0eca7b9dced..1435394fba022 100644
>> --- a/tools/testing/selftests/x86/syscall_numbering.c
>> +++ b/tools/testing/selftests/x86/syscall_numbering.c
> 
> Now I notice the fix depends on CONFIG_X86_X32_ABI=y (fails for =n).
> But we want to get rid of it anyway so…
> CONFIG_IA32_EMULATION is not affected (with the fix).
> 
It would be very simple to probe for by issuing a simple system call like
getppid() with the x32 bit set.

	-hpa

