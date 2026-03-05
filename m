Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6137C90C
	for <linux-s390@vger.kernel.org>; Thu,  5 Mar 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726175; cv=pass; b=X1tJM5LAGA34Hftan/ECJ4rksEtKuYjN8Mg1wqGUwloGiD95LA1GqH6mZwnSgVwggJtIMY5CH9tkWgVpcLQjcxhsHAcZf40NqFq8mgEPP04eL1emAS1N5E24ltqMgwuaILAKaxLwTp7sk02TRXPAMlXP2hB/ETz/apbTHYlKpVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726175; c=relaxed/simple;
	bh=8/He003bwLnsz3pqmNbbjqwfmJwHV9I05RtqhCGve7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7wNwXm3jueXzBhYM+2SWpuRro/hdHgEqzBoZ4jHxs4JXjuU97BK4MlLUbv06fA9tHLY1s8U1A3JXPtwQR/NiBASAcRXGCNh2AeKJc2zd67bCR1dJC5eIc6YKmtr/UWqICyUoqgknY36ZljwwGYS9RtRnO/e1e4S+A1d7WMJj+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Czm0Phi; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Czm0Phi"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069a785ed2so502951cf.1
        for <linux-s390@vger.kernel.org>; Thu, 05 Mar 2026 07:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772726171; cv=none;
        d=google.com; s=arc-20240605;
        b=Nnpvd9kNX21vwcqMLvf6aaPvQ91WLKy4/ng43ABOXbxpKqGlIzdAJGROKGBxBdeVZ6
         evEtOKRNcoQ/JybUbdMvkJFG3Q+WlSavrAxUXiUuHKGQj78o/fnHLLrDSClZfGcGk5Qo
         9M8xvYCvR45eD3+GKFLaFu8fSVx7q+gKJfrjv4Urd0pNU+IsjlWZMOwfXXxz0JChmaee
         q9PcwcIuAnpZj0511zzW5min5ISg67VnWLF8W/yTF6ysTxW0XVk70O/L5kEa7CPpcn5W
         iTVPQ6XPKKa4ZObKPuFa+Oup0JQsn5OQnVjYzYBSTJ9+0OwDXfraeJo1cWgD+6sGtbtV
         A1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CL67FwLgJYo3bAjpZv3JUFOlo9GyDQqh66JIS6cOafI=;
        fh=dc2gke6wFPe6LYeJ42n7N92ZeeFOMn9D6AFH4Msrb4U=;
        b=e+GCBk9XuU9YmxoKHJFWrfS/6mNMtP1XCS2OM6ZcS/t1HB1AReuKzP3fp31aAXwKFX
         C1IGTMq+1icJo4FpntEB/LZxEg/SqmYOlusu4EW79uilmG/ZdnwHlsPNRfbLvBh/6P1y
         1uDWddYIPPStX2HVPQdugLU0FQhpGAsWJy4KuMjb6XiHaYkEagyCQSpSYlG37TbirXE+
         S+el9Z2g0rZM2QFGCSoPTvB5KytlxH71z7VYY17mC0iyd/Mbb6accoI9Z/ShDNOzX26g
         85IAHUhR5337FFqqyDbMgZZYrDGCo06vv6KGDTklURCpidUukI4ofnxHIhSyWSmnXVQh
         2bBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772726171; x=1773330971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL67FwLgJYo3bAjpZv3JUFOlo9GyDQqh66JIS6cOafI=;
        b=0Czm0Phi/rqNNg51/pA1GTCajBphnBv5oPmkvxVAQIkQ7332K7OE+lhgTXXhK9GUvH
         niVGyUtXr2dg6TgsXIwBgV/npwCuDd+9vU14PIVRqX2DBwjYhKhFl8eSrmG10xpAqP58
         /eObO6v4khVkZN6s9dbL97OJhjK9nk0RDLsGdpeGJdU19PdmVWkIKKotGM0Bb9E5dOB5
         vbldsYeqP4QCvK7/tx8rmVeL0hO5Kij3SyOc8euLTBKx2qsXqk1pBHc94HJ4+Vq9nCeY
         1PAWpywrbpLV+HOLWJ7bCk0opINQmxpePnYSSOY3i/QN0z/mzZssI6x19vcE0u+IhAvG
         KqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726171; x=1773330971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CL67FwLgJYo3bAjpZv3JUFOlo9GyDQqh66JIS6cOafI=;
        b=uCqD70lnA/3RiprLM14LeNDb00xP9PNHjl60YiVbm6621gd3m27lgRR03/HXH3FppC
         te9LPoGq7gH8m9bRuaYeXsK/H2Xrw0dYXZkE8k5WCAmv3E2CU5z5H22Us+9akNZJ7QTj
         c2sHtdVAjS3OCHraPz7v78rw3mpIuTBy1tfDGYN7b4BvmLb9oleq/Xp2GG/9gaBzP4Jz
         E6QgHqJb9oxUie1IpHw+59DrgCsgSojJ81GEiwzEHEKTUROG5kNC9JrwSw7XsaLHTqzy
         LnPrZVt6zuWxK5XFQ4YcwsfOW6B7MAwPu5L7Utk0YVkq5i3NhByav9GJ7ag1USIvuel4
         yhjw==
X-Forwarded-Encrypted: i=1; AJvYcCVPAh2rHv1Kd/8Mfc/hf7MarcMKVbl3w7SsjdLYUePUCiEIeOdeSnuwA3yMMxUqhT2DPNNvSQ0i2E/+@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqxJx16FPsbP1YM6khs+ombhTWMAPuhAPaPM2beAhvllN36sa
	5jUzVJDENwyzwWDT7MhkU1DR8LGDtjpNvy6OfLZuECSSJ98IfSiICJYb8ESZf1Qm4Cu7oQ2JgH/
	lYpB+gvqpxoaQ+vjRnhmISbSMzQ/qjhMBeBuJlgRD
X-Gm-Gg: ATEYQzxcLn59g2W3HYa2qhxmAn+QP/g7h0k9pGbkHiuX4ORK5TXBSv5q8TXyWrlXqKg
	R6THiu+Igb230ThaFW82hS844MqfE9kNPD6n4rj/MilveK/XzoZj85BScl8+8RThjM47GfpKIzp
	+muxmFu6Tb8AR5AibNGPkQwqJri8DYTYGO3VDgwpagiRqaW7ZJWxgAsolxSg02pd+QrEKEdABjs
	MGmsJ18bffF/nevwzs2p3HDRxdTSunfmAvXe+uQ3XGB2PwKt74+Xtgs30hvNeB08ic5mpawauhT
	tqxVpp7qpkG4ovpA8UOvABYBMjNCIHK5K3pTTA==
X-Received: by 2002:a05:622a:508:b0:506:a1b1:422d with SMTP id
 d75a77b69052e-508e5e2b30dmr8659941cf.14.1772726170353; Thu, 05 Mar 2026
 07:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-3-surenb@google.com>
 <74bffc7a-2b8c-40ae-ab02-cd0ced082e18@lucifer.local> <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>
 <aadeHiMqhHF0EQkt@casper.infradead.org> <CAJuCfpFB1ON8=rkqu3MkrbD2mVBeHLK4122nm9RH31fH3hT2Hw@mail.gmail.com>
 <aael1XWaOJN134la@casper.infradead.org> <76aff8f9-1c08-449a-a034-f3b93440d1a8@lucifer.local>
 <aaiBX5Mm36Kg0wq1@casper.infradead.org>
In-Reply-To: <aaiBX5Mm36Kg0wq1@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Mar 2026 07:55:59 -0800
X-Gm-Features: AaiRm53SpNsDBZ1BZJy_J-KSVGaLXeUaHRvKuxEZ4rqtXprCC3pHIR_HRRDvcVY
Message-ID: <CAJuCfpF1=DP4Whe9YkuMcqkE7CXnDWMDbvBAg9pAsut0YSeKEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: replace vma_start_write() with vma_start_write_killable()
To: Matthew Wilcox <willy@infradead.org>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:00=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 04, 2026 at 04:53:27PM +0000, Lorenzo Stoakes (Oracle) wrote:
> > On Wed, Mar 04, 2026 at 03:24:05AM +0000, Matthew Wilcox wrote:
> > > We could literally return any error code -- it never makes it to
> > > userspace.  I forget where it is, but if you follow the syscall
> > > return to user path, a dying task never makes it to running a single
> > > instruction.
> >
> > Thanks for that Matthew, that makes life easier then.
> >
> > We can probably replace some of the more horrid if (err =3D=3D -EINTR) =
stuff with
> > fatal_signal_pending(current) to be clearer as a result.
>
> Umm.  Be careful?  fatal_signal_pending() may become true at a later
> point, so you may have acquired the lock _and_ fatal_signal_pending()
> can be true.  I'd need to audit a patch to be sure that it's a
> reasonable replacement.

Good point. I'll evaluate each case for this potential.
Thanks!
