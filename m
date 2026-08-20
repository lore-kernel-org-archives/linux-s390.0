Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2534DCC7;
	Thu, 20 Aug 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210451; cv=none; b=idzkohZ4EsSXC7rmtMXE1eVbLEO+X8ha4b2YcRcnNrxVKAirrp2vtbi8B2eH1dI5Wt6Cs7gF9YgzYpPAfGVFHoCoUIhffvVQy5zP972AMCDaTT6zbpmdLdXDuDosPzWI8W+8hTSvm7kju41Q7k86bi9JraRCF7wlnLU1MrI8uD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210451; c=relaxed/simple;
	bh=znE98YVST97VaoTwB0m90N3G+mLlJSh0lvMs18OWQ40=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gh37RrOY0W3OFCAZHhpEYMqyrFZd+niX76EM8iLyt/tAtqvXVlXgXXBMVxeRQaFvYq6VEoEGxRZwurr/J7PnFvLGvtk1KR/NKtsKHRt/anKd5RFbNJALO5calYS4b54+CNZnldpe94ptWjChMUglX4InIrVoXL8LSqp5m50dnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZJ8FrWHe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZJ8FrWHe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVj5h504052;
	Thu, 20 Aug 2026 07:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aorygv
	pdM4lf3q8aNVsqMzRkRTnFGGGVqu4kpdFkPJU=; b=ZJ8FrWHepftqRh5z1nAxDn
	cbYFYd8uOvGy8L6WoEGM+4v8URJE/9HL1Y/ubHEYI2hLrNTmeLVY3yHD25peQLOL
	RSi9u9hxT+gYK5AD6kA77spuJMJ2HdfKYsvo9bZiborvAu+3YYasZvPcPWqONJhP
	kTMyJk8dMaFSwxGHnwH5x65Eiu3o0hoMes8f6aVwfSOMt8rGxj1UXIuYSjTWaOPX
	Ps3jje9NQzgAbtDfiF13kTeLKjww0VDSX+SzzrnZDC7P+xJ3jpRBc/AAaxFk+mQ0
	q5FKE2nn8SRrV8a5TG3G9o7+ZOxYF6vFqoCDK+8WPX4+/FRNpQ09SR/Zakf6l5ag
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu48h7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:20:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K7BNVk027589;
	Thu, 20 Aug 2026 07:20:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekd5vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:20:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K7KhLg40567264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 07:20:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E1220043;
	Thu, 20 Aug 2026 07:20:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C4FC20040;
	Thu, 20 Aug 2026 07:20:43 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 07:20:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 09:20:43 +0200
Message-Id: <DKTL871ACAUC.E4I644TH501X@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>,
        "Alexander Gordeev"
 <agordeev@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/7] s390/pci: fix double-free in zpci MSI cleanup
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-1-826ff27b6e97@linux.ibm.com>
 <20260819090308.A0A2C1F00A3A@smtp.kernel.org>
In-Reply-To: <20260819090308.A0A2C1F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a86aad0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mIJv8-IqlaVkk2WYclUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bslE1Oaz45xHy6RXZY2fYVuvZhSQYSKh
X-Proofpoint-GUID: bslE1Oaz45xHy6RXZY2fYVuvZhSQYSKh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX5gpfqA0nBgpN
 zpxiwW34mfaqm8ctZp5qErgx4gPCu28cmH0SyCnHTzUCnfKIHcIwSaVRs9zkKaFgle40l2+bDwx
 dzxdReYmR5W7jW/+hwfRcK2yO5F1P6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX9W+oUiPyrAjs
 AgY7FY1E+RFYY/aFsHliD1LccfQkzccqGwsm1WhLIhxxhrQz7P10s1owGA8pqgSnqWLmoLNsUtJ
 5BN5Qm4BYu8mitg8BaZmYv5PYS4jRBsrvwMiUYK22MlymFbDwiO7jLDvgBemRLnnSyrkHMl3LHl
 u4w7gY3Tgac8ejd5Ml43LXfbv3C7DgvS4bVB+O0rDSmqABlKEPKfovKJw2+Ubo4ccW0xXzzEcIw
 D88tCc/DsTnnzgUV5YyGLlyxVOZmIqsYtqDguXmWZJbTSSIBy+m8QgM3dCyk5yUwVuNevuPJfXr
 wc99mDPbhAIJDootzg11DSuhTdcHhZBK5bjiU6e4m2HBPDtLJPdGRWcY/afiLDgOS9qP507NmCu
 IT4J7cdX0e0H8eJMc57BpLUu7+5+7VuLBnCe55mEa4vQa/ATeBL3aMgB5VcxKoYzEOgkyXk5f6W
 m9OK2LD0aWjkD6Rn13g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200049

On Wed Aug 19, 2026 at 11:03 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Medium] Pre-existing memory leak of `struct resource_entry` in `zbus->=
resources` when PCI root bus creation fails.
> --

-- snip --

> [Severity: Medium]
> This is a pre-existing issue, but while reviewing the error path discusse=
d in
> the commit message (when pci_create_root_bus() fails), does zpci_bus_rele=
ase()
> leak zbus->resources?
>
> In arch/s390/pci/pci_bus.c:zpci_bus_alloc(), a resource is added to the l=
ist:
>
>     INIT_LIST_HEAD(&zbus->resources);
>     zbus->bus_resource.start =3D 0;
>     zbus->bus_resource.end =3D ZPCI_BUS_NR;
>     zbus->bus_resource.flags =3D IORESOURCE_BUS;
>     pci_add_resource(&zbus->resources, &zbus->bus_resource);
>
> But in the error path where pci_create_root_bus() fails, zbus->bus is not=
 set.
> Later in zpci_bus_release(), pci_free_resource_list() is only called if
> zbus->bus is true:
>
>     if (zbus->bus) {
>         pci_lock_rescan_remove();
>         pci_stop_root_bus(zbus->bus);
>
>         zpci_free_domain(zbus->domain_nr);
>         pci_free_resource_list(&zbus->resources);
>
>         pci_remove_root_bus(zbus->bus);
>         pci_unlock_rescan_remove();
>     }
>
> Can this leak the struct resource_entry on this initialization error path=
?

Yes, seems like pci_free_resource_list() should be moved outside the if
block. But this should be fixed in a separate patch outside this series
since it is unrelated to the introduction of the irq domains.

Tobias
