Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C3E638F;
	Tue, 17 Mar 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756831; cv=none; b=dNmpOE0+0CIpjUG6stWq0ONQtTZrXLRD3n1cvtcuzGdylJDLEj0wiYwXY2Q5/Yr9+5kkbg0MeMW0L4D6V0oCQv7Mp63RbuzACFisqDCfxcwhbsi+jQRQkmSKGpaEclhx+IWzV4fIf+3d2fwTkobCTP5T4eYu8WhdmfeC9iTms+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756831; c=relaxed/simple;
	bh=RkewADzNkvxBUOT/4I8rSFHV1tsgWKOM5Wj6NnQFCvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hw4K+Jc08fKSeEJJtU0Ftg0+vnV7BYL6IsYZFTPA9kIjsgbg+92V1xrN84wE5aEWj1i1EZhE/jK6XaeM8P5M0HH2xqe53U/1d+guFQVcLZJpdymrfn1WWZoQfYrOY51Ra7vUD33af6yZl+nTcYjDK+5rdA65kndEcBw5s0OXWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=H9YOPO+N; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="H9YOPO+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1773756830; x=1805292830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pnj38ZEunZJJVUWYRSPy2Hkqiw4TfDVhbTQYfcLSb24=;
  b=H9YOPO+NYyWKDaeYejRrzD2Hp4V2ZuSjJXNehcXB6AlxC4zE2XdVlvWK
   vDZSN6lAQwkbWmu8Jq7gpfsHP+/qIe7u4xMu7GkuGOPMQbMMLaSq3G9Re
   Soe0bhGNWhvwss57XCCNcUnkqcLS4Mi2tuT7iXvPZ9FAc7pjLfGd5wbU5
   /YkfmGWCY0/keSpJy+fHVB4gK2fL0CWtX9eVaBsjiDe1rR3HHZAZhsLWo
   9H7CK4K2rwqT5VrNhutnCLu/a5VzeTmcQKdRCRGFFT3D01nV3p5yEneVt
   Y5vr+ipjfYGhIQLX2t3HIlU7qilPOL0LvnWB/SHN+xYxCdZOrQds0yenU
   Q==;
X-CSE-ConnectionGUID: 6tEFsmMKRiKCju09h+6xXg==
X-CSE-MsgGUID: Nb9k9SOhTdC17ygw1ts0mw==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="10887386"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:13:45 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:9034]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.244:2525] with esmtp (Farcaster)
 id 46addb52-27dc-449b-b609-08b4010fe2c8; Tue, 17 Mar 2026 14:13:45 +0000 (UTC)
X-Farcaster-Flow-ID: 46addb52-27dc-449b-b609-08b4010fe2c8
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:13:38 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB003.ant.amazon.com (10.252.51.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:13:38 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.037; Tue, 17 Mar 2026 14:13:38 +0000
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
Subject: [PATCH v11 16/16] KVM: selftests: Test guest execution from direct
 map removed gmem
Thread-Topic: [PATCH v11 16/16] KVM: selftests: Test guest execution from
 direct map removed gmem
Thread-Index: AQHcthg/KCzYvBJTJ0yQSSHK2da0LQ==
Date: Tue, 17 Mar 2026 14:13:37 +0000
Message-ID: <20260317141031.514-17-kalyazin@amazon.com>
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
Add a selftest that loads itself into guest_memfd (via=0A=
GUEST_MEMFD_FLAG_MMAP) and triggers an MMIO exit when executed. This=0A=
exercises x86 MMIO emulation code inside KVM for guest_memfd-backed=0A=
memslots where the guest_memfd folios are direct map removed.=0A=
Particularly, it validates that x86 MMIO emulation code (guest page=0A=
table walks + instruction fetch) correctly accesses gmem through the VMA=0A=
that's been reflected into the memslot's userspace_addr field (instead=0A=
of trying to do direct map accesses).=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 .../selftests/kvm/set_memory_region_test.c    | 52 +++++++++++++++++--=0A=
 1 file changed, 48 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/t=
esting/selftests/kvm/set_memory_region_test.c=0A=
index 7fe427ff9b38..cb445d420e8c 100644=0A=
--- a/tools/testing/selftests/kvm/set_memory_region_test.c=0A=
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c=0A=
@@ -602,6 +602,41 @@ static void test_mmio_during_vectoring(void)=0A=
 =0A=
 	kvm_vm_free(vm);=0A=
 }=0A=
+=0A=
+static void guest_code_trigger_mmio(void)=0A=
+{=0A=
+	/*=0A=
+	 * Read some GPA that is not backed by a memslot. KVM consider this=0A=
+	 * as MMIO and tell userspace to emulate the read.=0A=
+	 */=0A=
+	READ_ONCE(*((uint64_t *)MEM_REGION_GPA));=0A=
+=0A=
+	GUEST_DONE();=0A=
+}=0A=
+=0A=
+static void test_guest_memfd_mmio(void)=0A=
+{=0A=
+	struct kvm_vm *vm;=0A=
+	struct kvm_vcpu *vcpu;=0A=
+	struct vm_shape shape =3D {=0A=
+		.mode =3D VM_MODE_DEFAULT,=0A=
+		.src_type =3D VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,=0A=
+	};=0A=
+	pthread_t vcpu_thread;=0A=
+=0A=
+	pr_info("Testing MMIO emulation for instructions in gmem\n");=0A=
+=0A=
+	vm =3D __vm_create_shape_with_one_vcpu(shape, &vcpu, 0, guest_code_trigge=
r_mmio);=0A=
+=0A=
+	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 1);=0A=
+=0A=
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);=0A=
+=0A=
+	/* If the MMIO read was successfully emulated, the vcpu thread will exit =
*/=0A=
+	pthread_join(vcpu_thread, NULL);=0A=
+=0A=
+	kvm_vm_free(vm);=0A=
+}=0A=
 #endif=0A=
 =0A=
 int main(int argc, char *argv[])=0A=
@@ -625,10 +660,19 @@ int main(int argc, char *argv[])=0A=
 	test_add_max_memory_regions();=0A=
 =0A=
 #ifdef __x86_64__=0A=
-	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&=0A=
-	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {=
=0A=
-		test_add_private_memory_region();=0A=
-		test_add_overlapping_private_memory_regions();=0A=
+	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD)) {=0A=
+		uint64_t valid_flags =3D kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS);=0A=
+=0A=
+		if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM)) {=0A=
+			test_add_private_memory_region();=0A=
+			test_add_overlapping_private_memory_regions();=0A=
+		}=0A=
+=0A=
+		if ((valid_flags & GUEST_MEMFD_FLAG_MMAP) &&=0A=
+		    (valid_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))=0A=
+			test_guest_memfd_mmio();=0A=
+		else=0A=
+			pr_info("Skipping tests requiring GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_F=
LAG_NO_DIRECT_MAP");=0A=
 	} else {=0A=
 		pr_info("Skipping tests for KVM_MEM_GUEST_MEMFD memory regions\n");=0A=
 	}=0A=
-- =0A=
2.50.1=0A=
=0A=
