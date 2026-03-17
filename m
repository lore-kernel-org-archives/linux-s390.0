Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416533EBF33;
	Tue, 17 Mar 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756800; cv=none; b=IAbsd1BitDNbbIQ+jLpDeRo1oCf53ZJbE/wqYffnw8rTH0nwyLDptIIY0Ux2VYVx/kANrvq++MUht9ZxPRLp4H1nlwLUCmHMrPRYKcAyeHm3b4ONGQco8bQu8m0hXa7+qK87qX3gvBe4Iq15IzzfNOUWf2NpJftb/kG5oYTx/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756800; c=relaxed/simple;
	bh=ZAzjnpRpvztWYeB6BHb772r/08yikv+0cmvQJxlSmuA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQxW8Ktlct4M2Aj8hfnL2MALy2Y4mZeXcCzURwzXdWWwC1sQK2qKa0nIz6L2MkHD0ysuLuWrofaLBGicdciFgZrZfMlejokaMpJSazfMhF3nPXHp9J1xigD8xtFS4u7AwVnq+RfiePIfskiAdnBYZ9G49UX86ewcIWtj3k6+hJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=iZJwgBCz; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="iZJwgBCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1773756799; x=1805292799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FYsgkotQwsE3twzfNgwzCUddRr5tCg6gdL5/vBTBngA=;
  b=iZJwgBCzCMTOOAq9I3E+WyWnk4veP8sU4vg8znXjoBzXZW+k3C+9LiWh
   1CwShgrTScLVguQFJIkichW/w+XhG9iPgjuGtL9tliEKW1wrU8Lj2G+Ye
   +g2Jvhg7bmjUy0dQFOohrt2aSDJ7h/cqI+yGombgVotWG+N0vnUSuiZSz
   iLFBcaEpVCOisDYYNGcZlfNpa5l+YUjfYBB+vwHMEqXSdcunOBdAJxsrr
   Xlzo73nx1ZPIwxcDMOQsQ2lwnozXiW+KMY9gn0k0vUXLekDL1a6B5ACeL
   FEGUY36ul267P8zwgMhLodd4RMNirxnyvKfDRd3ElUKWKCFhqmZn2ACQz
   w==;
X-CSE-ConnectionGUID: dQ50hGlCS+mVkdXQCi27XQ==
X-CSE-MsgGUID: 75IWVisKTEGJehvuWkfBTw==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="10999470"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:13:16 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:19246]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.122:2525] with esmtp (Farcaster)
 id 2f13a2a9-ef77-4a1d-b7d5-f69766945acd; Tue, 17 Mar 2026 14:13:16 +0000 (UTC)
X-Farcaster-Flow-ID: 2f13a2a9-ef77-4a1d-b7d5-f69766945acd
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:13:15 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:13:15 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.037; Tue, 17 Mar 2026 14:13:15 +0000
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
	<coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "yosry@kernel.org"
	<yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com"
	<tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>,
	"wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
Subject: [PATCH v11 14/16] KVM: selftests: cover
 GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing selftests
Thread-Topic: [PATCH v11 14/16] KVM: selftests: cover
 GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing selftests
Thread-Index: AQHcthgyuwe8FmKDH0i+WVkM5uY4og==
Date: Tue, 17 Mar 2026 14:13:14 +0000
Message-ID: <20260317141031.514-15-kalyazin@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com>
In-Reply-To: <20260317141031.514-1-kalyazin@amazon.com>
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
Extend mem conversion selftests to cover the scenario that the guest can=0A=
fault in and write gmem-backed guest memory even if its direct map=0A=
removed. Also cover the new flag in guest_memfd_test.c tests.=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 tools/testing/selftests/kvm/guest_memfd_test.c  | 17 ++++++++++++++++-=0A=
 .../kvm/x86/private_mem_conversions_test.c      |  7 ++++---=0A=
 2 files changed, 20 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing=
/selftests/kvm/guest_memfd_test.c=0A=
index cc329b57ce2e..64c1200c182e 100644=0A=
--- a/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
@@ -403,6 +403,17 @@ static void test_guest_memfd(unsigned long vm_type)=0A=
 		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |=0A=
 				       GUEST_MEMFD_FLAG_INIT_SHARED);=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP) {=0A=
+		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_NO_DIRECT_MAP);=0A=
+		if (flags & GUEST_MEMFD_FLAG_MMAP)=0A=
+			__test_guest_memfd(vm, GUEST_MEMFD_FLAG_NO_DIRECT_MAP |=0A=
+					       GUEST_MEMFD_FLAG_MMAP);=0A=
+		if (flags & GUEST_MEMFD_FLAG_INIT_SHARED)=0A=
+			__test_guest_memfd(vm, GUEST_MEMFD_FLAG_NO_DIRECT_MAP |=0A=
+					       GUEST_MEMFD_FLAG_MMAP |=0A=
+					       GUEST_MEMFD_FLAG_INIT_SHARED);=0A=
+	}=0A=
+=0A=
 	kvm_vm_free(vm);=0A=
 }=0A=
 =0A=
@@ -445,10 +456,14 @@ static void test_guest_memfd_guest(void)=0A=
 	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLA=
G_INIT_SHARED,=0A=
 		    "Default VM type should support INIT_SHARED, supported flags =3D 0x%=
x",=0A=
 		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));=0A=
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLA=
G_NO_DIRECT_MAP,=0A=
+		    "Default VM type should support NO_DIRECT_MAP, supported flags =3D 0=
x%x",=0A=
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));=0A=
 =0A=
 	size =3D vm->page_size;=0A=
 	fd =3D vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP |=0A=
-					     GUEST_MEMFD_FLAG_INIT_SHARED);=0A=
+					     GUEST_MEMFD_FLAG_INIT_SHARED |=0A=
+					     GUEST_MEMFD_FLAG_NO_DIRECT_MAP);=0A=
 	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL=
, fd, 0);=0A=
 =0A=
 	mem =3D kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);=0A=
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c=
 b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c=0A=
index 1969f4ab9b28..8767cb4a037e 100644=0A=
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c=0A=
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c=0A=
@@ -367,7 +367,7 @@ static void *__test_mem_conversions(void *__vcpu)=0A=
 }=0A=
 =0A=
 static void test_mem_conversions(enum vm_mem_backing_src_type src_type, ui=
nt32_t nr_vcpus,=0A=
-				 uint32_t nr_memslots)=0A=
+				 uint32_t nr_memslots, uint64_t gmem_flags)=0A=
 {=0A=
 	/*=0A=
 	 * Allocate enough memory so that each vCPU's chunk of memory can be=0A=
@@ -394,7 +394,7 @@ static void test_mem_conversions(enum vm_mem_backing_sr=
c_type src_type, uint32_t=0A=
 =0A=
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));=
=0A=
 =0A=
-	memfd =3D vm_create_guest_memfd(vm, memfd_size, 0);=0A=
+	memfd =3D vm_create_guest_memfd(vm, memfd_size, gmem_flags);=0A=
 =0A=
 	for (i =3D 0; i < nr_memslots; i++)=0A=
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,=0A=
@@ -474,7 +474,8 @@ int main(int argc, char *argv[])=0A=
 		}=0A=
 	}=0A=
 =0A=
-	test_mem_conversions(src_type, nr_vcpus, nr_memslots);=0A=
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots, 0);=0A=
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots, GUEST_MEMFD_FLAG_NO=
_DIRECT_MAP);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
-- =0A=
2.50.1=0A=
=0A=
