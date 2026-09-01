Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBB374A1D;
	Tue,  1 Sep 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271626; cv=none; b=ePTaZjjudE7FNannLXZJnNfCBe76ezhpJ2O0ov9v43zknmCt43GokLqUVFuqvCXtbfbqFJStddDkCSgJqTFZd3jUgVv0ANzLkn5mhTMzo3LbAwKWyYDk+IiIlNcF0/Fo4sqwiOEklHQys4JvmvG/F8KioJsUZNJVLfru8LUzc98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271626; c=relaxed/simple;
	bh=1O9/rKU7KHiOHnc3FZFhXmrPr5pw2k6/sI2pYOXuv74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C++rrA/Hfs+mA6KrdyRRq/3A4J0QRaiycmsR95r28bOPNTg385FcHSuaE2ARinVCWCBDWdeznbt8XUzh/FQqzYSDIXhJsVl0FUg+MEtoe8NWh9588XkAqpCQ53x3aZxWsjHXRpu3iir7pwg1CS/4Hv+AbzwdQJhM7NaQPwlaVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MPdwjkFW; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MPdwjkFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788271625; x=1819807625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwbUYxXHQaXTXqslqakO/JmHO0leSCcNPKEN6HpwsIg=;
  b=MPdwjkFWrfa6dJPtq/YabRBPOpV1UTECJbQ2tvIr9ava77J0n3RMlptQ
   W8Nb0tH3Y9nv1v0ATx+yBnE/jjTK9efjjoCcU8++SdjQNI0a0yZffFK6i
   XbbFsjCrl2BjdExAg7P7PbhLeWRE/yDXbrDvG3+K4AsTNmIxr5Z5Zy8fZ
   oHnoXeDKlhlkGJPX7g7aD35y8hccpgpFwsB1MpTNitMO6prunD6xWrBpB
   DFdM9pInal6uudq9FU8f4lH5sLtTrEqxwaRWOA4yujughApzmnmtM9heY
   pXtDctQywq9ISwqoBN3/Gbgl/wbqraZF8aVpu4PekkRofQtTqfaBOnJg4
   A==;
X-CSE-ConnectionGUID: g7Zx9TRQQvWpTs8W3wP04w==
X-CSE-MsgGUID: 9pLg4PSzQd6ZYHeZKQt6qQ==
X-IronPort-AV: E=Sophos;i="6.25,256,1779148800"; 
   d="scan'208";a="27537013"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:07:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:11398]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.146:2525] with esmtp (Farcaster)
 id 8f131d5e-0695-4138-b720-3dbdcb1830d0; Tue, 1 Sep 2026 14:07:01 +0000 (UTC)
X-Farcaster-Flow-ID: 8f131d5e-0695-4138-b720-3dbdcb1830d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 1 Sep 2026 14:07:01 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.82.17) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Tue, 1 Sep 2026 14:06:44 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <brendan.jackman@linux.dev>, <maz@kernel.org>
CC: <Liam.Howlett@oracle.com>, <ackerleytng@google.com>,
	<agordeev@linux.ibm.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <alex@ghiti.fr>, <andrii@kernel.org>,
	<ast@kernel.org>, <baolu.lu@linux.intel.com>, <borntraeger@linux.ibm.com>,
	<bp@alien8.de>, <bpf@vger.kernel.org>, <catalin.marinas@arm.com>,
	<chenhuacai@kernel.org>, <corbet@lwn.net>, <coxu@redhat.com>,
	<daniel@iogearbox.net>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
	<dev.jain@arm.com>, <eddyz87@gmail.com>, <haoluo@google.com>,
	<hpa@zytor.com>, <itazur@amazon.co.uk>, <jackmanb@google.com>,
	<jannh@google.com>, <jgg@ziepe.ca>, <jgross@suse.com>, <jhubbard@nvidia.com>,
	<jmattson@google.com>, <joey.gouly@arm.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <jthoughton@google.com>, <kalyazin@amazon.co.uk>,
	<kas@kernel.org>, <kernel@xen0n.name>, <kpsingh@kernel.org>,
	<kvm@vger.kernel.org>, <kvmarm@lists.linux.dev>, <lenb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<lorenzo.stoakes@oracle.com>, <luto@kernel.org>, <maobibo@loongson.cn>,
	<martin.lau@linux.dev>, <mhocko@suse.com>, <mingo@redhat.com>,
	<mlevitsk@redhat.com>, <oupton@kernel.org>, <palmer@dabbelt.com>,
	<patrick.roy@linux.dev>, <pavel@kernel.org>, <pbonzini@redhat.com>,
	<peterx@redhat.com>, <peterz@infradead.org>, <pfalcato@suse.de>,
	<pjw@kernel.org>, <prsampat@amd.com>, <riel@surriel.com>, <rppt@kernel.org>,
	<ryan.roberts@arm.com>, <sdf@fomichev.me>, <seanjc@google.com>,
	<shijie@os.amperecomputing.com>, <skhan@linuxfoundation.org>,
	<song@kernel.org>, <surenb@google.com>, <suzuki.poulose@arm.com>,
	<tabba@google.com>, <tglx@kernel.org>, <thuth@redhat.com>,
	<vannapurve@google.com>, <vbabka@kernel.org>, <will@kernel.org>,
	<willy@infradead.org>, <wu.fei9@sanechips.com.cn>, <x86@kernel.org>,
	<yang@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
	<yonghong.song@linux.dev>, <yosry@kernel.org>, <yu-cheng.yu@intel.com>,
	<yuzenghui@huawei.com>, <zhengqi.arch@bytedance.com>, Takahiro Itazuri
	<zulinx86@gmail.com>
Subject: Re: [PATCH v12 09/16] KVM: arm64: define kvm_arch_gmem_supports_no_direct_map()
Date: Tue, 1 Sep 2026 15:05:21 +0100
Message-ID: <20260901140520.78333-2-itazur@amazon.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <DJJ28Z81JTQI.1SI0CNIP7W1JQ@linux.dev>
References: <DJJ28Z81JTQI.1SI0CNIP7W1JQ@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Apologies for the delayed response, and thank you for the review.

On Fri, 26 Jun 2026 14:45:45 +0000, Brendan Jackman wrote:
> On Tue Apr 21, 2026 at 4:55 PM UTC, Marc Zyngier wrote:
> > Support for GUEST_MEMFD_FLAG_NO_DIRECT_MAP on arm64 depends on 1) direct
> > map manipulations at 4k granularity being possible, and 2) FEAT_S2FWB.
> >
> > Where is this 4kB requirement enforced? Or is it that you means
> > "PAGE_SIZE"?
>
> Yeah I believe this means PAGE_SIZE and that it's effectively enforced
> by checking can_set_direct_map() in
> kvm_arch_gmem_supports_no_direct_map().

Yes, this should say PAGE_SIZE rather than 4k.

If I understand the arm64 MM code correctly, can_set_direct_map() is the
capability gate, but it does not require the linear map to be built with
page-sized PTEs from boot. Without BBML2_NOABORT, force_pte_mapping()
builds the linear map with PAGE_SIZE PTEs. With BBML2_NOABORT,
update_range_prot() can use split_kernel_leaf_mapping() to safely split
larger mappings on demand before changing a PAGE_SIZE range.

I'll update the v13 commit message to describe this.

On Tue, 21 Apr 2026 17:55:05 +0100, Marc Zyngier wrote:
> KVM/arm64 has:
>
>         select KVM_GUEST_MEMFD

I also confirmed that KVM/arm64 selects KVM_GUEST_MEMFD, so I'll drop the
redundant #ifdef in v13.

> Why is it an inline function? Given that it takes a kvm parameter,
> I fully expect that you'll have to evaluate this at some point.
>
> But since struct kvm cannot be dereferenced in asm/kvm_host.h, it will
> have to move. How about doing it right now?

Agreed. Although the current implementation does not dereference kvm, it
makes sense to move it out of asm/kvm_host.h now. I'll move the
implementation to an arm64 KVM .c file in v13.
