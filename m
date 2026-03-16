Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826D378812;
	Mon, 16 Mar 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649831; cv=none; b=khpOehCFCYHt20I2ESXu7AKBzSzzY4MKKw6d7tncLA2Ba/kkju82/Bd2uRdLICw9kuCZJ83FBBG7aTpRY/CXE+50NPhkIdPWJXacd2x3drOaCrthhOYEhNkJZ/REj4W1gGGlGkrIVHQkoGrreJyRHE9v7OAsZPH976eJMCzklW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649831; c=relaxed/simple;
	bh=qqFWtgtU0qGaIRVG0qMMCPejYzDY8YT6jaOvKCehBws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eEiIiCCgOLha2Q0D5XijQt2DXm3DHomO4ITh8OF95GrqAnr8BwOJOLoFcc8pIhQASR2BVwqnubSZ7PPPofgQECt6JTK9rajn+L+i4FyefuAgwbAC3yF/tYCHe3e6Nes1t9X3WG42hqhgRwq1W+C6hBNnaXfMv9VQA1zzZHsbNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kdN/AfpZ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kdN/AfpZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KKbPsDAO7LVmJHxlSzEBfeRUi2Nm7cblhvtLj41WeSc=;
	b=kdN/AfpZHzSBWHHnCUnfqcNeRn1Y/Ti1cCp31akA99MbW27C46+M+yFh4UoVlwWbikcPlzB3/
	fttUjkdYCbO7/xktrNNsfIedMKs84ZayJMRR1X8n8u/Y8ESNA4PLnEpzLQoidyveVf9eBSUiI/5
	McuUwxrVB59tOXLe1Ip8wWg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fZ7Sl43qDz1K96p;
	Mon, 16 Mar 2026 16:25:27 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9389940563;
	Mon, 16 Mar 2026 16:30:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Mar 2026 16:30:20 +0800
Message-ID: <b541bd3a-7407-d743-70de-f9665479dec2@huawei.com>
Date: Mon, 16 Mar 2026 16:30:19 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v13 11/12] arm64: Use generic TIF bits for common thread
 flags
To: Heiko Carstens <hca@linux.ibm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<shuah@kernel.org>, <kees@kernel.org>, <luto@amacapital.net>,
	<wad@chromium.org>, <kevin.brodsky@arm.com>, <charlie@rivosinc.com>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <ldv@strace.io>,
	<anshuman.khandual@arm.com>, <song@kernel.org>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <ada.coupriediaz@arm.com>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <liqiang01@kylinos.cn>, <thuth@redhat.com>,
	<andreas@gaisler.com>, <schuster.simon@siemens-energy.com>,
	<jremus@linux.ibm.com>, <jgross@suse.com>, <mathieu.desnoyers@efficios.com>,
	<yeoreum.yun@arm.com>, <kmal@cock.li>, <dvyukov@google.com>,
	<akpm@linux-foundation.org>, <reddybalavignesh9979@gmail.com>,
	<richard.weiyang@gmail.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
 <20260313094738.3985794-12-ruanjinjie@huawei.com>
 <20260313101022.13729C56-hca@linux.ibm.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260313101022.13729C56-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/13 18:10, Heiko Carstens wrote:
> On Fri, Mar 13, 2026 at 05:47:37PM +0800, Jinjie Ruan wrote:
>> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
>> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
>> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
>> them locally.
>>
>> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
>> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
>>
>> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
>> combined with the generic entry infrastructure (already used by arm64).
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/Kconfig                    |  1 +
>>  arch/arm64/include/asm/thread_info.h  | 62 ++++++++++++---------------
>>  arch/s390/include/asm/thread_info.h   |  7 ++-
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> 
>>  arch/x86/include/asm/thread_info.h    |  6 +--
>>  include/asm-generic/thread_info_tif.h |  5 +++
>>  5 files changed, 38 insertions(+), 43 deletions(-)
> 
> FWIW, I guess you want to do the same for loongarch was well?

Good point. I will include the LoongArch changes in the next version of
this patchset.

Thanks!
