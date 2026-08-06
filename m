Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93861C5D59;
	Thu,  6 Aug 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022857; cv=none; b=m0zIi4AirhcVm5fH6mqBcHWIkFexfwcs6BwzvqXihkWyeImuOHPh3Qz7VG5nzt8cPQ7jN2/twRGkmN2VyY1zVIvpUCBiSYIFIP5VrfxJQND/+y3OscI1QatGG/pbHBrBjwS4v02gkd0G1ZeuD/KaeJu8avi5e2idUO2DOOFbFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022857; c=relaxed/simple;
	bh=SqjcMEJsTfxPDy4Bl994t/pi15aqq7NlGJQg/ZXDqPY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gbexTO94DwfZZnL8VZP16k8d0gjnQRsxYSEQORD5jkIxjZ36c99Gx4h6yFHd07HPnIabh+I9tkoz/le/Spl0x5O5m7guHUOikJdYqfcaZi2cG3JQbP4ID+EPzy1MPjnZB5MMXqVy5rKM/W5vvCYitJ9ACNpfGcuNC8rVXibHc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M3nNcRZw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M3nNcRZw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmrZK1068446;
	Thu, 6 Aug 2026 13:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3p/urd
	5yrJhNURjwiR0XdUWbKOvqwGii/pP/Fx1DH1I=; b=M3nNcRZwiW7zuVup7DJ9Yf
	mV9DtIt3IZ9JXcRK9+opcDxvLfzrD/kpRkvS/h7V8G/Eny48XV5fi+yUWs4OlDhd
	GlJmnNSprkQm+8oMF+Mrhqxwk1WOeXrs83TITydKv59kojZUdRmCP4B8t9xt2bEb
	eKlOikwMVTlbh+5anF15oKcxwi8kNjV+gGFlsxV8QSoG20l6zm4CJ3hHMd74YE2g
	MAEKQ6gWq170tnImf9qM5/KUGQ8iuqIoc9L/MRVg9CkKtR0KhBSIWIQXT3CREE8+
	rKOYVrzD0JQ0jaS9vzLjL6puIoXe+FzmVz6YIzJiYOD1y1aD1DdcszMKMwFGzv4Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a48cx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:26:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676DQHGd002958;
	Thu, 6 Aug 2026 13:26:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4que74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:26:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676DQu2j39780858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:26:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C36258063;
	Thu,  6 Aug 2026 13:26:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ACFB58055;
	Thu,  6 Aug 2026 13:26:51 +0000 (GMT)
Received: from [9.87.149.45] (unknown [9.87.149.45])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:26:51 +0000 (GMT)
Message-ID: <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Danilo Krummrich
	 <dakr@kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev	 <agordeev@linux.ibm.com>,
        driver-core@lists.linux.dev,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Boqun
 Feng	 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin
 <lossin@kernel.org>,
        Andreas Hindborg	 <a.hindborg@kernel.org>,
        Trevor
 Gross <tmgross@umich.edu>,
        Tamir Duberstein	 <tamird@kernel.org>,
        Alexandre
 Courbot <acourbot@nvidia.com>,
        Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>,
        rust-for-linux@vger.kernel.org
In-Reply-To: <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
	 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
	 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
	 <20260804071330.24760Aaf-hca@linux.ibm.com>
	 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
	 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
	 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
	 <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
	 <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:25:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a748ba3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=-7aFLyduKmNeS4uVzOQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b23eBMweD_6RWPSuxM-j0TkZXHMI2pqj
X-Proofpoint-GUID: tbYH8ZhbpMk32MHVhmCDCxdpZRS5Sx3K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfX4AN1tntQwfJP
 7IDiJXPeF0HOCodeGyzcXGiOR+Z5LpVETuhOSMcxBpvdyYTL/KOhbJ8OfCUnuMTZZe6ApGIqn09
 nKbrNKwoSSold7dhkqnfONfJpJDHKOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfX9f8Z31qFetJX
 GmviPN9afc40edU5kFH+qB9fhtmI05lm6jRF+GMDcOc6zvuus9zoD3fBYc6Cs6E9wZDxH+0xY8h
 Lq5tqsdhTVa/XAq2mDQCnKJoj9J6BTs3apTJMDblJ9LooymvEjINeYcm7s03Gz36K6ccxDEcFjg
 e+MRYASJN8Bff1qekWSle8gXi0+aEG5sLdc9c48FDygXjXGIPoctnlvNQlVDR0Fo0zhWwMsn/9T
 HFO890V8k2w5nTVQvN4SslvYhmfbTewrK22KE/g7h91HAsh1D3d2atbpg0l9yKyr2qeyMGHIwJO
 JItpEb15MCDJbo38p4VmYP2PTeA+EasWWOp8DFDwpv0oY77nc8nyHmz210zT/g0ZgE6LVk9p24R
 sIcTjb1FpTNmn+hNmbS6bB35vuTCma1ntmCnQ3N0Ag+Uc6J5r6b0o5LTixScbLLu8xKvqJUaZ87
 6TAaD88WgH63OJ9LW8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060104

On Wed, 2026-08-05 at 17:56 +0200, Arnd Bergmann wrote:
> On Wed, Aug 5, 2026, at 17:36, Niklas Schnelle wrote:
> > On Tue, 2026-08-04 at 17:52 +0200, Arnd Bergmann wrote:
> > > On Tue, Aug 4, 2026, at 14:21, Niklas Schnelle wrote:
> > > - On PCI MMIO areas, memremap() and memremap_wt() should return a
> > >   normal kernel pointer that can be dereferenced, e.g. for
> > >   option ROM contents for a framebuffer console. This can't work
> > >   on non-MIO guests but might work on MIO depending on which
> > >   instructions are allowed those mappings (I can never quite
> > >   remember how this part works on z, does this have to use
> > >   pcistgi or does a normal aligned load/store work as well?).
> >=20
> > You still have to use pcistgi/pcilgi/pcistbi normal aligned
> > loads/stores will fail as the physical address is beyond the memory
> > limit. On the other hand the PCI instructions can't access normal
> > memory. So you when using memremap() you'd have to know which kind of
> > memory you're remapping and use the right accessors.
>=20
> Ok, so memremap() by definition cannot work on s390 for regular
> PCI devices, since you are not allowed to use readl() etc on a
> kernel pointer returned by memremap(), only on an __iomem
> token returned by ioremap().
>=20
> One important exception seems to be virtio_fs, which uses
> devm_memremap_pages() to map a virtio_shm_region, which in
> turn can come from a virtio-pci device but is backed by
> actual cached memory in the host instead of an emulated
> PCI memory BAR.

Interesting, do I see that right that devm_memremap_pages() and
memremap_pages() unlike plain memremap() does not utilize ioremap() and
thus isn't affected by our nopped ioreamp() when there is no-MIO?

>=20
> > > This would not help with either memremap() or the !CONFIG_HAS_MMIO
> > > issue though, right?
> >=20
> > I think it would help with memremap() because it would mean that when
> > used on normal memory and accessed with normal loads/stores memremap()
> > works and when used on PCI BAR / MIO addresses and accessed by I/O
> > accessors it would also work. So it should behave the same no matter if
> > memory-I/O is available.
>=20
> Have you come across any users of memremap() that pass the
> kernel address into readl()/writel() rather than accessing
> them as pointers? This would of course work on arm and x86,
> but is still a violation of the linux/io.h interface definition
> and causes a compile-time warning with sparse. If these exist,
> I think we just need to change them to ioremap().
>=20
>       Arnd

No, I'm not aware of any users of memremap() that would then use
readl()/writel() and I agree they really should be using ioremap() and
the use case doesn't really make sense I was just thinking about what
would technically work with the prototype I have.

Thanks,
Niklas
