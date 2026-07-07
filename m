Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F692874F5;
	Tue,  7 Jul 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415802; cv=none; b=IDgX+MHDQtC5SAtIq/fwNyMBj/RGDj/+5XedZ176hzOGx/CrpKxf+FJxcbA/yID4SAJ2n3w5wPxGL5TUWWcV8v4KPkGLtaaw3RQTUFPxvKJfHLD2+1CtT1VRTkNgF3kaqQyotwj+qUr/nbtTLH31Bk/VbOW/KFnDwBHmw6RAbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415802; c=relaxed/simple;
	bh=RhCA6WDr94FZziGv/8+lk11879pQLUdz8zSxlUS8zM0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WQRZf29RG7l1CRoNzsdJtEmk2k7FPC03EdBavxnpHAnDF3m7pp13umsw7p/fugZ6GZOy1omXLamzIEJkYjPpShiNEGw/OCg3TsZ0pSyuFyMnllbv336e5dTcuAaB4Xxd48tOC1NXFjNLHJ14zu9ahcHARZrpLnUNyPFzcl5hFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WCmxsDsb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCmxsDsb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IIC63129670;
	Tue, 7 Jul 2026 09:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kT3YUd
	5ZWB1X+FE0bR6RzjxkpMiDLuGWWT/G5hR+3qE=; b=WCmxsDsblUKe4MOrI4DKEm
	GClQLX7tO537P+Tgv7ADBwabzW2VGNpfRRLLUSJVF/200jIpk3Q9XRvQb6/KGo1T
	BuEa7ol6oSJs/ldtUiHwxy37Jrk8cujfcQNW7KE74CF0y3dZDY9OAzRl/cTzq8/w
	iLg52NwPJMFjLcFSFz81CnUbYNOjcTjSLw8oG7Y+ceB+5JncMjAHUUChz8dPvWiS
	tO/Lv4wSbpEB8gdecd0295CalS/nsrrj+UBPhX/mEer6GhDL1HogiyHLyu5dexyX
	HuOo50XUX1bhHWH65OAdxsbcr8Q0iteYpG35DRyYnx4bLW77Odd8OKaWXQWWXQvA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkne5k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:16:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66794edM021743;
	Tue, 7 Jul 2026 09:16:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y1pg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:16:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6679GXZ866257162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:16:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D97358063;
	Tue,  7 Jul 2026 09:16:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680445805A;
	Tue,  7 Jul 2026 09:16:30 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:16:30 +0000 (GMT)
Message-ID: <66fdb5ef25cdf733729b74b703de1a43b6b6a0af.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas
 Wunner	 <lukas@wunner.de>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
        Leon Romanovsky	 <leon@kernel.org>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>,
        Gerd
 Bayer <gbayer@linux.ibm.com>,
        Heiko Carstens	 <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	 <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260706200244.91130-2-ramesh@linux.ibm.com>
References: <20260706200244.91130-1-ramesh@linux.ibm.com>
	 <20260706200244.91130-2-ramesh@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 11:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4cc3f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UsWzb1JqLrbQIGmqEtMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e_HWy8tQjchuFL4SII3clCw7a_ZQN6B2
X-Proofpoint-ORIG-GUID: Wkhl1LmdpEfP6aKxXLstF3y2Yq1Tr-y3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX5zidlpsvSl2m
 mDv1cnobnrqUJY+a6KuqBZIeuapht7CcCMYQfFCJHwue4JhHGUUNNo8MGfln6nErCLMjZfnLhwf
 rcEDELvObliYMACX2MLl26DCNeAMEhk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX2MeGr6cncIGK
 o3YeOSGJRK7BwzlZ7RbsY1/TeJmzr8jUTNMb/6yLDUcssBdTmoiUHrbhBq94Llg4VYgyEkwOdST
 Fcx4CwlI0wTRRoDkg2CLh1C90uq60qTu1TV5ALoz2gVM11MwvO8gfqiA3b0CvO7teIQ0qS3abe+
 wBnMrwOeqHpfwXuWh2iuoHyBG9/QzMH1IcUo7PlTmJaGoo08KA7tiS2h1saS+71PcVWKAR5Bj5a
 ff5koSRj257HIVioAG/uuCwW/mPvMQSHwjLdnHDAF0SwrUOqwQftUAO4qZdWuBNYbs/T0Na2HL+
 WRR6rTTYYHFi5dbvWUnxYfnKGrCAL/RkqzojUrjha3iWWAxQ8A2lXfUTQLmpoFDGb3k6U3jRLXv
 Xw6zXJ+zkFS/uUwNn1r/maFqfviPHxJqSD+l5ag+nMSm7df6uMD/5+gfm9vHHncGaApirNI2Hxt
 lXksM53myWuDqrmqdfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

On Mon, 2026-07-06 at 15:02 -0500, Ramesh Errabolu wrote:
> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
>=20
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
>=20
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
>=20
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug=
/pci_hotplug_core.c
> index fadcf98a8a66..c3634b1cc7a8 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -173,12 +173,27 @@ static ssize_t presence_read_file(struct pci_slot *=
pci_slot, char *buf)
> =20
>  static struct pci_slot_attribute hotplug_slot_attr_presence =3D {
>  	.attr =3D {.name =3D "adapter", .mode =3D S_IFREG | S_IRUGO},
>  	.show =3D presence_read_file,
>  };
> =20
> +static ssize_t uevent_write_file(struct pci_slot *slot,
> +				 const char *buf, size_t len)
> +{
> +	int rc;
> +
> +	rc =3D kobject_synth_uevent(&slot->kobj, buf, len);
> +	return rc ? rc : len;
> +}
> +
> +static struct pci_slot_attribute hotplug_slot_attr_uevent =3D {
> +	.attr =3D {.name =3D "uevent", .mode =3D S_IFREG | 0200},
> +	.show =3D NULL,

As Bjorn Helgaas noted on v4 this ".show =3D NULL" is unnecessary. This
feedback should have been incorporated. And without that change there
is, as far as I can tell, no change vs v4 so this should have been
"[PATCH RESEND]" which Bjorn also told you in the same mail.

Thanks,
Niklas

[0] https://lore.kernel.org/linux-pci/20260521144853.GA163149@bhelgaas/
