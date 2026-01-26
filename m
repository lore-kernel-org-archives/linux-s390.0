Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51926334C3D;
	Mon, 26 Jan 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441523; cv=none; b=lNjC4uPJJIQf3hgOcrO6eYStUvVk1hYrjEUwN9xz0j05ct9LBe1xv3kU2E4+ye4vzMwWX8VDZ06hcxj+TAVs2PQ+JNRU9zC3Dhie6rILZZjDi7yj03Fb1e9qF0++tDH3WaTXEn02uoZxqRUUCfl+EAJG1GpdivJgkyijRo7+Gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441523; c=relaxed/simple;
	bh=Za1NfCjlqimI7reRl4rc2aeaWjaJr0fiN7wZR3sIgnk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I3vECbC4eEQAZIRNGI+FVTorYJvGetY1351tsH9UD+1g8s6lz+dniQ7FdrWb1ZxG5ZrH+0DpJT4Exe4rKyWteavXQ1EU7jHAsicI1lyMa/dQQHXGNdm0tpsLrFAK4ZaP2jpM9kWkSCk0dxJ1HsDNb9TbRiFqnbX2kv3TAo4oTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZTIjr9iz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZTIjr9iz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QF9Vxp028672;
	Mon, 26 Jan 2026 15:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3NRCgo
	uXtJWry/L7gBk13r2KQL/nufuQsClbyVdzlMM=; b=ZTIjr9izXR/aZY+SlrM99n
	d9ILIZtv3c1QdF4g1Z+veVlK6OOU0VwXUR05No2lj8M02/lL0rGEAgj43COwgich
	ecBtnlMvSi+sxAszx4XKIpNT1gy5aOvPiTtFjCj+CezqYk9iygznNelEObYg8CWt
	CLMgBmXbdRyvLbFgeo5uQRIiv/fNYNcn6K0fY+qiaVEYWYXdhxoEOKeztJKW4Kmv
	P5fj2MLli3FED3LAUaeAYXpJs9amAXRHTFTDPwG/KDyGFY7GZMNM/MSR0fFGPqUY
	yrOutiwlUIm+6epSTUMxSoNMXbKO/uqTVi82w6QXTLw/IUCFHJ68anGB3R+mJd8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfqhu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 15:31:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QCXL02023341;
	Mon, 26 Jan 2026 15:31:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjmwhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 15:31:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QFVojZ51118498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 15:31:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF1820043;
	Mon, 26 Jan 2026 15:31:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC54A20040;
	Mon, 26 Jan 2026 15:31:50 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 15:31:50 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 16:31:50 +0100
Message-Id: <DFYMO05UXGKY.2HG19ERN69ZUW@linux.ibm.com>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <julianr@linux.ibm.com>
Subject: Re: [PATCH v8 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122194437.1903-1-alifm@linux.ibm.com>
 <20260122194437.1903-10-alifm@linux.ibm.com>
In-Reply-To: <20260122194437.1903-10-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697788ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Okk2yIgg9Z9Hp2RjL0IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OUPgyJ6cPDkrIK-rUKGZs12tq3GdnhO8
X-Proofpoint-ORIG-GUID: OUPgyJ6cPDkrIK-rUKGZs12tq3GdnhO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzMSBTYWx0ZWRfX3qjgUcYByevO
 RA9Vgih70y53ruoeDz6l2xYNewvkH7k5rgoO+wdB5gDyZWLayLAPoUQuKVlb3PHIrdbSTuzrr7C
 WUwXc1N0FwTheVtLn1+KjW9YWWelk0P7UtUn0+uIiGKTbb1p9psMl7kiGoX9LJIsmbsYsUihyMa
 sM30SK5GoH+s/PHMXRK0GiHfjpZKvZvXOl7fw2RS3GmHKdEyFZotwedOQxhK9lum1jD4YUwT1ny
 O5d5JY4HziQqzj8A7utZP6dKB1B4ffdZlRt+uN8xNE9u+mdjuvt03Jh/kyImskF9sS58zIWMrr3
 Vg1XKrzVNEVhuP6Nd2Am383b+HyhwJs7cyePmdp9ykdsRDeaxEUuwKY65yHexmhuMkjTGIe+HOQ
 /N+LLHPB3rtSrT2yuo/+ZflfFMgkYIr1fSfkiKvzgeCnWGlJ/oTjpqIfAgQlNPWtpkEYfQdsHoV
 +lePA3mD4JupXMKI5cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260131

On Thu Jan 22, 2026 at 8:44 PM CET, Farhan Ali wrote:
> We are configuring the error signaling on the vast majority of devices an=
d
> it's extremely rare that it fires anyway. This allows userspace to be
> notified on errors for legacy PCI devices. The Internal Shared Memory (IS=
M)
> device on s390x is one such device. For PCI devices on IBM s390x error
> recovery involves platform firmware and notification to operating system
> is done by architecture specific way. So the ISM device can still be
> recovered when notified of an error.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
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

I'm wondering why this pci_is_pcie was introduced here in the first place.
Do you have any ideas?

-- snip --
