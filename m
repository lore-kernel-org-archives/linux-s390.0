Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168D46BF;
	Thu, 16 Jan 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047301; cv=none; b=L2Ov/3ube78TKkEwjxfYsSX+9HTxjT2g5PiThMT5Nt98TjTPnV0OcLcKHrqgFWy/2whhqF5eKcj5jEh2DhYy8SjFhgiShSbNrEmyrScLBEFOPdqW4pvgyMPTRDQdF4Me4Af1y6I++2trj7DyTw7ab8H0XEva9tuZoyOkgltS3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047301; c=relaxed/simple;
	bh=0IdRwpY7geweO2DXVKwZI1m08Wkk7nYnSESE20bRK9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pAtdYFrZ8kWz1+6dBnCcqXaWWw0zCcSQcfIab+tg98MTzt5b6tdQhcoAIndTEhHyoGEMa31UQgwoxE1cjR5auT4ij3UwSnz9e2Q7Tgl1LK5E5DhDDEa8CaxZcbht3Mg3s4mV1278PTAXI+dZs/KKQQ1KX0d5i7OiDAMLoEbiHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JDTOoeyT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JDTOoeyT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE6MeL024437;
	Thu, 16 Jan 2025 17:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qdes2T
	AIhNcEfBb2EGYJn6n6zLG76V8HiO4i/Nj/zn8=; b=JDTOoeyTkeHPcZwjnCP5F1
	tO58d4FIHZEPk8pBhX7RbxLzQGS3Y51fYHMy4A/lbnHaRjrStZFLfDcf/d8FKoaL
	jfS0Y7Kpxe9MQ5buxR0L/ygEZWyhFKuCVyLtbd8G3DT0dPGhv364Q/h7DW7gucsr
	bZudiPJvrHV3iG4kd2j3g95PfAnlqyYH6cwqzUECcWgKJ08bGV5SGYBdDetlcRre
	Wr5cEzTi5jHtkuO5RYN70ttQA7jUEprag/uwCJoIPPbXULuJfF7wBFMcFpWQrBnh
	wbzuWyKYNM/2xdeRYhnLWl00ymrk39xunY4QgN2+v3iAhkF954xQw1DhdYEJEMUA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k58xgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 17:08:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GH5cbV027569;
	Thu, 16 Jan 2025 17:08:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4473k58xgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 17:08:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEOllA001108;
	Thu, 16 Jan 2025 17:08:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k6jpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 17:08:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GH85q649283514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 17:08:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC00D20049;
	Thu, 16 Jan 2025 17:08:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 885EC20040;
	Thu, 16 Jan 2025 17:08:04 +0000 (GMT)
Received: from localhost (unknown [9.152.212.252])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 17:08:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 18:08:04 +0100
Message-Id: <D73NVE26KA00.26XEI1IINZ68M@linux.ibm.com>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alexandra Winter" <wintera@linux.ibm.com>, <dust.li@linux.alibaba.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        "Jan Karcher" <jaka@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        "Tony Lu"
 <tonylu@linux.alibaba.com>,
        "Wen Gu" <guwen@linux.alibaba.com>,
        "Peter
 Oberparleiter" <oberpar@linux.ibm.com>,
        "David Miller"
 <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andrew Lunn"
 <andrew+netdev@lunn.ch>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Thorsten Winkler"
 <twinkler@linux.ibm.com>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Simon Horman" <horms@kernel.org>
X-Mailer: aerc 0.18.2
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
In-Reply-To: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bkKEtLvYlWHZjIaqyVDUYzu0fqr349ri
X-Proofpoint-ORIG-GUID: BraC33s7yDibRzmR4aP1fdkOQDr8mKNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160128

On Thu Jan 16, 2025 at 5:17 PM CET, Alexandra Winter wrote:
>
>
> On 16.01.25 12:55, Julian Ruess wrote:
> > On Thu Jan 16, 2025 at 10:32 AM CET, Dust Li wrote:
> >> On 2025-01-15 20:55:20, Alexandra Winter wrote:
> >>
> >> Hi Winter,
> >>
> >> I'm fully supportive of the refactor!
>
>
> Thank you very much Dust Li for joining the discussion.
>
>
> >> Interestingly, I developed a similar RFC code about a month ago while
> >> working on enhancing internal communication between guest and host
> >> systems.=20
>
>
> But you did not send that out, did you?
> I hope I did not overlook an earlier proposal by you.
>
>
> Here are some of my thoughts on the matter:
> >>
> >> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
> >> Device) instead of ISM (Internal Shared Memory).=20
>
>
> So where does the 'H' come from? If you want to call it Shared Memory _D_=
evice?
>
>
> To my knowledge, a
> >> "Shared Memory Device" better encapsulates the functionality we're
> >> aiming to implement.=20
>
>
> Could you explain why that would be better?
> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
> Remote 'R' in RoCE. Not the greatest name, but it is used already by our =
ISM
> devices and by ism_loopback. So what is the benefit in changing it?
>
>
> It might be beneficial to place it under
> >> drivers/shd/ and register it as a new class under /sys/class/shd/. Tha=
t
> >> said, my initial draft also adopted the ISM terminology for simplicity=
.
> >=20
> > I'm not sure if we really want to introduce a new name for
> > the already existing ISM device. For me, having two names
> > for the same thing just adds additional complexity.
> >=20
> > I would go for /sys/class/ism
> >=20
> >>
> >> Modular Approach: I've made the ism_loopback an independent kernel
> >> module since dynamic enable/disable functionality is not yet supported
> >> in SMC. Using insmod and rmmod for module management could provide the
> >> flexibility needed in practical scenarios.
>
>
> With this proposal ism_loopback is just another ism device and SMC-D will
> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>
> But I understand that net/smc/ism_loopback.c today does not provide enabl=
e/disable,
> which is a big disadvantage, I agree. The ism layer is prepared for dynam=
ic
> removal by ism_dev_unregister(). In case of this RFC that would only happ=
en
> in case of rmmod ism. Which should be improved.
> One way to do that would be a separate ism_loopback kernel module, like y=
ou say.
> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the=
 ism module.
> I also think it is a great way for testing any ISM client, so it has bene=
fit for
> anybody using the ism module.
> Another way would be e.g. an 'enable' entry in the sysfs of the loopback =
device.
> (Once we agree if and how to represent ism devices in genera in sysfs).
>
> >>
> >> Abstraction of ISM Device Details: I propose we abstract the ISM devic=
e
> >> details by providing SMC with helper functions. These functions could
> >> encapsulate ism->ops, making the implementation cleaner and more
> >> intuitive. This way, the struct ism_device would mainly serve its
> >> implementers, while the upper helper functions offer a streamlined
> >> interface for SMC.
> >>
> >> Structuring and Naming: I recommend embedding the structure of ism_ops
> >> directly within ism_dev rather than using a pointer. Additionally,
> >> renaming it to ism_device_ops could enhance clarity and consistency.
> >>
> >>
> >>> This RFC is about providing a generic shim layer between all kinds of
> >>> ism devices and all kinds of ism users.
> >>>
> >>> Benefits:
> >>> - Cleaner separation of ISM and SMC-D functionality
> >>> - simpler and less module dependencies
> >>> - Clear interface definition.
> >>> - Extendable for future devices and clients.
> >>
> >> Fully agree.
> >>
> >>>
> [...]
> >>>
> >>> Ideas for next steps:
> >>> ---------------------
> >>> - sysfs representation? e.g. as /sys/class/ism ?
> >>> - provide a full-fledged ism loopback interface
> >>>    (runtime enable/disable, sysfs device, ..)
> >>
> >> I think it's better if we can make this common for all ISM devices.
> >> but yeah, that shoud be the next step.
>
>
> The s390 ism_vpci devices are already backed by struct pci_dev.=20
> And I assume that would be represented in sysfs somehow like:
> /sys/class/ism/ism_vp0/device -> /sys/devices/<pci bus no>/<pci dev no>
> so there is an=20
> /sys/class/ism/<ism dev name>/device/enable entry already,=20
> because there is /sys/devices/<pci bus no>/<pci dev no>/enable today.
>
> I remember Wen Gu's first proposal for ism_loopback had a device
> in /sys/devices/virtual/ and had an 'active' entry to enable/disable.
> Something like that could be linked to /sys/class/ism/ism_lo/device.

My current implementation represents the devices as following
in '/sys/class/ism':

ism_lo -> ../../devices/virtual/ism/ism_lo
lismvpci0 -> ../../devices/pci0124:00/0124:00:00.0/ism/ismvpci0

The driver is repsonsible for the naming of its devices.

And yes, because the s390 ism_vpci is backed by a PCI device,
'/sys/class/ism/ismvpci0/device/enable' exists.

I think we could implement a device attribute for ism_lo
to implement this functionality. I already have a=20
device attribute implemented in ism_main
to access the gid of each ISM device. This leads
to the following sysfs entries:

'/sys/class/ism/ism_lo/gid'
'/sys/class/ism/ismvpci0/gid'

Julian

>
>
> >=20
> > I already have patches based on this series that introduce
> > /sys/class/ism and show ism-loopback as well as
> > s390/ism devices. I can send this soon.
> >=20
> >=20
> > Julian

