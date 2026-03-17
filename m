Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BB3E2778;
	Tue, 17 Mar 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756686; cv=none; b=RntLwleBBLyjC57Ow06RZ2VGu+u4c1U+NLq1q4cgPeUu1CdoSsXwGo3++vQcdrrra1bu9osKzOzkl3ldQaYbck2l2dToCXMLtQg3SJOBMt9iVGzZ9hPaNnjCZF089MgZJrEHbv/3XS67cjkzOECZIJO0QFCMTdsg3yPZdjrJumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756686; c=relaxed/simple;
	bh=qXMv+FyYq6iyafIoNljnAbhjeIMJfmJg7BKR+L1Xtzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovkrvllwwqEomzrtETbmL3lTjeDjLTfHcAqkn0eJB809t8ml4kSHBgBPUKciPeac7KoVKPIhcW9Nvrz6YcyMupRPyrwx5KugcNzxmi+5qaqNrxxxduiJIPMXgjUU+IeP9tGE+a/2CMKnVBzgbCIo0XTIVVOEVDJPFZqaGXGrh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=di50sTK/; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="di50sTK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1773756685; x=1805292685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QH/0pY+L5Mnx+GXH9O+3FVFXbnxf+J6Zf5bgE/TnHq0=;
  b=di50sTK/jnmlQSGDVf9p3P4DtlftqmHqEv2TNbBLcGFdj/oNxg+yHWUZ
   KG7GNfESBVDtfrNYdK8fYwyU3zaT8UuhQ1UxVup2n5Exk3q51EeDR9hc9
   vzx2pb8/sOK8JoyW5dn/r+4BfOSVLnAurexwxSXCfBh+A7L3uooKvA1Zz
   I596PqlxOsjlFmGsClU6YrktLn0zoLUiesKC8NiP8oxm1QQDtrmUC1VJ3
   pv21WDXWhXfb9jlexARRHVKvHiPOHfWW1+FW3UwPoj6JVKWphssesXA2R
   G3hXI5voQmQ3c56iQXrINCYewjXG/iUB1TBqBTEkanFbNMaPn4hEJpddx
   w==;
X-CSE-ConnectionGUID: bjZm6s3/TCWdkXS4JpYsMA==
X-CSE-MsgGUID: Uv/u4CHeTxOSFi5l4I+Zag==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="11017718"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:11:20 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:28302]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.244:2525] with esmtp (Farcaster)
 id 2703a9d0-a65e-493e-aff8-54f3e9f5b406; Tue, 17 Mar 2026 14:11:20 +0000 (UTC)
X-Farcaster-Flow-ID: 2703a9d0-a65e-493e-aff8-54f3e9f5b406
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:11:19 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB003.ant.amazon.com (10.252.51.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 17 Mar 2026 14:11:19 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.037; Tue, 17 Mar 2026 14:11:19 +0000
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
	<kalyazin@amazon.co.uk>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v11 04/16] mm/gup: drop secretmem optimization from
 gup_fast_folio_allowed
Thread-Topic: [PATCH v11 04/16] mm/gup: drop secretmem optimization from
 gup_fast_folio_allowed
Thread-Index: AQHcthfsUhUKrmwTXkGd7H9F3DgqvA==
Date: Tue, 17 Mar 2026 14:11:18 +0000
Message-ID: <20260317141031.514-5-kalyazin@amazon.com>
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
This drops an optimization in gup_fast_folio_allowed() where=0A=
secretmem_mapping() was only called if CONFIG_SECRETMEM=3Dy. secretmem is=
=0A=
enabled by default since commit b758fe6df50d ("mm/secretmem: make it on=0A=
by default"), so the secretmem check did not actually end up elided in=0A=
most cases anymore anyway.=0A=
=0A=
This is in preparation of the generalization of handling mappings where=0A=
direct map entries of folios are set to not present.  Currently,=0A=
mappings that match this description are secretmem mappings=0A=
(memfd_secret()).  Later, some guest_memfd configurations will also fall=0A=
into this category.=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A=
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 mm/gup.c | 11 +----------=0A=
 1 file changed, 1 insertion(+), 10 deletions(-)=0A=
=0A=
diff --git a/mm/gup.c b/mm/gup.c=0A=
index 8e7dc2c6ee73..5856d35be385 100644=0A=
--- a/mm/gup.c=0A=
+++ b/mm/gup.c=0A=
@@ -2739,7 +2739,6 @@ static bool gup_fast_folio_allowed(struct folio *foli=
o, unsigned int flags)=0A=
 {=0A=
 	bool reject_file_backed =3D false;=0A=
 	struct address_space *mapping;=0A=
-	bool check_secretmem =3D false;=0A=
 	unsigned long mapping_flags;=0A=
 =0A=
 	/*=0A=
@@ -2751,14 +2750,6 @@ static bool gup_fast_folio_allowed(struct folio *fol=
io, unsigned int flags)=0A=
 		reject_file_backed =3D true;=0A=
 =0A=
 	/* We hold a folio reference, so we can safely access folio fields. */=0A=
-=0A=
-	/* secretmem folios are always order-0 folios. */=0A=
-	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))=0A=
-		check_secretmem =3D true;=0A=
-=0A=
-	if (!reject_file_backed && !check_secretmem)=0A=
-		return true;=0A=
-=0A=
 	if (WARN_ON_ONCE(folio_test_slab(folio)))=0A=
 		return false;=0A=
 =0A=
@@ -2800,7 +2791,7 @@ static bool gup_fast_folio_allowed(struct folio *foli=
o, unsigned int flags)=0A=
 	 * At this point, we know the mapping is non-null and points to an=0A=
 	 * address_space object.=0A=
 	 */=0A=
-	if (check_secretmem && secretmem_mapping(mapping))=0A=
+	if (secretmem_mapping(mapping))=0A=
 		return false;=0A=
 	/* The only remaining allowed file system is shmem. */=0A=
 	return !reject_file_backed || shmem_mapping(mapping);=0A=
-- =0A=
2.50.1=0A=
=0A=
