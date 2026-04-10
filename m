Received: from iad-out-003.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-003.esa.us-east-1.outbound.mail-perimeter.amazon.com [13.216.7.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BC3DB63F;
	Fri, 10 Apr 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.216.7.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834981; cv=none; b=Makzbly107L/JiVQgjmLpJHHavhVH2si25b9W6+G+Z1WZrBaWayap6hGv9dZB+OvQkYisb9l2/EFnzBDKt7VdaZdlOPd86h0rTMaVcHw2cr1A78+80i2P3EirGnW76oHDIYI7Q9Ejxb35DGia/EN3zZq83ZtIwjxUB1y3jc1cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834981; c=relaxed/simple;
	bh=hi7fsYEjIwddypla4AXhetUSQFsjC8RB+2OuOI2Gq/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J0MJKEwoS8anpx3DmASS5ULlH2IYh8vw5Gbi0RANcy4Lh+iOw14tctCfCHTafYht/tmo4jKQwJDwjCkq+CJiNuaHrFz9y+ZLmkdUrrKSaAqAMvtXwHI0GFXNv3lSFbhbxJ2TP+uFImO2Kmk+DCxB13ZYlD8rKxoLvZPfQvZfXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jzD7u/Vd; arc=none smtp.client-ip=13.216.7.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jzD7u/Vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775834979; x=1807370979;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=VnoFhiFBbMUTFQgLKAW7Zr/OcX3Sy0nEbMUwuooSdx4=;
  b=jzD7u/Vd78MSgV8+40wdxCkoumIs9IcnzAWtKdRAc96kC3JUkAwx/50g
   5Az4Y4e3BRiQZoPe1jYphaeUmWQEBHVHVCeAqFObbooxdL/z3+185S0HV
   kKquc7GRyBIV45Xag0xGWwTUfov++eTFvm0cank2IQ9nr4/ngk8g/gqG7
   qAERTO/AIvpqGfvOnYa7dqeDzaeWJxU6+Z3LyHDKmBwKwVrzCbtPxDd5y
   L0eQXrkdlIxdP4zarU2gJZy9q49lN1ngEByPZnUJMKVSBxjnwjq/BJzZU
   QTovhZdckDWWKw7tLJ+3XTRbqdanfO6O38Es9QYjBNZFtVcal4TfirUov
   Q==;
X-CSE-ConnectionGUID: l444M+2IQ3efoc7Pq16yxw==
X-CSE-MsgGUID: 4AZuz/LTTRy8oUAzNnFhGQ==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15812074"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-003.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:29:38 +0000
Received: from EX19MTAUEA002.ant.amazon.com [52.94.133.129:10453]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.3.180:2525] with esmtp (Farcaster)
 id d7b613a2-9e43-407f-8a16-526b4eceebd7; Fri, 10 Apr 2026 15:29:37 +0000 (UTC)
X-Farcaster-Flow-ID: d7b613a2-9e43-407f-8a16-526b4eceebd7
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:29:37 +0000
Received: from [192.168.12.97] (10.106.82.30) by EX19D027UEC003.ant.amazon.com
 (10.252.137.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 10 Apr 2026
 15:29:25 +0000
Message-ID: <3a51c589-e702-44a9-8ac1-9150c2de666d@amazon.com>
Date: Fri, 10 Apr 2026 16:29:23 +0100
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Kalyazin, Nikita"
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
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
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
	"Manwaring, Derek" <derekmn@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com>
 <20260317141031.514-11-kalyazin@amazon.com>
 <50bfaeb5-551e-403f-bd00-a7d8b6bbf6e2@kernel.org>
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
In-Reply-To: <50bfaeb5-551e-403f-bd00-a7d8b6bbf6e2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D008EUC002.ant.amazon.com (10.252.51.146) To
 EX19D027UEC003.ant.amazon.com (10.252.137.250)



On 23/03/2026 18:05, David Hildenbrand (Arm) wrote:
> On 3/17/26 15:12, Kalyazin, Nikita wrote:
>> From: Patrick Roy <patrick.roy@linux.dev>
>>
>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
>> ioctl. When set, guest_memfd folios will be removed from the direct map
>> after preparation, with direct map entries only restored when the folios
>> are freed.
>>
>> To ensure these folios do not end up in places where the kernel cannot
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
>>
>> Note that this flag causes removal of direct map entries for all
>> guest_memfd folios independent of whether they are "shared" or "private"
>> (although current guest_memfd only supports either all folios in the
>> "shared" state, or all folios in the "private" state if
>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
>> entries of also the shared parts of guest_memfd are a special type of
>> non-CoCo VM where, host userspace is trusted to have access to all of
>> guest memory, but where Spectre-style transient execution attacks
>> through the host kernel's direct map should still be mitigated.  In this
>> setup, KVM retains access to guest memory via userspace mappings of
>> guest_memfd, which are reflected back into KVM's memslots via
>> userspace_addr. This is needed for things like MMIO emulation on x86_64
>> to work.
>>
>> Direct map entries are zapped right before guest or userspace mappings
>> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or
>> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where
>> a gmem folio can be allocated without being mapped anywhere is
>> kvm_gmem_populate(), where handling potential failures of direct map
>> removal is not possible (by the time direct map removal is attempted,
>> the folio is already marked as prepared, meaning attempting to re-try
>> kvm_gmem_populate() would just result in -EEXIST without fixing up the
>> direct map state). These folios are then removed form the direct map
>> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.
>>
>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> 
> I you changed this patch significantly, you should likely add a
> 
> Co-developed-by: Nikita Kalyazin <kalyazin@amazon.com>
> 
> above your sob.
> 
> (applies to other patches as well, please double check)

Added.

> 
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   Documentation/virt/kvm/api.rst | 21 ++++++-----
>>   include/linux/kvm_host.h       |  3 ++
>>   include/uapi/linux/kvm.h       |  1 +
>>   virt/kvm/guest_memfd.c         | 67 ++++++++++++++++++++++++++++++++--
>>   4 files changed, 79 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 032516783e96..8feec77b03fe 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6439,15 +6439,18 @@ a single guest_memfd file, but the bound ranges must not overlap).
>>   The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can be
>>   specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
>>
>> -  ============================ ================================================
>> -  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file
>> -                               descriptor.
>> -  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during
>> -                               KVM_CREATE_GUEST_MEMFD (memory files created
>> -                               without INIT_SHARED will be marked private).
>> -                               Shared memory can be faulted into host userspace
>> -                               page tables. Private memory cannot.
>> -  ============================ ================================================
>> +  ============================== ================================================
>> +  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd file
>> +                                 descriptor.
>> +  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during
>> +                                 KVM_CREATE_GUEST_MEMFD (memory files created
>> +                                 without INIT_SHARED will be marked private).
>> +                                 Shared memory can be faulted into host userspace
>> +                                 page tables. Private memory cannot.
>> +  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will unmap the memory
>> +                                 backing it from the kernel's address space
>> +                                 before passing it off to userspace or the guest.
>> +  ============================== ================================================
>>
>>   When the KVM MMU performs a PFN lookup to service a guest fault and the backing
>>   guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index ce8c5fdf2752..c95747e2278c 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -738,6 +738,9 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
>>        if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
>>                flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>>
>> +     if (!kvm || kvm_arch_gmem_supports_no_direct_map(kvm))
>> +             flags |= GUEST_MEMFD_FLAG_NO_DIRECT_MAP;
>> +
>>        return flags;
>>   }
>>   #endif
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 80364d4dbebb..d864f67efdb7 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1642,6 +1642,7 @@ struct kvm_memory_attributes {
>>   #define KVM_CREATE_GUEST_MEMFD       _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
>>   #define GUEST_MEMFD_FLAG_MMAP                (1ULL << 0)
>>   #define GUEST_MEMFD_FLAG_INIT_SHARED (1ULL << 1)
>> +#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP       (1ULL << 2)
>>
>>   struct kvm_create_guest_memfd {
>>        __u64 size;
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 651649623448..c9344647579c 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/mempolicy.h>
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/pagemap.h>
>> +#include <linux/set_memory.h>
>>
>>   #include "kvm_mm.h"
>>
>> @@ -76,6 +77,35 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>>        return 0;
>>   }
>>
>> +#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)
>> +
>> +static bool kvm_gmem_folio_no_direct_map(struct folio *folio)
>> +{
>> +     return ((u64)folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;
>> +}
>> +
>> +static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>> +{
>> +     u64 gmem_flags = GMEM_I(folio_inode(folio))->flags;
>> +     int r = 0;
>> +
>> +     if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP))
> 
> The function is only called when
> 
>          kvm_gmem_no_direct_map(folio_inode(folio))
> 
> Does it really make sense to check for GUEST_MEMFD_FLAG_NO_DIRECT_MAP again?
> 
> If, at all, it should be a warning if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is
> not set?
> 
> Further, kvm_gmem_folio_zap_direct_map() uses the folio lock to
> synchronize, right? Might be worth pointing that out somehow (e.g.,
> lockdep check if possible).

Added a WARN_ON.  I couldn't find a way to have a lockdep check here.

> 
>> +             goto out;
