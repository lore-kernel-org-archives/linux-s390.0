Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC53DF001;
	Thu,  3 Sep 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423659; cv=none; b=emTFW1Tii2DxepubITMD5yOfIkWf2/mhw6Z1plvNDj4IHEAmX84Cb+zTbZoH7xmIHVIFFdEIUC5HgcMh3DCwbA8NiQIFnQoeRfn99eQh4rzCEXRqx8EzF17ON0Ov4HYTcgWN50eqRn3HWxOdqMi0z/EHdWYKIIJoa/BQTqFDnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423659; c=relaxed/simple;
	bh=84DNcnsXLqi+5/LG09dYLEgLVmMNzWJGE5kJxK5txwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc4QClWob0VxfJkfSr5VGnWaqrcjryES7395e4suznCOs182vB8c12YM5U89HL5G0mvEEgwlv9muiWuL2A4+4tKQEC12Kc8EY4StYQng9uvEfnIDx1ZG3oCHqsRyxe+gZtjWQTtbyBUgnVaUQvbaAlMSPBVYVE6wrjOubO+/oyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SnIfij3Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SnIfij3Z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361Ze12239229;
	Thu, 3 Sep 2026 08:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hUm4QUsy/TVNuKJFMSmmKV4BEi2VHN
	7HaKk5bnYppf8=; b=SnIfij3ZuyC841lNNzZpNz60fDPfoAoMoCJKaBxtqGBBAj
	F64bukdJ2rcbXZtz1kcwPjZoSkB2MVZuWjyP2pF1S0mOn8+oLdZZ6BbqdU8kResQ
	5S0U87bEds7BXZIEu1zr7Vg/CqRyia8srD3O5BQRPFt9qKYLn7EABokHwKipvbgY
	vQmn+NCCk8DnLKZ1nNsuuJTr0xgDN+sjbnspFXbXzXFNguR8BXfSdPBQhvK9ijIP
	YbwbZmpaORfXlAr1AeYeug7qvYs589IFcQxuAc3sUwZn665V9utEIGSwoT9RYsYC
	3JU4OuWxwsZQfnHvq6sapMkirvLqYTaadu/Bne6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tk8ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:20:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6837uJDf003084;
	Thu, 3 Sep 2026 08:20:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkerdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:20:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6838KPFl46793010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 08:20:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC562004E;
	Thu,  3 Sep 2026 08:20:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC55920043;
	Thu,  3 Sep 2026 08:20:24 +0000 (GMT)
Received: from osiris (unknown [9.111.48.84])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 08:20:24 +0000 (GMT)
Date: Thu, 3 Sep 2026 10:20:23 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: Use file-based reference counting for KVM
Message-ID: <20260903082023.33034-A-seiden@linux.ibm.com>
References: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
 <20260902141914.15a30449@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902141914.15a30449@shazbot.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a992dcf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=-wUcbuAlgh7G9y_c6i4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfX/K7EfYJSGELq
 LmqlS/lQunbd/g+d78kLa+zOvQih+yqci4SjX3SaTrezD2gI1UtJgbZ/zL8fromqNybgmBTUaPU
 JluFGrRfKhy53PPfxijtvrHmrB5EjUs=
X-Proofpoint-ORIG-GUID: 2hS_Em0VUbYpvASAWceuBdB6wlXzIbcX
X-Proofpoint-GUID: DmSg5LS0hd1AgQrSjpJAoVjnwoIw5mHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MSBTYWx0ZWRfX9W6n61uAwyJv
 xtpqFObxkeDtOVtT7a3Q+RFHnFwUgE9daMKMLyjFJZ/lShJNc7vBGbcS81Xf/wJJ1E55CDDAi9b
 zr6lB81CS4Xsemb6HMcb8ly1eVT4/t5lrwxskNXyEjtnMalrJQyTj/bQaKjgz0vlygJuYg7uZwz
 bV026kC4wbJ0YebqSmaX26qdtR94pKnRu3RESTy0q7wjyf0SuBfMIa/lCvblzSWuuxC8uNe+kLY
 zovbqzQ7f4uo8UQeSgSvzdbjBSRloN0e9AngHawkeMTvxu02rRgihSvaz8c77DK3S1UMF4Cz4w4
 9u6Oug/XyRkuiN6xfFgjcC4JbDwS9Z12kIskjReVWFdbpBQgGY7IG53OOwPRmKS2msmtwLikigk
 PkMaYteJ6hXh3l7j5KDdYsc7UkyO0884G5xBI3lHkmE+bHsW9jQbHrAp7AKbeISSX0zEw5O79Vx
 jQuFNcORr5LDsPyZXxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030071

On Wed, Sep 02, 2026 at 02:19:14PM -0600, Alex Williamson wrote:
> On Wed, 12 Aug 2026 20:55:30 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> > Replace manual module reference counting with file-based reference
> > counting for KVM integration. Previously, VFIO used symbol_get() to
> > obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> > then manually tracked module references through these symbols. This
> > approach required storing the put_kvm function pointer in each device
> > and carefully managing symbol references. Remove the put_kvm field in
> > struct vfio_device as is it no longer used.
> > 
> > Pass struct file pointers instead of struct kvm pointers throughout the
> > VFIO-KVM interface. This leverages the kernel's existing file reference
> > counting mechanism via get_file()/get_file_active() and fput(),
> > eliminating the need for manual module reference tracking. The
> > file->private_data field provides access to the underlying struct kvm
> > when needed.
> > 
> > group->kvm and df->kvm hold a reference of their own, taken when the
> > pointer is stored and dropped when it is overwritten or cleared. They
> > have to: the kvm-vfio device fd holds a VM reference of its own, so the
> > VM file can be closed and released while the kvm-vfio device is still
> > alive and still pointing at it. filp_cachep is SLAB_TYPESAFE_BY_RCU, so
> > a stale pointer left in those slots could be made to reference a
> > recycled, unrelated file.
> > 
> > kvm->file itself carries no reference, so that it does not pin the VM.
> > It is only ever read with get_file_active(), which is safe because
> > kvm_vm_release() clears it, i.e. before the struct file is freed.
> > 
> > This simplifies the code and removes all remaining externally exported
> > symbols for KVM, paving the path for a second concurrent KVM module.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Co-developed-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> > This is a spin-off for the arm-on-s390 series for fast-lane merging
> > requested by sean[0]. It is based on patch 1 [1] of the v6 of the
> > arm-on-s390 series but with some fixes for some issues pointed out by
> > sashiko. The useless rcu protection of kvm->file is removed and
> > the getting-the-file-handle process is streamlined.
> 
> We'll need a shared branch to merge this across two subsystems and the
> vfio-ap driver.  Based on $Subject and LoC I can volunteer to provide
> that once we're settled.  A couple minor issues below...
>

Thank you for this, would be great!

> > diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> > index 0990fdb146b7..d3a110101353 100644
> > --- a/drivers/vfio/pci/vfio_pci_zdev.c
> > +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> > @@ -144,6 +144,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >  {
> >  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> > +	struct kvm *kvm;
> >  
> >  	if (!zdev)
> >  		return -ENODEV;
> > @@ -151,8 +152,12 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >  	if (!vdev->vdev.kvm)
> >  		return 0;
> >  
> > +	kvm = vdev->vdev.kvm->private_data;
> > +	if (!kvm)
> > +		return -ENOENT;
> > +
> >  	if (zpci_kvm_hook.kvm_register)
> > -		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
> > +		return zpci_kvm_hook.kvm_register(zdev, kvm);
> 
> There are conflicts here with Farhan's 9f240376d034 ("s390/pci: Store
> PCI error information for passthrough devices"), we need to maintain
> the error exit funnel through stop mediation.
>

just sent a rebased v2 with that issue resolved.

> >  	return -ENOENT;
> >  }
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 7728bc99b63d..f76504d707e1 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -23,7 +23,7 @@ struct vfio_device_file {
> >  	u8 access_granted;
> >  	u32 devid; /* only valid when iommufd is valid */
> >  	spinlock_t kvm_ref_lock; /* protect kvm field */
> > -	struct kvm *kvm;
> > +	struct file *kvm;
> >  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> >  };
> >  
> > @@ -88,7 +88,7 @@ struct vfio_group {
> >  #endif
> >  	enum vfio_group_type		type;
> >  	struct mutex			group_lock;
> > -	struct kvm			*kvm;
> > +	struct file			*kvm;
> >  	struct file			*opened_file;
> >  	struct iommufd_ctx		*iommufd;
> >  	spinlock_t			kvm_ref_lock;
> > @@ -107,7 +107,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
> >  void vfio_df_group_close(struct vfio_device_file *df);
> >  struct vfio_group *vfio_group_from_file(struct file *file);
> >  bool vfio_group_enforced_coherent(struct vfio_group *group);
> > -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
> > +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
> >  bool vfio_device_has_container(struct vfio_device *device);
> >  int __init vfio_group_init(void);
> >  void vfio_group_cleanup(void);
> 
> There's a stub in the !CONFIG_VFIO_GROUP set of declarations below this
> that isn't updated to the new prototype, build breaks.  Thanks,
> 
> Alex

Ah I missed that. fixed in v2.

	Steffen
