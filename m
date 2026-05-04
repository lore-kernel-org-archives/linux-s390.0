Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD839B963;
	Mon,  4 May 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909970; cv=none; b=X+0F2Nc8OwprA+oLtLbDF9DcHuAw/lbF9W2K1EFysyeG9NaP0ypDGCqQv07FpUSNqQ6Qm2UnoP/s3xn3ojiOEp6ps+O3/3HGS2iNxotFdA55ME3Dp4URl6d8RnK+W2mkL0RIRZDpvljGhIDfuPVSmSehcobiyybdfkl+1v+r8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909970; c=relaxed/simple;
	bh=mmRd1eJIEDRhJo4c2qOnszAGYWQ+LIHiRBlmKEOveio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOiaFSwhF1DR+AdA6L8x/kBNx0rwuxvltpA+k6FduSwaeP54ZP3M+ZKnUSYJRkGiV8jeOQGXBFDwlQt5LK3W0nWSI1DcRYDhngRP6ni79yB7yt9xrAvhu+psSCeYBoZp3isGk+rqq7Lc4XragZzNZROxwqIqid2yJJWee8wdNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PVBT2BJM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PVBT2BJM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448uEjI879334;
	Mon, 4 May 2026 15:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5nvSnB
	f9gLyHmg+Rq3gsVgQUg64M7WxU5t53cRgbb0c=; b=PVBT2BJMkirTxMWo031zHR
	Q97NOZMHtmvKfB73HjFtLGf4LlrrWYVsxMsuloVoO5yoTfn6DYRhTUUgT01KLugP
	Vzk0Huem/sUp5geDor2j/b5Ac3BxBh4/Bei0fiJc8WJx4l2YJT8F5QAO8YUWIDAk
	Ypha2GQmATtHj9usmXMz4fd/IuRlDmf1/lbd5ylzEW7TwE9F9Fpd5eE6fR1KIpYt
	tRNPNJA4kxCCmUiREKSRRgrSLMhfvztrFsCn/bo2AVTR9+UPIRi7ipGRgW+ZFuw8
	gcT1nKykFZ6rTN3RM9pHLKQmWtQhgOMSII5CI5H5O5OP/k/L38jHWtM1W3er7i+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4fshf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:52:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EsRAX017436;
	Mon, 4 May 2026 15:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq5y45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 15:52:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644FqcpS61866474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 15:52:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2683520043;
	Mon,  4 May 2026 15:52:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50E3020040;
	Mon,  4 May 2026 15:52:37 +0000 (GMT)
Received: from [9.111.24.118] (unknown [9.111.24.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 15:52:37 +0000 (GMT)
Message-ID: <e8758975c7e5007306096a165d05cf1ebf10ccec.camel@linux.ibm.com>
Subject: Re: [PATCH v14 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org
Date: Mon, 04 May 2026 17:52:36 +0200
In-Reply-To: <20260421163031.704-2-alifm@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
	 <20260421163031.704-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX9/Ql5X7w1FjA
 iQDPLKBeVq3ZHopJh0UQOLsgMrQtIhyQfRilRvStftz6OOgKhq+HfcHg6TQ16BDEioj29qwWaUs
 jCNpLVycSeASVj3peJJ7FAPpcB96uRu2edgCHrHds9ruYB3gbZVbvr6YJdJj7S8GaON805K6naK
 vjPfIdUefsNTux6M656eAmRkoBXo91CnkVj+H/Em8nGzCsi4pqUUbAxaPJ/JDcPoLMY+2zoMLpl
 P2B/V55tCoYJgckufJPBJ8WEfUNCXh+mlcwwnYbu71dWrzgpj7ccplcMcXkGGP3+/0FzqsBlMJ7
 pvWC2kdubf/o1OOu+adbh7PhK+BLa25sbN+8H6RIyDUzHATs+2v4yr43qsIZEjbLFlMD7FkpF0V
 324Wr80OFJr1kQ+liH3YfzipBwwiQWAr8wC1/OtMSNa2EJj06yO+9Od+dmKgM1mEvbKfJRfssC6
 1Uigf0Ue3tYsl/qyMwQ==
X-Proofpoint-ORIG-GUID: RUHU29tJsx3lGCDMbdRrrIZSFqxbHcB2
X-Proofpoint-GUID: RUHU29tJsx3lGCDMbdRrrIZSFqxbHcB2
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f8c0ca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bDQvo4m8Rz4M5vCSQ40A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040154

On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
> On s390 systems, which use a machine level hypervisor, PCI devices are
> always accessed through a form of PCI pass-through which fundamentally
> operates on a per PCI function granularity. This is also reflected in the
> s390 PCI hotplug driver which creates hotplug slots for individual PCI
> functions. Its reset_slot() function, which is a wrapper for
> zpci_hot_reset_device(), thus also resets individual functions.
>=20
> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
> to multifunction devices. This approach worked fine on s390 systems that
> only exposed virtual functions as individual PCI domains to the operating
> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> s390 supports exposing the topology of multifunction PCI devices by
> grouping them in a shared PCI domain. This creates a problem when resetti=
ng
> a function through the hotplug driver's slot_reset() interface.
>=20
> When attempting to reset a function through the hotplug driver, the share=
d
> slot assignment causes the wrong function to be reset instead of the
> intended one. It also leaks memory as we do create a pci_slot object for
> the function, but don't correctly free it in pci_slot_release().
>=20

Hi Farhan,

sorry for jumping this late into reviewing this, but I think I'd prefer
a different approach than extending the slot member to u16 to make the
full range of 256 usable:

> Add a flag for struct pci_slot to allow per function PCI slots for
> functions managed through a hypervisor, which exposes individual PCI
> functions while retaining the topology. Since we can use all 8 bits
> for slot 'number' (for ARI devices), change slot 'number' u16 to
> account for special values -1 and PCI_SLOT_ALL_DEVICES.
>=20
> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> Cc: stable@vger.kernel.org
> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>  drivers/pci/pci.c                 |  5 +++--
>  drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
>  include/linux/pci.h               |  8 ++++++--
>  4 files changed, 35 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpap=
hp_slot.c
> index 67362e5b9971..92eabf5f61b9 100644
> --- a/drivers/pci/hotplug/rpaphp_slot.c
> +++ b/drivers/pci/hotplug/rpaphp_slot.c
> @@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
>  	struct hotplug_slot *php_slot =3D &slot->hotplug_slot;
>  	u32 my_index;
>  	int retval;
> -	int slotno =3D -1;
> +	int slotno =3D PCI_SLOT_PLACEHOLDER;
> =20
>  	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] typ=
e[%d]\n",
>  		__func__, slot->dn, slot->index, slot->name,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..d0c9f0166af5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))
>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index e0b7fb43423c..3f6e5dce27a0 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops =3D {
> =20
>  static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  {
> -	if (slot->number =3D=3D 0xff)
> +	if (slot->number =3D=3D (u16)PCI_SLOT_PLACEHOLDER)
>  		return sysfs_emit(buf, "%04x:%02x\n",
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);
> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *sl=
ot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
> =20
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *s=
lot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn =3D=3D slot->number;
> +
> +	return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) =3D=3D slot->number;
> +}
> +
> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void pci_slot_release(struct kobject *kobj)
>  {
>  	struct pci_dev *dev;
> @@ -82,8 +99,7 @@ static void pci_slot_release(struct kobject *kobj)
> =20
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list)
> -		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot =3D NULL;
>  	up_read(&pci_bus_sem);
> =20
> @@ -176,8 +192,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
> =20
>  	mutex_lock(&pci_slot_mutex);
>  	list_for_each_entry(slot, &dev->bus->slots, list)
> -		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot =3D slot;
>  	mutex_unlock(&pci_slot_mutex);
>  }
> @@ -256,7 +271,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
> =20
>  	mutex_lock(&pci_slot_mutex);
> =20
> -	if (slot_nr =3D=3D -1)
> +	if (slot_nr =3D=3D PCI_SLOT_PLACEHOLDER)
>  		goto placeholder;
> =20
>  	/*
> @@ -287,6 +302,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
>  	slot->bus =3D pci_bus_get(parent);
>  	slot->number =3D slot_nr;
> =20
> +	if (pci_slot_enabled_per_func())
> +		slot->per_func_slot =3D 1;
> +
>  	slot->kobj.kset =3D pci_slots_kset;
> =20
>  	slot_name =3D make_slot_name(name);
> @@ -307,8 +325,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
> =20
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &parent->devices, bus_list)
> -		if (slot_nr =3D=3D PCI_SLOT_ALL_DEVICES ||
> -		    PCI_SLOT(dev->devfn) =3D=3D slot_nr)
> +		if (pci_dev_matches_slot(dev, slot))
>  			dev->slot =3D slot;
>  	up_read(&pci_bus_sem);
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..d58982aa8730 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -78,14 +78,18 @@
>   * and, if ARI Forwarding is enabled, functions may appear to be on mult=
iple
>   * devices.
>   */
> -#define PCI_SLOT_ALL_DEVICES	0xfe
> +#define PCI_SLOT_ALL_DEVICES	0xfeff
> +
> +/* Used to identify a slot as a placeholder */
> +#define PCI_SLOT_PLACEHOLDER	-1
> =20
>  /* pci_slot represents a physical slot */
>  struct pci_slot {
>  	struct pci_bus		*bus;		/* Bus this slot is on */
>  	struct list_head	list;		/* Node in list of slots */
>  	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
> -	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> +	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> +	unsigned int		per_func_slot:1; /* Allow per function slot */

How about you introduce two additional single-bit flag members here for
- placeholder, and
- slot_all_devices
and avoid creating an artifically wide number member.

Eventually, this means that the special cases "placeholder-slot" and
"bus-wide slot" should be broken out of pci_create_slot().

>  	struct kobject		kobj;
>  };
>=20

Hope this makes any sense? It almost makes me wonder if this should be
handled with a pre-cursor patch to this...

Thanks,
Gerd
