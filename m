Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F71A257D;
	Wed, 21 May 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837470; cv=none; b=m07viskCZbgJdRtp6gMmq1dvZaNVX0CtWN9/nQBBNwvupVPiazDowJFpj2kMqHJadLh+l96glcGnOiYpKqEoV//oYElRgSucbWFuuyNoJ91ba32uK4c5gcVgZu9VV8FW+3vZAzkEYcUB/yFHNnxNKc/necAgP06GUoLxtT9eeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837470; c=relaxed/simple;
	bh=ooII1SG546YuRx1haJqB/YGVc4axhqFDEgHnwiiK0E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7WehdrwENnM2YZMA6YkGFjMig0IoM7n3R1ziqPpjYWd97bWjCCe2dyPXaudLuILo9K+InwERxoQshesgG296y3xVpsZKNIPu6q4/GYfqXsLNGCSjocK4UNphuYCng3wg+0LblVpN/iIthSrVeK5zTq0uszl30JCH5eYarpkq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y/jvpc/H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/jvpc/H"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDn2TU006457;
	Wed, 21 May 2025 14:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CUmBkivY7tO/sQL1SI7gmFR8qaMp1g
	AKSVaJ+GrGhvY=; b=Y/jvpc/H8c2Gebn0ZcHWJGrx+40mASN/UkEGB2J4AhIb57
	VVW+plauERibi90Ja54FKix1X5C5kutduoEf9CT/mWj2SNBWAeU9weMCzf7FIbUm
	HiafDs7LStkm00oNhikUUUO0vaA1wWUy8LytFsCtrU9t6ze5dmlax78u0nyy+VnJ
	WoJYvyAsBFAft6KEhl0ahtRetZ3NYUq5Fmc4LxDjMdeGsJWuVQFRbwKe0+xKaKa6
	/HDMSaM9s+ng8jFupW7ic9o/fW273hFqITbueVZEyXF0+Y9ZR32zbe/xfinZy/jN
	vON4tKsjl8vb+5QBakf4rb/USlXOklCHvKqR7uqw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sg2305rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:24:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDctAW024664;
	Wed, 21 May 2025 14:24:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkr4j49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:24:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LEOFqf49086972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 14:24:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CBBF20043;
	Wed, 21 May 2025 14:24:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3FFF20040;
	Wed, 21 May 2025 14:24:14 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.130.155])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 May 2025 14:24:14 +0000 (GMT)
Date: Wed, 21 May 2025 16:24:13 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
Message-ID: <aC3iDR8mB0uFWzAT@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
 <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q6gjXwEoWQYoOp3sliZjbUuUNyqrKs_g
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682de214 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=bvEob7D9_O_jlljhXYMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzNyBTYWx0ZWRfX7o+5WipuuU+M stjIdMAdyweWio/VWFcfnIcikD21aSkj3Omcty8zM8johLgnCa2laa+LmLzSzuRdJvfaS0Wb2rd lC11aUE58vDn4RCbAid57cawOVjceIJ0XmCRFceXdh+HkCoC3tbHYIuyellW1DsjHREAuQSDqvQ
 oiaIjGawlgwcw14hjZ1u6LiD7CXcaijhJxNzQptA8u6BQoxgQq+YOsndgLPzB2VWhTJeowLSQGy 9vG9ZQ2bmdhSOS21kXLciesiMe7CAQMA2mrAJx14dtk3upK44P016Np59QEv/CxXAv4wcI74SAd r02ndZFbeAx5yOLNC2uxiKMnSapB1XQiFZZkvtsJHUQ7H+B898D6Jsrc91GgWAHUIuQX1FQapgY
 tKgYB0MKG0RMIlKpPC5W9K9DxXoS6/FDmwr+vpQaeUCiuPM3DFS4T0b36t2SFMcJidOrr7+s
X-Proofpoint-GUID: Q6gjXwEoWQYoOp3sliZjbUuUNyqrKs_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210137

> So, the same as /sys/devices/system/memory/block_size_bytes ?
> 
> In a future where we could have variable sized memory blocks, what would be
> the granularity here?

I wasnt aware of this variable sized memory blocks. Then either
introduce block_size_bytes attribute inside each memoryX/ directory ? or
add it only when variable sized memory blocks support is implemented?

> I assume, because that is assumed to be the smallest granularity in which we
> can add_memory().
> 
> And the memory block size is currently always at least the storage increment
> size, correct?
> 
> > 
> > As I understand it, add_memory() operates on memory block granularity,
> > and this is enforced by check_hotplug_memory_range(), which ensures the
> > requested range aligns with the memory block size.
> 
> Yes. I was rather wondering, if we could have storage increment size >
> memory block size.

I tried the following:

* Config1 (zvm, 8GB online + 4GB standby)
  vmcp q v store
  STORAGE = 8320M MAX = 2T INC = 16M STANDBY = 3968M RESERVED = 0
  the increment size is 16MB in this case and block size is 128MB.

* Config2 (zvm, 512M online + 512M standby)
  vmcp q v storage
  STORAGE = 512M MAX = 2T INC = 1M STANDBY = 512M RESERVED = 0

  But, memory_block_size_bytes() would return max(increment_size,
  MIN_MEMORY_BLOCK_SIZE)

  In both cases, therefore, memory block size will be 128MB.


On the other hand, I checked one of the lpars,
the increment size is 2GB, which is greater than MIN_MEMORY_BLOCK_SIZE.
Hence, memory block size is 2GB here.

> > I was wondering about the following practical scenario:
> > 
> > When online memory is nearly full, the user can add a standby memory
> > block with memmap_on_memory enabled. This allows the system to avoid
> > consuming already scarce online memory for metadata.
> 
> Right, that's the use case I mentioned. But we're talking about ~ 2/4 MiB on
> s390x for a single memory block. There are other things we have to allocate
> memory for when onlining memory, so there is no guarantee that it would work
> with memmap_on_memory either.
> 
> It makes it more likely to succeed :)

You're right, I wasn't precise.

> > After enabling and bringing that standby memory online, the user now
> > has enough free online memory to add additional memory blocks without
> > memmap_on_memory. These later blocks can provide physically contiguous
> > memory, which is important for workloads or devices requiring continuous
> > physical address space.
> > 
> > If my interpretation is correct, I see good potential for this be be
> > useful.
> 
> Again, I think only in the case where we don't have have 2/4 MiB for the
> memmap.

I think, it is not 2/4Mib in every usecase.

On my LPAR, the increment size is 2GB. This means 32MB struct pages
metadata - per memory block.

> > As you pointed out, how about having something similar to
> > 73954d379efd ("dax: add a sysfs knob to control memmap_on_memory behavior")
> 
> Right. But here, the use case is usually (a) to add a gigantic amount of
> memory using add_memory(), not small blocks like on s390x (b) consume the
> memmap from (slow) special-purpose memory as well.
> 
> Regarding (a), the memmap could be so big that add_memory() might never
> really work (not just because of some temporary low-memory situation).

Sorry, I didnt understand it correctly. 
regarding a): If add_memory() is performed with memmap_on_memory, altmap
metadata should fit into that added memory right?

> > 1) To configure/deconfigure a memory block
> > /sys/firmware/memory/memoryX/config
> > 
> > 1 -> configure
> > 0 -> deconfigure
> > 
> > 2) Determine whether memory block should have memmap_on_memory or not.
> > /sys/firmware/memory/memoryX/memmap_on_memory
> > 1 -> with altmap
> > 0 -> without altmap
> > 
> > This attribute must be set before the memoryX is configured. Or else, it
> > will default to CONFIG_MHP_MEMMAP_ON_MEMORY / memmap_on_memory parameter.
> 
> I don't have anything against that option. Just a thought if we really have
> to introduce this right now.

If there are no objections on this design, I'm happy to start exploring
it further. Thank you
