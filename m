Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CB7484
	for <linux-s390@vger.kernel.org>; Sun,  7 Apr 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476202; cv=none; b=tY7zIu0nEEq+5XbyVG0iaSMllmeHmG7WJxUhEmK5l3ZJ7gswHt9b3AdQkgyjAYCSFP1JCpMjLpzx/kg216i1YeRFxomTwrwS5IeLyIHoeDaMWt/l4KW/VEiXnJrvrgWrRauaBMcESydCuP+mcAiggebIhskr/Y8fnE7OO2qFqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476202; c=relaxed/simple;
	bh=G2yXjWdg3pJnxsnntQWfuPvLSRSxp8WlVyEALB8Zy6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lvO4gz1GHyKY+eoeh+YDEj0sPOAHXndVhUEYFhIAc+0SW5O/16VQVE54xWCofjD0SKeDY+8kzF9ou34HOXXI4feDaCj86E/KZ7n19nyKX03fMP1F8z5OLXwLnTsNBaeZnZSjIpFGwEAVEtvhxdNLepkYqJk9upbw35mOt2rSFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VC47C1yhVzwRPw;
	Sun,  7 Apr 2024 15:47:03 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A70414010C;
	Sun,  7 Apr 2024 15:49:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 15:49:54 +0800
Message-ID: <4d45fffc-877a-4ad1-ad02-a33341e467e7@huawei.com>
Date: Sun, 7 Apr 2024 15:49:53 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arch/mm/fault: accelerate pagefault when badaccess
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <surenb@google.com>, <linux-mm@kvack.org>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403134539.fde3a6c594f2d88409be30ed@linux-foundation.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240403134539.fde3a6c594f2d88409be30ed@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/4 4:45, Andrew Morton wrote:
> On Wed, 3 Apr 2024 16:37:58 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> After VMA lock-based page fault handling enabled, if bad access met
>> under per-vma lock, it will fallback to mmap_lock-based handling,
>> so it leads to unnessary mmap lock and vma find again. A test from
>> lmbench shows 34% improve after this changes on arm64,
>>
>>    lat_sig -P 1 prot lat_sig 0.29194 -> 0.19198
>>
>> Only build test on other archs except arm64.
> 
> Thanks.  So we now want a bunch of architectures to runtime test this.  Do
> we have a selftest in place which will adequately do this?

I don't find such selftest, and badaccess would lead to coredump, the
performance should not affect most scene, so no selftest is acceptable.
lmbench is easy to use to measure the performance.
