Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE63E4C90;
	Tue, 17 Mar 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756742; cv=none; b=pYFjASgl6KnlsQUAbqdiL7UERkRaLT7s74Ov9F7DQamxYR65klWbwTgFuL3096zAGodPXNB+gs+k2ZgDobpuUm52P1j8UnKyRf/XZSpV3QpKGNmzfH8TOk+RJciCQLmz3ktPWckA6hgXxzJkp05ccyZBLWDuRZAab1LzR6q7gY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756742; c=relaxed/simple;
	bh=e9tAKvgOQmgePezKmQZDfHlUyh0Lm3Uf9THU29WFWG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGfFiphZyQYNk0YWOIi1NrFpvjNZceV+1Clt5n0l6TPb9+ydTqds08oQtHAbrX2L2kg2jh72MvbudL7zyGvjgp0TC2rmQqqsKHXr8M/wYC3gmBwBI1w2B/+BvNcJoFTqaoY6NA4FGa7Sl1E1nFABU2y/1WjW4OoObEg+HnHhP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=pHmqak/C; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="pHmqak/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1773756740; x=1805292740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2c78Mh9z7WDueLSiXQGt7i6WZglrX93MoDY5zuXKFPY=;
  b=pHmqak/CahzQEgDPskgxuJ7NtEB4xjPojAElLpz8Q/k+TpZFoh6NFMuU
   cTLgqsG+u1GAsAs1OA7bL7TvSZUAIsiGQzdykq9+FKQrvzs+6SNaVhx7j
   /c7BfK2XHeBA2qbdNIaDnS4yw0ntTGyWWryzfL0TlJ2uXECM/iJCSfXLY
   bgdWO7Hmn0/zHgDikPkZsj37sez47uUTGZHdMKvXnowAKmLwaKIm7RoGk
   XDbnRvB6QPjkpAXNH47uq0hrd3u4nYYnlUlcou+orp55JPkwMb6JF+MSb
   AWezBFP+esEiGuklkHUJxKvU9H5cEDk2HV6U5/k8Af93vJu5eNk08NSsf
   A==;
X-CSE-ConnectionGUID: dQblRH3kTSS8SeOY/jt2uw==
X-CSE-MsgGUID: aa3TGXikT1u2+oO9tXimkg==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="10998003"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:12:18 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:3027]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.205:2525] with esmtp (Farcaster)
 id 9ae028c9-faf2-4cea-a353-2d55223a3078; Tue, 17 Mar 2026 14:12:17 +0000 (UTC)
X-Farcaster-Flow-ID: 9ae028c9-faf2-4cea-a353-2d55223a3078
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:12:17 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:12:16 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.037; Tue, 17 Mar 2026 14:12:16 +0000
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
Subject: [PATCH v11 09/16] KVM: arm64: define
 kvm_arch_gmem_supports_no_direct_map()
Thread-Topic: [PATCH v11 09/16] KVM: arm64: define
 kvm_arch_gmem_supports_no_direct_map()
Thread-Index: AQHcthgPB9NLB7PWNUiZvDNvyT7cZw==
Date: Tue, 17 Mar 2026 14:12:16 +0000
Message-ID: <20260317141031.514-10-kalyazin@amazon.com>
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
Support for GUEST_MEMFD_FLAG_NO_DIRECT_MAP on arm64 depends on 1) direct=0A=
map manipulations at 4k granularity being possible, and 2) FEAT_S2FWB.=0A=
=0A=
1) is met whenever the direct map is set up at 4k granularity (e.g. not=0A=
 with huge/gigantic pages) at boottime, as due to ARM's=0A=
break-before-make semantics, breaking huge mappings into 4k mappings in=0A=
the direct map is not possible (BBM would require temporary invalidation=0A=
of the entire huge mapping, even if only a 4k subrange should be zapped,=0A=
which will probably crash the kernel). However, the current default for=0A=
rodata_full is true, which forces a 4k direct map.=0A=
=0A=
2) is required to allow KVM to elide cache coherency operations when=0A=
installing stage 2 page tables, which require the direct map to be=0A=
entry for the newly mapped memory to be present (which it will not be,=0A=
as guest_memfd would have removed direct map entries in=0A=
kvm_gmem_get_pfn()).=0A=
=0A=
Cc: Will Deacon <will@kernel.org>=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 arch/arm64/include/asm/kvm_host.h | 13 +++++++++++++=0A=
 1 file changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm=
_host.h=0A=
index 70cb9cfd760a..fbdd43e7e94e 100644=0A=
--- a/arch/arm64/include/asm/kvm_host.h=0A=
+++ b/arch/arm64/include/asm/kvm_host.h=0A=
@@ -19,6 +19,7 @@=0A=
 #include <linux/maple_tree.h>=0A=
 #include <linux/percpu.h>=0A=
 #include <linux/psci.h>=0A=
+#include <linux/set_memory.h>=0A=
 #include <asm/arch_gicv3.h>=0A=
 #include <asm/barrier.h>=0A=
 #include <asm/cpufeature.h>=0A=
@@ -1682,6 +1683,18 @@ static __always_inline enum fgt_group_id __fgt_reg_t=
o_group_id(enum vcpu_sysreg=0A=
 									\=0A=
 		p;							\=0A=
 	})=0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+static inline bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm)=
=0A=
+{=0A=
+	/*=0A=
+	 * Without FWB, direct map access is needed in kvm_pgtable_stage2_map(),=
=0A=
+	 * as it calls dcache_clean_inval_poc().=0A=
+	 */=0A=
+	return can_set_direct_map() && cpus_have_final_cap(ARM64_HAS_STAGE2_FWB);=
=0A=
+}=0A=
+#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_dir=
ect_map=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
+=0A=
 =0A=
 long kvm_get_cap_for_kvm_ioctl(unsigned int ioctl, long *ext);=0A=
 =0A=
-- =0A=
2.50.1=0A=
=0A=
