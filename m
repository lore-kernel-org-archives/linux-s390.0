Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842D2F4A14
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622420; cv=none; b=OawF8h5MqkWHgrrPO0vMDoS4lOxNnyBv3RFXmOJvAFQgbl9hNUSkJov3MpX9ankQydZErHmqbVhbHu5HEy9RnJR43InsNXOF9YcG78DxjXOgB2Fz991O9RnkiDQxb97CNH+OdLC08YM90jRGESbkGK6OvkMzywIwBSJ/IuKTiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622420; c=relaxed/simple;
	bh=53KOvVRxqebfsaKtshYt5ZefzJHmkhxjBoiFF+hbHak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkIr2IcgD8du4kjIEOpzQecrwjg+BuotCddnIAfABB4eotYjgje/fSqDN140YxW7rCtDmh5IEfRkH/wbWy/s6o8/6P2z5Pt86o+4nbbfZsaBUR3oUrK2wxmoujjVR1BWiKDCLbwPDC4GZPW77eVrq2xdJoPkCAgKrn6XimysPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FpoH38ed; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FpoH38ed"
Message-ID: <a5efef0a-8d68-4c8c-b8ae-09a6a33e37cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774622416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPmy7VWivg5YsRBSBaIcdTmp91XPK0irR3iwfLEb4tM=;
	b=FpoH38edCQ9PPpFsGYVuORz7UGKbAz3vOE8SC863R9H33+lGVW2wozoOwesf39+5QTJLZ6
	YMLDpHYRZPlLmWXmfHEsd2JK00Icpo84ITAZklijT4H3nM+WPbh5CLzikqON6bRdbSd6yH
	4h/88ILAJinto+ZbCJD1S1MPuXXTASM=
Date: Fri, 27 Mar 2026 10:40:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Content-Language: en-GB
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 linux-mm@kvack.org, fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
 <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 27/03/2026 12:25, Lorenzo Stoakes (Oracle) wrote:
> On Fri, Mar 27, 2026 at 09:51:31AM +0100, David Hildenbrand (Arm) wrote:
>>>
>>> RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
>>
>> Note that we usually go from RFC to v1.
>>
>> I'll put this series on my review backlog, but it will take some time
>> until I get to it (it won't make the next release either way :) ).
> 
> Yeah, please update to v1 from RFC because I'm looking at this and wondering
> where v1, v2 was and why I didn't see them...

Ah yeah I included the previous version link in the coverletter [1].
> 
> Generally I'd also advise un-RFC'ing a biiiig series IDEALLY be done early in a
> merge window :)
> 
> We've pretty much shut the door to new series this cycle, but being so late in
> the window at -rc5 would mean no way for this one anyway.

ack

> 
> But in general it's going to be a rebase pain this, 

Yeah rebasing from previous version [1] wasnt fun. But yes happy to rebase when
needed!

> and I'd rather not see it
> land in mm-unstable at this point, because that's supposed to be 'what's in the
> next release' and it's stuff like this that leads to 'I am not sure what
> mm-unstable represents any more' being a thing.
> 
> I think in an ideal world we'd ONLY see this in mm-new.

ack, I will try and send the next revision on top of mm-new. I do believe
this will apply cleanly on mm-new at the moment as well but ofcourse that can change.

> 
> I wonder if we need some process for un-RFC'ing really, where somebody kinda
> asks rather than it being a vibes thing as it is now (or a 'people don't reply
> to my RFC' which yes I'm guilty of :)
> 
> Anyway this is more general points and not about you Usama, because - hey - all
> this stuff is pretty unclear generally.
> 

No worries and Thanks for reviewing!!

>>
>> --
>> Cheers,
>>
>> David
> 
> Cheers, Lorenzo


[1] https://lore.kernel.org/all/20260226113233.3987674-1-usama.arif@linux.dev/

