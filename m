Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77B3B19B7;
	Mon, 23 Mar 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274361; cv=none; b=ofGw/fGodjuqbxm4oSYLaasj7YvDhANZ2ibwRGL2mSDTdLxSAfcvuE1na5FmHm2R80nfgTdPzS+HuwuU2UcPSSvieM3PrLPnnPRmvUku0gLSYNU84dCzrGqp44L/dwWP3ZGM7E744q7/PGaAq/TTJal9iAcxoaFcFrmYNL0SvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274361; c=relaxed/simple;
	bh=jpaMpx0A4Uslor4kI+RTRJFPaUAAaa44NZs5nmY4t+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgLufbc5JfKKR/y6bqx7U6ckqXBsRkvmWPxV0KJRgoYqr3haAbDGuGrSf3JMsA7AaHqR3OcMhzpO4vUs4GyLq4kDCVfc1BQmL7DY83Plo9U6WiPj8FBrvSaDanFdlD8mdjUjqp81d0coOn2c3LSa47rSjnHWSjNWKZGJ2tKXWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVsY35XL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVsY35XL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLkNGc447711;
	Mon, 23 Mar 2026 13:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rqcifN
	SgiPtMTPL4gvhJH6P+FzHLQwjU8gI6W5XdzEM=; b=CVsY35XLu3t1XHAW5X2kp7
	xbN/IX3RRn18aA7pYyRcd4TCi955L8ZBMFsCVL10eeqZuhlLP80/EFhaHuzP1PjY
	fsT/uCz5/FBQkl/nHLuWNu0toig1DMWmBYzATcNR2oADMQiPybkGmaiSD3SwEtvj
	hd6bmvEYo/hBo/iVlJmj8nLAMCjhyeEe3MXFj3AUQhhJIWYci4tGz6mEsgDZsWVN
	9cL5j8v9ypy7wh8DY8v4AibIFZwhFEps8pprPnkBAmezdigEnN7jUjAX7MAVCBev
	N61KwFZt95Uaa+EfRHb0cQiyvU2/3zeuFe3tM3b0PPcbTyZDlZDVBD5RXZ7Pe/Dw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9q4a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 13:59:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCTwMq009115;
	Mon, 23 Mar 2026 13:59:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nndkbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 13:59:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NDxAH848497130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:59:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FA342004D;
	Mon, 23 Mar 2026 13:59:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25EBE2004B;
	Mon, 23 Mar 2026 13:59:10 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 13:59:10 +0000 (GMT)
Message-ID: <8bfd4b31-96c8-4a7f-ba0e-9ab2b6a74bf1@linux.ibm.com>
Date: Mon, 23 Mar 2026 14:59:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum
 <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
 <20260323-vfio_pci_ism-v7-2-abf537150408@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260323-vfio_pci_ism-v7-2-abf537150408@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P8Om7W6ApukN2-b0nyd1QTxrPj1CkLyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfXyXy0lJ9b/UoM
 GfvcX5oOlUq06tDndhQ512wLqdILt6dfx7xtfADCWXphL5u5UdOEqz8ha6N2DA6s51tT7BFQVJm
 euv0ep3Psy23noOE07ALoe2yOS4OfwzFNVsS05pIh9tcpvy9yNPyGdDxgs/K6hPgqdkOYYFlSnW
 H/+5HdncyQrHYIXq7819CqX63Ysb6QZzJe0xt9RXjC9ZHubSqiyvPoCCk7ce9zx0zR/tYnn+Med
 M8oSGxyXLY5dBw7m21F5gqA3uPk2f3ccWO6JuAaBG+SuH/DD+tqGuZbSWtTMqjo7irg7Yh+/h4K
 sXrhOZHjpxk9mAKGDSAEPtJT57wbXeMgiLi6DAtfgAwDGlJZmrHnOC0q8brdkvYkR6Q7ggDFZ1V
 HQUYjxdQKCcWMISnNmEwA7ordDhZrz3OGt5b23vOxWfQomoaN+zpu+M9ZzbyXKWRK+w6VYytvxH
 D96Tsaygk/Nvm2u3D7Q==
X-Proofpoint-GUID: P8Om7W6ApukN2-b0nyd1QTxrPj1CkLyU
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c14734 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=akap8JHnbm7pTVdsz3UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230107



On 23.03.26 10:32, Julian Ruess wrote:
> Add a vfio_pci variant driver for the s390-specific Internal Shared
> Memory (ISM) devices used for inter-VM communication.
> 
> This enables the development of vfio-pci-based user space drivers for
> ISM devices.
> 
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function handle based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function handle-based PCI instructions are
> used instead.
> 

Nit: How do you want to spell "function-handle-based"?
(You have one with 1 hyphen, one without)

> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store block (PCISTB) instruction to
> perform write operations.
> 
> Stores are not fragmented, therefore one ioctl corresponds to exactly
> one PCISTB instruction. User space must ensure to not write more than
> 4096 bytes at once to an ISM BAR which is the maximum payload of the
> PCISTB instruction.
> 
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---

Looks good to me.
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


