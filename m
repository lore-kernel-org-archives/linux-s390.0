Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95451E8320
	for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560149; cv=pass; b=WdqisfKvCcKD1dsRFnbWN+2d8TQZKbBaOyoVivu1gWVXciZYXJzLgLsjl1SSUypECh8psPTR07Y3IkiVo2TOMlOXlKBPDB5GDXyTVLkwFz8MPnOwz2QDfjm1ZIBIiTKrCiGHGpHUP5oLbCAvNUUP1CRjkTq02eOjtGJU303p0Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560149; c=relaxed/simple;
	bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyFzONxJ9ZwM3VUwWoUJUIpHwzCJ1ix74v6d5mQr1wDBI6NQKftIb59tAy66L7J3KPFVaU79BmIHI+MFGJ8lhHDAlqdj3HSZU+/BKrYCikz3SnTHglvS48c8L/IWYl4JPq7LUAR1SM45zD37O9LTl0Oyuh3sq1vBRKae2Mr6TYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RoTkF48w; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoTkF48w"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5f53021703aso2151854137.3
        for <linux-s390@vger.kernel.org>; Tue, 27 Jan 2026 16:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769560147; cv=none;
        d=google.com; s=arc-20240605;
        b=gDDYFUgN0Ir5821zkQZppuwYlbBFvjwkTZz/V7WACNKv6LJi/3KRgYeP4RggFvNeyO
         Wyyz1a45/OUx403XvxsaF6f6MY2DuTiFywsw/L90F/6/ucBltN0PNzWvh2hqdScE/FRt
         hG+KNZffrptjmgj/VheRFRrpl5m9l3GqKR2LzxDS+raZoISIneC8kFgrO8D5dkEf1ex5
         ei5NtMp9kudkNFAN6t6mTR3JzpZ4meNhmhiKjsj2NdEnZLLkwlEORD/5zjHAHJQWg/ea
         f/70TZ/9V8Ce0DJQdb7NLK7pNT6sfFLnkIUZk3a/ld9w/gBuCJBGkGRbRnajtYZgVIIA
         Ka4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        fh=aQanthJAqXS7xaxzXuejtR0OD8E22oJtIKbboNeu8RQ=;
        b=CDBzcJXIHm9Jt1lIpq/EpwithbdyssXoej6qXfQtKZFmMF331uorpol+fj1Kz7+DXV
         /nWPBfUzZuXe8RhmV3qyMyK1qTmB7LybZQTvNikK6EpHQlnboUOfu0uoP3zMWOtk5C4Q
         mnR7oxg3yMGEdZW4mgp2ZnSuKvyQluA+o3fEQ2fAEMhIcQqaa8HVumT07UiTHlzBdeO3
         BpNE+pzdZtRwdKkqPPEWio2OH4JE01EjeY/1oNV5P/RcQLGg4Yzu7oRQzlnlEo0LDkj0
         5GjGgErk1so1HnXqsqsSI9ypT9H8NnCHIZaVt7YuA1crfYs0/dv9G4PhFMDP/PmqLOtb
         s0QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769560146; x=1770164946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=RoTkF48w++rpKI98DbFbYQgosbq5Z9QYSnnq2r0pJkWKQL7IXk+tBiTjV3OruM/GGg
         ODyn1mmKK+G87tX796IdJALpF+WQsSR4L1Vxu5SJc+ZvRFEwpfNQRL3hcRj5/OEI2soa
         6tWPkr57+6vqerzADKUP6NUF13qgXMGoptBRWRkx1Ax6eUQ6DQwyvVYbU3mlNTlofdzs
         HUJH460iLD2dejAHI07YqaoXQXLkT5ymt+DtUkE7p5CWNgbbwZpBXSjB8RmKNABMm+sb
         ALXGe3FrNfDccfBmdSvM+tZA37dZs+apXke4UFlxZ/l3FUpPzcVJTVRjdqdDnck/TP4s
         kwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560146; x=1770164946;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afdfdT2YOMsD0iZJQSrtAQ+axiAIWjxn1C3TT/YCmDM=;
        b=xG/pdwAivmg0D/1GC9kGt2BarTjBHsC2f2L9ZtkSXmR6yaBtY4v8ZCUusDP5SJaR82
         YawsjZ8EwiS8rIKuWosZ1LPJDIBOMsBXgSkeVeoNMjSNWT2kBEREYJeCS1iVLVFxMHvu
         c3mIw+rwcAukVsrSzdFSmV5MGstHXRkzpXIxDFSYFdogdoyd2v1NraapVwWa5k1zGgfg
         3MTVGT5ZV/yujIqwAvOTIvBFX/emvJLQx/Tc+Q1yqatGdvkO6ReAKOvxo+WjlgPa49MV
         FcUt9Hcz9l55PE9XoSizEhC+VaPs7DWLQhj2eMvW7XVKjnkuh2P60k8iGXhDWigrdhRe
         QNyA==
X-Forwarded-Encrypted: i=1; AJvYcCUdBkxpZbPeWRg5LgDzO00nvmFE3NHIoPGRdHW7R4oXdP0aTc7ReV7Q2tI3eoOBeNT24yVv826eEL74@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6BJOoMftK+oe5Ypr11eLdxiCMTHfszDlzqRhx4nawhgoFlwR
	SURc4nbuUbXucBzjIdaZDNq5tyRHGaVzf3fSuu8zwIKdYnWMuXUh3sdL9sCjYIiBwr9NyC8kyc/
	F816HE1s1YUfBhUE9Zi9rSIOfchBfepCW/gVM+tbZ
X-Gm-Gg: AZuq6aJP23DqcgKIEWsFVC0N6xDdegzNSjqlEPwaSYmgaPK4vGn10dyW3WEWq8iwHQg
	HZW0z4N+c0zS2I8J1hxc74sPuoNw/0gVpLPi7DzM2lhmKcchTQs/vpi5t01HdbPHR3HGWzwswbq
	OQRWSA6SO13XbES94q/c1a03GwITgklGLVBLB5a3YYD47qLPEWlIA1A+1J4hgg03THX2eInbLyo
	7YvhhlNabnvOwo69+8hIrCmuG/F0KDJX79ScD6tpy1cEBzJjZIDC8xV+hzjn60gsUF9biXGsE1J
	78HcMWwuoI+VOpr7+0ASBnBy4CssOCgiQUyr
X-Received: by 2002:a05:6102:94f:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5f72380ed5bmr1335024137.38.1769560145803; Tue, 27 Jan 2026
 16:29:05 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:05 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 16:29:04 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
 <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
 <8c1fb4092547e2453ddcdcfab97f06e273ad17d8.camel@intel.com>
 <CAEvNRgEbG-RhCTsX1D8a3MgEKN2dfMuKj0tY0MZZioEzjw=4Xw@mail.gmail.com>
 <ee9c649eed3893d852c3d20fb96bdc4904b7c295.camel@intel.com>
 <CAEvNRgEz0+ic9uvcsWYqWgR5EV=TfY0SAGC39zAL+n19SoBXmw@mail.gmail.com> <f4f2a0297e38ac45e4438342ac2c882b91544acb.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 16:29:04 -0800
X-Gm-Features: AZwV_Qi5-DP-v6wjOnL-aDMsdDCx4XY7-YGdXQ0tP6_jJk0lLjibrIAwkazF3pk
Message-ID: <CAEvNRgHMOWfCRnkx7YJoAzNpBBOHCgvR5GHe66uHJX45WDT-YA@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>
Cc: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"jgross@suse.com" <jgross@suse.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "pfalcato@suse.de" <pfalcato@suse.de>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "maz@kernel.org" <maz@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "ast@kernel.org" <ast@kernel.org>, 
	"peterx@redhat.com" <peterx@redhat.com>, "alex@ghiti.fr" <alex@ghiti.fr>, "pjw@kernel.org" <pjw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "willy@infradead.org" <willy@infradead.org>, 
	"wyihan@google.com" <wyihan@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "luto@kernel.org" <luto@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"oupton@kernel.org" <oupton@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"kernel@xen0n.name" <kernel@xen0n.name>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"gor@linux.ibm.com" <gor@linux.ibm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, 
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
Content-Transfer-Encoding: quoted-printable

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-01-22 at 14:47 -0800, Ackerley Tng wrote:
>>
>> There's no use case I can think of for unmapping TDX private memory
>> from the host direct map, but Sean's suggestion
>> https://lore.kernel.org/all/aWpcDrGVLrZOqdcg@google.com/=C2=A0won't even
>> let shared guest_memfd memory be unmapped from the direct map for TDX
>> VMs.
>
> Ah!
>
>>
>> Actually, does TDX's clflush that assumes presence in the direct map
>> apply only for private pages, or all pages?
>>
>> If TDX's clflush only happens for private pages, then we could
>> restore private pages to the direct map, and then we'd be safe even
>> for TDX?
>
> Yes, just private pages need the special treatment. But it will be much
> simpler to start with just blocking the option for TDX. A shared pages
> only mode could come later.
>
> In general I think we should try to break things up like this when we
> can. Kernel code is not set in stone, only ABI. I think it will lead to
> overall faster upstreaming, because the series' can be simpler.

I agree on splitting the feature up :), agree that simpler series are
better.

Perhaps just for my understanding,

+ shared pages =3D> not in direct map =3D> no TDX clflush
+ private pages =3D> always in direct map =3D> TDX performs clflush

(I could put pages back into the direct map while doing shared to
private conversions).

Is everything good then? Or does TDX code not apply the special
treatment, as in clflush only for private pages, as of now?
