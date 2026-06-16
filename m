Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4144D686;
	Tue, 16 Jun 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624489; cv=none; b=J++tiYW1dmgKz0I9Z/AcQU9ncafZYu4i92CtBeojV9sQ/pcoD2DQNa/qfM1oqShUgH0nnZ1iqmRyrNaFffuX3BueJwjgq4zPkXY48be27xJw2Gd/DxLW61Uu9dT1aHuMAIqzArSUTB7Xz1SMhkJs9rpoCMTciDUQSspXHwy62rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624489; c=relaxed/simple;
	bh=ci+UPfHl9w2sbjgJBM6U0uH9tN6siWTlTRuJj7ZSB6Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BQ9aS0wa8zy16iLSMKAEkkVQ4dV8e3zTIwGkRwn2RgLonCN28jI8+7v1YM//nwW9zhM8ie5XPY4gjrLPO2UeSMFhrlj2vMABkC/nLVVYky43WfjG0zrJ8QPmugO0MkFRI/q4v0VjcWY9898gvfJR+PZ5xFUlsBB0+56SnxYHa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OD/XtXIi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OD/XtXIi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GEIFfG1652767;
	Tue, 16 Jun 2026 15:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VqTSkW
	MDhPtujS8jrLfubZSY4AjyzSzuRprOifqz6bY=; b=OD/XtXIi0C8uIHoiqmUtMO
	5iDwekcKeFRpccAdZpfcb6gkJLaXqV2WZHicUPt83QjlYM2mPL4VnjrW8JCnIlBh
	Zr/j0ro9Ggqs3kSv+Qm0QMp0z7P6FFMV19S/vPghTawZUU7rAPIrMH0UqIBE4lBW
	h6eZKAhkyfEZ9O2lVHzOS/ou2IeUiUmNTdj/ri+7LIy0LeI+wo3JZHxW5EHFwpkE
	WlKJMu+Q2/+mM9QzYA3TuKpIBPufuy0jyRCk+w+UEGxjY9ASghNlsVL5oT7A/7GJ
	QpeZsyx+w/j8nnP+2T+OiNk+zHTqqxv+rv6lW586+/LG8FZUWAtnUoSQLgSfFEvg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0p367-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 15:41:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GFYbZh021961;
	Tue, 16 Jun 2026 15:41:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq492p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 15:41:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GFfLIH14222042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 15:41:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC4F5803F;
	Tue, 16 Jun 2026 15:41:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5121B58060;
	Tue, 16 Jun 2026 15:41:18 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 15:41:18 +0000 (GMT)
Message-ID: <ec9d383ff4881945a6b242a37e4024cacc406261.camel@linux.ibm.com>
Subject: Re: [PATCH v4] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Ramesh Errabolu
 <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas
 Wunner	 <lukas@wunner.de>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew
 Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Leon
 Romanovsky <leon@kernel.org>,
        driver-core@lists.linux.dev
In-Reply-To: <20260521144853.GA163149@bhelgaas>
References: <20260521144853.GA163149@bhelgaas>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 17:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0bs4HoeCo7b3Q4cWp070UfjONMV3zP0x
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a316ea3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8bvjBKMlFFBRua3M5rcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1NyBTYWx0ZWRfXzJMTSqPvmT3l
 5qEbGnRY3AFfcrbIchHfE2YSNj7zMbtZjpd6sPzCOPtRdThHWYsRQ3jigb/N97fWKuXYikCCFnA
 KulnugO89jrxX1bZ0OZ0owIwCqwn6jl4qy7qrANos+QYfi+pCykV4wGIL/+PcUdaS9uHMyW9CIK
 dYS2lqZiJPdHPDJQvpYOuHM27Dsp51MLAUkKjrt7wC5nHYqE2kdL3csLSEh2jUCfctITyZtgVxN
 /93ahSWFlnXAXVjN7uDQNLj83fi0qOtNcjM7ZyYwi/1tyzd7DXlHiOOxurtrfk8NHp7/t8ym67v
 TQ3V1P/P5dJ+KHP6R8BWL2nGsvQhGq8M+2chVudg/pKTNrzPvOV0PysHnZCn7FxIwd8cFamYtX7
 eCgTbwJHIFgWPh/Js/pSUqwsBqqaip+198BNxxMS6KQjr4x+GEdbdByDbFl7Jh4ejTF0jZY4aBL
 IvR4GPIKQLh7LEBN3VQ==
X-Proofpoint-ORIG-GUID: ssdctJVrL45gDjVG8uRjJP6sQsBeU9GK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1NyBTYWx0ZWRfXxJvr+k4o8m/K
 mePr1e0HK79uGiXtM839OF2Cd0MJL6AvdVVRjI6dRu2nHBgRMq1XyzSxr4Rg6TktSz9Zq4LMtoh
 vZAlmWteSiD/oAYuPY+o0keKWqUrDr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160157

On Thu, 2026-05-21 at 09:48 -0500, Bjorn Helgaas wrote:
> [+cc Leon, driver-core]
>=20
> (Ramesh, when you post new versions of a series, please cc anybody who
> responded to earlier versions.  Also, v2, v3, and v4 are identical, so
> there's no need to post them as new "versions"; you can just ping the
> original thread or label them as "RESEND")
>=20
> On Wed, May 20, 2026 at 05:13:20PM -0500, Ramesh Errabolu wrote:
> > Add a write-only 'uevent' sysfs attribute for synthesizing
> > uevents for a PCI slot. This extends the existing uevent
> > support which emits a KOBJ_ADD uevent in pci_hp_add() with
> > the ability to replay such uevents for cold plugged devices.
> > As such events are only emitted by hotplug capable PCI slots
> > so is the support for synthesizing them.
> >=20
> > The change was validated by manually triggering 'add' uevent
> > for a specific hotplug PCI slot:
> >=20
> >     $ echo "add $(uuidgen)" | sudo tee   \
> >                 /sys/bus/pci/slots/<slot-id>/uevent
> >=20
> > Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotpl=
ug/pci_hotplug_core.c
> > index fadcf98a8a66..c3634b1cc7a8 100644
> > --- a/drivers/pci/hotplug/pci_hotplug_core.c
> > +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> > @@ -173,12 +173,27 @@ static ssize_t presence_read_file(struct pci_slot=
 *pci_slot, char *buf)
> > =20
> >  static struct pci_slot_attribute hotplug_slot_attr_presence =3D {
> >  	.attr =3D {.name =3D "adapter", .mode =3D S_IFREG | S_IRUGO},
> >  	.show =3D presence_read_file,
> >  };
> > =20
> > +static ssize_t uevent_write_file(struct pci_slot *slot,
> > +				 const char *buf, size_t len)
> > +{
> > +	int rc;
> > +
> > +	rc =3D kobject_synth_uevent(&slot->kobj, buf, len);
>=20
> I haven't followed the discussion closely, but I'm skeptical because
> this would be the only use of kobject_synth_uevent() outside the
> driver core.  That means a change like this should include a
> description of something unique about this PCI slot situation that is
> different from all other buses.
>=20
> For driver-core, the preceding discussion is here:
> https://lore.kernel.org/linux-pci/20260225150815.81268-1-ramesh@linux.ibm=
.com/t/#m57bf51ce1c073b685b391867d4a9932e5f9dccc9

Sorry for the late reply. In the previous discussion we decided to move
this here because this is the same file where the existing add uevent,
which we're trying to synthesize for cold plug, is handled in
pci_hp_add().=C2=A0So from our point of view this is really a missing part
to that existing uevent support that is causing real issues for us. In
particular we need to be able to create udev rules that react on
plugging of an s390 hotplug slot. On s390 a hotplug slot being plugged
is how the (machine) hypervisor makes a PCI function available to the
system where the function may first appear as powered off to multiple
Linux instances and only gets actually attached once one instances
powers it on. For example such a rule would be used to automatically
power on the function in cases where we know that we're the only
instance that will see it. Of course we'd like to have the same rule
handle hotplug (works already) and cold plug during boot (needs
synthesized uevents).

As for what's special, I think it is that as far as I understand the
PCI hotplug slot "drivers" don't seem to be well integrated with the
driver model. For example neither our s390_pci_hpc nor the acpiphp
hotplug driver seem to actually have an associated struct device_driver
nor do these hotplug slots appear on a bus which I guess would allow
using the bus's uevent.=C2=A0Fixing that does seem like a much bigger effor=
t
though.

There is also the call to kobject_synth_uevent() in
kernel/module/main.c which looks at least somewhat similar. But yeah I
do see your point that basically all other drivers and devices get
their uevent syfs file from the driver core.

Thanks,
Niklas
