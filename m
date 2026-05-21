Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F63A6411
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353260; cv=none; b=gbKgqiIeldVVY41HJUAWbmoQD+J4DWp89hYysm9DKie47sTBYpdv4lUmVlMfxJ66d1bP8jyVOaUnMs1k5naeCAzw4qqs8i3CQ4tCSrrNunnGcdtwuFsNEhDTOZQvQ9LJC4Qn/l7jKVl1mI7+KquBr0A4P61ZuZq1rNJYWalvSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353260; c=relaxed/simple;
	bh=Ce0YsJDZhijtzDvB+cpUwwO/m6mCN3ATBf0wLj4s7bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyxxTke2vxQYSpUbw5vAOLbhGxsF/RpmczLtK0gahffEtKCdnXXIptxkAcHzZQGOFyoPKzYs2MLksHFqHX0rMbMSGMAfthF+yqqzjZL8VfezYcfMj10n9G9P4PmW8Zc/FICB0qXduzYm9rZZsAm8Yns+JbtriNSoTJ7uh0oxQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/o56LCe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/o56LCe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779353247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce0YsJDZhijtzDvB+cpUwwO/m6mCN3ATBf0wLj4s7bQ=;
	b=p/o56LCeHYPXPT9ntpy7ijsSA6U2XV1q/IBxgTL/awZNyuXPbTR8nUqPg1fOGGNvmHFIc0
	+K/9omdB3BHMb1jH0Ko3eYnwfwaqGJr9EmwxM9iQdlkJ157w8nTXKiIgoFtsoY0SjzL+uG
	hQxO7Q43dKvRrpA5oNJkOQUMed1HVEo=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Date: Thu, 21 May 2026 16:47:18 +0800
Message-Id: <20260521084718.36436-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
>register_page_bootmem_info_node() essentially only calls
>register_page_bootmem_memmap(). However, on powerpc that function is a
>nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
>anymore, let's just drop it.
>
>We can stop including bootmem_info.h.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup! Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
