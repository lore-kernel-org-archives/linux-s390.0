Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7B33D506
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558364; cv=pass; b=FBwzTP4mxMv4EKAeXiv5iC8fZJAQMAZUPEJsOSGfGbw7+UDtK0cXdnAGWI1jyDPH7BoCItMNWTcWRP70VHF2XsL6IwctvUZmRN5jcpXBCC6Y2QbsVrUVNz5H0AFcHyQTzvVmaK3+qlvH+DWWsr3FleiqAar2Dre8T61j6TQtAZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558364; c=relaxed/simple;
	bh=S3yZUPmgM96a8eLarLrzfMcx4Pi7ZeX29Z2UxIQ+heQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK349dpZBWqSPhexQPYZLLouMNZlMYcj1gbHipvpbpbIeBQu7t6I8rafWu8NvQ0YoLbDWZrYz8u5LdCyrvnf0o3SaWobhuYHSUPLFwm3vDF8+96lhgZxa4PG7udT8xMYxxmK2A/S3TURT2AUKPTKK0JUEou1iTgY8N58KI2GBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qo4uJMMk; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qo4uJMMk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso520262a12.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 00:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558361; cv=none;
        d=google.com; s=arc-20240605;
        b=GKmmsC9abeTB+UGkmrhm+4mc1krY+S6FYkP/mh1FqdDy9A7XbRkWY1ARwRyOarUY2t
         Z2/AM5dHS7HXcfObbL9Yx7TD2JUXF9ayRXvPKiAOOXT/w/Bmc+Gb9gC9OPOxV5Sg3jpJ
         O2kO/Ftqlw8ZhXgLfa3e6K12njYR17HRc5JINy9EwD//gzclVov96Gp0j9P1SYzuFbsh
         rnOYRAJUF28XmTOiYMXTJOKxJw+yKrns/D+kkLCGud78XYJ9DvqPFMAdB0xYD46Bp2QN
         kjnCf93826N06In1pEoPAHrFZsx7+50ik/ACbwxtzTee0zmuyNiyTMtat+o19wXLELfi
         J9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        fh=QaETqMCu0ns4WjnzJIXuiPt5UIZESTaBlo1gJCYUnl8=;
        b=IkxgthzoKXiw585Sw+XPeh2TIMNK1RXRopY+nUEOLYv1Nodv7F3dHMHP1ZqIep4Y36
         kDdbl3UCBrY5kORVU1vvwFczxKgvjFTC3/TYeJ8B8llxOqTwIiCuLIUrJM8VhQuxsbcT
         kHE26xclFx1xBOPfs0ffSr6Z8y58zN2soz4ueVskcbDyxho8zZ/KFYU0v59EoQd223e5
         ePS2LhDzwW3C6qslzfoKQZf2kb3kG4yrn1aqVGmQ3AJ0DUwOagL/uj2qd4xY7vVLlows
         WiS7EyD8EGmT3kZ7BPhZWr/2wm1uECc32RVfp7aRfUK+GKKdpZqsyyMghSuL9srydHmA
         gYbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780558361; x=1781163161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=Qo4uJMMkkZXz558w50bDtVYL28nAUMb4Gt7vnqifsO6D/AN0n4Jps76jwCbF7gNHdg
         /56rMV7fhFObsEblJd5DqxsRKMjUStzhDfIgGGzHrnNcSsCp2H8K9fvxLMgAwUg7WsRJ
         tZ8krxHDYciuybZ5Qlq6JxxSYybHsYxzj/RzI+KUYnpX7GyWpqsFjAWd7zFE/yhGxxo5
         iGKDMUVIRvnG3N+83KFQJqzAkhf3brWZUvIYTv/4gu4w8NqRb6SthIQp5VxVVoyD78CO
         nNgUjkG3QTOdR3pLxLdpPMiFbDZteVKa6Kmwel4AIxjoo/yw60A7ehhfCkIoRNglyCP2
         og6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558361; x=1781163161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=YoQQctxqyS60vilTr0CCguGbcIOW8qdllNPFJn784SOkPSYUBeJPP5Cji1HUkQzHRy
         0TtPHncVuRHhOt2B/rwT3BX2uM2Gqe1P0C8TsE1EH8NqqioC9Tac3DOJLpeKJRneJgo6
         kS7sl/C9Fz/VAE+z4p6hgSP81Lxr6Evv2iFJPmn9ibdHTvWUnuUkOgyh+Mxw27wiR9O/
         SZCef62Gb1Mt/RhnIWKTSKt0uK1ZHXQ5Jp828OHNIleKfXU5Vzbru4QJhp+XvFdCngL6
         rtKtbx24iRWvz1dWn6C7hMGAaOhDWCXh8sLGpfvJMYzJs3FZQQ/AsewRpeqabrYTaPNE
         xVqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bmg16AQUDCKQ4iAEs9Plz9piCGZmmJjjebNsgO0ISYaJZ+XIKrAz299r7S9Ejjx23N4r9k8Y+KfHW@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuYYCH8lljiy9p7oZ5E+PTMT/tWsxKE8wA2BDoc3wFW7gzSo9
	5+1EGPyPLXaLZZYmlSeYwjEF2CGYFLDZsYP5Rs/fb5rNzeIiJObvfld3QvTv64GYWdw4kgRt5hm
	raAUmoVCU0PFIEuTYztfEej+VOLrmy+cqi/f9IyDIBA==
X-Gm-Gg: Acq92OHN9aX8odVSjSbbc3QbcHFLOB40VbweRuoWMG6e2engIKeuelONEaKbFo+OcDk
	pRDB3hSk91XymtTSaOf1Q4ROVosjmesgc0rpNCA+NAxiwEIGkM9smI66NHcdVqlY4PuYHlzEwJI
	pF46Yhnw3dPNnu/5Jzgoeve8IKS+WZ82Byc/XVe8NGO/q/4OEhIGPKc3zBc8Y39pgq81r6zPK/t
	Py+8bMXXvLIPSgnUIdjqqJ/a3BZHzJKsw8UY+jHMX8SiugotyeB80bsplXZpVTRX8jSTqw1FJM3
	c8cztVWQyOAPUBX1/I3qIUnX/12CiP4Rk4OeO//U/I/Gdrw=
X-Received: by 2002:a17:907:8e0e:b0:bea:4c91:fe88 with SMTP id
 a640c23a62f3a-bf0ad204057mr309239166b.18.1780558360935; Thu, 04 Jun 2026
 00:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 13:02:28 +0530
X-Gm-Features: AVHnY4Iu3YbvJ8smZ2k5Oglofp60PZLnbqbe_g3OJ5J_F-575g430amKBK4ebP4
Message-ID: <CAO_48GGCdU6znkdHW5gns=s+N0wtNAq4U8s4OtLEyW6Y73oMUA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 12:51, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Hi All,
>
> On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > > module") the system dma-buf heaps can be built as a module. The
> > > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > > but those functions are not exported on powerpc. This can result in a
> > > > > build error like:
> > > >
> > > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > > since 2017, but that's a really bad idea, and we should fix it instead
> > > > of spreading the export.
> > > >
> > > > Setting memory decrypted is a dangerous operations and should only
> > > > be available to core code.  We should have various allocators for
> > > > decrypted code, but not export the functionality to random code.
> > >
> > > At the very least an EXPORT_SYMBOL_NS.
> > >
> > > Looks like there are about 3 modules using it already..
> >
> > So, I'm not really sure how to fix this now. Should we revert the patch
> > making the system heap a module, or should we export the symbols for all
> > archs?
>
> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Jiri, any thoughts from you?

Argh, I'm sorry I missed that some modules are already using it. I apologise!

Christoph, is there a way we could accept the symbols export for other
archs if the arch maintainers are ok? Heiko seemed ok for S390, so
this needs agreement for powerpc.
> >
> > Maxime
>
> Best,
> Sumit.

Best,
Sumit
