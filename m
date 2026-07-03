Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA43D88F5;
	Fri,  3 Jul 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085955; cv=none; b=rz9iraxqKGrvU/pRETFAFPjlsZEg7ciFr7pZspat91dx+TbtFJ59B74/tbwCsbk1c7UInyxV7P1eGPnZ7aEdrNREhRuhdMuNz5NAM9fa03f5/z5icMbdFaRFJL3va5Yopw2AueZ2KyA0TZqy3zbYF4i92005EVZ4RJH6bJDatSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085955; c=relaxed/simple;
	bh=7WWSbSoIwq/hUhTjnTNiVjOrA3d9Lyf8l1GJiBo9eH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfkXcjaS3cBk+lOqXGpmymPNgwJiZPn/8MoMJgNDAUJfc63r19Pv0RyO/f47DDJ7Lot0G5Cwh4hN8qtTJd8m2/5mC2BOp3hqMLIdL15h1Z4tEsliJ3h2idKLdFAdOwb7isUOBJUhXvZvCRbbZccovzyLHwqIJbxXgPu7UZ5rAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy2MjFOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy2MjFOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187FE1F000E9;
	Fri,  3 Jul 2026 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085954;
	bh=gZAdfsOK4tFSPJR7Aj2D7TzZA7j60EZxfwd8tWq9E3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iy2MjFODHI3xorm5lCCn7X6KmOVRg3yW91mvKPD3two97lMxlZP19piRDprB1eNYc
	 DYlZMhegN1/lp/SjFedKlM3U/uDlvrL/9FgXMqyE6u/yL0Ujaob2xTzV37rWwMRkoq
	 RD+Cfv1Ss+ANInYh8hjtzd8vOZ2qyNFX0YLUuiDSmBvMQl4DJfBeWFbgehjn15IkuW
	 pLv3nUbJk9Vw7He2DwneABC+WC7/sy307tOrWzutaUbX1KeUAFwPxeahHXI0Vw6oyu
	 0/7olW/AWWlIiQs2eKZwXYIiO1DZHs2HA0/80RJmZuQ+CO8dQ46MDNubibxQD7ahra
	 YV7D3efGERuwA==
Date: Fri, 3 Jul 2026 16:38:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"vbabka@kernel.org" <vbabka@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"riel@surriel.com" <riel@surriel.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"coxu@redhat.com" <coxu@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"yosry@kernel.org" <yosry@kernel.org>,
	"maobibo@loongson.cn" <maobibo@loongson.cn>,
	"tabba@google.com" <tabba@google.com>,
	"prsampat@amd.com" <prsampat@amd.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>,
	"gor@linux.ibm.com" <gor@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
	"vannapurve@google.com" <vannapurve@google.com>,
	"jackmanb@google.com" <jackmanb@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>,
	"Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [PATCH v12 02/16] set_memory: add folio_{zap,restore}_direct_map
 helpers
Message-ID: <ake7aPB2O_-dAXhI@kernel.org>
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-3-kalyazin@amazon.com>
 <DJOUYOKL6N3R.BFIO8HEL03OA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJOUYOKL6N3R.BFIO8HEL03OA@linux.dev>

On Fri, Jul 03, 2026 at 10:19:10AM +0000, Brendan Jackman wrote:
> On Fri Apr 10, 2026 at 3:18 PM UTC, Nikita Kalyazin wrote:
> 
> My local Sashiko run pointed out that this is broken for highmem.
> 
> There's no highmem for guest_memfd but there is for secretmem.
> 
> ... but this isn't actually an issue with the patch, it's currently
> broken in Linus' master:
> 
> Su[   30.071284] ------------[ cut here ]------------
> ccessfully allocated and mapped 2097152000 bytes at 0x3a449000
> Populating memor[   30.074614] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
> y...
> [   30.078636] WARNING: arch/x86/mm/pat/set_memory.c:1840 at __cpa_process_fault+0x34d/0x360, CPU#5: allocate_secret/570
> [   30.084789] CPU: 5 UID: 0 PID: 570 Comm: allocate_secret Not tainted 7.1.0-14063-g4edcdefd4083-dirty #10 PREEMPTLAZY
> [   30.090937] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   30.097543] EIP: __cpa_process_fault+0x34d/0x360
> [   30.100514] Code: ff ff 85 c0 0f 89 7d fe ff ff e9 3d fe ff ff 8b 03 8b 00 c7 04 24 c8 ff 64 c1 89 44 24 08 8b 45 e8 89 44 24 04 e8 53 7a 00 00 <0f> 0b c7 45 f0 f2 ff ff ff e9 fc fc ff ff 90 8d 74 26 00 55 25 00
> [   30.110829] EAX: 00000000 EBX: f64afe98 ECX: 00000000 EDX: 00000000
> [   30.114799] ESI: 00000000 EDI: f64afe98 EBP: f64afe04 ESP: f64afdcc
> [   30.118785] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
> [   30.123020] CR0: 80050033 CR2: 46c48ffc CR3: 038c8000 CR4: 00000690
> [   30.127010] Call Trace:
> [   30.129078]  __change_page_attr_set_clr+0x5e7/0x870
> [   30.132275]  ? console_unlock+0x99/0x130
> [   30.135069]  ? irq_work_queue+0x36/0x70
> [   30.137853]  ? page_address+0xd3/0xf0
> [   30.140421]  set_direct_map_invalid_noflush+0x52/0x60
> [   30.143782]  secretmem_fault+0x128/0x210
> [   30.146560]  __do_fault+0x25/0x90
> [   30.149053]  handle_mm_fault+0x6d1/0xcb0
> [   30.151759]  exc_page_fault+0x135/0x3b0
> [   30.154487]  ? doublefault_shim+0x150/0x150
> [   30.157416]  handle_exception+0x130/0x130
> [   30.160137] EIP: 0x804d29f
> [   30.162307] Code: 89 54 08 e1 89 54 08 e5 89 54 08 e9 89 54 08 ed c3 0f b6 44 24 08 89 7c 24 0c 69 c0 01 01 01 01 8b 7c 24 04 f7 c7 0f 00 00 00 <89> 44 0f fc 75 0e c1 e9 02 f3 ab 8b 44 24 04 8b 7c 24 0c c3 31 d2
> [   30.172936] EAX: 5a5a5a5a EBX: 00000000 ECX: 0c800000 EDX: 3a449000
> [   30.176927] ESI: 00000000 EDI: 3a449000 EBP: bfbbae18 ESP: bfbbadac
> [   30.180897] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
> [   30.185161]  ? doublefault_shim+0x150/0x150
> [   30.187979] ---[ end trace 0000000000000000 ]---
> Bus error                  (core dumped) ./allocate_secret_i686 2000M
> 
> Fixing this directly in secretmem.c is kinda yucky but if we can just
> make folio_zap_direct_map() a NOP for highmem folios it's nice and easy
> so I propose to just fix it as a followup to this series.
> 
> Alternatively, we maybe should disable secretmem for highmem systems
> since it evidently doesn't have any users.

Yes, please :) 

-- 
Sincerely yours,
Mike.
