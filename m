Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDE3BB9EF;
	Fri, 20 Mar 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015000; cv=none; b=ab8OGsStw0f0tp5ieQvMcCMJVkRlB1Af3H/1OU9112XZKhhx5verV2fXpTjzsmVFmpwKp+b30yR2JWCJXoZFr4ekhieLIcvbLMD1lpbEDcdzu5tgzqanMh6Tm4YRocyNR3r4XKGAhRVNl8mgWOa37QXxQAvVL7gC2jz6HspLVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015000; c=relaxed/simple;
	bh=tX6/W1A1kEXtwqb5ckMUXhUASfg0SQDSZtu9TEzvcHY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rJYsbrYSG8telh9X5UCdGbUrZiDgVI2LbZ/mSeWZKRQZQeTbyAZ32IldsFfS8idgBVFMRf8UA93uT01vjE72SrHOs8Gtf5ZhCCkISmnhJq0DvJvU/6mhJ2daY74RvlrobKjov5GNqhyMxF10X2uMY2iDQmrmUXUoD3ImXS/+c10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s63zTc9F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s63zTc9F"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KDWgsI3853770;
	Fri, 20 Mar 2026 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iQwT3N
	4Hti2sP5fljFNWHjvaqT49hVkYTsFhEhfnakA=; b=s63zTc9FF70zI5/JTbs9R/
	3tk/Bqudd1mYMDmIBZ04nD8KlTHrW2NUQjAihqP4Dt6nShu9eZ1ncCW/MlqEgC0E
	AbiTFyNjJMMFrLiQ9NLZRgY5+QipnIbuAoESITTxNDEexHls69Ns2QR/aV6gD4AH
	LAVrrR3EttS/I2mr3/LgRe7NRuqdkhYwKl/yCTf9lB9xFkbmsysfsAUEN8JWCuME
	GjtzABGltcmhH206hwrBjutIZ9Djed6HpHKTEgIVWiBcVg4qps5nGFbb51sFLAvt
	curXttMG64FHzEMoP1W58mMXy1N/ddaMAPULRaQOYdGSyr5QRLDl/CI8sU2sp8AQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybskv74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:56:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KC3rC3013987;
	Fri, 20 Mar 2026 13:56:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyffcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:56:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KDuP1v21234218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 13:56:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4772C58056;
	Fri, 20 Mar 2026 13:56:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399AC5805A;
	Fri, 20 Mar 2026 13:56:22 +0000 (GMT)
Received: from [9.111.12.113] (unknown [9.111.12.113])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 13:56:22 +0000 (GMT)
Message-ID: <d9930a51099574eb45b9194b5249bf637cb04f31.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex
 Williamson	 <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai
 Hadas	 <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian	 <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <DH7NFCRHDMI3.1S64YUGRBH7O8@linux.ibm.com>
References: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
	 <20260319-vfio_pci_ism-v6-2-c6bab675bc0a@linux.ibm.com>
	 <18f44f67f096e0003d4083da20e2ace4c118c2f4.camel@linux.ibm.com>
	 <DH7NFCRHDMI3.1S64YUGRBH7O8@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Mar 2026 14:55:21 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bd520b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=HAAw3tWQj_t11YiA66sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -jKIIKZX4Gm0mQukSm7UHEcS8dRAV1j0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwOSBTYWx0ZWRfXwLsro+ShjsBT
 1Aa2PZXAy0mYBJvhdircDeIX2m2Po05gbH6zli1uPEPxm0v+Cdys2la1XtA5d7OArH+WyOgdKEo
 C4qXLYXv2VSEnaB4MWe1cVh1nBnMQbuNEodNwtHIPmOXmn2PN1DQ5g/MCllK2PMzRixRV6Ar9xk
 3LF/ffuqUD2of7OaVFfy2bZluRdhjk1SRJedv7xDkdiVFGjOleYdeseXCX4Mao0M5y1Hxhh6WZt
 g0NHzA68Tq/pft0vqcMBEWvn4N8mimsA2pq6O9JU5i1T0I2i8agV4rFWjz05MRyBBrkX+YnuRV6
 N1A7olxuYx62ua/OS2WplYQhPcpnwqT4KW3ELjRjCk5i8Av4crh4bTD6o5cv2XN3SPmc7/UMKHs
 k32zn3BdB5mOFqN69+/SCUVlh5HaOPWUiekvt+XujwDrskG5UtWormQPHUUFDXW/qpgNmB7aOHl
 wniwqbthn+GP+m/Wnkg==
X-Proofpoint-GUID: -jKIIKZX4Gm0mQukSm7UHEcS8dRAV1j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200109

On Fri, 2026-03-20 at 14:37 +0100, Julian Ruess wrote:
> On Fri Mar 20, 2026 at 1:54 PM CET, Niklas Schnelle wrote:
> > On Thu, 2026-03-19 at 16:42 +0100, Julian Ruess wrote:
> > > Add a vfio_pci variant driver for the s390-specific Internal Shared
> > > Memory (ISM) devices used for inter-VM communication.
> > >=20
> > > This enables the development of vfio-pci-based user space drivers for
> > > ISM devices.
> > >=20
> > > On s390, kernel primitives such as ioread() and iowrite() are switche=
d
> > > over from function handle based PCI load/stores instructions to PCI
> > > memory-I/O (MIO) loads/stores when these are available and not
> > > explicitly disabled. Since these instructions cannot be used with ISM
> > > devices, ensure that classic function handle-based PCI instructions a=
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
> > > Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> > > ---
> > >  drivers/vfio/pci/Kconfig      |   2 +
> > >  drivers/vfio/pci/Makefile     |   2 +
> > >  drivers/vfio/pci/ism/Kconfig  |  10 ++
> > >  drivers/vfio/pci/ism/Makefile |   3 +
> > >  drivers/vfio/pci/ism/main.c   | 400 ++++++++++++++++++++++++++++++++=
++++++++++
> > >  5 files changed, 417 insertions(+)
> > >=20
> >=20
> > As a general note, ISM devices do not support any low power/sleep modes
> > which is why there is no PM handling done.
> >=20
> > > +
> > > +/*
> > > + * ism_vfio_pci_do_io_w()
> > > + *
> > > + * Ensure that the PCI store block (PCISTB) instruction is used as r=
equired by the
> > > + * ISM device. The ISM device also uses a 256 TiB BAR 0 for write op=
erations,
> > > + * which requires a 48bit region address space (ISM_VFIO_PCI_OFFSET_=
SHIFT).
> > > + */
> > > +static ssize_t ism_vfio_pci_do_io_w(struct vfio_pci_core_device *vde=
v,
> > > +				    char __user *buf, loff_t off, size_t count,
> > > +				    int bar)
> > > +{
> > > +	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> > > +	struct ism_vfio_pci_core_device *ivpcd;
> > > +	ssize_t ret;
> > > +	void *data;
> > > +	u64 req;
> > > +
> > > +	if (count > zdev->maxstbl)
> > > +		return -EINVAL;
> > > +	if (((off % PAGE_SIZE) + count) > PAGE_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	ivpcd =3D container_of(vdev, struct ism_vfio_pci_core_device,
> > > +			     core_device);
> > > +	data =3D kmem_cache_alloc(ivpcd->store_block_cache, GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	if (copy_from_user(data, buf, count)) {
> > > +		ret =3D -EFAULT;
> > > +		goto out_free;
> > > +	}
> > > +
> > > +	req =3D ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, count);
> > > +	ret =3D __zpci_store_block(data, req, off);
> >=20
> > Note: There is a Sashiko finding that PCI Store Block needs 8 byte
> > alignment and we don't ensure that off is 8 byte aligned here. While
> > generally true the ISM device has relaxed alignment rules and this
> > requirement does not apply. That said we should set PAGE_SIZE alignment
> > on the kmem_cache such that data is guaranteed PAGE_SIZE aligned and
> > the page crossing check works correctly.
> >=20
> > > +	if (ret)
> > > +		goto out_free;
> > > +
> > > +	ret =3D count;
> > > +
> > > +out_free:
> > > +	kmem_cache_free(ivpcd->store_block_cache, data);
> > > +	return ret;
> > > +}
> > > +
> > --- snip ---
> >=20
> > > +
> > > +static int ism_vfio_pci_init_dev(struct vfio_device *core_vdev)
> > > +{
> > > +	struct zpci_dev *zdev =3D to_zpci(to_pci_dev(core_vdev->dev));
> > > +	struct ism_vfio_pci_core_device *ivpcd;
> > > +	char cache_name[20];
> > > +	int ret;
> > > +
> > > +	ivpcd =3D container_of(core_vdev, struct ism_vfio_pci_core_device,
> > > +			     core_device.vdev);
> > > +
> > > +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->f=
id);
> > > +	ivpcd->store_block_cache =3D
> > > +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
> >=20
> > Sashiko notes here that the cache_name is stack allocated and says that
> > kmem_cache_create() doesn't copy it. Looking at
> > __kmem_cache_create_args() however this seems to be not true as that
> > does krstrdup_const() on the passed-in name.
>=20
> I think we should change this to:
>=20
> ivpcd->store_block_cache =3D kmem_cache_create(
>        cache_name, zdev->maxstbl, PAGE_SIZE,
>        (SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT | SLAB_PANIC), NULL);
>=20
> The alignment ensures that we do not cross the integral boundary, and as
> Sashiko said, memcg accounting is also useful here.

We definitely do *not* want to panic when kmem_cache_create() fails,
that would take down the whole kernel just for a PCI device! The others
make sense though I'm not sure if SLAB_RECLAIM_ACCOUNT needs other
setup.

Thanks,
Niklas
