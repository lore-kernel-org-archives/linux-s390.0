Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958577;
	b=fSlpumf6eJ1blNe0GZEma4fmE112Zq6OdO+nfshAODUaiw2p9Sf3mJbG3p+rahTy1iGn
	 EmkPP/q73mb5QynnXazIzd/8/p9ZQPKLvQGynohZEF1KxE0RpXmkdsDwM+Y7clB2Bsuim
	 JDf6rRLIEVdyShTIci5PXGKQ++d8UINQ9ztCwuVFHXBLKFhruat30xkOl8ff58AG+rwNi
	 zHh+NcvRdlIP3SmprmDrxJ1oV5QBRSIlTHix4Si9oaUt6jkoAlcufQ8thLkNqKhhB+Ued
	 ueC0058PF26vK9iNqT01BG3GKJnAk0v+Pol508qGgWLgxaIOKl4fSpzXteNE5B205eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958577;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6DU4XzSpmp/n4/D9eXag/+qPRamb2DqfAVopLVqvQOo=;
	b=xqvPU8KvKmUaK107lbPoAHpGtTQ3ekjF5KGbrWgSNjBJoY3vweZy58h3m9TfMapdPUWF
	 QvuOQiWfndGdqc8r9cIPoAMpQJ2u7JWUNgeLw5N3EAZB8ZQuchyyGRZu4QS9/qH+c+9d7
	 ImSGwtTh97JKj80/ll/DASieBbA5u+THyKkj9pk4M3s9K9bpUy8aVYrmc/2dmNvTfPerj
	 MBgnTk8r6fIcXOwopkt7zbVKFS5ZEfXV1AYdbRaLvRGRtcAqlWvsVpkogT9bllITglzpX
	 YP0lVCIy0utqoE5EKzyxRk4gwmZwLPW0yaNFOkF26qbll98a5RYw0kQxz6ETrJwJY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lUfxt6bO;
	arc=none smtp.remote-ip=91.218.175.73
Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60657606A33F
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 09:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60657606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lUfxt6bO
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eG7lP6gOXEU8U4LBsocd1+0PiWMCGV/hYfHSxyzIAWA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793958574; v=1; x=1794563374;
 b=lUfxt6bO2AGkup/NTOyuAZoiZE/jQzRxT5tCXgq14ZttaOFnSszhVifTOFP9nEEpplUmd8kd
 9wfsWuh5xuZoTmvlJg4W24nXQIet+recIFSbR+orEKuGtuZx7twPiwoMZ9WprNnwHvvE4f6QU14
 8UDGWZZy1lxF4UYC0FQsRE1Q=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ec9a2babcc567cf7;
	Fri, 06 Nov 2026 09:49:34 +0000
X-Mizu-Trace-ID: ec9a2babcc567cf7
X-Migadu-Flow: FLOW_OUT
Message-ID: <3436028c-6ab8-42a6-9489-8dfe861fc3f4@linux.dev>
Date: Fri, 6 Nov 2026 17:48:23 +0800
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
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Sashiko <sashiko-bot@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>, maddy@linux.ibm.com,
 Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, osalvador@suse.de,
 Qi Zheng <qi.zheng@linux.dev>, chenhuacai@kernel.org, kernel@xen0n.name,
 linux-mm@kvack.org, x86@kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <sashiko-outbox-198652@kernel.org>
 <20261105080241.57241-1-lance.yang@linux.dev>
 <2AB0A0B1-1613-44CC-A007-2453F6206D77@linux.dev>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2AB0A0B1-1613-44CC-A007-2453F6206D77@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/6 14:09, Muchun Song wrote:
> 
> 
>> On Nov 5, 2026, at 16:02, Lance Yang <lance.yang@linux.dev> wrote:
>>
>>
>> On Thu, Nov 05, 2026 at 07:16:48AM +0000, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>> - [Low] mm: undeclared vmemmap in section_vmemmap_optimization_disable()
>>> - [Low] mm: define vmemmap_optimizable_order() before section_vmemmap_optimizable()
>>> --
>>
>> IIUC, on LoongArch, asm/pgtable.h includes vmemmap-optimization.h before
>> defining vmemmap.
> 
> Yeah. Really nasty.
> 
>>
>> How about taking a PFN and page count instead, and leaving the conversion
>> to the callers?
> 
> However, although this can solve the compilation problem, for the caller,
> it is not very straightforward because they need to calculate nr_pages.
> section_vmemmap_optimization_disable is only supposed to be used in the
> vmemmap population path, and in these paths, the most direct parameters
> are start and end. I think this function could be moved to
> mm/sparse-vmemmap.c, and that way the compilation dependency problem
> would be solved.
> 
> What do you think?

Yeah, fair point, let's do that ;)
