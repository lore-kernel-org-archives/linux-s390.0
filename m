Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159634BA5C;
	Tue,  7 Oct 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859784; cv=none; b=UWcX3gQRT/e7ItFToqxyZtLk3GTr76DGjEZnkdt3ZkGElsV2kbpNfF0mRGNnGo24QhfsoAiElxrY2FYOi+9NDyxJc7UKExS3ke15ZA76K/OqZW741Vr4CNoJT08fs4IHw4RSUIZdxLibTalyFyFC+qmAzfLjttsQcm7KauTrIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859784; c=relaxed/simple;
	bh=49+pRmCmZNOyTYPmRmQiTGXMqfU0hX61ESqK1EXT+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9C/ZiTXY+WYOg2ySBuMa6JeYrhUh6ZD2WgmmTZLCAfMglytrQJJGsiYg1WT+dYBCLxM6/SaS4xV/2HDRn9sHuBf3xGKjkOS9+4Kv+BeprGE9VEXJQRi7p61PiAyRzO1IlbpUbwsrbDEC9luIhJ8h2041bV3zxv2QzxVhFXxBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QtKDcyow; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QtKDcyow"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597HKPJ7004491;
	Tue, 7 Oct 2025 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5Ip2faPvSaL5hQutEabPCv/m/yn7K8
	QTSsXH+7JXA9U=; b=QtKDcyowrIK7ft2mhiDL/miKmtQri0B50qIimXQioE7NYk
	MWwWD7xNJw5PHbByJsck7FdieMu5TW4gnnflT2+S9jDj9zF7HMUsRi8uhA/eQPJI
	3a3fCdaaBGEZqt2NEO79DvNTR6eMwL9JnmJohJ9IUVhqpQdIVfcpY+MSPYNBo9wk
	OG5ql75sIccxS0UhjYH5Ewjt+BN5Y/0GwmgmNiZvelt5Pdu2RkmAQo2xmQ0BrPRm
	UZeDBx0AprSnKzLdFwPQBk35FrT2TQ/Mmin03ooyhs11se5GMmEGZus0D5LkWCvy
	VqZv5kidiN5g78FagLE9AUChk4n9TGoe7+UUMe8A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h0vnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 17:56:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597G5VFo000886;
	Tue, 7 Oct 2025 17:56:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9y4s56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 17:56:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 597Hu8QF52232618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 17:56:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84CC320043;
	Tue,  7 Oct 2025 17:56:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23CC22004D;
	Tue,  7 Oct 2025 17:56:08 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.19.165])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Oct 2025 17:56:08 +0000 (GMT)
Date: Tue, 7 Oct 2025 19:56:06 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
Message-ID: <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfXylUUU/jt24f5
 tQuSC7DX/ep+Nx3a70qKiQTRUwJ+I9sYyTmr0NLmAUv1eIkYwn8gTSXUkQbC4PcQY5Hqj/5JxvW
 uel0UHlhnqgxOwgfLbn0CoOdxZFqEc1+hoEhRyhfINkmo7XmULy5Nk+OspLE5kbzYDZpsiHnntt
 8m19KVrTH+drppv2C9UTKFLTYA6VyeR2JMPc+DhtgUO2nWnOjJxqoLG9c3cxJmExK2LMWQf+87F
 /IalMiEAagLF45wlZFpdxpP3TMAUHQXzkY2WrAc7PZyt/DargJxkN0sE3JJiFBQ4NcDFbGzU303
 7CcUwxPuPzBKqP85mErumtN1sxfGtz0eJUHJIbQDx8rsyM7KHHBKJ8tpmakbMYIb2h17UQ9hkAt
 lSQXtQ7xrqGoYL1cIDYu+Z2ZYI4PYg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e5543e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=92Z1TgZWQHc7t2sYIh8A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: oLSBHSvNKQ11hi5t5Mg7NEpb4gBzW7cf
X-Proofpoint-ORIG-GUID: oLSBHSvNKQ11hi5t5Mg7NEpb4gBzW7cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018

> > With the new interface, s390 will not add all possible hotplug memory in
> > advance, like before, to make it visible in sysfs for online/offline
> > actions. Instead, before memory block can be set online, it has to be
> > configured via a new interface in /sys/firmware/memory/memoryX/config,
> > which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
> > controlled by the user instead of adding it at boottime.
> 
> Before I dig into the details, will onlining/offling still trigger
> hypervisor action, or does that now really happen when memory is
> added/removed?
> 
> That would be really nice, because it would remove the whole need for
> "standby" memory, and having to treat hotplugged memory differently under
> LPAR/z/VM than anywhere else (-> keep it offline).

With this approach, hypervisor actions are triggered only when memory is
actually added or removed.

Online and offline operations are common code memory hotplug actions and
the s390 memory notifier actions are none/minimal.

> > s390 kernel sysfs interface to configure/deconfigure memory with
> > memmap_on_memory (with upcoming lsmem changes):
> > * Initial memory layout:
> > lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> > RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
> > 0x00000000-0x7fffffff   2G  online 0-15  yes        no
> > 0x80000000-0xffffffff   2G offline 16-31 no         yes
> 
> Could we instead modify "STATE" to reflect that it is "not added" / "not
> configured" / "disabled" etc?
> 
> Like
> 
> lsmem -o RANGE,SIZE,STATE,BLOCK,MEMMAP_ON_MEMORY
> RANGE                 SIZE    STATE BLOCK
> 0x00000000-0x7fffffff   2G   online 0-15
> 0x80000000-0xffffffff   2G disabled 16-31
> 
> Or is that an attempt to maintain backwards compatibility?

Mostly. Also, similar to lscpu output, where CPU status shows
CONFIGURED/STATE column.

Also, older scripts to get list of offline memory typically use:
lsmem | grep offline

and

chmem -e <SIZE> would work as usual, where <SIZE> specifies amount of
memory to set online.

chmem changes would look like:
chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
chmem -g 128M : deconfigure memory
chmem -e 128M : optionally configure (if supported by architecture) and
		always online memory
chmem -d 128M : offline and optionally deconfigure memory (if supported
		by architecture)

> > * Configure memory
> > echo 1 > /sys/firmware/memory/memory16/config
> 
> The granularity here is also memory_block_size_bytes(), correct?

Yes, correct.

> > lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> > RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
> > 0x00000000-0x7fffffff    2G  online  0-15  yes        no
> > 0x80000000-0x87ffffff  128M offline    16  yes        yes
> > 0x88000000-0xffffffff  1.9G offline 17-31  no         yes
> > 
> > * Deconfigure memory
> > echo 0 > /sys/firmware/memory/memory16/config
> > lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> > RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
> > 0x00000000-0x7fffffff   2G  online 0-15  yes        no
> > 0x80000000-0xffffffff   2G offline 16-31 no         yes
> > 
> > * Enable memmap_on_memory and online it.
> > (Deconfigure first)
> > echo 0 > /sys/devices/system/memory/memory5/online
> > echo 0 > /sys/firmware/memory/memory5/config
> > 
> > lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
> > RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
> > 0x00000000-0x27ffffff  640M  online 0-4   yes        no
> > 0x28000000-0x2fffffff  128M offline 5     no         no
> > 0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
> > 0x80000000-0xffffffff    2G offline 16-31 no         yes
> > 
> > (Enable memmap_on_memory and online it)
> > echo 1 > /sys/firmware/memory/memory5/memmap_on_memory
> > echo 1 > /sys/firmware/memory/memory5/config
> > echo 1 > /sys/devices/system/memory/memory5/online
> 
> I guess the use for memmap_on_memory would now be limited to making hotplug
> more likely to succeed in OOM scenarios.

Yes. with memmap-on-memory enabled, mainly in OOM situations.

However, it also provides flexibility to the user to configure few
memory blocks with memmap-on-memory enabled and few with
memmap-on-memory disabled (When the user needs continuous physical
memory across memory blocks).

> > Patch 4 removes the MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers. It
> > is no longer needed.  Memory can be brought to accessible state before
> > adding memory now, with runtime (de)configuration of memory.
> 
> Nice.

Thank you David
