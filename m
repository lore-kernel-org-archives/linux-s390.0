Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203314;
	b=luCl/49tFDt7gaE6UuDDJz0bf899lAM8g696oSSsdZoU0xkBCDGIfnRXRAg/WYCJupqX
	 8HW68TNnf0Z1eSuO/zRVG6Txkutn6B6lGFCilNl4h0WE8+Yv5pj5rQ3PPLp9b/dXcfiKP
	 +gdvD/34hlBhns5XN9r+kS5r6NzoVM/rtxOAFlm0pN2sWZpMcREGOgswpzl5nJty+rGo7
	 ADbnJwMxZJfsYYFRpQf1OKC7MdIyHu0hfpDuiPAo+lGBdPX85DH0gy32SbpBiKuTu8PT8
	 chIPvjMAKeWE7+6IHO/4NfJwyRQsRYss56q3bVfT5CZPYW4F9DNDcn/wht2eOEcvNJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203314;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JSOyM4K5zrqmDFF61CwIn14s5ShEHbu2alo+0Cxugro=;
	b=0aO/F5H0IrGK4XuNkBW9Cp6ywhJhaetnkuPubgmapdTtO17PcW0yPgWcZCOUcDC8A1Oh
	 +FRwoB8gMA0YThPJp/2aXF5DP8JT5fxvR5ff+i2PpgID6LCLBXoic5Jab6dtNDMstEbbf
	 cLfxDlwL2AQkCx6tN7uhk+KRVk6S9uRgW+ubhhqmIMWzKk3pDvMVJqDZSPBe42TAnWOun
	 3M4oaMKa09oO6TRj4+YyPbNR/Vkarnz2oLuLeZS1/sN1fbsEE4EhLOJeTh6fTp0Ln4+L4
	 0S/uyNCKZxNXw/hi/5HtWh8YKdx5mo71xLeqhIZ8ydCGsaH2iTv9KmHvIP7n6EU1kXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMq0OsFY;
	arc=none smtp.remote-ip=91.218.175.54
Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED0606A322
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 05:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76ED0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MMq0OsFY
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JSOyM4K5zrqmDFF61CwIn14s5ShEHbu2alo+0Cxugro=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794203309; v=1; x=1794808109;
 b=MMq0OsFYOeDFfLKeanMq/JRW5emG22N+JN82VeucMQQPT+M2lExIrVamS+c7q+asXdJ1pdl2
 1X0kSw1FOEdPQI/obnIvW1WVZJsWlAMtC3SyfA526L1kdBXP241tfsR5N7B2uuz87yZGgwPpUpd
 dE+PwLyiJkXRbdzGAO40uSAY=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bae7ce2de6921a50;
	Mon, 09 Nov 2026 05:48:29 +0000
X-Mizu-Trace-ID: bae7ce2de6921a50
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: david@kernel.org,
	maddy@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	osalvador@suse.de,
	qi.zheng@linux.dev,
	muchun.song@linux.dev,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Mon,  9 Nov 2026 13:48:23 +0800
Message-ID: <20261109054823.45056-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261107043122.25650-5-songmuchun@bytedance.com>
References: <20261107043122.25650-5-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Nov 07, 2026 at 12:31:21PM +0800, Muchun Song wrote:
>section_vmemmap_optimizable() can already decide whether a section uses
>vmemmap optimization based on the section compound order. The DAX-specific
>vmemmap_can_optimize() helper duplicates that policy, so remove it to
>simplify the code.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

With the arch fallbacks handled by the previous patches, we can just drop
vmemmap_can_optimize() now ;)

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
