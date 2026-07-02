Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE13C65F2;
	Thu,  2 Jul 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984005; cv=none; b=HQdXlC/XM74p6u1VAG3YRv30o0PvT3w9DIx7kfkHLA/HTsRNdcvhSeg58Tj5xg/sACyiJFzIxd5mcZM2MeeROGFyNVH2sNfeEwL1BZF5f6g7+QfazIw9CHV78qi3dC2C04VchC1vhcFdqzisnzNri2cD3csb5qvc0fvnFg/0EoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984005; c=relaxed/simple;
	bh=S8HugMjxHFbPNvLg+AAYFwaWDIzsdO1q5qMD3yZa1ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEAcNiscdh08ooM8IVI1gm3Nnm3z34qmbLmS9Nqk++BoAkfTSSE7QQ5bmopQwsGVJhjvbZO2Fyj9It9Qg3IUkIDrLdJ9P+bf7plUvY30qHceF11itzrQs8CP6Lu0Yg6gwSfrMwUd/Zch+Dzu5hpqVf1xaxPGZytXURxF20OAXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csWmZYUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csWmZYUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3179D1F000E9;
	Thu,  2 Jul 2026 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984004;
	bh=krb+dDOShP/VdQBJzNgKxbwj/+Edag23SSgoQwI13H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csWmZYUC4S9Nl6WrP1bTUNqSv20R6fPVTF+KG1Cmg4Dj4DYI1f3yts+zZ5SFuSxLE
	 1zPcsdAMtlXsGeuD40TVFAs2oF468naHHJOCp0j/1bFoVDTNF6O7cSdv1QHcUl8cr1
	 EW6MIUu8XQAwz74SIdBY2YpAOeihb71togX+9u2JNdB6lg2m2cPNh6B+BHirU09w5I
	 RKwcx2Ycjot9IrFfgVli3rPKjJzw+RV8X3QtfO29MXfAD1a8jPLHvfU0nHbSXEKo7Z
	 7pwjC3c7iadUtI3cUSa0bj4W+vUlp5rmb1/SIDADt3Q/PVKz8CiTd3VtiiPObNQSHp
	 ybamgLGQIRuGw==
Date: Thu, 2 Jul 2026 10:18:47 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <akYs91INHMXMTI-t@willie-the-truck>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>

On Wed, Jul 01, 2026 at 06:08:15PM +0200, Thierry Reding wrote:
> From: Chun Ng <chunn@nvidia.com>
> 
> Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE protection bits
> on a kernel-linear-map range.

That sounds like a really terrible idea. Why is this necessary and how
does it interact with things like load_unaligned_zeropad()?

I think you should unmap the memory from the linear map and memremap()
it instead.

Will
