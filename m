Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5E2E091E;
	Thu, 26 Mar 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516736; cv=none; b=JDu4/QQV4IAcouVOSWJBXXipP7tTXfqVYjG3p7kazSKoS2uK/KsG3MC6IEvFi3dT2Tl9V/yfl7cytitZif/KF9TCQG1/8xSwmpknD4l3I13oPqAXuRlObByNgy3wkhORAqZ59a1FnZowD75eG0cXfEI99AflcEVUsF/GLBVSeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516736; c=relaxed/simple;
	bh=yUWBxeEHyviOPKRneK6j/gfx/J/uc8pAHvShiPb46kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j635BmuadtZcx+4XD/msfSUWMxg1hHAg2uYt4GT4+psosQNJmoBjz5Qs9/LN8PvBuQgZOfmfScZQcle4OF/E41QpIwLE4aKQNoRm+ahxr+LuUVwsk2ip3qY3qfOBYa1ZikYVOmWYeMf9XUA0+QDCJm7lRszxrc1TojXRsqWynQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGEvX/Tz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGEvX/Tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FB6C116C6;
	Thu, 26 Mar 2026 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774516735;
	bh=yUWBxeEHyviOPKRneK6j/gfx/J/uc8pAHvShiPb46kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGEvX/Tza/tjOvP+jwHZtAfsQ9i3c7zrE71IAVXMEBQFuXXBY8J8Q7ke9WuRoZPaA
	 Y+chvo99aGdYyVr/Ej6q7FyBK8u7WGGWRA7w0fOlldEtOkdpL64+VWh9BMNsNv3AvP
	 C24e0feiTo3fMQgLeEi0DEnVobzVj0a1HCmGQBIDe89k5m+My6w495OfsTJWLoTXTk
	 rW1jm4hUGy40vO8TEOhFBYjcPcB74lkZHpC2O6WO0jV8h/eZB2c+l21RdUfU2k8Ah1
	 Rs4/PMwca7YEl/l752V++FgB8s2oggoqcfw9t8psB+h6tVJgd7Iz5Q8Myq1/LinSjR
	 TSfqa9opHxHVg==
Date: Thu, 26 Mar 2026 09:18:53 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-ID: <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326080836.695207-1-surenb@google.com>

-cc old email

(Gentle reminder to please send all new stuff to ljs@kernel.org - at some
point I'm going to set a rule to ignore kernel mail sent to the old address
so, if you need a response you should send to the new :)


On Thu, Mar 26, 2026 at 01:08:30AM -0700, Suren Baghdasaryan wrote:
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
>
> Changes since v4 [1]:
> - added Reviewed-by, per Barry Song and Lorenzo Stoakes (wherever the code
> stayed the same)
> - split patch 2 into 3 parts, per Lorenzo Stoakes
> - converted vma_start_write() in mseal_apply(), per Sashiko
> - changed vma_start_write_killable() error handling in
> set_mempolicy_home_node(), per Lorenzo Stoakes
> - added comment why mm->locked_vm is fine even when we exit early,
> per Sashiko
> - moved vma locking before vrm_calc_charge() in move_vma(), per Sashiko
> and Lorenzo Stoakes
> - set give_up_on_oom on error in vma_merge_existing_range() to propagate
> the error, per Lorenzo Stoakes
> - moved validate_mm() out of the error path in expand_upwards(),
> per Lorenzo Stoakes
> - dropped the patch changing S390 error handling, per Sashiko and
> Lorenzo Stoakes
> - reworked error handling in clear_refs_write(), per Lorenzo Stoakes
> - uninlined process_vma_walk_lock() while changing its return type,
> per Lorenzo Stoakes
>
> [1] https://lore.kernel.org/all/20260322054309.898214-1-surenb@google.com/
>
> Suren Baghdasaryan (6):
>   mm/vma: cleanup error handling path in vma_expand()
>   mm: use vma_start_write_killable() in mm syscalls
>   mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
>   mm/vma: use vma_start_write_killable() in vma operations
>   mm: use vma_start_write_killable() in process_vma_walk_lock()
>   KVM: PPC: use vma_start_write_killable() in
>     kvmppc_memslot_page_merge()
>
>  arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
>  fs/proc/task_mmu.c                 |  12 +--
>  mm/khugepaged.c                    |   5 +-
>  mm/madvise.c                       |   4 +-
>  mm/memory.c                        |   2 +
>  mm/mempolicy.c                     |  12 ++-
>  mm/mlock.c                         |  28 ++++--
>  mm/mprotect.c                      |   5 +-
>  mm/mremap.c                        |   8 +-
>  mm/mseal.c                         |   5 +-
>  mm/pagewalk.c                      |  22 +++--
>  mm/vma.c                           | 146 +++++++++++++++++++++--------
>  mm/vma_exec.c                      |   6 +-
>  13 files changed, 190 insertions(+), 70 deletions(-)
>
>
> base-commit: e53c9040ab1b738dd2c83b57558f141902caaf4f
> --
> 2.53.0.1018.g2bb0e51243-goog
>
