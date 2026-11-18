Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996638;
	b=WWn5XqsLCBkTdu6hv0q0TBixoZ17/bu/3/6LGG00rtHagUO3OS4QbC82QNzd2lKC7Yuw
	 e+77V71YGyqy3sqvOGlaxP51hhCciC5BG48jP0MOhZxKFo5DP6enmUU5ZPu71mDajByOC
	 uI8V6BDGxRa/8yECZL5Kf8r7xr+5gu90d3jxRkyJmHbXdosX1UkpK1oTrKSmBhZxEGTxF
	 VJIMGLAEh+pbRptPMtitfyU9B5ZgK8tqp1NXZGwo7/QXOAeOtyEKDw1WYP80XDCYJB6b3
	 e68oaAt8j2wQ2zraofvpy29m1tr5S+DVY1PrCC55GnJkVSZIg4b5dYjFBsKUkMwXupA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996638;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wrKcyq/CS/+K5ohB+rYj423miBN7GD9bXqseFUFq2oc=;
	b=WDwufJI6Z1KolyKiLJmf6kisypnHrZqkKL+Eb/GcpuBXCdS50Zw4GlEoXRS/lpQShvEM
	 JZH7Un3Ky2Li0XpuRQLgoOJoZAlvijaxzSjcwXQrkA2hpr/TaG+ZHiukON2sD8LwU9QZd
	 Po2FDlxEa4HQkwDECrDvu1RuGLHdDS6UYlc3EdLaSG6nRbbDkFTH+y456KCi7WUVciYSf
	 VAlGeD9kFAqskjXBTUj8jYmojVxJdR2FqqcDeVBy058wJHcMyXCIuBFVFkK2LSl8FSpxH
	 VZrDijoTNzKBZq0NQDJOy+cxlHNIIRa7F6WvXto4pVzGv0NKdG8LGDFcRnKSwIrne2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fF1k6gtv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873A606A320;
	Wed, 18 Nov 2026 10:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D873A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fF1k6gtv
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9u2vB790669;
	Wed, 18 Nov 2026 10:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wrKcyq
	/CS/+K5ohB+rYj423miBN7GD9bXqseFUFq2oc=; b=fF1k6gtvrpIpnb/kyVVxCB
	r5PsvoOCpGWgVKKnytT7x0x3CRab04RwPgSpkNTUjqoywckZxJB3mHreYstuvHrx
	h0oDJGs8Ai06D2vb2yKpqglqe/sXIf1SUfMKCV5D092Aq7W2yRsjAPhKFRxm7oKS
	n/LMW3JkBg0pUILTTI5xjCh4WSYuHtyRyX8+hwTrltnMBa+Jm3gVzYbUljGhD7zU
	cdYOA5cgm9SQ0FzUAQ//f0l6f2VfR6yREJE64Bff1MlZAt9hc2HniUGwAQqM+H/f
	DBQsfZhgEMBtsZkgRRwttHjc82DuafHdhdnKTiEH0JzTDS1ZaGtqB5IZsvO+dfmw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t1wnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:10:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIA50kl1140918;
	Wed, 18 Nov 2026 10:10:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvhmfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:10:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIAA8wC21824116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 10:10:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3087758064;
	Wed, 18 Nov 2026 10:10:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E8E158061;
	Wed, 18 Nov 2026 10:10:03 +0000 (GMT)
Received: from [9.111.50.133] (unknown [9.111.50.133])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 10:10:03 +0000 (GMT)
Message-ID: <ccb3af54ee02d7cb56871d55e977502c9845b6d5.camel@linux.ibm.com>
Subject: Re: [PATCH v16 5/5] s390/pci: Fix circular/recursive deadlocks in
 PCI-bus and -device release
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>, Benjamin Block
 <bebl@ategam.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        linux-kernel	
 <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Dragos
 Tatulea <dtatulea@nvidia.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>, Lukas
 Wunner <lukas@wunner.de>,
        Matthew Brost <matthew.brost@intel.com>,
        Halil
 Pasic <pasic@linux.ibm.com>,
        Ionut Nechita	 <ionut.nechita@windriver.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias
 Schumacher <ts@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Ionut
 Nechita <sunlightlinux@gmail.com>,
        Michal Wajdeczko	
 <michal.wajdeczko@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Matthew
 Rosato	 <mjrosato@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        linux-intel-xe <intel-xe@lists.freedesktop.org>,
        Andreas Krebbel	
 <krebbel@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        linux-s390
	 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, piotr.piorkowski@intel.com,
        Guenter Roeck <linux@roeck-us.net>,
        linux-pci	 <linux-pci@vger.kernel.org>, stable@vger.kernel.org
In-Reply-To: <4c7d6e0ca4772a80059e9feb8e4b113154f420c3.1790945242.git.bblock@linux.ibm.com>
References: 
	<845f3fd0e94294765ea10454823c21e464d2f4bd.1790267348.git.bblock@linux.ibm.com>
	 <4c7d6e0ca4772a80059e9feb8e4b113154f420c3.1790945242.git.bblock@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:09:01 +0100
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd7983 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_fwKBuLvI4NI4-RVdj8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4XJPmtDVz3b1Qyhcv36qKTzT9yhD5HpI
X-Proofpoint-GUID: 6pb9C8fMySZ3DF1YPnC-pV3ajAIGD0cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX6cLk/q9tgEcj
 SsqcZgRxiwC5l/D8felnSYrPNOsqs4OJKkIWXet3Ta/I79VCv7uAtmKxeGB1Bf5ktBTyq/9krwq
 BlxM7p3N/VLRL0xGMPBaPU7enoJQo7rMwTJK5g9sYPHs4UvOMR8Pv0dj31wd3TihN2h2kxf4NUB
 J+swI4YuuHHTBT4p9j5N++ldmiJ32GiI3h9JdqJXyUvDw4OoU0V5LmhOsC5VjVyhs14eTDHoRiy
 RcLalWk5KSGfvb8smBkNOWsx+lJTVm8PKGbLBbtVSxfXSTK4W8ea9heNa8jrEnMNbNaXmo5iAIK
 timqDVKQEi5PRYSIV3WT3yV+Osq7itBy11sILQVeaS2fr02WHObG2bHSPXbmQS4M4G+uejxNxAE
 SXabp1CrHq2/G35IpnNGYq4+tq3Kp1Uogmmr5VDlfmCTyTNiJzZ/ou84SY651zIoPoXkSSc4uph
 0CkC8/sKCKIEg01L/cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX9QNJglqqCInP
 NGfNL3bI+awOoU03+0sirbHfiktLvandw+/51nab66S5TB2IedNieJJ2Bn6mB08LRb6ggCFULEM
 lq+HEDEuZMu8r5C6d+L80ODOvEgXweo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180039

On Fri, 2026-10-02 at 14:55 +0200, Benjamin Block wrote:
> When removing PCI device or PCI bus objects there are a couple of
> call-chains where it is possible that the kernel runs into a circular
> deadlock involving the central `pci_rescan_remove_lock`.
>=20
> Two examples:
>=20
> (A) Thread =CE=B1 receives a PCI event notifying the kernel that a PCI
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
>   sriov_numvfs_store()
>     -> ... (device driver dependent)
>     -> sriov_disable()
>     -> sriov_del_vfs()              # will   lock(pci_rescan_remove_lock)
>     -> ... (deep chain)
>     -> pci_release_dev()
>     -> pcibios_release_device()
>     -> zpci_zdev_put()              # will   lock(zpci_add_remove_lock)
>=20
> If thread =CE=B1 and =CE=B2 coincide, this will result in a cyclic deadlo=
ck.
>=20
> (B) Thread =CE=B3 receives a PCI event notifying the kernel that one or m=
ore
> PCI functions got hot plugged, and need to be configured. A possible
> call-chain that might happen while the PCI subsystem is trying to add
> those new function looks like this:
>   __zpci_event_availability()
>     -> ... (multiple ways in which a device gets added)
>     -> zpci_add_device()            # will   lock(zpci_add_remove_lock)
>     -> zpci_bus_device_register()
>     -> zpci_bus_put()               # will   lock(zbus_list_lock)
>     -> zpci_bus_release()           # will unlock(zbus_list_lock)
>                                     # will   lock(pci_rescan_remove_lock)
>=20
> Now the same thread =CE=B2 as above in (A) might coincide, and again coul=
d
> result in a cyclic deadlock.
>=20
> `pci_rescan_remove_lock` has to be and is taken at a "high level" in
> most call-chains since it is intended to protect/mutual exclude all
> rescan and/or removal actions taken in the PCI subsystem. So to prevent
> the outlined deadlock scenarios above remove it instead from the "low
> level" release functions for both the PCI device and PCI bus objects.
>=20
> Instead, lock `pci_rescan_remove_lock` in all call-chains leading to
> those release functions:
>   * initialization of the PCI subsystem;
>   * processing of availability events (CRWs) for PCI functions;
>   * processing of error events (CRWs) for PCI functions;
>   * architecture specific release PCI device implementation.
>=20
> Additionally, remove `pci_rescan_remove_lock` from zpci_bus_scan_bus()
> since its only caller zpci_scan_devices() is now always called with
> `pci_rescan_remove_lock` already held.
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

Thank you for the very detailed analysis. I agree with it and the fix
approach.

> ---
>  arch/s390/pci/pci.c       | 10 ++++++++--
>  arch/s390/pci/pci_bus.c   | 15 ++++++++-------
>  arch/s390/pci/pci_event.c | 29 +++++++++++++++++++----------
>  arch/s390/pci/pci_iov.c   |  3 +--
>  arch/s390/pci/pci_sysfs.c | 25 ++++++++++++-------------
>  5 files changed, 48 insertions(+), 34 deletions(-)
--- snip ---
> =20
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 36a4807285fa..c1b48b572e86 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -82,9 +82,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev)
>  	if (!pdev)
>  		return -ENODEV;
> =20
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	pci_bus_add_device(pdev);
> -	pci_unlock_rescan_remove();

This is a pre-existing issue not introduced by your patches, but I
think pci_scan_single_device() further up in zpci_bus_scan_device()
should also be done under the pci_rescan_remove lock.

> =20
>  	return 0;
>  }
> @@ -132,10 +131,13 @@ void zpci_bus_remove_device(struct zpci_dev *zdev, =
bool set_error)
>   * Return: 0 on success, an error value otherwise
>   */
>  int zpci_bus_scan_bus(struct zpci_bus *zbus)
> +	__must_hold(&pci_rescan_remove_lock)
>  {
>  	struct zpci_dev *zdev;
>  	int devfn, rc, ret =3D 0;
> =20
> +	lockdep_assert_held(&pci_rescan_remove_lock);
> +
>  	for (devfn =3D 0; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
>  		zdev =3D zbus->function[devfn];
>  		if (zdev && zdev->state =3D=3D ZPCI_FN_STATE_CONFIGURED) {
> @@ -145,10 +147,8 @@ int zpci_bus_scan_bus(struct zpci_bus *zbus)
>  		}
>  	}
> =20
> -	pci_lock_rescan_remove();
>  	pci_scan_child_bus(zbus->bus);
>  	pci_bus_add_devices(zbus->bus);
> -	pci_unlock_rescan_remove();
> =20
>  	return ret;
>  }
--- snip ---

Apart from the pre-existing issue this all looks good to me. The
remaining issue is close enough in nature that I think it should be
part of this patch and it does become simpler due to the guard(). The
addition is simple enough that you can go ahead and add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
