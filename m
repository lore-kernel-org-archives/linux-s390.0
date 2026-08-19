Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B731E852;
	Wed, 19 Aug 2026 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123005; cv=none; b=hJrk0oGTlzBR9MpiIjFGQ0hUCMIU9wIrgUlIfudip6JiiTuOfkPbdTHRnDir6fXCyrLjo2988VPPtxuwVrm0aCExBLJRBU1EFSEXANOdh7ImoAhMTdHVJ9NXIkiy/YnpPOfUt04QjbG4F62RoFB/33AIdhLhTSXMeuCTxwSloKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123005; c=relaxed/simple;
	bh=kogiabQex8ceO4jBfTbGi2eSZBGKffmzWtkrc/8gn9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrZWSBFixnGYAMAVNCa5jrmprMWRiSEsg/Z8Mnd4AJCTWyMzf8Ci7tsG1PD+ha8IkPBCpCsCtuLogn5AgvzHqMq+MmyOe+oFYOt6t6Vbj51zV63y6kZwBGd3zLMRaWSoen44XGdpAQfwVM+AiQ27tO1Z3JSkipkH7IhfiTesETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP+RwyhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP+RwyhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806741F000E9;
	Wed, 19 Aug 2026 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123003;
	bh=0dah2MZp38/3Li3hSx/lwDyI7CxaUkx606L5S0i7Muk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lP+RwyhKAIpRG5lS47j2c+l1rdHP+0qhlYNqRooGsJcG+u91AUYg5Z5dfPimN8Txb
	 mJVqarLe7Qj8ldqvBUVR7TB5YrVnUPEO50Ol3sDeZkyEGOOxnk4G+CGQ56mODhxF7a
	 aeyZhH3LwHUE7tq8YcbPzPEcstv5CHI/epISHGClFcaDE/PIp+j3GznLbxScO19LGc
	 UHnw7fsDmhGuC5gASggSxDWKrNX/3HGhLCk8CTP/zaMPinLpamf6VbjdMTIO2l/4Ox
	 LrtHgvPi2poylI5EnjezNWD/G4MufvcOtT9JAxXDUYWcI/D6mtvQczmvRS4DSgtVjC
	 +r1FLpqOpY+WQ==
Date: Wed, 19 Aug 2026 10:03:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
 allocations
Message-ID: <aoVVNXbXvWarDkSR@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-5-90944a3ad43f@kernel.org>
 <20260816111727.0A6521F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816111727.0A6521F00A3D@smtp.kernel.org>

On Sun, Aug 16, 2026 at 11:17:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] execmem_cache_clean() calls vfree() on partial or interior chunks of a larger vmalloc allocation, causing a use-after-free for actively used regions.
> - [High] Unchecked return value of mas_store_gfp() during maple tree deletion can leave a dangling pointer in the free tree if deletion fails.
> - [Medium] Cache memory may never be freed because execmem_vmalloc() does not guarantee PMD_SIZE alignment on all architectures, preventing execmem_cache_clean() from matching its alignment checks.

Noted, will check which of those are real and address them with separate
patches.

-- 
Sincerely yours,
Mike.
