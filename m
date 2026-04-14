Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF53EDAD1;
	Tue, 14 Apr 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188301; cv=none; b=b2G/aTxh5ZkHLYD9KG07XOKZuPD6TBL1YuTipoVGqEdkV7HOLjaQGdnTB84Zr/qjSLKfZOydeVaS1BzV6E7zaWomujQZ/bJmxjtqeyBCLKz1BC6xQL3uMqHZa1VanM5XlZsrQljoeMQV0MeF9qQuAJt8iTV4ogcCiZ56ReIOFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188301; c=relaxed/simple;
	bh=LuhkQ/zv/OtvVCg3FzLN+SqhZeScV2Hzlr/g41O5F2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEyS5b9CWMZGR36dVByiyKL8o2Ww4j2NnnknZcU5XX3feFRA4Jj9iRhWaYUsps9qpYk/hXbw+WDw6JM/bwXyChYyRamGYRAL/RyMn1z4USlQYK8eBdX5gqtLuBF0dgjXspsMPFpr4kc8kM4hNAnpn+nLlV6bsmOr4hJPrZBKRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A9nIZdW1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A9nIZdW1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D76125E0;
	Tue, 14 Apr 2026 10:38:13 -0700 (PDT)
Received: from [10.57.33.35] (unknown [10.57.33.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017FC3F641;
	Tue, 14 Apr 2026 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776188299; bh=LuhkQ/zv/OtvVCg3FzLN+SqhZeScV2Hzlr/g41O5F2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A9nIZdW1PiOaBm9npx6eosy3cJwTTO9WMk80QCCJdMFI37tgu7+eEUusEWBJ8DuiX
	 0OA9eo6hscO+Lb5nKIkXqEtAokwo8VgY3OsiH4y0IxTeOb31din/AMaCbjFOKYEcD8
	 Go6mFNzgpnA519rMBd9CmQkN9yd0gtPFW1bRhXok=
Message-ID: <d5a39861-0f5f-4aee-84e3-f4d956f83461@arm.com>
Date: Tue, 14 Apr 2026 19:38:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
 <896b3d93-8e60-42e2-b8bb-d3d4e8c99927-agordeev@linux.ibm.com>
 <534ed892-a6ab-454e-831b-e207930c35cc@kernel.org>
 <584f0f88-aef9-4a70-b0bb-abc797f741ed-agordeev@linux.ibm.com>
 <17505ac4-c5e5-4046-b362-830369b8d401@arm.com>
 <384c5b93-7939-4a9e-9298-66397cc6fa28-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <384c5b93-7939-4a9e-9298-66397cc6fa28-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2026 18:08, Alexander Gordeev wrote:
> On Tue, Apr 14, 2026 at 04:30:10PM +0200, Kevin Brodsky wrote:
>>>  * @mm: Address space the ptes represent.
>> Not sure that makes sense, maybe something like "Address space the PTEs
>> belong to"?
>>
>>>  * @addr: Address of the first pte.
>> Isn't it the address of the underlying memory rather?
> Will update both and also the clear_not_present_full_ptes()
> comment, where I copied it from.

Oh I hadn't realised those comments came from there, that would be nice,
thanks. A better reference might be a function like clear_ptes(), which
was probably the inspiration for clear_not_present_full_ptes() (but
wording adjustments were needed for the latter since the PTEs don't
point to any memory).

- Kevin
