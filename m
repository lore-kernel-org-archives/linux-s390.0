Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087361BF50
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737268; cv=none; b=beW8PtCH8usaluBo0xUbY0djH9PvtYhqEVMtX+lv53pNIjSwU3NzTb1b9uBcxtmJdUmnXwGN6zWleANFwLiPnFamtyYT3MaOa21/2yr/EBaMGa/A9VAJlNSE0VXealgGcIvS9vb7W+fp1oyR1blaPMS9GSB2PQk36pPpjDzYcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737268; c=relaxed/simple;
	bh=RZdzogOuc1kq4sjLYqFyUe9bGzfScwyKnQmviKovzjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdNswscK/TELABABP3SA644DAGPLgjHVQoj9TBToAuXQM+V3voxbDs6OjpHj4eCWlfgexrJ2uc9IGpQGlJ64jeghK/S9JuJ0SSge00LFBPHLRBN3QdUC3GFRYkfbClYWBzuSw33namZYum8cJghGADMNNpTahVyguf4j/Qhfuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBhxWS/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBhxWS/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718737265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iONNWsSJIhRiflyqzXYngvOSW75NSKM8t1pbHy6XOt8=;
	b=fBhxWS/o/iPbCCTwunjtM1Wm9ig9d18Kjse4QtunrOJ+Z6VYQ1VnJm0QiYoSLyGzFFr1Gb
	o/50HYrwUYwso5nXZlPhoonGKyIH7vFnNLogkl8sLh/2AQcfFSijq5bySk1WPLhDhJsTzq
	SjT0Z+WmKuJAlcKi5vz47uWUBsvSPpE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Mgkhq3VrNPmqsL96tjtcbw-1; Tue, 18 Jun 2024 15:01:04 -0400
X-MC-Unique: Mgkhq3VrNPmqsL96tjtcbw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so712423539f.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 12:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737263; x=1719342063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iONNWsSJIhRiflyqzXYngvOSW75NSKM8t1pbHy6XOt8=;
        b=X6UXHAARjgeBBM5i4Hk0ntpWvxVEHz9Qako/LIau+T2pRUIejGNm+bXucJjw0aLW0k
         PyWCGbk5eHcZ7Hoco2nUdM1okHSVagPv+Jc0s5cy7p8x70foHOEtgv3LV6ACqYRRYtN3
         /6jiitm65d4zEPAw644d08Z9z+2267F6QVaUv8dxyTZ5lg+fGmpKFQFVNJdyndWvZV17
         RutLE9nqZYui3sPnH/4QJhUC8nhUQOCUhd7Q4wrA6vOB1ROsgyrEa78HEBLffNv7NiJ3
         ExKK4kG6FgJMmzjbuz033EvF3HekwS1QgoK1nURfmbX67819tBekvRs31k/lh2+9wIsO
         WVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV66S7KKebJZGT/8CzrxsErkhXeTcmDYEOlPPOHqQqrDJAeSqIGKWnQMNoG8F5hfJg1U2xbuG+WvgsNtOiXa/NHqsli5u4vbLY7vA==
X-Gm-Message-State: AOJu0YxunGJiEudk1z99u8qx6ZqymY/IUTESAELX2QaKlenaJofVVqKm
	gvgbaG9FmXbX6ZhrgQPUAiefpqYdzs+HEZRlxa0GMQzwgaI2L3JgRAYvshEL1Yn7SMaX55MnjUd
	nTA79Vw+IvucHKTvR9sQYPLPHIeyrz4poyQKZmzobZE/L6vftqcctOh+8pCg=
X-Received: by 2002:a05:6602:13ce:b0:7eb:8d08:e9de with SMTP id ca18e2360f4ac-7f13ee617f3mr87313839f.14.1718737263720;
        Tue, 18 Jun 2024 12:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt6/Yo+vizoGd9kpvkDUEN0YgXOl2lw7rJTfvjGTAnXaZt0xOJLqn58TmtgF3f7CbCJGzNrg==
X-Received: by 2002:a05:6602:13ce:b0:7eb:8d08:e9de with SMTP id ca18e2360f4ac-7f13ee617f3mr87309739f.14.1718737263284;
        Tue, 18 Jun 2024 12:01:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b95693f330sm3278327173.61.2024.06.18.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:01:02 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:01:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Ramesh Thomas <ramesh.thomas@intel.com>,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, Ankit Agrawal
 <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>, Ben Segal <bpsegal@us.ibm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] vfio/pci: Fix typo in macro to declare accessors
Message-ID: <20240618130100.4d7a901f.alex.williamson@redhat.com>
In-Reply-To: <162e40498e962258e965661b7ad8457e2e97ecdf.camel@linux.ibm.com>
References: <20240605160112.925957-1-gbayer@linux.ibm.com>
	<20240605160112.925957-4-gbayer@linux.ibm.com>
	<20240618112020.3e348767.alex.williamson@redhat.com>
	<162e40498e962258e965661b7ad8457e2e97ecdf.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 20:04:26 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

> On Tue, 2024-06-18 at 11:20 -0600, Alex Williamson wrote:
> > On Wed,=C2=A0 5 Jun 2024 18:01:12 +0200
> > Gerd Bayer <gbayer@linux.ibm.com> wrote:
> >  =20
> > > Correct spelling of DECLA[RA]TION =20
> >=20
> > But why did we also transfer the semicolon from the body of the macro
> > to the call site?=C2=A0 This doesn't match how we handle macros for
> > VFIO_IOWRITE, VFIO_IOREAD, or the new VFIO_IORDWR added in this
> > series.
> > Thanks,
> >=20
> > Alex =20
>=20
> Hi Alex,
>=20
> I wanted to make it visible, already in the contracted form, that
> VFIO_IO{READ|WRITE}_DECLARATION is in fact expanding to a function
> prototype declaration, while the marco defines in
> drivers/vfio/pci/vfio_pci_core.c expand to function implementations.
>=20
> My quick searching for in-tree precedence was pretty inconclusive
> though. So, I can revert that if you want.

Hi Gerd,

I'd tend to keep them as is since both are declaring something, a
prototype or a function, rather than a macro intended to be used
inline.  Ideally one macro could handle both declarations now that we
sort of have symmetry but we'd currently still need a #ifdef in the
macro which doesn't trivially work.  If we were to do something like
that though, relocating the semicolon doesn't make sense.

In any case, this proposal is stated as just a typo fix, but it's more.
Thanks,

Alex

> > > Suggested-by: Ramesh Thomas <ramesh.thomas@intel.com>
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > > =C2=A0include/linux/vfio_pci_core.h | 24 ++++++++++++------------
> > > =C2=A01 file changed, 12 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/include/linux/vfio_pci_core.h
> > > b/include/linux/vfio_pci_core.h
> > > index f4cf5fd2350c..fa59d40573f1 100644
> > > --- a/include/linux/vfio_pci_core.h
> > > +++ b/include/linux/vfio_pci_core.h
> > > @@ -139,26 +139,26 @@ bool
> > > vfio_pci_core_range_intersect_range(loff_t buf_start, size_t
> > > buf_cnt,
> > > =C2=A0					 loff_t *buf_offset,
> > > =C2=A0					 size_t *intersect_count,
> > > =C2=A0					 size_t *register_offset);
> > > -#define VFIO_IOWRITE_DECLATION(size) \
> > > +#define VFIO_IOWRITE_DECLARATION(size) \
> > > =C2=A0int vfio_pci_core_iowrite##size(struct vfio_pci_core_device
> > > *vdev,	\
> > > -			bool test_mem, u##size val, void __iomem
> > > *io);
> > > +			bool test_mem, u##size val, void __iomem
> > > *io)
> > > =C2=A0
> > > -VFIO_IOWRITE_DECLATION(8)
> > > -VFIO_IOWRITE_DECLATION(16)
> > > -VFIO_IOWRITE_DECLATION(32)
> > > +VFIO_IOWRITE_DECLARATION(8);
> > > +VFIO_IOWRITE_DECLARATION(16);
> > > +VFIO_IOWRITE_DECLARATION(32);
> > > =C2=A0#ifdef iowrite64
> > > -VFIO_IOWRITE_DECLATION(64)
> > > +VFIO_IOWRITE_DECLARATION(64);
> > > =C2=A0#endif
> > > =C2=A0
> > > -#define VFIO_IOREAD_DECLATION(size) \
> > > +#define VFIO_IOREAD_DECLARATION(size) \
> > > =C2=A0int vfio_pci_core_ioread##size(struct vfio_pci_core_device
> > > *vdev,	\
> > > -			bool test_mem, u##size *val, void __iomem
> > > *io);
> > > +			bool test_mem, u##size *val, void __iomem
> > > *io)
> > > =C2=A0
> > > -VFIO_IOREAD_DECLATION(8)
> > > -VFIO_IOREAD_DECLATION(16)
> > > -VFIO_IOREAD_DECLATION(32)
> > > +VFIO_IOREAD_DECLARATION(8);
> > > +VFIO_IOREAD_DECLARATION(16);
> > > +VFIO_IOREAD_DECLARATION(32);
> > > =C2=A0#ifdef ioread64
> > > -VFIO_IOREAD_DECLATION(64)
> > > +VFIO_IOREAD_DECLARATION(64);
> > > =C2=A0#endif
> > > =C2=A0
> > > =C2=A0#endif /* VFIO_PCI_CORE_H */ =20
> >=20
> >  =20
>=20

