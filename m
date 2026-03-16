Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07233ADA2;
	Mon, 16 Mar 2026 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654703; cv=none; b=BKy+yHLlJJhr8rQLsjRu09+gxDkM7a91FPmSnehBWyPEL99ZolYQzAkrTUUm4WytwTPbExRraASUaWny6T368WPXor/KxLJ1syxN1yz75hqnjvPNUlx1Z5wA4J7lSJZjoa3MSBJOdNZ2VY260H8Zb1bjCtVh8N2fJ7JRdxkZzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654703; c=relaxed/simple;
	bh=vlPGwGwPhF0cwnp7ltkdbPiL0mtl2qAfel+dPE5bvWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KIOXARn9DXgHJrkF/M5Z2Lnsu2q5jd1rmQ4Blz6Fk7PanIdXohdSWB+ggwzbXfBP+vn9lP3x0RGaA2t3AwojlzASRW2gjI08+kYpKSbTvNrz3RTQPzl8n56tT7K0w4071UtStV7f9Zr/I35XgmQh/pHQdJHO7YnE55EaxyLNaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KKdBc+DG; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KKdBc+DG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=balSCgYcEbAY56RSuhkaZ0aLc2AhLdhLQy1g8WgNbj0=;
	b=KKdBc+DGmyUhCo271f64VAYuX3SbUGzK2OPqk0EYZzDpk69J7P/Fej2zG8g3t0eS35Dw/yMGj
	vx/vL7s2VNgucXFKIGc46t0PT34JlesQ3V+5TE0yR9eueuvodEj65SDAT5KfG4wmlXyCMhXMGR3
	5j68uwwQ6TKiWtMOXcvNY4I=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fZ9Ff3Fz3z12LKJ;
	Mon, 16 Mar 2026 17:45:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F1D424056B;
	Mon, 16 Mar 2026 17:51:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 17:51:28 +0800
Message-ID: <b750c5eb-f8ff-0d19-f722-89785c096d13@huawei.com>
Date: Mon, 16 Mar 2026 17:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v13 00/12] arm64: entry: Convert to Generic Entry
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <arnd@arndb.de>, <shuah@kernel.org>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<charlie@rivosinc.com>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<thuth@redhat.com>, <andreas@gaisler.com>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<jgross@suse.com>, <mathieu.desnoyers@efficios.com>, <yeoreum.yun@arm.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <akpm@linux-foundation.org>,
	<reddybalavignesh9979@gmail.com>, <richard.weiyang@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
 <20260313115700.GA2872@noisy.programming.kicks-ass.net>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260313115700.GA2872@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/13 19:57, Peter Zijlstra wrote:
> On Fri, Mar 13, 2026 at 05:47:26PM +0800, Jinjie Ruan wrote:
> 
>> Jinjie Ruan (11):
>>   arm64/ptrace: Refactor syscall_trace_enter/exit() to accept flags
>>     parameter
>>   arm64/ptrace: Expand secure_computing() in place
>>   arm64/ptrace: Use syscall_get_arguments() helper for audit
>>   arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
>>   arm64: syscall: Introduce syscall_exit_to_user_mode_work()
>>   arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
>>   arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
>>   arm64: entry: Convert to generic entry
>>   arm64: Inline el0_svc_common()
>>   s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
>>   arm64: Use generic TIF bits for common thread flags
>>
>> kemal (1):
>>   selftests: sud_test: Support aarch64
>>
>>  arch/arm64/Kconfig                            |   3 +-
>>  arch/arm64/include/asm/entry-common.h         |  76 ++++++++++++
>>  arch/arm64/include/asm/syscall.h              |  19 ++-
>>  arch/arm64/include/asm/thread_info.h          |  76 ++++--------
>>  arch/arm64/kernel/debug-monitors.c            |   7 ++
>>  arch/arm64/kernel/ptrace.c                    | 115 ------------------
>>  arch/arm64/kernel/signal.c                    |   2 +-
>>  arch/arm64/kernel/syscall.c                   |  29 ++---
>>  arch/s390/include/asm/thread_info.h           |   7 +-
>>  arch/s390/kernel/process.c                    |   2 +-
>>  arch/s390/kernel/ptrace.c                     |  20 +--
>>  arch/s390/kernel/signal.c                     |   6 +-
>>  arch/x86/include/asm/thread_info.h            |   6 +-
>>  include/asm-generic/thread_info_tif.h         |   5 +
>>  .../syscall_user_dispatch/sud_benchmark.c     |   2 +-
>>  .../syscall_user_dispatch/sud_test.c          |   4 +
>>  16 files changed, 166 insertions(+), 213 deletions(-)
> 
> AFAICT arm64 is still using exit_to_user_mode_prepare_legacy() after
> this. This cannot be right.

You are right. exit_to_user_mode_prepare_legacy() should be replaced
with irqentry_exit_to_user_mode_prepare().

> 
