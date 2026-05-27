Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6722472A6;
	Wed, 27 May 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862675; cv=none; b=QHKa2JJlp759kGEX4o9SOiAQgRH8aZKMgTDDX3iwXiNJa6XDhitvKobNMRuqFt4RH0gz1j9VgJDn2c+h0GiqDZQkq+OyJFSTopsXTd4iwD+w8udfLkov7ydXnPEhfojLvaHGkKAR5GxoIUa6zs8b0Nu8OsAsTJqox6KJGmcYG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862675; c=relaxed/simple;
	bh=ITZ89l8iv+tRojDGYDoM+u7LyJtEkE40gE1DUpCsepw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gza85TsePKaIThe2POTxVWWky4xztRZdyhrZNskYUWoReVoz56GG2nNjgOKhtgLeHnL+CAYXqhf2q8zIUNttl59L1y6Bviss2y1h0H7tw6xjujSBxwM0JWSdXIUCIBSla8JPC9WyBi3f7B+9/HUBobalmUCyZW01hU63T41a4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGF4HNU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGF4HNU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482771F00A3A;
	Wed, 27 May 2026 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779862674;
	bh=ZT/m8b1GGado2ObiguIe+nrJbFZcOjU/0firNep8ZZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZGF4HNU8vusMaJXqA36lg/7aCESZ5Yv1d7rXALegoxA85zBLw6Br4xR3MyNoMU3Ni
	 SiWYsIidwkJGPSE/vxajnzuQ1m52HRM/8hJCkJr0R0q1CdpXr3/owbXTlUrzlXfpzk
	 +ueF3LRS00o9zNfmsa38IFO0qVZTSWfydKbddr25y8veDTi5utOdXCWr40SqLyz6/a
	 qA/2VJvMoD1mbU7w/Lha2PQsmAAgyq9/hTSoDLCRJqo0E+o3q7WDLmuL6VEVLyIXOj
	 z4Box8YffdHjbIVkFk2VlH/Ae0rbxa3A83yAGYr99qRKVbxfkIu61SIS6W2q3P6Mu9
	 GqrsHKTqjRWiQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7C4E5F4006F;
	Wed, 27 May 2026 02:17:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 02:17:52 -0400
X-ME-Sender: <xms:kIwWak9u3bKh0PZ2-2vlwdaKDX0ZCjeQQW4X6eYYquRmxkQ4Fu-m6g>
    <xme:kIwWaqn3C8WqyU5qOEDNf_DmCqdOLzBnjygiVtmKRp2pY_GZr7wcrix6XnN_XCByP
    IlOTXfOCfu1JBEsOZfdkclougvvRHlY-R7EAS6xYCX0nzJitSDTVOZK>
X-ME-Received: <xmr:kIwWajG9OzDDFVvY7_6eus_xqy0lfTjzvuZ7-vAixy8OkOUXn0G7nkR-7oAdTdfSB8jBuhI7fGKyVTJ4uWdt0E17WuVxZbllREo>
X-ME-Proxy-Cause: dmFkZTGErg+1lWkmtnAfvZbPe16X0asbS04veNar5msmw1tkod5BOZqg7nEH99D5I9SUhQ
    Eimi3Gtg2JkZkWINT7pEaY7Zsjx/vI51Vw+mc4IeFv+/0YLPvV9POut5KNXS7vXU43Y5uk
    Z9b052jxbLf7zuQpq8Q4paiW6CrKpiXaldtdAONK+ChW4RAHl1HO8O6Vt0TSgo0SE0unyo
    G1tRhBTXhQKQDvhIuDBZ6v3R/hp3x62c4Rid1K7J84JHjPGDmjW4GIQM7O1/0n1ZeXw3kj
    OiTvOjHcFQHUqbztpMt2u9eqcsHopQ4s/NvDdELaBTL7VJYKNpaiZe0/UAi7fJne7y/EI7
    punSI61BJxIPNVXx7CoOy1h+sR62KKfpO+1rmoJYZQnqZf/gJmvn8ds97hH4eO4OkGYRyJ
    S4Fp+i+r+yw6Wv6dz4bUY61M64JlU1yWp7TtCTVqzfSAlkMAPVaaLHxHT9fBChJt36oEXO
    IpgADbPyaiJYYuuhH42Z7ZJayw13wNccBsuTkW/rc0uI81u1udGkTrp71iecFnAuLiBbPS
    XQG1qcqc/Oj/pgUai1p5J3qKNLc7gjAYhdeUC1kR0+92m4gJA4Ycv70MWW1ChODR+uwSCc
    evBe4npgf2SOOq8tzPKQO77DseN9ja5jKaVZTZwpDLGEXjcde+FdI33ljEKg
X-ME-Proxy: <xmx:kIwWalvxp7cN1jtHn7jncdePxeINa_iSeogoIjzrHpar30b5yHqwVQ>
    <xmx:kIwWahmIYVLUxsIYTk7CRNY51sNcZp1ysLF4un7NYslksHgnDS2P-Q>
    <xmx:kIwWamP6Gf1_00K6aZ5uD7i_ZayXa1uinrDp8gOb2V7TDhxYp_S3cw>
    <xmx:kIwWagwNa9e0Ag4swqzy5VfwkyGODN486VW66o5z7R5012saglnZdw>
    <xmx:kIwWakmEOpC0NQCNX7190PZ-wxsodSAmoCwVBux9nPU2s-7tWoGiv6tH>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 02:17:51 -0400 (EDT)
Date: Tue, 26 May 2026 23:17:50 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, 
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
Message-ID: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
In-Reply-To: <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexey Kardashevskiy wrote:
> 
> 
> On 26/5/26 01:48, Aneesh Kumar K.V (Arm) wrote:
> > Add IOMMU_VDEVICE_TSM_REQUEST for issuing TSM guest request/response
> > transactions against an iommufd vdevice.
> > 
> > The ioctl takes a vdevice_id plus request/response user buffers and length
> > fields, and forwards the request through tsm_guest_req() to the PCI TSM
> > backend. This provides the host-side passthrough path used by CoCo guests
> > for TSM device attestation and acceptance flows after the device has been
> > bound to TSM.
> > 
> > Also add the supporting tsm_guest_req() helper and associated TSM core
> > interface definitions.
> > 
> > Based on changes from: Alexey Kardashevskiy <aik@amd.com>
> > 
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >   drivers/iommu/iommufd/iommufd_private.h |  6 ++
> >   drivers/iommu/iommufd/main.c            |  3 +
> >   drivers/iommu/iommufd/tsm.c             | 68 +++++++++++++++++++++
> >   drivers/virt/coco/tsm-core.c            | 39 ++++++++++++
> >   include/linux/pci-tsm.h                 |  9 +--
> >   include/linux/tsm.h                     | 25 ++++++++
> >   include/uapi/linux/iommufd.h            | 80 +++++++++++++++++++++++++
> >   7 files changed, 226 insertions(+), 4 deletions(-)
[..]
> > diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> > index 09ee668dbed9..342fbdb6a6b9 100644
> > --- a/drivers/iommu/iommufd/tsm.c
> > +++ b/drivers/iommu/iommufd/tsm.c
> > @@ -60,3 +60,71 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> >   	iommufd_put_object(ucmd->ictx, &vdev->obj);
> >   	return rc;
> >   }
> > +
> > +static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
> > +{
> > +	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
> > +		return false;
> > +
> > +	switch (scope) {
> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
> > +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
> 
> This scope thing still needs clarification.
> 
> I have 3 types of requests to fit here, all go via VM -> KVM -> QEMU -> IOMMUFD -> TSM.
> 
> 1) bind/unbind TDI <- moves to CONFIG_LOCKED, this is "OP";
> 2) start/stop TDI <- moves to RUN, this is "GR"? Right now I route it via "OP";
> 3) enable/disable MMIO/DMA <- no TDI state change, this is "GR" but which scope is it here?

The scope parameter was meant to enumerate a security model for classes
of commands that are otherwise opaque to the kernel. However, none of
the commands we are targeting are opaque (private specification with
unknown effect). It now turns out there is no role for @scope for
security.

Now a command family that iommufd can validate seems useful. As it
stands this implementation aliases command codes across TSMs. Do we
proceed with creating an actual shared command uapi for the truly shared
commands:

TSM_REQ_TYPE_DEFAULT: Commands every arch needs
TSM_REQ_READ_OBJECT
TSM_REQ_REGEN_OBJECT
TSM_REQ_OBJECT_INFO
TSM_REQ_VALIDATE_MMIO
TSM_REQ_SET_TDI_STATE

TSM_REQ_TYPE_SEV: Commands only SEV needs
TSM_REQ_SEV_ENABLE_DMA
TSM_REQ_SEV_DISABLE_DMA

...or just observe that per CC arch commands are needed to setup the VM
so per CC arch commands are needed to marshal device assignment support
requests.

In that case pci_tsm_req_scope becomes tsm_req_type and is just:

TSM_REQ_TYPE_CCA
TSM_REQ_TYPE_SEV
TSM_REQ_TYPE_TDX

I am leaning towards the latter at this point.
