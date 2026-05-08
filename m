Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35336403A;
	Fri,  8 May 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228319; cv=none; b=c43kfh65tIJ0DrHDOcEoV5MKayoOfqYTMGOklFOMB5wjwT8t5L5/WcOKEH2xWt95J9tGscIuejjUPEazYxjw83J7417IOGU69P8ZqAeilP9l8RiEmzlfl3Y2tsZt6nIBdy5/bP+I4CGmi43Iz0xQ9YKDdw8PMhW9yTIGuCuRISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228319; c=relaxed/simple;
	bh=Jc3PpcNd3ZxX08IHUJtRP179UXyMvc29rNhuJm7NkoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVqVnJ+RxrMKTf0e0WUu1dNoR72yBGnG4/417ywyKyYb3YvWSSgudHFXC7vusVZ+1DAEJ5+qKJtx0T8f6i4blYzDQJLH7UQOcoE7CV5hNxcerIMZN+H7oHcH5EQkxyY8vM4/iVgQJG2QLGCEg89f7zcmdi5P67s7lq0zqmNl82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mpDmhIDH; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mpDmhIDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778228318; x=1809764318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=he6DON9jfdhSLBt5e/vXn3CElWPL4k8qbH0NcK/2obw=;
  b=mpDmhIDHD9Z9dIBy2Xr9/PGUfqlwPzQOsrVF1L+8dRzQXh4VWb6Lknfu
   viYhguRusJq2uwxyhC7BLQ4Qer0k2W7yBTuSLHltw10UfN+LaTU/y2Yaw
   N4VEBsUzGEQENERkloUMUDXEVmAocjvKMEt+toFlc3hbW5QoqC4Htw829
   IpUSLopwAmAcPju6UHTPUIF7Rc9WMPZsbD6O0k2Qc3u1r2cr8Brp2fz2J
   QoMIEU83/+OD4CmftCgWXiQEzMi96JyC1ZGJ36tAljgfgWosM3FMPP6Q6
   vR18d8uiC9+3c16HSmqrgMYTNGrrhERX6iGxONV2frmr612c+VIJ7rmIB
   A==;
X-CSE-ConnectionGUID: T2XNpIqvShm0IOn66vQpwQ==
X-CSE-MsgGUID: K+8ujvsvQ+aWk2f8+1q5Sw==
X-IronPort-AV: E=Sophos;i="6.23,223,1770595200"; 
   d="scan'208";a="18948631"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:18:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:1235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id 181a188e-b1e1-456f-b102-a9f2c8f54015; Fri, 8 May 2026 08:18:34 +0000 (UTC)
X-Farcaster-Flow-ID: 181a188e-b1e1-456f-b102-a9f2c8f54015
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 8 May 2026 08:18:31 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 8 May 2026 08:18:18 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <fvdl@google.com>, <seanjc@google.com>, <ljs@kernel.org>
CC: <Liam.Howlett@oracle.com>, <ackerleytng@google.com>,
	<agordeev@linux.ibm.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <alex@ghiti.fr>, <andrii@kernel.org>,
	<aou@eecs.berkeley.edu>, <ast@kernel.org>, <baolu.lu@linux.intel.com>,
	<borntraeger@linux.ibm.com>, <bp@alien8.de>, <bpf@vger.kernel.org>,
	<catalin.marinas@arm.com>, <chenhuacai@kernel.org>, <corbet@lwn.net>,
	<coxu@redhat.com>, <daniel@iogearbox.net>, <dave.hansen@linux.intel.com>,
	<david@kernel.org>, <derekmn@amazon.com>, <dev.jain@arm.com>,
	<eddyz87@gmail.com>, <gerald.schaefer@linux.ibm.com>, <gor@linux.ibm.com>,
	<haoluo@google.com>, <hca@linux.ibm.com>, <hpa@zytor.com>,
	<itazur@amazon.co.uk>, <jackabt@amazon.co.uk>, <jackmanb@google.com>,
	<jannh@google.com>, <jgg@ziepe.ca>, <jgross@suse.com>, <jhubbard@nvidia.com>,
	<jiayuan.chen@shopee.com>, <jmattson@google.com>, <joey.gouly@arm.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <jthoughton@google.com>,
	<kalyazin@amazon.co.uk>, <kas@kernel.org>, <kernel@xen0n.name>,
	<kpsingh@kernel.org>, <kvm@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<lenb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <lorenzo.stoakes@oracle.com>, <luto@kernel.org>,
	<maobibo@loongson.cn>, <martin.lau@linux.dev>, <maz@kernel.org>,
	<mhocko@suse.com>, <mingo@redhat.com>, <mlevitsk@redhat.com>,
	<nikita.kalyazin@linux.dev>, <oupton@kernel.org>, <palmer@dabbelt.com>,
	<patrick.roy@linux.dev>, <pavel@kernel.org>, <pbonzini@redhat.com>,
	<peterx@redhat.com>, <peterz@infradead.org>, <pfalcato@suse.de>,
	<pjw@kernel.org>, <prsampat@amd.com>, <rafael@kernel.org>,
	<riel@surriel.com>, <rppt@kernel.org>, <ryan.roberts@arm.com>,
	<sdf@fomichev.me>, <shijie@os.amperecomputing.com>,
	<skhan@linuxfoundation.org>, <song@kernel.org>, <surenb@google.com>,
	<suzuki.poulose@arm.com>, <svens@linux.ibm.com>, <tabba@google.com>,
	<tglx@kernel.org>, <thuth@redhat.com>, <urezki@gmail.com>,
	<vannapurve@google.com>, <vbabka@kernel.org>, <will@kernel.org>,
	<willy@infradead.org>, <wu.fei9@sanechips.com.cn>, <x86@kernel.org>,
	<yang@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
	<yonghong.song@linux.dev>, <yosry@kernel.org>, <yu-cheng.yu@intel.com>,
	<yuzenghui@huawei.com>, <zhengqi.arch@bytedance.com>, <zulinx86@gmai.com>
Subject: Re: [PATCH v12 10/16] KVM: guest_memfd: Add flag to remove from direct map
Date: Fri, 8 May 2026 08:18:10 +0000
Message-ID: <20260508081812.12345-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAPTztWb67XZvfcMVnbegDNNW0LJa9UsaTGx3M898xJUJrekk0w@mail.gmail.com>
References: <CAPTztWb67XZvfcMVnbegDNNW0LJa9UsaTGx3M898xJUJrekk0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Sean, Frank, Lorenzo,

On Tue, Apr 21, 2026 at 10:08:48AM -0700, Frank van der Linden wrote:
> On Tue, Apr 21, 2026 at 9:31 AM Sean Christopherson <seanjc@google.com> w=
rote:
> > Making guest_memfd responsible for zapping and restoring the direct map=
 on a per-
> > folio basis feels wrong given the addition of AS_NO_DIRECT_MAP.  I espe=
cially don't
> > like that the "rules" for when an AS_NO_DIRECT_MAP folio has a direct m=
ap will vary
> > based on the owner, and even within an owner (e.g. guest_memfd) will be=
 ad hoc.
> >
> > E.g. as per the series to add guest_memfd write() support[*]:
> >
> >   When direct map removal is implemented [2]
> >    - write() will not be allowed to access pages that have already
> >      been removed from direct map
> >    - on completion, write() will remove the populated pages from
> >      direct map
> >
> > That's pretty gross ABI, because with KVM_GMEM_FOLIO_NO_DIRECT_MAP, use=
rspace can
> > write() exactly once.  To re-write memory, I assume userspace would nee=
d to do a
> > PUNCH_HOLE or truncate.
> >
> > What's preventing us from handling this automagically in e.g. filemap_a=
dd_folio()
> > and filemap_remove_folio()?  Then the usage rules are pretty straightfo=
rward: the
> > kernel must *always* assume the direct map is invalid for folios from
> > AS_NO_DIRECT_MAP mappings.
> >
> > Then if KVM needs to utilize a kernel mapping, e.g. in kvm_gmem_populat=
e(), KVM
> > could use dedicated variants of kmap_local_xxx() to deal with a local m=
apping for
> > a folio/page without a direct map.  Or, KVM could simply disallow the s=
pecific
> > sequence that would require KVM to do the memcpy (I'm pretty sure we ca=
n do that
> > with in-place shared=3D>private conversion support).
> >
> > I realize that could throw a big wrench into write() performance, but I=
MO, before
> > merging either series, we need a complete story for exactly how this wi=
ll all fit
> > together, in a maintainable fashion and with sane ABI.
>
> I agree with this - this approach would also allow for memory that was
> never in the direct map to begin with, or has been taken out already
> (for which I happen to have a use case :-)). guest_memfd and other
> code can then assume that AS_NO_DIRECT_MAP means they have to take
> explicit action to map it if needed. It's a clean, simple ABI.
>
> With the current set of patches, it seems like this couldn't be done
> in a clean manner.

Agreed with both of you.  I'll adopt the filemap-level approach:

- Move the zap/restore hooks from guest_memfd into filemap_add_folio()
  / filemap_remove_folio().
- Tighten AS_NO_DIRECT_MAP semantics so that, for folios in such a
  mapping, the direct map is invalid for the entire time the folio
  resides in the page cache.
- Drop the per-folio KVM_GMEM_FOLIO_NO_DIRECT_MAP bookkeeping in
  folio->private, since the existence of the folio in the mapping is
  itself the state.

On each guest memory population path,

- memcpy-based population from userspace goes through the userspace
  mapping of guest_memfd, not through the kernel direct map, so the
  filemap-level invariant doesn't affect it.  But this is slow, which
  is what motivated the write() syscall support.

- write(): meant to speed up the userspace-memcpy case above by doing
  the copy in the kernel.  I believe Brendan's __GFP_UNMAPPED/mermap
  work [1] would give us a low-overhead way to get temporary kernel
  access to an AS_NO_DIRECT_MAP.  Landing mermap may take a while, but
  this series does not introduce the write() path, so mermap is not a
  blocker for now.

- kvm_gmem_populate(): this is a TDX/SNP-only path, and NO_DIRECT_MAP
  is not available on those VM types =E2=80=94
  kvm_arch_gmem_supports_no_direct_map() returns false for
  KVM_X86_TDX_VM and KVM_X86_SNP_VM, which are its only callers
  today.  So it doesn't interact with the filemap invariant IIUC.

So, unless I'm missing any path, adopting the filemap-level approach in
this series should be fine.


I'd like to consult with you folks on how to proceed in advance.  In a
separate reply on the cover letter thread [2], Lorenzo and Sean
suggested that the mm pieces should go through the mm subsystem:

On Tue, Apr 21, 2026 at 04:36:00PM +0000, Sean Christopherson wrote:
> Yeah, when the time comes, the mm pieces definitely need to go through th=
e mm
> tree.  Ideally, I think this would be merged in two separate parts, with =
all mm
> changes going through the mm tree, and then the KVM changes through the K=
VM tree
> using a stable topic branch/tag from Andrew.

I see two reasonable paths to get there, and would appreciate your
input on which you prefer:

Path A =E2=80=94 validate on KVM side first, then split:
  - Post v13 as a single series on the KVM list, gather feedback and
    make sure the design is acceptable to KVM reviewers.
  - Once v13 looks good ("the time comes"), do the MM/KVM split,
    rebase the MM part onto the appropriate MM branch, and post the
    MM part to linux-mm to build consensus with MM maintainers.

Path B =E2=80=94 split early and seek MM consensus in parallel:
  - With the filemap rework already in place, do the MM/KVM split
    now and post the MM part to linux-mm directly.  The KVM part follows
    on top of a stable topic from MM.

Which of the two would you rather see?  Happy to go either way.


[1] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54=
f41@google.com/
[2] https://lore.kernel.org/all/20260506080753.14517-1-itazur@amazon.com/

Takahiro

