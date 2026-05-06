Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554073E9F9A;
	Wed,  6 May 2026 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060387; cv=none; b=nYXbed56NYXyuh6T2G71CAhG29MHJycKh7baNv11uuBOP8cIfXFgBEwS7eUlK8qXQSOth2VOWRwqItkDkbC3aCZB4dEDXdcnbP0U4mBTfkbqqe6UgwqNCpOYkMq2eErVlsWMTPVgg2YFivGV2ztQQxbygOuE4+BTuoFntDY0gIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060387; c=relaxed/simple;
	bh=4Gv4eM8gD0segQ3Z+gCobKn/W1vPAzKXWT9G8vuJ9q0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fpwhH7sMIMNcaE0Nqvt1P7n5ETP07fU0Y6FA9GuYPyJMPhjQ/wGAhbROcOGC3OLHJdXwlN4am8iMsCHTwTxNCwUMAlHcl27JKK/HiRnwlipfzaUV/I2EwQsG29Wjp6uMcc9eXmEbELRKUsWReV9zJcpGAgjm8SwaVGSbmOuJCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHhW2Lu0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHhW2Lu0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645HRnPw2769341;
	Wed, 6 May 2026 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WEAmT+
	br5ESyBMdhBXa0IcMUMJYiUaug0gPuYdmYpvQ=; b=HHhW2Lu0PG+Kk5ZeLeOrsW
	cktOWqBJJ/9KB6YyXhvfsmj+OzMdOvUL55cfiRSQAZ97mO3cfiY7qCrxLwYtyiJD
	+LLoweUYcO06uQkmNorT+OE8RX3pNY4MphgIylYySEZCSAbh5qgQavZUJUhNFvX4
	390c8kRA0IgJQg5heLoUdaGpKbKxZ7nmRKk/BUGsg6P8lxDGkulkKX+iwd2QwB1n
	Kl10uaFex4okwRJpPCJnEvFWYM6AgMBXqb+tEWvqONTy+fW0h6l/qHW2uc88DHfe
	HSHmrMOvJ2mzSqTauU9lvGTE0QjucaYjl0SMccaE7yFXa1VQ2DYNB5aIJKzohFSw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6fav8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:39:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6469dOki031844;
	Wed, 6 May 2026 09:39:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9ydbg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:39:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6469daFQ32637624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 09:39:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D830758055;
	Wed,  6 May 2026 09:39:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3082358059;
	Wed,  6 May 2026 09:39:35 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 09:39:35 +0000 (GMT)
Message-ID: <24bd0f694b2bddf07450e09fcea0488ee42ccdf7.camel@linux.ibm.com>
Subject: Re: [PATCH v15 4/7] s390/pci: Store PCI error information for
 passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
In-Reply-To: <20260505200510.2954-5-alifm@linux.ibm.com>
References: <20260505200510.2954-1-alifm@linux.ibm.com>
	 <20260505200510.2954-5-alifm@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 11:38:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb0c5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pafV649OIR0JyFPQdDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5qRXA7xaIYJfoXEGmPKiuhWCZbnT_lZm
X-Proofpoint-GUID: 5qRXA7xaIYJfoXEGmPKiuhWCZbnT_lZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5NCBTYWx0ZWRfX2JXiHplIN3vV
 5GUa26LbfQI//NfpXUSVhmKL2nqR386dCxkVg/AQzwQnBJDv2dBtKlc74+VbpktdUCs7vka6p9U
 QbHCdTdl1XL2fShUY3Z5CFc6lgSRKi5e6VcoQB7JlTauIlhQv4iuWIs/rAKplDTCV1F0H4nU/Sz
 93JQdc9G4hZqWK4F1p+VW4Bhngld3K53tzqwPcnYP3fUJJGoaUAPWPL9rIdQqXTW0nEHSOxPhR9
 NT1tt21XfIrJ9+zo1By09swKx7iU1Cj1ynhf1YvKyBpZNsrgSI9JXFEyiE5Eux1DDq7gigjbR0B
 oemotJbJh6g0qyabE2TLd0wzALQbvTVGUDOgDSNRVgjRtLjFugQOLEO7yNk2GBIFaAhp6f+F0an
 D84EiH7CUvn/3uDfQzexSi3dll096xaar6MaldQi2ETUE+dKtlvP2Jn23+j0h9ZT1GvKt6g48zd
 bGpMgDA+uLobRF/VWmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060094

On Tue, 2026-05-05 at 13:05 -0700, Farhan Ali wrote:
> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> We can now have userspace drivers (vfio-pci based) on s390x. The userspac=
e
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depe=
nd
> on struct kvm_zdev.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  30 ++++++++
>  arch/s390/pci/pci.c              |   1 +
>  arch/s390/pci/pci_event.c        | 114 +++++++++++++++++--------------
>  drivers/vfio/pci/vfio_pci_zdev.c |  18 ++++-
>  4 files changed, 109 insertions(+), 54 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 5dcf35f0f325..016386f7ef4a 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -118,6 +118,32 @@ struct zpci_bus {
>  	enum pci_bus_speed	max_bus_speed;
>  };
> =20
> +/* Content Code Description for PCI Function Error */
> +struct zpci_ccdf_err {
> +	u32 reserved1;
> +	u32 fh;                         /* function handle */
> +	u32 fid;                        /* function id */
> +	u32 ett         :  4;           /* expected table type */
> +	u32 mvn         : 12;           /* MSI vector number */
> +	u32 dmaas       :  8;           /* DMA address space */
> +	u32 reserved2   :  6;
> +	u32 q           :  1;           /* event qualifier */
> +	u32 rw          :  1;           /* read/write */
> +	u64 faddr;                      /* failing address */
> +	u32 reserved3;
> +	u16 reserved4;
> +	u16 pec;                        /* PCI event code */
> +} __packed;
> +
> +#define ZPCI_ERR_PENDING_MAX 4
> +struct zpci_ccdf_pending {
> +	bool mediated_recovery;
> +	u8 count;
> +	u8 head;
> +	u8 tail;
> +	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
> +};
> +
>  /* Private data per function */
>  struct zpci_dev {
>  	struct zpci_bus *zbus;
> @@ -192,6 +218,8 @@ struct zpci_dev {
>  	struct iommu_domain *s390_domain; /* attached IOMMU domain */
>  	struct kvm_zdev *kzdev;
>  	struct mutex kzdev_lock;
> +	struct zpci_ccdf_pending pending_errs;
> +	struct mutex pending_errs_lock;
>  	spinlock_t dom_lock;		/* protect s390_domain change */
>  };
> =20
> @@ -334,6 +362,8 @@ void zpci_debug_exit_device(struct zpci_dev *);
>  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header =
*);
>  int zpci_clear_error_state(struct zpci_dev *zdev);
>  int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> +void zpci_start_mediated_recovery(struct zpci_dev *zdev);
> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> =20
>  #ifdef CONFIG_NUMA
> =20
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 39bd2adfc240..2d377c2e194d 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -842,6 +842,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, =
enum zpci_state state)
>  	mutex_init(&zdev->state_lock);
>  	mutex_init(&zdev->fmb_lock);
>  	mutex_init(&zdev->kzdev_lock);
> +	mutex_init(&zdev->pending_errs_lock);
> =20
>  	return zdev;
> =20
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 839bd91c056e..41547c54076f 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -17,23 +17,6 @@
>  #include "pci_bus.h"
>  #include "pci_report.h"
> =20
> -/* Content Code Description for PCI Function Error */
> -struct zpci_ccdf_err {
> -	u32 reserved1;
> -	u32 fh;				/* function handle */
> -	u32 fid;			/* function id */
> -	u32 ett		:  4;		/* expected table type */
> -	u32 mvn		: 12;		/* MSI vector number */
> -	u32 dmaas	:  8;		/* DMA address space */
> -	u32		:  6;
> -	u32 q		:  1;		/* event qualifier */
> -	u32 rw		:  1;		/* read/write */
> -	u64 faddr;			/* failing address */
> -	u32 reserved3;
> -	u16 reserved4;
> -	u16 pec;			/* PCI event code */
> -} __packed;
> -
>  /* Content Code Description for PCI Function Availability */
>  struct zpci_ccdf_avail {
>  	u32 reserved1;
> @@ -60,18 +43,6 @@ static inline bool ers_result_indicates_abort(pci_ers_=
result_t ers_res)
>  	}
>  }
> =20
> -static bool is_passed_through(struct pci_dev *pdev)
> -{
> -	struct zpci_dev *zdev =3D to_zpci(pdev);
> -	bool ret;
> -
> -	mutex_lock(&zdev->kzdev_lock);
> -	ret =3D !!zdev->kzdev;
> -	mutex_unlock(&zdev->kzdev_lock);
> -
> -	return ret;
> -}
> -
>  static bool is_driver_supported(struct pci_driver *driver)
>  {
>  	if (!driver || !driver->err_handler)
> @@ -81,6 +52,46 @@ static bool is_driver_supported(struct pci_driver *dri=
ver)
>  	return true;
>  }
> =20
> +static void zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(pdev);
> +	int i;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	if (!zdev->pending_errs.mediated_recovery)
> +		return;
> +
> +	if (zdev->pending_errs.count >=3D ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued",

Missing "\n"

> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
> +		return;
> +	}
> +
> +	i =3D zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.tail++;
> +	zdev->pending_errs.count++;
> +}
> +
> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery =3D true;
> +}
> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
> +
> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery =3D false;
> +	if (zdev->pending_errs.count)
> +		pr_info("Unhandled PCI error events count=3D%d for PCI function 0x%x",

Also missing "\n"

> +			zdev->pending_errs.count, zdev->fid);
> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +}
> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
> +
>  static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev =
*pdev,
>  							 struct pci_driver *driver)
>  {
> @@ -175,7 +186,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pc=
i_dev *pdev,
>   * and the platform determines which functions are affected for
>   * multi-function devices.
>   */
> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev=
 *pdev)
> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev=
 *pdev,
> +							  struct zpci_ccdf_err *ccdf)
>  {
>  	pci_ers_result_t ers_res =3D PCI_ERS_RESULT_DISCONNECT;
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> @@ -194,13 +206,6 @@ static pci_ers_result_t zpci_event_attempt_error_rec=
overy(struct pci_dev *pdev)
>  	}
>  	pdev->error_state =3D pci_channel_io_frozen;
> =20
> -	if (is_passed_through(pdev)) {
> -		pr_info("%s: Cannot be recovered in the host because it is a pass-thro=
ugh device\n",
> -			pci_name(pdev));
> -		status_str =3D "failed (pass-through)";
> -		goto out_unlock;
> -	}
> -
>  	driver =3D to_pci_driver(pdev->dev.driver);
>  	if (!is_driver_supported(driver)) {
>  		if (!driver) {
> @@ -216,12 +221,25 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
> =20
> +	zpci_store_pci_error(pdev, ccdf);

Sashiko notes that zdev->pendings_errs.mediated_recovery could become
true between the above zpci_store_pci_error() and the below check for
leaving recovery to user-space. I think we could make a general
improvement that also tackles this concern. The ideas is that we could
have zpci_store_pci_error() return true if it did store the error and
we are in mediated recovery mode. Then we use that as the signal to
skip host recovery below. That way we also don't need to retake the
pending_errs_lock which makes the below much simpler and it would be a
win independent of the race. As for the race this would make sure that
we either do the host recovery or store the error and let user-space
recover.

>  	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str =3D "failed (abort on detection)";
>  		goto out_unlock;
>  	}
> =20
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.mediated_recovery) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +			pci_name(pdev));
> +		ers_res =3D PCI_ERS_RESULT_RECOVERED;
> +		status_str =3D "in progress";
> +		mutex_unlock(&zdev->pending_errs_lock);
> +		goto out_unlock;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);

Other than the missing "\n" and suggestion above this looks good to me.
So I'd hope to R-b the next version.

Thanks,
Niklas
