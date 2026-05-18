Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DD30C157
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087331; cv=none; b=a1TO5+leiDDkftVpgaOt6ToZA0e3dwz4NSYRe127zwcph+O0tS0WNLObjKOOYyr1wA7YoIkL5QQYJHI9g2V4bzGnEnRb1PTxdqCqH+6CvIq61VJHfCYl/svXHd0c8Stasijxj6r9ZrscP2TFfbWn5SgF4x3fSw13fOQAwoq6TAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087331; c=relaxed/simple;
	bh=T6Q6narBBfa2DFEcAhiLjPk+kC15poLsjndhE7THPe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3brlGm4gNUvhhBUH9XLeJfHyVXxB/aYBtfm62o7p0pod48ICHPa076IVOvoEYfgiS0UaBk2KF/ZIEKYg+DFVAoGn+a80RasOsCHFAIykmXQ8WGopXN8VHmsfMNYS/UQkxq49/gGb62RDf2WGcTHTu210hppV9lPN3y0EztG79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JM9d4r3u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JM9d4r3u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6Q6narBBfa2DFEcAhiLjPk+kC15poLsjndhE7THPe4=;
	b=JM9d4r3um6vkgkiy6daR65WR78qA1MrD9d2QcfRAVl6Vzhs/8XY97LYGKJl4fqdLxvpeuH
	YEir1Mr9Ev7fsq18T4jdnS1xPmdwaStWTxOSPu+T7af5NwJa/Cjb9FifpXmLXh/R1qLVtG
	219UPF+OKh7SlV2vRBywuN9O80W4b1Y=
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
Subject: Re: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Date: Mon, 18 May 2026 14:55:06 +0800
Message-Id: <20260518065506.79263-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:29PM +0200, David Hildenbrand (Arm) wrote:
>sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
>register_page_bootmem_info_node() is a nop.
>
>Let's just get rid of register_page_bootmem_info().
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup!

With CONFIG_NUMA=n, the removed helper did nothing.
With CONFIG_NUMA=y, it only looped over nodes and called the empty inline
stub.

So, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
