Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140233344D;
	Tue, 20 Jan 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948522; cv=none; b=QHGFeBeWzca/6FY23Vcp2IaIkfxym7XKqc2ocTwxGtlUVMhJbBcIsj/PcSxyEU2fmUczbzsF4eoUhPJqQSMupTkwaVA3Sp9xiMcEl2hQBWiU1SrDosVUS6Ai62Yk5xnuZyaX8z/LlcjmTYxCcxaNgO2+XWn/q0Ba+AdjfXypWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948522; c=relaxed/simple;
	bh=2q//nO1gkcAFcMpgv29nxjdwK94Lp05QTJSCFEfRrZ0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=s6o4pm8XLej4lHT2IBMilxSp9lVDHxdpVTfUHjErWfI+Znoag52ix8/Yp2oHww8bZj8C5Vq9HtGjNk1zKkeDsqmLuFKwg9Y3TbEWqgmhRF2cFxZVIkimrMynCh6CbbJ6gNE+b10gKU/3yMNxpYaYC4jp+Mkd3aAekifKCSCeV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g24pQyHB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g24pQyHB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KElI6q022132;
	Tue, 20 Jan 2026 22:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gm1R/6
	oNHFw02//RQl4EUDYWJeIcCpRsWmFhSV1mlyo=; b=g24pQyHBBpH5gGwduFh10F
	m5AKxW+DYL76R63ipBm9aqFxSiTLaOYiIIgv/bwSqYOcumhXmYi35A5QA/T/qrX5
	nzX5/P9VB/WHp5OTvJUC8PG2sABm4eHbewUsakQjoG04O9pdAA5kI1qJVibHymMU
	YiOWE0X5lWzwhjeiStzQQ3Esbdw+z+9+l5coI5PNm54eAKYMmLp6uWPVcNb9VL2C
	44CNqQFR+lAF0u9uqW+aWxSRfb15RWLYDcjoFXN/laWp9x0Sq1E6y12VhhbTh0XU
	SY6bSceho9DI0a+cfOQVQuX0Ej75A54tPJh4phfTmo+qPcfDX8N9HCOs5UYcCREw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uffy9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 22:35:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KLjhFE006415;
	Tue, 20 Jan 2026 22:35:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1g1b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 22:35:10 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KMZ8Tc60883242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 22:35:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC725805A;
	Tue, 20 Jan 2026 22:35:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C6F258052;
	Tue, 20 Jan 2026 22:35:07 +0000 (GMT)
Received: from [9.111.82.89] (unknown [9.111.82.89])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 22:35:06 +0000 (GMT)
Message-ID: <99b0c4dd03013226c8e3fa9dc6661f40fc1b0b88.camel@linux.ibm.com>
Subject: Re: [PATCH v7 6/9] s390/pci: Store PCI error information for
 passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, mjrosato@linux.ibm.com
In-Reply-To: <20260107183217.1365-7-alifm@linux.ibm.com>
References: <20260107183217.1365-1-alifm@linux.ibm.com>
	 <20260107183217.1365-7-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2026 23:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XDX-GSMPBkpA97dAOzIbDHpNfa3yQVo7
X-Proofpoint-ORIG-GUID: XDX-GSMPBkpA97dAOzIbDHpNfa3yQVo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4NSBTYWx0ZWRfX3dgY81I0/t+M
 qi0bStxzMXu/tSQ1FfFQBmpuQJ87pW0QOHWg4ISLbVdxM9BNmo7DkpXRJbvTdNAcXIah5EZWTIZ
 9TXU3VNgn0y0yGsy74B0RVwodw3LflLkJjovt2tDUbXdQKNGiQgA4nxIqL/w8+YdDzFmsEbSSDG
 Xmb0+l+k5swSHp2yBttqXBJyYTtzWUp1UPKsxLWtS5+l+/i0sQjDQAQ1QdLkPspWk6YnDNjO/Rz
 a0VaWTU4pKDWCP7XNXrovfW2UA26rBmoCq2jE7QBlNlBJMORUDIwK6Sw1ri2iIXt8pJHZksV5WP
 x9gp9F+SaPQm5IEu/nVFoUaooRpS2Hb/bEm5CYYZvqreArnD1p9YQ8VFBqqy0blSjH8ZsAey2UZ
 P/2A0FpIsu7ScK01B31K2LP9RD3cxpbnmyXJMtneH9UwRmzLfSwsbslsM7cevIilAvN/1XuIX2i
 Gw0qgzRm/7t5MtzMj/A==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=6970031f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=U9gv1QJqUYU1_2GOVGQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200185

On Wed, 2026-01-07 at 10:32 -0800, Farhan Ali wrote:
> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      | 28 ++++++++++
>  arch/s390/pci/pci.c              |  1 +
>  arch/s390/pci/pci_event.c        | 95 +++++++++++++++++++-------------
>  drivers/vfio/pci/vfio_pci_zdev.c |  2 +
>  4 files changed, 88 insertions(+), 38 deletions(-)
>=20
>=20
--- snip ---
> =20
> +static void zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(pdev);
> +	int i;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count >=3D ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued",
> +				pci_name(pdev), ZPCI_ERR_PENDING_MAX);

Nit: Here and in a few other places the alignment doesn't match the
open parenthesis. These are caught by checkpatch.pl with "--strict".
That also points out a couple of lines over 75 characters in commit
messages in this series.

> +		mutex_unlock(&zdev->pending_errs_lock);
> +		return;
> +	}
> +
> +	i =3D zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.tail++;
> +	zdev->pending_errs.count++;
> +	mutex_unlock(&zdev->pending_errs_lock);
> +}
> +
> +void zpci_cleanup_pending_errors(struct zpci_dev *zdev)
> +{
> +	struct pci_dev *pdev =3D NULL;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
> +	if (zdev->pending_errs.count)
> +		pr_info("%s: Unhandled PCI error events count=3D%d",
> +				pci_name(pdev), zdev->pending_errs.count);

Nit: Align with open parenthesis (see above)

> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +	pci_dev_put(pdev);

Yay, the previously missing pci_dev_put()

> +	mutex_unlock(&zdev->pending_errs_lock);
> +}
> +EXPORT_SYMBOL_GPL(zpci_cleanup_pending_errors);
> +
>=20
--- snip ---
> @@ -210,12 +223,23 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
> =20
> +	if (needs_mediated_recovery(pdev))
> +		zpci_store_pci_error(pdev, ccdf);
> +
>  	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str =3D "failed (abort on detection)";
>  		goto out_unlock;
>  	}
> =20
> +	if (needs_mediated_recovery(pdev)) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +				pci_name(pdev));

Nit: Code alignment

> +		ers_res =3D PCI_ERS_RESULT_RECOVERED;
> +		status_str =3D "in progress";
> +		goto out_unlock;
> +	}
> +

With the style issues fixed feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
