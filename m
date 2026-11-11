Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403824;
	b=wYWZsjGSy7VidY/lE9gh21xYAEV3SKC+Akar1Q3TYbAuZMigAIG5jFaZGCo34L0TaKtV
	 D/FoyurYXSfB2uXYVxQm+7ZftxZdhZx0KzvITOl8QXbJaEZW0QOTJyFVoaJA5BFIKGEHU
	 boN4hJtVa9s9UQuD7p/Z2BAx6qz8QlpefWttJdRR8Y5lV/T00yMFdKJPL/fTFHIERRQY6
	 HhgU5HnuB8h9Ife2IIYfx/WJT7xr7t6ZJwgmXr8b6nBmNXR3NduBNzGHjUOzfhez8nLuI
	 spIJ8YQ5nJDgUbgq+xD5FHYa8vBFIkfFdXJ2Gzo2SqATwDHqXG0zY5FTDqFAKOXbqbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403824;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vJ2dUUZCJGSHVy+N9jFxxvcVlyEBSBDtM55u9FMgeyE=;
	b=yJvSShGCCFj0I/TqvGEyKvpX/KhIRkhue0M4P5IHbqlPsT5TxA0XoDRZKWGWyeNQv1Qq
	 Ym6Dq+qg/cUz3b3RcE1XylSS9hVMM1+Q6Dw6PwN7D6U/N+2GuvbojhvjlCxb0EECzTPHa
	 NIJJBuA/YoKaIovc/AnX7AGs3XqmEYIhmX9DEhLmisXN2BhAFKOa05qIcoiz/nM1czZoz
	 JopS4t/VhmQoedk33wMYXbkTv1S4wVERO45w74yZCmRLvkmQe0WUwGSso45aMvxOUv7ZY
	 ogoN3uP21OCJwIZVff25S0gdXjmNPSnJjUR3zLCRrdJTMKsc+Ryz/fSbCpmEWdEEuZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="ei6IDIE/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFB606A32A;
	Wed, 11 Nov 2026 13:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AFB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ei6IDIE/
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCimbW1145607;
	Wed, 11 Nov 2026 13:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vJ2dUU
	ZCJGSHVy+N9jFxxvcVlyEBSBDtM55u9FMgeyE=; b=ei6IDIE/R5IK1aSjm/JJtJ
	rweoEk1alSMyDBenEHcPMuwFfi0HTTSEGJBmjQTeKPFUI55BDD1K960CCbWtmyWI
	TkVqBZsGtK68APk9qq/2z4GuWyqtcIaXgsoEaDncAZYCXf5Y8MMbOV3vhNNQ0IvV
	5z+UOf5JYFHjQib40MH96J5W7gjWfNwlUumHiUDleL23ZRMgbm4+fUYh3cp89tQr
	UF81u/zIyH5b+cV0kowMIMID/mm1mgqv6wT3Imm6Mk4KoyMliDZtpVSZSdsyyAFk
	jPF5Y+hZ3BiN8p3QOl09WXZI7fLp0EOYCafktTF/NcUxhNP6lWJrXJ3zlLCEfGYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq72c3j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 13:29:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYs0T3379745;
	Wed, 11 Nov 2026 13:29:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsv86q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 13:29:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABDTrgn33358522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 13:29:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C04A58054;
	Wed, 11 Nov 2026 13:29:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4559A5805A;
	Wed, 11 Nov 2026 13:29:47 +0000 (GMT)
Received: from [9.111.22.168] (unknown [9.111.22.168])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 13:29:47 +0000 (GMT)
Message-ID: <757b59869b1a58e714d6a411f7c5a4714d0f959e.camel@linux.ibm.com>
Subject: Re: [PATCH v15 1/5] PCI/IOV: Make pci_lock_rescan_remove()
 reentrant and protect sriov_add_vfs/sriov_del_vfs
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>, Benjamin Block
 <bebl@ategam.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens	
 <hca@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        piotr.piorkowski@intel.com, Farhan Ali <alifm@linux.ibm.com>,
        Halil Pasic	
 <pasic@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Lukas Wunner	
 <lukas@wunner.de>, Guenter Roeck <linux@roeck-us.net>,
        Manivannan
 Sadhasivam	 <mani@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Ramesh Errabolu
 <ramesh@linux.ibm.com>,
        linux-kernel	 <linux-kernel@vger.kernel.org>,
        Sven
 Schnelle <svens@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        Andreas
 Krebbel <krebbel@linux.ibm.com>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ionut Nechita	
 <ionut.nechita@windriver.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-pci
 <linux-pci@vger.kernel.org>,
        Ionut Nechita	 <sunlightlinux@gmail.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390	
 <linux-s390@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>, stable@vger.kernel.org
In-Reply-To: <3e3bfc04a89459de57c4783734ff56e4ec979db0.1790267348.git.bblock@linux.ibm.com>
References: <cover.1790267348.git.bblock@linux.ibm.com>
	 <3e3bfc04a89459de57c4783734ff56e4ec979db0.1790267348.git.bblock@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:28:46 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX4spW+bdZtEdO
 ar8AL2puVV37v8xLEuWdydbvJGCAfZv7jhQMxP4spXqglOTESXJyECpmvLgw3//SzfYdoKCbjcT
 crvjrrdRvWAhi5LeOAhkb0SAL0tie5s=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af46dd3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=PtN3Y-iHzQweFIBZXwoA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: CsYFFla_IZOQuiBb-vm6JEcbsyFqbI9L
X-Proofpoint-GUID: DNWZkMfk9r_h-L_vg50Z-qH3Fp5-F0gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX2lvR4i2tS2Rb
 Mr+C1ZfKibFPPn2oujL71vl+PdEFW0XmBf0/jiig+Izam+zpv0oZ/fCRb+570AHf2ZfHWpwE418
 sx+/jDHKVoJirKD+119u66LJXp1i5uV56VhYgP0kLWLnhT9/foDud5lFmX+QifSDcfVypyjlXJ9
 7n/qrDVdlSPk8hmDCL29XDzD21YsK5WlLDKHKe6qdptjrBddD4pYRPoqp6CfY6wgMt9wLiY3Zrn
 NgzAnmeWsX6QUNIuJPZjPtsUpacvfAawVwMiCYd4kV96Xzi63p/yZImXWsaHx6jJO/3AMFZM2kV
 vBno4t4yAa5ZX7wf1Avwcnms3IyQ7XB0+rr96Aox1TB2Ap5rW+sja1dxeA3ReZpi9rhosOcBMXe
 /0kQQjyIFKYd/xYZkpWHxpFAyKYftYnLIxXL6HV9s+2U7bvKgQvorkBTKQ8fYasp2TYzbprFX0m
 kYe5RpbpnupBNR36XRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110052

On Thu, 2026-09-24 at 18:29 +0200, Benjamin Block wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
>=20
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
>=20
> We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> be called from paths that already hold pci_rescan_remove_lock (e.g.
> remove_store -> pci_stop_and_remove_bus_device_locked, or
> sriov_numvfs_store with the lock taken by the previous patch). Using
> mutex_lock() in those cases would deadlock.
>=20
> Make pci_lock_rescan_remove() itself reentrant by tracking the current
> owner task and a recursion depth counter, as suggested by Lukas Wunner
> and Benjamin Block, since these recursive locking scenarios exist
> elsewhere in the PCI subsystem:
>  - If the lock is already held by the current task (owner =3D=3D current)=
:
>    increments the depth counter and returns without re-acquiring,
>    avoiding deadlock.
>  - If the lock is held by another task: blocks until the lock is
>    released, then records the owner and sets depth to 1.
>  - If the lock is not held: acquires the mutex normally.
>=20
> pci_unlock_rescan_remove() decrements the depth counter and releases
> the mutex (clearing the owner) only when the depth reaches zero.
> A WARN_ON catches mismatched unlock calls from tasks that do not own
> the lock.
>=20
> This avoids relying on mutex_get_owner(), which is not exported to
> modules and caused link failures for builds that inline this code
> outside of the core kernel image.
>=20
> This approach keeps the API unchanged: callers simply pair lock/unlock
> calls without needing to track any return value or use separate
> reentrant variants.
>=20
> Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
> sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
> removal against concurrent hotplug events.
>=20
> Remove the rescan/remove locking from sriov_numvfs_store() that was
> introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
> enable/disable and hotplug"), since the locking is now handled directly
> in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
> reducing the lock scope.
>=20
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enablin=
g/disabling SR-IOV")
> Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and=
 hotplug")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> [bblock@linux.ibm.com: rebase on v7.3, READ_/WRITE_ONCE changes, comments=
]
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  drivers/pci/iov.c   |  9 +++++----
>  drivers/pci/probe.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 6 deletions(-)

Thanks for taking over from Ionut and refusing to give up on this. I
don't love needing a reentrant lock, but it seems like the simplest,
and most contained solution to a real problem until such time as a full
rework of the pci_rescan_remove lock comes up. It also feels easy
enough to understand and the added WARN_ON() should catch the double
unlock case. Also both upstream sashiko and my own LLM reviews with
multiple models are all happy with this.

So I think we should go ahead with this and feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
