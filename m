Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939896;
	b=dAuAnsFkas+k2LvQd1DKitTDAhjR90FVABmjX2VaF6EVOWvo8dXj7GAgasLW6vfBVm2p
	 G5WrRi8FU340l22cAD9FzP3RzRQAKEo9LWcSYwHZ8AXd7zvaWXseInfUleWB6A/byq9OE
	 j8qWutAG8xIE63tQOUIUyGtFYAHErcBh+P8w9+YR12uEwSpL0GFyOx/5OwYhJLf90fCX7
	 BVZESR1UO6e7KQHV1vJ0L1pubgB59kukgTjac9RhdGWmHbwVBp0/qFEPUsP3rKQvRWbyV
	 6TWPaLYJq61ryPRfLQ1TUS2yksza9Xz3/mrSrRcU/xhvbaRwnXKy6ZrOldVx19Hehww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939896;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/Yx3i1zeQ5pe4eBI/JzCvDsEdxLLepzecCOmB7O2Y5Q=;
	b=zAkMxctVnPhU0LUfoGHFd5/fdR6KhKAKqKAOdbm+gSKsxK5j5mERdQ0Ac3zYojfh5xFr
	 Y+J1hbizFlU8brKTPXOxehou4jUfBHtEl7rPWRrX3HcWfUe+QY0Yo2fqwV+CtpQpi9qZG
	 t9qV0G4cyMcyEZt9R8jOZKzpybQ1NXL05ussFJShpgx/hc6c27137DQHWK/60AemjniC/
	 5a+XphrDbWSiAnA38fF/6yCgrJIbLarHd0DHX7GWiMKRM+FUlqceXwidcsMHALFv7Ik+K
	 2iWVDAlpmwbLJjrgAyiantAiV9KUBTmNV2uQeeoquHAnm9fv5C3sEJzWBlWJTfs1Gtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2NarzBu;
	arc=none smtp.remote-ip=91.218.175.213
Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16918606A328
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 04:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16918606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2NarzBu
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/Yx3i1zeQ5pe4eBI/JzCvDsEdxLLepzecCOmB7O2Y5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793939893; v=1; x=1794544693;
 b=h2NarzBu5wSfv3HGLjDaliK2QJozxMk1T8AWSAyQrfXgHTDTPCv+ZGuVrnREakda/ZEx8QA1
 8oHdr4LZFwNJAxqLIVYaUXa8CPvRrYRT1iKnDBFCbx5htEVpTCoeBhb92BY4AQ1xCcuyadvcBnR
 1nSZlm5DlYnhXsdFYvkrWORw=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9188c1b74d12ac2b;
	Fri, 06 Nov 2026 04:38:13 +0000
X-Mizu-Trace-ID: 9188c1b74d12ac2b
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
Subject: Re: [PATCH v2 1/5] powerpc/mm: make vmemmap_populate_compound_pages() static
Date: Fri,  6 Nov 2026 12:38:07 +0800
Message-ID: <20261106043807.32969-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105061217.13302-2-songmuchun@bytedance.com>
References: <20261105061217.13302-2-songmuchun@bytedance.com>
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


On Thu, Nov 05, 2026 at 02:12:13PM +0800, Muchun Song wrote:
>vmemmap_populate_compound_pages() is no longer used outside
>radix_pgtable.c.
>
>Make it static and drop the unused dev_pagemap argument from
>its only remaining caller to simplify the code.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Acked-by: Qi Zheng <qi.zheng@linux.dev>
>---

Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
