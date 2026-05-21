Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D872F9DA1
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339857; cv=none; b=d7Y4MEil6I9AuYBDtvGh254ryjCjKQBqDHKpVW1jAthAHmjfIZCdU99C1BNOb1uwmXF9Zkfi9h0h7o5yxEKzT49zi1lDNO/Mwkeg93vTh6IPh7Ak4Y8k4AzKTUU1ivuB7eoPosykR5zJMw5ij9HB1Sl4tz2NNlDNMYeWGm4VIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339857; c=relaxed/simple;
	bh=udD7mWlkd64piA/1uV3JoogXR6FhB2/z0dczFUqXvp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1JFnJU8iQeFP1kBe6Ez4+C8pMOKjCee1kpnDDdyU8FhJeRmSju3wjxDirdnindeliPhUAZmapDAvvO4unj6Rksc1BoI7W9lHUGktFop/zmHYgmJeQt208FgPtObSPG+PgEoHSQVg/mgCySvXuRMt7xdVf5pfOwz5xiXZZijOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JULoXvF9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JULoXvF9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779339843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udD7mWlkd64piA/1uV3JoogXR6FhB2/z0dczFUqXvp4=;
	b=JULoXvF9rBrdxisl033+Bdt9vswxhIhpTxZDs+FlAdkNcEg3HR7Hnujny9LdUKuej4hxLJ
	iCfAds7VXyCqv+FOPxCKSMUoBQwrw59yeCxPcn5xYNCHYWFqJD7LIMlHe1JAMI794A1wmX
	BdOajcXyff9GzuTfn9ACSh0PO5UhgKo=
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
Subject: Re: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
Date: Thu, 21 May 2026 13:03:39 +0800
Message-Id: <20260521050339.65872-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:34PM +0200, David Hildenbrand (Arm) wrote:
>We never free the ms->usage data for boot memory sections (see
>section_deactivate()). And to identify whether ms->usage was allocated
>from memblock, we simply identify it by looking at PG_reserved.

Yep, PageReserved() is already enough to tell that case apart :)

>Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
>Let's just stop doing that.

Right, MIX_SECTION_INFO doesn't add much here. For ms->usage, removal
code doesn't use MIX_SECTION_INFO at all :)

>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
