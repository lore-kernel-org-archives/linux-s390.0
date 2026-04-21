Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3163A4F58;
	Tue, 21 Apr 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778824; cv=none; b=t7bYCdQVU4MzJhOYezzxYO+HX9elO2omd1rDJja04s/0HzfFhCQ4+/6aMB03SQxMcLgPCBtBLFtvQfrEpGi9PPxmrrHBMvrtmOUpFD1qj9E2qaF3tRb+4FXjbXaExF79mE0z+Y3ZSGOOU5i9d01wMMI4ehooxx5RGfyCXLvPDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778824; c=relaxed/simple;
	bh=vIZhXnlC6WemEIo1i/UKx7MP0mQPp/95QfMD/4Qm33E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+NCJEhwuOZKazJsoKgJ4rliVIYXE9/uGalNrXHFGaU87tDiwQSkNe+bDFUyPRu+/3JNwOjmvgNjvFiwDFNC/5xSfHCHC+F+AzujqulG1O1VcegxJ77WneXpGhIhitgfFhQMnDTmj1N62qBelraR1p/stsINQ301YZ4pqlwhQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM9M+cAM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM9M+cAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960EEC2BCB0;
	Tue, 21 Apr 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776778823;
	bh=vIZhXnlC6WemEIo1i/UKx7MP0mQPp/95QfMD/4Qm33E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM9M+cAMwYtyZ/A/5TpgIRwCop4cQGETyptMq9v/u2ZyABhJIYqmVqEGj6kj7c0mc
	 xVYYEi62APJ5T0XXKihQl9hGTj5ZtXlke6J/Oqhu0yujsLCZlQ35h7lYIiUHPsp3/Q
	 MEGMsjCnycG6EP/nstht7LFTGqTG5E3lf4DO2oXz1tQIJHkLI9zm985r40lziN5vJt
	 ZX6DHRJOKSx9g6w9ICOHxWviHfREB7F9Q1M+sqOjSAaoY8J/F7drcEQGW9bPd+LvjL
	 hT5ZNQlmw5CPWPkFI+zi0Y6WHB3LXv5kYwCB41ifJu8Dl1sVO7dWr012VlzGKaZwZ4
	 MXoEiOoy31ijA==
Date: Tue, 21 Apr 2026 14:40:21 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"david@kernel.org" <david@kernel.org>, "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com" <jannh@google.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "yosry@kernel.org" <yosry@kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"tabba@google.com" <tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>, 
	"wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"jmattson@google.com" <jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com" <thuth@redhat.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"urezki@gmail.com" <urezki@gmail.com>, "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, 
	"lenb@kernel.org" <lenb@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>
Subject: Re: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
Message-ID: <aed88qcV6PjEIHnd@lucifer>
References: <20260410151746.61150-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410151746.61150-1-kalyazin@amazon.com>

On Fri, Apr 10, 2026 at 03:17:47PM +0000, Kalyazin, Nikita wrote:
> From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
>
> [ based on kvm/next ]

Hm, given this touches a fair bit of mm, I wonder if we shouldn't try to do this
through the mm tree?

In any case, we definitely need a rebase on something not-next :) if not mm then
Linus's tree at least maybe?

I'm seeing a lot of conflicts against mm-unstable, it can't b4 shazam even patch
1 and in Linus's tree it's failing at an mm patch (mm: introduce
AS_NO_DIRECT_MAP).

That and 'KVM: selftests: Add guest_memfd based vm_mem_backing_src_types' won't
apply, but that one's trivial at least.

Obviously we're in the merge window right now so maybe best to do any rebasing a
little after 7.1-rc1?

Cheers, Lorenzo

>
> Unmapping virtual machine guest memory from the host kernel's direct map
> is a successful mitigation against Spectre-style transient execution
> issues: if the kernel page tables do not contain entries pointing to
> guest memory, then any attempted speculative read through the direct map
> will necessarily be blocked by the MMU before any observable
> microarchitectural side-effects happen.  This means that Spectre-gadgets
> and similar cannot be used to target virtual machine memory.  Roughly
> 60% of speculative execution issues fall into this category [1, Table
> 1].
>
> This patch series extends guest_memfd with the ability to remove its
> memory from the host kernel's direct map, to be able to attain the above
> protection for KVM guests running inside guest_memfd.
>
> Additionally, a Firecracker branch with support for these VMs can be
> found on GitHub [2].
>
> For more details, please refer to the v5 cover letter.  No substantial
> changes in design have taken place since.
>
> See also related write() syscall support in guest_memfd [3] where
> the interoperation between the two features is described.
>
> Changes since v11:
>  - Ackerley/Sashiko: fix previously missed __set_pages_* argument update
>    in __kernel_map_pages (patch 1)
>  - David: disallow large folios in folio_zap_direct_map (patch 2)
>  - David/Sashiko: check for folio_is_zone_device if mapping is NULL in
>    gup_fast_folio_allowed (patch 4)
>  - Ackerley/Sashiko: kvm_arch_gmem_supports_no_direct_map to return
>    false for SEV-SNP (patch 8).
>  - David: replace a redundant check for GUEST_MEMFD_FLAG_NO_DIRECT_MAP
>    with a WARN_ON_ONCE (patch 10)
>  - David: assert the folio is locked when zapping direct map (patch 10)
>  - Ackerley/Sashiko: reorder operations to "zap then prepare" and
>    "invalidate then restore" (patch 10)
>
> v11: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com
> v10: https://lore.kernel.org/kvm/20260126164445.11867-1-kalyazin@amazon.com
> v9: https://lore.kernel.org/kvm/20260114134510.1835-1-kalyazin@amazon.com
> v8: https://lore.kernel.org/kvm/20251205165743.9341-1-kalyazin@amazon.com
> v7: https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus.lmu.de
> v6: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk
> v5: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk
> v4: https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk
> RFCv3: https://lore.kernel.org/kvm/20241030134912.515725-1-roypat@amazon.co.uk
> RFCv2: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon.co.uk
> RFCv1: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk
>
> [1] https://download.vusec.net/papers/quarantine_raid23.pdf
> [2] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
> [3] https://lore.kernel.org/kvm/20251114151828.98165-1-kalyazin@amazon.com
>
> Nikita Kalyazin (4):
>   set_memory: set_direct_map_* to take address
>   set_memory: add folio_{zap,restore}_direct_map helpers
>   mm/secretmem: make use of folio_{zap,restore}_direct_map
>   mm/gup: drop local variable in gup_fast_folio_allowed
>
> Patrick Roy (12):
>   mm/gup: drop secretmem optimization from gup_fast_folio_allowed
>   mm: introduce AS_NO_DIRECT_MAP
>   KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate
>   KVM: x86: define kvm_arch_gmem_supports_no_direct_map()
>   KVM: arm64: define kvm_arch_gmem_supports_no_direct_map()
>   KVM: guest_memfd: Add flag to remove from direct map
>   KVM: selftests: load elf via bounce buffer
>   KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd
>     != -1
>   KVM: selftests: Add guest_memfd based vm_mem_backing_src_types
>   KVM: selftests: cover GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing
>     selftests
>   KVM: selftests: stuff vm_mem_backing_src_type into vm_shape
>   KVM: selftests: Test guest execution from direct map removed gmem
>
>  Documentation/virt/kvm/api.rst                | 21 +++---
>  arch/arm64/include/asm/kvm_host.h             | 13 ++++
>  arch/arm64/include/asm/set_memory.h           |  7 +-
>  arch/arm64/mm/pageattr.c                      | 19 +++--
>  arch/loongarch/include/asm/set_memory.h       |  7 +-
>  arch/loongarch/mm/pageattr.c                  | 25 +++----
>  arch/riscv/include/asm/set_memory.h           |  7 +-
>  arch/riscv/mm/pageattr.c                      | 17 +++--
>  arch/s390/include/asm/set_memory.h            |  7 +-
>  arch/s390/mm/pageattr.c                       | 13 ++--
>  arch/x86/include/asm/kvm_host.h               |  6 ++
>  arch/x86/include/asm/set_memory.h             |  7 +-
>  arch/x86/kvm/x86.c                            |  7 ++
>  arch/x86/mm/pat/set_memory.c                  | 27 +++----
>  include/linux/kvm_host.h                      | 14 ++++
>  include/linux/pagemap.h                       | 16 ++++
>  include/linux/secretmem.h                     | 18 -----
>  include/linux/set_memory.h                    | 22 +++++-
>  include/uapi/linux/kvm.h                      |  1 +
>  kernel/power/snapshot.c                       |  4 +-
>  lib/buildid.c                                 |  8 +-
>  mm/execmem.c                                  |  6 +-
>  mm/gup.c                                      | 47 ++++++------
>  mm/memory.c                                   | 45 +++++++++++
>  mm/mlock.c                                    |  2 +-
>  mm/secretmem.c                                | 18 ++---
>  mm/vmalloc.c                                  | 11 ++-
>  .../testing/selftests/kvm/guest_memfd_test.c  | 17 ++++-
>  .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++---
>  .../testing/selftests/kvm/include/test_util.h |  8 ++
>  tools/testing/selftests/kvm/lib/elf.c         |  8 +-
>  tools/testing/selftests/kvm/lib/io.c          | 23 ++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 59 ++++++++-------
>  tools/testing/selftests/kvm/lib/test_util.c   |  8 ++
>  tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +
>  .../selftests/kvm/pre_fault_memory_test.c     |  1 +
>  .../selftests/kvm/set_memory_region_test.c    | 52 ++++++++++++-
>  .../kvm/x86/private_mem_conversions_test.c    |  7 +-
>  virt/kvm/guest_memfd.c                        | 75 +++++++++++++++++--
>  39 files changed, 489 insertions(+), 202 deletions(-)
>
>
> base-commit: 24f9515de8778410e4b84c85b196c9850d2c1e18
> --
> 2.50.1
>
