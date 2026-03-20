Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970031A061;
	Fri, 20 Mar 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998937; cv=none; b=aHv5zoKhsfSqYiLNN9zB1f2FLkDLMy9HJ1hS12GqRdTioNnbjSaOyDLSIVUKQsbN/M5RNe5P+b1gZeEGMAWFg7FnfqGwWKcO9apwdw7VxRzAz2FF0a/cbbDXNstoI6ZeE8/g0i46HCsa0MwQJViQE2fhaaLnwHyhQXcbv3/y2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998937; c=relaxed/simple;
	bh=dTAvufztQKo3Sa181iPB+4E1k6ZRfEDVnRafQ/wm0Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eLB4UC33L8Q9gc/K5OwQ03jLwL3YbAxdUy0VMkSZKsHqzDfIcSNArweM8piyGqIvAxfjn1xyGBkBMIsdkdu3QqVYT+JMI0U92jYmZNw7yTJXPQATQcXzDFlgJbdebA+cxyO1EHdu12QX1810teoJQHxp0lo9kFQEHCTwHMxbBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a/UyDyL2; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a/UyDyL2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HlNFJC4wyGaCNDbE98fPlMM3Ufwe5S0+cI7tu1uEJCg=;
	b=a/UyDyL2Bn1j0uSZRF35r+WgLIIXko5euO/MgsRomtz7PkvhYcAMpRt4RpMou2R1cLGVef72P
	oLDoUjzWHxESBFel09sC55R6dI9nXOhtB6I3mYne0VRi0BxIm+V9XsV38zbGSfcc/muuQk5lZZa
	E+o+F7TA36OMVKh6hngXzgE=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fccY15r6kz1cyV1;
	Fri, 20 Mar 2026 17:22:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 81A404056C;
	Fri, 20 Mar 2026 17:28:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 17:28:44 +0800
Message-ID: <181ef8b3-dadb-bbc1-7779-a875ac7bef05@huawei.com>
Date: Fri, 20 Mar 2026 17:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v13 RESEND 00/14] arm64: entry: Convert to Generic Entry
Content-Language: en-US
To: Linus Walleij <linusw@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<deller@gmx.de>, <macro@orcam.me.uk>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <thuth@redhat.com>, <song@kernel.org>,
	<ada.coupriediaz@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<liqiang01@kylinos.cn>, <ziyao@disroot.org>, <guanwentao@uniontech.com>,
	<guoren@kernel.org>, <schuster.simon@siemens-energy.com>,
	<jremus@linux.ibm.com>, <david@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<edumazet@google.com>, <kmal@cock.li>, <dvyukov@google.com>,
	<reddybalavignesh9979@gmail.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
 <CAD++jLmai3mxCr6EYzfrirLfV_RNaun-QSr-ZzWL0j1ZT2cCpg@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAD++jLmai3mxCr6EYzfrirLfV_RNaun-QSr-ZzWL0j1ZT2cCpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/19 22:35, Linus Walleij wrote:
> On Tue, Mar 17, 2026 at 9:20 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Currently, x86, Riscv, Loongarch use the Generic Entry which makes
>> maintainers' work easier and codes more elegant. arm64 has already
>> successfully switched to the Generic IRQ Entry in commit
>> b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"), it is
>> time to completely convert arm64 to Generic Entry.
> 
> Looks good to me, except patch 14 that needs your Signoff.
> 
> Perhaps it is best if patches 1 thru 11 are applied separately
> to the arm64 tree and the remaining patches either postponed
> to the next kernel cycle or applied on top of an immutable branch
> based off v7.0-rc1 from the arm64 tree?

Thanks for the review and the suggestion on the merge strategy.

1. Regarding the Split: I agree with applying Patches 1-10 to the arm64
tree first. These are foundational and ready for inclusion.

2. Regarding Patches 11-14: I am fine with postponing them or using an
immutable branch based on v7.0-rc1.


> 
> Yours,
> Linus Walleij
> 
