Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FA3E4C83;
	Mon, 18 May 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092649; cv=none; b=c1UcEiE8qPsqKMKtW4rvyj1BiGNkwZqIcU+xBt5oF+UL3hCRhFhCpGsw+tmX6KOlZFWCT9f/bF8tSrvcBUN1SGBlKSSdT+KpTzm5d7LbjimxgnrZ57DU+Tfv8A0719Avya91rjN4626FT08NF9mtZy3fCgYGV8+mWbL5t719JZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092649; c=relaxed/simple;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrkCEhX1Qf2wieDzOXWogLT/gjv3tbW8UME//IQAnh9kUI49gUbryNhyZCyvbkla0muhUf8YPHQj5MSSzM1WUCi4I6zSRROfT3GgVGj1r13fOvsmAxCE94Sa0tk35i3QM+o8peZTXf3asNqPeyQklBprBTVfq8in1MgkzfiMr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWifYtBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWifYtBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D1C2BCB7;
	Mon, 18 May 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092649;
	bh=nDIhMV1nHjwLsCIXlCezYHSNmQyf4UWuYbLZvlWovDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NWifYtBE4iioUAj3misRX6WwJ0qFse49SAbzHE90dFtNp8FN6knm3Yiph8G/VuQHI
	 mk5mZdPQEKJC66muMH1yh9b6HwWB0JlBDq+5eBGodIOS/8D1pPmfLOHdZOjeKWK88i
	 N/8w1A1QCWLgXVg9FtWIO/NYcHS1lK/vrQsa5fOdwGgM9OSoaJW4SZC9Hjn7WPYBcw
	 GeKO0qiVF65IovoAz/Xum8DtfjdWmTxiZ2CqAnKB3ZuqDWK9CLQYjpJrhBZDofIX5j
	 V9HjO3QpHnZq4b337FQLstpxcEkP7IBe0Bd8u8pcKxo9RJ8TS2P+8sg+7Whz3yPWao
	 yp6TgriAHH+hg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <agldl4XQLKAtyLty@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
Date: Mon, 18 May 2026 13:53:58 +0530
Message-ID: <yq5amrxxxh0h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri Pirko <jiri@resnulli.us> writes:

> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>are handled consistently.
>>
>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>shared/decrypted buffer handling. This series consolidates the
>>force_dma_unencrypted() checks in the top-level functions and ensures
>>that the remaining DMA interfaces use DMA attributes to make the correct
>>decisions.
>
> FWIW, the patchset in general looks good to me. I tested this with my
> system_cc_shared dmabuf flow, works flawlessly.
>
> Thanks!
>
Thanks, Can I add

Tested-by: Jiri Pirko <jiri@resnulli.us>

-aneesh
