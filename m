Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3C3BB24;
	Tue,  3 Dec 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236406; cv=none; b=aTPFeuOdfZjU+rASHDwnC086kTXudq5s1aHmGzNcbpjVT7FKYTsVScvrDpIBmZoLr8NU0lPmvB8dqrLpljL7Nb/Y4RDZkJJ1uDrLP7gSS5F9CRjrmUA7QZPZOO6gCEU8PzE0r476r63QO2o6cLilyHDaCFRxXG8c2KHAbF+4frY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236406; c=relaxed/simple;
	bh=11j42MwHiEKqypzz0wQHy9eouxCnRZ0P38XMeQx2weI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk8osaWR2lfa1INftiuZkAiCbRrIZEOZlh29Chs3HD10dAhlATc1keTU4+6UmMDam/kOYoQDWhr+b66VAtH1a4m8aQYIcgbFw1COBNdw/GNzn5vm7qX/6Z0EvzveF6Mbot7vp+HMuc9VpizZfawPW93hPWM/XXTQqpCn2HxbSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VwSoI1Ax; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VwSoI1Ax"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CrBHM011897;
	Tue, 3 Dec 2024 14:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rt42MDgeK03o2gsfWT114x3hcN+2YJ
	+aVG8pLK9z4/A=; b=VwSoI1Ax8xzUJrCv4kItpgZ+9TMC+RdXwDDo5mZh1RktEu
	od70T4XW5SjDdAoE6V36/yF/P8O8uDlu7p9jQWLd/R5y+SKkzOustiJbLlfeLO8z
	ttYnzDiOW2/JF+n6kQdizDS5n4i+4Xxd5PdXx4DLr9yCxoidEUWpbQ78+fTJhaKz
	d/GVtdeB2My+RYTqj1xm0Lf5zuNKzQC1idobT5Fo7w6GGnPuPlqDpbQP90gpVuhK
	7yujaQ7mFaIIFfyf/bHtS+cZDZVlDEc4ChldiqYExt06kBR1EXHhVdbLMKsVfPTb
	UwQEKggbY4gEFDsv1cqb6jdsP1qAxjtjbTs4s1DA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4j28df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:33:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3D0RMK031726;
	Tue, 3 Dec 2024 14:33:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ehkwb6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:33:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3EXAuR31588924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:33:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D22482004B;
	Tue,  3 Dec 2024 14:33:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D0A20040;
	Tue,  3 Dec 2024 14:33:10 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.16.180])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Dec 2024 14:33:10 +0000 (GMT)
Date: Tue, 3 Dec 2024 15:33:08 +0100
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
Message-ID: <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ItduTtDKXqtELposVLLu0zuhPtcE-6J
X-Proofpoint-ORIG-GUID: 9ItduTtDKXqtELposVLLu0zuhPtcE-6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=596 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030124

On Mon, Dec 02, 2024 at 05:55:19PM +0100, David Hildenbrand wrote:
> Hi!
> 
> Not completely what I had in mind, especially not that we need something
> that generic without any indication of ranges :)
> 
> In general, the flow is as follows:
> 
> 1) Driver detects memory and adds it
> 2) Something auto-onlines that memory (e.g., udev rule)
> 
> For dax/kmem, 1) can be controlled using devdax, and usually it also tries
> to take care of 2).
> 
> s390x standby storage really is the weird thing here, because it does 1) and
> doesn't want 2). It shouldn't do 1) until a user wants to make use of
> standby memory.

Hi David,

The current rfc design doesnt do 1) until user initiates it.

The current rfc design considers the fact that there cannot be memory
holes, when there is a availability of standby memory. (which holds true
for both lpars and zvms)

With number of online and standby memory ranges count
(max_configurable), prototype lsmem/chmem could determine memory ranges
which are not yet configured 
i.e. (configurable_memory = max_configurable - online ranges from sysfs
/sys/devices/system/memory/memory*).

Example prototype implementation of lsmem/chmem looks like:
./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
RANGE                                 SIZE        STATE  BLOCK ALTMAP
0x0000000000000000-0x00000002ffffffff  12G       online   0-95      0
0x0000000300000000-0x00000003ffffffff   4G deconfigured 96-127      -

# Configure range with altmap
./chmem -c 0x0000000300000000-0x00000003ffffffff -a
./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
RANGE                                 SIZE   STATE  BLOCK ALTMAP
0x0000000000000000-0x00000002ffffffff  12G  online   0-95      0
0x0000000300000000-0x00000003ffffffff   4G offline 96-127      1


# Online range
./chmem -e 0x0000000300000000-0x00000003ffffffff &&
./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
RANGE                                 SIZE  STATE  BLOCK ALTMAP
0x0000000000000000-0x00000002ffffffff  12G online   0-95      0
0x0000000300000000-0x00000003ffffffff   4G online 96-127      1

Memory block size:       128M
Total online memory:      16G
Total offline memory:      0B
Total deconfigured:        0B

# offline range
./chmem -d 0x0000000300000000-0x00000003ffffffff &&
./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
RANGE                                 SIZE   STATE  BLOCK ALTMAP
0x0000000000000000-0x00000002ffffffff  12G  online   0-95      0
0x0000000300000000-0x00000003ffffffff   4G offline 96-127      1

Memory block size:       128M
Total online memory:      12G
Total offline memory:      4G
Total deconfigured:        0B

# Defconfigure range.
./chmem -g 0x0000000300000000-0x00000003ffffffff &&
./lsmem -o RANGE,SIZE,STATE,BLOCK,ALTMAP
RANGE                                 SIZE        STATE  BLOCK ALTMAP
0x0000000000000000-0x00000002ffffffff  12G       online   0-95      0
0x0000000300000000-0x00000003ffffffff   4G deconfigured 96-127      -

Memory block size:       128M
Total online memory:      12G
Total offline memory:      0B
Total deconfigured:        4G

The user can still determine the available memory ranges and make them
configurable using tools like lsmem or chmem with this approach atleast
on s390 with this approach.

> My thinking was that s390x would expose the standby memory ranges somewhere
> arch specific in sysfs. From there, one could simply trigger the adding
> (maybe specifying e.g, memmap_on_memory) of selected ranges.

As far as I understand, sysfs interface limits the size of the buffer
used in show() to 4kb.  When there are huge number of standby memory
ranges, wouldnt it be an issue to display everything in one attribute?

Or use sysfs binary attributes to overcome the limitation?

Please correct me, If I am wrong.

Questions:
1. If we go ahead with this sysfs interface approach to list all standby
memory ranges, could the list be made available via
/sys/devices/system/memory/configurable_memlist?  This could be helpful,
as /sys/devices/system/memory/configure_memory performs architecture
independent checks and could also be useful for other architectures in
the future.

2. Whether the new interface should also be compatible with lsmem/chmem?

3. OR can we have a s390 specific path (eg:
/sys/firmware/memory/standy_range) to list all standby memory range
which are in deconfigured state and also use the current design
(max_configurable) to make it easier for lsmem/chmem tool to detect
these standby memory ranges?

> To disable standby memory, one would first offline the memory to then
> trigger removal using the arch specific interface. It is very similar to
> dax/kmem's way of handling offline+removal.

ok

> Now I wonder if dax/kmem could be (ab)used on s390x for standby storage.
> Likely a simple sysfs interface could be easier to implement.

I havent checked dax/kmem in detail yet. I will look into it.

Thank you
