Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DD35F619
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449746; cv=none; b=N27/ESjd/5aisR7xvoVEBoGc8UVhwgIikiZi3PByYCMR/66R5Ef/wK/FonDYcVogsLoeNbSkqfGpoRVSQKfe2SCwIEhZ8Re+o7i6aYRv1csA2R+EfEU/mD4eB7VcdcTQfcMSJx9+6Gm8HEi/dKMLP2jO1Q0wxp/iVsUAEsay4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449746; c=relaxed/simple;
	bh=Zkxz08/LDrHk/y3pz/FJdC442E8l4NJ9XBu96XAbuSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0mhywuNnIF0xMHDaqD7IM3DXWPoKBJt+cBTmNGR0WmhIaZtp4mYuNOdkA1yIPTS5Y7nHZot80m70DFkkHPHDjlAHcUVd2CWyKzmznwcrAgLpmCOW0mhSgGgxPUJyHnlNwN/x3mRPjWcFgj2SyoaU8AicprQcTJjw4iKsPJPAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHpzqh4T; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHpzqh4T"
Message-ID: <d8771807-c85b-48f6-b5a3-a7f167cc9494@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772449740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALgtyZvM7U+ADKVcCq+vWsLwr98RElyoZqbUR3DonCk=;
	b=eHpzqh4TQFq6GsbuPnCpe5jSVHJ3YXMxlPIIhBK0jXo03V3jnRz3qkm5dHB/xKaM1ACva+
	2Y8OdZXsjeij5zDj3tbrLBIE+QRNrcPXZM4UgCJcT9WztqxJP4KNtYkPpB8oLLxlIXXWk+
	kq5Y65mqoE25P4/NF5WJQn/9mPcWqZU=
Date: Mon, 2 Mar 2026 11:08:52 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 00/21] mm: thp: lazy PTE page table allocation at PMD
 split
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com>
 <1d3a4e8e-9ea0-42e7-b8e7-d92fb27f80f4@linux.dev>
 <CAA1CXcCygvA9uUJjB-+2J00srnHbiNGwbvcbqpRer8Vy8QBxWg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcCygvA9uUJjB-+2J00srnHbiNGwbvcbqpRer8Vy8QBxWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


>> Thanks for the build and looking into reviewing this. All comments
>> and questions are welcome! I had only tested on x86, and I had a look
>> at the link you shared so its great to know that powerPC and s390 are fine.
> 
> Good news: as you noted all the builds succeeded, and the sanity tests
> dont show any signs of an immediate issue across the architectures.
> I'll proceed to debug kernels, and then performance testing. I will
> try to start reviewing the actual code changes in depth next week :)

Thank you!!
