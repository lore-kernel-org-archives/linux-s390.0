Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580082E8B64;
	Mon, 30 Mar 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881698; cv=none; b=m817FaV2yGKFcUzqIK+esdF0DNp0T5qlP/F+vK/eowKIKfoUu39pI9wkh1uWlq6uavxUkrRy7Irt1tE2aEn9yXGncIgZPWzY581oZBtmUffxhf5Iv/zPwrRw0pP+ekrFTqyQcBq+YeYUQdGEiJwfMHT2AHrzS5vdNLwAQAdoLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881698; c=relaxed/simple;
	bh=q1b29V/4pBqAX8CvMK4aRNivkNTJ18eDUC9nnf6AzYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me3wvyfowaOFkNUDBa2ekONW6ULK3+qzYXYrUNeaNnGIPAwF4PBjpCA9knkExi1jDpHqLKjL2zWlWm++dygzZLqskAMTVzESoosJA9rHY7wzilUnAkqOSmHICBRejD9tpSNVCdN6sx/XZuh6KmNn7/Ju8sTzd/D4FgdmbBYCzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf5fu/0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf5fu/0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FF1C4CEF7;
	Mon, 30 Mar 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881698;
	bh=q1b29V/4pBqAX8CvMK4aRNivkNTJ18eDUC9nnf6AzYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hf5fu/0N5Yv+ao/HMQUzQ1C/IjOSFn75AM00UCavWx7lyuckbd0NQDPWCguCVvijt
	 5W9bE1IWkkL0SYVSeXmiw/LTEfMTFb4AI+NLduN/HEXZNgmhftc4j5SJTiryonKZPX
	 Gg5SHcAounYh8uZaOUmBfs08IChQktAT5vPNocEZdLJoUFM2tL1gKg44Zhx0uiPq9z
	 At7kdO3ZJvMpMVDLS6JOGhIZxedbZOleGYisUGSSkKcLJGe0GtxoV5ClX8LbTfnsV4
	 WMNycWvEKQWWHYpx4wKvGpEgPwAHnUKrdtccaNuVGJtSYBjsE5Xmc/d7EZJGTuqqpp
	 ddn7Fz3uG2sNw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D6B0F40070;
	Mon, 30 Mar 2026 10:41:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 10:41:36 -0400
X-ME-Sender: <xms:oIvKacMH4pOUW8JXzjJVcV1JLzTY_4rDoT65o0x10z46C2K2JSs5iQ>
    <xme:oIvKaanQVUb7bHySeH3KuajIHPvb4CeD9IiHtDeY9rZMkNbzmFDV5YwyHXoa1GZ9G
    x_OjvKLyV3RmCnA4I3Fh57qch58qCAqtdTFoi46GQLS_79B9tcNRRo>
X-ME-Received: <xmr:oIvKaaq8KEaqXgMksQxNtNzuauD7tt-PlwwS868pJJ0CeXnge6oxIL3tPVU1dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehfvhgulhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpthht
    oheprhhivghlsehsuhhrrhhivghlrdgtohhm
X-ME-Proxy: <xmx:oIvKafP9t2FsSI-ZdJ9ZVNXV5FpK1ku-TWrmAckhaNHLY6HFw3SpNw>
    <xmx:oIvKab8Hh6_7PeZedKLo1IrRiQRb0sN3lqFZqD3jayWAIdx6_5RZKQ>
    <xmx:oIvKaSjR6nXSb8o15Qfy00tBqI3goNQr7LPPAmFDKjADHeeZTucDUQ>
    <xmx:oIvKaerDRj-PItMlNiCaaZjsbVjD-mjCZevsuatZWZyJWu-aOeCeLg>
    <xmx:oIvKacM9haxG7npqDzzSIoNVqtGL8pCMFQrFUNHVYhBT0WFrlHw2iuvR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:41:35 -0400 (EDT)
Date: Mon, 30 Mar 2026 15:41:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, 
	lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 16/24] mm: huge_mm: Make sure all split_huge_pmd calls are
 checked
Message-ID: <acqLbkH_aN6aeZXN@thinkstation>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <20260327021403.214713-17-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327021403.214713-17-usama.arif@linux.dev>

On Thu, Mar 26, 2026 at 07:08:58PM -0700, Usama Arif wrote:
> Mark __split_huge_pmd(), split_huge_pmd() and split_huge_pmd_address()
> with __must_check so the compiler warns if any caller ignores the return
> value. Not checking return value and operating on the basis that the pmd
> is split could result in a kernel bug. The possibility of an order-0
> allocation failing for page table allocation is very low, but it should
> be handled correctly.

I think we want the same __must_check annotation on stubs for CONFIG_THP=n.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
