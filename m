Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A724A7C2;
	Thu, 16 Jan 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028517; cv=none; b=TlBWjHy2I4q5Kdzf0W4fQEXlFmoFJIT1MqMDx3lDlVtETw2WygIWYQWq7ngWGur64w3MZYx2tATMopK5FkpH4Cz+VxObLCqqO9qSrwziJPJ8LNj1wLiOpj3XDsYV2CuNw6MPJIGZ1QtMqBXmW52jDyxmOczGrdaB5WpdBTw8+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028517; c=relaxed/simple;
	bh=8hbVN9YI8078tT8U7lrYZ98z4vS7Y/T+E7zIKDTJMCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ksn6BUqQb9Wqied4xEr71G2nsMObryHBqMpNmcApmQL8PGeHwIo8pp8de5XzouOzLbz6YjgPu5kvzNUhpbkJBOWGehf0apVGIrTtjcg9MvGWTLQF2XycmLnZFMbDHKzE07FN4JgCDfzidt1PUuNP78W15dKUR3K2/cYy9HwT/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tuG3SE+9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tuG3SE+9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G85g9F020410;
	Thu, 16 Jan 2025 11:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6WsHXS
	0exKRc+P/C03gFAFZ609oBGsJkwai4PeAqKhc=; b=tuG3SE+9/ubvUHj7uiv0EP
	g5c9yI7GBrsq4e1qV8J3eCtCOPauuyuZWrN7//P/3AOCsa3w7Z7ofupt29/w+KY1
	/YeXkZdogfbVb+l11vUgApZpqnxkjMGqu0JOtxmUj1ARAFQMFktx9Pp8JrxmNULc
	V9XZLSwxE5XVQapkgzGVL9+/b6rqowCRVCBo4UsU8au+Hu77mRQfNQzKQqoPTYEq
	UFqZG+PV92tC1v8ulZCoobQCXk1p97avxynUi5z+XWM2v4t+YPK/pBnxxVUsTfwi
	kMxgFX2MhH+C/pJjp5BKY7bttxqUx0GEry7/QcfyVxOn15/aoMOB3q9N+gebxxcA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa391nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:55:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GBhCkT019881;
	Thu, 16 Jan 2025 11:55:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446xa391np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:55:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAPmbB017400;
	Thu, 16 Jan 2025 11:55:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkdjkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:55:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GBt37h55116062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:55:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5455020043;
	Thu, 16 Jan 2025 11:55:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D6A20040;
	Thu, 16 Jan 2025 11:55:03 +0000 (GMT)
Received: from localhost (unknown [9.152.212.252])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 11:55:02 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 12:55:02 +0100
Message-Id: <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
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
Subject: Re: [RFC net-next 0/7] Provide an ism layer
From: "Julian Ruess" <julianr@linux.ibm.com>
To: <dust.li@linux.alibaba.com>, "Alexandra Winter" <wintera@linux.ibm.com>,
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
X-Mailer: aerc 0.18.2
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
In-Reply-To: <20250116093231.GD89233@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g1AF_0ccCVsJ4D_uIEKg71EqVM-xJvTq
X-Proofpoint-ORIG-GUID: uSQbR03rO6Wpiy8HraAqore_CAF8D85i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160086

On Thu Jan 16, 2025 at 10:32 AM CET, Dust Li wrote:
> On 2025-01-15 20:55:20, Alexandra Winter wrote:
>
> Hi Winter,
>
> I'm fully supportive of the refactor!
>
> Interestingly, I developed a similar RFC code about a month ago while
> working on enhancing internal communication between guest and host
> systems. Here are some of my thoughts on the matter:
>
> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
> Device) instead of ISM (Internal Shared Memory). To my knowledge, a
> "Shared Memory Device" better encapsulates the functionality we're
> aiming to implement. It might be beneficial to place it under
> drivers/shd/ and register it as a new class under /sys/class/shd/. That
> said, my initial draft also adopted the ISM terminology for simplicity.

I'm not sure if we really want to introduce a new name for
the already existing ISM device. For me, having two names
for the same thing just adds additional complexity.

I would go for /sys/class/ism

>
> Modular Approach: I've made the ism_loopback an independent kernel
> module since dynamic enable/disable functionality is not yet supported
> in SMC. Using insmod and rmmod for module management could provide the
> flexibility needed in practical scenarios.
>
> Abstraction of ISM Device Details: I propose we abstract the ISM device
> details by providing SMC with helper functions. These functions could
> encapsulate ism->ops, making the implementation cleaner and more
> intuitive. This way, the struct ism_device would mainly serve its
> implementers, while the upper helper functions offer a streamlined
> interface for SMC.
>
> Structuring and Naming: I recommend embedding the structure of ism_ops
> directly within ism_dev rather than using a pointer. Additionally,
> renaming it to ism_device_ops could enhance clarity and consistency.
>
>
> >This RFC is about providing a generic shim layer between all kinds of
> >ism devices and all kinds of ism users.
> >
> >Benefits:
> >- Cleaner separation of ISM and SMC-D functionality
> >- simpler and less module dependencies
> >- Clear interface definition.
> >- Extendable for future devices and clients.
>
> Fully agree.
>
> >
> >Request for comments:
> >---------------------
> >Any comments are welcome, but I am aware that this series needs more wor=
k.
> >It may not be worth your time to do an in-depth review of the details, I=
 am
> >looking for feedback on the general idea.
> >I am mostly interested in your thoughts and recommendations about the ge=
neral
> >concept, the location of net/ism, the structure of include/linux/ism.h, =
the
> >KConfig and makefiles.
> >
> >Status of this RFC:
> >-------------------
> >This is a very early RFC to ask you for comments on this general idea.
> >The RFC does not fullfill all criteria required for a patchset.
> >The whole set compiles and runs, but I did not try all combinations of
> >module and built-in yet. I did not check for checkpatch or any other che=
ckers.
> >Also I have only done very rudimentary quick tests of SMC-D. More testin=
g is
> >required.
> >
> >Background / Status quo:
> >------------------------
> >Currently s390 hardware provides virtual PCI ISM devices (ism_vpci). The=
ir
> >driver is in drivers/s390/net/ism_drv.c. The main user is SMC-D (net/smc=
).
> >ism_vpci driver offers a client interface so other users/protocols
> >can also use them, but it is still heavily intermingled with the smc cod=
e.
> >Namely, the ISM vPCI module cannot be used without the SMC module, which
> >feels artificial.
> >
> >The ISM concept is being extended:
> >[1] proposed an ISM loopback interface (ism_lo), that can be used on non=
-s390
> >architectures (e.g. between containers or to test SMC-D). A minimal impl=
ementation
> >went upstream with [2]: ism_lo currently is a part of the smc protocol a=
nd rather
> >hidden.
> >
> >[3] proposed a virtio definition of ISM (ism_virtio) that can be used be=
tween
> >kvm guests.
> >
> >We will shortly send an RFC for an ISM client that uses ISM as transport=
 for TTY.
> >
> >Concept:
> >--------
> >Create a shim layer in net/ism that contains common definitions and code=
 for
> >all ism devices and all ism clients.
> >Any device or client module only needs to depend on this ism layer modul=
e and
> >any device or client code only needs to include the definitions in
> >include/linux/ism.h
> >
> >Ideas for next steps:
> >---------------------
> >- sysfs representation? e.g. as /sys/class/ism ?
> >- provide a full-fledged ism loopback interface
> >    (runtime enable/disable, sysfs device, ..)
>
> I think it's better if we can make this common for all ISM devices.
> but yeah, that shoud be the next step.

I already have patches based on this series that introduce
/sys/class/ism and show ism-loopback as well as
s390/ism devices. I can send this soon.


Julian
