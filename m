Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFD3C38;
	Tue, 27 Jan 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501735; cv=none; b=tF9bz+rS/c9ee8nBWXbcfNSxKK13JKWACuyavqjhwU4gp410biHhrtDhWrL7dgmFph1cFQk4al4Jk0G79Vhh8nuOD4Hcuag1uD3sDNoop9uVhU5LW+QJ0B69PVOad+lYHaP2Rkew3hnkNrnAPRWMJnxbXvlrXlCE2NRVONzBpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501735; c=relaxed/simple;
	bh=F0E7nYosuaQUjoEHCcGwgVEwx8Z8Q/uBLWfO23+tG8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nSuP/10zxhGZMeCFo/GawMAy802J8gDM4CKtmWKxi2lOsxnJFAHNqhT8JAtAC743ncEcIjmFsR63DZAZmAoTuYZtxxgXTw20B7xj3i7c0b3WzW9uADdWB047zdKcl+dzEJxD/gglVcYLqzKAtZWeXSOmR6gQIgsIfZaLdgI8aqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q7UOdtOR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q7UOdtOR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5mfLt027227;
	Tue, 27 Jan 2026 08:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5cercG
	Ynr3NipLgMN02u1JYISn/EnJIUYxWdekvMZxU=; b=q7UOdtORwJRudyvg7kFmgQ
	GsTedx2v5NdG6BxO8w0P3L6Z4RhUImF4ZBxGBN8exeUFO6fiNV3XsEekOe3Ha+MF
	TgN0OtAdGUvYIIolPTqqcZ1JCZk35ZP/GYy9ZJZFnSl1hW6HuRWN9jCOLk13iGhz
	7pbynktvJIb9sTqTd3sMx2sBuqKxf8QhDshxjQq1MAgxcdelBQQJSTbpWXBxgVrz
	oGu4OfzSNadf0gGYQ+ZqLRx7R8kO76TWJRelHryy7i2lP9q7STKpyoLCFZnoGeJU
	5W7beYqEvT0N7cj4fDqZU+xs2Bi6VgHBwjb8L4X9+Zy87fvCLOdYtuswjXppGaeg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtc5nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:15:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R3BqdP026319;
	Tue, 27 Jan 2026 08:15:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk7tr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:15:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60R8FM7J44564924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 08:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258AA20040;
	Tue, 27 Jan 2026 08:15:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFED20043;
	Tue, 27 Jan 2026 08:15:21 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 08:15:21 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 09:15:21 +0100
Message-Id: <DFZ80CU1BHRM.1OALN64S2ULP@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <julianr@linux.ibm.com>
Subject: Re: [PATCH v8 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
From: "Julian Ruess" <julianr@linux.ibm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122194437.1903-1-alifm@linux.ibm.com>
 <20260122194437.1903-10-alifm@linux.ibm.com>
In-Reply-To: <20260122194437.1903-10-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5nq5fY66aKLmUghryfvPIFxnQsWtuNpr
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978741f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=E0RtPYjD2jRhVGfDaHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5nq5fY66aKLmUghryfvPIFxnQsWtuNpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA2MiBTYWx0ZWRfX0ousSD3KUfdK
 eeEW2KqyZ/ytQmuyJFeTE7GTUZ1gkwWX+VImeuBHnxEZC+XGezhvH190YGmn4rYQSUFSkN2/YBg
 tCzahpF+/XLTRAeEFwHGcrWbLtiUYiUDlpbF4BnVjLz/Cd7afzaDLBp25KfjQrj0S74Qr5RYhmZ
 uHzWl46AlICeAi6CluM4L3ZK5csuv/hSsXBFazqmjXQB5AWGKbEqZUNuqwbB5pvFZ3qHzh4iGi2
 lyZpLosjAWtGGszZw2eC76Fd5qtUeFHHv78UVZyy7FZ0V3zhwxVCHRv9hWs5G1FddWaSElQ783y
 35yarl6Jsz2uV4HbpzsURHdvBLRSlBNSLEpgrBixFmbCwWMKB/zzJ4z9/DV9PputWTSZMMgGKyB
 6GNIK8TEOJLwJUS/QQCvLcnqziAI2hlZq0wQdh/Sl1if5bhVJBhA2d71Kb6bTvc318R2GwtZjWw
 4p25O5WE74WPeHsiI/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270062

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

Feel free to add my
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>

Thanks,
Julian
