Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89E17A2E8;
	Tue,  7 Oct 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847436; cv=none; b=rwplk+aykBHRAtYHtTRVM7BEj8qoZkpzFVQ9J6FgrnA6VxUWbCp0IFyfmbdE7Ljsb3BLeTAbRj1krpsCnFx/0tiRksRzNawN7/ETuR6TES9m9sq8WZ3dkSf5QENNKD0qf+G9x4O7ksCsM3HdUKiFtMODTaPsqcjzuSetHalgVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847436; c=relaxed/simple;
	bh=NsyeHFVPUrvF4HhBo24JMcbqVJtgrObWwdnEYottEf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIMGWbM3OW25e00NxxZZAPK+2+/9Y+KZPcCX71i1gXlPlLFD061t6txvDh3RNXcyNOtzXH2PzVAZRJJM8SIDXcbydKo1lD71MEZctohVZy8gGH2dOb4PTrasgSeYAZv+nmzbUIk5iOHNQ0lYLv4DAwgDM67xZ5yY2JOnngbqCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwYYfD2l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwYYfD2l"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597BF7i8031517;
	Tue, 7 Oct 2025 14:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KIQG8fe18Cm5jfwgp1PcSo86AFXK7b
	2BBlHnYTtTuIM=; b=CwYYfD2lrxdBqH48n17aAykQR5P+PvM+gXkItNXLycqN4L
	vYkoBl5oohmVfU+70xqsp5wXoSk2SL4RtRoJj8SL968ZQpL/KY7eQsHvYhjxQuwW
	kX4udQrdFhoxJkY39JPU0ExVn3PCmxOYhxlXARi7lbMAqyyMuiIuqO6k+Klee753
	gCN7u60SGOJ7jVb92f5SVMWnstdn7ip8GXG/BfMfFlJOLNJitXzIiNV746qTkHHd
	F33eH+w9uVFPHfkE5jwBmtsfDeS93WNYsPI5D4ipFFH2X1VIgq1Zy66UDOmSE0S6
	4k3sqKkGwrnZVjMx7nEcQVdKhMUjxT9vcbj5biTA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8aq37r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 14:30:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597CeRC9019601;
	Tue, 7 Oct 2025 14:30:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kdwsbv1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 14:30:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 597EUNax53477864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 14:30:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0247420040;
	Tue,  7 Oct 2025 14:30:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 936F520043;
	Tue,  7 Oct 2025 14:30:22 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.19.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Oct 2025 14:30:22 +0000 (GMT)
Date: Tue, 7 Oct 2025 16:30:21 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
Message-ID: <aOUj_RE8z9OiIIfN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PdkXKFhNzTG2BT8DipAPd1uZ87BQphbV
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=68e52403 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=w9My_uIrVxvTaZuSxxAA:9 a=CjuIK1q_8ugA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX/tzvw3cApgKZ
 ONyKqQVhsLg6ZJvP2trmG55xOCkFAKZ7rwkNlxFpvKy2DdcVbtpTE2QsTCCIuF5ZwONxvIu5fK6
 OTJAy4WeFfjs6kdZz0a2Z8TiF2RP3FB110TP6GPoWYjNV64WXPcYHqcfNEj07g1dVRXNV1y/ZeA
 ORaL+5YDnl0Cjphe38y2uIOOmWkX2xRbgtnxtddU+96nHVBUKtHK6EToiaeVD7Xb0iYk8YfFdJk
 2BwbeN6UXRxFQEr7kZ5S91yKpLmkyiV9mXqX1B8E5q4GKoLT1tdzOx0tZW04TkCC9FGTB8aP+A0
 xixHAVY8S3Z8/IM2p7TKvjv/uwNJFpn1t0DfEd8xr50eP//PX56KYAUoeUrbIHdvDRgp+eRwF0j
 Lv9Nm2fMvHRvOCJ9ORwsT8v84u4ZGA==
X-Proofpoint-ORIG-GUID: PdkXKFhNzTG2BT8DipAPd1uZ87BQphbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040022

On Fri, Sep 26, 2025 at 03:15:23PM +0200, Sumanth Korikkar wrote:
> Hi,
> 
> Patchset provides a new interface for dynamic configuration and
> deconfiguration of hotplug memory on s390, allowing with/without
> memmap_on_memory support. It is a follow up on the discussion with David
> when introducing memmap_on_memory support for s390 and support dynamic
> (de)configuration of memory:
> https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
> https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/
> 
> The original motivation for introducing memmap_on_memory on s390 was to
> avoid using online memory to store struct pages metadata, particularly
> for standby memory blocks. This became critical in cases where there was
> an imbalance between standby and online memory, potentially leading to
> boot failures due to insufficient memory for metadata allocation.
> 
> To address this, memmap_on_memory was utilized on s390. However, in its
> current form, it adds struct pages metadata at the start of each memory
> block at the time of addition (only standby memory), and this
> configuration is static. It cannot be changed at runtime  (When the user
> needs continuous physical memory).
> 
> Inorder to provide more flexibility to the user and overcome the above
> limitation, add an option to dynamically configure and deconfigure
> hotpluggable memory block with/without memmap_on_memory.
> 
> With the new interface, s390 will not add all possible hotplug memory in
> advance, like before, to make it visible in sysfs for online/offline
> actions. Instead, before memory block can be set online, it has to be
> configured via a new interface in /sys/firmware/memory/memoryX/config,
> which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
> controlled by the user instead of adding it at boottime.

Hi David,

Looking forward to your feedback to proceed further.

Thank you,
Sumanth
