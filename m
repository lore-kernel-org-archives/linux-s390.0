Received: from iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.216.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684A3D9DD2;
	Fri, 10 Apr 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834274; cv=none; b=otmrcOjBnURwfTMVBOgVArpTCga6LsY8MK9VvXkWplU3Jm6XX2RjH9wklZtuaels7Y7Uu136vZWmFNsGAgGZRJj7bJiipWWmSBK5QHMpT0UWH2CUFvra9H0vWXq5Iw0cmMfUNlnUxtb+Jm5bu+7cfC0bBdFvQepoeP+7IUMQR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834274; c=relaxed/simple;
	bh=G9IbjlxQI5oDBYhkCvOyuQes6hXtB74Dw0d5QXYNEW8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XtFjkxcN8d/4mCKx8gdO+4X+DnkyK32VXczQZYoRocZh1DmL77A21Z4Y3f0BQ1J3H902GX9ux4JaZKrU3Q4oD1kc/ctYS2rIzkuOw1YEsI8ZX+i17uqkfW6XcG0+83NHSRUUQi7VkBJuf1Aw6Bub+Rcn1J4HoX87UWnh5J1QfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=cuvVTqxM; arc=none smtp.client-ip=3.216.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="cuvVTqxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1775834273; x=1807370273;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=8HieUWXwfTPL/TX57Qxi0290udRDGerg8ZVRI0leHrg=;
  b=cuvVTqxMKjsaDP+7IsXbk0YjkjsQVf7H+OEstXxN1LeSz1PevDyL18zx
   KndxyvsubODgP/ty6ujpWgPFguEciig9LukDFHoaoUznyU8Kdwx3P+pyi
   drPzGsXb4kop1kW7v6dk7mMMM8M0fOMqfcdfbkuAIAVZoG1mTSn3jnhBt
   AWdPRVtePybpQO6z820A7a9t/q2UnKbV7Sy1sQsRvUW7tslh4/CqZe0yq
   rC1EAXkK3mS7e//mq8mlcP4PR0pZtZ5GT2rvZXxuDG/qYrkkMX8NLh433
   MDCCN5zHqPPAEazoMK2lbk/vwbDgtBcF6yA49DXgxTzeg7Fp1Yt2tUiXN
   g==;
X-CSE-ConnectionGUID: 3b8vreyoQF+JHxAkoMc12w==
X-CSE-MsgGUID: 7nws4pUrSTqpAuILmVnHgQ==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15982000"
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:17:48 +0000
Received: from EX19MTAUEB001.ant.amazon.com [72.21.198.67:20021]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.29.254:2525] with esmtp (Farcaster)
 id cbca5809-ea98-4c81-9ff3-7d14d4c26b47; Fri, 10 Apr 2026 15:17:48 +0000 (UTC)
X-Farcaster-Flow-ID: cbca5809-ea98-4c81-9ff3-7d14d4c26b47
Received: from EX19D027UEC001.ant.amazon.com (10.252.137.156) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:17:48 +0000
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19D027UEC001.ant.amazon.com (10.252.137.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:17:47 +0000
Received: from EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d]) by
 EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d%3]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 15:17:47 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com"
	<riel@surriel.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jgross@suse.com" <jgross@suse.com>, "yu-cheng.yu@intel.com"
	<yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com"
	<coxu@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"tabba@google.com" <tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>,
	"wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro"
	<itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Kalyazin,
 Nikita" <kalyazin@amazon.co.uk>, Nikita Kalyazin <nikita.kalyazin@linux.dev>
Subject: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
Thread-Topic: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
Thread-Index: AQHcyP0wLRkmRDUt+U2dSCwqaTZUYg==
Date: Fri, 10 Apr 2026 15:17:47 +0000
Message-ID: <20260410151746.61150-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
=0A=
[ based on kvm/next ]=0A=
=0A=
Unmapping virtual machine guest memory from the host kernel's direct map=0A=
is a successful mitigation against Spectre-style transient execution=0A=
issues: if the kernel page tables do not contain entries pointing to=0A=
guest memory, then any attempted speculative read through the direct map=0A=
will necessarily be blocked by the MMU before any observable=0A=
microarchitectural side-effects happen.  This means that Spectre-gadgets=0A=
and similar cannot be used to target virtual machine memory.  Roughly=0A=
60% of speculative execution issues fall into this category [1, Table=0A=
1].=0A=
=0A=
This patch series extends guest_memfd with the ability to remove its=0A=
memory from the host kernel's direct map, to be able to attain the above=0A=
protection for KVM guests running inside guest_memfd.=0A=
=0A=
Additionally, a Firecracker branch with support for these VMs can be=0A=
found on GitHub [2].=0A=
=0A=
For more details, please refer to the v5 cover letter.  No substantial=0A=
changes in design have taken place since.=0A=
=0A=
See also related write() syscall support in guest_memfd [3] where=0A=
the interoperation between the two features is described.=0A=
=0A=
Changes since v11:=0A=
 - Ackerley/Sashiko: fix previously missed __set_pages_* argument update=0A=
   in __kernel_map_pages (patch 1)=0A=
 - David: disallow large folios in folio_zap_direct_map (patch 2)=0A=
 - David/Sashiko: check for folio_is_zone_device if mapping is NULL in=0A=
   gup_fast_folio_allowed (patch 4)=0A=
 - Ackerley/Sashiko: kvm_arch_gmem_supports_no_direct_map to return=0A=
   false for SEV-SNP (patch 8).=0A=
 - David: replace a redundant check for GUEST_MEMFD_FLAG_NO_DIRECT_MAP=0A=
   with a WARN_ON_ONCE (patch 10)=0A=
 - David: assert the folio is locked when zapping direct map (patch 10)=0A=
 - Ackerley/Sashiko: reorder operations to "zap then prepare" and=0A=
   "invalidate then restore" (patch 10)=0A=
=0A=
v11: https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com=
=0A=
v10: https://lore.kernel.org/kvm/20260126164445.11867-1-kalyazin@amazon.com=
=0A=
v9: https://lore.kernel.org/kvm/20260114134510.1835-1-kalyazin@amazon.com=
=0A=
v8: https://lore.kernel.org/kvm/20251205165743.9341-1-kalyazin@amazon.com=
=0A=
v7: https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus=
.lmu.de=0A=
v6: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk=
=0A=
v5: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk=
=0A=
v4: https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.u=
k=0A=
RFCv3: https://lore.kernel.org/kvm/20241030134912.515725-1-roypat@amazon.co=
.uk=0A=
RFCv2: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon.c=
o.uk=0A=
RFCv1: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.c=
o.uk=0A=
=0A=
[1] https://download.vusec.net/papers/quarantine_raid23.pdf=0A=
[2] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-=
hiding=0A=
[3] https://lore.kernel.org/kvm/20251114151828.98165-1-kalyazin@amazon.com=
=0A=
=0A=
Nikita Kalyazin (4):=0A=
  set_memory: set_direct_map_* to take address=0A=
  set_memory: add folio_{zap,restore}_direct_map helpers=0A=
  mm/secretmem: make use of folio_{zap,restore}_direct_map=0A=
  mm/gup: drop local variable in gup_fast_folio_allowed=0A=
=0A=
Patrick Roy (12):=0A=
  mm/gup: drop secretmem optimization from gup_fast_folio_allowed=0A=
  mm: introduce AS_NO_DIRECT_MAP=0A=
  KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate=0A=
  KVM: x86: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: arm64: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: guest_memfd: Add flag to remove from direct map=0A=
  KVM: selftests: load elf via bounce buffer=0A=
  KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd=0A=
    !=3D -1=0A=
  KVM: selftests: Add guest_memfd based vm_mem_backing_src_types=0A=
  KVM: selftests: cover GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing=0A=
    selftests=0A=
  KVM: selftests: stuff vm_mem_backing_src_type into vm_shape=0A=
  KVM: selftests: Test guest execution from direct map removed gmem=0A=
=0A=
 Documentation/virt/kvm/api.rst                | 21 +++---=0A=
 arch/arm64/include/asm/kvm_host.h             | 13 ++++=0A=
 arch/arm64/include/asm/set_memory.h           |  7 +-=0A=
 arch/arm64/mm/pageattr.c                      | 19 +++--=0A=
 arch/loongarch/include/asm/set_memory.h       |  7 +-=0A=
 arch/loongarch/mm/pageattr.c                  | 25 +++----=0A=
 arch/riscv/include/asm/set_memory.h           |  7 +-=0A=
 arch/riscv/mm/pageattr.c                      | 17 +++--=0A=
 arch/s390/include/asm/set_memory.h            |  7 +-=0A=
 arch/s390/mm/pageattr.c                       | 13 ++--=0A=
 arch/x86/include/asm/kvm_host.h               |  6 ++=0A=
 arch/x86/include/asm/set_memory.h             |  7 +-=0A=
 arch/x86/kvm/x86.c                            |  7 ++=0A=
 arch/x86/mm/pat/set_memory.c                  | 27 +++----=0A=
 include/linux/kvm_host.h                      | 14 ++++=0A=
 include/linux/pagemap.h                       | 16 ++++=0A=
 include/linux/secretmem.h                     | 18 -----=0A=
 include/linux/set_memory.h                    | 22 +++++-=0A=
 include/uapi/linux/kvm.h                      |  1 +=0A=
 kernel/power/snapshot.c                       |  4 +-=0A=
 lib/buildid.c                                 |  8 +-=0A=
 mm/execmem.c                                  |  6 +-=0A=
 mm/gup.c                                      | 47 ++++++------=0A=
 mm/memory.c                                   | 45 +++++++++++=0A=
 mm/mlock.c                                    |  2 +-=0A=
 mm/secretmem.c                                | 18 ++---=0A=
 mm/vmalloc.c                                  | 11 ++-=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 17 ++++-=0A=
 .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++---=0A=
 .../testing/selftests/kvm/include/test_util.h |  8 ++=0A=
 tools/testing/selftests/kvm/lib/elf.c         |  8 +-=0A=
 tools/testing/selftests/kvm/lib/io.c          | 23 ++++++=0A=
 tools/testing/selftests/kvm/lib/kvm_util.c    | 59 ++++++++-------=0A=
 tools/testing/selftests/kvm/lib/test_util.c   |  8 ++=0A=
 tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +=0A=
 .../selftests/kvm/pre_fault_memory_test.c     |  1 +=0A=
 .../selftests/kvm/set_memory_region_test.c    | 52 ++++++++++++-=0A=
 .../kvm/x86/private_mem_conversions_test.c    |  7 +-=0A=
 virt/kvm/guest_memfd.c                        | 75 +++++++++++++++++--=0A=
 39 files changed, 489 insertions(+), 202 deletions(-)=0A=
=0A=
=0A=
base-commit: 24f9515de8778410e4b84c85b196c9850d2c1e18=0A=
-- =0A=
2.50.1=0A=
=0A=
