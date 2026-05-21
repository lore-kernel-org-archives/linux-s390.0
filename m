Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEA39D3D0
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352829; cv=none; b=tRIt0Tef8RjgoZc8SY+N8NxgeYWvFtdqXj+V0k1WHsPXf30CBObnyyecafy3HS0tdxSrDxDng9J6BYruEGkQNdlgFnuPcDNyEuuKjPXbyHbdgIkGAH1FJ49HUe9ZU+U79M5x/UtTnOMMfUYPeW+FwVebuESyyrDTxeatzbAK0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352829; c=relaxed/simple;
	bh=E4k19jfrGZognz9ylmmH1ahmwrZE9nXMy8Z2zTJ2/qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMzmedtpYnSICV2Av88lMyvRIM5Gm/lLcp9GO1kFC512lucKC40c/Cu5EjjBHwXNexqvIlJSqC1QORN05OztvP2OcQoPbGgCVabSDxJjm384MXS9CjzBzXlsouoxVaroKNL+h+rHw6yLuJfOMEax2vhh52oYO9VFdd7WagSuKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I0/Fo/D6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I0/Fo/D6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779352813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4k19jfrGZognz9ylmmH1ahmwrZE9nXMy8Z2zTJ2/qk=;
	b=I0/Fo/D6//GbWeFmyAxHEQejv6UqxNMM8i7TkpHyaSI9zoZcVjqtoUQJPFhUfu3nEYOP0V
	zr3OmOhOtORbSm2LamS6JBJ20lMiTgfL/wTSv1FNzblIQYdQf2s6waidmpIDqHZvB/ies0
	V3l/d4fkK8ZMWZulCQedS9XqNROMfZs=
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
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in vmem_free_pages()
Date: Thu, 21 May 2026 16:39:35 +0800
Message-Id: <20260521083935.28252-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
>We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
>free_bootmem_page() nowadays always translates to free_reserved_page().

Yeah. After patch #04 there is no kmemleak handling left in
free_bootmem_page(), and on s390 it is just a wrapper around
free_reserved_page() :)

>Let's use free_reserved_page() to replace the free_bootmem_page() loop.
>We can stop including bootmem_info.h.
>
>Likely, vmemmap freeing code could be factored out into the core in the
>future.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
