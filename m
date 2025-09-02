Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367812F3C0F;
	Tue,  2 Sep 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810645; cv=none; b=uEx7bgek7pfKZy0JC2TvSAIKW/oqGoFmUsnNXE5LtWr4D+UzgN798I4iAgD9v/Vo+u4rrB/H3zy49MmcDyGUHWYyanJb/0vpq+2yoSzjoImZBzaqUJfmpn/WPdXGwNTUCAL2UW/pcIiThAD6/AwKtF+/3BggXj8JMNp+G4M6YE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810645; c=relaxed/simple;
	bh=095NuIZ7Nx8c0fwOC2OSs+cDvccgtMlrYoeSjfTOcqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXEGOnoPQ87u7icFDaEfpzMFUkxzBvHlRDdTiBcnOu4WCQpwLHjBlO+HuA4EasKx3NN5yy/ciasLTuaxKwFZTuR3gJrkwCZQGHjJZOmkhgGZtWLePOlk+Totz4hYyG3QjSOpUAHw1WHNrktqZ2k3IavMyFlk+fbxdkulIfvdp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U19bxKED; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U19bxKED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A5C4CEF5;
	Tue,  2 Sep 2025 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756810644;
	bh=095NuIZ7Nx8c0fwOC2OSs+cDvccgtMlrYoeSjfTOcqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U19bxKEDTS2pl8YXrvOUOiOOiHTIAO1t3vzP+lNrLWXbKtcH/rW8K58r9I/DFwXZQ
	 KKANo+dhBTGZ2QEpTNoRVugjRz+PXRneWl73Z3M1PjupoeBDcSnESAA8BCcBbtFgzB
	 TKl/IuFL3r97oTI7JTDGFJ/O8jcR3yJwYnH6xItZGA/vWC1klv7Ta7e2nnqhbLiwfF
	 GBKMznnSxXtz+S2eQ7AU3FdpMlKDkJEpyW9goog22j31cMfjT/AZ+pH9r3o2mfXSjn
	 OdeEwbYi0gFpNcp5vQcsFv/d3ZNcbNGSlXR1TFL97sBKoF+PiO77gUSwI69FQsHPnY
	 HcioZpzP6CKng==
Date: Tue, 2 Sep 2025 12:57:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com, 
	broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au, 
	nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 04/12] fs: constify mapping related test functions for
 improved const-correctness
Message-ID: <20250902-einblick-nichtig-c4fe7fa5ae6f@brauner>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-5-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-5-max.kellermann@ionos.com>

On Mon, Sep 01, 2025 at 10:50:13PM +0200, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
