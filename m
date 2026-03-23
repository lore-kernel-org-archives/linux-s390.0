Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4D3DC4C2
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297368; cv=pass; b=qM5YmBUZtG08QgdWxMDrZ5wb4vHnysUQxpyv9sgnxxQeKckc1HOzBjajfNHKOl/J1pouItFlDBwT7CgiH/6V+7tz4xsO/QN4PnF+iuvjfSVjNPOUOWdzYosmqZf5exz/sL4zuDBEhzlUUX44BdoPor3yiTUDcUsXQD6OdWiotNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297368; c=relaxed/simple;
	bh=+Ww3YVEwz3akOCPkGfwPOz5g/SjxY63PNjUlqwWXbGQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOCnpz3qWXhd/uqmWk3nCmkvZOEWQFWpRLEUMnW6IKEgmbPHSCYl+1SNSv3SaX23jePu/kV2OipJ3U431PyzfYGX/UOJzpa51cls/3OSXjQXmTSjWoEUwNIYKnODX9+dkWVfEmd/E8AMLHKNwdu669GyXmWDxSRKr+WtLCjZIgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ibwuzlau; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ibwuzlau"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffd797184fso2813823137.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 13:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297365; cv=none;
        d=google.com; s=arc-20240605;
        b=OzC1LPaCQysXMdcECRP1QFK/dUZvYLxQYA6Er2y8VdvLcThJ9BPQkHw4G6hJorCII2
         kztRVhqJnZA8TZx6hKZpFtOSHor31OvXwkyeuLA2Rzn4EysAeswLhkDIpcApi6FmGlS2
         u0HrFx5nSqnZlk3hbd/HUskZ730LJ1i9rXb1BzNmljvt/csGtLqeblVREhuz8plhsdcE
         r2QNcydwE4wrbf9eicRajNcYu9NstXSDZ3TpFXDTYO346UvIFe3hk+OVSTlGSwEXIcEN
         uv+Bu/8YsS38aHReymq4+jz23oraviQUh/fcPbA4Vy71cJFeWasb8cjPebd6ApMVlueK
         JaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        fh=NDaM7d8tprGpFKHDTF/VHuHQQsTiQBTRKdzdSa126e0=;
        b=j0yAu1BCPjEb4mUY7WB4oIHlwFLBza9QfvHwgZCxf7j1cFzCsUoisdnWKj1105DBVw
         u9RjlL5tPRHGizcxM0ZRnJ8lbWUDiHIgXu96PHY74F+BWiWu3cWHqhKy0qe3r7I8BHW8
         fncwjE0fu8iMBgBrsRROtQd9IubHD64rV9z4qDT0R+3AZC7DIW07U1y3sGlJH7aY5Lab
         aiNv6ztaDmwTGKChzy5LiyhKgyR5AbI9ie65MWo/7cr8rfENLk9pHHxzK4zxGSfLZlG0
         K//9sVv3Pu84YVJ3rjzDz/485bs15RyIAyfPuDv2DYZ0YCluSQ0tqErtuKILcTJV99Y0
         YWaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297365; x=1774902165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        b=Ibwuzlauj5c8iKXxG1nK0hN4JyHV1Mv3KfKVQuiM0E+dlMSGVRwp8PfoYFyP1KyuxP
         TV8eM6VPHDio+E5Cn8SvvUl81aCB1scyZpRBpQDqfaLDZ/2fcpxRSgfNro+mQ6DrusbP
         Z/a96ziy/AhJVi5KNvSFNb0PJC3qVLwpHNJIPJ+i2XhBM9b547uqZ6kBX5VfuKRPpGll
         zvvg4ItxeGu1cu1UCqpMsS5/wsgfWhO4cfLEXuCTkRTZm/O8BRjqXxrk7D84ejUoBBku
         ZfHITQWeg4EzxLmcIyXpuaZa2R++4mxy+6mdQVDjSpf0LTRgOhE1fJU0yDfXDeikC89Y
         vkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297365; x=1774902165;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        b=ZlUy/ozKbSvW0XcDtATLdiCLgx044HeR2AEiH/xTXC76DCco30xQetGcKBTkFBKNZD
         yYWAjVect4dtmvgSqpxgmhJy6pQS6UcQAVMYn8uArJdh/ZS21HQh0cA/ZRWhiH6hdgAd
         7JTriizVLk4joFTOopMFS+kSzCRDsbOVdGJuP2465Gr9FExYajX6eQ2gmA2yvgNgBL5U
         ykchJQJUw074EZS3xHjWh5BOO1ti5aRhA4bCSKPst39Hzq6AOugjPk2Y8ieSSwfaVuDD
         k0floA/EChZJZvAtexZ4p7nEg1oes2fhCeirowUl+gv0hSNvkc1QlG63Nh16sBzP93Er
         rBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXclSmTugTpQDvkLZclfR5yl5F+ziqExH9lg1AhG5OHlMZ8Lbw8LVd47+nr/4svIWp1WlBlwLJQSon0@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGyumtB8S9HuS6MLPqLUxG1szQYNZV5ivhpHpIJIaT0ZPGPcl
	nuc4n6OkgEJBNX7cctlABSVUOZ8N6rA+k7OOme4nPOsoK6IhsfU09FMD9N4phagva/8QLnrfkab
	/ELguDIkKwQT+dBDXQ9Hsx6eIirvnSVH5b7u4woi/
X-Gm-Gg: ATEYQzwVEkVvRlAbI/tuFPI8St304IRZO4GB8wAFvQRDAdsuv544s5nR72mB9SmHxL8
	jcA9AkMs2PtPugeZOF2sGCltjoKeKOy7/VBiUZSeZyoWlOgdSDD+Dh1+82L6ofSpPG0lYy9XfdW
	e6j9+3wOFBRFL//nWfvqapU2lsy3IAfcHLHDpFygWs1iOlAHnC5HjuKV1Q0osl3hZ2v6WMdNW1V
	TFQ51VO/WTgWepFlVLTnKHIr941Tx9QMmKLF5dFsrfqlAxHI6kYWtwRuPr/AXIVmZzQ//P3n+aN
	AFsOnhivJ+mSyInoK9y2nT8h6mg6h6j3PtmZG5SQYNewlFX+FJci0nNwnMp69nV/hOVkvg==
X-Received: by 2002:a05:6102:3a06:b0:602:8742:1fa with SMTP id
 ada2fe7eead31-60316013f44mr514571137.9.1774297364023; Mon, 23 Mar 2026
 13:22:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 13:22:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 13:22:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0a14c10d-0dab-4b9c-85ec-e0ee25cd0db8@kernel.org>
References: <20260317141031.514-1-kalyazin@amazon.com> <20260317141031.514-6-kalyazin@amazon.com>
 <0a14c10d-0dab-4b9c-85ec-e0ee25cd0db8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 13:22:43 -0700
X-Gm-Features: AQROBzAJTtmZ8_CHcmYDgt7IaYmvr2Pi4WE03drdmWTq3AGR3rA_vEwuIGtsbTw
Message-ID: <CAEvNRgHqJGwmAfS8TuGBbUoQehpqY9GdtjUS=+Hc1ViK79RL4w@mail.gmail.com>
Subject: Re: [PATCH v11 05/16] mm/gup: drop local variable in gup_fast_folio_allowed
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com" <tabba@google.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org" <pavel@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "vannapurve@google.com" <vannapurve@google.com>, 
	"jackmanb@google.com" <jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 3/17/26 15:11, Kalyazin, Nikita wrote:
>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> Move the check for pinning closer to where the result is used.
>> No functional changes.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>  mm/gup.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5856d35be385..869d79c8daa4 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2737,18 +2737,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>   */
>>  static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>  {
>> -	bool reject_file_backed = false;
>>  	struct address_space *mapping;
>>  	unsigned long mapping_flags;
>>
>> -	/*
>> -	 * If we aren't pinning then no problematic write can occur. A long term
>> -	 * pin is the most egregious case so this is the one we disallow.
>> -	 */
>> -	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>> -	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>> -		reject_file_backed = true;
>> -
>>  	/* We hold a folio reference, so we can safely access folio fields. */
>>  	if (WARN_ON_ONCE(folio_test_slab(folio)))
>>  		return false;
>> @@ -2793,8 +2784,18 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>  	 */
>>  	if (secretmem_mapping(mapping))
>>  		return false;
>> -	/* The only remaining allowed file system is shmem. */
>> -	return !reject_file_backed || shmem_mapping(mapping);
>> +
>> +	/*
>> +	 * If we aren't pinning then no problematic write can occur. A writable
>> +	 * long term pin is the most egregious case, so this is the one we
>> +	 * allow only for ...
>> +	 */
>> +	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
>> +	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>> +		return true;
>> +
>> +	/* ... hugetlb (which we allowed above already) and shared memory. */
>> +	return shmem_mapping(mapping);
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> I'm wondering if it would be a good idea to check for a hugetlb mapping
> here instead of having the folio_test_hugetlb() check above.
>

I think it's nice that hugetlb folios are determined immediately to be
eligible for GUP-fast regardless of whether the folio is file-backed or
not.

> Something to ponder about :)
>
> --
> Cheers,
>
> David
