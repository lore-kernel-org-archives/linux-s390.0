Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB328369D;
	Sun, 21 Dec 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342949; cv=none; b=Pj7tq9zMjjWkO3WyVjCjC0TYIWUn2wGGRdwKq/wRQEBk+MANeSb//M20R1bONyxpm6epZ3Ppm+Wb4lC9d2FrrYOpBhWdcAhX1ipxVBdg02XrE5xmH2fHHir5/kgXz4HG32AzetTUvZY9L8Um1M5G98YZcm1S9DY3zqOqCfwu/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342949; c=relaxed/simple;
	bh=IJXA+QzQQpGmzrjmRsOKwVn2upf0r1hQr276K/HQbNg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oXbnuW4oZsh3kBjzS10DxDlUDjtxPrj9pH989cNcL4wdGT+6A6y7BL7kTRi06ft+1lLSxlUa6ZlSjbVHJP/GoDc5lB++wQDVPwdZH6mYlvB1C6rboF9V0rM5dGc8tRgZYHVSvbknobLCjnTrhjwN2LkMiXP9yAlTIGgf9hN4kLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nJr+00XR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nJr+00XR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87ECC4CEFB;
	Sun, 21 Dec 2025 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766342948;
	bh=IJXA+QzQQpGmzrjmRsOKwVn2upf0r1hQr276K/HQbNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJr+00XRdPtzlvH9JOjETY8okc5IoS3PxdQmW9oo668Rvqkalq9mXrLUjB0AbsyW/
	 eIKKrW8sm5ef9jKskfyVXa7x3lRrVXMySdJZN2ki5xU01eOomWskWSJRcFhhR668sx
	 3LiGEKDsBGq2NxgVr0zHtc+LHnCm1WTs0bAiuqPg=
Date: Sun, 21 Dec 2025 10:49:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
Message-Id: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
In-Reply-To: <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
	<87a4zcml36.ritesh.list@gmail.com>
	<655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 10:22:44 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> > 
> > My main concern was -
> > A fixes tag means it might get auto backported to stable kernels too,
> 
> Not in the MM world -- IIRC. I think there is the agreement, that we 
> decide what should go into stable and what not.
> 
> Andrew can correct me if my memory is wrong.

Yes, -stable maintainers have been asked to only backport patches where
the MM developers asked for that, with cc:stable.  There may be
slipups, but as far as I know this is working.

I don't actually know how they determine which patches need this
special treatment.  Pathname?  Signed-off-by:akpm?

> But we can always jump in and say that something should not go to stable 
> trees.

Yes, please jump in if there are any thoughts about
ordering/priority/timing.  In fact, please jump in if there are any
thoughts at all ;)

