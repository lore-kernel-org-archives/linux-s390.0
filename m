Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AA3B47D9;
	Mon, 23 Mar 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279891; cv=none; b=mvKXNP2G2/IDDaA6PqFG2pcQQZxnGUiMdTNSOie/ftyWb0mhd3wx9yweORTm9E3habLnUuHAFhYXKdSCWtncLJsUz9EONGUkhWNEd/S7oKpo4MqNOAgbghkAn7rUgBnvmd9fzXv5WiE9H1Jndtevo8eJyJHMV3CiZ86oE2DB55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279891; c=relaxed/simple;
	bh=gFotMnh6T4R6rbqoVPBBvlc3XHWuyVmMZwyBjniBdMQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XCyQcZ+IETGSFfKVM8oaWa51IWNplYCtCzSxRm3q6jA2g80JYB/P02nQMP4cR6wTX94eulQRc64/Wr/b+XGZBd1HRa5PZSgz9N4cKaRTPGVViidraDBZ4u6eDWQxm6p8iP3fjNNU1dmRdbaXMVFcSjQ+Opu6hQLKciw9WDNV4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HOnvf8pm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HOnvf8pm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBxGFH3835046;
	Mon, 23 Mar 2026 15:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0sMpem
	Kg+LLurXE6sJMaeLKcPHglqpQ45/D59uSvY1I=; b=HOnvf8pmeXCjUSLb4Xzx5D
	DgoqTj/0jg/vPvT2TQbm3YF0GTQ/wmASi4uB5TPcToR6ikp5J+D/S315JWmnVMX7
	nKvPfh8i/wPA676BhAlOK3yS5/MTQEvrAmqWZXDfGzAnzhMMzI2eRLu+pPSny1LZ
	MYYkBQJyvVeXZ6E2ZHxL3T4Q6y9Ic/7RSLbDuqRh8VhOdlo6DQFK2JL4ljHbNAw5
	JqOK9NBOYu8/DAQRD54Fl+1jFk4M6mCqUlXjPMhGC9wMgGXKEXdXW3uWjxw8YDlI
	00MfiWxmZtnkTtmG3m3kkzRXdy4GJJLAZMmOxPxo035E5BiFv4L99rmbr+bJvzYA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuq79r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:31:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCNZFM008749;
	Mon, 23 Mar 2026 15:31:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nndw6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:31:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NFVLma26149482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:31:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C67B258043;
	Mon, 23 Mar 2026 15:31:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391A758055;
	Mon, 23 Mar 2026 15:31:18 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 15:31:18 +0000 (GMT)
Message-ID: <f0f6b132e375b765a35910d077f4751de06299e3.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/3] vfio/pci: Rename vfio_config_do_rw() to
 vfio_pci_config_rw_single() and export it
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
In-Reply-To: <20260323-vfio_pci_ism-v7-1-abf537150408@linux.ibm.com>
References: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
	 <20260323-vfio_pci_ism-v7-1-abf537150408@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2026 16:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UbzvAm4YzKZX2f7tlgo-MboN_QQl8yo5
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c15ccb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=LxoSHNL35pUpTilSjbQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX7u9UCs1F3TWC
 nc02HKi/c0arpmNC2otaYXMb1gDqogKgAzPjUafgjW7JY7vJ+mCtvmoY7eE78Nds4FrVXZTlLl5
 d9F2j3N7gM4+8wWM+Jr3qJWiEilS/vt32LjFkMPO8zpf2SuuFMQLWSozP81otORj2npa3ohoeGw
 hq8aQv3bcBBPTEcNmZ/5e1Z5CQbZHtmA2T+8oBq85vnTjrphY6FugVoGC0DQ/+yE3S/w+xERnjz
 wEEuR7t/rAXsYXnF/Dy42y+nKr0q+G+6jr5S84iDNNBvaGXVKWDEXRKV4kom+gk90oLq6Hzez9h
 YBGO++DklDW5MM3DYa2tS6BzGf/BS53MLxJGw5ABGcVudBd4c+BxyHFbT4TUDS+3kxId9Va2RlT
 BnYAieC8m2xIiC5i0A5CLN7U5wCKab0PuRsD/j5A5gFTFj8T/dogRwRQhe9o9IyDW8JrNoQbvo3
 0sApKtg/Ff10USLE7gw==
X-Proofpoint-GUID: UbzvAm4YzKZX2f7tlgo-MboN_QQl8yo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118

On Mon, 2026-03-23 at 10:32 +0100, Julian Ruess wrote:
> A follow-up patch adds a new variant driver for s390 ISM devices. Since
> this device uses a 256=E2=80=AFTiB BAR 0 that is never mapped, the varian=
t
> driver needs its own ISM_VFIO_PCI_OFFSET_MASK. To minimally mirror the
> functionality of vfio_pci_config_rw() with such a custom mask, export
> vfio_config_do_rw(). To better distinguish the now exported function
> from vfio_pci_config_rw(), rename it to vfio_pci_config_rw_single()
> emphasizing that it does a single config space read or write.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 8 +++++---
>  drivers/vfio/pci/vfio_pci_priv.h   | 4 ++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index b4e39253f98da61a5e2b6dd0089b2f6aef4b85a0..fbb47b4ddb43d42b758b16778=
e6e701379d7e7db 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1880,8 +1880,9 @@ static size_t vfio_pci_cap_remaining_dword(struct v=
fio_pci_core_device *vdev,
>  	return i;
>  }
> =20
> -static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char=
 __user *buf,
> -				 size_t count, loff_t *ppos, bool iswrite)
> +ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
> +			      char __user *buf, size_t count, loff_t *ppos,
> +			      bool iswrite)
>  {
>  	struct pci_dev *pdev =3D vdev->pdev;
>  	struct perm_bits *perm;
> @@ -1970,6 +1971,7 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_co=
re_device *vdev, char __user
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(vfio_pci_config_rw_single);
> =20
>  ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __use=
r *buf,
>  			   size_t count, loff_t *ppos, bool iswrite)

Nit: The renaming results in formatting CHECKs when running
checkpatch.pl --strict. Sorry I missed this in my last review.

> @@ -1981,7 +1983,7 @@ ssize_t vfio_pci_config_rw(struct vfio_pci_core_dev=
ice *vdev, char __user *buf,
>  	pos &=3D VFIO_PCI_OFFSET_MASK;
> =20
>  	while (count) {
> -		ret =3D vfio_config_do_rw(vdev, buf, count, &pos, iswrite);
> +		ret =3D vfio_pci_config_rw_single(vdev, buf, count, &pos, iswrite);
>=20
