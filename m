Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2B3DD1FC
	for <linux-s390@vger.kernel.org>; Thu, 22 Jan 2026 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100293; cv=pass; b=HFF/5pbA1YLbffhVmSOBBsnkEuFHuftwcPT8i6FgOY7l9ERJT5coCkUtYShJjtyMCxzD9bkjEwCIoniF3oT+rAZwBNnLoqef3NWb/MtH4xvhMhcJDOvBNYjeiVpUw3Ju1Acd7ESJ2pkC/UafgI5eaPSWYsiglTCt3q/AmVq/1XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100293; c=relaxed/simple;
	bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oe/8vLTH+zpnG4/AXE5HG/iXPC0ZbWIn+16DVjvDxdVm3y8/ZxfexAR13OG7SG4bqd5aJ9+AMleRkiYI4Svnkn3pchWCXzJmwZud5wxo/LEUVL+SCMVw1dmhXWHXH76QKXWQxI9zqpkmi+veM3fiL8d/2toquVumlAtt0VUkDuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dfc6529b; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dfc6529b"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5eb8f9be588so887096137.3
        for <linux-s390@vger.kernel.org>; Thu, 22 Jan 2026 08:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769100280; cv=none;
        d=google.com; s=arc-20240605;
        b=MxE5W73fPW7k0Vr0/okkvUdYC3BCQskkMdrpg/ng8I4XhZWUfh/CqwTavUrcUodvMJ
         NJ2Qrf6KLeGRG0Ixhz/o26z4BzZSlQjAPtybfX5XM6Z80QeSwA+dYfO9xi7d6Uj9fTy0
         ECNc44j2zcF/tgmCimcihyU9Q82uyOvWjo3NrSAc3HqFJ3O9x9a0CWvs7k+rP1EzISWl
         Qce6y1DHwnzFW9KDi6qAKlSUgLUzeD/A0W8E83EZ2P/aR7FMNyJYSaMh0v9KUM93NwVf
         TssoUEJyve9Km2uNdFczH6+fPMlLxNoprDZBTWq5GibMu/RuxfsFTRzk+sLyWdiLUpo/
         5U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        fh=5kEwd3vCc5DtSXGTWReBCUIpp8IyTwwUJ8ry9eqpNF8=;
        b=WgKck2HVVHZ8bcnriZOxM/A/h0ssDzfPT/3Fw0aGhqoj8LBD72GFVsRdpN8aNoOFT7
         2DEAmy9/9Puzi46jhr0CO5CNIZ8c0BGvjEpQSF9ieRy2+a4SdPYW2hHIBwzSUw+UdWKJ
         swJ0TgP4rydNiK48YI2WDTWbGYUhQXYcsF/T0TLhAV3WbR1/tRFJwAhm5tjI/lIgaq23
         UU2LZ0e5HrFN5dxy9A+csqGD2B6XwK9q/5CCXxJWrzp4DFK0SWz4p8wprehkQu8OY+ZN
         8Re6oogC4pQX83BDcpriI2orprS+a76a6JT3hrC+LFyCXki5w+/TQuK74GEKwpn81Yen
         EHtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100280; x=1769705080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        b=Dfc6529bhrwVaUn3YFXZCSUY5JhwdcykntEWmJBOZ5d1M1fQelFtle5XRVrvvcf3f8
         0IdAa02rZxfIuB2X5MTdy4mrRK9HIYUbxP3SVo83JD00f03CrF2HsaRXrLc0lzcAxMmh
         lKJ9tI/YJPfUZf+Lb62z41OJ5CzOXE/zHlooZNpwRkJReZPTPYydzS39pI2u+3RpEEM6
         dlz4xHl1+zCZs8zcO+Wr6j2pPs3Nr6pHtVrUfkvGgGO4jl4qF0Llg3tbd1WXVSVU1ZDX
         9FbtTHTHMcAocczb+axesPiHB/rnQaU5gbmb9JZfdhU3EZ4LWRwMkNmRJIQRlqJyoiyv
         P60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100280; x=1769705080;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i278ipBKd9t4eNryNmv1UqNg417NlVEpdzsVGz5SQq0=;
        b=kutCtGDQelVVIGPUq0nbZkruM+J8dp7tBs6f4kOH4AIp9TFqN0c37scry02kKTBkWe
         caKbtK78+F5EHGaldeNVbzaV3lXLIvzicaKO/0jhGPoZ6eK4aEIbTVpFadaUQ9pFfEkH
         aacVWQ1v03hNK3aZbc9loNAaR69sU2gvd1aYpmKY4omQoHGJExtjOozrzymp3aw3o3U2
         WuryRuzer340m+y6BZ1liyDzHKvVyFAIqk4Jh3ypSlyu93N5yLR/R3yctJQolkVnMnOS
         nJFxXp1eiFi/Qvv47K0PPrcigwa8kaQPxHkr6HwvkFhUqvZNYnW8q0+1vYm01hp0jD8X
         ZT4A==
X-Forwarded-Encrypted: i=1; AJvYcCXU9z0lwsoCeNc/rmx2toA+InJVEjg59Xy557cP+t+DZJ1dQ6O4QBOKfY4cy3fyBuXZBIydeBEFtbsU@vger.kernel.org
X-Gm-Message-State: AOJu0Yztw1zkO+4idM7SSqWgD7j85wIBy4ohwBs5z2bVDoF+dpBR7RXo
	mAs0tpwop88iFnQ+ti7qQqgIVyWzW4pcwg4QKZ9higGBjj4EEyEAoH/SeCIjvXTGwFxD21b+yEY
	e0daORBKBSsQw3QTqOjEyRiFOPD3dTpEgaM3sxyL8
X-Gm-Gg: AZuq6aIW/fivXufQxpyfPpvtRyBn5CBARrNp0XuHzYF3E0PD3EYEWTWpCg1hpcaRMOP
	U/9pSY0ltnjkqNosgBcuguItdFv5WNkCFl52IL4OF/HGmAjsp0VmzCJ4s1HWrOcpO+6gPRYgMeN
	bZ3nRmVOXnCe09chv5AwUTbQNohe7zYgGqWrR+/qRiqoO1PCMmx1km9TQKELqjtrtKbpzy5rtA2
	UnyCmJT5TJ4NDIsNWOFZgl9JUCzA6eTP4m9kh3Ar/x+2YpfTCsyzKAzz2/MdcQEg7Y9jQ==
X-Received: by 2002:a05:6102:d89:b0:5ec:c528:4df8 with SMTP id
 ada2fe7eead31-5f54bc628cbmr124387137.28.1769100279450; Thu, 22 Jan 2026
 08:44:39 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 08:44:38 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 08:44:38 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com> <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 08:44:38 -0800
X-Gm-Features: AZwV_QjFiVCL1GgMB61exuGngD3MnDbAOiFUMFZ1rYdJZrzTGdTea8E5DMfoinE
Message-ID: <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "ast@kernel.org" <ast@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"pjw@kernel.org" <pjw@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"luto@kernel.org" <luto@kernel.org>, "haoluo@google.com" <haoluo@google.com>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"oupton@kernel.org" <oupton@kernel.org>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, "hpa@zytor.com" <hpa@zytor.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jthoughton@google.com" <jthoughton@google.com>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"derekmn@amazon.com" <derekmn@amazon.com>, "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jannh@google.com" <jannh@google.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Fri, 2026-01-16 at 09:30 -0800, Vishal Annapurve wrote:
>> > TDX does some clearing at the direct map mapping for pages that
>> > comes from gmem, using a special instruction. It also does some
>> > clflushing at the direct map address for these pages. So I think we
>> > need to make sure TDs don't pull from gmem fds with this flag.
>>
>> Disabling this feature for TDX VMs for now seems ok. I assume TDX
>> code can establish temporary mappings to the physical memory and
>> therefore doesn't necessarily have to rely on direct map.
>
> Can, as in, can be changed to? It doesn't now, because the direct map
> is reliable today.
>
>>
>> Is it safe to say that we can remove direct map for guest memory for
>> TDX VMs (and ideally other CC VMs as well) in future as needed?
>
> Linux code doesn't need to read the cipher text of course, but it does
> need to help with memory cleaning on the errata systems. Doing a new
> mapping for each page getting reclaimed would add cost to the shutdown
> path.
>

Can we disable direct map removal for errata systems using TDX only,
instead of all TDX?

If it's complicated to figure that out, we can disable direct map
removal for TDX for now and figure that out later.

> Then there is the clfush. It is not actually required for the most
> part. There is a TDX flag to check to see if you need to do it, so we
> could probably remove the direct map accesses for some systems and
> avoid temporary mappings.
>
> So long term, I don't see a problem. For the old systems it would have
> extra cost of temporary mappings at shutdown, but I would have imagined
> direct map removal would have been costly too.

Is there a way to check if the code is running on the errata system and
set up the temporary mappings only for those?
