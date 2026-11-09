Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205003;
	b=QK/ugQZwYt/laAO0uZlJfPjOiFM/dCr7QoJgEweRE91mpnTDBX0WRn2Ekq6ZwuQT929E
	 5/rOTvhu+N0KdH/nrIiVPjNSGOuC22r/eGnw5aRaC4MVaHpvg5b45bGUljGtEL9HORa84
	 /3qscCOcIsZkTGx+faIaTt36jM+7wP2X/5tRaRWnoGuTBcbxMkQMqJ9cpE+22r2491g4k
	 MuRbSTxlpMdr9K1/i7JqrWQ9m6y6hroOhoqtvHSNjAl3TzD6JHFHWW9aTvI98SUd0xIvs
	 2ZWz4plHOn/tSnsTcbxvDKByM+OwpoUmDbNjYM4KDODl+NeyGur4nYRYbS1+aCG9eBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205003;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rLoo3d8wA/2dmWzlOHmZSdy7DBfGYigRliA9FCVCD2U=;
	b=1zeuizIhXTbit8YtmBqN1+cRh9iF5JGef+Bei5jMYPr1/VXpeNAeiaNNyotcV6ToYH/p
	 psbGFNLZavr79y2UygJs9k4hGaLm/oqzCh+iyXR9aReP79Zz0c2kKmaMOY7dzIhKmiLcG
	 DLxzEVqUrL3eUuUFeDztlCEXHcInJ937SQ8Nd1byS3+DQ51iOGB4yCC7SuWRP2AuW+6y4
	 Hvps27fNdv7KIwaFWSRqx6MxPzAdhwXj78rNyemmKrsQbo6cxUB3LKNaZK52W6NColVFx
	 OeP07g1xMEHyERxj3tYZ4hJFfrbCNeIRHfCXIsk1NekYE7Z5Scoa762xWXr25Augm5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YdOHLkm1;
	arc=none smtp.remote-ip=91.218.175.173
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DD606A31C
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 06:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YdOHLkm1
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rLoo3d8wA/2dmWzlOHmZSdy7DBfGYigRliA9FCVCD2U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794205000; v=1; x=1794809800;
 b=YdOHLkm18ej0NUagkOx5fL3TEOgHMQ4gnUIWPRRwP2usH38o0YIcXOhwUKSi9HBHrLmHN3CF
 VnYMJvdPfaRR5Gnc4oHs25xqt4OL2JddMSYjRcOZQnm+keRRQyCMa8U5/cjU5k8uVN1qEiWUb8p
 luxB4nmOtrLFMWZo/OoPRgjQ=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7a98a3c4281100a;
	Mon, 09 Nov 2026 06:16:40 +0000
X-Mizu-Trace-ID: b7a98a3c4281100a
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
Subject: Re: [PATCH v3 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs
Date: Mon,  9 Nov 2026 14:16:30 +0800
Message-ID: <20261109061630.47601-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261107043122.25650-6-songmuchun@bytedance.com>
References: <20261107043122.25650-6-songmuchun@bytedance.com>
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


On Sat, Nov 07, 2026 at 12:31:22PM +0800, Muchun Song wrote:
>The vmemmap population and memory hotplug paths no longer need @pgmap
>to decide whether a mapping can be optimized. That state is now carried
>in mem_section, and the architecture-specific population code can make
>the remaining decisions internally.
>
>Drop the @pgmap parameter from the vmemmap population helpers and the
>related memory hotplug interfaces, and remove the remaining
>dev_pagemap-specific coupling from those call chains.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---

I had another another another look and couldn't spot a missed caller :D

Might as well stop passing pgmap around now that nothing down there uses
it.

LGTM1 Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
