Received: from iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com [13.216.54.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E443DA5BF;
	Fri, 10 Apr 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.216.54.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834382; cv=none; b=AP1+fEyjBTwTpzNfoxmPomjc5w08buE3brX15MmiwEs586ZwIKZskaCE7+ZJ0xGv1JPgYFgrZUuuDwMW3ll69UekgD7ieWekDQCFxg7DVcYwUyBbUcPX56UOT8a461JBKCqcFGAL4QU3Fz5mnLbB8cMaVJSpCGzUnflWUsZG3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834382; c=relaxed/simple;
	bh=DARPx0/A/0SyL++lCBCb9Hxzk2csZhsoZq12066OEwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTDmpRwmePj5THJSvqMmbvNjGzdnw8qUKzs2qsb0bPCTKkY8zuI193GcpHrfjQ3oBIrcvkj2zZPrmTwSfloZpnnUCRl2WBgA7zlMFYH92gLaGWSNrdHXJLCKDabxRYSNy6MSBva6/AsXfoYYpgzLo2BorDgx1H9YpdipJA3hrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=NB2QQGtJ; arc=none smtp.client-ip=13.216.54.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="NB2QQGtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1775834380; x=1807370380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5C9AEaTZC2vnX9WJzvecdU4TcSrFHbDbWhfB5ZZnz/U=;
  b=NB2QQGtJvApou6Tz9C4qTQqDKZNzrV/qM7XMIhqYQMRAcZajLm3aLbHr
   nep2axjzGogIU6pjmuFNYAv2a6zgzc/DosMRmloazXIVamyIwNNMdkRLJ
   y0POo/ru6Uiv03VbxdLtkZvCb2MfkZ7EQQzq/59v7YCtlIQSrWhYCnt8c
   ehnijbINXgJJLdz2itU88/ep6ZAdXTALuxCPaBFG0TKd2lG+Eann1GpR7
   Ko+kTJz0XVjNTiQHoD8wuXUDaI/C86S8Jxs/kf1ptQjW676UjTinKRGud
   YkZ3pxz8F1a+Msam7CIgvfPix1ecLNlia+LsWKt6nLjMledYCEVMcr5n0
   A==;
X-CSE-ConnectionGUID: 18qYh3HmQaibfh/VI2oe3g==
X-CSE-MsgGUID: XjBPrBJnTOmInJJy00mcRg==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15981021"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:19:36 +0000
Received: from EX19MTAUEB001.ant.amazon.com [72.21.198.67:7247]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.155:2525] with esmtp (Farcaster)
 id 7679b919-827f-4863-9b32-918b6977df81; Fri, 10 Apr 2026 15:19:36 +0000 (UTC)
X-Farcaster-Flow-ID: 7679b919-827f-4863-9b32-918b6977df81
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:19:36 +0000
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19D027UEC003.ant.amazon.com (10.252.137.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:19:35 +0000
Received: from EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d]) by
 EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d%3]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 15:19:35 +0000
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
Subject: [PATCH v12 10/16] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v12 10/16] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcyP1wgECm8Dfrh0CyY43UsmUx2g==
Date: Fri, 10 Apr 2026 15:19:35 +0000
Message-ID: <20260410151746.61150-11-kalyazin@amazon.com>
References: <20260410151746.61150-1-kalyazin@amazon.com>
In-Reply-To: <20260410151746.61150-1-kalyazin@amazon.com>
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

From: Patrick Roy <patrick.roy@linux.dev>=0A=
=0A=
Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()=0A=
ioctl. When set, guest_memfd folios will be removed from the direct map=0A=
after preparation, with direct map entries only restored when the folios=0A=
are freed.=0A=
=0A=
To ensure these folios do not end up in places where the kernel cannot=0A=
deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct=0A=
address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.=0A=
=0A=
Note that this flag causes removal of direct map entries for all=0A=
guest_memfd folios independent of whether they are "shared" or "private"=0A=
(although current guest_memfd only supports either all folios in the=0A=
"shared" state, or all folios in the "private" state if=0A=
GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map=0A=
entries of also the shared parts of guest_memfd are a special type of=0A=
non-CoCo VM where, host userspace is trusted to have access to all of=0A=
guest memory, but where Spectre-style transient execution attacks=0A=
through the host kernel's direct map should still be mitigated.  In this=0A=
setup, KVM retains access to guest memory via userspace mappings of=0A=
guest_memfd, which are reflected back into KVM's memslots via=0A=
userspace_addr. This is needed for things like MMIO emulation on x86_64=0A=
to work.=0A=
=0A=
Direct map entries are zapped right before guest or userspace mappings=0A=
of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or=0A=
kvm_gmem_get_pfn() [called from the KVM MMU code].  At present, direct=0A=
map removal is not supported on platforms that support=0A=
kvm_gmem_populate().  In case such support is added in the future, the=0A=
following ordering is maintained: zap then prepare, invalidate then=0A=
restore, to avoid having guest-owned pages being temporarily mapped on=0A=
by host.  This assumes that preparation or invalidation code does not=0A=
access the page content.=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Co-developed-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
---=0A=
 Documentation/virt/kvm/api.rst | 21 +++++-----=0A=
 include/linux/kvm_host.h       |  3 ++=0A=
 include/uapi/linux/kvm.h       |  1 +=0A=
 virt/kvm/guest_memfd.c         | 71 ++++++++++++++++++++++++++++++++--=0A=
 4 files changed, 83 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t=0A=
index 032516783e96..8feec77b03fe 100644=0A=
--- a/Documentation/virt/kvm/api.rst=0A=
+++ b/Documentation/virt/kvm/api.rst=0A=
@@ -6439,15 +6439,18 @@ a single guest_memfd file, but the bound ranges mus=
t not overlap).=0A=
 The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can b=
e=0A=
 specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:=0A=
 =0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
-  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file=
=0A=
-                               descriptor.=0A=
-  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during=
=0A=
-                               KVM_CREATE_GUEST_MEMFD (memory files create=
d=0A=
-                               without INIT_SHARED will be marked private)=
.=0A=
-                               Shared memory can be faulted into host user=
space=0A=
-                               page tables. Private memory cannot.=0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
+  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd fi=
le=0A=
+                                 descriptor.=0A=
+  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during=
=0A=
+                                 KVM_CREATE_GUEST_MEMFD (memory files crea=
ted=0A=
+                                 without INIT_SHARED will be marked privat=
e).=0A=
+                                 Shared memory can be faulted into host us=
erspace=0A=
+                                 page tables. Private memory cannot.=0A=
+  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will unmap the m=
emory=0A=
+                                 backing it from the kernel's address spac=
e=0A=
+                                 before passing it off to userspace or the=
 guest.=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
 =0A=
 When the KVM MMU performs a PFN lookup to service a guest fault and the ba=
cking=0A=
 guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always =
be=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index ce8c5fdf2752..c95747e2278c 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -738,6 +738,9 @@ static inline u64 kvm_gmem_get_supported_flags(struct k=
vm *kvm)=0A=
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))=0A=
 		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;=0A=
 =0A=
+	if (!kvm || kvm_arch_gmem_supports_no_direct_map(kvm))=0A=
+		flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+=0A=
 	return flags;=0A=
 }=0A=
 #endif=0A=
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
index 80364d4dbebb..d864f67efdb7 100644=0A=
--- a/include/uapi/linux/kvm.h=0A=
+++ b/include/uapi/linux/kvm.h=0A=
@@ -1642,6 +1642,7 @@ struct kvm_memory_attributes {=0A=
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest=
_memfd)=0A=
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)=0A=
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)=0A=
+#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP	(1ULL << 2)=0A=
 =0A=
 struct kvm_create_guest_memfd {=0A=
 	__u64 size;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 651649623448..80d4a6aca128 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -7,6 +7,7 @@=0A=
 #include <linux/mempolicy.h>=0A=
 #include <linux/pseudo_fs.h>=0A=
 #include <linux/pagemap.h>=0A=
+#include <linux/set_memory.h>=0A=
 =0A=
 #include "kvm_mm.h"=0A=
 =0A=
@@ -76,6 +77,39 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, str=
uct kvm_memory_slot *slo=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)=0A=
+=0A=
+static bool kvm_gmem_folio_no_direct_map(struct folio *folio)=0A=
+{=0A=
+	return ((u64)folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
+static int kvm_gmem_folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	int r =3D 0;=0A=
+=0A=
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);=0A=
+=0A=
+	if (WARN_ON_ONCE(!(GMEM_I(folio_inode(folio))->flags & GUEST_MEMFD_FLAG_N=
O_DIRECT_MAP)))=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (kvm_gmem_folio_no_direct_map(folio))=0A=
+		goto out;=0A=
+=0A=
+	r =3D folio_zap_direct_map(folio);=0A=
+	if (!r)=0A=
+		folio->private =3D (void *)((u64)folio->private | KVM_GMEM_FOLIO_NO_DIRE=
CT_MAP);=0A=
+=0A=
+out:=0A=
+	return r;=0A=
+}=0A=
+=0A=
+static void kvm_gmem_folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	folio_restore_direct_map(folio);=0A=
+	folio->private =3D (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRE=
CT_MAP);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Process @folio, which contains @gfn, so that the guest can use it.=0A=
  * The folio must be locked and the gfn must be contained in @slot.=0A=
@@ -388,11 +422,17 @@ static bool kvm_gmem_supports_mmap(struct inode *inod=
e)=0A=
 	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;=0A=
 }=0A=
 =0A=
+static bool kvm_gmem_no_direct_map(struct inode *inode)=0A=
+{=0A=
+	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)=0A=
 {=0A=
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
 	struct folio *folio;=0A=
 	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
+	int err;=0A=
 =0A=
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >=3D i_size_read(inode))=0A=
 		return VM_FAULT_SIGBUS;=0A=
@@ -418,6 +458,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct v=
m_fault *vmf)=0A=
 		folio_mark_uptodate(folio);=0A=
 	}=0A=
 =0A=
+	if (kvm_gmem_no_direct_map(folio_inode(folio))) {=0A=
+		err =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+		if (err) {=0A=
+			ret =3D vmf_error(err);=0A=
+			goto out_folio;=0A=
+		}=0A=
+	}=0A=
+=0A=
 	vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
 =0A=
 out_folio:=0A=
@@ -529,6 +577,9 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 	int order =3D folio_order(folio);=0A=
 =0A=
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
+=0A=
+	if (kvm_gmem_folio_no_direct_map(folio))=0A=
+		kvm_gmem_folio_restore_direct_map(folio);=0A=
 }=0A=
 =0A=
 static const struct address_space_operations kvm_gmem_aops =3D {=0A=
@@ -591,6 +642,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
ze, u64 flags)=0A=
 	/* Unmovable mappings are supposed to be marked unevictable as well. */=
=0A=
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)=0A=
+		mapping_set_no_direct_map(inode->i_mapping);=0A=
+=0A=
 	GMEM_I(inode)->flags =3D flags;=0A=
 =0A=
 	file =3D alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_f=
ops);=0A=
@@ -802,14 +856,23 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memo=
ry_slot *slot,=0A=
 		folio_mark_uptodate(folio);=0A=
 	}=0A=
 =0A=
+	if (kvm_gmem_no_direct_map(folio_inode(folio))) {=0A=
+		r =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+		if (r)=0A=
+			goto out_unlock;=0A=
+	}=0A=
+=0A=
 	r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);=0A=
+	if (r)=0A=
+		goto out_unlock;=0A=
 =0A=
+	*page =3D folio_file_page(folio, index);=0A=
 	folio_unlock(folio);=0A=
+	return 0;=0A=
 =0A=
-	if (!r)=0A=
-		*page =3D folio_file_page(folio, index);=0A=
-	else=0A=
-		folio_put(folio);=0A=
+out_unlock:=0A=
+	folio_unlock(folio);=0A=
+	folio_put(folio);=0A=
 =0A=
 	return r;=0A=
 }=0A=
-- =0A=
2.50.1=0A=
=0A=
