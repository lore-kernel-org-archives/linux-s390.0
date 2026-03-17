Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6B35F166;
	Tue, 17 Mar 2026 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741744; cv=none; b=Y3/jUEsSEMDC/FRjb9fksTuLBOY9QbDwC96sC+isPqYZCUGgfAhUzpL72EKcxz0MiMu0Qe69CarQbkzN68VoLf55oFWfxzdcg6PRgDVU0Ne9rQojlsBEKbU0FP1pKkRGRrHB0TUrPQbNT7iJbWUufu0/TgvX1EabiyvtvJ7i2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741744; c=relaxed/simple;
	bh=aG3FFPKh4hTVCNstPdGYx0sLO1kAavWNNRKcaF1haTg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AF7jeorxiwGgBJ0oBTjzSEf4x/GbEXUfPQD/0dLHpUS/uBaMellbN00WxmByCFkYhySpO+T1YRKEvPg0+dh5/EJk5oUdygS/6snPAFLrGbRr1OQt33NLgCuaEzhVixBQIXSeHYv19CvWyPNFRz7fmIDqGBofOHjVVwbXicaBE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S28n5FtE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S28n5FtE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9NL8o1374065;
	Tue, 17 Mar 2026 10:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RLkbSB
	/SzzMyZttJuZfettVuzPD702M4h6+m6gsqEXE=; b=S28n5FtEjgIzEq64DmQDtR
	A5IgQMHrXGKJKsOBPn4ALVHhRShRNc/XiyF+yFm3XI2Dx4UEclOdOk3XcdOyB8AZ
	ctZLOYt/OCJ/PT1J5pCtzFiGqurd1//8iU6IgBGF1cBtoa9CgGwIRdOdUGtM2G8L
	U0C0PVD51M1TpjdFrclW2MP4eLJk65QkrSuB/hCudfYmqrrR4W/EI80Dp6Pj1xqn
	VxPkKZ9L0MOC4yc/2Ff4krkNXxIwyA4KHT+/1+0UGT/lIij4uuEkPLxagk/pkFAc
	9kjglTjh1xFT2XLP6ed3fkD8BRztlqGbGY1+1tFZ6pa+c166IdlCpOcCys5m434Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64m565-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7jR3j032333;
	Tue, 17 Mar 2026 10:02:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jrdtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 10:02:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HA2FQ65046906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 10:02:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEEEE5805D;
	Tue, 17 Mar 2026 10:02:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4069A58054;
	Tue, 17 Mar 2026 10:02:11 +0000 (GMT)
Received: from [9.111.91.128] (unknown [9.111.91.128])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 10:02:11 +0000 (GMT)
Message-ID: <87b6394f8fc587281e310fdc84d7b5fa0135f387.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] vfio/pci: Introduce vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Alex Williamson <alex@shazbot.org>, Julian Ruess <julianr@linux.ibm.com>
Cc: wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas	
 <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin
 Tian	 <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <20260316130305.21e015ef@shazbot.org>
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
		<20260313094127.74aa0767@shazbot.org>
		<DH47JTI4L8PJ.2A4XCC5SRV0NW@linux.ibm.com>
	 <20260316130305.21e015ef@shazbot.org>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 11:01:10 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3dgH3YR9wH0hzLEl539haK_hts8NOpX7
X-Proofpoint-GUID: 3dgH3YR9wH0hzLEl539haK_hts8NOpX7
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b926a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MsBGacowydRqnMt2wnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4NSBTYWx0ZWRfXyJ1GKTM45WZx
 QBdgmdHidQs/tL2UOYOAnE0VC1l986j1NZsAWJgQ7KLY+LUNmOQ+VafM+KZKiLcK4LEV0B3pbGH
 surt50Oey2cGbiRXFwG62pYRdl/SLiY8s0FBlExcBCBAhrDV0lCSwfL6EmxEjPGXmV3ZKBWFZgs
 9366qeJ8w8Pj+pfAvbiRCqM65Cwb/TryLVHKNiOWVa09Gn1eUIOlKL4IkfyHtmsTqdnlS3x8LC+
 nf4HShJ9Bp36LcCQ6SCYXlvIJyT2/B570JEJgEIYUEbJW/KRrfZc/U4J2wpcGSdK7lUCP4kJ6uk
 knq7rVF0DflQFcpXR+OB4FTw7fK176E+s/X75Ex0PeAtU0Ie2srqMnBIXgA2zGB2BOg/EoSCloi
 1KRuOU95yc5wijSw7FoEeMOo5t0gr3PepoHVMiiuILxaDnwxHmS7nOiWIblhpadK3CRuzYhq/hF
 qFUuyvL8S4Ruxx1Sn6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170085

On Mon, 2026-03-16 at 13:03 -0600, Alex Williamson wrote:
> On Mon, 16 Mar 2026 13:33:04 +0100
> "Julian Ruess" <julianr@linux.ibm.com> wrote:
>=20
> > On Fri Mar 13, 2026 at 4:41 PM CET, Alex Williamson wrote:
> > > On Fri, 13 Mar 2026 15:40:27 +0100
> > > Julian Ruess <julianr@linux.ibm.com> wrote:
> > > =20
--- snip ---
> >=20
> > Hi Alex,
> >=20
> > thanks for the quick feedback!
> >=20
> > We are currently developing this extension for a non=E2=80=91QEMU vfio =
user space
> > driver. Reads smaller than 8 bytes are theoretically valid, but they ar=
e not
> > used by this driver nor the existing in-kernel driver at the moment. We=
 could
> > extend this in the future if needed.
> >=20
> > vfio=E2=80=91pci based PCI pass-through of the ISM device is already po=
ssible without
> > this extension. In that case, the ISM driver in the guest kernel access=
es the
> > BARs directly through hardware virtualization, without using the new ac=
cess
> > routines provided by this variant driver.
>=20
> Hi Julian,
>=20
> The cover letter argues a secondary use case with QEMU, especially in a
> nested environment.  The ISM range appears to be an interface to a
> variety of device types, console and block are noted.  It's also noted
> in the implementation that the z/Architecture allows sub-8-byte access.
>=20
> I think we need to be cautious that the existence of this driver makes
> it available for use with QEMU and other VMMs.  In the case of QEMU
> vfio_region_ops will allow single-byte access by default.
>=20
> The restricted access width is positioned as a simplification here, but
> it needs to be evaluated against all the use cases.  Unless we're 100%
> sure none of those use cases rely on sub-8-byte accesses, we might be
> setting ourselves up for hacks later to fix or detect partial access
> support.
>=20
> I'll leave it to IBM folks to determine if this is indeed a
> simplification for long term support of all use cases and not a short
> term fix for the short term use case.  Thanks,
>=20
> Alex

Hi Alex,

Thank you for the insights and expertise it is highly appreciated. Your
reasoning makes sense to me and I agree this simplification looks like
it may be ok for now but could cause more trouble than it is worth
later and there's really no reason not to just support < 8 byte
accesses too.

One thing I'd like to explain though since you mention ISM potentially
being an interface to different device types. This part of the cover
letter is easy to misunderstand since we haven't yet send out patches
opening up that direction. There is only one ISM device and even future
versions would likely just iterate but serve the same purpose. The
multiple device types including consoles and block devices will not
replace this ISM device but rather sit on top of a virtual bus called
the ISM Peer Bus where the ISM device will serve as a communication
channel between two Linux instances connected via an ISM device.
Specifically in the current design there will be a vfio-pci based user-
space daemon/driver on one Linux instance that provides virtual
consoles and block devices for other Linux instances on the other side
of ISM based communication channels. Those Linux instances will use
kernel integrated drivers for the console and block devices. Currently
there are no plans for passing these devices through to guests since we
can also just pass-through an ISM device and ISM devices being virtual
we're not limited in how many we can have.

Thanks,
Niklas
