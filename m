Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261F2BE034;
	Tue,  6 Oct 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276576; cv=none; b=WNLq2WT1Zvrcjaarej6AwDxJE64E7EE8s4oQiUPTfA+pjS3UZP1/LXhyRlvAuOGxgYWqUvS8ceKqFc8x/57JdQmg01mw2NsabvZ7sZVLhglZzlKx2BfzlPefxdEXeEdbSCez3T54iU4UQ0RrtZX9u71W6pYp1RypWdxzcA7Ke/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276576; c=relaxed/simple;
	bh=gsMc6bwMrW1xxHD2QpX1n/Pf4rhgitFhBYj65CWCDAw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=EQNgHh2vMvsNCuZpJK7zJ2iY6CzWEfMy5v3I2ubMX/GwgDr9D65e0bxJaxqiskaaGvSln+gZDRqqGIBgzZdikCbYBqw3tdqTyVfoR06LSahSHWZ7HFO/Yfk3ub3Mty5IaJYydppPZOMaiXwj0ZoerpOosbGHMQWa8Jkq90TU5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pw7fr5VX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pw7fr5VX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966brSx2929762;
	Tue, 6 Oct 2026 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4q2CKe
	WyxxdnW6T+E5REDnkhZzMhrY3UHgmN+i9Viqc=; b=Pw7fr5VXRSlwiCz1FHDyLw
	sNvnJtnnMKeziQIpYPCTSpxnb0h3oHzskDPlM8KbySdoRs+AXYbo3wGW/3IOiFBh
	vf4kLcvzy9rYGlDw91lwF5OeJMpNRA/27lf6pVViap5aSe/qQe1GCSzw39snnAnN
	KOwf2bWitpWJtkyVdHlf/2OS0kdLyDPS5btjcaUZUWG9PtAF756UjFF1OQXLrnOD
	zLD0VnccGjFu7NeT8hqY/4IKfYN38fZ+hJRaHo6K17bQMM5q1XNK41718XE3V9Ly
	oCaKqkp2r2xWFNw/TECMLl84I6Fb6rM+MsZepZUvgyzlgqRm0Uuh/mu1rdfIXyxQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv615c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 08:49:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69672SR04103016;
	Tue, 6 Oct 2026 08:49:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvs8rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 08:49:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6968nTrZ14811840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 08:49:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10B7258056;
	Tue,  6 Oct 2026 08:49:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C66A58052;
	Tue,  6 Oct 2026 08:49:26 +0000 (GMT)
Received: from [9.87.140.229] (unknown [9.87.140.229])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 08:49:25 +0000 (GMT)
Message-ID: <a24337bd66864dd70ae61e28d86590052ac0fc5d.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] s390/pci: Reuse FMB buffer and preserve state
 in device re-enablement
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
In-Reply-To: <a6d35b06-694e-45da-ab3d-12279cacdc8c@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
	 <20261005154557.57801-3-oelghoul@linux.ibm.com>
	 <023ed9db17d9c7d785dad387fc18dff6bed862d8.camel@linux.ibm.com>
	 <a6d35b06-694e-45da-ab3d-12279cacdc8c@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I0poJ0vnMF20fSzYtm1fmsIU5aK8OKsW
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4b61b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=hSiswbDSEv_IIy351AMA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: I0poJ0vnMF20fSzYtm1fmsIU5aK8OKsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNCBTYWx0ZWRfX1v1+QWtEgfr+
 4a5r7fwoPKROceWa1I4DsC+mIVL0nYew/GMSvhXJJtc4I5O5KyoVW6NPjtIzb8n92a8MLpoXjGa
 ofI2Q91R3Zl/x+0l5BJ5iKlmqpj+LqO78PxC+k72Nj4ZuJMdCY57GYnVSaPzBJMpGa3LuwM9cOD
 NVXIbY/1YVr4g8RgvOhKCWlPffyTthX7RJ+kegCX6841ePALOdGwCelTPXhiz2mihZ6AjOBssa+
 xH8jObELaqNFQd+XPg4MzQirzLeywH0kOqR0q+P1FQibrBKcOTZVaLND4kdMh3ZVZASdwIS/cTB
 i4woOsWhXVveVEDnwMreh7h2/KjzoNxHCHYz3+zehuO6T5FEd9wmDbOJHzIul220Kt6YSpxcbIM
 ssaJSMyQYDmJyrq66DqyjHPQ8i9keemfYI4Ua14BZQ6Uhzq+kCBdgF1RZSKnERef0puEJ+EafWT
 2qoTitG4ZMCtQA5dPww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNCBTYWx0ZWRfX5myYGKQeZTBo
 dGjRYtu961kqfMmmPcrNFw6ck8LG/3nnBVolE6eopD9we/vAKPvnLQL6R5BBE8Uay72psgGTloe
 FL+PXxSY4MP1hI3TM+/AEMoUCuTh27U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060034

On Mon, 2026-10-05 at 18:05 -0400, Omar Elghoul wrote:
> On 10/5/26 3:53 PM, Niklas Schnelle wrote:
> > On Mon, 2026-10-05 at 11:45 -0400, Omar Elghoul wrote:
> > > Don't free the FMB buffer when disabling measurement in
> > > zpci_fmb_disable_device(). Instead, make the buffer persistent for th=
e
> > > lifetime of the device and reuse it across enable/disable cycles. Def=
er
> > > freeing the buffer until teardown in zpci_release_device().
> > >=20
> > > To support the persistent buffers, add the fmb_enabled bool to struct
> > > zpci_dev to decouple whether FMB is enabled from whether the buffer h=
as
> > > been allocated. Audit the only consumer of zdev->fmb as a liveness ch=
eck
> > > and update it to reflect this change.
> > >=20
> > > Introduce the function zpci_fmb_reenable_device() to ensure that the =
FMB
> > > is enabled. If it was already enabled, disable it, zero the counters,
> > > and re-enable it. This allows the function to be used in both first-t=
ime
> > > enabling and re-enabling measurement. Call it in zpci_reenable_device=
()
> > > to preserve the FMB enablement if it had been implicitly disabled by
> > > firmware in zpci_disable_device().
> >=20
> > I think this causes a sequencing error in zpci_hot_reset_device().
> > First the device gets disabled via zpci_disable_device(). This
> > implicitly disables the FMB but keeps zdev->fmb_enabled set. Then we
> > call zpci_fmb_reenable_device() in zpci_reenable_device(). Since zdev-
> > > fmb_enabled is set we don't first enable the FMB and instead go
> > directly to disabling it but that is wrong since the FMB is already
> > disabled as a side effect of the CLP Set PCI Function (Disable) in
> > zpci_disable_device().
> >=20
> > Also, and I think Gerd mentioned this before, there is a disconnect in
> > semantics between zpci_fmb_reenable_device() and zpci_reenable_device()
> > that is quite confusing. While zpci_reenable_device() re-enables the
> > device with existing interrupts and I/O address translations, after it
> > was disabled, zpci_fmb_reenable_device() on the other hand does a
> > disable and then enable cycle.
> >=20
> > I think the idea here is that zdev->fmb_enabled tries to track whether
> > the FMB is supposed to be enabled rather than if it is enabled.  This
> > makes some sense since the FMB can get disabled by the device entering
> > the error state or a zpci_disable_device() and we want to know if we
> > need to re-enable it at the re-enable of the device.
> >=20
> > Importantly, unlike the disablement of a device we always initiate the
> > enablement. But then we can't try to disable the FMB without knowing if
> > it was already disabled. I think a possible solution for this would be
> > to have zpci_fmb_reenable_device() mean that we know that the FMB is
> > disabled but should be enabled, which we know when we re-enable the
> > device and zdev->fmb_enabled is set. Of course then it doesn't do a
> > disable but only an enable despite zdev->fmb_enabled already being set,
> > Then zpci_fmb_enable_device() on the other hand sets the flag initially
> > and then uses zpci_fmb_reenable_device() or a shared helper. Of course
> > we would then have to properly document zdev->fmb_enabled as being a
> > the target rather than current state.
>=20
> I agree with your insight and I'd be happy to follow this approach, but
> I think this can cause FMB consumers to read stale snapshots (e.g. if
> the device was disabled due to an error state or similar but fmb_enabled
> is true).=C2=A0
>=20

I'm not sure reading stale data is really an issue. When this happens
the device is disabled and won't see updates anyway. Also there is a
timestamp in the FMB so it's transparent how old the data is. And just
based on the interface the same FMB can be re-read between updates so
if you don't want duplicate data you'd need to check for changed
timestamp anyway.

> What would you think of leaving fmb_enabled as-is to indicate
> whether FMB is actually enabled, and then introducing a second bool,
> maybe something like fmb_needed, to track the user's intent and whether
> we should call zpci_fmb_reenable_device() from zpci_reenable_device()?
>=20
> This way, a successful zpci_fmb_enable_device() sets both flags, and
> zpci_fmb_disable_device() clears both. zpci_disable_device() should
> only clear fmb_enabled and leave fmb_needed as-is, allowing us to track
> the implicit disablement by the firmware. This will make fmb_enabled
> represent the actual firmware truth, and it becomes a reliable liveness
> check for the FMB consumers (debugfs and vfio, for now.)
>=20
> As for zpci_reenable_device(), it would check fmb_needed and if set,
> call zpci_fmb_reenable_device(), since we'd already know by that point
> that the FMB was implicitly disabled by firmware.

This feels like an overcomplication to me and "fewer stale FMB reads"
doesn't seem worth it. Even if zpci_disable_device() clears fmb_enabled
I think it wouldn't be the true state because the plaform might have
disabled it e.g. in an error event and then we would have to litter
those places with clearing the flag too instead of just using the
existing zpci_device_reenable() which gets called when we get out of a
platform disable. I do like the fmb_needed name though or maybe even
better fmb_requested.

Thanks,
Niklas
