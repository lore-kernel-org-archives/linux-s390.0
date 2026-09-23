Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6D4F403E;
	Wed, 23 Sep 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176152; cv=none; b=tGHjzrEp9LYAVwUGi0luv8+1CwM/haAvO9srzEd2cnlJDDTAPYTZicD4VJFR5eN/sNQc8ggMUGfr2JeOwqejr9TS1zMx9X0xAQstcSUc48aLDurItxqDVV6Znvu2SQeQ6sTNiR5TQswg+ra2h+3Vmom90QZS9plrRS8xC3fL868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176152; c=relaxed/simple;
	bh=kbjEPQisOMReKzVuwlvcs8Tj08ueB5cETOFLgl9aBZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tf+tk0kFL8ksb6mZHiDkMSPHw/yKtg7h21H9xa02BdAgz3QwV4hgxHv1vY61tKMD3ZJxfzL2Dv0PPWT5t6KNI2XYxWhIpRtzzetMBm4kEDc1l3P8AHPXeIJ307BvNcoY9MIzLLpZeinq/UePywjOQ+80g/mTjM3r9mn7CNHrEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XODfHCz8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XODfHCz8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZftW2742262;
	Wed, 23 Sep 2026 15:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hxgNtc
	od0dYCrLZEfQ82+TO+k/62tLZFxNN7ZVmniu8=; b=XODfHCz8sIJ5yaUUvTsIxp
	v5CJagy8/HwtK+GXTr8Z0VP7zRA/rQxRHZweh0/jYRCIcaINFxGCEKBXnqfCexOH
	iuSekeykE5fyW/W1ej9BGjAm3QK3wistsVeRu2Q5ZrYVEe8Hqv0qKxkZqfkbCH79
	FabePCd1QBiUm6UbrVQK7P+0gfo9Tcq8qVhOQtwaVN7poSJb4Rog0GEvrxAZS8Ni
	ozCQXjoXsXlOdV7JbyyJZd2pkP23PgCjt20nTiValEx22OaWGAXDQ/VBAhQuUcRR
	JoEILi8fATKggu5I4M4uIxvs0fIUtzF4z2ZKKxlvrDarUVfuSdCDYSidiQ0Z95Zw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1km4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:09:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCoQds008141;
	Wed, 23 Sep 2026 15:09:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2sdg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:09:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NF93Jb47841638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 15:09:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B06D20043;
	Wed, 23 Sep 2026 15:09:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43DCC20040;
	Wed, 23 Sep 2026 15:09:03 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 15:09:03 +0000 (GMT)
Message-ID: <d5a32ced819407ae370da37803e30acf541bc5d3.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
Date: Wed, 23 Sep 2026 17:09:03 +0200
In-Reply-To: <20260922195141.94548-3-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
		 <20260922195141.94548-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: byX7xD6VCr9YM67JN-N1c1v1A2P4bhuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MCBTYWx0ZWRfX4eRYWUFBeEgp
 vaAoLtzwEKLBcRDTQnrMRiM2ahcto0s/G/kO7t1QTbUmJciUNNXNOzFtz5m2p/NEswg81JYzvS5
 Aa/1b8HsJMkNF5/XazL/p5t5atu5Eos7wCvDEnufU2QtUX1JoLzd0tkH5Y//i4OyljeFvxG6uz4
 D/0I6Yc0Wycypzo8rExSWINrGPW/flN2tpBHZOc2g8MeqY0VVMuT9NSnV10094HbBX/rFVtIFqv
 JU8UfGiAdhgRzpFl/PIkTRP6JNLZBZb+AOwSpLpe2ntcUG2D+uxsDzsn3BG0viV4zwfXFEOKGXD
 GPuCK6rE3b6/kZPk1XO7wrNRP3pmrtrMsV/JsFjhxS6ozO5aNdFkwsnU/F2JuIcB/JRNyEvgxqa
 glFHv5D8a2oF/RfawORn5PebYwHzScIvEk8cnnScNzZBN6SPLhyQXf2ww5SK8bBAXW9sOArv0z7
 zVyNQLwwPTE6kWlP6Jw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3eb94 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ciMhaqKDz8H6mv_B3WcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MCBTYWx0ZWRfX++caJmu/1zA8
 vS+N4CNS054xebZ29xymFMHRzzvTyjI+eONypNeXu/ojM/0CS82XXMQYIVWXaIzqdElvyFx70TO
 kz1zPbSt0edCn4FbPjP9gjjpdIp4Ty0=
X-Proofpoint-GUID: byX7xD6VCr9YM67JN-N1c1v1A2P4bhuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230060

On Tue, 2026-09-22 at 15:51 -0400, Omar Elghoul wrote:
> Introduce the function zpci_fmb_reenable_device() that checks the state
> of function measurement and ensures it is enabled. Reset the counters to
> zero, disable, and re-enable the FMB if it was already enabled. Call
> this function from zpci_reenable_device().
>=20
> Don't free the FMB buffer during disabling and reuse it when re-enabling
> measurement. Instead, free the buffer upon device teardown, allowing the
> same buffer to be reused in the enable path and add the bit fmb_enabled
> to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
> to reflect the change in semantics.

While I understand how this evolved, this commit message reads upside-
down for me. Shouldn't we consider the changes described in this second
part of the commit message as a preparatory step for the introduction
of zpci_fmb_reenable_device() and put this paragraph first - or even
into a separate commit of its own?

Or, do you want to capture some (the outcome) of the prior discussion
about the "grace period" that architecture imposes on re-using the
memory that was ever registered as FMB with a PCI function? As
rationale why this patch changes when the FMB memory is freed.

>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  2 +
>  arch/s390/pci/pci.c         | 77 +++++++++++++++++++++++++++++--------
>  arch/s390/pci/pci_debug.c   |  2 +-
>  3 files changed, 63 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..b8162f7a8968 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -175,6 +175,7 @@ struct zpci_dev {
>  	u8		util_str_avail	: 1;
>  	u8		tid_avail	: 1;
>  	u8		rtr_avail	: 1; /* Relaxed translation allowed */
> +	u8		fmb_enabled	: 1;
>  	unsigned int	devfn;		/* DEVFN part of the RID*/
> =20
>  	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
> @@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *z=
bus);
>  /* FMB */
>  int zpci_fmb_enable_device(struct zpci_dev *);
>  int zpci_fmb_disable_device(struct zpci_dev *);
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev);

Nothing wrong in this patch, but apparently there's no common "style"
in this file regarding whether parameters are named in the function
prototypes.

> =20
>  /* Debug */
>  int zpci_debug_init(void);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad0972..815257ddb6c8 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -175,13 +175,18 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
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
> +		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> +		if (!zdev->fmb)
> +			return -ENOMEM;
> +		WARN_ON((u64) zdev->fmb & 0xf);

Already before this patch: Is this WARN_ON necessary, with the
alignment on struct zpci_fmb when zdev_fmb_cache is created in
zpci_mem_init()?

> +	} else {
> +		/* FMB buffers are intentionally persistent for later reuse */

How about changing this comment to: /* reuse same FMB buffer as long a
zdev lives */

> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> +	}
> =20
>  	/* reset software counters */
>  	spin_lock_irqsave(&zdev->dom_lock, flags);
> @@ -199,11 +204,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
>  	fib.gd =3D zdev->gisa;
>  	cc =3D zpci_mod_fc(req, &fib, &status);
> -	if (cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
> -	return cc ? -EIO : 0;
> +	if (cc)
> +		return -EIO;
> +
> +	zdev->fmb_enabled =3D 1;
> +	return 0;
>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> @@ -215,7 +220,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (!zdev->fmb)
> +	if (!zdev->fmb_enabled)
>  		return -EINVAL;
> =20
>  	fib.gd =3D zdev->gisa;
> @@ -224,13 +229,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>  	cc =3D zpci_mod_fc(req, &fib, &status);
>  	if (cc =3D=3D 3) /* Function already gone. */
>  		cc =3D 0;
> +	if (cc)
> +		return -EIO;
> =20
> -	if (!cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
> -	return cc ? -EIO : 0;
> +	zdev->fmb_enabled =3D 0;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
> +
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb_enabled)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid stat=
e here
> +	 * because we are re-enabling function measurement for the same functio=
n
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zdev->fmb_enabled =3D 0;
> +	return zpci_fmb_enable_device(zdev);
>  }
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);

I see a little imbalance of the semantics of "reenable" in
zpci_fmb_reenable_device() vs. zpci_reenable_device():
zpci_reenable_device() "just" enables + registers existing data
structures with the underlying system - while
zpci_fmb_reenable_device() does both the disablement + the enablement.

Since zpci_disable_device() includes the disablement of FMB per
architecture, I wonder if it would suffice to set zdev->fmb_enabled =3D 0
in that function, and drop the explicit disable FMB there?

> =20
>  static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8=
 len)
>  {
> @@ -737,8 +768,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
> +	if (zdev->fmb_enabled)
> +		zpci_fmb_reenable_device(zdev);
> =20
>  	return rc;
>  }
> @@ -1003,6 +1040,12 @@ void zpci_release_device(struct kref *kref)
>  	if (zdev->has_resources)
>  		zpci_cleanup_bus_resources(zdev);
> =20
> +	if (zdev->fmb) {
> +		zdev->fmb_enabled =3D 0;
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
>  	zpci_bus_device_unregister(zdev);
>  	zpci_destroy_iommu(zdev);
>  	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..44f026ead414 100644
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

Thank you,
Gerd
