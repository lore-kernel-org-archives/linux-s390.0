Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBC3815DF;
	Mon,  3 Aug 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775281; cv=none; b=eFeUegeb6qE3t/8L1PpXr5fno/z/2NYa+7vToBQTHcLLZJiXVo+hj37AfWGuj9wmUPaQ8jhj6J/ZIxclO3/lRTEd/slsEduOPxjVKaUv5UKxQdKOa1+TKA46aHq3tciKg0pJ/8RSvs7nhXbppdtpkfrbRXwLQwwoKyRk3gUj/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775281; c=relaxed/simple;
	bh=WzYXqiW1e/bpxwOTk8uTSdPqI1H48FbaRf7wrPRBx4s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YdbxzItGp5QdctvzFe0qllyGNpC8brNFQan9z8dXjxL6+akEx6sACKuZzdrmpKA2Ero1lE13IttP6IgZg0ghfO7suJdEMUx7zIf2gmwupU/FV0lKIPQrU5VFG0j4nWeOJeCt+t+wndNnyig2FqKXpyW3IhKC5j8i7TWHVXgPANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qgqiMGxM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qgqiMGxM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHntv2341358;
	Mon, 3 Aug 2026 16:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s6ky7z
	U/hEIv8BcfWEy7ktQhfKyjGu3PcGAhdsBSJeQ=; b=qgqiMGxMNr14kvzHcZcQDg
	LgTtgQ6fKykD8PSd7essoTP1wsrxlA2lKIv5TtlW4Q8ztuLmRn/2Tzm8j59iaYXr
	3EP/BPFuzSwC43GF78vIDpfc4oCfyoUBAOzLDo9J7bS8YJkoB3YpP6xwNUVsnqMU
	vGwXcmjxcUSmlBUB/ODjlM1nhz1tmdicuoQV40QntT/tRfKsNYXcF+jqId4aYZvU
	xMuIcNEtMndGtdJEPW/jNWuY6A9FDht4b+mmr/dugvBymYtYcK0ApKfTufGIhzHe
	Mq30F5dCQNucNxZerHmDzzmbkP0zgC9WU+qAKAm139gwbX+p5jUSEO//vPGp27ow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhg0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:41:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GfFUn013949;
	Mon, 3 Aug 2026 16:41:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg633r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:41:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GfGE112321390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:41:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C159F58051;
	Mon,  3 Aug 2026 16:41:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E78C5805E;
	Mon,  3 Aug 2026 16:41:15 +0000 (GMT)
Received: from [9.111.54.211] (unknown [9.111.54.211])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:41:15 +0000 (GMT)
Message-ID: <cbcdabac9c84252aabfaf1adda139652711de9a6.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] s390/pci: Rework __zpci_event_error() to remove
 conditional locking
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily
 Gorbik	 <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803142907.1771509-2-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
	 <20260803142907.1771509-2-hca@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ewQDV0eYI59MhBwvYqM79tG7AbUbgFXj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0NiBTYWx0ZWRfX00vZ4S1zTZ/u
 xcQ0jy/oQAxeDxQucIWWAH9oM51bixJjWWb7n0pkPUN2djAn1ytURJ1rhACIJUn4mlhV8DPhlGS
 M6j0Yn3yn0u0b72vrRmT+wP+cgpclN4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0NiBTYWx0ZWRfXw6LK6MEy1vTR
 g/RiQf4phroOvaTjSAnxehG63gKdJl9VNFCUFaQQaKRcVkmmscF5QA6zngi1MlmZRBlALhgcuO8
 UJQmj/0J3wYj7BIJ6LYNLwBasDbo2uexC6St678qsiH9H7kxKtkzMtkcveZzZJN7jgKDQjzyzyB
 uX0KJVk7qaP4ZQbjESv21H9kR6WiJ8rM4o8xZwSpymC7NPRsgv+nvWY6JZp2/DPCuVI7qXTQcxy
 N+U92eK4hp9J1HuhRT5A8EIW1SdZuTqyYGfg3wAPZc+60OcO2/1pCWRNauLUWcDHnPgzXMfMMr2
 tFRpKwZGeDb2QSZNMHrGStG6b7HzgMpURmUBR6qHiu0Zu+MnbccnVSiZyfTqdd1pnEs9lS6PEz5
 vwUw/XwHjZwDXZOfzUDLshdCImPwySh3MUjvAKu7LOzWOT+xKRCdoHPt5Q08xTZZym3Z6Va+3QB
 WMyjnm6b1sS971Mq/DA==
X-Proofpoint-GUID: ewQDV0eYI59MhBwvYqM79tG7AbUbgFXj
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70c4ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=BYthbiou9KiBg9ueyzsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030146

On Mon, 2026-08-03 at 16:29 +0200, Heiko Carstens wrote:
> Clang's compiler based static context analysis does not work with
> locks that are conditionally taken like in __zpci_event_error():
>=20
> arch/s390/pci/pci_event.c:320:2: warning: mutex 'get_zdev_by_fid(ccdf->fi=
d).state_lock'
>  is not held on every path through here [-Wthread-safety-analysis]
>=20
> Given that code which takes locks conditionally can be considered
> suboptimal rework __zpci_event_error() to get rid of this.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c | 43 ++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 839bd91c056e..48fa26dcbee1 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -288,6 +288,12 @@ static void zpci_event_io_failure(struct pci_dev *pd=
ev, pci_channel_state_t es)
>  	pci_dev_unlock(pdev);
>  }
> =20
> +static void __zpci_event_print_error(struct pci_dev *pdev, struct zpci_c=
cdf_err *ccdf)
> +{
> +	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
> +	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
> +}
> +
>  static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
>  {
>  	struct zpci_dev *zdev =3D get_zdev_by_fid(ccdf->fid);
> @@ -301,24 +307,24 @@ static void __zpci_event_error(struct zpci_ccdf_err=
 *ccdf)
>  	zpci_err("error CCDF:\n");
>  	zpci_err_hex(ccdf, sizeof(*ccdf));
> =20
> -	if (zdev) {
> -		mutex_lock(&zdev->state_lock);
> -		rc =3D clp_refresh_fh(zdev->fid, &fh);
> -		if (rc)
> -			goto no_pdev;
> -		if (!fh || ccdf->fh !=3D fh) {
> -			/* Ignore events with stale handles */
> -			zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
> -				 ccdf->fid, fh, ccdf->fh);
> -			goto no_pdev;
> -		}
> -		zpci_update_fh(zdev, ccdf->fh);
> -		if (zdev->zbus->bus)
> -			pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
> -	}
> +	if (!zdev)
> +		return __zpci_event_print_error(pdev, ccdf);

Nit: Here pdev is always NULL because the assignment moved below.
Functionally this is fine but it would be more clear this is the case
if you passed NULL for pdev explicitly.

> =20
> -	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
> -	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
> +	mutex_lock(&zdev->state_lock);
> +	rc =3D clp_refresh_fh(zdev->fid, &fh);
> +	if (rc)
> +		goto no_pdev;
> +	if (!fh || ccdf->fh !=3D fh) {
> +		/* Ignore events with stale handles */
> +		zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
> +			 ccdf->fid, fh, ccdf->fh);
> +		goto no_pdev;
> +	}
> +	zpci_update_fh(zdev, ccdf->fh);
> +	if (zdev->zbus->bus)
> +		pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
> +
> +	__zpci_event_print_error(pdev, ccdf);
> =20
>  	if (!pdev)
>  		goto no_pdev;
> @@ -340,8 +346,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *=
ccdf)
>  	}
>  	pci_dev_put(pdev);
>  no_pdev:
> -	if (zdev)
> -		mutex_unlock(&zdev->state_lock);
> +	mutex_unlock(&zdev->state_lock);
>  	zpci_zdev_put(zdev);
>  }
> =20

Thanks for cleaning this up. Even on its own this would be a net
improvement. So with or without my nit resolved feel free to add:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas


