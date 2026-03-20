Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB335BDAF;
	Fri, 20 Mar 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998643; cv=none; b=qNN+BfKc0d7gnI6RxvvWw/160ca+KbQjJcuCjzmcuQB6ueM40BoanlO+iexPrMsHN0T3bkQUzA5YP7wLSEVm274LtbIvedD1dF1pPKqBTAaNbtLFg0RdZHlOKTTva5ZTq+Z0LOZFxRC4g/KX6gvyqF9ckTaYiVjhc5NEt/NTfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998643; c=relaxed/simple;
	bh=/HoHJoQHQdbOo+83COWDJcTQTVJYoTW8MkFU9xIKmUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nSYdZfjrAUoOt/PJ74TyAGYVq0EZ1A0HTI35O+sU6eX2rFmOv7mRlIphXODkhYJbpLtef7lZOJ/TKlBtdgMBgu0mG3WIXDk17k5OIMmuIeUOhzc2kTVZeOBbRrVdcNQrXxlkAOdvPImg9Ve2TnyxZN4CeWAH39qAzkscco05o2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yiTksmqk; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yiTksmqk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dueANSQysHjoI2uUi/CBY7x6RsKVtnKMmUpZG7hlYgw=;
	b=yiTksmqknK0saLurfwWJkiOQPHa/VTOZs+ZeKiSkBIaaFeUkJFx8B7Vf+/F3trYLDKIZHwWHW
	gBl9d9/sgc00KKcpS6Kcn7oAKxNY5+6Ev2oPx6xSesO3cFDzpBJXpx0EKQy8son4+y88IX5rBtY
	wMCvWUd5pDTpJtYIj3bhd8A=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fccRy73k0znTWm;
	Fri, 20 Mar 2026 17:18:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 84BAD40562;
	Fri, 20 Mar 2026 17:23:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 17:23:50 +0800
Message-ID: <b70425a6-83b8-64ce-9d67-1504461c053e@huawei.com>
Date: Fri, 20 Mar 2026 17:23:49 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v13 RESEND 14/14] selftests: sud_test: Support aarch64
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
 <20260317082020.737779-15-ruanjinjie@huawei.com>
 <CAD++jLkpHbZ5rf=D+Az=XiWmDFOdD6MPjEVPBLCf820q1Jef4A@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAD++jLkpHbZ5rf=D+Az=XiWmDFOdD6MPjEVPBLCf820q1Jef4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/19 22:26, Linus Walleij wrote:
> On Tue, Mar 17, 2026 at 9:20 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> From: kemal <kmal@cock.li>
>>
>> Support aarch64 to test "Syscall User Dispatch" with sud_test
>> selftest testcase.
>>
>> Signed-off-by: kemal <kmal@cock.li>
> 
> You need to sign this off since you are on the delivery path.

My apologies for missing that. I'll definitely add the Signed-off-by tag
in the v14 submission.

> 
> Yours,
> Linus Walleij
> 
