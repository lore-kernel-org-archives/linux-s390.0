Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9F19D098;
	Fri, 17 Jan 2025 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133048; cv=none; b=M9kiCwondxVnQJh93gWUEG7yXs0M/krp9Pny1NyT4YYIpBeq0xCPJbQ+8hIf3EujpPZaMSly8+sk3VMkfjjnr2UDuXmDbpvNw4qLSkU6rfdNd7vLKsBCngpLr1TBxRd9B0kEhcKIeBbrnbMf0Nn0ONtmL8IAK4GK2xXqMU1mWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133048; c=relaxed/simple;
	bh=hY4KQb5f505xNYTwG/F/Ret6BMwLtDPyOmPU1zwXjHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwIL6p5+IZmNBwmPDMWpqUdfNEbdqHN4YVSp1GTPwjBPBXKDiPsD3i3tCwe6W4urkEKZHFFxsn/JQtFoDq7nZkhuADjtIb4kExgozm6t7BpGTkZaXB/kbOrKMtU9b/BZUPINbQD5zmnQl3A4lGEiwWoVGyw6cOuXZaYRQ/Rg9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IADzNmmN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IADzNmmN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEKObE015200;
	Fri, 17 Jan 2025 16:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qlWznX
	u3dKPrZdqKv562Fw2hwWvdcB1K8vm6Swgh4p4=; b=IADzNmmNsD9FATwnbMM7C7
	jchjKYzGrGxdu+SLHIy2dTsfBET3XfESOpUfv6kEmVblsqG05hI4SXJYFQqv8o3I
	JOx5qWFPH/DanH4iwfJQUL/VYXDZ+Fl6f+wzUwcoF+IpvVyQ5/2SHZvXc/uJnUbB
	0yffl3LID5KKtHtnBY/7PUlzh9QMumz13Kkr20dVC9yjvd76/Ya8n18VxKyYEgK6
	GssKoPRRAe1PvyPF2y0kg3zYfReHuQ3ddUp0zrcDsLu1nOQ/VUTxkXTCIp8hsCAX
	caN4P42kI3zC5IZj3O3nkpTLN8fgJbFNGRHXF+vQp4FSC7j6+nf4zwLKOh+Xb6Ew
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpubdyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:57:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HGa6qP003718;
	Fri, 17 Jan 2025 16:57:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpubdyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:57:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HE5h3C002663;
	Fri, 17 Jan 2025 16:57:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443bykxfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 16:57:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HGvGtR30671514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 16:57:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDE65803F;
	Fri, 17 Jan 2025 16:57:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319355804E;
	Fri, 17 Jan 2025 16:57:11 +0000 (GMT)
Received: from [9.171.9.47] (unknown [9.171.9.47])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 16:57:10 +0000 (GMT)
Message-ID: <c2eb6fd7e9a786749d70a17266a04fb50dbd5bb8.camel@linux.ibm.com>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dust.li@linux.alibaba.com, Alexandra Winter <wintera@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>,
        "D. Wythe"	 <alibuda@linux.alibaba.com>,
        Tony
 Lu <tonylu@linux.alibaba.com>, Wen Gu	 <guwen@linux.alibaba.com>,
        Peter
 Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thorsten Winkler	 <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Date: Fri, 17 Jan 2025 17:57:10 +0100
In-Reply-To: <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
	 <20250116093231.GD89233@linux.alibaba.com>
	 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
	 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
	 <20250117021353.GF89233@linux.alibaba.com>
	 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
	 <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
	 <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>
	 <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a_IOCrvlW2R-9K4krF9PCVvfq_pUMBX4
X-Proofpoint-ORIG-GUID: -mQzV7MgixzX7W7vFv09Zn7lvBiIz1yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=550
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170130

On Fri, 2025-01-17 at 17:33 +0100, Andrew Lunn wrote:
> > Conceptually kind of but the existing s390 specific ISM device is a bit
> > special. But let me start with some background. On s390 aka Mainframes
> > OSs including Linux runs in so called logical partitions (LPARs) which
> > are machine hypervisor VMs which use partitioned non-paging memory. The
> > fact that memory is partitioned is important because this means LPARs
> > can not share physical memory by mapping it.
> >=20
> > Now at a high level an ISM device allows communication between two such
> > Linux LPARs on the same machine. The device is discovered as a PCI
> > device and allows Linux to take a buffer called a DMB map that in the
> > IOMMU and generate a token specific to another LPAR which also sees an
> > ISM device sharing the same virtual channel identifier (VCHID). This
> > token can then be transferred out of band (e.g. as part of an extended
> > TCP handshake in SMC-D) to that other system. With the token the other
> > system can use its ISM device to securely (authenticated by the token,
> > LPAR identity and the IOMMU mapping) write into the original systems
> > DMB at throughput and latency similar to doing a memcpy() via a
> > syscall.
> >=20
> > On the implementation level the ISM device is actually a piece of
> > firmware and the write to a remote DMB is a special case of our PCI
> > Store Block instruction (no real MMIO on s390, instead there are
> > special instructions). Sadly there are a few more quirks but in
> > principle you can think of it as redirecting writes to a part of the
> > ISM PCI devices' BAR to the DMB in the peer system if that makes sense.
> > There's of course also a mechanism to cause an interrupt on the
> > receiver as the write completes.
>=20
> So the s390 details are interesting, but as you say, it is
> special. Ideally, all the special should be hidden away inside the
> driver.

Yes and it will be. There are some exceptions e.g. for vfio-pci pass-
through but that's not unusual and why there is already the concept of
vfio-pci extension module.

>=20
> So please take a step back. What is the abstract model?

I think my high level description may be a good start. The abstract
model is the ability to share a memory buffer (DMB) for writing by a
communication partner, authenticated by a DMB Token. Plus stuff like
triggering an interrupt on write or explicit trigger. Then Alibaba
added optional support for what they called attaching the buffer which
means it becomes truly shared between the peers but which IBM's ISM
can't support. Plus a few more optional pieces such as VLANs, PNETIDs
don't ask. The idea for the new layer then is to define this interface
with operations and documentation.

>=20
> Can the abstract model be mapped onto CLX? Could it be used with a GPU
> vRAM? SoC with real shared memory between a pool of CPUs.
>=20
> 	Andrew

I'd think that yes, one could implement such a mechanism on top of CXL
as well as on SoC. Or even with no special hardware between a host and
a DPU (e.g. via PCIe endpoint framework). Basically anything that can
DMA and IRQs between two OS instances.
