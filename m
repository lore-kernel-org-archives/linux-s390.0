Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBC3750DD
	for <linux-s390@vger.kernel.org>; Tue,  3 Mar 2026 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572109; cv=pass; b=BCoQGC2+EWYPleAXv7FLzcLaTWiOpEmdlRPge601QivAzv07CdzbgnFcnjKQiJ7PJIYwHAvDSH6PogWYB5YHMA2YwQAHx50xKDtpyaQpLx1ZYUPvx85CQTm6VZtSWTYgH2UPChwsyKrzVnzp29qG0bvEMpu+OKmDFdI1gPbKKPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572109; c=relaxed/simple;
	bh=KEkVamCoeFISLCmjti3x3hvAOikseimZp+4dyxL4Jmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYnhvQkb9YsS9/jT2viIw0B255q8Uu/AB+j3D7pJST4JZNTGova2AdgqA9zpqFlx66oDhJ6/cA4xkybv30V18riBRvlDXwtjN6HHHIFPJZ+m97aHHGqo14PFjHlbLxH2nLzbu88ujVUUVHwbrOEjzfm6Xgjz9pbscULocFKacGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htilFfbV; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htilFfbV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-505d3baf1a7so652281cf.1
        for <linux-s390@vger.kernel.org>; Tue, 03 Mar 2026 13:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772572106; cv=none;
        d=google.com; s=arc-20240605;
        b=k9b/P+S+bUMFsXEzfZ/V+COJFfst/83rDDQS4vdnxAoKF6M3cxlxzgGXQW9HPpSDXx
         yTimr71685tuuyIKaKn825x0bJJ8GFyPeMZE5PKSEm9E6KC7UD3Iy82YP9CvgZnnhljY
         ewORl2dj5q8tK9EUeSE80D79T8XTkNNOoB9qiBoRAMsp55SEteGz8t2KvZhE3v+AHjMJ
         +4yetH2ZbhoEKPyFTgayXSpyyCfv4g/TtQ255ddkEEPja0lg9n31KtCfhN4+1xIP2vO2
         m60zylKMdbd2yRrqRia0bnFLBk0Yb5b98f4TqzD3TMQRAd7GLczeKAJ5n+wOYe9fPOa7
         bdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wn5qswiKl5vyNXCasCn1z2S9Z34vPhCjx+1iyWUKiGQ=;
        fh=iv69/2BYI55MBeFwlRT4Uw3+3Mt5GG9sJeRYlmhI5F0=;
        b=JmKUNO/Lr97wQNGfZWMc0dQ9ijL4B6nt5pG3sK+AJYV39EHD8rYe/E3+jHOVuCm0R5
         SeP0zqIx2HxJI410fh1glKx8lwoDt0oQlOQRWowRx16YC7izbx6P7YCT2wcm29S5sAu+
         7Kc++dZHkZMSpyREgmADLq0hSH1Cdz1JIn1A3G9Db8DtRRs3HWQuhmQWfA2pl/mWrXxa
         MRANGPilXLDMIyDpYwDFfADEsNk+qy3uqdUqO45kjkP27bjI691vHC/7Y6HRGvAFRd4Z
         Io+nI4fFJUA5OhGebLWHqpiqRBT0eQ44IPDb0tNXRvcM2SZXarrFu5mBhD5iqXksoDLQ
         +JiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772572106; x=1773176906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn5qswiKl5vyNXCasCn1z2S9Z34vPhCjx+1iyWUKiGQ=;
        b=htilFfbVzNItWcnwEt9SMUFi7ba3iCxdaaMIXtleC4O/fng9tkBtBBxrGcS1cEtzRg
         UB/qqqthVL5LjoPs8wSwOkCiTw9HdjJaU5czx73019QUPTa03dKluY5RSFxhn6avyywK
         19zhDQ54ZT4QT1ciCa0/Pw7xFwvZn84/eO59ft3LJoJWD0hjrSujUtXIG+QJlDVqXVO4
         eGj8D6hoT7TqTkEccs0LNxS+DFmwTzMBf0O2L4BaDr2ZHoJTgQb4ptPODmqLj2ejXe3E
         zvSQgrmeSbdX6hXK4W/5Hd+RhZtpYxJe3CUJDZGPe03EQOdpbNo69KsofrqeQxT6lmkj
         brgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572106; x=1773176906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn5qswiKl5vyNXCasCn1z2S9Z34vPhCjx+1iyWUKiGQ=;
        b=CUR5ouEy9C2W50m0RIDdLVTXY3fHNaGGD5ET/h8gMEp2lA9p5YKzWQ2vHkq7ruvBqB
         rTxeoPeF/QZ+iVaqixqitkZXI+4ghMWVyns5/5ggaSgzmeaaCq2TJ0CWRGCaxW0EMJFw
         W5Hyi/+fZ5JNo73dkgfD0P7uWp4QifzZ+VrZ30k76P5qszmuHk5jw/Uh15j2gwxf33L/
         RTN2ktFJe/NLj2+92kDA0IvG9sojWS8jKdTfZMdSAx4DuEvDEsiSRa0Fbo32R5ACwEzz
         QzAqc0W3xrrg1I+HixNtfeCsYkc9fVPmAMYHa2q5tI5B9QgNJctG+6SeZZNVUWiV3vfz
         LteQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+CaDESmMKJ1u4kRF+VqgDnqFIpVPJygKCX1aJ9pW3Ls3CAovOWN0/EfFkugf6AcYbqNAvX3t26YO+@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRfgBXb/ryYZ1bOV1X/xj3EwLaNIFcx1oBibz+ANa9UWlE1aM
	0gVC3OqtRBgCe/MXf7G9CgnusYsal+uUErq9ZwdIaJ+V2+3UJaDGpgb6V1KyKbrW9KmxCyKKnzq
	80eXg1B1lFLjvs3iMM/kt5rPAH+3vtHsnUIkYwO/j
X-Gm-Gg: ATEYQzz4HrzYBYd1hXQ0BAkqoHpvebAngIe8MY8ZQ7YZ4LlEVkdCRZFH4IRipYE6efJ
	1H7TRjqfdzd8U0ytY13QtpWj4muKK2iZDRjfmzF9VDFDkegs3BMwtc0qGQm4a9xLeBOuL1YIQOa
	ndanqU3okR0qS3TUOTLhtZxt3TZiEdbTW2ZW8uFJd/mffx8hd7DAenrAw2+6G5POCdf/GGeE10R
	8MP9z2atQWORnL5cIdpZmziGUNq0hMK3DQ8fkyEe37AD2uH9SAR+D+P9zG6SHXHNfRpHKldYY+r
	5wlJHesYA0jPx2qI88NIJCYezYKRrGr8CgBI
X-Received: by 2002:a05:622a:1999:b0:506:1f23:e22c with SMTP id
 d75a77b69052e-5075fcedcc2mr43645141cf.6.1772572105403; Tue, 03 Mar 2026
 13:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com> <20260226070609.3072570-2-surenb@google.com>
 <877a55ac-b12d-4997-8c0f-fc0405220a63@lucifer.local>
In-Reply-To: <877a55ac-b12d-4997-8c0f-fc0405220a63@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 3 Mar 2026 13:08:13 -0800
X-Gm-Features: AaiRm50S7J7MsSFOK2DH7gtLJxKekAGMKhFqAJWn8DaN9ladXIEjtSX1nx_7JMk
Message-ID: <CAJuCfpHD8wKJTpaRjZtUR3d+e4hSPH4GyL9DCKwbVWDVxWXRug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/vma: cleanup error handling path in vma_expand()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
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

On Mon, Mar 2, 2026 at 5:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 25, 2026 at 11:06:07PM -0800, Suren Baghdasaryan wrote:
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
> LGTM, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

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
>
> > +     if (vmg->copied_from) {
> >               ret =3D dup_anon_vma(target, vmg->copied_from, &anon_dup)=
;
> > -     if (ret)
> > -             return ret;
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Thanks that is an improvement!
>
> I was going to suggest declaring 'ret' in each block but that kinda adds =
noise
> so this is fine.
>
> Maybe rename 'ret' to 'err' but not a big deal, this function could do wi=
th a
> little more cleanup too I think!

Sure, since I'll be posting a new version I'll do the rename too.
Cheers!

>
> >
> >       if (remove_next) {
> >               vma_start_write(next);
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
>
