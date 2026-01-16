Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFD36AB48
	for <linux-s390@vger.kernel.org>; Fri, 16 Jan 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584617; cv=pass; b=iO65s1rSiZbCTHk/UYv185cREY5j/mPRGHa3uc94b67PbAaXI1KGCOJjbS9QyXB2cJBnVw1yiTnpU5NbiUkk+qX3SnPMX2Cp+wPsEryeT3TN9PBzkGjEXxZn2G827+U5KXpgqtwbAJqbnlJJvOyWqarbRDcu3FRMkQ6qZ7uDm3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584617; c=relaxed/simple;
	bh=dI/o20x9Y2HfQtj2OfDVbvhM6LWHTEelpWzil3w2nKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcTTFyBNO2A9aEY1bvYZ407xXPZtbKuq+MzxDpxby0vQcl04TOt2TBe3a9Egjby/7an0jxxhHbhAb8QHKrvTkZkI8Yozd2Xf0jvDzTF5jFTjF/xMnMiOoXj/Mm6T0jc+8Tz2I+5gD3op+8hm9xjmRmegCPGe9dpeVFHI+/zV1MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mD1TG0+; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mD1TG0+"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12331482a4dso10022c88.1
        for <linux-s390@vger.kernel.org>; Fri, 16 Jan 2026 09:30:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768584615; cv=none;
        d=google.com; s=arc-20240605;
        b=M/LpGarPKWAnX0wUZ1pgOBxt0WjpAgAYBzG2xsJtOn+riUt5k0oSYaXsJB7d2Ufjiw
         mUAX9i8PGLStes+bXWc3vtQPMbUmD1xB9U9H3EWUrxsYjBV9cmWj9AF23/fJwXJFiftq
         QDkuBfwNv+xERpNqT7M4T+BsqP1a2pLr5Ieyu4FZZ5i0Z9xd+zHcb2KGeB0+u2yhjYPW
         YqxXi8Qc4qnKRkoDsDaS9e30xoMxnZb3TIrGkum7TOYm78HwNLdKiSnenu7gvwhIoreF
         R5Pe0z79klGoclqZhY2zFRfBUPANyG6nbkCIgmRG2pnNgNypzB8J+xs1wtf4ur6WgGyK
         oMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        fh=2YcWNlTK0MFNOb/V01YO3hzCyHq5HGyxolmYB+K6VS4=;
        b=dY53+cUruIS5K70fIQ6mQOi0XM/3H0taJ8we2lP2TkcQQI0TDVp2i1iSDV14+XFQva
         A8WWvcwR6RB9A0UT7iH3g3Z8D4Q2RavO0L9LjmMj7n/PMnU1Uz8BLFnWHWaTPYh6g2dF
         K0jpNsRBSXk2sFmZyJ65UsYgzBtA3JzzP56nUuQ0GnuFHOQty2p/5k4GfrGr/f5q0xxA
         SCdaht5goVTP+ctkID6058Bd+1qkvScEqAJ5dBC7xAJfLastX1uBcpuBB0zK9AtDqt/L
         6omN3L8v0Ndl4OtpD8AvR7l992ejHjxpVn2arKQEsv1oWc6IOcXy9CIgDAiiVcKrFtTh
         2VwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768584615; x=1769189415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        b=3mD1TG0+dMwPXYG0SmVG0MaKWdwu8Gn/jYBskohb8JXBE6eX7Eu7Gsmtwiziv/aXa3
         KmF1VLqJI1Aa6h/nUMHRrVO6HaSEkG2YcHnX1VHEU6Jl6m4DIUBE5wGna34h0JJq/i8H
         690BhTEvNMAAt2FHhhDemQexF5KOoJ/KZTCSJ+fNRHfUTrQnIr3Ax3x+akY3CYl67nq8
         HLFQUDu2Iiv2q7Ziio0O0IfWPXZmAjtuyTRV2qPwI6r96O7OK1XMt7VpXgpn78Cp49nk
         j3rHfFsTumguC1FAGxZQgXCMHMyYXBWw+kJ7gpjk62sDz/Tybd40IZkraYCB8+BiabVY
         UWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768584615; x=1769189415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53uWNErBo7wI6ZcBPOrPDVWa4idMxyXiq3MzbljTtl8=;
        b=swVQBhUtDRsEq9QL37xhtUrc26CGuZpHckZxX2RTJ7TJVKkQrPAEeLcv+fCUKWGjlg
         qIk9V5IoupmvP+3RAqpNqzkj6JmaRLIY2yeXm5Nf5lr5GMMIW+hkwhJBJUwbAyQT0fyc
         W94zWc/F+XBr91SWOuggSwcO2HFzdMr/0w2ozaNoVk1XiZDK13ZKtUoKVhmZNr68CUBN
         6sayl5rAGOETGO0xtJLGPKcMQIrFlAVunUsJhoEO1zOye26ShTDMi8mzf74AJjUdHCzX
         Vz68KRoMyYkinifqwOud0D90IiCwUrWY/sD3fGPC30VSBXHl/lZuZyti0zaB39mK5mXS
         nipw==
X-Forwarded-Encrypted: i=1; AJvYcCVGH41+qOjp+dbHNh+Bgh2BPP289pH7wDJH7dxT8BK3XK5QTINEMFdlTcWYrgFF3afqfTYSrj65yJkH@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqJhV7GAjs1/b5gLeKnFfPvPeBXs5TKZ+iu65rg9xYaJXQwdY
	GF21mH5JwcW73kUJTnA7UYpInO8wrgPp29itkpDZZXUYbKEERJxGM3Sn7GMCCuidu+NwJIV0H4A
	v2qkJlERkVvToWZhvnguobZTnul+/KTaIf0Yc09Ie
X-Gm-Gg: AY/fxX4+qSeui69T5pv8+9MuBR4q3/X8v3q06hIT9zN549qIjoyBOsJSQYoP3ryCv8p
	nHc0dv6Hy+xN1flw4D55GVUZGVjGTs8azuyiAvQT8GNKEB1jaCurRm6mu3RSRnvsHhdgLUBJUrR
	SwUxoOM/UcgP6/ujx2ERBMVPCSxw2ZldnP3/op+ADvVZ8S9GTvuR0gNFHCa4nCZH8BjLQ9P8eZr
	cOSd3/xgHUcRnFMTN2TS+Xw1814iwGK4lwLh7fwGSd/3SRnVYgDTnPbCdGlxHyyPxfg1d7rHyEU
	0Os+zM3Icu20A/HpMoI/veWWrfQrr6P22Uw17Vw=
X-Received: by 2002:a05:701b:2212:b0:120:5719:1852 with SMTP id
 a92af1059eb24-1244b44d299mr107912c88.16.1768584614413; Fri, 16 Jan 2026
 09:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-8-kalyazin@amazon.com>
 <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
In-Reply-To: <ed01838830679880d3eadaf6f11c539b9c72c22d.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 16 Jan 2026 09:30:02 -0800
X-Gm-Features: AZwV_Qg33M1rO31dgikgfsTaot12EQbVpaEnX3TxsJMPXzhkvu_Y-NHzJrI17yU
Message-ID: <CAGtprH_qGGRvk3uT74-wWXDiQyY1N1ua+_P2i-0UMmGWovaZuw@mail.gmail.com>
Subject: Re: [PATCH v9 07/13] KVM: guest_memfd: Add flag to remove from direct map
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"kalyazin@amazon.co.uk" <kalyazin@amazon.co.uk>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "david@kernel.org" <david@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"surenb@google.com" <surenb@google.com>, "riel@surriel.com" <riel@surriel.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "thuth@redhat.com" <thuth@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "ast@kernel.org" <ast@kernel.org>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "pjw@kernel.org" <pjw@kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "willy@infradead.org" <willy@infradead.org>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "wyihan@google.com" <wyihan@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, "jmattson@google.com" <jmattson@google.com>, 
	"luto@kernel.org" <luto@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "coxu@redhat.com" <coxu@redhat.com>, 
	"mhocko@suse.com" <mhocko@suse.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hpa@zytor.com" <hpa@zytor.com>, "song@kernel.org" <song@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"Yu, Yu-cheng" <yu-cheng.yu@intel.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"shuah@kernel.org" <shuah@kernel.org>, "prsampat@amd.com" <prsampat@amd.com>, 
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "itazur@amazon.co.uk" <itazur@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"jackabt@amazon.co.uk" <jackabt@amazon.co.uk>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "derekmn@amazon.com" <derekmn@amazon.com>, 
	"xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "jackmanb@google.com" <jackmanb@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"corbet@lwn.net" <corbet@lwn.net>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"jannh@google.com" <jannh@google.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"kas@kernel.org" <kas@kernel.org>, "will@kernel.org" <will@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:04=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2026-01-14 at 13:46 +0000, Kalyazin, Nikita wrote:
> > Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
> > ioctl. When set, guest_memfd folios will be removed from the direct map
> > after preparation, with direct map entries only restored when the folio=
s
> > are freed.
> >
> > To ensure these folios do not end up in places where the kernel cannot
> > deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
> > address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
> >
> > Note that this flag causes removal of direct map entries for all
> > guest_memfd folios independent of whether they are "shared" or "private=
"
> > (although current guest_memfd only supports either all folios in the
> > "shared" state, or all folios in the "private" state if
> > GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
> > entries of also the shared parts of guest_memfd are a special type of
> > non-CoCo VM where, host userspace is trusted to have access to all of
> > guest memory, but where Spectre-style transient execution attacks
> > through the host kernel's direct map should still be mitigated.  In thi=
s
> > setup, KVM retains access to guest memory via userspace mappings of
> > guest_memfd, which are reflected back into KVM's memslots via
> > userspace_addr. This is needed for things like MMIO emulation on x86_64
> > to work.
>
> TDX does some clearing at the direct map mapping for pages that comes fro=
m gmem,
> using a special instruction. It also does some clflushing at the direct m=
ap
> address for these pages. So I think we need to make sure TDs don't pull f=
rom
> gmem fds with this flag.

Disabling this feature for TDX VMs for now seems ok. I assume TDX code
can establish temporary mappings to the physical memory and therefore
doesn't necessarily have to rely on direct map.

Is it safe to say that we can remove direct map for guest memory for
TDX VMs (and ideally other CC VMs as well) in future as needed?

>
> Not that there would be any expected use of the flag for TDs, but it coul=
d cause
> a crash.
