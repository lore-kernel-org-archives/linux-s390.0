Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FC4A2631;
	Thu, 24 Sep 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265321; cv=none; b=d1Qf+cf61ruxI8XYO/ByT7ptRSsvmG8UBUxLdg5KZTBpGOCICMqt9iA2UKdZGZ27XNwHgQ7tmMe8iBS4K37Buon8gfJJziLY/yYloSBeGw202vTZ3GwbJkUmTvIHXZJkguZDJ9VB/d/ZSJ9Bl5v+zVseGXteajF2m1z3mLvUTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265321; c=relaxed/simple;
	bh=lOn8pU/Ic2xKhcoU+iEhzv5ynf0puxNUNBBxcniK3dU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHvMAQpqH9qAUdFu+wqJDRz8/noSLZhM6VlUhVr6WabdxszMX0aQOLh78vWd9wp8ISxM6Tgoqu2t2Mgi31FA5MM4/6ZK7BwknBia3j7PFE+BZNR4E37ar9gpf0FflRkXpRagF/JCjYa7w7ttGXIjR8xIARDgvZxAR3MC3E/HQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbP0ufDc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbP0ufDc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6A5r2190676;
	Thu, 24 Sep 2026 15:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2E2H4C
	oyxfJK+lzu9ThUQaah7QWZCRFiMjlmX/h5w9A=; b=WbP0ufDcmMLR0ct/6TXk/8
	RcsM5Yw8PvL3PzD7a4DFZ1d/jobJSOtqgFonsk+V3V1IHGIzpk6ok5CxxyPK95ac
	bYUwrsI1KqopPQ4IwhrOyP+3NRADHrSMxe5FBvdQp3e07wJOy89ECA1Lmwrj1Up4
	cRlmmrjG6Wf2U0BoTycl2ZDpZIDbc36hqsd2O2Zeyx4714M3TVwec/4DEXOwc+0F
	tp6JY7ZOtA5NR6sExTuC/LP9KibReGyp60rUpIv1bnlAOu7ISTJa/c4xXP8rwrzt
	MuFWMlCt1zewsfno8h36YVkC/KtqjHi9VUmFAfGtJs68YsEUICj/wknRgneayWaw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2t5qd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:55:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFlcB62346203;
	Thu, 24 Sep 2026 15:55:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1xhnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:55:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFt7lW53215596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:55:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD80020043;
	Thu, 24 Sep 2026 15:55:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926642004B;
	Thu, 24 Sep 2026 15:55:07 +0000 (GMT)
Received: from [9.224.92.241] (unknown [9.224.92.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 15:55:07 +0000 (GMT)
Message-ID: <8c1094dda46b18a8c4d12dafbfea94e89c0b0b85.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org,
        Gerd Bayer <gerd.bayer@de.ibm.com>
Date: Thu, 24 Sep 2026 17:55:07 +0200
In-Reply-To: <07094b4a-0c11-42a0-a9dd-8c46fe7e47f9@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
	 <20260922195141.94548-3-oelghoul@linux.ibm.com>
	 <d5a32ced819407ae370da37803e30acf541bc5d3.camel@linux.ibm.com>
	 <07094b4a-0c11-42a0-a9dd-8c46fe7e47f9@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: swd93M0KtWqyEYMWC8W9kk8ppXcor1YT
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab547e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rfKfkVEBMkOvuwVTT1cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NCBTYWx0ZWRfX0YNQ6S6vupux
 6g5oNU7Dq2kMkyBNQtDl33SviBLMhWDyEMpTZhj8gIoPn7Dhe7sMgEvMG0GXjI5cegUii+LhIzy
 GuGl63pKb86wQSDSITRAkGwoOEetRZFDnygZTSrLJlAd4dYrhIu+ux0ixlr3w6E92ReytL0khKO
 hytvHyJcTdB798Q7H5xdIwp0PceQ566IT3VyXrxE5e8iDAgIlEvBaHgIf/hqx24oFPqA3p/CSpJ
 zj1/ikxa7pMJ4GNPX+I5IXi1bnJP27c8ebzGUqqfvMhtL121gwTSo2mRAG7tJBAV7NTuLcZr6eZ
 Io2gVyLWC5Y0SHvuiqUv2LeTMYbgoqueXlmvccNqteFBaq1kdhZ4biJ9BLz2ETAJrXd9lZyaREc
 1kPUXzMozjmNU2HlgCUyUnm9jefP5KHN8fXuiaj8VIx1K5Zg0Q6arXtI6FezRzSF7ExcHdMEdQx
 ueyp4Ym8by3u5lmrAWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NCBTYWx0ZWRfX21B1Cqk+nWJY
 YxKc3d0spPQmF6B0gV4Gb8DviT33tER5wn6RIdByQvR5xOlnm/1/Tna0Hn+k2sIp648eIayVAMV
 kxljliqwy9SgT+pT26xLM1U0AW6EZBo=
X-Proofpoint-GUID: swd93M0KtWqyEYMWC8W9kk8ppXcor1YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240064

On Wed, 2026-09-23 at 12:37 -0400, Omar Elghoul wrote:
> On 9/23/26 11:09 AM, Gerd Bayer wrote:
> > On Tue, 2026-09-22 at 15:51 -0400, Omar Elghoul wrote:
> > > Introduce the function zpci_fmb_reenable_device() that checks the sta=
te
> > > of function measurement and ensures it is enabled. Reset the counters=
 to
> > > zero, disable, and re-enable the FMB if it was already enabled. Call
> > > this function from zpci_reenable_device().
> > >=20
> > > Don't free the FMB buffer during disabling and reuse it when re-enabl=
ing
> > > measurement. Instead, free the buffer upon device teardown, allowing =
the
> > > same buffer to be reused in the enable path and add the bit fmb_enabl=
ed
> > > to struct zpci_dev. Audit the only consumer of zdev->fmb and update i=
t
> > > to reflect the change in semantics.
> >=20
> > While I understand how this evolved, this commit message reads upside-
> > down for me. Shouldn't we consider the changes described in this second
> > part of the commit message as a preparatory step for the introduction
> > of zpci_fmb_reenable_device() and put this paragraph first - or even
> > into a separate commit of its own?
>=20
> That's a fair point, the commit message can be restructured to describe
> exactly what the function does first, and then afterwards describe where
> we're calling it and why.

Sounds good.

> I also think having everything in one commit is necessary because this
> commit changes the semantics of zdev->fmb, where the old code used it
> as both the buffer and also as an FMB enablement check. The latter check
> is no longer valid after this commit, unless we want to add a separate
> commit that just adds the fmb_enabled bool, which I thought was a little
> overkill.

That's fine with me, no hard feelings.

[...]

> >=20
> > > +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> > > +	}
> > >  =20
> > >   	/* reset software counters */
> > >   	spin_lock_irqsave(&zdev->dom_lock, flags);
> > > @@ -199,11 +204,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zde=
v)
> > >   	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
> > >   	fib.gd =3D zdev->gisa;
> > >   	cc =3D zpci_mod_fc(req, &fib, &status);
> > > -	if (cc) {
> > > -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> > > -		zdev->fmb =3D NULL;
> > > -	}
> > > -	return cc ? -EIO : 0;
> > > +	if (cc)
> > > +		return -EIO;
> > > +
> > > +	zdev->fmb_enabled =3D 1;
> > > +	return 0;
> > >   }
> > >  =20
> > >   /* Modify PCI: Disable PCI function measurement */
> > > @@ -215,7 +220,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev=
)
> > >  =20
> > >   	lockdep_assert_held(&zdev->fmb_lock);
> > >  =20
> > > -	if (!zdev->fmb)
> > > +	if (!zdev->fmb_enabled)
> > >   		return -EINVAL;
> > >  =20
> > >   	fib.gd =3D zdev->gisa;
> > > @@ -224,13 +229,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zd=
ev)
> > >   	cc =3D zpci_mod_fc(req, &fib, &status);
> > >   	if (cc =3D=3D 3) /* Function already gone. */
> > >   		cc =3D 0;
> > > +	if (cc)
> > > +		return -EIO;
> > >  =20
> > > -	if (!cc) {
> > > -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> > > -		zdev->fmb =3D NULL;
> > > -	}
> > > -	return cc ? -EIO : 0;
> > > +	zdev->fmb_enabled =3D 0;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
> > > +
> > > +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> > > +{
> > > +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> > > +	struct zpci_fib fib =3D {0};
> > > +	u8 cc, status;
> > > +
> > > +	lockdep_assert_held(&zdev->fmb_lock);
> > > +
> > > +	if (!zdev->fmb_enabled)
> > > +		return zpci_fmb_enable_device(zdev);
> > > +
> > > +	fib.gd =3D zdev->gisa;
> > > +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measure=
ment */
> > > +
> > > +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid =
state here
> > > +	 * because we are re-enabling function measurement for the same fun=
ction
> > > +	 * handle.
> > > +	 */
> > > +	if (cc)
> > > +		return -EIO;
> > > +
> > > +	zdev->fmb_enabled =3D 0;
> > > +	return zpci_fmb_enable_device(zdev);
> > >   }
> > > +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> >=20
> > I see a little imbalance of the semantics of "reenable" in
> > zpci_fmb_reenable_device() vs. zpci_reenable_device():
> > zpci_reenable_device() "just" enables + registers existing data
> > structures with the underlying system - while
> > zpci_fmb_reenable_device() does both the disablement + the enablement.
>=20
> Strictly speaking, the disablement step may not be necessary, provided
> firmware starts the counters at zero upon changing an FMB address, which
> does seem to be true in practice. The architecture doesn't explicitly
> require that though, so I thought it's a reasonable safeguard to use it
> as an intermediate step that signals firmware to stop counting before we
> immediately restart measurement after.

Initially, my point was purely "semantics":
If it is enough for zpci_reenable_device() to do only "enabling"-kind
of steps, why is zpci_fmb_reenable_device() then also doing some
"disabling" (under certain conditions). In my eyes the "reenable" was
actually a "conditional-toggling-on".

And this then led me to checking the paths leading into
zpci_reenable_device(). I found that all paths would call
zpci_disable_device() before and that led me to the next question:

> > Since zpci_disable_device() includes the disablement of FMB per
> > architecture, I wonder if it would suffice to set zdev->fmb_enabled =3D=
 0
> > in that function, and drop the explicit disable FMB there?
>=20
> The semantics of the FMB re-enable function were intended to allow us
> to re-enable the FMB when we re-enable the device after FMB was
> implicitly disabled via zpci_disable_device(), like you said. Prior to
> this patch, there was a sort of "limbo" state where firmware thinks FMB
> is disabled, but the kernel is unaware of it because it was implicit.
>=20
> For that same reason, I would prefer to not touch zpci_disable_device()
> at all, neither explicitly disabling FMB nor setting fmb_enabled to 0.
> The purpose of fmb_enabled variable is to allow us to restore the
> original FMB enablement when we re-enable the device, and so we want to
> preserve it here [1].

OK, I see. The whole point was to preserve the FMB enabled state over
disable/enable sequences on a zdev: Re-enable if (and only if) it was
enabled before the sequence. So I agree, you must not set zdev-
>fmb_enabled =3D 0 in zpci_disable_device(). But you can trust firmware
to stop updating the FMB buffer (after the ominous grace-period) after
zpci_disable_device() ran - the zpci_mod_fc() to set FMB to 0 is done
implicitly in clp_disable_fh().

And you wanted to reuse the zdev->fmb buffer if there ever was one
allocated for the zdev. It just occurred to me, what good is the whole
zdev_fmb_cache if the life-time of struct zpci_fmb buffers becomes
almost as static as struct zpci_dev (short of those that never leave
"STANDBY"). Couldn't we just kzalloc() a struct zpci_fmb right in
zpci_create_device()?


>=20
> Thanks
>=20
> [1]=20
> https://lore.kernel.org/all/dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ib=
m.com/
>=20
>=20

[...]

Thank you,
Gerd
