Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898000;
	b=C7Mnu3EbS2ukJ6i0TxgozPwqzyP92uy0z/sJt8ZsSgGEQm+MlRNDP2tIJq/1Hbkr7uki
	 bYKk93jFlSi1PKmoS0vPhcM6XapdXEvUA7WS1qj/aP3n9Zo7++lZdpD4IJn49dVLgdYKx
	 Gp6wA/0kQEQgWRIQJYvlsO/UdqCMfY1JhSbfB6NQ1cU+kLSU1Cxmr6Ep9rMmhq2O0fSDi
	 r+inSLohbr0Ha+v/8w9+ncv4Ztj84k+1+xTur9PHoEeQ87BGs4crndixa4+pl0wOohNwE
	 aYq4BqmxwwxILJm5QctFCXUTKY0Yv/VaPNg2Qnb+pr3SfsVRXwMJQDQVTqerRpL6EjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4VdMmw9IgQMj60w2SfS0ONa+3TaIIoExykF4uE26k34=;
	b=Ie1xOhUE8++rwtSD1MRlFeus9oHAHcjJ6umrNcPgCLTOHoTNDEpuQvTEP0valAxZHE0V
	 fe3Qfeahs2KvEKXaQG1izCK5cCgbH/0qe7VtApGE/EaN+J42L4L1K2u0S3PEC8kCJ/yDT
	 O+9YO1rfgEgAQMQYmYJgMzk2l8MpCCD/jFToTLwbvHwFTRVGT1TGRmEavGc4ZLWQ4DYN5
	 gWgbsFLUPMqtK24f99k5IALjVmIXoOtVJe9gLIyQe2M8/maa8OxyC1CIQuceslXhz6/AJ
	 5I/7eCyj2xwuqQ/R5biiOpPUZS7iX596teMRx5NaqfJ7Ja+QRSgXDFoBDkIn6SnuMqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h6eF5DSI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE2606A326;
	Thu,  5 Nov 2026 16:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1AE2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h6eF5DSI
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiG8w3787897;
	Thu, 5 Nov 2026 16:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4VdMmw
	9IgQMj60w2SfS0ONa+3TaIIoExykF4uE26k34=; b=h6eF5DSICEoAPw2m+QFrPo
	VfyyLsBf95vEVvVWrZG8fqyte37gS6PS+D6RV+Wo3B6Nh3ACPHiO6kMeo7tmJRpA
	yzkmBe72wJYNi0ey4SR9r0Ne4T9Xg1C1vUkJcvh1zCdeiV67wQyzqAC4gPPJAgai
	tAg7156hH9dzoq9g8P1cDUk7wg0uvEGj+88WFfs/8I75wIMHqBIjUz4/kCAhC2gC
	DtNS729NtJkS3rEq6Kng5FwvC4pTewRl67cjU2ToZTAGgwB6c6UXC139aF/wsTSc
	XkiZZLcay+slEQyVtB+QyO9Liw/R2Ciz446FcCyK5X3KcLvzw1hjHZ210X4Qmzdw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn8273vfp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 16:59:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Gs6fj1685693;
	Thu, 5 Nov 2026 16:59:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrek01h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 16:59:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5GxpXD42926360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 16:59:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B470D20043;
	Thu,  5 Nov 2026 16:59:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D78D20040;
	Thu,  5 Nov 2026 16:59:51 +0000 (GMT)
Received: from [9.68.14.168] (unknown [9.68.14.168])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 16:59:51 +0000 (GMT)
Message-ID: <5ba403bebb619e0361d9963c98c8c978c2000e07.camel@linux.ibm.com>
Subject: Re: [PATCH v12 2/5] s390/pci: Improve function measurement state
 management
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 05 Nov 2026 17:59:51 +0100
In-Reply-To: <20261103150114.68873-3-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
	 <20261103150114.68873-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gOJ5I3V8KOJWN5GBoZRATia1TjtZk9wM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX5DKQz1onL+ZQ
 i/vySttEmNgRIOv8Np7YM9AybSuN1MOf4qTI2lI8sNjSs4rfCT++DQXr3JiMcc1u2Mc5ue1OsMl
 1swJGb0hcqztvm2eBlNNyBHOKd29wYEPTK1agwFywbDG3MTndjMgmgFTDJRhdm37ZN+ZXaG6b1r
 qWyixodtrJu/iumxCJ1MPk+1mjqMTHZaXc9m0h/75q/ZTC/u/zRWlcVf0FoK3caxw5M8URWVUy0
 HgwozHop862k6lcvwrOonom0rsyHmeU5tspXgJD7tLxcN62uHGFmsTF2q2Gj71LTjmgD/kxhBVi
 Nem6pOmOJmWexB3o62ZV+pvonFw6tCTH8hznaT8y9ffZg5phLUuv9CM0H/99uiJA6d/fXHlSh+4
 k7wPj7rxSQEB/381e0KeJAeX2THPJ2bl5WRGr0PkHexYqAfmVOZI0UY5eVPjrobOhwJTJUaPhGj
 lYbD9EPItyIJXdKEWJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX1LyTnZEWbjdG
 kWhq8S4m5HtjOhm7cdEILYQoSym8x9QYpDHLQ5GvBVeUYNp6Gr0pSueiqH2szFzRY1omRFUoV+Q
 x4/T0RJuPWISTu/AirAen8HgNIGLSbU=
X-Proofpoint-GUID: gOJ5I3V8KOJWN5GBoZRATia1TjtZk9wM
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aecb60c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YjtKywxNojFmjcD5IdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050066

On Tue, 2026-11-03 at 10:01 -0500, Omar Elghoul wrote:
> When a zPCI function is disabled and re-enabled, the firmware implicitly
> disables function measurement while the kernel still believes it is
> enabled, leading to a disconnect between the user-visible state and the
> actual device state.
>=20
> Add the statistics_on field to struct zpci_dev to track the desired FMB
> state. Introduce the functions zpci_fmb_request_on()/_off(), which defer
> to zpci_fmb_enable()/_disable() to perform the actual firmware change.
> This decouples the enablement or disablement step from managing the
> user's requested state.
>=20
> Restore the state in pcibios_enable_device(), pcibios_disable_device(),
> and zpci_reenable_device(). New devices start with measurement on by
> default, unchanged from before.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  7 +++--
>  arch/s390/pci/pci.c         | 54 +++++++++++++++++++++++++++++++++----
>  arch/s390/pci/pci_debug.c   |  4 +--
>  3 files changed, 56 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..dd58c48ac2ed 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,7 @@ struct zpci_dev {
>  	struct zpci_fmb *fmb;
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
> +	u8		statistics_on	: 1; /* desired FMB enablement */
> =20
>  	u8		version;
>  	enum pci_bus_speed max_bus_speed;
> @@ -349,8 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus *z=
bus);
>  void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
> =20
>  /* FMB */
> -int zpci_fmb_enable_device(struct zpci_dev *);
> -int zpci_fmb_disable_device(struct zpci_dev *);
> +int zpci_fmb_request_on(struct zpci_dev *zdev);
> +int zpci_fmb_request_off(struct zpci_dev *zdev);
> +int zpci_fmb_enable(struct zpci_dev *zdev);
> +int zpci_fmb_disable(struct zpci_dev *zdev);
> =20
>  /* Debug */
>  int zpci_debug_init(void);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad0972..f49736386eb7 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -164,8 +164,38 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 d=
maas)
>  	return cc;
>  }
> =20
> +int zpci_fmb_request_on(struct zpci_dev *zdev)
> +{
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	rc =3D zpci_fmb_enable(zdev);
> +	if (rc)
> +		return rc;
> +
> +	zdev->statistics_on =3D 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_request_on);
> +
> +int zpci_fmb_request_off(struct zpci_dev *zdev)
> +{
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	rc =3D zpci_fmb_disable(zdev);
> +	if (rc)
> +		return rc;
> +
> +	zdev->statistics_on =3D 0;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_request_off);
> +
>  /* Modify PCI: Set PCI function measurement parameters */
> -int zpci_fmb_enable_device(struct zpci_dev *zdev)
> +int zpci_fmb_enable(struct zpci_dev *zdev)
>  {
>  	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>  	struct zpci_iommu_ctrs *ctrs;
> @@ -207,7 +237,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> -int zpci_fmb_disable_device(struct zpci_dev *zdev)
> +int zpci_fmb_disable(struct zpci_dev *zdev)
>  {
>  	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>  	struct zpci_fib fib =3D {0};
> @@ -644,7 +674,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
>  	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_enable_device(zdev);
> +	if (zdev->statistics_on)
> +		zpci_fmb_enable(zdev);
>  	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);
> @@ -655,7 +686,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_disable_device(zdev);
> +	if (zdev->statistics_on)
> +		zpci_fmb_disable(zdev);
>  	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }
> @@ -737,8 +769,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
>  	}
> =20
>  	rc =3D zpci_iommu_register_ioat(zdev, &status);
> -	if (rc)
> +	if (rc) {
>  		zpci_disable_device(zdev);
> +		return rc;
> +	}
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +	if (zdev->statistics_on)
> +		zpci_fmb_enable(zdev);
> =20
>  	return rc;
>  }
> @@ -847,6 +885,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh,=
 enum zpci_state state)
>  		goto error;
>  	zdev->state =3D  state;
> =20
> +	/*
> +	 * Measurement is on by default for new functions, this will be honored
> +	 * by pcibios_enable_device().
> +	 */
> +	zdev->statistics_on =3D 1;
> +
>  	mutex_init(&zdev->state_lock);
>  	mutex_init(&zdev->fmb_lock);
>  	mutex_init(&zdev->kzdev_lock);
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..06e2e8bb2f82 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -156,10 +156,10 @@ static ssize_t pci_perf_seq_write(struct file *file=
, const char __user *ubuf,
>  	mutex_lock(&zdev->fmb_lock);
>  	switch (val) {
>  	case 0:
> -		rc =3D zpci_fmb_disable_device(zdev);
> +		rc =3D zpci_fmb_request_off(zdev);
>  		break;
>  	case 1:
> -		rc =3D zpci_fmb_enable_device(zdev);
> +		rc =3D zpci_fmb_request_on(zdev);
>  		break;
>  	}
>  	mutex_unlock(&zdev->fmb_lock);

Yeah - this looks good to me!
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thank you for your work!
