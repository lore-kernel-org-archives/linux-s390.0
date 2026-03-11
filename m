Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115F13DDAA;
	Wed, 11 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234296; cv=none; b=C+3d1H4jDOSqqNLxAJteY2lBrIeVBdBUbgvPKZRXnuVX+uJFTqh9oXimNy6qkMoXRYw11gjxd9XzG6s9v16oSQJ5xxBUimBb4eWHTsT60hFF3o2eXoaOfi40cssQERWAiTyzFsUxwTICrN+Zwohx+3nQFfN1JCqqk888DOu0txU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234296; c=relaxed/simple;
	bh=4EGQ2reP10nQZYMb6lkCnlojp09WtDMjHX7jYM0cEy0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CYOWsh8FrExS4AhScy3uXveyF96TvDnveqlH/xBla9IVxANMy0M5N5P5vm6CE8k1wezxrcBwztY5bm97TxdwCvlyRwNd0G05hPEbASS7GUov9dtBQvuIwnDT/4VlEkQUf44gcfGb3/vmub+mfSvDl4MTA+tXddJJBOZxqlZKEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VL+0QG4J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VL+0QG4J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA9i43451596;
	Wed, 11 Mar 2026 13:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=98LEp5
	CSKNfw9BYO5yhiBIhlPwKu6gRATauk0GHZBlA=; b=VL+0QG4JwPE8a98yUp/zXQ
	OisjM0fQVQMMjAd8yvheBAiUdQwWOoAsFzJjkL7vR+32OIDgpwNoWXEvOF+dVJu1
	pA71JggARsO1txHZjVtVpvWDY3e5MfP+K4gArKWJ/609QQTPtN1fAxF4WX2gIza3
	6ksg2Vf4F+pT5DzT0wyn+R5LgdLPOwvjgDLP5aSMVy4upmh5mL/PbC3Nw9uceM/C
	0emtZ0Qyr0CGes+GA/AnGO8JBA4uxayby31iReHvt45l2NAeYyvDUPoaNhJLYy4a
	/mxYfiGOX5FX2MpLAWUC9R+rZaMJTMdtBy5gZSaui57m0TUl1RUjWbiAcUefDvVg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywfxdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBSdDS021181;
	Wed, 11 Mar 2026 13:04:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbswmks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:04:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BD4klN1114668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:04:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BA865805A;
	Wed, 11 Mar 2026 13:04:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97FF5805F;
	Wed, 11 Mar 2026 13:04:42 +0000 (GMT)
Received: from [9.111.27.49] (unknown [9.111.27.49])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 13:04:42 +0000 (GMT)
Message-ID: <6c13dd5e0b7650abc008aa3b8981786f094efc73.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Alex Williamson <alex@shazbot.org>, Julian Ruess <julianr@linux.ibm.com>
Cc: wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas	
 <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin
 Tian	 <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <20260310132015.6e4453be@shazbot.org>
References: <20260305-vfio_pci_ism-v3-0-1217076c81d9@linux.ibm.com>
		<20260305-vfio_pci_ism-v3-2-1217076c81d9@linux.ibm.com>
	 <20260310132015.6e4453be@shazbot.org>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 14:03:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMCBTYWx0ZWRfX70LkzFFXWfNE
 q+KzIEtcSAT8t1CU/wIaLvISSobkUIr/Kzxge5SaHkX6Twra+buxR7BT6COTZPkivyFpAj+6e3y
 PdewYp91Oe3qhGWXCDuNoNYRS2KkcEvfgvlXI/s8h6pAixpm1Ecz5Ciyjsrssu36yVG2XWLTSTB
 cAtRQZK8ORPOdjiDRibOGN4r6YBQ+0hmsSfmO9Su38STT03sysKYWaQtL4KHxPPVPBvtnazdSwN
 AH/TRgqqVdb4ti9mgCBj4qpfG06fbI+rQ0JkqL9brw3sL+7ZoBnjkIYR5ZgYI62HtrVTr3VgCnm
 vZV9jytcWmmzSdFjCu9lkqFyFFfIL8Dy2jqfsaFdcowRNlcHCPRBNCmjP8IZzFvVFV1KNUfakNE
 3PMkq16CLUQqFT83y0dw4pj0VCPDr884iQO8s8BF8vQVqQ1h8iLwZAapJUx9iYqHadrY0e0Kfpq
 l1YPq6gZTs9FqPTkj2A==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b16870 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=iExcyH4Xor4oW9lXfNEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ml7YYkLcb8bargZMeWRuJRtUawup0qBT
X-Proofpoint-ORIG-GUID: Ml7YYkLcb8bargZMeWRuJRtUawup0qBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110110

On Tue, 2026-03-10 at 13:20 -0600, Alex Williamson wrote:
> On Thu, 05 Mar 2026 13:20:14 +0100
> Julian Ruess <julianr@linux.ibm.com> wrote:
>=20
> > Add a vfio_pci variant driver for the s390-specific Internal Shared
> > Memory (ISM) devices used for inter-VM communication.
> >=20
> > This enables the development of vfio-pci-based user space drivers for
> > ISM devices.
> >=20
> > On s390, kernel primitives such as ioread() and iowrite() are switched
> > over from function handle based PCI load/stores instructions to PCI
> > memory-I/O (MIO) loads/stores when these are available and not
> > explicitly disabled. Since these instructions cannot be used with ISM
> > devices, ensure that classic function handle-based PCI instructions are
> > used instead.
> >=20
> > The driver is still required even when MIO instructions are disabled, a=
s
> > the ISM device relies on the PCI store block (PCISTB) instruction to
> > perform write operations.
> >=20
> > Stores are not fragmented, therefore one ioctl corresponds to exactly
> > one PCISTB instruction. User space must ensure to not write more than
> > 4096 bytes at once to an ISM BAR which is the maximum payload of the
> > PCISTB instruction.
> >=20
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> > ---
> >=20
--- snip ---
> >=20
> > +static ssize_t ism_vfio_pci_do_io_r(struct vfio_pci_core_device *vdev,
> > +				    char __user *buf, loff_t off, size_t count,
> > +				    int bar)
> > +{
> > +	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> > +	ssize_t ret, done =3D 0;
> > +	u64 req, length, tmp;
> > +
> > +	while (count) {
> > +		if (count >=3D 8 && IS_ALIGNED(off, 8))
> > +			length =3D 8;
> > +		else if (count >=3D 4 && IS_ALIGNED(off, 4))
> > +			length =3D 4;
> > +		else if (count >=3D 2 && IS_ALIGNED(off, 2))
> > +			length =3D 2;
> > +		else
> > +			length =3D 1;
> > +		req =3D ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, length);
> > +		/*
> > +		 * Use __zpci_load() to bypass automatic use of PCI MIO instructions
> > +		 * which are not supported on ISM devices
> > +		 */
> > +		ret =3D __zpci_load(&tmp, req, off);
> > +		if (ret)
> > +			return ret;
> > +		if (copy_to_user(buf, &tmp, length))
>=20
> Is there an endian issue here for 1/2/4 byte reads?  zpci_read_single()
> uses a u64 target for zpci_load(), but then casts the result into the
> destination buffer to place the low-order bytes.  AIUI, copy_to_user()
> would start from the high-order bytes of the u64.

Great find Alex, thank you! One should think that us s390 people would
be the ones extra careful with Endianess. I did a bit of digging how
this slipped through our review process and it seems we actually had it
right up to our internal v5 using a macro generated ism_read##size()
and using a temporary u##size. Then we messed up pulling the
copy_to_user() out of the individual ism_read() macros which then got
eliminated still without noticing the endianess issue. We actually also
don't need the sizes < 8 in the current user-space driver so didn't
notice in testing either. And as a side note LLM review also didn't
catch it. So unless vfio-pci requires reads < 8 bytes to work we'd opt
to just support the 8 byte case.

>=20
> > +			return -EFAULT;
> > +		count -=3D length;
> > +		done +=3D length;
> > +		off +=3D length;
> > +		buf +=3D length;
> > +	}
> > +	return done;
> > +}
--- snip ---
> > +
> > +static int ism_vfio_pci_probe(struct pci_dev *pdev,
> > +			      const struct pci_device_id *id)
> > +{
> > +	struct ism_vfio_pci_core_device *ivpcd;
> > +	struct zpci_dev *zdev =3D to_zpci(pdev);
> > +	int ret;
> > +
> > +	ivpcd =3D vfio_alloc_device(ism_vfio_pci_core_device, core_device.vde=
v,
> > +				  &pdev->dev, &ism_pci_ops);
> > +	if (IS_ERR(ivpcd))
> > +		return PTR_ERR(ivpcd);
> > +
> > +	store_block_cache =3D kmem_cache_create("store_block_cache",
> > +					      zdev->maxstbl, 0, 0, NULL);
> > +	if (!store_block_cache)
> > +		return -ENOMEM;
>=20
> ivpcd is leaked here, we need a vfio_put_device().  Thanks,
>=20
> Alex

Good find again. For completeness we also noticed another issue here in
internal review. The store_block_cache gets replaced and the old one
leaked when multiple devices are used with this driver. So we'll likely
go to a per-device kvmem_cache in v4.

>=20
> > +
> > +	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
> > +	ret =3D vfio_pci_core_register_device(&ivpcd->core_device);
> > +	if (ret) {
> > +		kmem_cache_destroy(store_block_cache);
> > +		vfio_put_device(&ivpcd->core_device.vdev);
> > +	}
> > +
> > +	return ret;
> > +}
> >=20
