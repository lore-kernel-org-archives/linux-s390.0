Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6835F17D;
	Wed, 27 May 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922146; cv=none; b=KmjBWRsY2yDFQSjifkEjFqy9HsySBOxejIrLkIM2MfUT89H9DQ7cnwJrjEfwluOT4+JuA6io/u7Xz2j9hBcFVdBL2fL1457McPt9V/bDNv735ga2CGJ/3BvEg88CPMNqZ7Gir/sWFfHT3ZBYxrSx2rRYVz8PHZQSkU7kYcvInhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922146; c=relaxed/simple;
	bh=XgCimAoT7hxbVKi27EM2uVlOhhGmrOb94/8bSorKk6o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lCveeWXPtIGs0CJQ8vPtldn0zHWmRRvxhDfSnoCT6hcPouLLzityAVbPe5+L54Gj0FH5fM7uVQVQRjdu2jBeRNrtSUSr4Bye9jagg8L+sodOrj4uxOwqeVTzBMUHlnWZaw6D4LsMuNm+ys2EpyeKZawNjbi33zH0o68iKxKniSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfXIZS1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfXIZS1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199341F00A3D;
	Wed, 27 May 2026 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779922145;
	bh=kbwvCEgGUo53H1eMdHinsXodo5C04fK1nklZJsj/WrU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZfXIZS1Ls2HEsX0SlQYoXjWfo4DV+yfsRZo6fAPXpYNLbaKANgvkILGMArld3S/zj
	 Kl9L+PVwAM9iVCd6ayt1ecyj2PIFBa/HoxpcLq64RWXKA1kY+ckBHfdIsfvsmD6+AA
	 q8Y7ok0dljyVyUi2HNrJ1ADSolklhHqzH12ygiwE724mSDofrSYq6Tnibrhq6Sqeji
	 UhPU6Psy+RpY7uirQCbkmhhXCzd+TBsbPCrwfibePFDG3vKQJYp6Iet6oSJz3xpZTG
	 NSS1V/Fq0n2+GkAB8++1mFf9rC5nCjtEdX7Fv38isZAUS/hzyIJVWvW5kCN5ikGLFI
	 xSigt28Vy/gYA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5353AF4006B;
	Wed, 27 May 2026 18:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 18:49:03 -0400
X-ME-Sender: <xms:33QXampOgvj0FTxfrrqvIaE2WkPjN4ZzJPeT7HLRAO703M5bbVhwQg>
    <xme:33QXak_Ng1KpK1W3mzSKlCKYUqCS3oTxMAXUt2FXME0GQjoHgFhMWxhLzn6CciYqD
    9SsY4d-krsQC2UkWuE6VAvdEwKZ4ehCyL2BmduTVTzPq-B5N1cM7Bg>
X-ME-Received: <xmr:33QXai1I8lAnYd5E04lWVxWavWDl5KTjJfgqWjQAvIVzWMRYHkSiABWI9DPINF-1Cd57hmWuX9cQcFB39p8RBMgv0YkN36Om1lU>
X-ME-Proxy-Cause: dmFkZTEKosdjcGQ0fUzOjNmQ2DaCEkmXgDIgGtQ7CeozMDS1NKqLYgRoYzp4SrcRkoePGh
    I3/0gP8U7PceQZ5VeBofkCCiqKdtXu/IVi1l7qzDRfWoqulRf4ZxWwe+5xsnELv45z+f/G
    MaW/6HK6PZ9Po7ctNfm2S2K8YTLug1Wy65sJ4o5Ro+jeumn5uaFuZ85G3XiIiuz96lPvyJ
    5fVFLuiNLia/ofcgArMi7jyfqb+AyocmjpvFTrvevVedErrFHWQvg4mrVFRK+7hxI8TP9M
    mH1GI7EFK4AsYlNCrehRXq0VRcua8GPJN1WdVOwJgcw1qyxxLSJNDVONOXjRw9Ti6ErZO8
    IrHD8LSA2YBfCifjnv7QIoH3nmTTq5UhqXrsa2xxfEYB5iGFJ+/B967wkejXSzOP9s9tkv
    UziHZTPytzoznWs846mNcKteLWm5xtwTynhnjOrk5gw8NB5l1etb2x+/nrPDugBmnBBK/v
    1D0lDSGZ10+FSjJsdy6DjVLLoKrjKk78XVjOo/5ByP2KjEIVJvPtPm0VVSuBJj4eR3Sjyv
    V6VDIJElnseu4xowOBfRXXRYf2l5RdjZ7CSob4xY0gEA9sCwels/KxGLYUc6MfH6UAP10J
    Ki7RBESOfd6GCyV5R5advgpW4KSHN05EtIQ+9TPuuk3AJBaPYbxgY5UdHtyA
X-ME-Proxy: <xmx:33QXagjbrn0N50-mkQRVcaem9HyvUmPsqN33puowc7OUHE5Za155kQ>
    <xmx:33QXaucHNUjz6CMg_eWGBI2GVA5a4BRjQ0__UGwjLXLtFONMDBhu8w>
    <xmx:33QXas0GqdHzsaxMbrruKhhHapNJW6YuDhyVjV57fZSmFdQuhJRAPA>
    <xmx:33QXaiN8g3Bd53M7QMBeTuH-AWTijtnsJaP1eq_qSAR8M3WMXLjMYA>
    <xmx:33QXarTzdGYhkry-UZRJtm3zXrRdJgI-w69jvHYiJrkKw_kYebPLmtte>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 18:49:02 -0400 (EDT)
Date: Wed, 27 May 2026 15:49:01 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 linux-coco@lists.linux.dev, 
 iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Dan Williams <djbw@kernel.org>,
  Jason Gunthorpe <jgg@ziepe.ca>,  Joerg Roedel <joro@8bytes.org>,
  Jonathan Cameron <jic23@kernel.org>,  Kevin Tian <kevin.tian@intel.com>,
  Nicolin Chen <nicolinc@nvidia.com>,  Samuel Ortiz <sameo@rivosinc.com>,
  Steven Price <steven.price@arm.com>,
  Suzuki K Poulose <Suzuki.Poulose@arm.com>,
  Will Deacon <will@kernel.org>,  Xu Yilun <yilun.xu@linux.intel.com>,
  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
  Paolo Bonzini <pbonzini@redhat.com>,
  Tony Krowiak <akrowiak@linux.ibm.com>,
  Halil Pasic <pasic@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,
  Harald Freudenberger <freude@linux.ibm.com>,
  Holger Dengler <dengler@linux.ibm.com>,
  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,
  Alexander Gordeev <agordeev@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,
  Sven Schnelle <svens@linux.ibm.com>,
  Alex Williamson <alex@shazbot.org>,
  Matthew Rosato <mjrosato@linux.ibm.com>,
  Farhan Ali <alifm@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,
  linux-s390@vger.kernel.org
Message-ID: <6a1774dd80f74_19737610095@djbw-dev.notmuch>
In-Reply-To: <yq5aldd4spyc.fsf@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
 <yq5apl2gsw6y.fsf@kernel.org>
 <yq5aldd4spyc.fsf@kernel.org>
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aneesh Kumar K.V wrote:
> >> I am leaning towards the latter at this point.
> >
> > But we already have struct pci_tsm_ops::guest_req, which is specific =
to
> > the underlying CC architecture. From the above, pci_tsm_req_scope als=
o
> > appears to carry the same information. Is that useful?
> >
> =

> I think there is value in having the VMM express the guest=E2=80=99s
> confidential computing architecture, so that the TSM backend can
> validate whether it should handle that guest request ?.

Yes, that is the idea.

> So it would not be the IOMMU validating the scope value, but rather
> pci_tsm_ops::guest_req.
> =

> static ssize_t cca_tsm_guest_req(struct pci_tdi *tdi, enum pci_tsm_req_=
scope scope,
> 		sockptr_t req, size_t req_len, sockptr_t resp,
> 		size_t resp_len, u64 *tsm_code)
> {
> 	struct pci_dev *pdev =3D tdi->pdev;
> =

> 	/* reject the guest request if VMM was using the link tsm wrongly. The=
 guest
> 	 * was using a wrong CC archiecture with this link tsm
> 	 */
> 	if (scope !=3D TSM_REQ_TYPE_CCA)
> 		return -EINVAL;

Right, iommufd is tunneling TSM requests. The tunnel should have an
envelope of TSM_REQ_TYPE_* and an @op field. The TSM driver gets those
from iommufd, validates the envelope and then processes @req.

This self-consistency and explicitness also buys some future-proofing.
It allows for alternate command sets within an arch, cross TSM
implementation shared commands, IOMMUFD-to-TSM requests outside of guest
requests.

> Jason Gunthorpe <jgg@ziepe.ca> writes:
> =

> > On Tue, May 26, 2026 at 11:17:50PM -0700, Dan Williams (nvidia) wrote=
:
> >
> >> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
> >> =

> >> TSM_REQ_TYPE_CCA
> >> TSM_REQ_TYPE_SEV
> >> TSM_REQ_TYPE_TDX
> >> =

> >> I am leaning towards the latter at this point.
> >
> > Yeah, this sounds good. I would also include an common op field that
> > can be decoded by the TSM driver based on the TYPE above, and the
> > usual in/out message buffers.
> =

> We already have iommufd_vdevice_tsm_op_ioctl() to handle common
> operations.

Per above, I believe this is about an @op value in a common location
that iommufd can forward to the backend for validation of guest
requests.

> Right now, it handles IOMMU_VDEVICE_TSM_BIND and
> IOMMU_VDEVICE_TSM_UNBIND. I guess we should move TSM_REQ_SET_TDI_STATE
> operations to that as well?

I think we can wait to move it to its own IOMMU operation unless/until
there is a need to set RUN outside of an explicit guest request, right?=
