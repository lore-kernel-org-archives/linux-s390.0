Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092030F7FF;
	Thu, 17 Sep 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634772; cv=none; b=lv5i2xyC5baUqZBGkV/LjoihJnOqJcH5sWyqV4Ny2/IZSSjczf5IbCGrV5vzX5lb9ZTpHdIy6v4z6I29IbKhs2WRjArxgRPS0vu9kyC6w+/X8MMqhhI2uzrF9t0BtAj/meskMbbOL1+7g3yRrPvMWm7KZF+W/KlZBvNk0vdGDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634772; c=relaxed/simple;
	bh=KNvuiSAZT/02QuUxp7uiQOlWYu2VUC1qzplqriSz8ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/cMDx72Skwql2VZhhZNwOi38DY7mbNYmJ0sYKyVdLsc0BJuMO5RX1+rTNLmfmuS5a4J6PPadDryzHOz3FOsmt6HZ6Auv27RKne09EYKSady9gT3Nb6IQbO2bH44Ik0sx5JTbnkfhWU4ccXSsSF/vQBoUmcTs4ym9X+RQPlJs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g9dlaHth; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g9dlaHth"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62V4k543286;
	Thu, 17 Sep 2026 08:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=T5CM6ODXOUrqzCVj1f4AUoFeSoYLib
	qQQi4xRw949ug=; b=g9dlaHthG11QP5ZrXfLVjTXxXbYSqgV2LuzJ2K/1ZC0lJr
	quZT21uTR85Uc5hmt1I3JwSudAlylafERGmMd+bwd6fAb/XK9n4O8AV9sTgDiYXL
	HLa/qAzjz4FtRGTj+nJQCNyb0Om/AJf7nUpapw9eqN3Tif3o5vH+C2gcf2SBFcJx
	4ea4w2EvqSzyhPkEFCMZOgS8RalrRSoHve88zVmTtf4zmxcaYEYvJlsrRvgaMaPj
	DKT7BU5LMP/h8uL9HbtHaIFu1z2wKDs+nm5pNP46cfYT4/YNApujotXLDoUJTUwg
	jPwsXCjvmUMv26Ptog15p1Cj3RrlnArmewsVjIUw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8ydf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:45:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H653432660555;
	Thu, 17 Sep 2026 08:45:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjhk3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:45:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H8jkFd28311812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 08:45:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516AE20043;
	Thu, 17 Sep 2026 08:45:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D20720040;
	Thu, 17 Sep 2026 08:45:46 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 08:45:46 +0000 (GMT)
Date: Thu, 17 Sep 2026 10:45:44 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
Message-ID: <20260917084544.474297-A-seiden@linux.ibm.com>
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
 <20260903084221.C3B871F000E9@smtp.kernel.org>
 <apmpWNSv6ahYr2Bl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmpWNSv6ahYr2Bl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNiBTYWx0ZWRfX4FTCRqbsYLxT
 y8ElZRsb3ecu1u3jDKbnmHnSGHE/pSCyvi4Gzl6o1Wf4YvQeV0UCfGyG0JQORNgz4mWHENUgImy
 mGACtsKrluwU18t44CFFM+VqNSl3cjODchhlAHPTo8OThpbciYJjgvkNvqSRjFzaGdoy6Dv23xB
 cKD8D3oadonV3LChRwFSETYe+g7YzLf0RcLkGcl82EmyB7YSASTi2ZruiaG+Mh7C8PxjIgT2EXR
 YgKlHxInAqGTLH+dPGlX9zzXpC8v4WAG2N/fwxyTJH/Kp8iRCZ4Opubs8TttoTuSBd62D81DATU
 moREleUNsgMwwtr+JdYYeyPWhvYtubVmUGPFSzLwUH6v44ktCQtb5+l2ekATqCbZxEF0O0/rlBF
 GGlqBywt+jRWyAx6IWyI+N9+c6xC+8I7aFvI/6CBgOawxTGmDel6jXjN0YZa/Si6rhJxDC9HVYC
 //o6GQ/iHCBPJDsQ01g==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaba8bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1S03ISw_H58Mq3hviRYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xKBDAchbgNBRyb6i4BLtkzoy4Et3BA-5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNiBTYWx0ZWRfXy8SBbaPR4RIP
 tedWM7+COBnMzpJi6+74K7bZqRIxJ8xZq8mim9sbyIu1RXRleDEgG2ir7YvzaIUXA/OYG+jvuKM
 1L6fj4f+XLmxzwdAhin9TrHkMBfASSI=
X-Proofpoint-GUID: sxzVDNJf6d89P3f8URrWrJYS87sx4rU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170116

On Thu, Sep 03, 2026 at 10:07:36AM -0700, Sean Christopherson wrote:
> On Thu, Sep 03, 2026, sashiko-bot@kernel.org wrote:
> > > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > > index 940c0ff668bee..f160e1945fbce 100644
> > > --- a/drivers/s390/crypto/vfio_ap_ops.c
> > > +++ b/drivers/s390/crypto/vfio_ap_ops.c
> > 
> > [ ... ]
> > 
> > > @@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
> > >  
> > >  /**
> > >   * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> > > - * to manage AP resources for the guest whose state is represented by @kvm
> > > + * to manage AP resources for the guest whose state is represented by
> > > + * @kvm_file
> > >   *
> > >   * @matrix_mdev: a mediated matrix device
> > > - * @kvm: reference to KVM instance
> > > + * @kvm_file: the KVM VM file this vfio device is associated with
> > >   *
> > > - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> > > + * Return: 0 if no other mediated matrix device has a reference to the VM;
> > >   * otherwise, returns an -EPERM.
> > >   */
> > >  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> > > -				struct kvm *kvm)
> > > +				struct file *kvm_file)
> > >  {
> > > +	struct kvm *kvm;
> > > +
> > > +	if (!kvm_file)
> > > +		return -ENOENT;
> > > +
> > > +	kvm = kvm_file->private_data;
> > > +	if (!kvm)
> > > +		return -ENOENT;
> > > +
> > >  	if (kvm->arch.crypto.crycbd) {
> > 
> > [Severity: Critical]
> > Does this code adequately verify that the file is an s390 KVM file before
> > casting its private_data in vfio_ap_mdev_set_kvm() inside
> > drivers/s390/crypto/vfio_ap_ops.c?
> > 
> > If a user instantiates a VM using a concurrent KVM-arm64 module and attaches
> > an s390-specific VFIO device to its KVM device, could this driver extract the
> > untyped private_data and mistakenly treat an arm64 struct kvm as an s390 one?
> > 
> > Because the memory layouts of struct kvm_arch differ across architectures,
> > would accessing s390-specific fields in the arch member (like
> > kvm->arch.crypto.pqap_hook) result in arbitrary memory corruption?
> 
> This is effectively the same concern I raised[1] in the s390+arm64 series:
> 
>  : Side topic #2, this entire approach seems extremely brittle unless you make it
>  : all but impossible for non-KVM code to get at KVM structure definitions.  Outside
>  : of KVM, all compilation units will see the s390 version of KVM structures.  Which
>  : is "fine", but obviously dangerous and IMO asking for maintenance issues down the
>  : road.
> 
> I don't think we need to go to the super extreme lengths I proposed[2] back when
> we were exploring multi-KVM on x86, but the direct dereference of ->private_data
> is a huge red flag.
> 
> Given that external usage of "struct kvm" should be *super* rare, and IMO is
> something we should actively discourage, I think we should make it opt-in.  Then
> at the same time, define the API so that it's arch-specific, e.g. to yield
> file_to_kvm_s390() so that drivers/s390/crypto/vfio_ap_ops.c can get exactly
> what it wants.
> 

yes, I was not happy with the ->private_data either. Thanks for finding
a solution. Simple is good. I only came up overly complex solutions I
did not like :) I will incoporate this. 

> Diff below, though it needs to be split into multiple patches (I'll respond with
> more to the full patch).

Amazing, thanks!

	Steffen
