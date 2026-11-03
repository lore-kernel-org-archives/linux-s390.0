Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740188;
	b=atTbXT7XMZcsSs9Q4XLzWy5PPQHJhD9SYKZhiBSI/DjmzYQsoDEkfI+5sdHbOo26xz+/
	 l+gHwjAXI8AVYIxqx0NVNaK0nkgkGrvsh93SKMt/WZYlH7FBzzpGjNgRAAxuFk1m7T+V4
	 WwONqGj7XtdcKWmgGoI/EYbcWiTFrwwn+8vjbdPNusoWK1ZN58062pNfXRY3NNtwLFI8A
	 NIZXqnRGwESXyZgLEJDwXf/nEbinL5D6GF1uoFIv57343rvbU8VUVCH+cMqCIfx14sz9N
	 N5s+8OKN0l/wYBn00btkwUbGR94VGAMdL/0H3UdtEiVvMiJpkp255n0NeWiobR1Zm3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740188;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pbuaBlkeDfILQZS3CoQ/rYggLvu4O1PZ8Fc4Ks8Xak8=;
	b=Cb7fV74lOc0xelGESo2zqhAv0xCof142nBk1U//4Tooh79SXODKK9f/ONBhOmA9ULzti
	 j9z5vZVH/4QG/n9qdIWdGKVF5Yyb/Gl5yKK50cRx3UPaDAKYEfp/elwJj9Wi7PbUfiNH5
	 y5/Ew1NfVJDtbBDE5UNDnS8ZdKlDWU1stY3tTzSsw/ZZONbiBWKTTYkwnplqiWJvvd4H9
	 67cA9NAEhrVv3LPYB24tcVwagqz8P8zSOrr43h6p3VlalNq3a1ocOC02SA6S569wUiKSb
	 wrFFqXTEd2tKl+/CPklLwefArOv2HpMli26ocAQ8a2U9vMKr0boQ4/bzl2uRnujcDCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="B0WSdO2/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AA606A31B;
	Tue,  3 Nov 2026 21:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B0WSdO2/
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IiQfv2834630;
	Tue, 3 Nov 2026 21:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pbuaBl
	keDfILQZS3CoQ/rYggLvu4O1PZ8Fc4Ks8Xak8=; b=B0WSdO2/GwfsastNDjywbe
	f4+paReq4rtccHar4FHnVGaAHToL4TJdYs0mOxD2vkrjuVVdj3rPvytzCvCHWWJH
	b2N5PwbDHfMnt35qv5vcXGOmDmuca0CLV20LlwJtaBY/pvPLMQAjvZl8INgH8Uhd
	SlTl9Z+vb6AFtXGP4xEvxqJCFneoLN4QrcSw7CX8+2fBdDEP9BSTtm7UyQSiKbYr
	xDfC+ev8QdewNCNrGMjWutKzFAGpgNkBoxErkQsXM2QEmEgAzKJMTjX0GjAG5SdM
	F/SdtDyNnMRHfABr1Cs5KOYh0Eg+eFjkOjsaLSBVwJRx6qBYtCshPgQZePX6lyOw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3gfed-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 21:09:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IaZEn2936191;
	Tue, 3 Nov 2026 21:09:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkbag1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 21:09:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3L9fNw29754062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 21:09:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC69758060;
	Tue,  3 Nov 2026 21:09:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 252135805E;
	Tue,  3 Nov 2026 21:09:39 +0000 (GMT)
Received: from [9.87.159.144] (unknown [9.87.159.144])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 21:09:38 +0000 (GMT)
Message-ID: <15fbeb951c380ba6a200651d6ff69b783c96a375.camel@linux.ibm.com>
Subject: Re: [PATCH v12 5/5] vfio-pci/zdev: Add VFIO FMB device features
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
In-Reply-To: <20261103150114.68873-6-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
	 <20261103150114.68873-6-oelghoul@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:08:38 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aea4d98 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=r1p2_3pzAAAA:8 a=SplykyD-GKlIp8uzigcA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: nVoEV-5N3W4ksAFyjZlZLV8JUI8ttfLR
X-Proofpoint-GUID: nVoEV-5N3W4ksAFyjZlZLV8JUI8ttfLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MiBTYWx0ZWRfXweuaBvb1OtaO
 p9QPnezyg/bEd6jDEMv8+A3YptcO4zgsxdj8HO19bS3AhZN6lzD2IMz7NjSWhCizXL3Et1ApFgg
 Jpkh3G7ykl79Ja5f8UbWTtON7M0/BxhwwwydssW15ak274YVfHP0IWTDJxW4D/vP2yJpQ1T0XgA
 iNqmf7l6HiXU2KozcaymBIszFWJI8IyZWokvxxqsnhbtj0H4FC0A5m18RWFu0X9/dDnRS3+x7bs
 9dui1Er0vYCv9HZmuCcVaHQy+icEZ9Pb8P1vPmPu1d8ysPNC4x1kMavR7ZCcUuaaUVr1B21I7xP
 OUP9iYewazHJ6ZZkXUWO1xIaOqtQiRBFUwjzqehlsjY9pNVH8cAFu7KpsWI5lGylrq5p3/aYCu4
 ImsmpXtTZevEemB25sEJrndpVmpFckwxlMIcvs8mNuglcXXkZkxzVf1zZ4jxTqMAjWsZvseJign
 QA4GZM7MM14cyxAy0kQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MiBTYWx0ZWRfX1dJlKpb+SyRn
 KrPCrdEMY/KA+mvfJ5ZULNtpM5zMF3Z6nJe5OLSCVeKOEvJzdcclRbNrdEXgNTULlT89xdPay4G
 OBnb3nTdE+doQo8/6ab93NCwWmeczQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030082

On Tue, 2026-11-03 at 10:01 -0500, Omar Elghoul wrote:
> Introduce new VFIO features for zPCI devices to provide FMB passthrough t=
o
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Acked-by: Alex Williamson <alex@shazbot.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  4 ++
>  drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 64 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 30 +++++++++++++++
>  4 files changed, 116 insertions(+)
>=20
--- snip ---
> +
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u3=
2 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	struct zpci_fmb fmb_bounce;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeo=
f(fmb_read));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	zdev =3D to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> +		return -EFAULT;
> +	if (!fmb_read.data)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &zdev->fmb_lock) {
> +		if (!zdev->fmb_enabled)
> +			return -ENOMSG;

For those who were also wondering what would happen if the zdev has an
FMB length too large for this kernel's version of struct zpci_fmb. In
that case zpci_fmb_enable() fails the FMB enablement leaving zdev-
>fmb_enabled false and then the check above also covers the memcpy()
here even if user-space ignores that the FMB is not enabled.

> +		memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb=
_length))
> +		return -EFAULT;
> +
> +	return 0;
> +}

Looks good, looking forward to having function measurement in KVM
guests.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
