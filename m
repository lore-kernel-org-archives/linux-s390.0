Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745971;
	b=IPmuxerYTZjFhr/j7CrTllINIoXGrZbClwi9F452L8zG7vjaBJejTXQiA5REomq70A8S
	 TWDnd1bHZ9sn6mOKgBQeAdmc5oe2LlC2jy3nA5Zxp+g7hc3LOOsqsXBnVNeAoySy+7f/c
	 NoPFn7vOjnzFm6AxD96LbdT1bVQ6bFP7Dg2bgrMIF8MT9E4EQAefYxOvyWCBL4DU6MzLw
	 B5CTfG6g3PFjCKvWFKl4foYQTuMt8e3u2EnyVhBNeIe01OgnGwtmBfYD3csbbyvq3M54j
	 zM538txlaLA5qaeUGIVjjwwOZ/WIFpy71n/3jAjRO8r0LkhVjWCJBMrtOg5mk8oLUjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745971;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zmg/yxiwkjfaDfTODXwb587ZNjoOvF78dqo2aQK83Zk=;
	b=hy8xh5/HN92DPdzdHEX1wb9mMvgW/EycT00DQC9UXgYAodJvsoS5ptupJMNkCx6KjMy5
	 RXouCOWh3HgwojHhhvD9GHjpaguoGShLMMnKkBYuKusO4mE7i2cKYZuVgOcNAXeYERJcm
	 gzWqmqP+iVU+Oyf80PLPX02Gbx56nMbukH9qQrv0zTO9M8Fk5ZcQjQJma2pUh4pNqfDvZ
	 aHMJUet0/izkyjsqZEr6hcfNal+UlbZddfwxdEeqqwWFe+wKYm6BUccGORBUmB+xZa6x4
	 Mz0Nc91z+0q2iWvlup613foR8Pp/sH8V9909EEWS2CbPQUg5h/0DGEHAjsZq/zSGb6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Si6ZiX4G;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED9606A31A;
	Fri, 23 Oct 2026 08:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5ED9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Si6ZiX4G
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Ep282248252;
	Fri, 23 Oct 2026 08:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zmg/yx
	iwkjfaDfTODXwb587ZNjoOvF78dqo2aQK83Zk=; b=Si6ZiX4GdRH4M63Fjzk4kp
	y1ZIct7LXRhkltn1PC5Ijn+r3ISCDzDH4OCDEAQ+ve4nTY2ksdebVlWbu1BTFRr6
	UjRZbTa1pb2ypKeLZA7spCQLI0ORbYAuEis0qlE9d8q7SIYAsLz26x2keFDzVaE8
	1N1tQct5KnwmUN1xSJs9+sxMpuBw1F2iqvirX+x4VE8SQbUZ1/ikxLtxZcHapYyw
	0pjFvfbEO48GXvD4N4h5xA9flmSOUSofeSmlgSQuAxHXpPEtUg1fNk64e850VzRZ
	2wVZxB4676ZNymWsXOJuoy2expb3BXRp3piWL7r2C9wTch3zvxskpRGlFNrFYsIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5am50v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 08:59:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7K2e11759338;
	Fri, 23 Oct 2026 08:59:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x4bww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 08:59:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N8xNiV50266472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 08:59:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126742004D;
	Fri, 23 Oct 2026 08:59:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF07F20043;
	Fri, 23 Oct 2026 08:59:22 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 08:59:22 +0000 (GMT)
Message-ID: <e30a260ee021532b4bcbe424a18b47143638f222.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 23 Oct 2026 10:59:22 +0200
In-Reply-To: <20261020212427.2561-3-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
	 <20261020212427.2561-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX37QqU4qQ0dNe
 KAbG6MTbYkXI1chB9odXUyDFKZYBPKVF5fzcQtxQJMzVORY0BSHBCGTEKu/NcpoNR4yBqfzUGTj
 3X7zAaG3sK9MFbHZ98jpSc9vupJQzAc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX8s9n6xo4qDEX
 iEs1SOxocVBxMdNY/VbQzbcIwcco/a9Au1pCZhWKXiLmSlrcbSuITZm/8gK6DfYu6Asw80PAHlv
 uErYlGE+h3XdjsSCqsQkvXmN9nTa46v+Ga+QBsEefiE58IAdEq/3mAuD6i+/kUZeniYBGqSgia6
 NLRae1tuREzQvhq7YhZ43WSUPNxrNRPfZFjoCzQtEmTzYpjMpdquBKHFy7LOWZiuPkyl+pm0N1g
 b1O/DAyHd5efswZrcBvTeWL+jsoZSfdwV5Z1oGQ7RvzQQ3PvV9DlUXHLqkH0/c4lQFqwNDaLs0Z
 xe0F343mQmeMkf5S9FT17KbRrbLoyf5nHiRa+4kryR609APpN9hhucTzqc6VtrHKyDkR/VxhHKU
 BG8yK5RXiz+KaN9rMRUGXz1RXMWzmP1BXZ5nvuHW24jpDeOOL/KbQsXnawrX4nDf45105LIng7+
 OByRACeTD78+kJQ54lA==
X-Proofpoint-GUID: jn6DB7ZxMlWmnOokHjvEgVgOZiczanZO
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb21ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=hEZ094eQ13rxNu7WmyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jn6DB7ZxMlWmnOokHjvEgVgOZiczanZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230034

On Tue, 2026-10-20 at 17:24 -0400, Omar Elghoul wrote:
> Allocate the FMB once upon first enable and keep it for the lifetime of
> the zdev instead of freeing it on every disable. Track the enablement
> state in the new statistics_on bool, since a non-null FMB no longer
> implies that measurement is enabled.

Hi Omar,

thanks for picking up the suggestion to split this into two patches.
However, if you swapped patch 2 and 3 you'd introduce the "bool
statistics_on" in a more intuitive way and then the reuse of FMB
buffers once they're allocated comes in more naturally? That way the
name of "statistics_on" has a better explanation and this patch becomes
a lot smaller, maybe.

> Defer freeing the buffer until device teardown in zpci_release_device().
>=20
> Drop the alignment warning after allocating the FMB buffer due to it
> already being guaranteed by the kmem_cache.
>=20
> Audit the only consumer of the FMB (pci_perf_show) and update its
> liveness check to be aware of this change.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  1 +
>  arch/s390/pci/pci.c         | 41 ++++++++++++++++++++++---------------
>  arch/s390/pci/pci_debug.c   |  2 +-
>  3 files changed, 27 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..f4fea1c34746 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,7 @@ struct zpci_dev {
>  	struct zpci_fmb *fmb;
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
> +	bool		statistics_on;
> =20
>  	u8		version;
>  	enum pci_bus_speed max_bus_speed;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad0972..2a7e1ca0fa12 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -175,13 +175,17 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (zdev->statistics_on || sizeof(*zdev->fmb) < zdev->fmb_length)
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
> +	} else {
> +		/* reuse the same FMB buffer for as long as the zdev lives */
> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> +	}
> =20
>  	/* reset software counters */
>  	spin_lock_irqsave(&zdev->dom_lock, flags);
> @@ -199,11 +203,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
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
> +	zdev->statistics_on =3D true;
> +	return 0;
>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> @@ -215,7 +219,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (!zdev->fmb)
> +	if (!zdev->statistics_on)
>  		return -EINVAL;
> =20
>  	fib.gd =3D zdev->gisa;
> @@ -224,12 +228,11 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
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
> +	zdev->statistics_on =3D false;
> +	return 0;
>  }
> =20
>  static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8=
 len)
> @@ -1003,6 +1006,12 @@ void zpci_release_device(struct kref *kref)
>  	if (zdev->has_resources)
>  		zpci_cleanup_bus_resources(zdev);
> =20
> +	if (zdev->fmb) {
> +		zdev->statistics_on =3D false;
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
>  	zpci_bus_device_unregister(zdev);
>  	zpci_destroy_iommu(zdev);
>  	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..419c6a9200a2 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>  		return 0;
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	if (!zdev->fmb) {
> +	if (!zdev->statistics_on || !zdev->fmb) {
>  		mutex_unlock(&zdev->fmb_lock);
>  		seq_puts(m, "FMB statistics disabled\n");
>  		return 0;

Thank you,
Gerd
