Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713635BDD5;
	Sun, 22 Mar 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774196246; cv=none; b=ELhdKkPYqLo067izPVor68j5YMQ+YX62TXcE/c8Iy1wP0SvRkqVNHpKtGR9mn4IqTKjwG8T0Y+RlfZF+FTcUlZb4GjiJ4PxfSsamu+7fH72CuRMdlfPUO5PV8Ujug2EKGHfe7FNK/7njqUxNO1wnWsmSUWYg5PMU41VE/C2bCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774196246; c=relaxed/simple;
	bh=xn7acWrcNfOM9ZzwScwVBSuLjXy+6p1AilKCtVPfDiw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YXXvIAJoTgqLexQ57REeOuITL6BI+u1oEPuE/8M2hq8AFS08UI1OAwulzfLUMzBaCiUDaqO2iMsQVs8V1XiDrLvaXiOUBhOyXmJXMcabTm7OssuKgS+1GE6RR5pXVbWVRNHq8p5gIfOq4go1L/hOaetMFh+UHE1HTb+kGqwu/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rqMEGL82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rqMEGL82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC38C19424;
	Sun, 22 Mar 2026 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774196245;
	bh=xn7acWrcNfOM9ZzwScwVBSuLjXy+6p1AilKCtVPfDiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqMEGL82CatXzSZUGssMlnUBlu7gibQcWJDmvlWNKM8wR3LI3RfabxRShgetGdnKM
	 qLVqViq53DE0oJ/EZ62HKok/IvlxVVVO2j8c2jdxjK1jRsQYexN6L6lz/p6Ea6GpOg
	 Z40l5OIIF154Wpf+2VLWVtL80h1i7JP6sGNOXwGg=
Date: Sun, 22 Mar 2026 09:17:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org,
 mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
Message-Id: <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Now that we have vma_start_write_killable() we can replace most of the
> vma_start_write() calls with it, improving reaction time to the kill
> signal.

Thanks.  Sashiko review raised a few possible issues:
	https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@google.com
