Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEF32AAB6;
	Thu, 19 Feb 2026 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537106; cv=none; b=GVS51B4XoXKofQSyIGNL68xkI6AVO0qoDO+7uf1gDubfiJK/Jw3couezTCAjj8z0hCAdeA9PRfT3nR3HShdwLLhYwKTe5vqrGE11M3XT78tqFj6sAfl+CJBL8qh76ubuQUwFR9cKoAlmdwkMnpw5OHmIE7NBnDknx/EVjW5K44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537106; c=relaxed/simple;
	bh=xHIZ8InWsWt7cRxRhkSl7jAPYEW2L5LYlecHFeUG3Ic=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=umHmy1J+5pBGwjnE8OMofkR3DQl4eft7WxO/SToWg6VC7RimJ119u5nBoJpIfAnYDqFTBkiJdtqG426bNRA+QEZTEsWgUJDrdP4vJ6LWSvuAv3XRh7isi1uTKL6xRugZUjcjeEmSXepayHm630eLQOZDNMHA5x6BxwZbPL/c0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cNl8VD81; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cNl8VD81"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKsp0N1600928;
	Thu, 19 Feb 2026 21:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UIUedV
	f8Uz5SgZ13wnLmKWU+kgTpHTtHsnKGIUtPsS4=; b=cNl8VD81FFqIvHJXOCcZLE
	lxaTGOCP7vPp7fxDIHP9CwsJL+ZKTkMTLs/KvmDSOXlc1pLgUL++mFCcfsafeMMF
	vtTEO+aK2sZ7NrXHkfewRPCjkueu69VYvPrQ0CC0EYJuYzjZr+3Ywm9WFCvFrQzp
	fqh9gp037p/VYRjMjyTCgVYCY1DC3uusi7K+X8vKCctGvOGnFH1kpYknBW4JkLsI
	azG4SajDGSLp1fhxtZEiuvw3CNiB9Wgme8d5qHRSpgPwn3ZNP2XEGdD3FjBdV8NO
	q2QyhkHc/eX1HoOKtUH5SZPeZIasnl8yKhle+ByjRW7ZGq5t5HvOqgnZtDKFKzXQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcr881y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 21:38:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JI3J4F023889;
	Thu, 19 Feb 2026 21:38:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45e069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 21:38:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JLcATF22544952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 21:38:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAFC58050;
	Thu, 19 Feb 2026 21:38:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51FF158045;
	Thu, 19 Feb 2026 21:38:08 +0000 (GMT)
Received: from [9.111.94.239] (unknown [9.111.94.239])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Feb 2026 21:38:08 +0000 (GMT)
Message-ID: <873a948a74df082bb22672cd58136337ffb54083.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/9] PCI: Allow per function PCI slots
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        mjrosato@linux.ibm.com
In-Reply-To: <54301c56-1add-4029-b6ed-b441e4fda8dc@linux.ibm.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
	 <20260217182257.1582-2-alifm@linux.ibm.com> <aZTaPH85j5R81Vna@kbusch-mbp>
	 <54301c56-1add-4029-b6ed-b441e4fda8dc@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Feb 2026 22:37:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gu1USADTSAeiuQcL4G9WUlzhAPz-C5K-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5MiBTYWx0ZWRfX3qb8LJLprNle
 7GGxsgTl3xAebK5YUDOysu4eYlpvqWLKVQJM8t9GBKjHpP4hUsiuVbA/Ib8GnMCw3eIZviKkpwN
 630AdRwYVrPqdvx+Pm1nYwsmbMJf1pmHTg0EongFd+uukaYVAsi9cpJNCePgVzuF9W9rbvO//pe
 qtvv5AtPGn7KA3LJYv24+30W/JhrM6BvrAdQf+ndSyZIfwNf4y7QlrVMHdP8FwIGEMcX0gcAe+i
 +jNMMKFvQURwQK57A34I/Dq4rlS/EEssLN8ANwfaKNYdAUBnalLdAYu8n/5T+Aa9LufoN8ryA7J
 pDRoW6xDKPvQ2qCCdwXdiMEDuQbt2dqGmODYF9Ak8oZ/3we+83ROzONm1jMSHWMyW6RUDyNRQkX
 +J+gOPl6yyushJim+p6g4hD8Cso7SBn4SEXPcAkX7Q/hVpo7rzt6xvF9d1hnQf6PetOgUy+zvex
 1QcWhMGS/NcF8wpg/Rg==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=699782c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=D9_2xHumePqsTmCLSkIA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Gu1USADTSAeiuQcL4G9WUlzhAPz-C5K-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190192

On Tue, 2026-02-17 at 14:26 -0800, Farhan Ali wrote:
> On 2/17/2026 1:14 PM, Keith Busch wrote:
> > On Tue, Feb 17, 2026 at 10:22:49AM -0800, Farhan Ali wrote:
> > > Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot ob=
ject
> > > to multifunction devices. This approach worked fine on s390 systems t=
hat
> > > only exposed virtual functions as individual PCI domains to the opera=
ting
> > > system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunction=
s")
> > > s390 supports exposing the topology of multifunction PCI devices by
> > > grouping them in a shared PCI domain. When attempting to reset a func=
tion
> > > through the hotplug driver, the shared slot assignment causes the wro=
ng
> > > function to be reset instead of the intended one. It also leaks memor=
y as
> > > we do create a pci_slot object for the function, but don't correctly =
free
> > > it in pci_slot_release().
> > I think leakage is because s390 is passing in devfn when pci_create_slo=
t
> > is expecting devnr, so things are not getting matched and assigned as
> > expected.
> >=20
> > If you're able to make this change, it will clash with one existing
> > thing, and another proposal I've got at v5 now(*). Specifically, this
> > would allow all 8 bits to be used for the pci_slot 'number' when it's
> > currently expected to be limited to 5 bits. 0xff is special, and I'm
> > proposing another special value. If we are going to allow the slot
> > numbers to use all 8 bits, I think we need to change the type from u8 t=
o
> > u16 so that there is space to encode such special values.
> >=20
> >   * https://lore.kernel.org/linux-pci/20260217160836.2709885-3-kbusch@m=
eta.com/
>=20
> I am open to suggestions on how we can better model a pci_slot per=20
> function. And yeah, I think it makes sense to update the pci_slot=20
> 'number' to u16.
>=20
> Thanks
>=20
> Farhan

It may give some better context to emphasize that s390 has been using a
per PCI function hotplug slot model since commit 7441b0627e22
("s390/pci: PCI hotplug support via SCLP") from 2012. Quoting the
commit description here:

   "The hotplug controller creates a slot for every PCI function in=C2=A0
   stand-by or configured state. The PCI functions are named after
   the PCI function ID (fid). By writing to the power attribute=C2=A0
   in /sys/bus/pci/slots/<fid>/power the PCI function
   is moved to stand-by or configured state."

So this isn't a new concept or something we can really change since
users and documentation relies on this for over a decade. It's only
that for the longest time the mismatch between the hotplug slot and the
pci slot went unnoticed because it really only causes trouble in very
specific circumstances even after we've started exposing the devfn part
of the geographic PCI addresses for SR-IOV capable multi-function
devices e.g. for the two PFs of ConnectX series NICs.

Thanks,
Niklas
