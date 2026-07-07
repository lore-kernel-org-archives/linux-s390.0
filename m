Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1D41F7CE;
	Tue,  7 Jul 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433737; cv=none; b=u+lIZn2Z6RUXqPYg3CPR8tXhP43YtTTe8TjYesfMxKuB8e6iaavg/k6YwDPBS8A6MkZsJGvJAs91hMVmfwOsURru/xVf9eP3s+4WvHY6vGXIyM/ijQVq6UzkfZ3XwP2FSOO59AauvifxxqlUTLLOl1gGhhEPUTzt7BbQdsxVo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433737; c=relaxed/simple;
	bh=IinY0qicpix8YaJZbueQ0ZMS6TH6C9aVow2ztmvUxgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioumIPLVU1uo+/oi0Lub/8dIB6GHb1+LKNE7jZgiP7FizxMU53y51zu7vpIzeOfp12CS8/v1uyphhsTlx6STteRSeWBuR5OgJ/yKhdvdrlIwxpgcLbPVAjjEK6R3cq62gabxZdGJDVda6SWpP/pD1Wk0N2z0oJihx8X5yznJjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LyOTCEzl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LyOTCEzl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E45351BB0;
	Tue,  7 Jul 2026 07:15:30 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEF93F7B4;
	Tue,  7 Jul 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783433735; bh=IinY0qicpix8YaJZbueQ0ZMS6TH6C9aVow2ztmvUxgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LyOTCEzl2lnONxDyc5YgaBVzkQQTQt8ZMCnf0rfSax4/Wh4a3/jy5UcOfHKZmIpCd
	 0JK0/K1vtUPTZHNaeJXMR1zwsZF41NYv8fSGFE5DnXecvjNTDzStlfxEvHuMh4fFmB
	 7HXVfvV6cUYysmr155+Ry6uasnPzrKLfjL2xY65Y=
Message-ID: <f6e8b4d4-8b50-4cc7-b264-ae39929c619a@arm.com>
Date: Tue, 7 Jul 2026 15:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
To: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Thierry Reding
 <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 Chun Ng <chunn@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck> <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome> <akftuw9NyRy36fXA@willie-the-truck>
 <akuvyu1Pq0ZVMZV0@orome> <akzikTrmhMsvkNVY@willie-the-truck>
 <b0a1bdd7-46ab-4025-8775-c9273892444e@arm.com> <ak0A6eLp0Pw8iKK0@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ak0A6eLp0Pw8iKK0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2026 2:36 pm, Mike Rapoport wrote:
> On Tue, Jul 07, 2026 at 02:17:29PM +0100, Robin Murphy wrote:
>>
>> Given the precedent of memblock_mark_nomap(), as long as the reusable
>> reserved-memory regions also get split into distinct memblocks, then it
>> seems like in principle we ought to be able to give them a new
>> MEMBLOCK_PTEMAP (or whatever) flag which could then be picked up in
>> map_mem() without needing to override force_pte_mapping() globally?
> 
> Please don't. _nomap() caused enough pain.

Indeed I was there for pretty much the whole pfn_valid() saga :)

Bad example maybe - in this case the only actual similarity to nomap 
would be the fact that it would also be set by the of_reserved_mem code 
based on what it finds in DT; in all other aspects it should be 
functionally closer to something like MEMBLOCK_RSRV_NOINIT, i.e. just 
carrying information through the mm init phase, then ceasing to matter 
at all once the linear mapping is done.

Cheers,
Robin.
