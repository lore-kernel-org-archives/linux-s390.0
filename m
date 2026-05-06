Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F83E123A;
	Wed,  6 May 2026 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054902; cv=none; b=HR3WOs7Ja2eh1TvGbXchV5JIFq0KEV/8X2D979+F034arWQ6wqgREKDP4KEXw4Mt5sCNJcE61akfIfh9YlJutbLO6kZOcjAooo3ZkXLQ9mtUIxjNVJeSp0bEJPHiZftJYmW0WZUdAwS2u2tp+2cMIhEoUFlHC0AEAZbvcDGLRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054902; c=relaxed/simple;
	bh=LakSgXK9xZWfp62uOJDjuByvdgT3HOkvb9TfiFQGvLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVG39jySvJ/+3ee7DQECwTBZ09B3nHnwfKA1bs6/JCudtcE2X1XMsLcEeWjP9ohBlOFjIA+KoUEc8F62Jvg1Ai/80p1MHnuY0DBvvvsvz/z4kVCzTaRKFmLXL4g/iS7lSANmj4cxHMOL9vBqHOHjg66z2SzDNC66KUKP9jc6gsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XmfCuIXA; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XmfCuIXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778054900; x=1809590900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfdMAsgvM6p8hWk2sdmIXhE1O1tOVF0HFNlReXBroqU=;
  b=XmfCuIXAF6d7b2BBCfezzI6lhB2W3xRFdTJ58T7uFoDIjOQRXC/wdaZY
   ThKAkg+TdefJtTnaGAg4Wu+hZk0qtvw3DpMIVGO7XTouuWs8WbfODJmtt
   BxGb4uhnzZxBGiIPEPhiz6+LuQnrTTdtWBDPGCgje78IZBtJGAnXt30Nx
   FBUmVOzjTRUr4uZDqVNBU7hqMbLE4D2TfkHcUDdaMGuHHfYBlvxnzrcL9
   GY8aA5L3yMpDf0cqksUWxseGsaEG/g5O+G72uJLm6AP8BPfZd6sAhNLVK
   UewJGEb4jl7vd3wAvmrnP5xMZ/hKYzU9VdAAleMG+HOszeHEouwQAyZ+H
   g==;
X-CSE-ConnectionGUID: MmMFvwZCQLewcyBwlWjNrw==
X-CSE-MsgGUID: dKPa6oOPR+SZmZUz/KuDQg==
X-IronPort-AV: E=Sophos;i="6.23,219,1770595200"; 
   d="scan'208";a="18975878"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:08:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:20934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.153:2525] with esmtp (Farcaster)
 id 4c3798b6-d4c5-412e-bccc-51de55c2e359; Wed, 6 May 2026 08:08:17 +0000 (UTC)
X-Farcaster-Flow-ID: 4c3798b6-d4c5-412e-bccc-51de55c2e359
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 08:08:17 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 08:08:03 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <seanjc@google.com>, <ljs@kernel.org>
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
	<yuzenghui@huawei.com>, <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
Date: Wed, 6 May 2026 08:07:52 +0000
Message-ID: <20260506080753.14517-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aeennZlV60k81OBf@google.com>
References: <aeennZlV60k81OBf@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Lorenzo and Sean,

Apologies for the delayed reply =E2=80=94 Nikita is leaving Amazon, and I'm
taking over this series going forward. Thanks for your patience.

On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
> Hm, given this touches a fair bit of mm, I wonder if we shouldn't try to =
do this
> through the mm tree?

On Tue, Apr 21, 2026 at 04:36:00PM +0000, Sean Christopherson wrote:
> Yeah, when the time comes, the mm pieces definitely need to go through th=
e mm
> tree.  Ideally, I think this would be merged in two separate parts, with =
all mm
> changes going through the mm tree, and then the KVM changes through the K=
VM tree
> using a stable topic branch/tag from Andrew.

Thanks for the guidance. The split makes sense to me; I'm planning to
follow this approach with patches 1-6 (mm) going through the mm tree
and patches 7-16 (KVM) through the KVM tree on top of a stable
branch/tag from mm. I'll confirm the exact boundary and coordination
details as I prepare the repost.

On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
> In any case, we definitely need a rebase on something not-next :) if not =
mm then
> Linus's tree at least maybe?
>
> I'm seeing a lot of conflicts against mm-unstable, it can't b4 shazam eve=
n patch
> 1 and in Linus's tree it's failing at an mm patch (mm: introduce
> AS_NO_DIRECT_MAP).

I'll rebase onto v7.1-rc1 and resolve the conflicts as part of the split.

Takahiro

