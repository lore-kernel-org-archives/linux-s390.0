Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72B2C2ABF;
	Thu,  4 Sep 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979117; cv=none; b=OkfBz80jKVk5Ar4QoGT+FYWhCTsjOa/4pgmB+0vkbAeHJ+jM4qx+rhIGyUNUcluNQXgfdlQzMpOfmcRApA6IeFHHPilRH15XJiNe3KI49PkNzQxHW3zwHqgT9CnAA+PlBBIAPLGXly7z1m1XCAdUTnYNL18gKmiuHFtrPGsnXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979117; c=relaxed/simple;
	bh=lZHyHsUXDsGsrX6TebtAYsy3nBIcN7FY8vdQTq/1mTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz6FW3msG2Rk/di+wVGJPhSyJwEd1TZUD74wONETccXOh5zwYuX6604oe4fsua6PZiPAG4zPscLc7HXHNqxpcwm9xKpnxOWtSwHEF/1fwnLnZE0PE7bR6LB7mFOUhZRYbxdZa+HTzataRl5zjJHlJFJi+q+B09mkep0AI3s6s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBaoaFp2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBaoaFp2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5848XM1a017937;
	Thu, 4 Sep 2025 09:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=A0nA+PaBXyWTXSobLQojNRs9RU5X055I9qvx6crey0M=; b=NBaoaFp2vuji
	XX2Ou+a6MRy7xLbk6jAc3vQD6IQqylonLiDHTWR2KOco832V1+WblAjHtJnsG5oH
	th3zwEvCvHVsdKEHsVeXm38USHt2xi89MYKsuHjwxp64t+Wpb4gRq0gxOqkXXzV8
	iZnxJDSQsyV0ov9MlY6MNgjJnDhaJ9wFKwpT2YCIPsGimY2tRO2H71N+BL8PBMTX
	ZaZX0UiWed0RrKqUHtaX9zmW9pVPsMuxc3pCYw51mxkhDo22b2eWPSaEhwesy+c2
	r83Av+xJ0V2SbvxqJ1No9MiOAKdYPil/kVP6EstIhn7mPVD/aFCVd87xth34+HTw
	/7tDSVsEdw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur9f7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:45:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5848bEkX013942;
	Thu, 4 Sep 2025 09:45:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3kjnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:45:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5849j3Ch7864808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 09:45:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDA422004D;
	Thu,  4 Sep 2025 09:45:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2AC20040;
	Thu,  4 Sep 2025 09:45:03 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.197])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Sep 2025 09:45:03 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.98.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1uu6Wd-00000000Hql-1wez;
	Thu, 04 Sep 2025 11:45:03 +0200
Date: Thu, 4 Sep 2025 11:45:03 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/s390: Make attach succeed when the device was
 surprise removed
Message-ID: <20250904094503.GA23344@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904-iommu_succeed_attach_removed-v1-1-e7f333d2f80f@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX9Uf97TqOR7P7
 d6kEq/lzAOUGoNT2hzbd2VqLX1GDdkAvWRqIhfRtNNH7j1k7JRxw8tWwniNo4hfWcVHhZEn1jiR
 XApKuimdWTLSlXU1hCdPUcdHCKt7zJHHBMB5lNeFemZ5mKsStSmx/T/YdoPnNzForKxrM9TaWpS
 ydxNlt9EI4vYGEvaqegJAfKh/M49siqZPr0yjdUND7a4rISEe7OJ0CisHm/p+4v/EfhhE6ljA9s
 IUTVRJ7Mq/CXYfLKpVQRyWNWHDqo1VFGBxE8uko5xBmALSLwI4wYf03uu6CC0AMi/yFDtKjuXJq
 0UaDv4ZSnDEdrL7zLzOsA0JS3Pj0Ltj41ACaByZ1KPJusaTxAQ326OXj8cys21zrpmG/etWAXR5
 tz7fSXLd
X-Proofpoint-GUID: mARirreqmIRmdzxpAgjnFR0UX0q8JwGf
X-Proofpoint-ORIG-GUID: mARirreqmIRmdzxpAgjnFR0UX0q8JwGf
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b95fa4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8
 a=VnNF1IyMAAAA:8 a=f94wAlES5zcTxHjwagAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

On Thu, Sep 04, 2025 at 10:59:49AM +0200, Niklas Schnelle wrote:
> When a PCI device is removed with surprise hotplug, there may still be
> attempts to attach the device to the default domain as part of tear down
> via (__iommu_release_dma_ownership()), or because the removal happens
> during probe (__iommu_probe_device()). In both cases zpci_register_ioat()
> fails with a cc value indicating that the device handle is invalid. This
> is because the device is no longer part of the instance as far as the
> hypervisor is concerned.
> 
> Currently this leads to an error return and s390_iommu_attach_device()
> fails. This triggers the WARN_ON() in __iommu_group_set_domain_nofail()
> because attaching to the default domain must never fail.
> 
> With the device fenced by the hypervisor no DMAs to or from memory are
> possible and the IOMMU translations have no effect. Proceed as if the
> registration was successful and let the hotplug event handling clean up
> the device.
> 
> This is similar to how devices in the error state are handled since
> commit 59bbf596791b ("iommu/s390: Make attach succeed even if the device
> is in error state") except that for removal the domain will not be
> registered later. This approach was also previously discussed at the
> link.
> 
> Handle both cases, error state and removal, in a helper which checks if
> the error needs to be propagated or ignored. Avoid magic number
> condition codes by using the pre-existing, but never used, defines for
> PCI load/store condition codes and rename them to reflect that they
> apply to all PCI instructions.
> 
> Cc: stable@vger.kernel.org # v6.2
> Link: https://lore.kernel.org/linux-iommu/20240808194155.GD1985367@ziepe.ca/
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_insn.h | 10 +++++-----
>  drivers/iommu/s390-iommu.c       | 26 +++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 

Looks good to me; thanks Niklas.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
