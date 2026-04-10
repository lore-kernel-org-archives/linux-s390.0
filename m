Received: from iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.254.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D213D9DDE;
	Fri, 10 Apr 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.197.254.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835057; cv=none; b=AZN83YyaVFpjCbGfyKHZMcHd1GL1WGVZ17mIJ/6aLU/ZewiGiR1//7G34dKn8QsCdhmKJgvNYr3ZF8M8LP7pD69Sj8oDB+8v9DwQxTBExgf9H/0CnsmLBUo6MDdMAtUsuSHvBVULm5GEAkBE8XWX4WN5h4NnyH0HOh9Q6To8MUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835057; c=relaxed/simple;
	bh=OIRQILUBc9oJdRt5XXErxyUnfe+lKJHSFNVPfJzNKbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KjMIWQd3b1v3N9w0yHMCFf04pwcx7hx4qi2r8/hFr2orWHCMi7kDmmthmfY2h8Gq3KSyWeDYJ0C0VwlodeuCWImKwg+PvxJS++/+MgALbkvVwMR64mhdZJ/0DvD3uUocY23oWaFnSmlFqNtNHc3JcO32JQ/45HELuwsGPY6v+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=n018FSLT; arc=none smtp.client-ip=34.197.254.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="n018FSLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775835056; x=1807371056;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=fk/G0VoAmsTULxx1duFy1qBcFztpaqd84bNcnJdqZbI=;
  b=n018FSLTH4un0ewyA5Vfw2TQnix43wY+xUYls0yG4+8wWSidmEghUreY
   ppTOeMxf0MGOhpympCj3AXhwtW8PXaNfb+lY5FZfT2mZk+m/a063QmbX1
   zsLrVDjToSI7BbiXJt0lGNe8Sz33LR0jtFRdHz9qVypiVr5YFxYuiOJQa
   4cSIUjL8cGYxrwhpH23XsR5GiERpeWkbmxTtxATVYBZ0a1UJReVxZynqX
   HomCjalp84f6cgnHqf1eppOHwexKkBCAHqpgloZSObEMqIhu5pz4in6Xc
   +lPwAoz9hj29q4bS+cW8ptDavgGJmvfAyJSDXOrokEsEIARgPb2MsARSo
   g==;
X-CSE-ConnectionGUID: EfpEH2kdQD+iuAgL71BkKg==
X-CSE-MsgGUID: S2cYWuC+QKSF2lkzx+JDHw==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15700706"
Received: from ip-10-4-17-41.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.17.41])
  by internal-iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:30:52 +0000
Received: from EX19MTAUEA001.ant.amazon.com [72.21.196.67:32091]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.29.254:2525] with esmtp (Farcaster)
 id 88ad7e41-cdbc-4feb-8b06-7a4fac6cc058; Fri, 10 Apr 2026 15:30:51 +0000 (UTC)
X-Farcaster-Flow-ID: 88ad7e41-cdbc-4feb-8b06-7a4fac6cc058
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:30:51 +0000
Received: from [192.168.12.97] (10.106.82.30) by EX19D027UEC003.ant.amazon.com
 (10.252.137.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 10 Apr 2026
 15:30:39 +0000
Message-ID: <45807109-570d-4681-bbd0-7a1649f515d9@amazon.com>
Date: Fri, 10 Apr 2026 16:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v11 10/16] KVM: guest_memfd: Add flag to remove from
 direct map
To: Ackerley Tng <ackerleytng@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"tabba@google.com" <tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>,
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
	"Manwaring, Derek" <derekmn@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com>
 <20260317141031.514-11-kalyazin@amazon.com>
 <CAEvNRgGb95C3uRxPy2_Uj7SmTW45hNNdJxi5RR209s5KYcHgBw@mail.gmail.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJp2NfjBQkGQlIzAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPPNDAEAvsw8vEWj8ArWQ1QJNufjrvobU/cE8MLKdBxbSE8CyZQA/0BldKxNAtAwG4qw
 wCLxsZ5vBL3Zkh/PdvtFCj/VGscGzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmnY1+MFCQZCUjMCGwwACgkQr5LKIKmaZPPQKgD/f3FtERbJ+LYHLSG/ZbLNAOLngUlQ
 qo5VfIyJOzeLzC0BAP2PIUFIHo7vmia/PXEmT+ve4c5rx+EkH/Dx1GRpjWoI
In-Reply-To: <CAEvNRgGb95C3uRxPy2_Uj7SmTW45hNNdJxi5RR209s5KYcHgBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D005EUA004.ant.amazon.com (10.252.50.241) To
 EX19D027UEC003.ant.amazon.com (10.252.137.250)



On 23/03/2026 21:15, Ackerley Tng wrote:
> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:
> 
>>
>> [...snip...]
>>
>>   static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>   {
>>        struct inode *inode = file_inode(vmf->vma->vm_file);
>>        struct folio *folio;
>>        vm_fault_t ret = VM_FAULT_LOCKED;
>> +     int err;
>>
>>        if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>>                return VM_FAULT_SIGBUS;
>> @@ -418,6 +454,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>                folio_mark_uptodate(folio);
>>        }
>>
>> +     if (kvm_gmem_no_direct_map(folio_inode(folio))) {
>> +             err = kvm_gmem_folio_zap_direct_map(folio);
>> +             if (err) {
>> +                     ret = vmf_error(err);
>> +                     goto out_folio;
>> +             }
>> +     }
>> +
>>        vmf->page = folio_file_page(folio, vmf->pgoff);
>>
> 
> Sashiko pointed out that kvm_gmem_populate() might try and write to
> direct-map-removed folios, but I think that's handled because populate
> will first try and GUP folios, which is already blocked for
> direct-map-removed folios.

As far as I can see, it is a valid issue as populate only GUPs the 
source pages, not gmem.  I think this is similar to what was discussed 
about TDX at some point and decided to exclude TDX support [1].  I 
followed the same path and excluded SEV-SNP in the patch 8 [2].  I kept 
your and David's "Reviewed-by:" for that patch, but please let me know 
if this makes you change your minds.

[1] https://lore.kernel.org/kvm/aWpcDrGVLrZOqdcg@google.com
[2] https://lore.kernel.org/kvm/20260410151746.61150-9-kalyazin@amazon.com

> 
>>   out_folio:
>> @@ -528,6 +572,9 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>        kvm_pfn_t pfn = page_to_pfn(page);
>>        int order = folio_order(folio);
>>
>> +     if (kvm_gmem_folio_no_direct_map(folio))
>> +             kvm_gmem_folio_restore_direct_map(folio);
>> +
>>        kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>>   }
>>
> 
> Sashiko says to invalidate then restore direct map, I think in this case
> it doesn't matter since if the folio needed invalidation, it must be
> private, and the host shouldn't be writing to the private pages anyway.
> 
> One benefit of retaining this order (restore, invalidate) is that it
> opens the invalidate hook to possibly do something regarding memory
> contents?
> 
> Or perhaps we should just take the suggestion (invalidate, restore) and
> align that invalidate should not touch memory contents.
> 
>> @@ -591,6 +638,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>        /* Unmovable mappings are supposed to be marked unevictable as well. */
>>        WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>>
>> +     if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)
>> +             mapping_set_no_direct_map(inode->i_mapping);
>> +
>>        GMEM_I(inode)->flags = flags;
>>
>>        file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_fops);
>> @@ -803,13 +853,22 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>        }
>>
>>        r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> +     if (r)
>> +             goto out_unlock;
>>
>> +     if (kvm_gmem_no_direct_map(folio_inode(folio))) {
>> +             r = kvm_gmem_folio_zap_direct_map(folio);
>> +             if (r)
>> +                     goto out_unlock;
>> +     }
>> +
>>
>> [...snip...]
>>
> 
> Preparing a folio used to involve zeroing, but that has since been
> refactored out, so I believe zapping can come before preparing.
> 
> Similar to the above point on invalidation: perhaps we should take the
> suggestion to zap then prepare
> 
> + And align that preparation should not touch memory contents
> + Avoid needing to undo the preparation on zapping failure (.free_folio
>    is not called on folio_put(), it is only called folio on removal from
>    filemap).

I reordered both, thanks.
