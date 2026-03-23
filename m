Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE93314D0;
	Mon, 23 Mar 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301507; cv=none; b=VQ/L5YfhPFHYfmAjoqtiUiX0Dbh0eYUj3jPqwzinZPGyVAEy+5vMlPcpD8CnlIaasSQbGcjWk5Z1SPYnVYWVwiC9PanZPoAa5M3vQfbGknEVuthSZIgV5HI0mtfoajAlrAfSDYyTWPrwf6z124Dx4mlp6Ce0PK+RW1dvJ7h4+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301507; c=relaxed/simple;
	bh=FXWQzYVXXeexo8k+hlFApOA0k8lKuydX8GFQP327BJ0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=H70fatCO4pcgziMcagd+ZGzU9kCaEW8V3vgt9FX1vOaujyh+u0XuKn79BZwu+8VrrpTmuNydAtTL55soPCMv88e6pAzxNn/IszjTrBf4eN5arwu/VmGzuZCSLBJ1h2br0ONHz7g6jK2fiW0AeWA9jDeqe+XY/MXqjUIFcSLacX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U5wtpq7I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U5wtpq7I"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NGQVTP1013982;
	Mon, 23 Mar 2026 21:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m6Q8h6
	FmtER19KyneQri2XMLp/7ti2ZQGqhrRWCTZYA=; b=U5wtpq7IbI1ISkLfLiERcE
	ZVzh5WqJhIIFyjK6tWnfwKrIaH5Z1AHHoSbl0N8k5KW22eRxB8ENcp/4wsQU6mvq
	ju0TSaEfqbk2aPQUwNuPogFcNFgHyXL5wr0kc2C6SsAENFsz9m0patGvT6VdElph
	+q7khaEqWcPJfa+TFs5zVMHbexgsw8fq4Ty+JwQXZ6wV32clKV6udPbzDDnVfroe
	TsPJ5+YyasNIqoDjVFT25lj5XhyBk+QZCr5YSagJFGG9L/yXoDkNjwnE6j3tTZID
	zGo2mVRolRYCHIv0y5c9t3KiTMa56zY6oAtzBTX3Ejh4JLYEZ7mNVcrH+wnCykLg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq8svd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 21:31:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NLUWll005976;
	Mon, 23 Mar 2026 21:31:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yf56e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 21:31:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NLVdQ930671462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 21:31:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 468F558058;
	Mon, 23 Mar 2026 21:31:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276AA58057;
	Mon, 23 Mar 2026 21:31:36 +0000 (GMT)
Received: from [9.111.10.175] (unknown [9.111.10.175])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 21:31:35 +0000 (GMT)
Message-ID: <408e262c507e8fd628a71e39904fedd99fa0ee8e.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex
 Williamson	 <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai
 Hadas	 <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian	 <kevin.tian@intel.com>,
        =?UTF-8?Q?Micha=C5=82?= Winiarski	
 <michal.winiarski@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260323-vfio_pci_ism-v7-2-abf537150408@linux.ibm.com>
References: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
		 <20260323-vfio_pci_ism-v7-2-abf537150408@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2026 22:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BYXJwMsAHNJSERTyQ3JfUDWCIxt_2MCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE1OCBTYWx0ZWRfX5IM7ITpcyvnq
 krt4sx+r1PTLrxr9244cN1kpjzAhxZt3GRSyQZ2JdCjZmkzdLS8JvatakujXy0WG3Isyt1ZdeHX
 ntv6dXCQ1Qrt4JJwS6XDUHQS9WVgd6yfyJ3WD7Tyy1QHikDOVeyvr4kfRkdZoMdY9l7sfcPU8x8
 L1OPbN1WBjPssyEIR6MN2JACQP1jEsZgaEqAEADdDhoNvLXS6h/5TX0/1YxwzJEMGtRxkYjcGhO
 AmEy23z/mg7SqL+xJOb/nSXkToiDJSTBjG26F+uVr7/DggUwo+EXQOW2HkngyJH0lKDUWfW3Sth
 slSeqJH4qbQ8VUXYza5LXAZAoCQrlH6JLWaDe55EWPf/I/J0QmMPMmpL0jfQeRbIhns6JE8v1+1
 ixmtrPtu9i1zSvJUM3xvQoQFl46e+G8X9rAX0jFEZkDFpMJ2AJ/zYQHyqMTURFvhZ4nQjke8Y4Z
 QdHEE1jhhtO/8XJYRxA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c1b13d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=xxTOiqZ9glbip-uEU58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BYXJwMsAHNJSERTyQ3JfUDWCIxt_2MCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230158

On Mon, 2026-03-23 at 10:32 +0100, Julian Ruess wrote:
> Add a vfio_pci variant driver for the s390-specific Internal Shared
> Memory (ISM) devices used for inter-VM communication.
>=20
> This enables the development of vfio-pci-based user space drivers for
> ISM devices.
>=20
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function handle based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function handle-based PCI instructions are
> used instead.
>=20
> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store block (PCISTB) instruction to
> perform write operations.
>=20
> Stores are not fragmented, therefore one ioctl corresponds to exactly
> one PCISTB instruction. User space must ensure to not write more than
> 4096 bytes at once to an ISM BAR which is the maximum payload of the
> PCISTB instruction.
>=20
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig      |   2 +
>  drivers/vfio/pci/Makefile     |   2 +
>  drivers/vfio/pci/ism/Kconfig  |  10 ++
>  drivers/vfio/pci/ism/Makefile |   3 +
>  drivers/vfio/pci/ism/main.c   | 401 ++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 418 insertions(+)
>=20
--- snip ---
> --- /dev/null
> +++ b/drivers/vfio/pci/ism/main.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vfio-ISM driver for s390
> + *
> + * Copyright IBM Corp.
> + */
> +
> +#include "../vfio_pci_priv.h"
> +#include "linux/slab.h"
> +
> +#define ISM_VFIO_PCI_OFFSET_SHIFT   48
> +#define ISM_VFIO_PCI_OFFSET_TO_INDEX(off) (off >> ISM_VFIO_PCI_OFFSET_SH=
IFT)

Nit: checkpatch.pl --strict recommends to add () around the off macro
argument to prevent precedence issues.

> +#define ISM_VFIO_PCI_INDEX_TO_OFFSET(index) ((u64)(index) << ISM_VFIO_PC=
I_OFFSET_SHIFT)
> +#define ISM_VFIO_PCI_OFFSET_MASK (((u64)(1) << ISM_VFIO_PCI_OFFSET_SHIFT=
) - 1)
> +
> +/*
> + * Use __zpci_load() to bypass automatic use of
> + * PCI MIO instructions which are not supported on ISM devices
> + */
> +#define ISM_READ(size)                                                  =
      \
> +	static int ism_read##size(struct zpci_dev *zdev, int bar,             \
> +				  ssize_t *filled, char __user *buf,          \
> +				  loff_t off)                                 \
> +	{                                                                     \
> +		u64 req, tmp;                                                 \
> +		u##size val;                                                  \
> +		int ret;                                                      \
> +									      \
> +		req =3D ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, sizeof(val)); \

Not your fault since it is in the original ZPCI_CREATE_REQ() also but I
think the READ_ONCE() is actually useless. The zdev->fh can indeed
change under us in some error/recovery scenarios but then the PCI
instructions would also just return a stale handle error and really the
access isn't really at risk of getting torn either. Still, I'd keep
this for consistency and then we can think of cleaning this up
everywhere.

> +		ret =3D __zpci_load(&tmp, req, off);                            \
> +		if (ret)                                                      \
> +			return ret;                                           \
> +		val =3D (u##size)tmp;                                           \
> +		if (copy_to_user(buf, &val, sizeof(val)))                     \
> +			return -EFAULT;                                       \
> +		*filled =3D sizeof(val);                                        \
> +		return 0;						      \
> +	}
> +
> +ISM_READ(64);
> +ISM_READ(32);
> +ISM_READ(16);
> +ISM_READ(8);
> +
--- snip ---
> +
> +static int ism_vfio_pci_init_dev(struct vfio_device *core_vdev)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(to_pci_dev(core_vdev->dev));
> +	struct ism_vfio_pci_core_device *ivpcd;
> +	char cache_name[20];
> +	int ret;
> +
> +	ivpcd =3D container_of(core_vdev, struct ism_vfio_pci_core_device,
> +			     core_device.vdev);
> +
> +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid);
> +	ivpcd->store_block_cache =3D
> +		kmem_cache_create(cache_name, zdev->maxstbl, PAGE_SIZE,
> +				  (SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT), NULL);
> +	if (!ivpcd->store_block_cache)
> +		return -ENOMEM;
> +
> +	ret =3D vfio_pci_core_init_dev(core_vdev);
> +	if (ret)
> +		kmem_cache_destroy(ivpcd->store_block_cache);
> +
> +	return ret;
> +}
> +
> +static void ism_vfio_pci_release_dev(struct vfio_device *core_vdev)
> +{
> +	struct ism_vfio_pci_core_device *ivpcd =3D container_of(
> +		core_vdev, struct ism_vfio_pci_core_device, core_device.vdev);

Here checkpatch.pl --strict complains about '(' at the end of a line
but clang-format also does it this way and even shortening the name
doesn't make it fit so I'd tend to keep it this way.

> +
> +	kmem_cache_destroy(ivpcd->store_block_cache);
> +	vfio_pci_core_release_dev(core_vdev);

As discussed offline. I think it may be a bug in the Xe variant driver
that their xe_vfio_pci_release_dev() doesn't call
vfio_pci_core_release_dev() even though xe_vfio_pci_init_dev() calls
vfio_pci_core_init_dev(). @Alex, @Michal?

> +}
> +
--- snip ---
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("vfio-pci variant driver for the IBM Internal Shared =
Memory (ISM) device");
> +MODULE_AUTHOR("IBM Corporation");

Apart from the code style nits this looks good to me now. Sorry for
sending us on a few detours.

Feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
