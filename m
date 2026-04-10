Received: from iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.198.94.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C93DA5BF;
	Fri, 10 Apr 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.198.94.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834304; cv=none; b=uQAytkdw99OIjUXAFsvqVirrXo2MnHjBZE5vmGG3wHRENg43KyI0ILITxghS2SMAa4T9bMLZzFM86cqgtXa1o1L2TtK9ZUCZvO3f2Nw1o/T39FMUyjoCeDoLSzaKpE3taHbUJ27mixvNGV7lZlfE3eS++7oUP41HqeN/ujTJjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834304; c=relaxed/simple;
	bh=8DjXIMBWBLOAn+CXSrJbYeOgxkkXIgdkJo0CROITJ0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQecDALK4JnuBvMH6LwkMIVSmlwcn+fse/3N8J7/k9Vxt1JK1B1nPSg7MCxejBae6HbtpvV2WFzc8Cduy7aeU1mTYZgPD62mcMwqHRF34vHrXCQMeEYRELopX6uqJXCR2IDbylLaU6I9FiYXyIFkp2mBl8jMztzBENRyqbfQY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=lPCUFR09; arc=none smtp.client-ip=34.198.94.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="lPCUFR09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1775834303; x=1807370303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SXUxXoRrWTOvyOc+uAqr+1ZCvKnUa6yiTRH8yoXeRFw=;
  b=lPCUFR09v9NfYL2aWeP5Vl7peYGiK799Q2GZk3o6E3GqXRqHzdwkZTdd
   pWjDBRj6F51lS2cxWnlbVvoj3MPayI0nQEtds+R5lxwX1yxODdh9xUK4/
   5zCl/50piHU72M1EbT/lv+Htzyl3M8NHHxzbQCvSjXeyBVwOgaAQ2EKTe
   tIObM+oKA91Ifrb8Y5z7CuBXGBtxFZblIWGYJ/E9J9xM3ExeU66650QJX
   7x2AxyLsG9WdhEpoycc25ATLsxDmv6HYb9DqppEI/lRVb+zW7Pj2rN/Hv
   ufju2h5E+MpMqzmZuWAJCxka7cC8NrEkERRB6xQNiJLB9nngcD0xTBoxp
   Q==;
X-CSE-ConnectionGUID: ETAIPHXHQ6Cl6VUBPfxqbA==
X-CSE-MsgGUID: K9skfv97QeinTXXHdn0ngg==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15898090"
Received: from ip-10-4-17-41.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.17.41])
  by internal-iad-out-009.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:18:21 +0000
Received: from EX19MTAUEA002.ant.amazon.com [52.94.133.129:4854]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.3.180:2525] with esmtp (Farcaster)
 id 5c57dd77-82b6-4d25-81d9-bfb9fbf59a7a; Fri, 10 Apr 2026 15:18:20 +0000 (UTC)
X-Farcaster-Flow-ID: 5c57dd77-82b6-4d25-81d9-bfb9fbf59a7a
Received: from EX19D027UEC001.ant.amazon.com (10.252.137.156) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:18:20 +0000
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19D027UEC001.ant.amazon.com (10.252.137.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:18:20 +0000
Received: from EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d]) by
 EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d%3]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 15:18:20 +0000
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
 Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v12 03/16] mm/secretmem: make use of
 folio_{zap,restore}_direct_map
Thread-Topic: [PATCH v12 03/16] mm/secretmem: make use of
 folio_{zap,restore}_direct_map
Thread-Index: AQHcyP1DBItR5zMXtEmj13bg9CfDRw==
Date: Fri, 10 Apr 2026 15:18:19 +0000
Message-ID: <20260410151746.61150-4-kalyazin@amazon.com>
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

From: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
=0A=
Replace set_direct_map_*_noflush with newly available=0A=
folio_zap_direct_map calls that take folio's address internally.  A side=0A=
effect is even if filemap_add_folio fails, the TLB is still flushed,=0A=
which is not expected to be on the hot path.=0A=
=0A=
Acked-by: David Hildenbrand (Arm) <david@kernel.org>=0A=
Reviewed-by: Ackerley Tng <ackerleytng@google.com>=0A=
Signed-off-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
---=0A=
 mm/secretmem.c | 8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/mm/secretmem.c b/mm/secretmem.c=0A=
index fd29b33c6764..27b176af8fc4 100644=0A=
--- a/mm/secretmem.c=0A=
+++ b/mm/secretmem.c=0A=
@@ -53,7 +53,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)=
=0A=
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
 	pgoff_t offset =3D vmf->pgoff;=0A=
 	gfp_t gfp =3D vmf->gfp_mask;=0A=
-	unsigned long addr;=0A=
 	struct folio *folio;=0A=
 	vm_fault_t ret;=0A=
 	int err;=0A=
@@ -72,7 +71,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)=
=0A=
 			goto out;=0A=
 		}=0A=
 =0A=
-		err =3D set_direct_map_invalid_noflush(folio_address(folio));=0A=
+		err =3D folio_zap_direct_map(folio);=0A=
 		if (err) {=0A=
 			folio_put(folio);=0A=
 			ret =3D vmf_error(err);=0A=
@@ -87,7 +86,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)=
=0A=
 			 * already happened when we marked the page invalid=0A=
 			 * which guarantees that this call won't fail=0A=
 			 */=0A=
-			set_direct_map_default_noflush(folio_address(folio));=0A=
+			folio_restore_direct_map(folio);=0A=
 			folio_put(folio);=0A=
 			if (err =3D=3D -EEXIST)=0A=
 				goto retry;=0A=
@@ -95,9 +94,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)=
=0A=
 			ret =3D vmf_error(err);=0A=
 			goto out;=0A=
 		}=0A=
-=0A=
-		addr =3D (unsigned long)folio_address(folio);=0A=
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);=0A=
 	}=0A=
 =0A=
 	vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
-- =0A=
2.50.1=0A=
=0A=
