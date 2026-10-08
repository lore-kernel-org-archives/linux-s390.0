Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E448595E;
	Thu,  8 Oct 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451803; cv=none; b=hMFyxN3mwi83DFU9d+dffDkvDGVbrtLhnOIN26w9gzr9nIiz4juj+qtWZw8q0NMKMaSeMNQgkhqtNIQ0dY1e4OfqSL4MMrhTQHGILFvLQXL8xNWZWYPAM36pQ8sSw6/R5KLSm0uqo/87Z1HkoC3uJrQc5DsQR8mOrOEcIFpM62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451803; c=relaxed/simple;
	bh=lg5xaA9J1lLU5oZXnwJbfkDLtgOLt9N+5eB26wbrnk8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TgTKVmmFdzHETnvQ3jDTuZNc4PGqiDJlJb5ViAkMrQRrCmrVGMG8rIIO+H47Ws+JwQAqOc2pHcyy9bvmKzXp+kINFO5qSW1dEbB+Fog9F0K+p4uxsv3fugSX0hUl0OVcOF+J8sv68w5VLSMiX+o0mQO/vDAilEflIDJ4GZQgCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pz4oQIED; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pz4oQIED"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZmJS731739;
	Thu, 8 Oct 2026 09:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=027tSR
	P0Qzyon4iYhMU7xZEozCsZU+gUdwo4e0hK+2M=; b=pz4oQIEDdqiCK5HRWmOm4a
	1ZROH/96iTQma9Plo20EOQAAExSjazxvm3RsbW0KghkY64S6UAZBVVROcttBGVpg
	ugwgnyhMzUfsqhnkEdxaz/cwLP8nYywf2u137qEUXpNbxVk9Vq7b2ou4rV2umN1z
	vCnTlYdu4Ye+zdTbv/WC+xqy3eL/I0igzeo7980M4Yh1KiQLkftJImZ5aU4XdCkW
	mPjKQdMW/j1YT3pg5o09fK1bkv1fkpWQ6ci9XtGIlwYGvxtGGXDcVQMt1tgHYsqE
	6W+33ksPhghNo+bSrirlK+/BLyYL4DeUPN4/+8tnTpkOBujHVT8In4R82DvDCXlg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjewv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:29:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987J0UQ3089525;
	Thu, 8 Oct 2026 09:29:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5psut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:29:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6989Twf863242688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 09:29:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1F358043;
	Thu,  8 Oct 2026 09:29:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5364858053;
	Thu,  8 Oct 2026 09:29:56 +0000 (GMT)
Received: from [9.111.34.167] (unknown [9.111.34.167])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 09:29:56 +0000 (GMT)
Message-ID: <7449a0e54f42673c17adc551be2b07cb4c19eaf2.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger
	 <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
In-Reply-To: <f082e43f024a3aa4a897b388b346eff4edea37ec.camel@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
		 <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
		 <sashiko-outbox-162922@kernel.org>
		 <8086f631ce7ce60f1763171c8f05b050ff6c73fd.camel@linux.ibm.com>
		 <9e3894fa-0a1e-432b-ba1d-76ea34d4f648@linux.ibm.com>
	 <f082e43f024a3aa4a897b388b346eff4edea37ec.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:28:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJHje7OlKZBDdZudsLajWOL2NmmV-s0R
X-Proofpoint-ORIG-GUID: aJHje7OlKZBDdZudsLajWOL2NmmV-s0R
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac76297 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=RWUoVfpbKxqPCDuM3soA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX+DONPOXCIgOt
 So5M+k142nx3vz5KQN79MoBdrduBae53urhhsS1fSmKV97I+cDPWfFOX0DuQTZAZPCW4RAberA4
 WQ5IAroB+uqTskWS6mpXq+AU67ug+bY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX/fgHHnqslqGA
 9Y7pa8CH7d2PsacMybhmc9zBwgkZgrD/14v3jFTxl+RU96mCB2Y+lwyZaZaOlyX0t/IHStAZKhb
 +OK6r4mxVxAfkwuLCMERYdRff9WJ788vhna5582vfYh6VzzLxN+EJxGfQoa6M9KY66MAHzvQ+YR
 2RPUCohc52vEcEsCVB+qCyq0GNc9wlegzo2UyIPdVqdbwLxctPDrne2fbU7VBcI5Tyupp2x17Gu
 7f1aRmVXNtpywWi+wgPx79EYr47MSrWkC2nNuKUg7K2FmrX20+kvHh2ZpRpmLC28sJXelT8uraA
 gyrttsACs41sMfeUvVf6BMM5t3k+LTDGSDwELfICEgdha/06hywkKwGpLsQnliJGbTT0o8fICP1
 n8CBsI+2x4IMzu3Q+oyvmsFjYvwUhpKjjMkIufq3SDYvmzcAEPFvN6jSRU9aPm1Nk9oUV/1AT6k
 Gf/hrM9B3Hl31MD5JZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080036

On Thu, 2026-10-08 at 10:50 +0200, Gerd Bayer wrote:
> On Wed, 2026-10-07 at 12:21 -0400, Matthew Rosato wrote:
> > On 10/7/26 10:46 AM, Gerd Bayer wrote:
> > > On Wed, 2026-10-07 at 11:19 +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potentia=
l issue(s) to consider:
> > > > - [High] s390/pci: infinite loop in zpci_refresh_trans on CC=3D2
> > >=20
--- snip ---
> > > > If scanning the initial portion consistently exhausts the hardware =
time slice
> > > > (such as during IOMMU TLB flushes on devices with large DMA spaces =
in
> > > > zpci_refresh_all()), will the operation fail to advance and loop in=
finitely?
> > >=20
> >=20
> > That concern sounds valid at face value; if we tried something and it
> > couldn't be completed in time, from a linux perspective we are simply
> > trying it again without changing anything and hoping everything works
> > for the best this time.
> >=20
> > > I see that all the PCI related instructions in this file may retry
> > > indefinitely (with delay) on CC=3D2. However, the architecture guaran=
tees
> > > that at some point the instruction will end with any of the other
> > > condition codes.
> >=20
> > I think that is the rub.  Sashiko couldn't possibly know that such an
> > architecture guarantee exists.
> >=20
> > I suspect the question is also a bit theoretical: what happens if the
> > range is so big that it's impossible for the RPCIT to process it before
> > the CC2 trigger point due simply to how big the range provided is?  The=
n
> > you're guaranteed to hit it every time unless you 'chip away' at it by
> > shrinking the range after each attempt.
> >=20
> > I would assume/hope that the SDMA-EDMA range limitation we impose on th=
e
> > aperture size already ensures that it is easily possible to handle a
> > RPCIT from SDMA thru EDMA without tripping CC=3D2.
> > So then the CC=3D2 case becomes purely situational vs a guaranteed resu=
lt
> > even for the largest possible RPCIT request.  That already makes it far
> > more reasonable to simply try it again.
> >=20
> > So: assuming that architecture guarantee stands (we know RPCIT can
> > possibly complete for the largest possible range SDMA-EDMA, and we have
> > some architected guarantee that the loop will be broken otherwise e.g.
> > architecture says it won't keep giving us CC2s forever) then it sounds
> > like nothing to fix, but maybe worth a comment in a future patch that
> > explains these guarantees, based on what you find in the ISA.
> >=20
> > I suppose we can consider whether linux should have its own redundancy
> > here or not in addition to those guarantees.  That sounds well beyond
> > the scope of this series and goes back to what I mentioned at the start=
:
> > this is pre-existing bevahior and should not hold up this patch either =
way.
>=20
> I went back to commit cd24834130ac ("s390/pci: base support") from 2012
> when RPCIT was introduced: The potentially endless loop on CC=3D2 was
> introduced at the very beginning.
>=20
> I found explicit words in the ISA specifying that "no other action is
> taken" when the instruction ends with CC=3D2. IIRC, CC=3D2 was introduced
> to signal a program that there are internal inhibitors present that
> prohibit to even start the requested "refresh" - or other PCI
> instructions. I still have to search for a statement that guarantees at
> the architecture level that CC=3D2 won't be presented forever. When I
> find that, I'll think about how to frame that into a future patch.
> >=20

This looks like a very clear case of LLM hallucination to me too. It's
not that surprising either that the model would make something up when
it doesn't have access to a good reference and what it made up does
make some sense. Either way, you're right for the cc 2 "busy" returns
the platform must ensure that at some point it either succeeds or gives
us a different error cc. As you correctly state this assumption has
been there from the beginning and maybe we need to ask for a more
formal guarantee statement but in the end a "busy" also just doesn't
make sense otherwise no one can be busy forever ;)

Thanks,
Niklas
