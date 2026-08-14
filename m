Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73B47CA78;
	Fri, 14 Aug 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720621; cv=none; b=m/MxwdRiLJcgyMp/9WslELn5gA8t4BJoNc3X19+mxg+ezqijA7y3CZYNQzX/jkd3qX36E71z3tiyGy+qaaQ4uZr2NaDxxINBtA3dLhnLtN8yMJZ68HdoUQ1otdSRNJSOMuJv2F1ypSauD4pNKVgq8PRXGLHp1ziRDH0S9bdzLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720621; c=relaxed/simple;
	bh=easrGihs+Y1fGw1uj9Ua6hDWJpMlYPztpSTk/FJCtdc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RawCRwgHchRsfuA3er416Nd8XavQKL4+xwSY83hMUnd57AHvkVxkTuU2bmcVeKrdeV6ieqOMaawaQGZ26BX/lxEL+L5evXsILkMlpLYJACNBHeItBMmyFz52xzd45wTaOuL6/otr0chst3fj2yNUDSd9EqdzvRYVhxjz3II5GKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e2nJmgSF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2nJmgSF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5bZN1342777;
	Fri, 14 Aug 2026 15:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CwKafk
	N+JBq6IyvF+UNMQZU0ZMIzS+yH3ejFO8GdRWU=; b=e2nJmgSFRHOD9mhPZjGhKk
	bwggTHE1S2WgjdI2ODaCQ220N6N6j9SYX+Lver/s1WPYYsHKoL/mLp6p1290k3ey
	ZGRXZhIGJ9OwcsWiyTfR4Jczgfv9uCpBueZa6zAlOgup4qsTXNbIBitx24W1P4fX
	c3SIR+RgTsM3GUS5w8b6nxj+jDNAb//KoZmJFNEQGEBxcF3r6plnsCBwzE0QhDYx
	wuD4Bf/5a2vIvBj0mWZ2aTpKpG3WVo+BQgYAsFZfSAcXj8LrdsVypaEhL/j85TZG
	E5gVzSnnEhwvQp0eKkWSTrF22clKhsv9kkN0cFnByH1ajQQ9MFPlmgoEPFDsQyTg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma5g0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 15:16:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EFBMPV002403;
	Fri, 14 Aug 2026 15:16:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvah9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 15:16:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EFGrf61049154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 15:16:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DEBA5805C;
	Fri, 14 Aug 2026 15:16:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5184758059;
	Fri, 14 Aug 2026 15:16:51 +0000 (GMT)
Received: from [9.111.8.241] (unknown [9.111.8.241])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 15:16:51 +0000 (GMT)
Message-ID: <0a7c5ae8a68b7603071aae49f75a65ae6d44bbe1.camel@linux.ibm.com>
Subject: Re: [PATCH v23 2/5] PCI: Allow per function PCI slots to fix slot
 reset on s390
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        alex@shazbot.org, mjrosato@linux.ibm.com, stable@vger.kernel.org
In-Reply-To: <20260814132607.GA1353174@bhelgaas>
References: <20260814132607.GA1353174@bhelgaas>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfX8ItEkIhe3M1b
 kj2LItY5IAMyrGevLqEzIeKd7SFY3vfA+FG6GyvuaK813Miwp7HZU48p0k+7lR3VL8ZA8Tod0yA
 3660LTcsXr1zoRCTq9Ioahxs8CdAqMzcLzUprwCO6BpmT+0FEBZDFWWJceKR3PTRHKrqz94T5pd
 9yJRAWVN95b26zjgJT9K9omkc5MXBgml6SlrIJlQpDNX0/ND3WULNPYXRwKtoH+P5yaxw0WWryb
 ggeTGzG5V3zXz2YbSE6lqVGY16Pndboklr/pzy6sdKMLHX9CCFGUAXEQEjtQ/bJeQsH7zLUX22k
 rX2bcjF4ip7ScvaZhYfzI4pfelHFLO1vlvF3mZVFt6vGoE4yWBfCyB/cTQ/QAD3oLdlb779ovM0
 GHP8FJKQdVKto7EmWRRv7f1XbXyLmpYMGyMeVU1v5EBbabRsikJNELIBXtnG/1xY+J2a94Hct30
 +TQ1kam920fPgtwBgRQ==
X-Proofpoint-ORIG-GUID: EFkFjz7ZLdiSRvcWa_jk3ETJe3viHZJw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfX658GXAsl8AqO
 jFIVw6/8BlWPQfyzxpFtCZRzG7iRTUV3gB/KbjjvDYFPKxTqUN27XOZoPIyzo0x1i2my0ck6nGj
 qiZSpcQmJSUlcQx0hJ3RNhgtq+qvAX4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f3167 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=M91HzHb04BXWXBx8-ZcA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: EFkFjz7ZLdiSRvcWa_jk3ETJe3viHZJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140114

On Fri, 2026-08-14 at 08:26 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 14, 2026 at 10:46:28AM +0200, Niklas Schnelle wrote:
> > On Thu, 2026-08-13 at 18:25 -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 05, 2026 at 09:55:15AM -0700, Farhan Ali wrote:
> > > > On s390 systems, which use a machine level hypervisor, PCI devices =
are
> > > > always accessed through a form of PCI pass-through which fundamenta=
lly
> > > > operates on a per PCI function granularity. This is also reflected =
in the
> > > > s390 PCI hotplug driver which creates hotplug slots for individual =
PCI
> > > > functions. Its reset_slot() function, which is a wrapper for
> > > > zpci_hot_reset_device(), thus also resets individual functions.
> > >=20
> > > Sorry to come back to this yet again.  I understand the issue with
> > > the wrong pci_slot being assigned for these s390 functions.
> > >=20
> > > What I don't understand is why we would use slot_reset() in the first
> > > place.  I would expect FLR instead.
> > >=20
> > > The hotplug slot_reset() path is used by pci_reset_bus_function().
> > > But given the order in pci_reset_fn_methods[], we would typically try
> > > pcie_reset_flr() first, and we would only get to
> > > pci_reset_bus_function() if FLR and the other resets are not
> > > available.
> > >=20
> > > Since these are actually multi-function devices, I'm surprised that
> > > they wouldn't advertise FLR support.
> >=20
> > Good question. The problem isn't that FLR isn't advertised or
> > unsupported. Rather we end up needing to use the slot reset when the
> > platform has put the PCI function in the architected error state which
> > blocks both MMIO and DMA similar to DPC and which we can only get out
> > of with the platform specific CLP Set PCI Function Disable/Enable
> > hypercalls. FLR still works if you have a function that wasn't put in
> > the error state but for most real world errors as well as some service
> > scenarios we do end up in the error state where a FLR won't work.
>=20
> I assume these are standard PCIe devices, but this architected error
> state doesn't sound like something from the PCIe spec.
>=20
> DPC works by disabling the link, but of course that blocks traffic to
> all the functions of an MFD, so maybe this is some s390-specific thing
> outside the endpoint, e.g., something in a Downstream Port that can
> selectively block traffic to/from a specific function?

Yes the error state is an s390 concept. It's implemented by firmware
which controls the PCIe root controllers which are hidden from Linux.
This firmware also controls the s390 HW IOMMU, though Linux controls
the translation tables. And it even controls the PCIe switches between
the root port and the endpoint. So firmware can disable MMIO, block DMA
and interrupts on a per function basis without dropping the link. If
the link is dropped it will of course affect the entire multi-function
device or even an entire I/O cage but then firmware will do the PCIe
level resets, link recovery etc. Then it will generate error events for
all affected functions and require a CLP based reset for each
individually. So even in that case we still work through it on a per
PCI function basis.

>=20
> To get to pci_reset_bus_function() where we can use the slot reset, I
> think all the previous methods, including pcie_reset_flr(), must have
> failed with -ENOTTY.  But I don't see a place that would do that.
> Maybe you remove the other methods from dev->reset_methods[]?

In our normal error recovery flow we use zpci_hot_reset_device()
directly. But with Farhan's series QEMU now needs to drive the reset
through vfio-pci. This happens on behalf of a guest which itself does
the CLP Set PCI Function Disable.

>=20
> In addition to whatever the CLP Set PCI Function Disable/Enable
> hypercall does to unblock traffic to/from the endpoint, I suppose it
> does an FLR internally?=C2=A0

Yes that's at least one of the options, it can also do PERST#, swap
links to alternate paths retrain links etc.

>  It must use some standard PCIe mechanism
> because the endpoint doesn't know anything about s390 or the
> hypervisor.

Yes, though our machines only support a limited set of devices and
firmware also knows what kind of device is plugged where, so while the
devices don't know about s390 the firmware may do device specific
recovery steps.

>=20
> I wonder if we should make some kind of direct platform-specific reset
> method, or maybe a pcibios_*()-style hook in the pcie_reset_flr() path
> instead of this somewhat convoluted pci_slot stuff.  But
> s390_pci_hpc.c is pretty simple and maybe it's used for things other
> than reset.
>=20
> Bjorn

s390_pci_hpc.c is also used for "sharing" PCI functions between
different Linux instances. Basically a hotplug slot with the power
attribute reading 0 represents a PCI function which is in a pool of
standby PCI functions which are seen by multiple Linux instances at
once. Once one instance write 1 to power the PCI function is configured
(aka attached) to that Linux instance and becomes exclusively owned and
the hotplug slot becomes invisible/is hot unplugged for all other Linux
instances that could previously see it. On the other hand when one
Linux instance write 0 to a hotplug slot the PCI function is returned
to the pool and other Linux instances get a hotplug slot hot plugged.

Note that even without this patch resetting through s390_pci_hpc.c
worked on a per-function basis since the linking from the hotplug slot
to struct pci_slot was ok which is also why this stayed hidden for so
long.

Thanks,
Niklas
