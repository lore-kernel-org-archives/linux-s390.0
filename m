Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313D84D02
	for <linux-s390@vger.kernel.org>; Tue,  9 Apr 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661285; cv=none; b=Fr3R0V6aK5j09nTQIAn7ZxiRxKiZvP3djaAOE6H3F3L4k8Y10CCymburYTU7g5kdm6iMmMrW0WkispZ7giiH1pyUwqzVSsJn2gVnABJgZ9egdGLayP75ZrOKYV8kdMX2GhHRyLBGxsX5THiuu6EYqewHNtDDFhlO1QLo7LSOEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661285; c=relaxed/simple;
	bh=g5WDgYmd1tGygYxCeeHhAYcVKdvhkUte9n/R9xJVUZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVhZtNDmzmj+8cJREtQ/87YO3T3yjw2E6sBRVUJuC7XV235Pm8Z7LdTF+wALGQEtDlC4p/CSEfNnnkiIGi+uSrE4uaxvFtILDvqK2BJz0ZgqAEmas5DBcBDdMfLnS/m4lMoUnlnVxOAQNGE5ZGJmVzP0lOOZbCnAHU9334rB8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC7C433F1;
	Tue,  9 Apr 2024 11:14:41 +0000 (UTC)
Date: Tue, 9 Apr 2024 12:14:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	surenb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/7] arm64: mm: cleanup __do_page_fault()
Message-ID: <ZhUjHkyIjalU0MAA@arm.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403083805.1818160-2-wangkefeng.wang@huawei.com>

On Wed, Apr 03, 2024 at 04:37:59PM +0800, Kefeng Wang wrote:
> The __do_page_fault() only calls handle_mm_fault() after vm_flags
> checked, and it is only called by do_page_fault(), let's squash
> it into do_page_fault() to cleanup code.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

As I reviewed v1 and the changes are minimal:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
