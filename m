Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963030;
	b=HSF4tyug4ME86IniLzfaRN1AVAWnA/KaXztgV9apquJqQgSs1li5N/Wrx5wIsXVCF1h+
	 J4THXEH5RkcjPvgmejiqeRsMhQcKfirS14HvFB4Wq94+M3gOpYW/Zvu/vVO5bHDJzIc6T
	 hLOd9Xq+mEOvGr826PXPuJJ1ISSoWtnkZZH/VkINiCwilpSAi6Bk79ZDNx0YPD5JO86gf
	 63jPyitNyRbhkFrLb19qVs5+SrX2uxZYrLsyntdXKxXvNN5+9ddyYbl2RrYAUxXLFwiiu
	 NfqnNYemERhvDfO8ERnO6zqxENskhTQg4TE9gqsEUaJmCXaG+zu/nZvMZlJLWiPOkCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963030;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=To28dABa66Cq8x0r2nuGn+jLe4StsbnYPLRGZ6fNC/w=;
	b=u/I5/vEqKXqg5K9dH+s5ydyiuO0pZ5EmXP9aSQ8tCst9eQc81VmRQ79iFFMLiroJJiKb
	 W/S+kycmCknNoNAj6yyMpGt9FspMJtaQVQnABefC4xcB3I64xXGeELX6/swHYSb5XJPRd
	 oGNWBWPOY0K6PeQZA6M8wrwqtIKNbm2Auhne6UlLJ+YFQ2sgn7HPZ8I/Gp2zHd0geHGpz
	 GzqdEKwxulkkEQxizQUkOVlHGcdyAT2knb3hp/UxErvS9ilZGwmPQO4Czj3xb8pBbsJAr
	 jBhoqGHZSUT4P5zCf1jx8iC+5XJa6SY4/7SVAkRHgAoRh7UUW+f1eHDMYL09kBsfGlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LBR0uM1y;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB4606A329;
	Fri,  6 Nov 2026 11:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BAB4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LBR0uM1y
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AivBd978577;
	Fri, 6 Nov 2026 11:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=To28dA
	Ba66Cq8x0r2nuGn+jLe4StsbnYPLRGZ6fNC/w=; b=LBR0uM1yC4P174HZfei3Y0
	1LgtBSUpfkOv2OcH3AC6YzlfZ6jDg6lOacMr6TXft+VHKAxMw2Ga1WYAAJxa5hm8
	Ok5VcQc187KlCqUvIzuUQOGGy1hAwezE96JNHkAJEk/am7G9hqi1axoS+9ffT5C5
	9z0QJHzrgEDpg310yr08/15CuXNOsRsVkDeOcJ1w8LSBlEbUa8El3jFH8VN1QqjT
	oKppUSOUdJOLyUS8RFpwT7VTyia58WBKYa4BoTUx9zodcYKIkbB+h/h5O3xE6zvX
	TFN8xj9uexlFyaXnPWnlA6wiDHUD3P/hfKB4gsAtkZYDzOEokqBZNWGE4TR2oq3g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbuspe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:03:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYxiY3159714;
	Fri, 6 Nov 2026 11:03:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrerb17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:03:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6B3g6B33817082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 11:03:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1704920043;
	Fri,  6 Nov 2026 11:03:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3CCF20040;
	Fri,  6 Nov 2026 11:03:41 +0000 (GMT)
Received: from [9.68.14.168] (unknown [9.68.14.168])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 11:03:41 +0000 (GMT)
Message-ID: <d683bc7a4852857f132187097eb2f610c53c76b9.camel@linux.ibm.com>
Subject: Re: [PATCH v12 3/5] s390/pci: Improve FMB memory management
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 06 Nov 2026 12:03:41 +0100
In-Reply-To: <20261103150114.68873-4-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
	 <20261103150114.68873-4-oelghoul@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5LAEPHj0mqcYdKqdfIo3FrAHKSKjzEFQ
X-Proofpoint-GUID: 5LAEPHj0mqcYdKqdfIo3FrAHKSKjzEFQ
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedb412 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=0y3wu6QeYUe49MgN8XoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX4uQbEJYT3Gct
 z6UDtl0Pz0gmt2QtWsoBcU0Y4tAk015GwRVRXtZasge96rHVgpol2GO1aASXtLwGoJVcT4Lduwm
 kwTlWy5zLKvjGrtAwUkDjkDUX+3e4U8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX+eqEOfL1qHuc
 3tyKyv/rS0J2RpcoTzsbugkLic9fMo7DQSXL08VZlKE5MVq5rainHoCVvrcBunNnVdDTuM0fvZU
 QF0FB3pUS9ytij6m0dmqYtJuuLJ8AgrvPU7qtYhbd1jUkjv/SqW8qdRTg/Pq/cK7Ww+avaZKHcn
 jpDxeQ5u3lrukkv/ZzfsDAjd2yIATR7KWMfoX+CNaHW7q0wxUCfRzJabQXEuqA2tTcAvATMjc2o
 PU/8SAXxgKAUyTC4iP2aJ8ywaPL3a+IfBajafU+JbtbCQg4fSqV5vPpE2s2cTlz17lEwT06vlrd
 w9gxInSPXJqYYsSrL/mSU87rUbNB9Of5XRktdzp5hZNudf2Y78ayEsOqOn9zDEuu3Ds5h+diThU
 LgFlEoDsjBQI++F5o5vFXgsyUf11fSwB8SPboLCVqwPDUVjb0QAT+KZAvG/iteLgb1FXE7cqnzr
 S+35hZaMfN+/8GgNhxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060042

On Tue, 2026-11-03 at 10:01 -0500, Omar Elghoul wrote:
> Refactor the FMB memory management code to use kzalloc() instead of a
> dedicated kmem_cache. kzalloc() already guarantees adequate alignment
> for power-of-two sizes, rendering the kmem_cache approach unnecessary.
> This simplifies both the initialization and cleanup procedures.

TIL about the power-of-two alignment guarantee of kmalloc(). Nice!

>=20
> Allocate the FMB once upon first enable and keep it for the lifetime of
> the zdev instead of freeing it on every disable. Defer freeing the
> buffer until device teardown in zpci_release_device(). Add the field
> fmb_enabled to struct zpci_dev as the new FMB liveness bool, since a
> non-null FMB pointer no longer implies FMB enablement.

Nit: maybe add "in hardware" to the last sentence?

>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  1 +
>  arch/s390/pci/pci.c         | 59 +++++++++++++++++++++----------------
>  arch/s390/pci/pci_debug.c   |  2 +-
>  3 files changed, 35 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index dd58c48ac2ed..6d3c1b8ac75b 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -209,6 +209,7 @@ struct zpci_dev {
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
>  	u8		statistics_on	: 1; /* desired FMB enablement */
> +	u8		fmb_enabled	: 1; /* actual FMB enablement */

Nit: Maybe reword the comment for fmb_enabled to "enabled in hardware"
- to better distinguish the layers where enablement happens?

> =20
>  	u8		version;
>  	enum pci_bus_speed max_bus_speed;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index f49736386eb7..f066a7ffc35c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -62,8 +62,6 @@ EXPORT_SYMBOL_GPL(zpci_iomap_start);
> =20
>  DEFINE_STATIC_KEY_FALSE(have_mio);
> =20
> -static struct kmem_cache *zdev_fmb_cache;
> -
>  /* AEN structures that must be preserved over KVM module re-insertion */
>  union zpci_sic_iib *zpci_aipb;
>  EXPORT_SYMBOL_GPL(zpci_aipb);
> @@ -205,13 +203,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
>  		return -EINVAL;
> =20
> -	zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> -	if (!zdev->fmb)
> -		return -ENOMEM;
> -	WARN_ON((u64) zdev->fmb & 0xf);
> +	if (!zdev->fmb) {
> +		zdev->fmb =3D kzalloc_obj(*zdev->fmb, GFP_KERNEL);
> +		if (!zdev->fmb)
> +			return -ENOMEM;
> +	} else {
> +		/* reuse the same FMB buffer for as long as the zdev lives */
> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> +	}
> =20
>  	/* reset software counters */
>  	spin_lock_irqsave(&zdev->dom_lock, flags);
> @@ -229,11 +231,12 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
>  	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
>  	fib.gd =3D zdev->gisa;
>  	cc =3D zpci_mod_fc(req, &fib, &status);
> -	if (cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
> -	return cc ? -EIO : 0;
> +
> +	if (cc)
> +		return -EIO;
> +
> +	zdev->fmb_enabled =3D 1;
> +	return 0;
>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> @@ -245,7 +248,7 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (!zdev->fmb)
> +	if (!zdev->fmb_enabled)
>  		return -EINVAL;
> =20
>  	fib.gd =3D zdev->gisa;
> @@ -255,11 +258,11 @@ int zpci_fmb_disable(struct zpci_dev *zdev)
>  	if (cc =3D=3D 3) /* Function already gone. */
>  		cc =3D 0;
> =20
> -	if (!cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
> -	return cc ? -EIO : 0;
> +	if (cc)
> +		return -EIO;
> +
> +	zdev->fmb_enabled =3D 0;
> +	return 0;
>  }
> =20
>  static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8=
 len)
> @@ -802,6 +805,12 @@ int zpci_disable_device(struct zpci_dev *zdev)
>  	} else {
>  		rc =3D -EIO;
>  	}
> +
> +	if (!rc) {
> +		guard(mutex)(&zdev->fmb_lock);
> +		zdev->fmb_enabled =3D 0;
> +	}
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(zpci_disable_device);
> @@ -1047,6 +1056,12 @@ void zpci_release_device(struct kref *kref)
>  	if (zdev->has_resources)
>  		zpci_cleanup_bus_resources(zdev);
> =20
> +	if (zdev->fmb) {
> +		zdev->fmb_enabled =3D 0;
> +		kfree(zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
>  	zpci_bus_device_unregister(zdev);
>  	zpci_destroy_iommu(zdev);
>  	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
> @@ -1122,11 +1137,6 @@ static int zpci_mem_init(void)
>  	BUILD_BUG_ON((CONFIG_ILLEGAL_POINTER_VALUE + 0x10000 > ZPCI_IOMAP_ADDR_=
BASE) &&
>  		     (CONFIG_ILLEGAL_POINTER_VALUE <=3D ZPCI_IOMAP_ADDR_MAX));
> =20
> -	zdev_fmb_cache =3D kmem_cache_create("PCI_FMB_cache", sizeof(struct zpc=
i_fmb),
> -					   __alignof__(struct zpci_fmb), 0, NULL);
> -	if (!zdev_fmb_cache)
> -		goto error_fmb;
> -
>  	zpci_iomap_start =3D kzalloc_objs(*zpci_iomap_start, ZPCI_IOMAP_ENTRIES=
);
>  	if (!zpci_iomap_start)
>  		goto error_iomap;
> @@ -1143,8 +1153,6 @@ static int zpci_mem_init(void)
>  error_iomap_bitmap:
>  	kfree(zpci_iomap_start);
>  error_iomap:
> -	kmem_cache_destroy(zdev_fmb_cache);
> -error_fmb:
>  	return -ENOMEM;
>  }
> =20
> @@ -1152,7 +1160,6 @@ static void zpci_mem_exit(void)
>  {
>  	kfree(zpci_iomap_bitmap);
>  	kfree(zpci_iomap_start);
> -	kmem_cache_destroy(zdev_fmb_cache);
>  }
> =20
>  static unsigned int s390_pci_probe __initdata =3D 1;
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index 06e2e8bb2f82..454121bc274c 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>  		return 0;
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	if (!zdev->fmb) {
> +	if (!zdev->fmb_enabled) {
>  		mutex_unlock(&zdev->fmb_lock);
>  		seq_puts(m, "FMB statistics disabled\n");
>  		return 0;

Otherwise, this looks good - and I think Niklas did cover nicely the
Sashiko comments regarding implicit disablement of PCI functions and
the implication of that to fmb_enable.

Thanks,
Gerd
