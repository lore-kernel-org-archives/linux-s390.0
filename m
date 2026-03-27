Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016441B808;
	Fri, 27 Mar 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631005; cv=none; b=F4FN4K7mLBogp0OQK5eV6vGod9O7OjCyUyJ56JG27a/hRO0bGZBgSKbfxzQHJ3pxzReS90DLwtBGSNgj45k1MOni7txbpuiudMu/SjQi2aUKtPQR52dRa8w9p03QTHpY8xRC9015MxTIvUeyEcl4Hy+37OOVkni6AfevoYHb174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631005; c=relaxed/simple;
	bh=jlgvlIx2lZLy/yw0VsiYcAtefj+7HLiDE86xWPu3bn0=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8ja9h07GhvilcgVs+Wd6ogQpliBq5TcFEEZq21kUkoOKmEEEgQoUtKDMkCoYuijmaN4mIivzZSJm5I7bv9CG3Eatw7mekFO7OiE/Tyxo61ZSKCKuDHfMxaKwDGbgIc///oWV4VCCxhi5izMSalB/jUX6CuBLO0CdapdZ8PiBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oq9Nujey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oq9Nujey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22BC19423;
	Fri, 27 Mar 2026 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774631004;
	bh=jlgvlIx2lZLy/yw0VsiYcAtefj+7HLiDE86xWPu3bn0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=oq9Nujeyhp7Zx6NT/DmAKRTTx7w3723Jfsgcrx2JTII8ccXAVeunav2gzmNtcCWt4
	 g+b2onmd9YBtHJ7AgnnAAq/NWR4pHj2kIgRzkSL3306j4h3HOUuTBYP0MQBBSLDCLr
	 YLaYJ9G1El1MIqjFKuWcT5xV6/7jTsovIMJ3/INw=
Date: Fri, 27 Mar 2026 10:03:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>, willy@infradead.org,
 david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz,
 jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de,
 kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, chleroy@kernel.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-Id: <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
In-Reply-To: <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
References: <20260326080836.695207-1-surenb@google.com>
	<20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> Three of your patches lack review tags so now it's 65!

Three is now zero, thanks Lorenzo.
