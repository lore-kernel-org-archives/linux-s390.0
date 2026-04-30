Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1A363C55;
	Thu, 30 Apr 2026 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535362; cv=none; b=A/eFGkJdXDo7ANCK7nt6JEGz01nN29iREKIpmzbiYewsASc8Ke2qr7+Ia5BRrIQSmGmIog2kATDdo0wVrsDjLj0MgAnKf3J8QFg//40brnxC9jkuvxnsaO8odxCRAac+at3KbrM+fjo5x8Opa4dcVzA4rSZAaxBqT3H5N3zRFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535362; c=relaxed/simple;
	bh=M2ekG0MZW1JJ+OuFj7+lV2wUm5rRxUcsETk1jVwsjn0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DUDe5yAfJ6IDHdAfEjOkfPLfLZZ4y6RAFg3GdsSJwvAQuP6NjeU6NufKP8Fty7wTzE/vE0jRo6mPeil9ibzi5wIG6OLmLdEali89FOyiq/pIMAyEIF/3nG5PEDALjMibmw4VHyG+dDV9sFxGtMSfwaF2p93NWmNHScTuak47mA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m2LAFq3q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m2LAFq3q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TIf3Dn1559961;
	Thu, 30 Apr 2026 07:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SE90+s
	J25ndoABNOg/x7CiDjnluFAwa/l3zUeM81+OQ=; b=m2LAFq3q9t/o2+qij15H4O
	EA5wxwqU7wetqMWHDvbtv0IANcwNOCshjDZkoNx6gsV+K+0mM8QrfPZ0oh0Oexcs
	fUUvaEKmanim/0E93syeQAogPoUxW9AHr5HonMw8V6DIZ5T+C3zpzRQ4SiGxu2T6
	HrMtTVJmGRl0G9XjtwSMRLFAxFrjRZQlypocoF6F607byipw4dN8ZQ6zRvB2V80s
	4wn25BbSUxUrwWW0U2Rl7XuJDE1fJpL0uvEoWl3VvYYn23EzPtxBOcdFAqy8l1aW
	YXAqKtsQnXVgc8nlNT2vpFcMqffjypLfOu/an3Pkg1OP2FHrPHyFNPLhXrqfPing
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vmtpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 07:49:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U7crmu007535;
	Thu, 30 Apr 2026 07:49:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5ghtj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 07:49:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U7n68U34013738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:49:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1586F58063;
	Thu, 30 Apr 2026 07:49:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 386FD58055;
	Thu, 30 Apr 2026 07:49:04 +0000 (GMT)
Received: from [9.111.84.159] (unknown [9.111.84.159])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 07:49:04 +0000 (GMT)
Message-ID: <c6363f08f898c7f4bb3e291ab2d3f7d8e3280459.camel@linux.ibm.com>
Subject: Re: [PATCH v14 4/7] s390/pci: Store PCI error information for
 passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        mjrosato@linux.ibm.com
In-Reply-To: <3f0d25e2-fe8f-470e-a857-f5474cba8cdf@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
	 <20260421163031.704-5-alifm@linux.ibm.com>
	 <08008a2a61556482c71f7f0ed65106e32e77f418.camel@linux.ibm.com>
	 <3f0d25e2-fe8f-470e-a857-f5474cba8cdf@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmmAWs8FCQl6sYAACgkQr+Q/FejCYJAn2g//UKzlXOgizdk0wudLooRbGzDo23ktGSPK5Oj9
 9o5z6v4Jz5+qOHo5835683cqkMLM9//udA1ZcKV88LVwyfmoHChPW24cWBmOEy7RJOWCR4WeEINaO
 pZUGF5YOx7oKTkPs511ky2FR0Heg35754pgTuTMEpYzRXr5pNMPS8mHXcXSARFPDPaCF+uBJ9BafO
 L7XbpSwKRttePsWAlPHbSbloeDApBfHUhcF/pbuM9GNs+c/8V9NK+SwwqNK214t7jaSq9k+19/hfE
 jvU45nbiYQM4VqGCelxVFRWol93JnwPFp/JaMgxgV1VYFH9Ijtgh+qNVVBqO8bbTjioFKy1bHdprN
 9GyPLDxoaI/lBg+5CwKewzazUjFd0xaqZbTXSgNK4ev/IuNI3qZV8tpvZZWwIgZU1K0Bhplt8Sku+
 O9Yl2H54erq9zuzwXjqBJtoW0+MaKbe+1gZ/v2/AVE2VeQMugPUWDg+2bpJaApRkeA4xQ9XfeW6Bp
 It7xYrwwbVhQtWRC0sRh+QNlU9HI28wPSnLWn7HFBeWupaIrxSp4IEL3eHUn8xv4aA8lpdNsHXD/X
 vqOSUwy5jlTPTlemvwaC9mNHagNdVXng8C6+hxiDLhZ6xH2P4qNHTKmjW61NsdF6Y/HfWP+lmbi8/
 474UNCltDt/fP01ajqogfWZKFymoH0O0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAtIw//WmQW/Z+SLdfrlDH5J2bvixzFNnO
 TOvp8uM8vcNZsxZwPXem4AeCXHayCqipxpa0iXWufEIvdMxkBxWvvM//V+rTUgQnJe6nhDxfLGklx
 5Mb2H+K/ndS73ElCuA30MPYq7mHr8i3gEmi2ZFX1W47JecJ8hno/DQxhHRG7bd+GFsiKCbsjLWXNq
 s/VaAK9uyOTQx7m6/2nR8L+Mvl1BrRXwkj7Qp0qxfQSd4r+IVNBzNFOcrGagBqsyHrN7Is7IICktH
 9VFl/G8P+hfviHQLnlxw9ltzpM1Dy6N1+BM3kbqD59gX+L6wqiLJI42eh+SHCiy35FvD3AFlYx4jZ
 MWE6qIgFnbwcL1kvcA7nnwfr3ZizCYPm8e334xXxslXBoRGsvjXSbAeAyZo2dvJXffNHdcDdUbJSl
 CfOixNGGKiQvs00X9ekfq9WmmRFvmYHu/m3lg1OXnMjFFIO41O51ZdhbEYJiqZEki7jA8Hd9xuWwQ
 nFDHhacU3xxivZ4BKQGQc+4XZ3yp/q6+7ux9prepRy/LeRyoaAmE67oxEsAgj+qyA3Tfy5nRTDdRQ
 E//gpaIt9H1VEx+68dRWHroxBQeozpnFPi25AlX3k4/EtVZjcItPWgE9iru1qT4DH3BBrz7Kd1zUw
 NnQC77zDJyZD2WUj1E+5bftO0aeE+7HZXj3tM/ea0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCaYBa6wUJCXqxgAAKCRCv5D8V6MJgkF/TEACOY2kL4NGFIbWeM5
 TUhatxqe8c3RT6jvNjq32CkvaK/cSZzBkS0smddyOzxt2WnsvMgkr9cM7P+CevoMwhT3e0lgQbqBD
 /vXZJjWKddC+iKXeqWkjMVcgCOsWNZ7PWEzRUT5X1AEFq2zzxQAQ/bCWEYNqIbHN4b6G1Wk+2Y598
 +KypZ3FS0bwiItnPQOWzOOqJCGxDxaEUuXFx4ah8HtVdtIev8jPS/5uzQO9iG2vZQUWeMEYZtfMHW
 sbFWqo2A3lxB+KPzNIYFhul4Lyx1CwvKUAGSHOx7FZuc2xI5DYt/Wdh2QyKFYr7xVzv3uwJjeS1+3
 6gvyB7DJaQuY+PziNPv4GPr5wy0cRkJ6Ps15fgC6y6wNwoNdNXKlwiuclIsBzJKa7A0pZMIfpCpIJ
 bEHP7oy3drBRAhIrBx7Lx1lyqqodDqc+ok5IQ5WcKG/TOrH732mTmJX6fxYTiCVxcU4WLJSNZbrZ/
 pjF0AWXs7E+onAkQy6RLg/XU1iiU5QdMvug+fTA6TpPSUMdujWtGWUt3/4nC+69AVc8tXtRQTZ7gP
 t7uIcQFwPqUuJGS26vl0w/6dIABQAyU9acvE3adCZra+/PBKFZi/yxT1WgV1T2mexKSWwQgLcR57J
 Yp5oWnQRgi/S6fAoskIWkp9UVcfAQPY0p45NwO5cZR9/g06JZmyrQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAz4A/9F+dMhzu7YonagL4qh
 WDz5IpRD4vzYKOBZ+qwYp1ugJz1BIUppN9i68HKoS4ARfgP97Sv9GpOy9g7L0lymH2MPF8hRPK0Yn
 7DKIkeu/r28YWEoWfoVm5reC+gpxMgmxBz4JScE4f6xfa7+Nw0bbTDl+nxftJD7lf/dTiruNJsXph
 HQnZ5wPXmxeH6XVJikfpyrGe8iJZALbtHtjlx6Omu7NvRGikenB8trrWS5W0F60ZdbqH1HdmDDcrZ
 pDq6LtAARHK5tGRm0SK6sZpKe3nULFeeCt7T/edk2FC6KVh4sL1jw1kyceX4DjiMffqYBPrhK5gz5
 cDIixLBF9C6Wt1ObvuDBrIQf1/3q6EZrUrUuf6qtaXDMuC6cSlShm47qaPEvVYh67O9JZQ7vzvaea
 UI74DJUb8Pjnz7mTOmMOzsS1gUhCue4n2YSSM6ythioCGb/3bgMGTpuer3JhvZG5s5uKD9yyj8s8x
 35qJkCFfjmjVx9s3vSUS48X+cUpYcMispErKzFu7C0YgKoxvJ4XTfXlDBiMFMPYcN67hsb2jeYHVJ
 wzE+fIZiDx9JLh1oQW2krwjweisE+3glOaKXZKi0fBtkxyH41iemLtLNYZRJopv6ykdl3hiI+Nh+a
 3FZJPTo/OpqchMm8XIeDxC4NFFiPMpyLeYzIxO7eZpiGrAjVTE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 09:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f30974 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=bcXxuKqiJE03SgATaGEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RJqTFXNaPDMH4AyxSK2XSDM_VLTpVirM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NSBTYWx0ZWRfXxzENuURwPtI+
 UyH2aS2AtTPQk2vKpdKLcQzXOUSlXvPg0EkgmkM5VPXFkVIcgAb++wvfUhcUEASyEc2rtQx53XH
 wA1jkqkf6bzpRvqeI55iq3N1d/uEW3ZH/q5olkJc1X+0JTTbxc6IHIP2NzoCf/iMLnkhxQcAklg
 f+WmleKd0ZEelnaqDvzbTO6jHMter8QkchN3hZOCu2t3F/G4ixF++poQKv0MP28DsbVOYSpr3oe
 EBhm7XyXMDX5dCFHAqZYbvMU4tIGc041fnWAhZVEbIEtCcGRpzXWVrzh4hZ8xhTHKdNoXhtC80Q
 +P9vrVo/KgORc5d95rshzk1RlmOm1UcocyxEAmUFLMogbevD/c6VfvB0hRXDyOAmH7CK1bD9tUq
 RTLKEGD3W1vxq0HE5A17xcYsqZ9NFxeOt7e7/ZnB98LJHN/iWsy0MCXSqSyidQP87UIAM2ThER6
 pI9KUmDn0MvycuSzKqA==
X-Proofpoint-GUID: RJqTFXNaPDMH4AyxSK2XSDM_VLTpVirM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300075

On Wed, 2026-04-29 at 09:48 -0700, Farhan Ali wrote:
> On 4/29/2026 4:41 AM, Niklas Schnelle wrote:
> > On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
> > > For a passthrough device we need co-operation from user space to reco=
ver
> > > the device. This would require to bubble up any error information to =
user
> > > space.  Let's store this error information for passthrough devices, s=
o it
> > > can be retrieved later.
> > >=20
> > > We can now have userspace drivers (vfio-pci based) on s390x. The user=
space
> > > drivers will not have any KVM fd and so no kzdev associated with them=
. So
> > > we need to update the logic for detecting passthrough devices to not =
depend
> > > on struct kvm_zdev.
> > >=20
> > > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > ---
> > >   arch/s390/include/asm/pci.h      |  30 ++++++++
> > >   arch/s390/pci/pci.c              |   1 +
> > >   arch/s390/pci/pci_event.c        | 117 +++++++++++++++++-----------=
---
> > >   drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
> > >   4 files changed, 105 insertions(+), 52 deletions(-)
> > >=20
> > --- snip ---
> > > +
> > > +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> > > +{
> > > +	guard(mutex)(&zdev->pending_errs_lock);
> > > +	zdev->pending_errs.mediated_recovery =3D true;
> > > +}
> > > +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
> > > +
> > > +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
> > > +{
> > > +	struct pci_dev *pdev =3D NULL;
> > > +
> > > +	guard(mutex)(&zdev->pending_errs_lock);
> > > +	zdev->pending_errs.mediated_recovery =3D false;
> > > +	pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
> > > +	if (zdev->pending_errs.count)
> > > +		pr_info("%s: Unhandled PCI error events count=3D%d",
> > > +			pci_name(pdev), zdev->pending_errs.count);
> > Sashiko notes a possible ABBA locking issue here between
> > pending_errs_lock and the pci_bus_sem inside pci_get_slot(). I wonder
> > if that would also be visible with lockdep? Also Sashiko notes that
> > zdev->zbus->bus could be NULL I don't think this is possible at the
> > current callsites via vfio-pci though. Similarly I don't think
> > pci_get_slot() can really be NULL at the current call sites. This makes
> > me wonder however, would it maybe be cleaner to pass a struct pci_dev
> > here so you don't need the pci_get_slot() at all? Both
> > vfio_pci_zdev_open_device() and vfio_pci_zdev_close_device() have that
> > readily available via vdev->pdev.
>=20
> The pdev here was meant for helpful error message. On second thought=20
> maybe removing the pdev usage, and using the fid would be better?

Either that or maybe just return the number of left over errors and do
the print in the caller?

>=20
> >=20
> >=20
> > > +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> > > +	pci_dev_put(pdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
> > > +
> > >   static pci_ers_result_t zpci_event_notify_error_detected(struct pci=
_dev *pdev,
> > >   							 struct pci_driver *driver)
> > >   {
> > > @@ -175,7 +190,8 @@ static pci_ers_result_t zpci_event_do_reset(struc=
t pci_dev *pdev,
> > >    * and the platform determines which functions are affected for
> > >    * multi-function devices.
> > >    */
> > > -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci=
_dev *pdev)
> > > +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci=
_dev *pdev,
> > > +							  struct zpci_ccdf_err *ccdf)
> > >   {
> > >=20
--- snip ---
> > >  =20
> > > +	scoped_guard(mutex, &zdev->pending_errs_lock) {
> > > +		if (zdev->pending_errs.mediated_recovery) {
> > > +			pr_info("%s: Leaving recovery of pass-through device to user-spac=
e\n",
> > > +				pci_name(pdev));
> > > +			ers_res =3D PCI_ERS_RESULT_RECOVERED;
> > > +			status_str =3D "in progress";
> > > +			goto out_unlock;
> > > +		}
> > > +	}
> > > +
> > Sashiko notes that mixing goto unlock and lock guards within one
> > function is discouraged. Here it's not that hard to read since it is
> > just a scoped guard but I think we should still not mix it.
> >=20
> > However if we also convert the device_lock() to a guard lock here the
> > goto would still make sense to go to the zpci_report_status() and that
> > is still a bit odd with guarded locks. So I think an alternative simple
> > fix, that makes this overall cleaner too, is to put the whole
> > scoped_guard() block above into a helper function then you can do the
> > goto out_unlock on that helper returning PCI_ERS_RESULT_RECVOERED in
> > line with e.g. zpci_event_notify_error_detected(). That way you don't
> > need to touch existing locks and you get to keep the guard locking.
>=20
> How about changing it to mutex_lock/mutex_unlock? I think the block is=
=20
> small enough that it shouldn't be too confusing. Moving to a function=20
> opens up the possibility of using a stale value for mediated_recovery.

I'm probably missing something but I don't see how moving it to a
helper function changes whether the mediated_recovery can be stale?
You'd still use the same pending_errs_lock and passed in struct
zpci_dev * then you just return PCI_ERS_RESULT_RECOVERED if mediated
recovery is in effect? And you can do the pr_info() at the caller so
you don't need to pass in the pdev too.

> >=20
