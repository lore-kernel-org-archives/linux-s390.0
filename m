Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980432E121;
	Tue, 17 Mar 2026 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782262; cv=none; b=Y2MUZhhb5+iv8ME2bjSuaq2nSmirIL5ZnE5EFcRrGK/Zk+8grZ1fgnjUDRToSKp5ktnjnoLwQlm03v3W61lGecg8oeHWXAalPaZCi1b2C9bdmvGCnWTTlpMuPgTd9sZvvyp1F7Os9VrMAjcynrG71LJ+0WD8yZnBXO1l81qtBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782262; c=relaxed/simple;
	bh=NMV5iN3F/IQSdli0Fw1nMlOi1xmPuXcYuWMEHszoD9o=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CyANGjzN6GSK0ro7X0dp5zPUUYIUmABIfOYOXOk/HXQvXi1avfvK6Jdfx2az+PjG5g/IlvUx/zX/wTxrTn1hliS0MOmvZzPAylulGtPjjO2ypoOwxZwHSJmWhQBIvg0t1rcIYJn1TpwCyaNj+lnaBXS6Qs/2Avz01rMxsQ+lqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LYZyOkla; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LYZyOkla"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HCdMhV2722906;
	Tue, 17 Mar 2026 21:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vd2fQN
	7yxeYG+o7GsQ+qcYT92WS0W8C7v34ki/Kfiy4=; b=LYZyOklaJXswGDJzHupK7L
	z9/ZmNOUfw5gb9R9VOiYEeXdwpu3hnB4uAcTNsI4bdwqrFc7F0+9tH8RpoO1Tl5k
	jNaeD8TIZasT9tfaigsYy/QQZ09dSBPU3bNzYQbEWsUrpcymaPutZ1L+raRpsBv/
	W6LPKeRrHfDRG3FpA6U7kLz0Y0JPbgULudXyVXqmk0j9z/35W+wk443gnK/qmtSP
	Dy/SrGXKFNf0R0cVjknCl274p1JvAjGorRBf0CkZ1If4C57w4UiaB11G4LwbLpdQ
	ngePVaQUQG/M8yrtMO95vqR7JWzt+ruODvuLbF/9fYIkMHuESdNQclePTkwT+0qw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaue9nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 21:17:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HIrODN014033;
	Tue, 17 Mar 2026 21:17:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy344n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 21:17:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HLHA4h1376866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 21:17:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22C9458065;
	Tue, 17 Mar 2026 21:17:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 253F258052;
	Tue, 17 Mar 2026 21:17:30 +0000 (GMT)
Received: from [9.111.4.94] (unknown [9.111.4.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 21:17:29 +0000 (GMT)
Message-ID: <ef044e7fa28e33cf865882e374957c0cd10124d1.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] vfio/ism: Implement vfio_pci driver for ISM
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
In-Reply-To: <de08911a-8bcc-4983-9ad2-b20467ebbb7f@linux.ibm.com>
References: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
	 <20260317-vfio_pci_ism-v5-2-b73248b4e576@linux.ibm.com>
	 <de08911a-8bcc-4983-9ad2-b20467ebbb7f@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 22:16:28 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE4NyBTYWx0ZWRfX3VtMFDG4SqcK
 n3Up6YGCiV394EtAn2+O4SwHBRT3xxoRSaT7Ii2HMX/T8r5e6Vpl1tlZVIrltRvvNh6IG7uyMR4
 VKfx+9VAKnI3RMwfs3FrEF+wlDj7davKqmkKDgeTQAs1vfAuIc1ai/RExVqaOIYhN7bHC6btLj0
 5a4LqiQV863810B6dM9s9EFEIdvMQq2KcluqZSCfndE2HEKTK+jk4IGblt6kqegxOuuEP+uF8cW
 Z/QHmrXu6r6ZAzgREhHrJzy4fZxJpNPXzcx6EAHsy2hFQno1/wquKDgzRqGD8b28J9SYuOopo67
 UrRFOkFts+KCuJEMteNr8X14RQh05Cj6YtkKSZneTm9nBbg4m+wfF8sTGpzhr2Z1BRpRiPlLDFz
 RSDmIpSb5fan7U7xOKeKveUvzXk8GBaY0xhRUOH7r5q9rwHK6G6IuCyRr5cSFufZ+mnTLs0dnSB
 2rCV0xQzwPyj3YB3Nog==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b9c4ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=kLfGYDRZCHAAhUMf1BcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CNADl5zxtaFpTQg4S4Il7TP7f4NpAWo-
X-Proofpoint-GUID: CNADl5zxtaFpTQg4S4Il7TP7f4NpAWo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170187

On Tue, 2026-03-17 at 11:43 -0700, Farhan Ali wrote:
> <..snip..>
>=20
> On 3/17/2026 5:58 AM, Julian Ruess wrote:
> > static int ism_vfio_pci_probe(struct pci_dev *pdev,
> > +			      const struct pci_device_id *id)
> > +{
> > +	struct ism_vfio_pci_core_device *ivpcd;
> > +	struct zpci_dev *zdev =3D to_zpci(pdev);
> > +	char cache_name[20];
> > +	int ret;
> > +
> > +	ivpcd =3D vfio_alloc_device(ism_vfio_pci_core_device, core_device.vde=
v,
> > +				  &pdev->dev, &ism_pci_ops);
> > +	if (IS_ERR(ivpcd))
> > +		return PTR_ERR(ivpcd);
> > +
> > +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid=
);
> > +	ivpcd->store_block_cache =3D
> > +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
> > +	if (!ivpcd->store_block_cache) {
> > +		vfio_put_device(&ivpcd->core_device.vdev);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
> > +	ret =3D vfio_pci_core_register_device(&ivpcd->core_device);
> > +	if (ret) {
> > +		kmem_cache_destroy(ivpcd->store_block_cache);
> > +		vfio_put_device(&ivpcd->core_device.vdev);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void ism_vfio_pci_remove(struct pci_dev *pdev)
> > +{
> > +	struct vfio_pci_core_device *core_device;
> > +	struct ism_vfio_pci_core_device *ivpcd;
> > +
> > +	core_device =3D dev_get_drvdata(&pdev->dev);
> > +	ivpcd =3D container_of(core_device, struct ism_vfio_pci_core_device,
> > +			     core_device);
> > +
> > +	vfio_pci_core_unregister_device(&ivpcd->core_device);
> > +	vfio_put_device(&ivpcd->core_device.vdev);
> > +
> > +	kmem_cache_destroy(ivpcd->store_block_cache);
>=20
> I think the kmem_cache_destroy() should be done before we do=20
> vfio_put_device() (or maybe even before=20
> vfio_pci_core_unregister_device()) to avoid use after free similar to=20
> ism_vfio_pci_probe(). Sorry I missed this earlier.
>=20
> Thanks
>=20
> Farhan
>=20

Good find! Wouldn't it be even cleaner to provide vfio/ism specific
.init and .release functions in ism_pci_ops that do the
kmem_cache_create() / kmem_cache_destroy() as part of init / release?
It seems this is done for e.g. Xe with xe_vfio_pci_init_dev()
and xe_vfio_pci_release_dev(). In fact wouldn't that be even necessary
to correctly handle the case where the above vfio_put_device() isn't
the last reference?

Thanks,
Niklas
