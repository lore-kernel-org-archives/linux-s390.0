Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8083EF643;
	Wed,  5 Aug 2026 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944278; cv=none; b=Hi3l8nKD2uIEGf3EYICXnutUvyToGZ/tFiwnmkRdRk2vh0C+8GHjito6FJz7ZlBJLo1Tub7kIHKx4wv31PjCEW9iBob8XDwpJBjfuq3SF5+f1XNgh5hQATSThf7S/x9WfbahHQo6Qb911iXyhlzmUNDf+4+DaSOItfN/zyKFc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944278; c=relaxed/simple;
	bh=KOw7dT9ocikrig+6Tpa+BlMp3tZja0cTFzufrMJA3bo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KvThLAELCrLnRVXYymlRiUFSEPrFOkhwRobjLix8ME8HO8V03zmpx3dQf9IbeAZakHbhHh73kTGDPvdcWG174XlJKMf4KcmZfbK0W1A/uqboeZQ1ufiX8GetWUH3zOcIHtkgoy+GHYShQ9CDNGdaQu11FuVsMi7t8bRCXSMMURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oH7HbGL6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oH7HbGL6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHwMd3825458;
	Wed, 5 Aug 2026 15:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ahdLhG
	8DYP4r6IJKL/HEO4diPXi3SndktJsL8gTrpK8=; b=oH7HbGL6ioz9Dztz6KDwWZ
	ebVIyxNOZc0/yBh/8+QxPEWpULKhQS/Vg7KgarbCTgSU5jcd4suHzNBgYpJLVd2B
	bCD3Bd0a0g1+TiTlpCk1dqP3Cwn1M8oAkwklgQuOMMuZoKU8TsYFolJU3+Ell3IU
	pps1wPIRuvYZsKdN4BDK0MAfjF0DeXgKy0qe4JiPM64KuzGZ3292dUp6Fm7TQI5g
	x5Zm8pPKrSwScXh+VaGV/K5k9zI5W0Qig7m8D+B2uWKe49zsKNBC0kyzeDYp+gkA
	vn4SRHnmqc+mJAADQqJOYq5cnnPIHmdfcR5zADUJ+XJCfRV8CdisHRuNVhq70MAw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h53tad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:37:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675FQKJq021438;
	Wed, 5 Aug 2026 15:37:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k75p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:37:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675FbKW726215026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 15:37:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895C25805F;
	Wed,  5 Aug 2026 15:37:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62DF65805A;
	Wed,  5 Aug 2026 15:37:15 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 15:37:15 +0000 (GMT)
Message-ID: <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
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
In-Reply-To: <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
References: <20260803180931.97202-1-ojeda@kernel.org>
	 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
	 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
	 <20260804071330.24760Aaf-hca@linux.ibm.com>
	 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
	 <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
	 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyNCBTYWx0ZWRfX04HmUhZZ4FQ3
 h24Gjn5b+bAuw9GMhJpVsH+xv6O4b2tMtx7BKI0XSJ3aaAeMqChIQdOgEyEehEO8a7ubU9Ish/K
 rDKLuXGRX+pleIAfU7cFsf91L0mo5NA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyNCBTYWx0ZWRfX2bzXNdFPKqJ8
 tsy7Geqr5Yr63FCOXPvY3r/X2TKV9BI67IsUkqFcEjrvzHr/Pew9XQyvOdc+hvpL0y5NapNBDRm
 FkmQoENyznz0m7EqhfbV8KWN+qiwbAjjn68jLdyEBqVr160en/aCn/5w177lemUzbmp2mMRDbPp
 VBaJZZCxcm3UOz5jUnsIM/FoH/Tj2wOQL0Gpx+wxGjJmikegCvUATwZFvXcxvvvt8JUnqZGBVia
 mqL6KixTdfYVIhWQ0iWp3sJRwKRc5S5L36zCIaW/BPJpiLkLAUYYClZjC7k6pyoDsFXohDY875q
 9yxrXiFzJmUltYBgUoxZlmnXmlroKuxMaHX0iJoW3ZDHHRSPaYNPMyhzCIfjrYGc9UXJw0K1Kdx
 eGLv47HPaSNloMvL+H05pAeYFXKyvGQ+g76BYVe9CFV7BUL9Vp5kD2uez7khj1/MlEiCyP1a84a
 ZW2OqcvYFIPKv2vefsQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7358b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Okgr_rpAkVYiebJifJEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5WgwwRmWRLkMPcTanpqKV5LwhaZ2hGFo
X-Proofpoint-GUID: NtfyF9feNjyIM7cGj7IWzStutXfslfWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050124

On Tue, 2026-08-04 at 17:52 +0200, Arnd Bergmann wrote:
> On Tue, Aug 4, 2026, at 14:21, Niklas Schnelle wrote:
> >=20
> > I think there is also an interesting interaction with memremap().=20
> > That calls ioremap() under some circumstances and it's a known issue th=
at on
> > s390 memremap() will work if the PCI memory-I/O (MIO) instructions are
> > enabled (e.g. on modern LPARs) because then ioremap() actually maps,
> > but won't work if they aren't enabled. With your proposal it would also
> > work for !PCI.
>=20
> Right, that is an interesting one, as there are somewhat conflicting
> requirements:
>=20
> - On PCI MMIO areas, memremap() and memremap_wt() should return a
>   normal kernel pointer that can be dereferenced, e.g. for
>   option ROM contents for a framebuffer console. This can't work
>   on non-MIO guests but might work on MIO depending on which
>   instructions are allowed those mappings (I can never quite
>   remember how this part works on z, does this have to use
>   pcistgi or does a normal aligned load/store work as well?).

You still have to use pcistgi/pcilgi/pcistbi normal aligned
loads/stores will fail as the physical address is beyond the memory
limit. On the other hand the PCI instructions can't access normal
memory. So you when using memremap() you'd have to know which kind of
memory you're remapping and use the right accessors.

>=20
> - On areas that are backed by physical RAM but not part of the
>   kernel memory (something like z/VM DCSS) should be mapped
>   using memremap(), which would fail with the current !MIO
>   implementation. On x86 and arm, this is done for mapping
>   firmware blobs, but I don't think anything tries to do
>   this on s390.
>   Right now, not having memremap() defined on !PCI configs is
>   the one thing that lets you know if some non-PCI code ever
>   start using it, other than crashing a non-MIO guest.
>=20
> > I actually have a prototype lying around where ioremap() always remaps
> > by mapping the address cookies much like we do for user-space access
> > via the s390 specific MMIO syscalls and then doing a page table walk in
> > the accessors for the case where we don't have PCI MIO support. That
> > would also allow us to implement the s390 MMIO syscall via
> > generic_access_phys() getting rid of quite nasty inline assembly and
> > over 300 lines removed in total. On the other hand it would cause
> > overhead for non-MIO systems and sadly this currently includes all KVM
> > and z/VM guests which is why it remains on my prototype pile. I haven't
> > actually been able to measure the overhead but clearly more work is
> > done.
>=20
> This would not help with either memremap() or the !CONFIG_HAS_MMIO
> issue though, right?
>=20
>        Arnd

I think it would help with memremap() because it would mean that when
used on normal memory and accessed with normal loads/stores memremap()
works and when used on PCI BAR / MIO addresses and accessed by I/O
accessors it would also work. So it should behave the same no matter if
memory-I/O is available.

Thanks,
Niklas
