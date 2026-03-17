Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B33E1D02;
	Tue, 17 Mar 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756675; cv=none; b=MEjGwfy7VMVDmKmw2Z1Xg28d5hbU5VaZ7gCnN0Zw/Q0mP3cTdOWp6A9+ZFDiiZ9AyezgGjwOnzkPzRfNAg9QmOW13kd1z5FhlTEx0FCRLnXa0nbGNSbgS4CM8cv+vTOjYdIgdV7WEwwhYozbwHOPOIrzl2FX6J/2h2o7/Z1V6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756675; c=relaxed/simple;
	bh=WHiyVRDw6kTV1LWtpBw5OcbVuqf3EYDjsGo/nTebqfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n8iBTY59lIVJe4JIdisTWLzIaHDY5B8bu7vX4Xp1EXf3fJ8CC5aKkvdHv/sahxlX2QUbT2Sz5FVGIh3lskb2VVwIIVpD8enR2u/M52/8fi9/FmiaEgkvvt3bppoIkXeCmXiCGPQrdKpaolTqFP4wH5kySXhlf75MrOUSsqnJrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=VtiT/Kjp; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="VtiT/Kjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1773756674; x=1805292674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=civgTW3KdVqRnNr9DLmAUo8biVlHbqHYSTZMRg7ipUE=;
  b=VtiT/KjpH2cv5K5I3umWNJ/nEmHgqvG+5iULpFP3E5lS/cWKUaV2DQht
   KM6V7H4BImrBCNzGNQrDVK/kdecEPR49sxQX2t84UOIKV0J0PdDJ776K2
   dRejmDR2gbjOjDgZ/NbmaLMzMtua3z5h9gERr81W3gs58QvUW7ob9RS92
   CQC0vepVeKfCaVy7Lz1gboPUgOOzKAdY4l0N+DR/yD5XdsABhw0x+oyoG
   liYWBrSG2NTwV1LfaWeFbWoLyI4N8eJ85YQtrCd1P/cblB7JfxsRqV27l
   IsQZ93AlODVTAWFlNuPewbf8wln1vFsWM0z40lJ/s1/xTSghvFIpAeIXJ
   g==;
X-CSE-ConnectionGUID: RwVI7fN2RW+jRHloYOdsvw==
X-CSE-MsgGUID: GzDBKQ3WRk2Fccj0YhCgLg==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="10908841"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:11:08 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:29351]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.64:2525] with esmtp (Farcaster)
 id 8e39f445-ebd5-4ce4-b99e-d390d1eee83e; Tue, 17 Mar 2026 14:11:08 +0000 (UTC)
X-Farcaster-Flow-ID: 8e39f445-ebd5-4ce4-b99e-d390d1eee83e
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:11:07 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:11:07 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.037; Tue, 17 Mar 2026 14:11:07 +0000
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
Subject: [PATCH v11 03/16] mm/secretmem: make use of
 folio_{zap,restore}_direct_map
Thread-Topic: [PATCH v11 03/16] mm/secretmem: make use of
 folio_{zap,restore}_direct_map
Thread-Index: AQHcthflERb7zhsH1EWE6uTFRY4Wfg==
Date: Tue, 17 Mar 2026 14:11:07 +0000
Message-ID: <20260317141031.514-4-kalyazin@amazon.com>
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

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
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
