Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232873290DA
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126615; cv=pass; b=kUzivVNDs1512dvCa6gghuPCxXvtyEtOfLnNVjExadq5a5MAm/lYM4qoC1u3aOuu6bKW8K9mDx3mfhLGkKEv5ejunl1yMniZv+z4Z+4oqrt18DrQLuTYVzJI6cM9LJrfqBSctUNB1cqJIxhfEDuVaVtBARVZMNiPXlejst6eEZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126615; c=relaxed/simple;
	bh=zN1A0NVoCrNndk1h7brwP4PDvP8PmvZiG+Q9N3TyOjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oRt9TPMYcPtiKqP00eGRQMzPOFn2ELnSjHIjul3V1wZVeG157f3WlNw6e94p073+HCLO+iu2akCk7UfZdd84USf/2NJ4jVrl3Anjsqg3iCJGpNoQcORjQkWPKIp5HCpa+stV5DK4HsC8MmFLfOo0+b1eA9ZcOsghqdejaKmpF6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNjhrGYm; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNjhrGYm"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5033b64256dso734371cf.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 09:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772126613; cv=none;
        d=google.com; s=arc-20240605;
        b=GipjFyKsZE6Tu5fdoTY3e4t64lA3llZMSAoZYEOt4eYO1EjeSox6hoqseiB9acfmTc
         ckTH4zfFnEqh+XSrA34xsha45fWHm0PaI9Y54PePoOtWVooptsDNBhul71ZsDvxh5xkq
         bO5OQbwj67qHHnSCWJZJGSRgALDIjcW86jZ6DbWrLZxQXs0IwcuWYf5Xuxvg98nS4/z1
         4SXgnMUB36yM0WxEJGAysXTATpqNYbNJutmC8cRVCn2BspNo992mmVUVk5kHKpdXYKkP
         9asTTUyGg6NtSmoH/KixjoRqTfNSFbAIrf8taMqDliebGgyLcKTsiar/uYb9AHG2HjTD
         Qteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FynKKhlWalFQKKrs3ZP5yNMAhsIr6fWHYQm9TKDGe4A=;
        fh=PxZXT93Fh3QAf6oPXly2/vdn//6qynIiMOjh04von9E=;
        b=V808gKvj8kScaCUPsn5F/QTiF4GOjQ4L0PbRuDu8hdElsSVsqhKjM8kIgrCgp3pJ1Q
         NlzmGHXoRfakaUZwCPdh37VDNydiGuPM0Q4KepoPjHx2c9J9mZyZL29nmKccq8y7vy1w
         KS/2PAh4PsyE39wA8fivg9skKePV4YID54Y0Jt2/Sofw1fWo/xybZ1U313sRgOe3cQyX
         0PaTRls45T6gFXDjBb6eQz6qv9SM6Ob2Kyu6/558FocoqNJdxcuYf1p8C5cyvAmVGy01
         uHHmEf4UE3aDFKPa8jg7kGFiSzPO0GmC8BklsLtpklhYq8/7Stz4mFbyO0jS5tJpfTCU
         mrrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772126613; x=1772731413; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FynKKhlWalFQKKrs3ZP5yNMAhsIr6fWHYQm9TKDGe4A=;
        b=fNjhrGYmxWL/YvzTLQjN5I8tbQIsTwhB5AZcbt+xKgVJv7BpVOMppvdGMgoTSVX7Za
         Sv/8EL6RNO0WbR8pK9cfM8rRHzbM0poFvzkJ0Q78MWj3x/qRR652mwVmVoL4KAxrc1Z3
         iSMsurK8ZnETiVfLLcYbgMYtvitEoGN0GZzq6m1PRH0VOm0RwcTq67hhdgRsn1wE6ecF
         YXY+oijCE6Pp429gC8WJA5oppjEYYyDpEexm0b9zlNA2aytoiGR/ptaHTEMo8zfRbNfh
         KD+FV9EhJLV+ZaK4PUFFmZLyXEHzQpX1VdJ6JZid0uQjg0KWWp9QhqzY+qINiDENV3o7
         RjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126613; x=1772731413;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FynKKhlWalFQKKrs3ZP5yNMAhsIr6fWHYQm9TKDGe4A=;
        b=emLRVgot5no7MVSCzCQLcwDOHhn/09VKox9kGZ56UrdezZ0vq+TJdrm7L1yKVy+nI/
         /exsCH8i5NElEpnFW2cRR2ULuzU/2FU0WRRPIvuz6X+pZKV9KKzyeWrCi9HoXMl05LIO
         cJ7jPlqeZ/xwyC4m66ZdKk9Ha5vYw9SH6Cni+F2wEhlrtFhL5g1j/dk1HNPU6m73hhbU
         1Q4qu+j2+zkDl4Xdu0wp+wbVHZzlNcu+thJNplA77rwNjYFav7vbke14rPVfmhc6xiyA
         hPfyJkzEyWcOUUmBviMfareHrSmTsDaLc83R+UKkFRpueB7SOapumL/dmO7zTMwchSvB
         RDCw==
X-Forwarded-Encrypted: i=1; AJvYcCWluuFT/2WiD2+3XRdv0K83C9LBkJS8SX1CFJh9xmhgUbE7PdWML8LaHKl1qsikPdZFb7P9mv/Y/Mkw@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZTmxVtAiuIEGn/KQ86PXh4pWd4K53+kt2dNBeZ38FPKK8JbF
	A3BeF2rRzS/z6sCeQOKcxF89n3mtSu2nSeGaVByhN2T4A/O5ARmhovZ54uFr4FD62pf+W8jL2fo
	lH5s0XLg7JZ/AKj12qQ+nfURWyU+JdbNPITZMtBnj
X-Gm-Gg: ATEYQzwDdLSAez0hyH4753NYlnbi1Jwet5UzT6KyD0/uHovvjvujdFjIBQihHzZny9w
	G9lzFYeGdlv/DWv2XnYI40sMupBhZtAGadFUKpIXkl56Y4jvEH8HOoMsPwyOtS91oYOcYTnr7Zc
	Ffig/C5ET85sNmypsZZnmk7qU8Aq3GAeYPQdbwqUZexQ3dpoVwOUJtzEAtEoLDGabztYIvsd03H
	ii0Ni41FTbVCvPrKalrnMWohBm5YPP5HHYgrvGIyE6DZXTqIIMAsEOeNZ6fowWA74pscY3ZqgWQ
	hm6c9S7KUIst52Zu1nGsTqtyMogoGZ2QGtwx7GnLBC1l4w78
X-Received: by 2002:ac8:7fca:0:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-507441ca8aamr14889431cf.10.1772126612071; Thu, 26 Feb 2026
 09:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-2-surenb@google.com>
 <pifgesxxxcwcrarg3q7sgiybg6d6laaym2jcj2h44wqoaxopcv@idc7vavsmjsd>
In-Reply-To: <pifgesxxxcwcrarg3q7sgiybg6d6laaym2jcj2h44wqoaxopcv@idc7vavsmjsd>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Feb 2026 09:23:19 -0800
X-Gm-Features: AaiRm51NlioHOecXqmKgqusOoAstD_F3nrG3Ao8qrpHVfKsEfdkgNePW1BjyYWA
Message-ID: <CAJuCfpGTNuojCXUQU0o-WrCRAuXPUAtLtSG=c8BL00JvnvNBiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/vma: cleanup error handling path in vma_expand()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [260226 02:06]:
> > vma_expand() error handling is a bit confusing with "if (ret) return re=
t;"
> > mixed with "if (!ret && ...) ret =3D ...;". Simplify the code to check
> > for errors and return immediately after an operation that might fail.
> > This also makes later changes to this function more readable.
> >
> > No functional change intended.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> This looks the same as v2, so I'll try again ;)

Sorry, missed adding it. So again, thank you very much!

>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> > ---
> >  mm/vma.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index be64f781a3aa..bb4d0326fecb 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1186,12 +1186,16 @@ int vma_expand(struct vma_merge_struct *vmg)
> >        * Note that, by convention, callers ignore OOM for this case, so
> >        * we don't need to account for vmg->give_up_on_mm here.
> >        */
> > -     if (remove_next)
> > +     if (remove_next) {
> >               ret =3D dup_anon_vma(target, next, &anon_dup);
> > -     if (!ret && vmg->copied_from)
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     if (vmg->copied_from) {
> >               ret =3D dup_anon_vma(target, vmg->copied_from, &anon_dup)=
;
> > -     if (ret)
> > -             return ret;
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       if (remove_next) {
> >               vma_start_write(next);
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
> >
>
