Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741637;
	b=0lUOvv6vfBVMrYlaIn9Mn4RbjjZjJtT+P1a9Som2dYzCyuYiYBXFR7wM7BTRXSkAROo+
	 Thgb+YRNVkYx8JqDkHlVLiSZrPQEg/fsmrjzgvtYUgs5eW1hWZaaZFmm6q5egWlUT/dCM
	 vpOSUk14q5xMmWALvQbZCIHrFFew8ZzAZir127UaXlH1nqMLgi0fp4eoIKc51xxP7Iw+w
	 Dtfk2mXmZqG4TQJeg7LLNaFxJpuAR3u24XshQfev46mplHBprH2CY7agPHhjGZwwVV16A
	 oHtJKvBhEgT4Ij+pY779LCbss8h/wkT99KeCu9SqsfHnyMFVUnl6IZIb3IE1NGuKWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741637;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0LIGQSqzoLWGtA16u3vLkplNm5SsVdd6wSEh7ArW4YA=;
	b=onbtXy1fpiWV1pwPI6eSLLb1278vzliGkANqHpQLqOidjUCkb4bdiHcf7V/ZT8fzUg7w
	 5dPJ8sONaLSNt5fNc4omehiHxHJ+ezp2zKSMMrzhPuTqV7HolIqfahTzjILvAEm+kqj57
	 xPF1HnZWP+hENMgnIAzlmMKcYSBbg2R/0/EWpRWs7DI4Yu/Qtbh5YsVHTJKnksff6+Gca
	 dnBoLKT7Kfrw90xCRBHCut95UIFQLPksiSif+sMtb8aqTHE9bDbh04bmyRdoTWfDZJTkY
	 YbdjoMNiKTmCaFlpLJgcnd6TheImUzrvlPf40PbWlQFhLgoFpMLVW6ttqwlo7yZPYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LYAvhz2G;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38014606A31B;
	Tue,  3 Nov 2026 21:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38014606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LYAvhz2G
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Ii6Qq991355;
	Tue, 3 Nov 2026 21:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0LIGQS
	qzoLWGtA16u3vLkplNm5SsVdd6wSEh7ArW4YA=; b=LYAvhz2G63h89pa2Fai4TU
	hwHgxjIoRytOqzI55udRYL4jt73aGKGZpXZGEXe/HmTdoM9ZG1WUB7HmqpdWBBb+
	Gj8NwoUEbAI79hdFYOZoTTbF8fak3z/gyHcJ1afDy+iiHtZRxEPM6GAc5CtP3S2p
	06QWRKT7vW5PpBygNCV3rXnCX0SYGr1cA1VkSFksAd763xUydzWI/+iB70TKn2I1
	2lMAzgNPbFTam/BXof48bSbKmxGTw2cM5lJf2Mcf0TeaqYFgsZdLC9+WdEIFgFXB
	UeHbbYjHNzwg7rxIIHotxR1cIcDYMIzA9W4cFfo2SQl+uIPiRG0M+GjrEVomo4gA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80srhqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 21:33:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LMeKU1955475;
	Tue, 3 Nov 2026 21:33:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfvmwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 21:33:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3LXrKX33227458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 21:33:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA06458065;
	Tue,  3 Nov 2026 21:33:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B6758052;
	Tue,  3 Nov 2026 21:33:52 +0000 (GMT)
Received: from [9.87.159.144] (unknown [9.87.159.144])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 21:33:52 +0000 (GMT)
Message-ID: <71ec3caa1782d7af71c1a2c141aac7c5e3b52c7f.camel@linux.ibm.com>
Subject: Re: [PATCH v12 3/5] s390/pci: Improve FMB memory management
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Omar Elghoul <oelghoul@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>
In-Reply-To: <sashiko-outbox-195573@kernel.org>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
	 <20261103150114.68873-4-oelghoul@linux.ibm.com>
	 <sashiko-outbox-195573@kernel.org>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:32:51 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: onTkyKh5taemNrcKnA8X3wn_CmPr4FgJ
X-Proofpoint-ORIG-GUID: onTkyKh5taemNrcKnA8X3wn_CmPr4FgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfX6leTvwDYVy+4
 LdvI/Nk4w2bS1/6OYp2IPH8ffBGPt2wurBsyz8CyE8+YF1zNdAKd5HgD8+d8s9P0mTYaTFkwqeA
 eNaffK7MTgJ9AoOVyaTIHdf8Lo7/Nx+myyeXhqu8XhletPZ30EdXdVsFJz/mlDbGoNBC+SXGDFa
 FDbKmlQCxB3ch0YRKY4SNuimaMVqhiD2LOgTFoB7AwpLYWDqlJdg0HX0egpAnKImkKUBX7sjt1G
 JRIJUblI+Ac0Eb9wlLMcVbnf5At4SB9t5zWIHKQT6d2Wo0fj+KymuQIFCu0DkcqB8Q4z0SHfMgH
 z8g0nr+VLHehdjJMDEIs8V9Bxi430vX6B1pktvGdGF11lCqzFGNxD3Mh9VuT6wsANRjD22bZaKv
 eEdqmhR5KuOSDAAOB22WN5QTYbX34z2PwlOaIfX8gJug1eSM3tsKbxFXsCEtiQIZuHCjP6TzSNV
 V40LS7mWkw1U2uoEXVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4NCBTYWx0ZWRfXzFn8uuRHYvI2
 dPyyXbQNhHsG2cI50lttPHHCOJj9bZbscyrv/TMCQchFMgUVi9JHBk13oyhd/amtbVumBujvRE8
 4NjfVdzl7PeH5nEONlVKN6l0WhZBUq0=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea5344 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4D6RPE3fgF7gyByhpikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030084

On Tue, 2026-11-03 at 15:15 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] s390/pci: fmb_enabled not cleared when function is already dis=
abled
> --
>=20
> commit ca3a9f4958dfbbed1e7f4c289498cd7e117c52ca
> Author: Omar Elghoul <oelghoul@linux.ibm.com>
>=20
> s390/pci: Improve FMB memory management
>=20
> This commit replaces the dedicated kmem_cache for Function Measurement
> Blocks (FMB) with kzalloc_obj() and retains the allocated FMB buffer acro=
ss
> disable cycles until device release. Because a non-NULL zdev->fmb pointer=
 no
> longer indicates whether measurement is active, it adds a zdev->fmb_enabl=
ed
> flag to track FMB state.
>=20
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index f49736386eb7c..f066a7ffc35c1 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> [ ... ]
> > @@ -205,13 +203,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
> > =20
> >  	lockdep_assert_held(&zdev->fmb_lock);
> > =20
> > -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> > +	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
> >  		return -EINVAL;
> [ ... ]
> > @@ -802,6 +805,12 @@ int zpci_disable_device(struct zpci_dev *zdev)
> >  	} else {
> >  		rc =3D -EIO;
> >  	}
> > +
> > +	if (!rc) {
> > +		guard(mutex)(&zdev->fmb_lock);
> > +		zdev->fmb_enabled =3D 0;
> > +	}
> > +
> >  	return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(zpci_disable_device);
>=20
> [Severity: Medium]
> Can zdev->fmb_enabled remain set to 1 when the PCI function is disabled b=
y
> firmware during reset or error recovery, preventing zpci_reenable_device(=
)
> from re-enabling FMB measurement?
>=20
> In zpci_disable_device(), when clp_disable_fh() returns
> CLP_RC_SETPCIFN_ALRDY because the function is already disabled in firmwar=
e,
> clp_refresh_fh() updates zdev->fh to the disabled handle and sets rc to
> -EINVAL:
>=20
> arch/s390/pci/pci.c:zpci_disable_device() {
> 	cc =3D clp_disable_fh(zdev, &fh);
> 	if (!cc) {
> 		zpci_update_fh(zdev, fh);
> 	} else if (cc =3D=3D CLP_RC_SETPCIFN_ALRDY) {
> 		...
> 		rc =3D clp_refresh_fh(zdev->fid, &fh);
> 		if (!rc) {
> 			zpci_update_fh(zdev, fh);
> 			rc =3D -EINVAL;
> 		}
> 	} else {
> 		rc =3D -EIO;
> 	}
>=20
> 	if (!rc) {
> 		guard(mutex)(&zdev->fmb_lock);
> 		zdev->fmb_enabled =3D 0;
> 	}
> }
>=20

Before anyone thinks we didn't test error recovery it turns out that
actually works despite this issue being real. During error recovery
drivers end up calling pcibios_disable_device() before the
zpci_hot_reset_device() that gets us out of the error state so the
zdev->fmb_enabled gets cleared. Note that the current code also relies
on this mechanism already so this actually isn't changed by this patch
that just replaces zdev->fmb NULL checks with an explicit flag.

Looking at it from a fresh angle I think the real solution isn't to
just clear zdev->fmb_enabled in both branches above. Instead we should
clear zdev->fmb_enabled in zpci_update_fh() if and only if that
transitions the function handle from enabled to disabled. That covers
both the !cc and CLP_RC_SETPCIFN_ALRDY branches above but also any
other place where we might learn that the platform has disabled the
device and also have zdev_enabled(zdev) reporting go from true to
false.=C2=A0

Due to the nature of learning of changes to the actual state of the
device via events this of course happens with a delay so we can still
run into cases where we try to disable an FMB and it's already disabled
under us. There's no way around that. It's sadly just quite finicky to
have synchronous transitions on one side and the hard reality of
"someone pulled the plug" on the other.

Thanks,
Niklas
