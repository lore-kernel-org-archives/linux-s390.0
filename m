Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F221CC66;
	Wed, 26 Feb 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599145; cv=none; b=kjL8wOdz1dn+KQShpH6fKYNOML4yL2b+O+do1NLxOet+EIGid9XltMHjzt7Rl4sX7FKkvDxCbwlOQvXin3ueaHjtJeS2WShGVimf6TGWAIfvzVql4ZQXQoUPYsXwYTa3BGDQu+WgUNHqX4X7VgFolvQNcyVmaRMSV+U1ekMGfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599145; c=relaxed/simple;
	bh=GuZ3Jq5tKDhMrGOl9x2V2OcZVxhCX6UW+4o9O2YPZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn3Q2XLkxJinc2u0bUwXkXrkJn+dTPTW86rxMgXmDfZod++YPG4cjnjq/PC5RAioJ0LMaheLfu85Oy5LbR/5do2wziE5oAGZOU9g7r8ilNCt4lrWsGouazCa8489a4lR31/dGub93uNCVVI677jI2Gvb/mAFotyt9YUb31orsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4275C4CED6;
	Wed, 26 Feb 2025 19:45:40 +0000 (UTC)
Date: Wed, 26 Feb 2025 19:45:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH V3 3/5] docs: arm64: Drop PTDUMP config options from
 ptdump.rst
Message-ID: <Z79vYibFJl7--Tmw@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
 <20250226122404.1927473-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226122404.1927473-4-anshuman.khandual@arm.com>

On Wed, Feb 26, 2025 at 05:54:02PM +0530, Anshuman Khandual wrote:
> Both GENERIC_PTDUMP and PTDUMP_CORE are not user selectable config options.
> Just drop these from documentation.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
