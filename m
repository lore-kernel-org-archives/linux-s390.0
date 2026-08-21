Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1252EEE61;
	Fri, 21 Aug 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318157; cv=none; b=Dtp1UgV7boD1u8SgDpv39d9p2pGhBZTCPi6YT/P+DE6Fwx/LADmgMtZDA1mgCBtMsWZEw/FJJWeFk7jmL1HexiXbKRznTLZqLzD9CxD2/A8Lcq0lfTVgs8dxhO0o66+s/hda/gbykQ7kWVP1XWcXevsuWhS9GwOh+EkJbEsZZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318157; c=relaxed/simple;
	bh=cAgRr8gWJU9GbZyqoyXXFF+7ahCnbIhCqj4ejqyUN1I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HwckekniqvEg+u95ls5NXGtUO4bIeNfNzMi03fNBrI+i+7PjT8+0Ms7fMyT5GT4RJV364+DCbPXGNJdW+B2MegjRW84/6kgqefFQMg8ezMfE4e+MvQMcngKf0+N9H4fzGo4ECk+D46Af+snJs8E9p4q8y/M48fVabWWtj4bhHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pNP8a/zp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pNP8a/zp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1sXF1473093;
	Fri, 21 Aug 2026 13:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5IAZOc
	Gm9hJJz7Fx9Zd5MJGs8zWz7KiiAUwXe4ZAnDw=; b=pNP8a/zpsTzuDoBAF06+Wl
	JO7Q94t6HeyMOT74fbU0Nb+Slee08MGSNsbQLJ+HXr3n5Yg2VplkschOyL3x/ISY
	qhzBinemPEuYMwUFhk6vyM3rAcv1GHg9lGK1Otb7bRZG7lKuXzbPTTIMj/ZzXLnl
	WUoLvkiBxqb/OXtM1ymIniuoWxjUk+EIcUSz56aF640YBqAD004iuFdURN47ZWTf
	7oo45dSx5yi5A7T3q7nRDZpO2WcsC1Fk4o7gnnEwIkcxOXPLMCF681yU1pPFVrzQ
	R/E03fM6WolozIOMXdJeZ1kYFmnPuO9/eoQXodgr3cLCUxdJ4CAMSf5p73MeD03Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4hhcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:15:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LDBObw000771;
	Fri, 21 Aug 2026 13:15:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twmw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:15:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LDFajU23921308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 13:15:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1150B58062;
	Fri, 21 Aug 2026 13:15:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329E358056;
	Fri, 21 Aug 2026 13:15:33 +0000 (GMT)
Received: from [9.111.15.247] (unknown [9.111.15.247])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 13:15:33 +0000 (GMT)
Message-ID: <6dff883412d6a8fc55b55cec8f58f4e27afc429f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher	
 <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter	
 <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260821125944.GB171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: 
	<20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
	 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
	 <2d699043-d415-4ba5-907f-393ba481ba20@linux.ibm.com>
	 <20260821125944.GB171473@p14sgen6-pf6akexs.ehn-de.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwMCBTYWx0ZWRfX1qDOJJW/cb9+
 vTdq2JJGUI+gK+EEFhi1Xv5khz84ld4zf2mBGX+nZHoUHZaBek7PCfU21MeMQpUwQ359QyEunOe
 PxJB2XsFDQrPFGh1g9qrfXSBZt+4wEU=
X-Proofpoint-GUID: 0hxOZHSoBKXxs3AKt3C9z-g_bzLEzJWs
X-Proofpoint-ORIG-GUID: 0hxOZHSoBKXxs3AKt3C9z-g_bzLEzJWs
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a884f7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dDJjkbnQuzecHEoTwVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwMCBTYWx0ZWRfX4VW7K0yFLrxY
 SaU2H2P1qVhh/xCcUnrUgtQRt5rZLFTNo236EAakwU2GEUqZRB1SN0YrmYDZbBIKbd1K29QMwdd
 JRyiF6PiEM5E60KaZ+eb0D1Ia7EhVvgoOX63DsFI55Il80L4YN7zMnDPq0rXZd3s0ye3TcinVCY
 F0eNzfCm8Db+qzzD9k2tFZCBOV02nStiJD2qm3Ld/6JLEvUYKLUvrwOc74GSYgDkTmqihbjVjDi
 GI4YMqoCKvy/6tmwwBLdh7Maf0DWJMSV3WSZ4tgVBW5QWOHj/3bH6yD0PJ4lr7P3iq+eXMz010U
 BZMvNyvB/m215WUYpQEEmaWT4B8LLNUJdfJ3YTD2SISel0trzo68a4jyYcGrJP38JyZcXk6gQa6
 8G5eSookfjSm0ixyjgZCfE734R2kDzn9yiw0CkDpDWBGfaY5Cve8/LKtsaFXt3CvtFIiFgpP3Ws
 79xwnXxPA0VfAm4MZgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210100

On Fri, 2026-08-21 at 14:59 +0200, Benjamin Block wrote:
> On Wed, Aug 19, 2026 at 02:30:18PM -0700, Farhan Ali wrote:
> >=20
> > On 8/19/2026 2:58 AM, Niklas Schnelle wrote:
> > > As zpci_report_status() accesses the device's driver the device lock
> > > needs to be held. Extend the critical section to cover the
> > > zpci_report_status() call.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via=
 SCLP")
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >   arch/s390/pci/pci_event.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > > index 839bd91c056e..48c150d6ba81 100644
> > > --- a/arch/s390/pci/pci_event.c
> > > +++ b/arch/s390/pci/pci_event.c
> > > @@ -256,8 +256,8 @@ static pci_ers_result_t zpci_event_attempt_error_=
recovery(struct pci_dev *pdev)
> > >   		driver->err_handler->resume(pdev);
> > >   	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
> > >   out_unlock:
> > > -	device_unlock(&pdev->dev);
> > >   	zpci_report_status(zdev, "recovery", status_str);
> > > +	device_unlock(&pdev->dev);
> > >  =20
> > >   	return ers_res;
> > >   }
> >=20
> > AFAICT this change is correct, but should we also add a lockdep_assert=
=20
>=20
> Andy maybe the context one `__must_hold()` or something as function attri=
bute.
>=20
> > in zpci_report_status()? Since this is the only placed its called, it=
=20
> > maybe fine as is. I just fear that we could miss on getting the lock if=
=20
> > we were to re-use zpci_report_status().
>=20
> Yeah, I agree. It's not obvious.
>=20
> I guess the critical point here why we need the lock is this line:
>=20
> 		driver =3D to_pci_driver(pdev->dev.driver);
>=20
> right? Because we assume the relation between driver and device stays int=
act
> after we get that assignment.
>=20
> Because otherwise I don't see why we must get the lock, if we get a valid
> reference in zpci_report_status().

Yes exactly, we need to make sure the driver isn't unbound or worse
unloaded in the middle of it. It's quite subtle which is why I forgot
it in the first place I guess.

Also note that the function may be called, and does handle, both an
unbound device (driver =3D=3D NULL) and/or a zdev prior to probing the
associated pdev (pdev =3D=3D NULL). This means the device_lock_assert()
needs to be inside the !pdev block. I'd think this also means we can't
really use __must_hold(), right?

Thanks,
Niklas
