Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53F3B6C0E;
	Tue, 26 May 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812878; cv=none; b=gSvENQRsrnmu+ScIedX38lLwwjLuVN/MHavzN9v6vsV6zgCC2XLgtgRfDG9tLYmeysjPSv72kfg1BiHu333GNZW8JhK0L0YBevM0rArfjIe1pQ78oV2WRnvwUX2Ib136odM27NPh8nopuyna3oncaKFKYpvjQDccj4tDpbvUltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812878; c=relaxed/simple;
	bh=uyHF9eg1fNPkQ8bTIFguWMYCPZbh4kpcbqHZpzfY8Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AziRrhsRir8YWeyz42HDuEP+8qUcuQZXagXkwHREyT6bphCInCt+boVrrY8r53bWLbD1giC89oRTsjRrwgzqDqSFPXtFcFAPTs4oXTj9qMhwpQ0vICtcd7j7bM+g+9M1BKQ25mi8XjytkgkI/ZUsnIRDNPUt9lvlQer72yt20cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCPBslFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCPBslFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289D31F000E9;
	Tue, 26 May 2026 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812875;
	bh=uX6weQ63PycMa+NiIwkaE0lKXtL5D7cf5slQyEH4uVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WCPBslFBHlD18xXQc3r4cfXRi6NRqMWZgpFMn1cIbrapYoU4c4gRwNK1+7uVsqGAy
	 60v2BCHvTRcdS1tVvGPbqfVfdwwcJp1FHFNfktx1fkX0Wbx1RZrVm0KBNermhINrKf
	 T9lX4lpoqb8ZTQ988HCILQXzmPKZjen7JnhZ0OVSRmfeZwap0kKaSy4gg8etm5udnf
	 udcU0Sgi7luz1Cc1OPvSW+2ubz9qCszQO2AwKg/qp69fZ72CdWGJzB5e9f6nHF0uBd
	 ldc80qXMC/DUvHJCNvAW1ArbfI1EfmFu9YdmZYAerVhlmQZOEcNqDEor/Ir+l9+s8j
	 e4sx9r+STyxUg==
Date: Tue, 26 May 2026 17:27:52 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: seanjc@google.com, Liam.Howlett@oracle.com, ackerleytng@google.com, 
	agordeev@linux.ibm.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	alex@ghiti.fr, andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org, 
	baolu.lu@linux.intel.com, borntraeger@linux.ibm.com, bp@alien8.de, bpf@vger.kernel.org, 
	catalin.marinas@arm.com, chenhuacai@kernel.org, corbet@lwn.net, coxu@redhat.com, 
	daniel@iogearbox.net, dave.hansen@linux.intel.com, david@kernel.org, 
	derekmn@amazon.com, dev.jain@arm.com, eddyz87@gmail.com, 
	gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, haoluo@google.com, hca@linux.ibm.com, 
	hpa@zytor.com, itazur@amazon.co.uk, jackabt@amazon.co.uk, jackmanb@google.com, 
	jannh@google.com, jgg@ziepe.ca, jgross@suse.com, jhubbard@nvidia.com, 
	jiayuan.chen@shopee.com, jmattson@google.com, joey.gouly@arm.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, jthoughton@google.com, kalyazin@amazon.co.uk, 
	kas@kernel.org, kernel@xen0n.name, kpsingh@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, lenb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
	lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn, martin.lau@linux.dev, 
	maz@kernel.org, mhocko@suse.com, mingo@redhat.com, mlevitsk@redhat.com, 
	nikita.kalyazin@linux.dev, oupton@kernel.org, palmer@dabbelt.com, patrick.roy@linux.dev, 
	pavel@kernel.org, pbonzini@redhat.com, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, pjw@kernel.org, prsampat@amd.com, rafael@kernel.org, 
	riel@surriel.com, rppt@kernel.org, ryan.roberts@arm.com, sdf@fomichev.me, 
	shijie@os.amperecomputing.com, skhan@linuxfoundation.org, song@kernel.org, surenb@google.com, 
	suzuki.poulose@arm.com, svens@linux.ibm.com, tabba@google.com, tglx@kernel.org, 
	thuth@redhat.com, urezki@gmail.com, vannapurve@google.com, vbabka@kernel.org, 
	will@kernel.org, willy@infradead.org, wu.fei9@sanechips.com.cn, x86@kernel.org, 
	yang@os.amperecomputing.com, yangyicong@hisilicon.com, yonghong.song@linux.dev, 
	yosry@kernel.org, yu-cheng.yu@intel.com, yuzenghui@huawei.com, 
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
Message-ID: <ahXJoHNoeCcaupzN@lucifer>
References: <aeennZlV60k81OBf@google.com>
 <20260506080753.14517-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506080753.14517-1-itazur@amazon.com>

On Wed, May 06, 2026 at 08:07:52AM +0000, Takahiro Itazuri wrote:
> Hi Lorenzo and Sean,
>
> Apologies for the delayed reply — Nikita is leaving Amazon, and I'm
> taking over this series going forward. Thanks for your patience.

Hey,

Thanks for letting us know! And thanks to Nikita for all his work, will
keep an eye out for the respin!

Cheers, Lorenzo

>
> On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
> > Hm, given this touches a fair bit of mm, I wonder if we shouldn't try to do this
> > through the mm tree?
>
> On Tue, Apr 21, 2026 at 04:36:00PM +0000, Sean Christopherson wrote:
> > Yeah, when the time comes, the mm pieces definitely need to go through the mm
> > tree.  Ideally, I think this would be merged in two separate parts, with all mm
> > changes going through the mm tree, and then the KVM changes through the KVM tree
> > using a stable topic branch/tag from Andrew.
>
> Thanks for the guidance. The split makes sense to me; I'm planning to
> follow this approach with patches 1-6 (mm) going through the mm tree
> and patches 7-16 (KVM) through the KVM tree on top of a stable
> branch/tag from mm. I'll confirm the exact boundary and coordination
> details as I prepare the repost.
>
> On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
> > In any case, we definitely need a rebase on something not-next :) if not mm then
> > Linus's tree at least maybe?
> >
> > I'm seeing a lot of conflicts against mm-unstable, it can't b4 shazam even patch
> > 1 and in Linus's tree it's failing at an mm patch (mm: introduce
> > AS_NO_DIRECT_MAP).
>
> I'll rebase onto v7.1-rc1 and resolve the conflicts as part of the split.
>
> Takahiro
>
