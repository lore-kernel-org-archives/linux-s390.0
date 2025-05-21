Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC325EFBD;
	Wed, 21 May 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823716; cv=none; b=fYwSv/sf8ZrfVL8gIx1pLlAfIupp2ZWsk/I1TVAGMU0AeNxKPZ1jgDCb/niMP6BajUaRrFOVQkdpufnKLPvj33uq+8giqKNnq6cZLY43mqXFXE//qxF6k5J5qx9xCIKrXa9/TE74peRKDJy2hUfMbibJDQvL1BHo6jSwiQRljRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823716; c=relaxed/simple;
	bh=Bc0tuxh6FuJgjjna2ZA5ICMvztWDekZiHjGH1e4t3aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPH5t+xFWw/F+h3IOjqWeLCTzUSP+F3oe0pyYuE6D+9wAWGHhfTFg+nNvQ+/wW+eL94wy73FcEWVcgP2VnOACS3gpAFnXfWuOJavds0T4ElNMAJBGrPit3XJoqM+2vKa9/lr8AjCT1tOdH/ZGJL8kq6tQ/BFEM5BSevJU8ousrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDq/77FY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDq/77FY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8pd6Z014503;
	Wed, 21 May 2025 10:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OnL2JX
	aeHotq86V5UBxO4l5O+IBgRMNGBuvWWVOJgCw=; b=eDq/77FYm2qIZjkTd8ZBSk
	Z6egjzV6wPflUaml1pHfFzppoS464s17qIPib/LO/VbzBhsq2ZfB8oHoamsj8SXR
	suieV+YEtyENELG4iv2YvILt5IY6Z7x72vV/dtp16fzrM6oEHUDJcrdCzyj4ICiX
	FWlnueZSMkFGKc4XRvoij0SOT+MicVGUXRCCrzyJ8ZCME+bl1wkCPyXb6vTY8+mH
	Y/B4AfIy564zHVpgkTuA6xXqVRVfWZedWP/h6v8D+bsJfBEyAXI+7xUIPL+zaqRG
	3iAzw3Rr3xwFYl9gHRSxnYfVOuM3QuUm/Xgo/VE+g4AcmzabzUf+1l5BowHIB7OQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph0ekd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:35:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9u1Qn010595;
	Wed, 21 May 2025 10:35:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwnmbqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:35:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LAYxgU53018952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 10:34:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53042004B;
	Wed, 21 May 2025 10:34:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E3E20040;
	Wed, 21 May 2025 10:34:59 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.87.130.155])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 May 2025 10:34:59 +0000 (GMT)
Date: Wed, 21 May 2025 12:34:57 +0200
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
Message-ID: <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NCBTYWx0ZWRfX1Ir7nocZ0ZE7 VwLaSFnCBcLO9gRJZ9hYfiAMbU76FNh4iApIpKJXzmSoT4vn8Lg/IQsyfdLK+Zoo+3Lltk+M4dt WLrbH+L/w3uVcn3PaOptjzibwO6gX4snCn68eKGHOUgnSg7AqiEQacJX/TW1NIyLk74DiQa0Kgo
 3R7kuIRsH/LnPCinvoUJmCM19GWwY1dJ//Vw3W6duRncWG7Jqh//UHn22WpssalgytAR8cIoag0 Oeb43/6GaKAoiElpSR4dB9sRvAK9zqI4j0huC1qZOk5Op7TdXK7eqC9GNpwOP4c/u0wJCs3cD0R Ra69DlOVVZSqzCex62bUhtmAUEiRT5ul8SfAXwBLSFxpR68pfPZrOBzhsxUEJteLPiOSFg6Skg4
 lbXbrBX+iK02e+5l/C8DEBK9bgfaBj1C6lfu/yb5kOcWtiQROKDDVPJeIG/baEMajccqj7t3
X-Proofpoint-ORIG-GUID: n9icrul-5QQRR8-0XybbBDzAXo3tLAj0
X-Authority-Analysis: v=2.4 cv=L5kdQ/T8 c=1 sm=1 tr=0 ts=682dac59 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=E8j359MtUMzoLxJxKO8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: n9icrul-5QQRR8-0XybbBDzAXo3tLAj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210094

> > Introduce new interface on s390 with the following attributes:
> > 
> > 1) Attribute1:
> > /sys/firmware/memory/block_size_bytes
> 
> I assume this will be the storage increment size.

Hi David,

No, this is memory block size.

> > > 2) Attribute2:
> > /sys/firmware/memory/memoryX/config
> > echo 0 > /sys/firmware/memory/memoryX/config  -> deconfigure memoryX
> > echo 1 > /sys/firmware/memory/memoryX/config ->  configure memoryX
> 
> And these would configure individual storage increments, essentially calling
> add_memory() and (if possible because we could offline the memory)
> remove_memory().

configure or deconfigure memory in units of entire memory blocks.

As I understand it, add_memory() operates on memory block granularity,
and this is enforced by check_hotplug_memory_range(), which ensures the
requested range aligns with the memory block size.

> > 3) Attribute3:
> > /sys/firmware/memory/memoryX/altmap_required
> > echo 0 > /sys/firmware/memory/memoryX/altmap_required -> noaltmap
> > echo 1 > /sys/firmware/memory/memoryX/altmap_required -> altmap
> > echo N > /sys/firmware/memory/memoryX/altmap_required -> variable size
> > 	 altmap grouping (possible future requirements),
> > 	 where N specifies the number of memory blocks that the current
> > 	 memory block manages altmap. There are two possibilities here:
> >          * If the altmap cannot fit entirely within memoryX, it can
> >            extend into memoryX+1, meaning the altmap metadata will span
> >            across multiple memory blocks.
> >          * If the altmap for memory range cannot fit within memoryX,
> >            then config will return -EINVAL.
> 
> Do we really still need this when we can configure/deconfigure?
> 
> I mean, on s390x, the most important use case for memmap-on-memory was not
> wasting memory for offline memory blocks.
> 
> But with a configuration interface like this ... the only benefit is being
> able to more-reliably add memory in low-memory conditions. An unlikely
> scenario with standby storage IMHO.
> 
> Note that I dislike exposing "altmap" to the user :) Dax calls it
> "memmap_on_memory", and it is a device attrivute.
> 
> As soon as we go down that path we have the complexity of having to group
> memory blocks etc, and if we can just not go down that path right now it
> will make things a lot simpler.
> 
> (especially, as you document above, the semantics become *really* weird)
> 
> As yet another point, I am not sure if someone really needs a per-memory
> block control of the memmap-on-memory feature.
> 
> If we could simplify here, that would be great ...

The original motivation for introducing memmap_on_memory on s390 was to
avoid using online memory to store struct page metadata, particularly
for standby memory blocks. This became critical in cases where there was
an imbalance between standby and online memory, potentially leading to
boot failures due to insufficient memory for metadata allocation.

To address this, memmap_on_memory was utilized on s390. However, in its
current form, it adds altmap metadata at the start of each memory block
at the time of addition, and this configuration is static. It cannot be
changed at runtime.

I was wondering about the following practical scenario:

When online memory is nearly full, the user can add a standby memory
block with memmap_on_memory enabled. This allows the system to avoid
consuming already scarce online memory for metadata.

After enabling and bringing that standby memory online, the user now
has enough free online memory to add additional memory blocks without
memmap_on_memory. These later blocks can provide physically contiguous
memory, which is important for workloads or devices requiring continuous
physical address space.

If my interpretation is correct, I see good potential for this be be
useful.

As you pointed out, how about having something similar to
73954d379efd ("dax: add a sysfs knob to control memmap_on_memory behavior")

i.e.

1) To configure/deconfigure a memory block
/sys/firmware/memory/memoryX/config

1 -> configure
0 -> deconfigure

2) Determine whether memory block should have memmap_on_memory or not.
/sys/firmware/memory/memoryX/memmap_on_memory
1 -> with altmap
0 -> without altmap

This attribute must be set before the memoryX is configured. Or else, it
will default to CONFIG_MHP_MEMMAP_ON_MEMORY / memmap_on_memory parameter.


> > NOTE: “altmap_required” attribute must be set before setting the block as
> > configured via “config” attribute. (Dependancy)
> > 
> > 4) Additionally add the patch to check if the memory block is configured
> > with altmap or not. Similar to [RFC PATCH 2/4] mm/memory_hotplug: Add
> > memory block altmap sysfs attribute.
> > 
> > Most of the code changes will be s390 specific with this interface.
> > 
> > Request your inputs on the potential interface. Thank you.
> > 
> > Other questions:
> > 1. I’m just wondering how variable-sized altmap grouping will be
> > structured in the future. Is it organized by grouping the memory blocks
> > that require altmap, with the first memory block storing the altmap
> > metadata for all of them? Or is it possible for the altmap metadata to
> > span across multiple memory blocks?
> 
> That exactly is unclear, which is why we should probably avoid doing that
> for now. Also, with other developments happening (memdesc), and ongoing
> effort to shrink "struct page", maybe we will not even need most of this in
> the future?
> 
> > 
> > 2. OR, will dedicated memory blocks be used exclusively for altmap
> > metadata, which the memory blocks requiring altmap would then consume? (To
> > prevent fragmentation) ?
> 
> One idea I had was that you would do the add_memory() in bigger granularity.
> 
> Then, the memory blocks hosting the memmap would have to get onlined first.
> And offlining of them would fail until all dependent ones were offlined.
> 
> That would at least limit the impact.
> 
> Then, the question would be, how could you "group" these memory blocks from
> your interface to do a single add_memory() etc.
> 
> But again, maybe we can leave that part out for now ...

Thank you David for the details. I will ignore/leave variable sized
altmap grouping for now.
