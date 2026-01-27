Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9F30E828;
	Tue, 27 Jan 2026 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512688; cv=none; b=CH47eLM050w5dfxKngj2kyYjQ8CHbvoU392EYTs5Ba4JYrd0FpdE3c/0khv6nf5nAjKv3JzYZLRbMhUadhfjHwcYbpVeRwwfI8n9abXCYb+ZfftkSEYOhQQr9M7nlh53IJTIi7eYHZMGylpZhNJwjtjc1FWgQ1g/ShXaINO6n6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512688; c=relaxed/simple;
	bh=BO+eC9qYn4eSMN1DTDWbFb2ZhuJ2fSLhMYWdtOIOsV8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Brrs/vphkQqdDu3VOiGVeOBXmFTQaGqcH17VtA/U6j7oboMnBNxDYlfq3VEDnaI8aNsljhYg7wwsReHjYtAbX6jamYner7SrNzQW285ql6NLdGCZl6Lr7xU9MU9KuKK7NGo4vv/fagKPYN7PhvmDedyl1kCPUhsxoJIQxOle5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QeD0QYLP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QeD0QYLP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7IsWM016363;
	Tue, 27 Jan 2026 11:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bSlAdw
	Fip8IV0RMmrpNL+IHZh6QaxHpksQsw1Ft9/5w=; b=QeD0QYLPueDerYe/iHipdu
	YLVWEmEIgKRz0NkVxd9XsWWcxs+PIrUtY79oFbZ8sxtoCsT83dJ3YtMFhmej4b6m
	drUqNyJ6eUEEQBuqJKQORNAXmWvjHgyg6WQb/7O6KbEMCNuRCyHLad5iBMigHcrQ
	SS0KRRPiUuq5ERJB+wENeCt91qV5rzwX9LzCsnZAbATOu3ME6M6oW0SQ4NGu5LsE
	6UoM62osmSwWpr6zKlVsq3vI/LYWy1qzs9dxBAaL4h0Cq9HMNIQlLA36GzsnkC/V
	88j9bJpV2DAFYPjXpK6fJrUnm+8uBvblihBQVJeQGOLSnKAuWuUP2CCqeGsSWGJA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7n0tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 11:18:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7ilLD019653;
	Tue, 27 Jan 2026 11:18:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn0ddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 11:18:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RBHw7O27394590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 11:17:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC7035805D;
	Tue, 27 Jan 2026 11:17:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C31658052;
	Tue, 27 Jan 2026 11:17:57 +0000 (GMT)
Received: from [9.87.144.123] (unknown [9.87.144.123])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 11:17:56 +0000 (GMT)
Message-ID: <74a97810e2c6a0aab4eac50b9bcf44c8dde4c57f.camel@linux.ibm.com>
Subject: Re: [PATCH v8 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, mjrosato@linux.ibm.com, julianr@linux.ibm.com
In-Reply-To: <20260122194437.1903-10-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
	 <20260122194437.1903-10-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jan 2026 12:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aDZ7QRH5yGvUuzEsIn6sOo793A6usvjW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5MiBTYWx0ZWRfX6GDcucppltJe
 FQZa4Ev/dF5g7l4I4xiwP/tjYEi0HGoWY9KfNPWqUIIV4tuIDtxiCclKggRyLOplTRwpR81s9nG
 doLXpP5W0Hi2Fxo4jx7/yxFuTgLBPJAQ4PIhzO9QRjhFpoL8get02GDHZcNyvgN+ONkfahszkDM
 KpNEQ5zD0HIImp6MSYgmQEmzAcsSHVleI5qm62DaYI6B0tRMZPtb59KaI+/5rfl+S95hRC99l56
 mxQmEBigs6zmUqr+uWc8MLe1Ti2qBFcehGfO6G/GUaegoOF1aRbpOGpkp4Wjj2ChHt/ZPpsnesV
 qdj2zLxrcYIPIeZWKkS9TgOk2yfeZblOj9tLykSe49B8D3SPOLjke0ATVaEsu082d0VWSt4cMaZ
 R0OI1Usz98oFNTl3ID+MMz5Yg2NLoh6R3/OOeE7XvOSx1LF9jB7/6rTuN5/1+w31LmwiMbDt8kq
 pxyqXkV/kBcbDWD6ibA==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=69789ee9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=E0RtPYjD2jRhVGfDaHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aDZ7QRH5yGvUuzEsIn6sOo793A6usvjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270092

On Thu, 2026-01-22 at 11:44 -0800, Farhan Ali wrote:
> We are configuring the error signaling on the vast majority of devices an=
d
> it's extremely rare that it fires anyway. This allows userspace to be
> notified on errors for legacy PCI devices. The Internal Shared Memory (IS=
M)
> device on s390x is one such device. For PCI devices on IBM s390x error
> recovery involves platform firmware and notification to operating system
> is done by architecture specific way. So the ISM device can still be
> recovered when notified of an error.

Nit: In the kernel context the guidance is to stick to the "s390" name
instead of s390x as in QEMU and even though technically it's all s390x
now ;)

>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>  2 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index c92c6c512b24..9d44df9e21db 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -778,8 +778,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_cor=
e_device *vdev, int irq_typ
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
>  	} else if (irq_type =3D=3D VFIO_PCI_ERR_IRQ_INDEX) {
> -		if (pci_is_pcie(vdev->pdev))
> -			return 1;
> +		return 1;
>  	} else if (irq_type =3D=3D VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
>  	}
> @@ -1155,11 +1154,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio=
_pci_core_device *vdev,
>  	switch (info.index) {
>  	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
>  	case VFIO_PCI_REQ_IRQ_INDEX:
> -		break;
>  	case VFIO_PCI_ERR_IRQ_INDEX:
> -		if (pci_is_pcie(vdev->pdev))
> -			break;
> -		fallthrough;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pc=
i_intrs.c
> index c76e753b3cec..b6cedaf0bcca 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_devi=
ce *vdev, uint32_t flags,
>  	case VFIO_PCI_ERR_IRQ_INDEX:
>  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> -			if (pci_is_pcie(vdev->pdev))
> -				func =3D vfio_pci_set_err_trigger;
> +			func =3D vfio_pci_set_err_trigger;
>  			break;
>  		}
>  		break;

Apart from the nit on the commit message this looks good to me. Thanks!
Feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
