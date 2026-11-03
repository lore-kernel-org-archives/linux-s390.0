Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725343;
	b=zEu77TdgGS7F9hVE+rBXFBnEJu77Ph2KOkdo6KJyrlJkR6WmW2vgMLVrmQRnmVbE4Aup
	 bdwEQruzRWujdDyvH5mJj9aCAJfjrmP3sC6T/SYpNYCPo47i3gBwqcylf6vK3OxzRyz49
	 U3QHCbGScFS7Sa8zQ9u3+8f7+ddXA4wADjDNpdrFWImYCLHsC4UMIMGW3meJqVvpKAC/T
	 KTMqUoZDD502+4QL9FI7rUwQ9kE5nITz7iAiNDVS4ywic75I7muW5GdutRyEjkDJaUwsI
	 P1BL+yxZSm4Y+SRi9kBwrLqxnUFdBIk5wi6lRflA3fCQ7py3mu18RkOivE2weRagRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725343;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=C5yiDQM3xzILX7PXhEnjdYcIagea0VimbnGH52vufrU=;
	b=IfyzQ1wcunsOGig8gwPGVU7KOrC/MuoDOHAmY0VkaZ9X8YJq3tSwxL4tFnxIVGPsdmbK
	 DJJRJtei6GR8H0ve6NAjNJtFsA1sTofbLS0QGD9oqDt47SyOgypqYTpdnFp0OlL4gP0eX
	 NshmJZiPHMYE1xl99EIFcKw0JkgBHcO+AEULm/a3N7aRFLeX4pQ1vaZSxvr+IPWcYVwix
	 7Gx5cvl06Ongk2IF4+ROd6350ctCJq7DYQz0w3eN30RSrShqeWSrU8VlhaokmolVHCY0x
	 1H8+2mZ81TGZDi8fgIcb2WKjPwHAzwjRKFhqwZ+3ShOJ9ybWXtulibKPkJ3z3TTNQaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZQPIT822;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818EA606A327;
	Tue,  3 Nov 2026 17:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818EA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZQPIT822
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEI4Y407338;
	Tue, 3 Nov 2026 17:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C5yiDQ
	M3xzILX7PXhEnjdYcIagea0VimbnGH52vufrU=; b=ZQPIT8222dGV1o7tih/O/P
	4GNNnSiyUPp0bPx7n8772avj0ZHJnDjWgWDj13nalH+WcaOrVgsEUE4cM5u8oLRl
	3yeapXzuQxTEQH2lwz44OoxV5AF1c2o0XrzL7Rjlt3zmziv3z8IVEXgBnX/Ihu31
	VVdyBrODe+FBwjmvO7UyFKSyufZqHVviEsb9hvEeXZflOQwTgi5JqKaZzXJ07LAR
	rHQtKUO/cP/WxSY1nXErP+jt1TxvaNu+tHVrx+oS0cG9Xr8JieXIhTZtu9P0fPPx
	QDi1uzS+Sg69sD0M+mUBY+QhlW+IREr33O+bHIp3B7NK4wU8+0vym7ptMBjhXZJA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sq5p0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:02:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK4GI2558213;
	Tue, 3 Nov 2026 17:02:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrca0dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:02:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3H2EjT46203206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 17:02:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8169E20043;
	Tue,  3 Nov 2026 17:02:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414312004D;
	Tue,  3 Nov 2026 17:02:14 +0000 (GMT)
Received: from [9.68.14.168] (unknown [9.68.14.168])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 17:02:14 +0000 (GMT)
Message-ID: <712b9ec90b4020131144ce5cd7976568ca5d2efa.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/5] s390/pci: Improve function measurement state
 management
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 03 Nov 2026 18:02:14 +0100
In-Reply-To: <20261028154352.15108-3-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
	 <20261028154352.15108-3-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: 9AACiBN6ELJz4-WzvTchN0FPBDBs9w0H
X-Proofpoint-ORIG-GUID: 9AACiBN6ELJz4-WzvTchN0FPBDBs9w0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX212fEVWl/hYd
 JMzMvoLKulrtpKB+Pfw9u8TigbHRGcpPHt5R6BZiiDd/Z9I86G49WtueeBzp1sG08esO4wKk3+s
 RWi11vQLCtQg+yKLIQPChxYQhAyomvoBIm1OI0CHtSWJud+oeg727LeQlGL9HEmrFMnJjmt2bL6
 kJmRQQsfReZmSMQ6ePcqGZ0qzzUmwpG73SJpbMWCv91PDwGflt09zdG1170HdT7dR2nhPDk+egi
 xHsSAYX70mS5d7EkVci2Eq0/bkv/cdaRnkTIcBQLi20AiMk0sgXmsQ4TOYu/CEu86caVJAwJr2l
 wxWZTbNJSXb6hI0+WLk+QPJxH4yNUSraRUsdkddSuaqBER/5AINn6tGgXo/YvAl8lxPR/bbQCHv
 jpadx0WumC0bZx9GUuQBEnRK/bmo+mvw/ABgHWw8zXQSdjmkLhne/DJadAqfTEMzjWPI0wSEmQz
 PVi1pEt3xb4t3uWfqqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfXy/qziD5MGcjP
 6FSAffkrXRgk7Oyp2KpOKY6zhDx3l0PoRXinm6W0ce/g6ttKA1lMjbtjXjLe/8unH4EjEdGAz3g
 h34UzP4UV3mJ9MMaJaDqdR0p466BMbs=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea139b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Ne-WxhAMbWJmMnziED4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030066

On Wed, 2026-10-28 at 11:43 -0400, Omar Elghoul wrote:
> When a zPCI function is disabled and re-enabled, the firmware implicitly
> disables function measurement while the kernel still believes it is
> enabled, leading to a disconnect between the user-visible state and the
> actual device state.
>=20
> Add the statistics_on field to struct zpci_dev to track the desired FMB
> state. Introduce the functions zpci_fmb_request_on() and off(), which
> defer to zpci_fmb_enable() or disable() to perform the actual firmware
> change. This decouples the enablement or disablement step from managing
> the user's requested state.
>=20
> Preserve the state in pcibios_enable_device(), pcibios_disable_device(),
> and zpci_reenable_device(), so measurement is restored automatically
> after a re-enable. New devices start with measurement on by default,
> unchanged from before.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  7 +++--
>  arch/s390/pci/pci.c         | 60 +++++++++++++++++++++++++++++++++----
>  arch/s390/pci/pci_debug.c   |  6 ++--
>  3 files changed, 63 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 88a125b92bdd..dd7a17955362 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,7 @@ struct zpci_dev {
>  	struct zpci_fmb *fmb;
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
> +	bool		statistics_on;	/* desired FMB enablement */
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
> index c055a9ad0972..5889dd227009 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -164,8 +164,44 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 d=
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
> +	if (zdev->statistics_on)
> +		return -EINVAL;

It's perhaps a question of taste, but is this strict rejection of
double-enable really necessary? Wouldn't it be more defensive if the
enable was just let to pass?
Ah nevermind: That would allocate a new FMB buffer from zdev_fmb_cache
and is a memory leak.


> +
> +	rc =3D zpci_fmb_enable(zdev);
> +	if (rc)
> +		return rc;
> +
> +	zdev->statistics_on =3D true;
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
> +	if (!zdev->statistics_on)
> +		return -EINVAL;

Same question here: Would a double-disable hurt anybody?
Doh: Yeah, you don't want to go down that route...

> +
> +	rc =3D zpci_fmb_disable(zdev);
> +	if (rc)
> +		return rc;
> +
> +	zdev->statistics_on =3D false;
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
> @@ -207,7 +243,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  }
> =20
>  /* Modify PCI: Disable PCI function measurement */
> -int zpci_fmb_disable_device(struct zpci_dev *zdev)
> +int zpci_fmb_disable(struct zpci_dev *zdev)
>  {
>  	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>  	struct zpci_fib fib =3D {0};
> @@ -644,7 +680,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
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
> @@ -655,7 +692,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_disable_device(zdev);
> +	if (zdev->statistics_on)
> +		zpci_fmb_disable(zdev);
>  	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }
> @@ -737,8 +775,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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

But that discussion about double-enable above makes me wonder:
Would we leak an FMB buffer, here - at least until patch 3 comes to the
rescue? Maybe the two patches are not so independent after all?

So, I experimented a little with patch 1 and 2 applied in an LPAR: I
injected PCI auto-recovery with 'zpcictl --reset-fw' to a NETD PF and a
NVMe PF and was pleasantly surprised that no resources were leaked
*and* statistics were enabled before and after the PCI auto-recovery.

Turns out that both the mlx5 and the nvme drivers pci_error_handlers
callbacks for error_detected() switch off statistics by way of
pci_disable_device() which calls pcibios_disable_device() - and the
callback for slot_reset (mlx5) resp. reset_done (nvme) restore the
statistics setting again by way of pci_enable_device() which calls
pcibios_enable_device().

So one could argue, that at least for the PCI auto-recovery case, this
conditional call to zpci_fmb_enable() is not needed?

> =20
>  	return rc;
>  }
> @@ -847,6 +891,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh,=
 enum zpci_state state)
>  		goto error;
>  	zdev->state =3D  state;
> =20
> +	/*
> +	 * Measurement is on by default for new functions, this will be honored
> +	 * by pcibios_enable_device().
> +	 */
> +	zdev->statistics_on =3D true;
> +
>  	mutex_init(&zdev->state_lock);
>  	mutex_init(&zdev->fmb_lock);
>  	mutex_init(&zdev->kzdev_lock);
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index c7ed7bf254b5..e479763858cd 100644
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

But overall, this is looking good!
Thanks, Gerd
