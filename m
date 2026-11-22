Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364245;
	b=syGGEm5vwldKVUlxAKLUoKwFoZQWsRMfr4Vze2WImpl06ztw+3M3wg2KvX5nNmRXzJmE
	 s0Of23b5n4LydNzA/nXe9D6XVMV3fsPIBD9cRFfsQfK2mC7NwIpZIMn6F09NBQqXL9veq
	 OTMwPZKzvNFSvmp+CTSjNtQEwYrMidvj9ccTO0PpkgZrhdNl2/O1irXVepZKLBn7JLdxL
	 ru4xLFcAA9qux3CYbfutN5B7QirumGXbAWz8EGP34oIgAJtMRIstyFw1RKtK57xAuTZev
	 JzQ+KM0+BjRSCF5hULOcxOBK63UMbNDR0kq5oAOhXxt+OUU6k0P9A+7gkG4L8SoxrNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364245;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=nR/Mv8pU+awzbKHVLVTOvIJwcSoB3/LbebgRm55ntSw=;
	b=nQUa2WTnHaPH2vDtmWOI711kVWub3n7ycT3NCtiJMjrH+pt+SeXux1SxwYLezTLGH8dG
	 eG2kcTSn9/h1bAXs8O4Xu+S4UAJ6j/7euslzqGL/JUhpf40xXcmvaKM8RDJCfaIq51LUs
	 XRyg5Ba8wb51vJC8ehYCSVIsCK/9/zt1Uu1nH9bF8Z8JOWzvxklLKYY4RNrqBtUpPviNt
	 C215gNLXzIPlcf1gv69D/2StxCl8Q40RGU7at7nlAHyf+qWC6TxwwaLaE1lXkY7KiHhsS
	 ZSGiZVs2UcOkwJdXk/xRU4C7Y6qFGeL/OKI5zJxxeKpmQ0ml+T4L/hghhiKHWkWGQOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHsC4CTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB91606A320;
	Sun, 22 Nov 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHsC4CTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E891F000C4;
	Sun, 22 Nov 2026 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795364244;
	bh=nR/Mv8pU+awzbKHVLVTOvIJwcSoB3/LbebgRm55ntSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EHsC4CTYewr8mI8OaADDEq5jIWtfCtl6qJKSpZCWS+G638u1IEt6FEddjKRZ/1mjW
	 iZ9bkOoAYfW6hNFTyBpzFs1sCJq1P32mkZ2JUK2v4GgWBNdBM7oXuciS59RGfSvxsD
	 d9X2GMgmRijAwtma/G0cv3+I/xsjjC7rYIGbaKPsCBNvIZF7jiFCdws8Zz2fX4JvV8
	 lyoGGSvbI2wnVbcexJaQe5Gxdc12IF+re7h6Bc9Kp9H7RQILVWIsHXXOx1Fm91JKWm
	 +cPqYYVeteRw5jTtrIl6EBP/JGBumLtlm5lLmwekdRW06eS1f5+758PSLk//NQcQXg
	 LLs/BqBJBrtOQ==
Message-ID: <a8aa2827-520f-4e64-92d3-776e891b3927@kernel.org>
Date: Sun, 22 Nov 2026 17:17:07 +0100
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
Subject: Re: [PATCH v2 1/4] mm/pagewalk: delete the unused member
To: xu.xin@linux.dev
Cc: acme@kernel.org, adrian.hunter@intel.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 borntraeger@linux.ibm.com, byungchul@sk.com, chengming.zhou@linux.dev,
 dev.jain@arm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
 gourry@gourry.net, harry@kernel.org, hca@linux.ibm.com, irogers@google.com,
 james.clark@linaro.org, jannh@google.com, jolsa@kernel.org,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, ljs@kernel.org, mark.rutland@arm.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 mingo@redhat.com, namhyung@kernel.org, nico.pache@linux.dev,
 oleg@redhat.com, peterz@infradead.org, riel@surriel.com, rppt@kernel.org,
 ryan.roberts@arm.com, surenb@google.com, svens@linux.ibm.com,
 usama.arif@linux.dev, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, xialonglong2025@163.com
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102132844.301730-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261102132844.301730-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 14:28, xu.xin@linux.dev wrote:
> From: Xu Xin <xu.xin@linux.dev>
> 
> The 'vma' member of struct folio_walk has never been used since it was
> introduced by commit aa39ca6940f1a ("mm/pagewalk: introduce
> folio_walk_start() + folio_walk_end()").
Right, I went back and forth whether to pass it to folio_walk_end() or not and
ended up leaving this stale member in.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
