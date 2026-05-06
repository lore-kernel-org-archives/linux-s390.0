Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141C36B076;
	Wed,  6 May 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068514; cv=none; b=KTdCwII94DvxpDEpYXICH+4hjyQ5uq3oGS+B2fULnQPPXGPNuhzBF9pc4kJ6Il+y0ggJYTXWIg65blzVM/Y3ApMpmr19to4IqniNx/5vy6pZzYVA51zgcUzftOZrFrBmjko/VXkLgIyajgx1saTFFT9uR+alOlHt7jTszyWlFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068514; c=relaxed/simple;
	bh=gGdtUST4fqCMI5aragQarHPbqAz+nSxmli79okfECQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhNXxl/zeEbxbSCQmOVZWyCSsZtsSMzSnYO3Y96D5+kA1bz4OxY8v0xRIBtKJQX8LiVOhErVfnTO1hCCefocQFTtlczbe6z0G7CWcC1pFhNBEjMAUkkVGvWnsvGfqpXgVTagNPG2i6nmE/rRE7xBENo6k6hsBzSqZVYhZN+nlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d+bt+kyv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d+bt+kyv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BEOYZ2607845;
	Wed, 6 May 2026 11:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=80xvyG
	BFmJhMsf+HdiQjDdVc+NIsNXE903IN3ipzVrA=; b=d+bt+kyv5dIE+wMUUKOTeD
	DQ8x2cvtLQIDMwfqlMgb7IGX5QPSPM3S+5LY38cd80EIimunbDQYeZrKpO3EYgTI
	6XnNzNUE20B7tIhGFs5ZmkuChh9feHtc9CDQmU/vsmqWBhpzj2JSb39Uz59W1a00
	q3X+TPpOu0VmJxsDgb0I1BjzXBSjt6STvvX+N2jEejV8scmKIfbW05WyCdDS2Vfk
	DEIufpF22KOlziJV7Q0wy0r0yvOTAP0AO3MeYMbxrkVXEXmZI8mzu7PYEYt8YuxN
	kb1OAKqAYTV1x5LAB9VpKdaadvbF+ZtimI8mF0eWgurb9Z7q+A9powYOHSKO5wtA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1gen5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 11:55:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646BdYx9010541;
	Wed, 6 May 2026 11:55:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgdv9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 11:55:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646Bt2pX30671396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 11:55:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E43332004B;
	Wed,  6 May 2026 11:55:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA57B20043;
	Wed,  6 May 2026 11:55:01 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 11:55:01 +0000 (GMT)
Message-ID: <baeb0cc55005577fa17206078b977149ccfe1876.camel@linux.ibm.com>
Subject: Re: [PATCH v14 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Keith Busch
	 <kbusch@kernel.org>
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org
Date: Wed, 06 May 2026 13:55:01 +0200
In-Reply-To: <536665e8-47fa-48d7-b22b-1d7133001f74@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
	 <20260421163031.704-2-alifm@linux.ibm.com>
	 <e8758975c7e5007306096a165d05cf1ebf10ccec.camel@linux.ibm.com>
	 <536665e8-47fa-48d7-b22b-1d7133001f74@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: xY7pK-uAJLukro1WvnUBG3RJA8aNX2oZ
X-Proofpoint-GUID: xY7pK-uAJLukro1WvnUBG3RJA8aNX2oZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExNCBTYWx0ZWRfX2pFP9LOAN9x6
 VZOQmALvvpfsCo+2Ys1NkVXdoPn00zlVmmTInQEjhyknUvrFndB54jLDk08jc0NpI6nKFZuw7jl
 c8lo3uoBRQoyoQ2NiYu10jxTAKQlDsDCZvJGGejZ5Y5cds8zl2j0NQeFrcvHDOa3Fe0acJ09SWH
 EvzMHOx6Q7jN6jHzsZDBvTTeCaiFbm3yOcCAHvHLXJOD3WJUeqmZnOhALaeqiW0QxYzoyufiSbX
 Nv6sHgRttLyXufhSp6/00GOu/g040sSll0ltNcb8gN07y4XgWDJDfrk+k/BjD5T+a05/rYCrytj
 O9oZPUKAt5wrfXI/i9TnXbtFuP0iEPxlCNSyDpRgg0gsUtALGhac49mltATw/qe9i+7FJuHytDF
 uhQBcQw7ifd+brskamatWy9ZVhXAor8bH6NTsg5SCX7cvR74+6IOJBaRjALPcSV5PFOsBkl2HxW
 exrzXioZzSOxhRCUIkw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb2c1b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=TkIMvqyG76GkEbtQsGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060114

On Mon, 2026-05-04 at 10:00 -0700, Farhan Ali wrote:
> On 5/4/2026 8:52 AM, Gerd Bayer wrote:
> > On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
> > > On s390 systems, which use a machine level hypervisor, PCI devices ar=
e
> > > always accessed through a form of PCI pass-through which fundamentall=
y
> > > operates on a per PCI function granularity. This is also reflected in=
 the
> > > s390 PCI hotplug driver which creates hotplug slots for individual PC=
I
> > > functions. Its reset_slot() function, which is a wrapper for
> > > zpci_hot_reset_device(), thus also resets individual functions.
> > >=20
> > > Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot ob=
ject
> > > to multifunction devices. This approach worked fine on s390 systems t=
hat
> > > only exposed virtual functions as individual PCI domains to the opera=
ting
> > > system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunction=
s")
> > > s390 supports exposing the topology of multifunction PCI devices by
> > > grouping them in a shared PCI domain. This creates a problem when res=
etting
> > > a function through the hotplug driver's slot_reset() interface.
> > >=20
> > > When attempting to reset a function through the hotplug driver, the s=
hared
> > > slot assignment causes the wrong function to be reset instead of the
> > > intended one. It also leaks memory as we do create a pci_slot object =
for
> > > the function, but don't correctly free it in pci_slot_release().
> > >=20
> > Hi Farhan,
> >=20
> > sorry for jumping this late into reviewing this, but I think I'd prefer
> > a different approach than extending the slot member to u16 to make the
> > full range of 256 usable:
> >=20
> > > Add a flag for struct pci_slot to allow per function PCI slots for
> > > functions managed through a hypervisor, which exposes individual PCI
> > > functions while retaining the topology. Since we can use all 8 bits
> > > for slot 'number' (for ARI devices), change slot 'number' u16 to
> > > account for special values -1 and PCI_SLOT_ALL_DEVICES.
> > >=20
> > > Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > ---
> > >   drivers/pci/hotplug/rpaphp_slot.c |  2 +-
> > >   drivers/pci/pci.c                 |  5 +++--
> > >   drivers/pci/slot.c                | 33 +++++++++++++++++++++++-----=
---
> > >   include/linux/pci.h               |  8 ++++++--
> > >   4 files changed, 35 insertions(+), 13 deletions(-)
> > >=20
> > >=20
> > >=20

[... snip ...]

> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 2c4454583c11..d58982aa8730 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -78,14 +78,18 @@
> > >    * and, if ARI Forwarding is enabled, functions may appear to be on=
 multiple
> > >    * devices.
> > >    */
> > > -#define PCI_SLOT_ALL_DEVICES	0xfe
> > > +#define PCI_SLOT_ALL_DEVICES	0xfeff
> > > +
> > > +/* Used to identify a slot as a placeholder */
> > > +#define PCI_SLOT_PLACEHOLDER	-1
> > >  =20
> > >   /* pci_slot represents a physical slot */
> > >   struct pci_slot {
> > >   	struct pci_bus		*bus;		/* Bus this slot is on */
> > >   	struct list_head	list;		/* Node in list of slots */
> > >   	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
> > > -	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> > > +	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
> > > +	unsigned int		per_func_slot:1; /* Allow per function slot */
>=20
> Hi Gerd,
>=20
>=20
> > How about you introduce two additional single-bit flag members here for
> > - placeholder, and
> > - slot_all_devices
> > and avoid creating an artifically wide number member.
> >=20
> > Eventually, this means that the special cases "placeholder-slot" and
> > "bus-wide slot" should be broken out of pci_create_slot().
> >=20
> > >   	struct kobject		kobj;
> > >   };
> > >=20
> > Hope this makes any sense? It almost makes me wonder if this should be
> > handled with a pre-cursor patch to this...
>=20
> I would like to avoid doing this as part of this series, and not=20
> increase it's scope too much. I do see your point about having separate=
=20
> flags to indicate a placeholder/slot_all_devices, but I think we would=
=20
> still need the special numbers unless we want to change pci_create_slot=
=20
> API to pass in flags.

I think I found a way to keep that untouched with some additional
changes as a pre-cursor: Below, you can find what I hacked together
extending on your idea of introducing flags for the slots. That way I
was able to decouple the input parameter slot_nr (int) from the actual
slot->number member (u8).=20
Caveat: I *did* change PCI_SLOT_ALL_DEVICES (similar like you) - and
this is compile-tested only - and lacks all updates to comments.

diff --git a/drivers/pci/hotplug/rpaphp_slot.c
b/drivers/pci/hotplug/rpaphp_slot.c
index 67362e5b9971..92eabf5f61b9 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
 	struct hotplug_slot *php_slot =3D &slot->hotplug_slot;
 	u32 my_index;
 	int retval;
-	int slotno =3D -1;
+	int slotno =3D PCI_SLOT_PLACEHOLDER;
=20
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s]
pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6d5cd37bfb1e..b3d54197e8c9 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,20 +37,11 @@ static const struct sysfs_ops pci_slot_sysfs_ops =3D
{
=20
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number =3D=3D 0xff)
+	if (slot->placeholder)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
=20
-	/*
-	 * Preserve legacy ABI expectations that hotplug drivers that
manage
-	 * multiple devices per slot emit 0 for the device number.
-	 */
-	if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES)
-		return sysfs_emit(buf, "%04x:%02x:00\n",
-				  pci_domain_nr(slot->bus),
-				  slot->bus->number);
-
 	return sysfs_emit(buf, "%04x:%02x:%02x\n",
 			  pci_domain_nr(slot->bus),
 			  slot->bus->number,
@@ -82,7 +73,7 @@ static void pci_slot_release(struct kobject *kobj)
=20
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		if (slot->bus_wide ||
 		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D NULL;
 	up_read(&pci_bus_sem);
@@ -187,7 +178,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
=20
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
+		if (slot->bus_wide  ||
 		    PCI_SLOT(dev->devfn) =3D=3D slot->number)
 			dev->slot =3D slot;
 	mutex_unlock(&pci_slot_mutex);
@@ -267,7 +258,7 @@ struct pci_slot *pci_create_slot(struct pci_bus
*parent, int slot_nr,
=20
 	mutex_lock(&pci_slot_mutex);
=20
-	if (slot_nr =3D=3D -1)
+	if (slot_nr =3D=3D PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
=20
 	/*
@@ -296,7 +287,12 @@ struct pci_slot *pci_create_slot(struct pci_bus
*parent, int slot_nr,
 	}
=20
 	slot->bus =3D pci_bus_get(parent);
-	slot->number =3D slot_nr;
+	if (slot_nr =3D=3D PCI_SLOT_PLACEHOLDER)
+		slot->placeholder =3D 1;
+	else if (slot_nr =3D=3D PCI_SLOT_ALL_DEVICES)
+		slot->bus_wide =3D 1;
+	else
+		slot->number =3D slot_nr;
=20
 	slot->kobj.kset =3D pci_slots_kset;
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..9a27fddeb397 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,14 +78,17 @@
  * and, if ARI Forwarding is enabled, functions may appear to be on
multiple
  * devices.
  */
-#define PCI_SLOT_ALL_DEVICES	0xfe
+#define PCI_SLOT_ALL_DEVICES	-2
+#define PCI_SLOT_PLACEHOLDER	-1
=20
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on
*/
 	struct list_head	list;		/* Node in list of
slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move
here) */
-	unsigned char		number;		/* Device nr,
or PCI_SLOT_ALL_DEVICES */
+	unsigned char		number;		/* Device nr
*/
+	unsigned int		bus_wide:1;	/* created with
PCI_SLOT_ALL_DEVICES */
+	unsigned int		placeholder:1;	/* special case for
PPC */
 	struct kobject		kobj;
 };
=20

Nice side-effect: The special handling for bus-wide slots in
address_read_file() is no longer necessary.

Adding Keith Busch who introduced "bus-wide slots" just recently with
102c8b26b54e ("PCI: Allow all bus devices to use the same slot")
which actually added special meanings for slot 0xfe - which is not
always desired.

Maybe it is time to refactor pci_create_slot() into separate variants
for placeholder and bus-wide (and multifunction) slots... But that's a
bigger change that is out of scope here.

Thanks,
Gerd


