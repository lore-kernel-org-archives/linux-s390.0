Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883859;
	b=F/ispoeSjUYA+e3tTuYwYoqWxTw8AOUEXyfjLV07FDi343vOXPmoX6x5R/m0/0Dm7rI4
	 IY28qeaqbwOWmckTeZI7r6HQphcfhoWM2WSZ0wg2FP8S6adKfphdyJhlJ8cGVSCbnTNQ4
	 aAuneQTXXO1FjUhU1+CDg0fl3GTboE9uT4L1BXSODkMPuOI5EYCAeMFGd6h8YJ/5Nvpe1
	 mId9gO2SUeM/fnRH2nBCQB9t+6Fo1ktsVHC95dTbnxW/SN4kZRBFw7Xt+AXOpzBraL39e
	 0bpv+D8yvL1EMJAOKF+zn1rC1vAaCUIfvIN2jpsLYVSnO6OB0L5mA/wPfRj14elXrTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PEYUQ1+aTUKMg+7BRFr8DvdpAnK4YM8OhX0sQta5fEw=;
	b=0VaKdF87Qy8h3mKvxDK3GOKfFSdp5tSs1I6Nc/l0bZv7uYYeOwvPQn6aHOP8U+LcX2yJ
	 uWItKxNPbsrwX+6lhrHM9Py+r8YQs6UjSYUf71TgxqtqFd6FCZkgsKv1HT/PxVpxxF44z
	 v9NyhGqbcKXuUKhXfrLnHwDgflf5dEN281YK5crjl7X4LbOZl8Bv+xouv8Wm+VVPynWyE
	 vrgNaYurwyA3yTP+BN92CV+RwwyVPKykoOCtDnrblajF4tMYmAfLjZ79WDKIuh2mR7EMD
	 2oKW/aDoqltRHJGMQpS6NTpEwD9SFUhFgZwaJAnAWRJ5oR7a6GnK9kh6g6Uf0CaU1Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IxxMN1zy;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB5606A330;
	Thu,  5 Nov 2026 13:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04DB5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IxxMN1zy
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEJXD3231339;
	Thu, 5 Nov 2026 13:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PEYUQ1
	+aTUKMg+7BRFr8DvdpAnK4YM8OhX0sQta5fEw=; b=IxxMN1zyPB51I53oKOQ7Ay
	8RNBtcuB9boKFUuRZpRRIMdEl1Hh1lANehELSie4xVuOF3GsNwqCMV0P3nx/fo0H
	Hm4bjl1v5vxjeWa2Svk4MvPAH6p0ZWgQhoDhV2gH97ARRAYGaYwTr1uikG4Nw+IF
	gHoskCelxgTWSFkagetIDbQvVYGL9Ki5yz24Ia3n79q+e8TDFzBLJpAKJ+L/yt94
	GjHOlBMCo/UdQCGdbIvwOPZ+X0SrDEgY/vPl2ELfySDXwCYRt+FEDPW8EUjCZCZR
	MstcTDbGwmd9XQkquvfHwG7jsLJs/N4OWVgkVb702fbEt87e574kir3iQIct9y7w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ys9s25-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 13:04:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AJpm71466511;
	Thu, 5 Nov 2026 13:04:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v0043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 13:04:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5D4Bhg41156958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 13:04:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7461A20043;
	Thu,  5 Nov 2026 13:04:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8FD20040;
	Thu,  5 Nov 2026 13:04:11 +0000 (GMT)
Received: from [9.68.14.168] (unknown [9.68.14.168])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 13:04:11 +0000 (GMT)
Message-ID: <90f6358e48dbd5db4c8ebecef97206bdf4f3afa1.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/5] s390/pci: Improve function measurement state
 management
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 05 Nov 2026 14:04:11 +0100
In-Reply-To: <17f74b7d-8fd8-49e9-960e-212cc3cdb09c@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
	 <20261028154352.15108-3-oelghoul@linux.ibm.com>
	 <712b9ec90b4020131144ce5cd7976568ca5d2efa.camel@linux.ibm.com>
	 <17f74b7d-8fd8-49e9-960e-212cc3cdb09c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aec7ed0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=zO0g8XVbTfOTk1bnwWMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfXzvlBqIw/Dqqe
 ICQ7hk8pBThUhA1Wqzcf8U/RPETUhfU9XfRwX0IqG2dmSFkwE4gsHwtxLXkdTRtesK5FNyQ5/Iw
 w2dTlZ7BVS0Fy6JQyXu94FXiJGCByXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX1MHWg0POcux0
 XA7Hvc8/uRenr7+vPJ3f0mCVhdbB1Fk7s6MRRkSI4pRjKD7Ni/eNWqu5OH6XIKGQwX1qE4hENLY
 be2uqcN+qy/sxFmAgchVnOTvqf4dhk8IuWIjx/43P+h7WIC9QljzJQJgRhdfWrnMqA1kLBNfcmi
 84OgXJNp6jYflazi84Sy07N10O66GRwXgyDeZa12YpSb2oGljlH5q1B2x/cw5mVETso4aj1S2c0
 zVL6hqXlVTO1EdNn0kUM2DdzulATTPrJbk5gbMQPuqWKh97JALcmY3LcUS3jnd5g134xoFKPdKY
 kIBeGhf+Bp99Gqvt+q2KlSSWNRHGm4xeayrhWoOVxthxdKSEUFd/8PZ33F8S0Vn6gi65YG5uluG
 GyHQjVZaTj7uvW8MIOLtqXEAESfB+VVyJ3nLUbCd+QDRwxCbvpEfX0kFouBu3aanFQur1yQHzq0
 fWpMKLKkfYhAjQcidOQ==
X-Proofpoint-GUID: BZ98E5ZmytWzR0h0JkU_efJHy05m7VUt
X-Proofpoint-ORIG-GUID: BZ98E5ZmytWzR0h0JkU_efJHy05m7VUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050050

On Tue, 2026-11-03 at 12:40 -0500, Omar Elghoul wrote:
> On 11/3/26 12:02 PM, Gerd Bayer wrote:
> > On Wed, 2026-10-28 at 11:43 -0400, Omar Elghoul wrote:
> >=20

  [ ... snip ...]

> > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > index c055a9ad0972..5889dd227009 100644
> > > --- a/arch/s390/pci/pci.c
> > > +++ b/arch/s390/pci/pci.c
> > > @@ -164,8 +164,44 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, =
u8 dmaas)
> > >   	return cc;
> > >   }
> > >  =20
> > > +int zpci_fmb_request_on(struct zpci_dev *zdev)
> > > +{
> > > +	int rc;
> > > +
> > > +	lockdep_assert_held(&zdev->fmb_lock);
> > > +
> > > +	if (zdev->statistics_on)
> > > +		return -EINVAL;
> >=20
> > It's perhaps a question of taste, but is this strict rejection of
> > double-enable really necessary? Wouldn't it be more defensive if the
> > enable was just let to pass?
>=20
> It isn't, and I actually just dropped it in v12. After introducing the
> fmb_enabled bool in v12, we now reject double-enables right from within
> zpci_fmb_enable() itself, matching the pre-existing behavior.

Looking at v12 ATM: Thanks for the change.

>=20
> > Ah nevermind: That would allocate a new FMB buffer from zdev_fmb_cache
> > and is a memory leak.
>=20
> With this patch alone, the buffer doesn't leak because zpci_fmb_enable()
> already rejects a double-enable with zdev->fmb is non-null. Of course,
> patch 3 here (v11) does introduce an issue where we reuse the same FMB
> buffer without adequately replacing the liveness check. This is again
> addressed in v12.

Still have to look into this in v12...

> >=20
> >=20
> > > +
> > > +	rc =3D zpci_fmb_enable(zdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	zdev->statistics_on =3D true;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(zpci_fmb_request_on);
> > > +
> > > +int zpci_fmb_request_off(struct zpci_dev *zdev)
> > > +{
> > > +	int rc;
> > > +
> > > +	lockdep_assert_held(&zdev->fmb_lock);
> > > +
> > > +	if (!zdev->statistics_on)
> > > +		return -EINVAL;
> >=20
> > Same question here: Would a double-disable hurt anybody?
> > Doh: Yeah, you don't want to go down that route...
> >=20
> > > +
> > > +	rc =3D zpci_fmb_disable(zdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	zdev->statistics_on =3D false;
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(zpci_fmb_request_off);
> > > +
> > >   /* Modify PCI: Set PCI function measurement parameters */
> > > -int zpci_fmb_enable_device(struct zpci_dev *zdev)
> > > +int zpci_fmb_enable(struct zpci_dev *zdev)
> > >   {
> > >   	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> > >   	struct zpci_iommu_ctrs *ctrs;
> > > @@ -207,7 +243,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
> > >   }
> > >  =20
> > >   /* Modify PCI: Disable PCI function measurement */
> > > -int zpci_fmb_disable_device(struct zpci_dev *zdev)
> > > +int zpci_fmb_disable(struct zpci_dev *zdev)
> > >   {
> > >   	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> > >   	struct zpci_fib fib =3D {0};
> > > @@ -644,7 +680,8 @@ int pcibios_enable_device(struct pci_dev *pdev, i=
nt mask)
> > >  =20
> > >   	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
> > >   	mutex_lock(&zdev->fmb_lock);
> > > -	zpci_fmb_enable_device(zdev);
> > > +	if (zdev->statistics_on)
> > > +		zpci_fmb_enable(zdev);
> > >   	mutex_unlock(&zdev->fmb_lock);
> > >  =20
> > >   	return pci_enable_resources(pdev, mask);
> > > @@ -655,7 +692,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
> > >   	struct zpci_dev *zdev =3D to_zpci(pdev);
> > >  =20
> > >   	mutex_lock(&zdev->fmb_lock);
> > > -	zpci_fmb_disable_device(zdev);
> > > +	if (zdev->statistics_on)
> > > +		zpci_fmb_disable(zdev);
> > >   	mutex_unlock(&zdev->fmb_lock);
> > >   	zpci_debug_exit_device(zdev);
> > >   }
> > > @@ -737,8 +775,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
> > >   	}
> > >  =20
> > >   	rc =3D zpci_iommu_register_ioat(zdev, &status);
> > > -	if (rc)
> > > +	if (rc) {
> > >   		zpci_disable_device(zdev);
> > > +		return rc;
> > > +	}
> > > +
> > > +	guard(mutex)(&zdev->fmb_lock);
> > > +	if (zdev->statistics_on)
> > > +		zpci_fmb_enable(zdev);
> >=20
> > But that discussion about double-enable above makes me wonder:
> > Would we leak an FMB buffer, here - at least until patch 3 comes to the
> > rescue? Maybe the two patches are not so independent after all?
>=20
> Nope, we don't because the behavior of zpci_fmb_enable()/_disable() is
> still unchanged from before this patch. They will still reject a double-
> disable/enable attempt even without patch 3.

Yup, that's what my experimentation did show. Sorry for the noise.

>=20
> >=20
> > So, I experimented a little with patch 1 and 2 applied in an LPAR: I
> > injected PCI auto-recovery with 'zpcictl --reset-fw' to a NETD PF and a
> > NVMe PF and was pleasantly surprised that no resources were leaked
> > *and* statistics were enabled before and after the PCI auto-recovery.
> >=20
> > Turns out that both the mlx5 and the nvme drivers pci_error_handlers
> > callbacks for error_detected() switch off statistics by way of
> > pci_disable_device() which calls pcibios_disable_device() - and the
> > callback for slot_reset (mlx5) resp. reset_done (nvme) restore the
> > statistics setting again by way of pci_enable_device() which calls
> > pcibios_enable_device().
> >=20
> > So one could argue, that at least for the PCI auto-recovery case, this
> > conditional call to zpci_fmb_enable() is not needed?
>=20
> I think you're right, but we still need this call here for other paths
> that call zpci_reenable_device() without pcibios_enable_device(). IIRC
> a sysfs recovery (via recover_store() -> _do_recover()) disables the
> device and then re-enables it using zpci_reenable_device().

Ah yes, I didn't think about that path.

I'll continue with reviewing v12.

Thanks,
Gerd
