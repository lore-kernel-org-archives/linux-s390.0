Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18014A4F1;
	Sun, 11 Aug 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394327; cv=none; b=MhKlZr0r/kt5s10ae34TuTTdum7p/B2D5Vi5tjad3ehgUZuwdqbGjTxNpQqZrlr32nPGAcL2qhKfzc2OuZchIuJYryRD3H5cld7MT6w2WJGCY8QeWaC4fet39DnrokP3jij2bBRtzHHEnQ1yds1xkoWgHRLIDIkPb6PFRYc0kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394327; c=relaxed/simple;
	bh=evOBG5xxFap9DEmPDfAZO40tsVzPvbnvJU9nM+60lno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eah4ubwfZLcMk7Y0GpS89im9FKwY+KPMslc/G+P6GRAw4NbFQoqqi2NH/1rpSFRQEH6WYj2IrTnU0ZO/VWxYv6xJjMACq/0HogQeEeUYUBX4SxWGPtYumUM8ZtVsNR/3nmVW3F8T+PoeQs4BifmqoFmkQJLHne4aX9L89L52dBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSrj0YTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSrj0YTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237EBC32786;
	Sun, 11 Aug 2024 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723394326;
	bh=evOBG5xxFap9DEmPDfAZO40tsVzPvbnvJU9nM+60lno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSrj0YTOF7TixMhBQC5em1jgDg7wJbRvWmm0aMFYxFCFwMJoqFAxxbBNHLk76T0/9
	 I8Uxw1keZO90WiSyvZAzN7cISSyRI/TkM2ZJs2F+VUV4G3+60HCynmdODo+a5hir+F
	 NH/tW35YDefDUZKvr6mQeqKqssc5cRgcqwW8TYMiB3N72AlzF6rN5FBrnXTz8cz5Vk
	 pkJ+PxAU2LQxgU4TYdRXtHLtorZ1BwtwyrdBXwVZkIyhI/vT4swWfepBnZg3qSZ65o
	 R8exXW3ntUFdcBCVezD/o3qcz9f0UKwVD19SvBeZWphy0md68eXL4uQJvZsObAadNd
	 +D61bZfCUS56Q==
From: Mike Rapoport <rppt@kernel.org>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 1/3] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
Date: Sun, 11 Aug 2024 19:38:31 +0300
Message-ID: <172339430546.1161596.15408670748567422629.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808001415.6298-1-richard.weiyang@gmail.com>
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 08 Aug 2024 00:14:13 +0000, Wei Yang wrote:
> During bootup, system may need the number of free pages in the whole system
> to do some calculation before all pages are freed to buddy system. Usually
> this number is get from totalram_pages(). Since we plan to move the free
> pages accounting in __free_pages_core(), this value may not represent
> total free pages at the early stage, especially when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/3] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
      commit: d0f8a8973f265f6a276f99d091af99edfb2b87de
[2/3] kernel/fork.c: get estimated free pages by memblock api
      commit: 0910bf0ef85c5404aac94394cb31e076e4eb03f1
[3/3] s390/mm: get estimated free pages by memblock api
      commit: cb088e38aab4c7e9ce711c18c66e851c8f4227bb

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.

