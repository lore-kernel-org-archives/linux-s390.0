Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A09218E91;
	Mon, 12 Oct 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796957; cv=none; b=euf4z13Hk9IyKzMNLFYf5UJSnBp4/k8uVVFJ6FN6UdtK4KQKt15K3ZUSiyWGDxTlMbU7aAskLcTcwhZt7vRDY9nf04X8NPS0Il1az7KdrOfhfZJ6MGKpohpLpJMAHm9MJcliUKoZvTwJCn8YZBQx+PxVkMH72t5iiIPyYe9P3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796957; c=relaxed/simple;
	bh=SVMLBSYh0GC7YxKk4rwlTqXtP1PrKbkgSBvybD6+uR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CS8gHagEUdm30WbIh9S98x78ODoCAbAJWuOIRFbFsruocrlHVL2gwdAloj4w7kx1Y1ji3d9zGr8yuJIdI6y/6ZUU2JMfuoH4t8/k3EPTK/GfztJmFal/g7yszHTgAVX8uLmAheqTcr6MmbH9iGfjATW9GPEyrumY8af8H9MNxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIplFLj2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIplFLj2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8i6UH4052642;
	Mon, 12 Oct 2026 09:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Is+7ac
	4G8QGj/qenm5iQ1uxgYjzEQHBFQjw89OqoujI=; b=TIplFLj2jIzeNr5qXX0tEl
	RBt/KkeOBGKskstpBL2virYu01dpIcS3bE+iTJzKXAACwf3XVU9EAq30agSPNUP0
	16kB0MhHqxLuBbuNWHPHIP9qL6G5kQ7tKpPzbBFCjrPbmr2/WdvPaczYiXP6QeIb
	kce5jOygnEMoMWzOrfqPvobtBj2yevUOgkxiNGaBV734BxLUwItaIGWljOD62+d9
	tlGEPAq3w93C9cK85HyvsmQ4idxcdSfG7m3NuUkhRyI0iFv8c8rv6d/NPQVL4ynU
	WFHLER56QlVhNNgDFj8U2qkEKIPYK2pjaGhK31DTlzgA2UU8zifyCesF+bYyu7Pw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug84c7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 09:22:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8YtAP978608;
	Mon, 12 Oct 2026 09:22:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vmmae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 09:22:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C9MRTS34472290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 09:22:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C169920043;
	Mon, 12 Oct 2026 09:22:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F27220040;
	Mon, 12 Oct 2026 09:22:27 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 09:22:27 +0000 (GMT)
Message-ID: <722e46379f3e7825ac1d40805ae67d236fcc6867.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 12 Oct 2026 11:22:27 +0200
In-Reply-To: <20261007135926.82935-3-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
	 <20261007135926.82935-3-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acca6d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=0EFr_cLxgBoSRm_Uz7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EyD14SUCemttR1T78rvEjlZG6-GRHdzR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfXwn66kwiy0ksQ
 lA5+rB92xvgiLhnFsTMQBDKADATfLgadcaaE2DdLGoPgWjXN2kbuO4JBnnwNZDCo6JYbdpaQAM2
 rl1Apv3vw95UrrS5eiRUQmRvShfLAkINVqCxxww2cNWg9t31dPtijT6KOkFAPYXjm6crjZstBue
 CENoxDZ3ZYB+h533NGp7yb7BfZlonIj+1TgXeroAu0coJND77qFNVB7pMKlUV/j5y7eq073mqhy
 5A2M3HiMyq7XbbRMiWFmJMElalmRb2s7C5mvXagdiwqWxMxlV3Bz2oeuWN6PNTil2m0rF7PQ987
 19+jEKEHuDqneD/Z7ON9MlbAMHLdEREKy3ZAdHXAPOXcZcII1CLqr+rUNfAQ9ytfPAE0prhHfqG
 jfqCQHAh/XLgY237lsjfIjutWBdZcor4bJJtY9U3yl+K8nQdLiC9dBtKPsQ8sD54SSR274D9QnY
 leveB8iVnNWDhbepqdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNiBTYWx0ZWRfX+3Pn1rU9sxqv
 qJKrpXNeq7hL+AWRMwakIx4fuBX7pI4zRAFFQz1LsA18e4RQtmDv2QMFOMaobz6EqLdfGePjZ37
 RxQCw/cU1Q8S/rYPl7CcxZB1iCN+wQY=
X-Proofpoint-ORIG-GUID: EyD14SUCemttR1T78rvEjlZG6-GRHdzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120036

On Wed, 2026-10-07 at 09:59 -0400, Omar Elghoul wrote:
> Don't free the FMB buffer when disabling measurement in
> zpci_fmb_disable_device(). Instead, make the buffer persistent for the
> lifetime of the device and reuse it across enable/disable cycles. Defer
> freeing the buffer until teardown in zpci_release_device().

I lost track if this was discussed before: Would it make sense to break
this out into a separate patch, so that memory allocation/life-time
questions are decoupled from function-measurement preservation?

> Introduce the bool fmb_requested to struct zpci_dev to track whether FMB
> enablement has been requested. This decouples tracking the enablement
> from whether the buffer had been previously allocated, allowing us to
> account for implicit disablement by firmware in zpci_disable_device().
> Audit the only consumer of zdev->fmb and update its liveness check to
> reflect this change.
>=20
> Separate the buffer allocation and measurement enablement step into the
> new function zpci_fmb_reenable_device(), which allocates the FMB buffer
> on first use, zeroes it on reuse, resets the software IOMMU counters,
> and enables measurement. Make zpci_fmb_enable_device() delegate to this
> function, and call the latter from zpci_reenable_device() when
> fmb_requested is true.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |   2 +
>  arch/s390/pci/pci.c         | 106 +++++++++++++++++++++++-------------
>  arch/s390/pci/pci_debug.c   |   2 +-
>  3 files changed, 70 insertions(+), 40 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..77c8c49ba6c8 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,7 @@ struct zpci_dev {
>  	struct zpci_fmb *fmb;
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
> +	bool		fmb_requested;	/* desired FMB enablement state */

How about calling this "statistics_on" - derived from the sysfs
attribute, to decouple this "user intent" even more from the actual ISA
level enablement?

> =20
>  	u8		version;
>  	enum pci_bus_speed max_bus_speed;
> @@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *z=
bus);
>  /* FMB */
>  int zpci_fmb_enable_device(struct zpci_dev *);
>  int zpci_fmb_disable_device(struct zpci_dev *);
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev);
> =20
>  /* Debug */
>  int zpci_debug_init(void);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad0972..bda91d79bafd 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -167,43 +167,13 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 =
dmaas)
>  /* Modify PCI: Set PCI function measurement parameters */
>  int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  {
> -	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> -	struct zpci_iommu_ctrs *ctrs;
> -	struct zpci_fib fib =3D {0};
> -	unsigned long flags;
> -	u8 cc, status;
> -
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (zdev->fmb_requested || sizeof(*zdev->fmb) < zdev->fmb_length)
>  		return -EINVAL;
> =20
> -	zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> -	if (!zdev->fmb)
> -		return -ENOMEM;
> -	WARN_ON((u64) zdev->fmb & 0xf);
> -
> -	/* reset software counters */
> -	spin_lock_irqsave(&zdev->dom_lock, flags);
> -	ctrs =3D zpci_get_iommu_ctrs(zdev);
> -	if (ctrs) {
> -		atomic64_set(&ctrs->mapped_pages, 0);
> -		atomic64_set(&ctrs->unmapped_pages, 0);
> -		atomic64_set(&ctrs->global_rpcits, 0);
> -		atomic64_set(&ctrs->sync_map_rpcits, 0);
> -		atomic64_set(&ctrs->sync_rpcits, 0);
> -	}
> -	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> -
> -
> -	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
> -	fib.gd =3D zdev->gisa;
> -	cc =3D zpci_mod_fc(req, &fib, &status);
> -	if (cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
> -	return cc ? -EIO : 0;
> +	zdev->fmb_requested =3D true;
> +	return zpci_fmb_reenable_device(zdev);

I'm not quite happy with "reenable" now becoming the "work horse" for
enabling function measurement at the pci device. I append a suggested
change at the end (since it's lengthy). My train of thought was:
Introduce symmetric zpci_fmb_req_{dis|en}able_device() that toggle the
"statistics_on" boolean, then call zpci_fmb_{dis|en}able_device() that
does the actual zpci_mod_fc(). This allowed zpci_reenable_device() to
call zpci_fmb_enable_device() if case of "statics_on", while the writes
into sysfs would call zpci_fmb_req_{dis|en}able_device().

And another after-thought, since the whole _device postfix on these
function names seems redundant, how about the following names:

zpci_request_fm_on()
zpci_request_fm_off()
zpci_enable_fm()
zpci_disable_fm()


>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> @@ -215,22 +185,68 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (!zdev->fmb)
> +	if (!zdev->fmb_requested)
>  		return -EINVAL;
> =20
> +	zdev->fmb_requested =3D false;
>  	fib.gd =3D zdev->gisa;
> =20
>  	/* Function measurement is disabled if fmb address is zero */
>  	cc =3D zpci_mod_fc(req, &fib, &status);
>  	if (cc =3D=3D 3) /* Function already gone. */
>  		cc =3D 0;
> +	if (cc)
> +		return -EIO;
> =20
> -	if (!cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
> +
> +/* Re-enable PCI function measurement: clear the software IOMMU counters
> + * and (re-)enable the FMB. This function is used to restore the desired
> + * FMB enablement state when measurement may be implicitly disabled by
> + * firmware (i.e., via CLP in zpci_disable_device())
> + */
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_iommu_ctrs *ctrs;
> +	struct zpci_fib fib =3D {0};
> +	unsigned long flags;
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb) {
> +		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> +		if (!zdev->fmb)
> +			return -ENOMEM;
> +	} else {
> +		/* reuse the same FMB buffer for as long the zdev lives */
> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
>  	}
> -	return cc ? -EIO : 0;
> +
> +	/* reset software counters */
> +	spin_lock_irqsave(&zdev->dom_lock, flags);
> +	ctrs =3D zpci_get_iommu_ctrs(zdev);
> +	if (ctrs) {
> +		atomic64_set(&ctrs->mapped_pages, 0);
> +		atomic64_set(&ctrs->unmapped_pages, 0);
> +		atomic64_set(&ctrs->global_rpcits, 0);
> +		atomic64_set(&ctrs->sync_map_rpcits, 0);
> +		atomic64_set(&ctrs->sync_rpcits, 0);
> +	}
> +	spin_unlock_irqrestore(&zdev->dom_lock, flags);

I know this is pre-existing, but how about breaking out the buffer and
counter preparation/clearing into a helper function?

> +
> +	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status);
> +	if (cc)
> +		return -EIO;
> +
> +	return 0;
>  }
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> =20
>  static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8=
 len)
>  {
> @@ -737,8 +753,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
> +	if (zdev->fmb_requested)
> +		zpci_fmb_reenable_device(zdev);
> =20
>  	return rc;
>  }
> @@ -1003,6 +1025,12 @@ void zpci_release_device(struct kref *kref)
>  	if (zdev->has_resources)
>  		zpci_cleanup_bus_resources(zdev);
> =20
> +	if (zdev->fmb) {
> +		zdev->fmb_requested =3D false;
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
>  	zpci_bus_device_unregister(zdev);
>  	zpci_destroy_iommu(zdev);
>  	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..9a960310d4dd 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>  		return 0;
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	if (!zdev->fmb) {
> +	if (!zdev->fmb_requested) {
>  		mutex_unlock(&zdev->fmb_lock);
>  		seq_puts(m, "FMB statistics disabled\n");
>  		return 0;

Oh, and while playing around with this patch (with and without my
additional modifications), I realized that statistics/function
measurement gets re-enabled when I run `zpcictl --reset-fw <bdf>` to a
function - despite it being switched off before the reset.

Thanks,
Gerd


[ here's the patch to avoid zpci_fmb_reenable_device(): ]


diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 77c8c49ba6c8..26c6b616cc25 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -350,9 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus
*zbus);
 void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
=20
 /* FMB */
-int zpci_fmb_enable_device(struct zpci_dev *);
-int zpci_fmb_disable_device(struct zpci_dev *);
-int zpci_fmb_reenable_device(struct zpci_dev *zdev);
+int zpci_fmb_req_enable_device(struct zpci_dev *);
+int zpci_fmb_req_disable_device(struct zpci_dev *);
+int zpci_fmb_enable_device(struct zpci_dev *zdev);
+int zpci_fmb_disable_device(struct zpci_dev *zdev);
=20
 /* Debug */
 int zpci_debug_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index bda91d79bafd..c0bd76eac717 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -165,7 +165,7 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8
dmaas)
 }
=20
 /* Modify PCI: Set PCI function measurement parameters */
-int zpci_fmb_enable_device(struct zpci_dev *zdev)
+int zpci_fmb_req_enable_device(struct zpci_dev *zdev)
 {
 	lockdep_assert_held(&zdev->fmb_lock);
=20
@@ -173,20 +173,25 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 		return -EINVAL;
=20
 	zdev->fmb_requested =3D true;
-	return zpci_fmb_reenable_device(zdev);
+	return zpci_fmb_enable_device(zdev);
 }
=20
 /* Modify PCI: Disable PCI function measurement */
-int zpci_fmb_disable_device(struct zpci_dev *zdev)
+int zpci_fmb_req_disable_device(struct zpci_dev *zdev)
 {
-	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0,
ZPCI_MOD_FC_SET_MEASURE);
-	struct zpci_fib fib =3D {0};
-	u8 cc, status;
-
 	lockdep_assert_held(&zdev->fmb_lock);
=20
 	if (!zdev->fmb_requested)
 		return -EINVAL;
+	return zpci_fmb_disable_device(zdev);
+}
+EXPORT_SYMBOL_GPL(zpci_fmb_req_disable_device);
+
+int zpci_fmb_disable_device(struct zpci_dev *zdev)
+{
+	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0,
ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_fib fib =3D {0};
+	u8 cc, status;
=20
 	zdev->fmb_requested =3D false;
 	fib.gd =3D zdev->gisa;
@@ -200,14 +205,13 @@ int zpci_fmb_disable_device(struct zpci_dev
*zdev)
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
=20
 /* Re-enable PCI function measurement: clear the software IOMMU
counters
  * and (re-)enable the FMB. This function is used to restore the
desired
  * FMB enablement state when measurement may be implicitly disabled by
  * firmware (i.e., via CLP in zpci_disable_device())
  */
-int zpci_fmb_reenable_device(struct zpci_dev *zdev)
+int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
 	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0,
ZPCI_MOD_FC_SET_MEASURE);
 	struct zpci_iommu_ctrs *ctrs;
@@ -246,7 +250,7 @@ int zpci_fmb_reenable_device(struct zpci_dev *zdev)
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
+EXPORT_SYMBOL_GPL(zpci_fmb_enable_device);
=20
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val,
u8 len)
 {
@@ -660,7 +664,7 @@ int pcibios_enable_device(struct pci_dev *pdev, int
mask)
=20
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_enable_device(zdev);
+	zpci_fmb_req_enable_device(zdev);
 	mutex_unlock(&zdev->fmb_lock);
=20
 	return pci_enable_resources(pdev, mask);
@@ -671,7 +675,7 @@ void pcibios_disable_device(struct pci_dev *pdev)
 	struct zpci_dev *zdev =3D to_zpci(pdev);
=20
 	mutex_lock(&zdev->fmb_lock);
-	zpci_fmb_disable_device(zdev);
+	zpci_fmb_req_disable_device(zdev);
 	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
@@ -760,7 +764,7 @@ int zpci_reenable_device(struct zpci_dev *zdev)
=20
 	guard(mutex)(&zdev->fmb_lock);
 	if (zdev->fmb_requested)
-		zpci_fmb_reenable_device(zdev);
+		zpci_fmb_enable_device(zdev);
=20
 	return rc;
 }
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 9a960310d4dd..f2f0e7f44842 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -156,10 +156,10 @@ static ssize_t pci_perf_seq_write(struct file
*file, const char __user *ubuf,
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
 	case 0:
-		rc =3D zpci_fmb_disable_device(zdev);
+		rc =3D zpci_fmb_req_disable_device(zdev);
 		break;
 	case 1:
-		rc =3D zpci_fmb_enable_device(zdev);
+		rc =3D zpci_fmb_req_enable_device(zdev);
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);


