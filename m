Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80C31F9AA
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291700; cv=pass; b=a+VpJTi17PePSOienXttEy/f+F91hptuYBbwEPQ7INadKGlTFpEQIABOKIbbfBGm9Rlb+uDuKU+xDox1Rxov1npLfRh0YaNQRwMWlTQxqpaTc3txOeKEDjVzMXn06pCCdPJqg0BBmk1fuZCaudeDqNjsDY4fHh0IMgdPoPXTFkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291700; c=relaxed/simple;
	bh=wtd4dR/oVa1duupPZRE6M4yMtMAB5U3Lxud0Yc5yhbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHVE0x2yt5aoPgZI5CZ813gBDtjMdY2G+hmDXSFCbML0U9/xEx5oqPtCCnMPwsB0+ijtvXVVq3MkM8HqRxoeaAwMksVrVvME8znGGj7ShNqug/s75UNg8lpLZxHaRwFA2LwIsW1jtd4lnLgQn7bep5ZJSALBJvf+VKSTKyNSHrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvZ+PVxj; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvZ+PVxj"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b6c45781aso145251cf.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 11:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291698; cv=none;
        d=google.com; s=arc-20240605;
        b=T3tsiGbTT8h/4HielOMFJFL7ypGFGeUKuMcoHMHOyO8I5GKQH2j3HGAH1JUlQk3NGK
         EPJwW455tHtm/cykxTYcPQeAgwq2TWpaTQwzZpsQT7AvQhUMDABxK+Gf7MPkMjAiYj8y
         tXio8WSrjOl3l78VHkQHOdXd7DMUFyOmY7q5kwaLiNwKtPeCiZkmbDpaH+zhJpSxDAJG
         SiB1SrHfVlVfbaVAzdyjN4lQlj9xK3gtscf9NHOd/qyq+MxIOGtV/4892S6zyxYFFc6h
         zlGawl22vBZzcpRAcjbUqoYf9L/LlFtTN1WkytmLSdMMk51exlfWnmtWm/K/jc+zEgst
         v2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        fh=D3uvid7RI32FHJh2XSqNO9z0FN2kN2cVwExilJcZ7+4=;
        b=TVPdFyA9jYhue+bxFUPIrLOUtBAEsy6ci/PbZHE6PK9hKoAoICwiuqKggtxK6SBCOs
         rJ/6y7+23pUB7eTHf7676afzNjYqcxMWH8wi9/dRqHF0adVefea4en+bJ3fYsQF2r0KP
         KDgKpFcN0RQJdDIDkouUohnfSUziC4N/RQ6aRFKTBGoWssCjADjJK7YcT2XHxpoXQ28N
         d7VR/e56sTqNHscI9EGMZ9wRQgvrKo5inOUcbifIfby6A+Kpduvdiz2q62rS+8X9hzz3
         Gp6rPCsQERAkndb89mEyK8cLCnGDGqbiCm67flpAIbIj01PmWWNvcsgS0tZvu6tXMLhB
         QDYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291698; x=1774896498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=uvZ+PVxj96HK+k4Ve4xvJGHxvyizwbjetJuPp1Dc5KTENfgbnAy1/ClCeaM8jZcndO
         4cJzXh/nb8ayOv5YnjXV7SOGTbbCCfkodig3g4JtI2T0X5tlshvoQemfdt/bfTKLYvOl
         haipNw7BOfRLtOTf7f9Fp7+vyvZM1n68ubNJgj2w7AKMIP+K5VOlo0182eGJhnWzuJph
         e0R8VdslH85Zpf9XueAMVrGE7lEPQB/ag6byVMkzrW4vlisx7LVcaHY6f2gAhDo+D0yC
         NMKQkEBL3awkqe0VZV/Y0ouEo8D7n1TPpjJJhMv9gVwrqIW7ylW9/tvv0BckT7fOts1E
         OEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291698; x=1774896498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcYV5qmYcsnRNOVKxHhuAn3tOig0z+BjjlFLGSFtEKI=;
        b=KHCuBQVAzXeE8ro+taELBk8OBPybF0EvXLTVk9ospMx9CeCmcE+YlJBFU+EBVXtFzA
         shQALcZiE/C8F6vPB4YTZ+SqtcmkBNYJVaQdZdaQLy3WqSEqKQ6LqtRa88u1n4LseFEv
         j6KSZSBV1RK2nZ4ADO6KQsEl4W2sk4ktiEBAozesy9Nuz+H4fMN1q+dJLE31dGSlsLBs
         eauRPASfAA5wi+/FPVAl3cgv8pbYxNOK/hnJ1Kp2EK2BmasZ3tpld5ecxC1H6s36J5gR
         BbOzuNErylHjjCZ4/fMR9UMzOdET8DFCjvhet7kLb3oy90rvEUF14tPLLjDB+XWlPRv9
         1acw==
X-Forwarded-Encrypted: i=1; AJvYcCXgTXwmoCqZQcwSvt5XvB0R4efUujtRaNm96QzwWSd57GREPPLi93LAsc4xM3op//pOMc0yIswlxLWr@vger.kernel.org
X-Gm-Message-State: AOJu0YxeV5vjN6VK69RqRp8srZmM3n3lU3VCIrfIfnHrG6lNUPSaUqQY
	j5ZDmnfeuR1wvzqh8jOYo51NnbGWenQKNlPLLrD7l5JyBOFputaHpJXKegGUINRr1L415Sl2Ws0
	mmfa3PPMvqeSLsj3crRrpAC8gDL0ucUuvQnqKBc9L
X-Gm-Gg: ATEYQzzgaIjnTAMPMgwPb/wXqehb2p9pgKzOUZsZSoqlgu0C+/cbgvM7Ej5W7p1XquU
	TDgLwuufKN1z4T4iLR479dj79Vq0BlBb6tVSTyf8SJZE3natmbDNibAXEo/kFpPpYNUvG3zyXaI
	QjrqDm/fAh0tX75vDDQPnhk1r/gevk9UPrNbCbtpx8KxYvsZOi3UvunMsPexDMv3j1qkIp0qYFN
	0LjHy6D5mHfhDwVkPyVYibCcfMs2C7DeeVx1lB/y8MSCPGQRUfNkD09lzgRm8ZGev1o9wWbng2m
	2GziQqohLnEOmfJd
X-Received: by 2002:a05:622a:1f85:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50b6fd357cbmr1787911cf.9.1774291697776; Mon, 23 Mar 2026
 11:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-4-surenb@google.com>
 <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
In-Reply-To: <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 11:48:05 -0700
X-Gm-Features: AQROBzAcISvCKuZDTq5gxGva_UwU6WnzRjvi5ru0PTUHh42qSaWhag7QAbSow20
Message-ID: <CAJuCfpFDv1JC-wXR2d_KyrisnJTXxZbPSCY6Bpo4vLxj+FNw5Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error overwrite
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:53=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:07PM -0700, Suren Baghdasaryan wrote:
> > If kvm_s390_handle_pv() call fails its error code gets recorded but
> > execution proceeds as if the call was successful. If the next call to
> > copy_to_user() fails then the original error is overwritten.
>
> Is that really a big deal though, as you're returning an error in either =
case?
>
> > The follow-up patch adds fatal signal checks during VMA walk, which
> > makes it possible for kvm_s390_handle_pv() to return EINTR error.
> > Without this fix any error including EINTR can be overwritten and
> > original error will be lost.
> >
> > Change error handling for kvm_s390_handle_pv() to alter normal flow
> > once failure happens. This is consistent with how kvm_arch_vm_ioctl
> > handles errors for other ioctl commands.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 3eb60aa932ec..ddad08c0926f 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned=
 int ioctl, unsigned long arg)
> >               }
> >               /* must be called without kvm->lock */
> >               r =3D kvm_s390_handle_pv(kvm, &args);
> > +             if (r)
> > +                     break;
> >               if (copy_to_user(argp, &args, sizeof(args))) {
>
> Yeah as per Sashiko we probably need to copy_to_user() still.
>
> But in that case, do we even need a change at all? I'm not sure it really
> matters which error code terminates things does it?

I agree. I plan to drop this patch from the series (see my former
reply) unless someone tells me otherwise.

>
> >                       r =3D -EFAULT;
> >                       break;
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo
