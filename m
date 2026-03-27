Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797734A79A;
	Fri, 27 Mar 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630060; cv=none; b=nsOwQkIfAM+qZiWScDVd3DalgTVPMSwaYnBq+krqMktxgZkZj8PxVep++cC1/Q6jTRg5VO/XVAXlc4URR3UZ0g7G3R5MP1BunDoZko22547QSfjxSrR3Q2gj9GYuWblSAbhu5zLVqZEqCD61/PWUNoGZoz3liicy/JCUzOBhKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630060; c=relaxed/simple;
	bh=zCHu6vdwFKPQuNA2ItrsbdYzJ6DJHAS5OipAXB0fjEs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CZppH51DmVogYGjmhLI7KiPEqMGS+b6KUGJTs/PPwGaPTiCX4ILaMPvQ39O8I2DRU6mY4yPGdBzr8F+cHt1mKapJAmSd3bP/pGF0/r5dn17xg4DjYHo+8SEudvxzgf+OVjasOSEKeydV43XRoG8ZrJA6oNgN84aj0EXn8dheLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n03tXMcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n03tXMcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0CEC19423;
	Fri, 27 Mar 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774630060;
	bh=zCHu6vdwFKPQuNA2ItrsbdYzJ6DJHAS5OipAXB0fjEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n03tXMcpjjYNt0Hx9YQwbPGwEDXWZKfUKohUo5ohPUHbPx+f8qh+KDZeTzpBbg3/7
	 LokGmm0Pw75YvFbCHRFosn/8qYVSWw0qa92DFLMAQG6xmDRvM6NK+zWmACR7qoWvYF
	 QyWcblJX4j+wv1GSRREER4cGbV/YrZaU//IBoy1I=
Date: Fri, 27 Mar 2026 09:47:38 -0700
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
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-Id: <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 01:08:30 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Now that we have vma_start_write_killable() we can replace most of the
> vma_start_write() calls with it, improving reaction time to the kill
> signal.
> 
> There are several places which are left untouched by this patchset:
> 
> 1. free_pgtables() because function should free page tables even if a
> fatal signal is pending.
> 
> 2. userfaultd code, where some paths calling vma_start_write() can
> handle EINTR and some can't without a deeper code refactoring.
> 
> 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> and operates on a remote mm. Incomplete operations here would result
> in an inconsistent cgroup state.
> 
> 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> vma_start_write() out of these functions and replacing it with
> vma_assert_write_locked(), then callers of these functions should
> lock the vma themselves using vma_start_write_killable() whenever
> possible.

Thanks, I added this to mm-new.

It doesn't appear to fix anything and it has no
appreciable&measured performance benefits, so I just broke my own rule.

Weasel words: Lorenzo would like it in 7.0, unreviewed patches in
mm-unstable&mm-new are down to 62 and I'm a sucker for nice patchsets.

Three of your patches lack review tags so now it's 65!
