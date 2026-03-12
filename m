Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776133BBB4;
	Thu, 12 Mar 2026 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349450; cv=none; b=sJZvTkOT4sFpkBihrUK5s8IrwdlWyxvxt+soW55vWFsuSG3MA6/5zrhe9g2GR6xw+VMQA/QCOf4xkFXRRGCqncM4/goTliq7EhcMAz1oOP3Pi6mVcHlFQ/1Nf4ZxUrg6QkiYaEJFs9kEnyY8RrD3cZS2ja3zmGkpKqDQuJu0Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349450; c=relaxed/simple;
	bh=mC5rww3WeIqUrS8X2I+Zlj7pyHjsi7WsHz0UPaQ1nek=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FbmtIRZ0eFTp9L8QlfzxOCgfXMIiH6stf9l9mgQOViVrXjOdZ8ua8xD15dfb2a6ec6xRLNLEvmsnP0za6mUvYHL6UrghzLfrp3DU1bkacIxjv5LT88v5SwI530Vivat8cO1dR+8Bn+NNYVcQiEBU7sk+3zLFoqXyWyNHrPKVQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rlA4zFXH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rlA4zFXH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CF4SsL2277765;
	Thu, 12 Mar 2026 21:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dvd7qq
	bC3/OKkT0vWcBun7ATQTDCNMlvRy4boGOPxcI=; b=rlA4zFXHYK/PRPXfVvrT9R
	d6JIlyvcdJ5RxKqyHwrCd+yh4n6UMkg06gXAI6+BUpKynU4bIWsCRoVxUq+qIf61
	Z+1GUyzgl+anTceBRJMHmUI5jjjwRl7IILwAHObV0hGsd0xsL5c8mjwcpufkS2jW
	KzXebFszQctkxOqwcHgBLpQ6nWtIezJIH69zq7fZQ+hAEIFg4Q4I6ic3CGR1PI1b
	Lq88Y64RVTFB68Bz/VHRqpemx/qmD5Zl5ltupU1nr4+27HmApUm6P2Obxu81QtqY
	/FVgZGEK0pCt1SS2Omix7pmnXSrw403Uy0UhbAge0kE+Ro7mJlZ2cT3tV8o4m6FA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91mv17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 21:04:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CIMW8P020811;
	Thu, 12 Mar 2026 21:04:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9m2a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 21:04:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CL444Z54526332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 21:04:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B12658056;
	Thu, 12 Mar 2026 21:04:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E83D58069;
	Thu, 12 Mar 2026 21:04:01 +0000 (GMT)
Received: from [9.111.17.170] (unknown [9.111.17.170])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 21:04:01 +0000 (GMT)
Message-ID: <df10e28bd86227dfd4830c34da8c68976df5e938.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] s390/pci: Fix circular/recursive deadlocks in
 PCI-bus and -device release
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>,
        Alexander Gordeev
	 <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens
	 <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-pci	 <linux-pci@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Ionut
 Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com>
References: <cover.1773235561.git.bblock@linux.ibm.com>
	 <354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2026 22:02:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6z7-w9WXyRuiIhLpyWNTk17x9mH6rA6u
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b32a47 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8 a=gz_SD1EWZaZO4LduKPQA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE2OSBTYWx0ZWRfXycccHIAqdSQ5
 I5XFquz8BxZLaEVI/N5CLq/M22RT/RSo7An9KAVDYOL9nv5+Ib2D5dJZjkUSvTNP5WwrN+Xau2G
 XrF+8yOi7l7J9BtKanhuKQAmdtQKDRr62EkL7su0aFBSfGxfie5y3QpifODnXrWdcHw4MexRcC/
 VQCj4bt68H4z6JWM/ZKbQgQTBH7x4C7EDY4RPft1FO2ES08e7jKzEULwNG8CjxjyhoAZHvORpBW
 yLWP3DTteEAfasZ+ZAhjBeNs5b7Rx3PVWFnPF/eK/CJ71kjhstlsJEKJQlq7H8gw0SgRTtpcrH5
 O75Kjpv5iD/iEmYnwt9yYyZftELLXhEgzzknyHQtJjh2ZhcTP6ODAcLYwVHTFeooqfsDDmgtMJA
 +LzyaAo7trSqeLyYVHIJsAj7juPO4t9Xclh0S2GnbJkN9U+/9on7E/qoosyeD8XY72WUfevfOI3
 lMIvNgApBVm6qKMGXLg==
X-Proofpoint-ORIG-GUID: 0n5ehpyqdMD2aq-9n0nVryNCy-7FhUf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120169

On Wed, 2026-03-11 at 14:27 +0100, Benjamin Block wrote:
> When removing PCI device or PCI bus objects there are a couple of
> call-chains where it is possible that the kernel runs into a circular or
> recursive deadlock involving taking the central `pci_rescan_remove_lock`.

Now that this depends on Ionut's patch at[0] and exploits the fact that
the rescan/remove lock can be taken recursively we may want to adjust
and thereby shorten this description to take this into account dropping
the recursive locking as deadlock reason.

>=20
> For example:
>=20
> (A) Thread =CE=B1 receives a CRW event notifying the kernel that a PCI

Nit: Other PCI related code calls these "PCI events" even though
technically they use the Channel Report Word (CRW) mechanism and thus
are CRW events.

> virtual function has been moved into Reserved state, and so the PCI
> subsystem will try to remove that PCI function. The call-chain for that
> looks like this:
>   __zpci_event_availability()
>     -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
>                                     # and    lock(zpci_list_lock)
>     -> zpci_release_device()        # will unlock(zpci_list_lock)
>     -> zpci_cleanup_bus_resources() # will   lock(pci_rescan_remove_lock)
>=20
> Thread =CE=B2 is triggered by userspace writing 0 into the SysFS attribut=
e
> `sriov_numvfs` of the parent PCI physical function of the same function
> we just try to remove. This will also try to release the PCI virtual
> function; but this time the call-chain looks like this:
>   sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)

With Ionut's patch a prerequisite the above taking of
pci_rescan_remove_lock now happens in sriov_del_vfs() with a bit
shorter chain but same result.

>     -> ... (deep chain)
>     -> pci_release_dev()
>     -> pcibios_release_device()
>     -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock)
>=20
> If thread =CE=B1 and =CE=B2 coincide, this will result in a cyclic deadlo=
ck.
>=20
> (B) Consider thread =CE=B2 from above; if the thread was to follow the sa=
me
> outlined call-chain for thread =CE=B1, and not fall into the cyclic deadl=
ock,
> it would recursive deadlock:
>   sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)
>     -> ... (deep chain)
>     -> pci_release_dev()
>     -> pcibios_release_device()
>     -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
>                                     # and    lock(zpci_list_lock)
>     -> zpci_release_device()        # will unlock(zpci_list_lock)
>     -> zpci_cleanup_bus_resources() # will   lock(pci_rescan_remove_lock)

Since Ionut's patch must come before this, this behavior itself would
be okay (see argument above). Maybve just drop this part?

>=20
> (C) And even in case `pci_rescan_remove_lock` was removed from
> zpci_cleanup_bus_resources(), the resulting call-chain would recursive
> deadlock when it tries to release the associated PCI bus:
>   sriov_numvfs_store()              # will   lock(pci_rescan_remove_lock)

Same as above after Ionut's change the lock is taken in sriov_del_vfs()

>     -> ... (deep chain)
>     -> pci_release_dev()
>     -> pcibios_release_device()
>     -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock),
>                                     # and    lock(zpci_list_lock)
>     -> zpci_release_device()        # will unlock(zpci_list_lock)
>     -> zpci_bus_device_unregister()
>     -> zpci_bus_put()               # will   lock(zbus_list_lock)
>     -> zpci_bus_release()           # will unlock(zbus_list_lock),
>                                     # will   lock(pci_rescan_remove_lock)

Same argument as above for dropping the recursive deadlock part but the
below cyclic deadlock potential remains.

>=20
> It can also easily be seen that scenario (C) offers the same risk as (A)
> for a cyclic deadlock in cases where `pci_rescan_remove_lock` is first
> locked, and the PCI bus released under its protection.

I think this part should spell out which two locks create the cycle

>=20
> `pci_rescan_remove_lock` has to be and is taken at a "high level" in
> most call-chains since it is intended to protect/mutual exclude all
> rescan and/or removal actions taken in the PCI subsystem. So to prevent
> the outlined deadlock scenarios above remove it instead from the "low
> level" release function for both the PCI device and PCI bus objects.
>=20
> Instead, lock `pci_rescan_remove_lock` in all call-chains leading to
> those release functions:
>   * initialization of the PCI subsystem;
>   * processing of availability events (CRWs) for PCI functions;
>   * processing of error events (CRWs) for PCI functions;
>   * architecture specific release PCI device implementation.
>=20
> Additionally, remove `pci_rescan_remove_lock` from zpci_bus_scan_bus()
> since it is now always already taken when called.

Nit: I'd add an explicit statement that the locking order between
pci_rescan_remove_lock and zpci_add_remove_lock is thus reversed with
pci_rescan_remove_lockk always taken first then zpci_add_remove_lock.
Still it is understandable without it too.

>=20
> Lastly, document the new locking expectations after these changes. Add
> sparse and lockdep annotations to functions that previously locked
> `pci_rescan_remove_lock` explicitly, making sure the lock is now
> already held when called. Additionally also add the annotations to
> zpci_zdev_put() and zpci_bus_put() to make sure that every function that
> potentially drops the last reference already holds the lock to prevent
> surprises.
>=20
> Fixes: 05bc1be6db4b2 ("s390/pci: create zPCI bus")
> Fixes: ab909509850b2 ("PCI: s390: Fix use-after-free of PCI resources wit=
h per-function hotplug")
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c       | 11 ++++++++---
>  arch/s390/pci/pci_bus.c   | 15 ++++++++-------
>  arch/s390/pci/pci_event.c | 28 +++++++++++++++++++---------
>  arch/s390/pci/pci_iov.c   |  3 +--
>  arch/s390/pci/pci_sysfs.c |  9 +++------
>  5 files changed, 39 insertions(+), 27 deletions(-)
>=20

I had not previously looked at your commit message from the point of
view when it is ordered aferr Ionut's patch[0], which it has to for the
release case. So I ended up with a few comments now even though I
previously read it multiple times and was just very happy with the nice
and readable call chain and locking order explanations.

Either way the code itself looks good to me and I also did quite a bit
of testing with this and the previous versions. Trying hot(un)plug and
SR-IOV with various PCI devices and also just ran this and the previous
version on several test systems for a few days doing other testing and
development work.=C2=A0

I also put quite a bit of effort into trying to modify this and/or
other s390 PCI code to not require the reentrant behavior of the
pci_rescan_remove_lock but failed. The really tricky part to me is how
e.g. a driver can hold on to a struct pci_dev even after it has been
removed while we have to keep both the struct zpci_dev and struct
zpci_bus and associated struct pci_bus exactly until the last
pci_dev_put(). And then needing to remove the PCI bus via
zpci_bus_release() we need to have the pci_rescan_remove lock but now
this can happen, in principle, at any pci_dev_put() and that of course
sometimes happens when we already have the pci_rescan_remove_lock and
sometimes without it.

So feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

[0]https://lore.kernel.org/lkml/20260310074303.17480-2-ionut.nechita@windri=
ver.com/
