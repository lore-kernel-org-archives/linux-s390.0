Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2B8462;
	Wed, 18 Mar 2026 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814591; cv=none; b=IcwP1cQPlU6Fr2JeXdfrmpfV1QNOqxglz7L8E0QNycHvoMG3wXZKqqYu2IROQeozgds8o02KAIIPEUgrdtjt2HraJfMBCUXHtLGp7KbNSO9Q4axgUbAG3ABYhU52g49yDzSse+4lrUIpA89flIN1mT8sDaTNKkS4lIvdY36pDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814591; c=relaxed/simple;
	bh=oDnlMW+yrl3kxEDV1Uxuwpsrw8lOvDpiu3LAZZ2bpIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=i7H2eSQGZPLPk/VFgLN0W67viuvlwjgU7vLJy//fJBJpZrZckXAhc2hxUJMc0N+ThXV0/Ap524yGJr5k3WxLayl4ARZvAo28tHBqFdU1y9RZUi/E3FdW3GveEukXtjxQ1ATI0eRieECYxLmd7XRJUGHSSj4CXUUmW971z3IgA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iS1zN2AE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iS1zN2AE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I601hr3176840;
	Wed, 18 Mar 2026 06:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DifgUe
	WpE4npuUkNsLjMpFr/mxGVgkbz/vAv+BrXPtg=; b=iS1zN2AE2pgOS9fEDNhy03
	MhmglpDq6czo7tzl6o+xaoyqJfkk3EXeG/+jfnfHt1qMx1N5nswNWv2rxzKGoHNs
	bC94db4scXeHUX63WB6pxxyfvQMe/oeaF4QSF865CELrGVMoQKzrnejYuBjORiMw
	JoYf+W1kR4TJ3T5SqF5AZes5maI5la8nqpKJ+YB89KCuf0JDuexCE4/6+eV57QWe
	1wVaCq8+qUGL3S5T2yr6lq6yEOaSnLTw4B81yBzPnX9CBXm0nAU3wNouNWMxoNmb
	w9e3+TUKr7kSstQcxmGe7RCG0RomX6/iFHJnSjOow/Lk+CMPexGHhiD612pAoBTA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cyw3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:16:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I5jBUb032327;
	Wed, 18 Mar 2026 06:16:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jvgw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 06:16:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I6GDLZ39059714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 06:16:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61BC72004B;
	Wed, 18 Mar 2026 06:16:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2963B20043;
	Wed, 18 Mar 2026 06:16:12 +0000 (GMT)
Received: from localhost (unknown [9.111.43.66])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 06:16:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 07:16:11 +0100
Message-Id: <DH5OSCR30K6L.3SIBYOZ6166AC@linux.ibm.com>
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Farhan Ali"
 <alifm@linux.ibm.com>,
        "Julian Ruess" <julianr@linux.ibm.com>, <wintera@linux.ibm.com>,
        <ts@linux.ibm.com>, <oberpar@linux.ibm.com>, <gbayer@linux.ibm.com>,
        "Alex Williamson" <alex@shazbot.org>,
        "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Yishai Hadas" <yishaih@nvidia.com>,
        "Shameer
 Kolothum" <skolothumtho@nvidia.com>,
        "Kevin Tian" <kevin.tian@intel.com>
Cc: <mjrosato@linux.ibm.com>, <raspl@linux.ibm.com>, <hca@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <gor@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
 <20260317-vfio_pci_ism-v5-2-b73248b4e576@linux.ibm.com>
 <de08911a-8bcc-4983-9ad2-b20467ebbb7f@linux.ibm.com>
 <ef044e7fa28e33cf865882e374957c0cd10124d1.camel@linux.ibm.com>
In-Reply-To: <ef044e7fa28e33cf865882e374957c0cd10124d1.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba4332 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=yDXdNYyLDAtsUWoxkjsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1MSBTYWx0ZWRfX0KT5g6jHbLCN
 JS79k+9K0j2YW2GmxHMyXw6jPBJR9dGI3D+4PbIxS+N1q6PpY/JQeSzEyAFCBl27K7kCtBzwJIS
 4tVxIf97jF+JVqysFpV6qIhkYgEIoA4ni/qiWqAenxElysjTqMMkITzGDKkc+jpBDkVz3wEsIH+
 n9wYhbj5U8IE1YZrUoa3TsKEqCQJihe2kDZVw7Aux0dkPS+Q33aWHAw42iwcWBAUuYbgpUVTJT6
 Yb6F9WxsJ/8XfgedfrqP23FHXNbnfrBIsfYqYNu1kJHrKW13yQmtPHrRdG4Duw+Mp9zkUypo7pg
 N3rEev0/p/BNbpy7JYrVi+C6QS1GPbqWTdpNr8UBC1+kIwCZPyd35nALrLtY+PQ1TbKey31p1hK
 Wsfsxadrv3vg53Pq0ZmYQ11Qd/gcE8FzdosMLxbYlJ/EL94jd4kel/fMFHDzefr5hOde6U5qPcF
 y0nMy21Viw8IvdPe9ag==
X-Proofpoint-GUID: U5dQJsKgC-FeaBSVolbyzLf-1CQIDqbz
X-Proofpoint-ORIG-GUID: U5dQJsKgC-FeaBSVolbyzLf-1CQIDqbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180051

On Tue Mar 17, 2026 at 10:16 PM CET, Niklas Schnelle wrote:
> On Tue, 2026-03-17 at 11:43 -0700, Farhan Ali wrote:
>> <..snip..>
>>=20
>> On 3/17/2026 5:58 AM, Julian Ruess wrote:
>> > static int ism_vfio_pci_probe(struct pci_dev *pdev,
>> > +			      const struct pci_device_id *id)
>> > +{
>> > +	struct ism_vfio_pci_core_device *ivpcd;
>> > +	struct zpci_dev *zdev =3D to_zpci(pdev);
>> > +	char cache_name[20];
>> > +	int ret;
>> > +
>> > +	ivpcd =3D vfio_alloc_device(ism_vfio_pci_core_device, core_device.vd=
ev,
>> > +				  &pdev->dev, &ism_pci_ops);
>> > +	if (IS_ERR(ivpcd))
>> > +		return PTR_ERR(ivpcd);
>> > +
>> > +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fi=
d);
>> > +	ivpcd->store_block_cache =3D
>> > +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
>> > +	if (!ivpcd->store_block_cache) {
>> > +		vfio_put_device(&ivpcd->core_device.vdev);
>> > +		return -ENOMEM;
>> > +	}
>> > +
>> > +	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
>> > +	ret =3D vfio_pci_core_register_device(&ivpcd->core_device);
>> > +	if (ret) {
>> > +		kmem_cache_destroy(ivpcd->store_block_cache);
>> > +		vfio_put_device(&ivpcd->core_device.vdev);
>> > +	}
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +static void ism_vfio_pci_remove(struct pci_dev *pdev)
>> > +{
>> > +	struct vfio_pci_core_device *core_device;
>> > +	struct ism_vfio_pci_core_device *ivpcd;
>> > +
>> > +	core_device =3D dev_get_drvdata(&pdev->dev);
>> > +	ivpcd =3D container_of(core_device, struct ism_vfio_pci_core_device,
>> > +			     core_device);
>> > +
>> > +	vfio_pci_core_unregister_device(&ivpcd->core_device);
>> > +	vfio_put_device(&ivpcd->core_device.vdev);
>> > +
>> > +	kmem_cache_destroy(ivpcd->store_block_cache);
>>=20
>> I think the kmem_cache_destroy() should be done before we do=20
>> vfio_put_device() (or maybe even before=20
>> vfio_pci_core_unregister_device()) to avoid use after free similar to=20
>> ism_vfio_pci_probe(). Sorry I missed this earlier.
>>=20
>> Thanks
>>=20
>> Farhan
>>=20
>
> Good find! Wouldn't it be even cleaner to provide vfio/ism specific
> .init and .release functions in ism_pci_ops that do the
> kmem_cache_create() / kmem_cache_destroy() as part of init / release?
> It seems this is done for e.g. Xe with xe_vfio_pci_init_dev()
> and xe_vfio_pci_release_dev(). In fact wouldn't that be even necessary
> to correctly handle the case where the above vfio_put_device() isn't
> the last reference?
>
> Thanks,
> Niklas

Thanks guys! Yes, I think we should introduce custom .init and .release fun=
ctions. Will change that in the next version.
