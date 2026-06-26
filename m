Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B73D669D
	for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487748; cv=none; b=J1NhFWataYfNgbvmBgA1mGJco1J4DuU088UAM2hmLhPRrjxrIv3OI6TZtWvS4hBOn4HvEhV4jVPSZxD8zGouR5UAZhAPEyQHlhmbWEuYeJeXG052AihhHwBbRZ5YsapEOrcRABn0xAcLJLpVIiBv1VImMDkkxtDfTdcyUXV5s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487748; c=relaxed/simple;
	bh=Wy502H7G6EG5DDUhaqL8ZH31eQuVJEouI4PSOxFgm0M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AqFwXvrGh1jFkls0XBRWcdq11egauw5Cukm6tO0UvRgM1ZaJAubugQqqoSQnmojTmMSYf5hsmc3k0vVzPovkUyuwJtn50IliKJ5qsjh+T4PfV29XKqG71v100aH6M6YOj7YK94aP6PlXzsUX+YRO585fIFoWvLYbgt0D6Y0ivZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wIhePOhy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wIhePOhy"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782487742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9yV2d4U6Iq5tvwMQAZTQglaDvuPvKN3XGu5+n1GLLQ=;
	b=wIhePOhyn6G6N5ff0edE/tWPIL0KMu4yLFZwEwWoqZZHrBK6tCDf3vdBAO8t9df+oI6kuQ
	xLnpFgOEs4zA46/+kNEFwdQe2/mKKSiElfQZLqTo8viWrcXcy9xwbuopsxn4/7w4KV94aW
	uCiQ2fhh93vV19Hi8UBA0NS234VnMPI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:28:43 +0000
Message-Id: <DJJ35VLH2PE5.DFD8OYXEOH97@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Takahiro Itazuri" <itazur@amazon.com>, <seanjc@google.com>,
 <ljs@kernel.org>
Cc: <Liam.Howlett@oracle.com>, <ackerleytng@google.com>,
 <agordeev@linux.ibm.com>, <ajones@ventanamicro.com>,
 <akpm@linux-foundation.org>, <alex@ghiti.fr>, <andrii@kernel.org>,
 <aou@eecs.berkeley.edu>, <ast@kernel.org>, <baolu.lu@linux.intel.com>,
 <catalin.marinas@arm.com>, <chenhuacai@kernel.org>, <corbet@lwn.net>,
 <coxu@redhat.com>, <daniel@iogearbox.net>, <dave.hansen@linux.intel.com>,
 <david@kernel.org>, <dev.jain@arm.com>, <itazur@amazon.co.uk>,
 <jackmanb@google.com>, <jannh@google.com>, <jhubbard@nvidia.com>,
 <jmattson@google.com>, <joey.gouly@arm.com>, <john.fastabend@gmail.com>,
 <jolsa@kernel.org>, <jthoughton@google.com>, <kas@kernel.org>,
 <kernel@xen0n.name>, <kpsingh@kernel.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.linux.dev>, <lenb@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <lorenzo.stoakes@oracle.com>, <luto@kernel.org>, <maobibo@loongson.cn>,
 <martin.lau@linux.dev>, <maz@kernel.org>, <mhocko@suse.com>,
 <mingo@redhat.com>, <mlevitsk@redhat.com>, <nikita.kalyazin@linux.dev>,
 <oupton@kernel.org>, <palmer@dabbelt.com>, <patrick.roy@linux.dev>,
 <pavel@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <peterz@infradead.org>, <pfalcato@suse.de>, <pjw@kernel.org>,
 <prsampat@amd.com>, <rafael@kernel.org>, <riel@surriel.com>,
 <rppt@kernel.org>, <ryan.roberts@arm.com>, <sdf@fomichev.me>,
 <shijie@os.amperecomputing.com>, <skhan@linuxfoundation.org>,
 <song@kernel.org>, <surenb@google.com>, <suzuki.poulose@arm.com>,
 <svens@linux.ibm.com>, <tabba@google.com>, <tglx@kernel.org>,
 <thuth@redhat.com>, <urezki@gmail.com>, <vannapurve@google.com>,
 <vbabka@kernel.org>, <will@kernel.org>, <willy@infradead.org>,
 <wu.fei9@sanechips.com.cn>, <x86@kernel.org>,
 <yang@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
 <yonghong.song@linux.dev>, <yosry@kernel.org>, <yu-cheng.yu@intel.com>,
 <yuzenghui@huawei.com>, <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v12 00/16] Direct Map Removal Support for guest_memfd
References: <aeennZlV60k81OBf@google.com>
 <20260506080753.14517-1-itazur@amazon.com>
In-Reply-To: <20260506080753.14517-1-itazur@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Wed May 6, 2026 at 8:07 AM UTC, Takahiro Itazuri wrote:
> Hi Lorenzo and Sean,
>
> Apologies for the delayed reply =E2=80=94 Nikita is leaving Amazon, and I=
'm
> taking over this series going forward. Thanks for your patience.
>
> On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
>> Hm, given this touches a fair bit of mm, I wonder if we shouldn't try to=
 do this
>> through the mm tree?
>
> On Tue, Apr 21, 2026 at 04:36:00PM +0000, Sean Christopherson wrote:
>> Yeah, when the time comes, the mm pieces definitely need to go through t=
he mm
>> tree.  Ideally, I think this would be merged in two separate parts, with=
 all mm
>> changes going through the mm tree, and then the KVM changes through the =
KVM tree
>> using a stable topic branch/tag from Andrew.
>
> Thanks for the guidance. The split makes sense to me; I'm planning to
> follow this approach with patches 1-6 (mm) going through the mm tree
> and patches 7-16 (KVM) through the KVM tree on top of a stable
> branch/tag from mm. I'll confirm the exact boundary and coordination
> details as I prepare the repost.
>
> On Tue, Apr 21, 2026 at 01:40:00PM +0000, Lorenzo Stoakes wrote:
>> In any case, we definitely need a rebase on something not-next :) if not=
 mm then
>> Linus's tree at least maybe?
>>
>> I'm seeing a lot of conflicts against mm-unstable, it can't b4 shazam ev=
en patch
>> 1 and in Linus's tree it's failing at an mm patch (mm: introduce
>> AS_NO_DIRECT_MAP).
>

Just as an FYI, I am gonna look at trying to move this forward a bit
while Takahiro ramps up on taking over (I spoke to him about this off
list).

My ulterior motive is that this would give me an excuse to add
ALLOC_UNMAPPED (formerly __GFP_UNMAPPED) and the mermap [0] which
unblocks various security nonsense including ASI [1]. (But also, this
feature is a good idea).

[0] https://lore.kernel.org/all/20260320-page_alloc-unmapped-v2-0-28bf1bd54=
f41@google.com/
[1] https://linuxasi.dev
