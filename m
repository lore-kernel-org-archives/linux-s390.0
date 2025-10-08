Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC8296BD6;
	Wed,  8 Oct 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903557; cv=none; b=Mehmb7XfaUbMlvQ4HC6ff+IJjSZSfSgeMwkhGXUSAjwMx8v1QynaJmck3CmvkWWDPe/54pNLxgokBgILsyMnlFMpFcSxMn6gKqqYFY/UtXxfaRhnbQt8TNZkpgrJI3z2OMy6S+WlJ76kdq2c3rwHhV3EpcBtcL80r20VVGgM8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903557; c=relaxed/simple;
	bh=JkjV/eUnoUMBOfGzA4SXzJjf+CoDKfYEQQqG+BWErM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD939WdiC+rYH4l2+goKL4mm7VZsfsBZnpy4DLmYxFIFYNSDqro/JBXxAzL1abc408UAc8j3VW3RIPfUYJBR1Rt9UbAr5B5mrn6kDFlnIfDS8prPH/rtDtA2e35/8hhNmLfHtOFu3CYP7GgZ1Vhn+//mygr1EcC+GIG0bA/OQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dV+xOPxm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dV+xOPxm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597NHZ85010446;
	Wed, 8 Oct 2025 06:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fp1Xmw
	wO64BlkPa30P5ZNooeZdR3zNM9pfHkI1Vb+AQ=; b=dV+xOPxmiLHRLJUvA2b+ep
	nyF1nXUOxM62bjxo+Tyk2wWPjfAl/yID6FBpd49nz6JnMH3XFnQTcxoRiYs+zx4d
	c7qyBmxQTl1u+z8aNlAIaXbGdSSBN36XBwDobKTgMe/FWlFQwZpagTbfcKGg22Jx
	wKfuv4Bfj02x0OJZriDIEu/GAqI6nFpvJUufyhnVX8kOPMup4mYvHxDumuFHggvL
	w4h+S7cHjul3T2KLtEehyqhDPv8bVa31mzW2jveDaL3OvlrucUyZxxn9tip63v14
	eZ/P/wObBqcXWKv/i3L34ELluWA3bo62sxF1jyX43+Yspp43jCrHtr5aRkKQllzA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju93k8ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 06:05:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59864KOg030957;
	Wed, 8 Oct 2025 06:05:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kfdk71mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 06:05:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59865b1P14811636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 06:05:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A1362004B;
	Wed,  8 Oct 2025 06:05:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9003D20040;
	Wed,  8 Oct 2025 06:05:36 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.14.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 06:05:36 +0000 (GMT)
Date: Wed, 8 Oct 2025 08:05:35 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
Message-ID: <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6fWQ4SnX9jmxmfjEemvFmoq18YJ7A2AG
X-Proofpoint-ORIG-GUID: 6fWQ4SnX9jmxmfjEemvFmoq18YJ7A2AG
X-Authority-Analysis: v=2.4 cv=Fec6BZ+6 c=1 sm=1 tr=0 ts=68e5ff36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gABlUkJTZVALj7I02CYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX3bFbGwH8kkF8
 80trDb1rC5iYBgYASeHI/HLWMcllw2srfs7nRGTGILHE6p7L9VbeC/5ldO3K0ITSL7elSQHTAHs
 oHxhsMuEHMGrVYlwZJvk5QvLHEGkK+HISwJ5UgOfdKU1+d9U5w7mFRG27dtWOpasyjEeSk0SCd/
 xD4B0vHa9ZJ9QmXz3Q5I/vEiuxDwvVojeZoEZl8uMUyFDijfA7/4Lw6QCaHwY8NyALdnirxXv2G
 P+jRPG+Qica+DzpNMOMUvl5Di5fugpcUMOHS31aByL2WGV5eYzbcPMYTkmD7WCA2E7d5sOEko/K
 pdPzesTu2evT+rD8oCmzBGY8MvuwrfzVv1hXdnT0uXwK5GK5pTqezo4z6j5y9l1wcTYE5oYn/5p
 LQmd28qZ+k9VDLGdvWTwFOH83WXxMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

> Care to share an example output? I only have a s390x VM with 2 CPUs and no
> way to configure/deconfigure.

lscpu -e
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
  1    0      0    0      0    0 1:1:1         yes yes        vert-medium  1
  2    0      0    0      0    1 2:2:2         yes yes        vert-low     2
  3    0      0    0      0    1 3:3:3         yes yes        vert-low     3
  
# chcpu -d 2-3
CPU 2 disabled
CPU 3 disabled
# chcpu -g 2
CPU 2 deconfigured
# chcpu -c 2
CPU 2 configured
# chcpu -e 2-3
CPU 2 enabled
CPU 3 enabled

> > chmem changes would look like:
> > chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
> > chmem -g 128M : deconfigure memory
> 
> I wonder if the above two are really required. I would expect most/all users
> to simply keep using -e / -d.
> 
> Sure, there might be some corner cases, but I would assume most people to
> not want to care about memmap-on-memory with the new model.

I believe this remains very beneficial for customers in the following
scenario:

1) Initial memory layout:
4 GB configured online
512 GB standby

If memory_hotplug.memmap_on_memory=Y is set in the kernel command line:
Suppose user requires more memory and onlines 256 GB. With memmap-on-memory
enabled, this likely succeeds by default.

Later, the user needs 256 GB of contiguous physical memory across memory
blocks. Then, the user can still configure those memory blocks with
memmap-on-memory disabled and online it.

2) If the administrator forgets to configure
memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
Rescue from OOM situations: configure with memmap-on-memory enabled, online it.

Thank you,
Sumanth
