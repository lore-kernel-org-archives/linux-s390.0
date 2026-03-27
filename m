Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763733FA5F0;
	Fri, 27 Mar 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623292; cv=none; b=YInOgaWWNnf6SBg3kmFqpa5vmuQcDgrnq8fTX6uTvMe9FjeVqsVVYnPS3774zvZDQ9aHyzAbdyFwJ6B49UqRypw9zns9ojtKemuMrmhpsXJRTQqoSQyHwiY6zCGuRAAES+t/bYCsUuOSCnZaGYQkyxtYD8T0RERVxOiutFb4Uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623292; c=relaxed/simple;
	bh=sBDkQZ0IMKKrYQG4KzoUcctk38Cd+7kL8vp1ws6Ti9I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=s4JFHl4FUejqQVxI3NCnDgKm+0oLDoLtIhA8lAvbeQGnhGmk/eq2mt6sLbp+k+/VZHkNVJgAJfeeHf7OqGs2EhVJ8B6apqF8/mt5j+pe86Hd3Bl9R+p/EO9Rl4Yn8lwKJdqkAWNTRrW3e1RIRgEc3ofSn2lYIaeh/MQGlZ6ITz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SbHV+1eM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SbHV+1eM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R5hLVN196681;
	Fri, 27 Mar 2026 14:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wwr6oR
	7eBM1GT1fLWWpsP40CvLQOt/4IGzocrdyOk0k=; b=SbHV+1eMq4OxA02yjl0NCN
	dqMI0gY6PZhARXtHEsrobKbTzomJEJr9In4rB5vCCB6IuixIqKUoNa5M9neNCvXG
	uX+eXdnymM9yeLrm6nBqsBSmLQ16eovjEeo/MxIBo4JnoEO3FI10YJYupXdN8Hpl
	PHR64Ap94SQIbp9d8vLSPDw9oDxfDKUyoJBp70qIwqqJEGa6TLz91PrnVWIP1t59
	puEA1gk2NslXBIrQHzMTs2VZgCOrfPr2pffhJlUxEBANMq7NDKWSc0NYZmVWdw2H
	uvQuMpXWNf+JC/fHf2RLZ0PqF0HGK6UJ9ExXM2o2AivKgietpqi5Eyd8RIOjOIeg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kun1jw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 14:54:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62REq86L005972;
	Fri, 27 Mar 2026 14:54:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d262000se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 14:54:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62REsYGo4653948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 14:54:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 578C058062;
	Fri, 27 Mar 2026 14:54:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2608958059;
	Fri, 27 Mar 2026 14:54:31 +0000 (GMT)
Received: from [9.111.77.47] (unknown [9.111.77.47])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 14:54:30 +0000 (GMT)
Message-ID: <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe	
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum	
 <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Mar 2026 15:53:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UG4dm3Y2oBhExZJg3MheE7j3O2b8zM80
X-Proofpoint-ORIG-GUID: UG4dm3Y2oBhExZJg3MheE7j3O2b8zM80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwMiBTYWx0ZWRfX8b1H2eNq0rpR
 1V0JcIDvmlp0CVODbbKu9QnMiPkiuUlV4uFoFE+JKp66O3x3CIu4gFvs2CeoLbL39N7zT8MOFGf
 0MzUDolRGn49RTW7aBikc5rO8F0Q0fD6nzZchUxgsL4USFjMgxhvudWV9JJFixCidIkTD3pqA96
 EzGheOLKJ4NkkKzxVA9ZGVVY2oJ5zRTRdfCdIW1nwgyFniIxsxobIyzHCIdLy0yDm52UE2yqDuw
 JPwP5JXG//WYWxQGkx9vn1wcxUguKv+S5NCidXJ6csFDfLHESMesDGDICBFcDLe4f26PBfWZcnb
 oUOnoCSeFOolAt5/M5zrlQgVq590AomFmRDNdOTFdSDgivSxqxuvUmH8r5lvk1X+qXRMkzqPHgS
 6Ukz2cn8jvBUw6vW2jYmcPhIbgbsgbcbHysG7UykLlbIUxLpYgm4mK+9GwkausFJFxi6rcCZhnf
 0yeI66nJchW29YRdl6Q==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c69a2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pcDmQ4xKrVFVuDfWhAIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270102

On Thu, 2026-03-26 at 12:05 -0700, Farhan Ali wrote:
> On 3/26/2026 6:03 AM, Niklas Schnelle wrote:
> > On Wed, 2026-03-25 at 14:31 +0100, Julian Ruess wrote:
> > > Add a vfio_pci variant driver for the s390-specific Internal Shared
> > > Memory (ISM) devices used for inter-VM communication.
> > >=20
> > > This enables the development of vfio-pci-based user space drivers for
> > > ISM devices.
> > >=20
> > > On s390, kernel primitives such as ioread() and iowrite() are switche=
d
> > > over from function-handle-based PCI load/stores instructions to PCI
> > > memory-I/O (MIO) loads/stores when these are available and not
> > > explicitly disabled. Since these instructions cannot be used with ISM
> > > devices, ensure that classic function-handle-based PCI instructions a=
re
> > > used instead.
> > >=20
> > > The driver is still required even when MIO instructions are disabled,=
 as
> > > the ISM device relies on the PCI store block (PCISTB) instruction to
> > > perform write operations.
> > >=20
> > > Stores are not fragmented, therefore one ioctl corresponds to exactly
> > > one PCISTB instruction. User space must ensure to not write more than
> > > 4096 bytes at once to an ISM BAR which is the maximum payload of the
> > > PCISTB instruction.
> > >=20
> > > Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> > > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> > > ---
> > >   drivers/vfio/pci/Kconfig      |   2 +
> > >   drivers/vfio/pci/Makefile     |   2 +
> > >   drivers/vfio/pci/ism/Kconfig  |  10 ++
> > >   drivers/vfio/pci/ism/Makefile |   3 +
> > >   drivers/vfio/pci/ism/main.c   | 408 +++++++++++++++++++++++++++++++=
+++++++++++
> > >   5 files changed, 425 insertions(+)
> > >=20
> > --- snip ---
> > > +
> > > +static int ism_vfio_pci_ioctl_get_region_info(struct vfio_device *co=
re_vdev,
> > > +					      struct vfio_region_info *info,
> > > +					      struct vfio_info_cap *caps)
> > > +{
> > > +	struct vfio_pci_core_device *vdev =3D
> > > +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> > > +	struct pci_dev *pdev =3D vdev->pdev;
> > > +
> > > +	switch (info->index) {
> > > +	case VFIO_PCI_CONFIG_REGION_INDEX:
> > > +		info->offset =3D ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> > > +		info->size =3D pdev->cfg_size;
> > > +		info->flags =3D VFIO_REGION_INFO_FLAG_READ |
> > > +			      VFIO_REGION_INFO_FLAG_WRITE;
> > > +		break;
> > > +	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
> > > +		info->offset =3D ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> > > +		info->size =3D pci_resource_len(pdev, info->index);
> > > +		if (!info->size) {
> > > +			info->flags =3D 0;
> > > +			break;
> > > +		}
> > > +		info->flags =3D VFIO_REGION_INFO_FLAG_READ |
> > > +			      VFIO_REGION_INFO_FLAG_WRITE;
> > > +		break;
> > > +	default:
> > > +		info->offset =3D 0;
> > > +		info->size =3D 0;
> > > +		info->flags =3D 0;
> > > +		return -EINVAL;
> > Thinking more about this, the above default handling actually breaks
> > additional regions such as the one added by Farhan for the error
> > events. I think this needs to instead call the generic
> > vfio_pci_ioctl_get_region_info() for other regions.
>=20
> Note for error events we are using a VFIO device feature and not a=20
> region. At this point we actually don't have additional regions. I do=20
> agree that if we were to add a zpci specific region we would need to=20
> update here and ism_vfio_pci_rw() to allow region read/write ops. This=
=20
> ISM driver would also need to support all the possible callbacks in=20
> struct vfio_pci_regops.
>=20
> Given that we don't have any additional regions yet, I am conflicted if=
=20
> it makes sense to add all the code to support additional regions without=
=20
> a good way to test it. Maybe its something we can defer when if we add=
=20
> additional regions? Thanks
>=20
> Farhan

@Alex, we experimented a bit and it turns out with the custom
ISM_VFIO_PCI_OFFSET_SHIFT it becomes quite tricky to reliably call into
common vfio-pci code for handling other regions as that again relies on
the normal VFIO_PCI_OFFSET_SHIFT.

So we came up with two options:

1) vfio-pci-ism will only support this basic set of regions. It seems
to us that new extensions like Farhan's error events should use device
features anyway, so this to us seems like an acceptable limitation and
would essentially mean we take this patch as is.

2) We revisit the original idea of adjusting VFIO_PCI_OFFSET_SHIFT
globally but do so only for CONFIG_64BIT so as not to break 32 bit
platforms. This would simplify vfio-pci-ism and cause less code
duplication but also affects everyone else.

Either option works for us, so I'm hoping for your input.

Thanks,
Niklas
