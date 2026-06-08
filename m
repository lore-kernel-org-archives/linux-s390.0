Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB3331221
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934691; cv=pass; b=GVKthS4hRv8X/N78CYfov53cWrvaeiWlj3b/IN5ETd5/HtefJHmuI4NRSrza8TaSE24fLEfaiUieDQ0Pkgu+zxo4JZE+ylNewqGFnazsZpQHCAPoY0Bmm/E1qNeBmocEPC8q4uTLHDtj3etkI5AdAJPvxHvLqn6oWtiYg111jm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934691; c=relaxed/simple;
	bh=itDKg5VHTo1QlVDvtR/ptqkY/rb9iX9OeM5STd1MO0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdMjpOcJesz6rma+PZRzht+PkSE/iwqNWecb+X1qsIPBur5L2ntMQ0U7GCpMsJyG5QEZ1cL2Hitft0LXFmr4GafHeoWio1D81sCJLwWoAu5AgyHYR4Srb56QP4WrjJsjX4CstGqqfdv8qgB3FVHDKsYi85PNLIJEg6bI7e+1h/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcTHiuoZ; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcTHiuoZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso227685e9.0
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934688; cv=none;
        d=google.com; s=arc-20240605;
        b=ULOFMLlku7nQmJG3cz/vAfNZdfEd5IOgH3pXq0CeTcnvHmJ41m0XdzLeSa2hHYwcoM
         piFDJDSuW1E4WBVXu+UM0pFX/GgagAKrV4fDhSjFgpzvzmcGgobCKjxdMe9pBDEbiqKu
         vP4lo4JmhrKcG1pP1mGNb8WZeFkvHDmdK269bKaRVFpFRSjeSMck09OK5cC8XyU3zuuF
         80dLcmwoWO94B5g+sGf82X4FHGhIkCWgwlHmfTw2vvRvzfu8bZerNmLJDYNYPrCorNhE
         5iAIMEwbFuRVtMY99gMeusqX4xAfPcQ4uO1WHtaXG7dR7is/fdNfPfsVtZfzQ6kDu48U
         Z4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        fh=RyJYGtXMivuL22W834ULjv5uO0ihFfK+BgvKFRn+HPQ=;
        b=FSKH8WHxf5uDNzC0FWllBsBKbE1bj7ItyWk82iehIhgXbtFwXa6fTeYbH8uNErFMAN
         kVVgG8snAjzUODkUqRQouqMTqjLXeY+rue7CxW20T/AUVni1Co3XSwqfWvjEkQA7H1ng
         xscH0jAveO+r8LqqsIKeezpH274fT6sKLaVbIZXxcaE/VPeevPWVvwV9/BLzo+ODCv0h
         yUkqLMKi7R05OX5ooOIuSluhp1oRdfZCHplImYOxIdXnPWuC3ZiHn7G6o6DiLWWhuifi
         aJzBt73gtZTgfFb84i6RK5j7cblnX8tFtl9txA3MFhNL7SIESSD4Wfk8xrITRVw63Vak
         7eHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780934688; x=1781539488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=fcTHiuoZM/HzqVrsfTVcruUqqoDAGoZcNMOp0l2L5cn/1oJfG0LU0pMIY5GXRVKFCb
         mUxWdmRlt7q3favv1wdHOm8qivQ+uBFnDjUqHGo0qWgkSoFFyptBGP4GPSQ6wNcFdWOG
         zxV8QCQyyplwuBsBRHsJ+HZtwWTzvfMh7P6P6b0Dtq6Klhlj/29+GXXs91iP9eFeRAGe
         bha6Wslr8feUvcargoVV4JKXCiyHoX+u3oyxflqfQlBDvHfdQVCpB0mscwDzSBN8ontd
         dR/AufSqrThIxpxBgzkgzUSH2Sc0KwOp9ZwzE5DPXt2OYW+lnredLfguzhhHDJerwmhy
         KYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934688; x=1781539488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDdhbWCx9VsAlPpkbZ7T/pVekmt8/mWg3u3kSPoOV2c=;
        b=rXq0gq6qxFxFefWP/a/CcHNxocTz2GJ5hSp6xGPfSkrHSThwcSYtbEIxBh2Ccsx8AE
         7nRG6hfecEx82AqTV3y8xLmy82fVEFvg15ShFt0zzMihUwg16tAcC005dwIB1wHhNMdw
         x+lYgMsRZ6gdSfpaLBtQOc3hZcGcEum0/JfClfU9FBMIVogu9CPPzmos+bCAmkdteX7n
         aZlLZL6TlC9X0wmQGZFD4v2Ffos/xYcbHpkXtRG13EupJOivAZ6UHnL9yNSH0rtua8Re
         mvbBLK7d1htKjlSZbyFxGbheOuUm6A9W7AdBPFawyB6o6uZnu5cNZUqGwDTh+glQPXGK
         Bd7A==
X-Forwarded-Encrypted: i=1; AFNElJ9pyHol/Q2gOHY+uYPY/TNNHQ7bCwkah9PaCPTSCbDn118xqacSDIcEVZfcF5IrCnzrfLZgMdi+0Ch4@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcB6lqsVbOJiooaIrD7LFm0XbIVfe1pkePRlwel62OaLQ0GeH
	sTc/q+fUgPOeztJ98+zcnz74fCcQrJyIXYnSgg1TCzMgmRPgyqFpJeJHmaT/tt5k9ETjwJ7AKcz
	QhIf2Lk+LiaL1xUyKHjKjUlL6RSxK4s9bDLaZIf/P
X-Gm-Gg: Acq92OFGDJzNZvoiE1OpeGgwMQ/oaPqZV5lrID7oMNfcK6qky0nPPg6nASKM98EIfJi
	XfU80Z0urrJlDga3epFOOcuiOM4uQ9UFfq082cMBXYM6sg8Ser/chRa/28IBy+akSWVuh4AXIn9
	mVPjYXNjHa/zj79QZWmGA9hBgacPoKlgNwUORoBXEuT5JWisZTmkc7AhhxR/0CeoRIooemQRkqt
	Fp+FLkW5eem0PEaVsp7/DycvqsThcMbmA8/Aq/afClzwWKIH+z9eQ0bvkhQtOMzhRpyyriLlz4L
	Z8tjzMZpdXJrIYfcBLjoxVGS7Tp5TW8qnrXbjzATZK0tQuhX
X-Received: by 2002:a05:600c:3495:b0:490:b0f1:3422 with SMTP id
 5b1f17b1804b1-490c2ca21f1mr5078185e9.10.1780934688036; Mon, 08 Jun 2026
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
 <20260604135712.GV2487554@ziepe.ca> <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
 <20260608152743.GD2764304@ziepe.ca>
In-Reply-To: <20260608152743.GD2764304@ziepe.ca>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jun 2026 09:04:35 -0700
X-Gm-Features: AVVi8CdkX2dlLd8iv_kbStMI93TXdDT01BqcU1-TGKHekXSJtH26ENHtm_IhVVA
Message-ID: <CABdmKX18EXsL48Cv1Kxrp0g6bVndZfU9b5pfeGgQyvMREk5PSA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>, 
	Maxime Ripard <mripard@kernel.org>, Christoph Hellwig <hch@infradead.org>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:27=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Jun 08, 2026 at 08:47:15PM +0530, Sumit Semwal wrote:
> > Hi Jason,
> >
> > On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
> > >
> > > > Given that Christoph's objection is not really about the modules pa=
rt,
> > > > but that the set_memory_{encrypted,decrypted} should not be used he=
re,
> > > > one option is to revert 78b30c50a7ac until that issue is sorted out=
?
> > >
> > > Please no, we have stuff already using this so it would be a
> > > functional regression. Revert making heaps into a module since that
> > > doesn't have a functional regression.
> >
> > Thanks for your comments.
> >
> > To me, it looks like while system and system_cc_shared heaps share a
> > lot of code, their user bases have different needs. It's apparent that
> > system_cc_heap users don't care about it being a module while system
> > heap users would very much like so.
> >
> > I also discussed this with Arnd, and he suggested we could rearrange
> > the code so that system_heap_cc_shared_priv depends on a new Kconfig
> > symbol like
> >
> > config DMABUF_HEAPS_CC_SYSTEM
> >         bool "DMA-BUF System Heap for memory encryption"
> >         depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=3Dy
> >
> > This allows building both into the kernel or leave encryption choice
> > up to the consumers of the system heap.
> >
> > If this is agreeable to everyone, I can post Arnd's patch.
>
> Yeah, that's fine for me for now
>
> Jason

+1 SGTM

Thanks,
T.J.
