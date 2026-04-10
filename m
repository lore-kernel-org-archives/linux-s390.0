Received: from iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.10.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152F3DA7F7;
	Fri, 10 Apr 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.197.10.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834327; cv=none; b=OocPQM05aBhj/7DS854SBR3MN7hFX0QZcLbzTrjd7s0O97rTFqyuakIdx6mwrN2tad1PNNaQUWX6U6pJQqRXYS29ozr9TMCv9Hb31t63XYErFHWov8JORzdSnWjTUqThYFA/ar8IcI+p7BffQh0d1lrAuk3mP+jORLcaX6XoP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834327; c=relaxed/simple;
	bh=0ZUwZlXV0hDJ6090PKknS2vdFy+ok+C/vMrImjdoaq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQbBi/xC3yj/vrdGejLNMBNWfBOZwfKecPRt5VERxvruaPL7CAfRZXV7/dh55vrJ1wwmvSK5HblBEBs7mz3D7Iv9Y5pZx22ElwyHqTgTRxnQfAy7OC2NGyrhufUDqn6k7cYNF7yU9RwINdNfdscWVU5u8Mv8LYYAdejcLuwM6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=tSZeKLZM; arc=none smtp.client-ip=34.197.10.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="tSZeKLZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1775834326; x=1807370326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6rramw02zFfaQ/VTWivc4Tqh7KGk0PsNNXj8pjM5nD8=;
  b=tSZeKLZMawo9jtONrZErBPL6fWQFrmb5FrCZSfwzFxVdsCBXje9S213K
   b59kUpWjnc4JTfxDNqE3IzcIPRfjXIzWCcZk/5t9v2vVOUHZ/HavfHxfH
   QFzSPJMVricx12htMZXlcZq3w9ZCOUHjYPVmU4BHYOSuyKDFfD7iULLEz
   1CpjdJl71LOizFgh//1VVm7dFaZz/rdtdKTLU/tNy2MdNd+wS11rg09nx
   mwmm3HmKHA18HfQtlll0r7u8G8s2hZ1CoQJdcyD+5ev0lPm0/WLEu2dSu
   FxXS/m4e02X6fTrHcHA8trDrBjBvpYWaUpK9mZJ8Yg9kA2+y4K0rBT3BM
   g==;
X-CSE-ConnectionGUID: yToEaIXKRYmG7oPx4P8CLw==
X-CSE-MsgGUID: kwtkzB/GQkmjo48FL84lPw==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15710859"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:18:42 +0000
Received: from EX19MTAUEC002.ant.amazon.com [72.21.198.66:30402]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.32.14:2525] with esmtp (Farcaster)
 id fba8fd5c-1716-4384-b576-8dedd695907e; Fri, 10 Apr 2026 15:18:42 +0000 (UTC)
X-Farcaster-Flow-ID: fba8fd5c-1716-4384-b576-8dedd695907e
Received: from EX19D027UEC002.ant.amazon.com (10.252.137.166) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:18:42 +0000
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19D027UEC002.ant.amazon.com (10.252.137.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:18:41 +0000
Received: from EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d]) by
 EX19D027UEC003.ant.amazon.com ([fe80::887f:519b:ba73:21d%3]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 15:18:41 +0000
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
Subject: [PATCH v12 05/16] mm/gup: drop local variable in
 gup_fast_folio_allowed
Thread-Topic: [PATCH v12 05/16] mm/gup: drop local variable in
 gup_fast_folio_allowed
Thread-Index: AQHcyP1QmbwBcUnJSEGr91ll3sDzdg==
Date: Fri, 10 Apr 2026 15:18:41 +0000
Message-ID: <20260410151746.61150-6-kalyazin@amazon.com>
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
Move the check for pinning closer to where the result is used.=0A=
No functional changes.=0A=
=0A=
Acked-by: David Hildenbrand (Arm) <david@kernel.org>=0A=
Signed-off-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>=0A=
---=0A=
 mm/gup.c | 23 ++++++++++++-----------=0A=
 1 file changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/mm/gup.c b/mm/gup.c=0A=
index e8367564d636..41eb64783e03 100644=0A=
--- a/mm/gup.c=0A=
+++ b/mm/gup.c=0A=
@@ -2737,18 +2737,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);=0A=
  */=0A=
 static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags=
)=0A=
 {=0A=
-	bool reject_file_backed =3D false;=0A=
 	struct address_space *mapping;=0A=
 	unsigned long mapping_flags;=0A=
 =0A=
-	/*=0A=
-	 * If we aren't pinning then no problematic write can occur. A long term=
=0A=
-	 * pin is the most egregious case so this is the one we disallow.=0A=
-	 */=0A=
-	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) =3D=3D=0A=
-	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))=0A=
-		reject_file_backed =3D true;=0A=
-=0A=
 	/* We hold a folio reference, so we can safely access folio fields. */=0A=
 	if (WARN_ON_ONCE(folio_test_slab(folio)))=0A=
 		return false;=0A=
@@ -2797,8 +2788,18 @@ static bool gup_fast_folio_allowed(struct folio *fol=
io, unsigned int flags)=0A=
 	 */=0A=
 	if (secretmem_mapping(mapping))=0A=
 		return false;=0A=
-	/* The only remaining allowed file system is shmem. */=0A=
-	return !reject_file_backed || shmem_mapping(mapping);=0A=
+=0A=
+	/*=0A=
+	 * If we aren't pinning then no problematic write can occur. A writable=
=0A=
+	 * long term pin is the most egregious case, so this is the one we=0A=
+	 * allow only for ...=0A=
+	 */=0A=
+	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=3D=0A=
+	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))=0A=
+		return true;=0A=
+=0A=
+	/* ... hugetlb (which we allowed above already) and shared memory. */=0A=
+	return shmem_mapping(mapping);=0A=
 }=0A=
 =0A=
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL=0A=
-- =0A=
2.50.1=0A=
=0A=
