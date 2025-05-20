Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA422422F;
	Tue, 20 May 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746395; cv=none; b=Efzf+EFtZkQhx1gVh6i5W8ArD+fZ7XxjbXDnMWze069hXq0XRTwpEGpHn+Zmvf7d8IqW/UtEhxG1A4ggUdDNr2jMK23xVhl0BACaF0ujfHSc8gZ7ZQlkfWG4rcCdVSwQyiX/J6nuImCzI869wEm/PglkiB3jfk/PVdFBFIDb+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746395; c=relaxed/simple;
	bh=4hJL3d24yTxg/sVIhUFtZaoBtL0PWHqh8Y4HdHYhUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjoqganYkVYUHUZ56Adh9DzAHby2TZRO34DCethwQojlFdhEM+Kk3Xtuo8eirgaYQxXnGe3x8jklOzctq7lUci1ujPEZVVoxMvZ6cdUgmbn7SD1oxonnncHbBEo0LFIcVqVgYYvn9zw9i/vSWP65QuuSQaLkB5w4YgiujnUlUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IlWeZAxe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IlWeZAxe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IKD6016775;
	Tue, 20 May 2025 13:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cy5wTS
	ziBQsdtfZ3j8cjf5XwjTaunUcYpjReKuumP8I=; b=IlWeZAxedET7Z2mOeMuRv9
	li3lI16EdCt/dz9rwX0qCCka8ZU+4alIJVojoPwCXML14qAKxg2dcuPbRqFbfaBD
	aSqUWEEtFt33xYVhk6LMpyISnlG2WCapgPFUJhm1Q4bSQk3BknFIf409nFTAE9X7
	VbAIrsFr2xZZ4dwrG4K+rrLX5pz7sghF609G7pAzZAw5xHRQ4gk7T4d99lk8xOLc
	GEyoxUAkcq1hC1p+JPaOSUD0QWbPmhrSu0B2+x6quBj7qBCFT8jvLBFVj13t/I0K
	t8JmMr6d3jB0kCHfiV4xd+NYC+PkOU8RPF9jQJ9wLigr8rXihPEVmYXDiJA0aQnQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbsswt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 13:06:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KApXUE002449;
	Tue, 20 May 2025 13:06:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snv0e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 13:06:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KD6I0i28901976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:06:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0ED52004E;
	Tue, 20 May 2025 13:06:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7217A2004B;
	Tue, 20 May 2025 13:06:17 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.35.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 13:06:17 +0000 (GMT)
Date: Tue, 20 May 2025 15:06:16 +0200
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
Message-ID: <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwNSBTYWx0ZWRfX0WqjmVSHorLo oxRKIaBoqik08JOTxgRvtRr9+NaMbtdHMGNpIWeUrDtXI8n94s1hTWlde3f3fzkNSOYTnLCRh+e gAOiOEUsrIyQ2ir0+KOGSFnviRP+/+pRnL6Q5nKgQcgY0F9HmXkFU3vZPKArO8dCKpiO0TcPX34
 3fAocxMTCJX/obvj9AYOFsx/uU1NHVa8DeSd3UuvdaCXWbrcjxhrq9m2b8ucjzejTgRo8wNF70O xE02HhgbME0sCbhvo73TQRIJGW4ybMZnx24q72uVjuKlFwVzNXn/3ESQK/AktvDbKpH54vFDdz9 0CT9b8EdI/YjbSafiBwnFhparAmctdFncMt9amrBzHbpb4n+trw3jCZZz6jCAALGGDGaaGhsm5m
 P5savAnGCSxnzYPx59PKokJNU+oWbdWXOdbR2P2z1uwVpY2jf64SVlvTDvz4CeRvF4k/VOpQ
X-Proofpoint-ORIG-GUID: OXkGa_xERynWSUNglpmDyrmyuQd-c5Oo
X-Proofpoint-GUID: OXkGa_xERynWSUNglpmDyrmyuQd-c5Oo
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c7e50 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=lGm5nveCKM6En4syuT0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=880
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200105

> Maybe "standby memory" might make it clearer. The concept is s390x specific,
> and it will likely stay s390x specific.
> 
> I like the idea (frontend/tool interface), all we need is a way for these
> commands to detect ranges and turn them from standby into usable memory.
> 
> > 
> > The user can still determine the available memory ranges and make them
> > configurable using tools like lsmem or chmem with this approach atleast
> > on s390 with this approach.
> > 
> > > My thinking was that s390x would expose the standby memory ranges somewhere
> > > arch specific in sysfs. From there, one could simply trigger the adding
> > > (maybe specifying e.g, memmap_on_memory) of selected ranges.

Hi David,

Sorry for the late reply.

Potential design approach for enabling dynamic configuration and
deconfiguration of hotplug memory with support for both altmap and
non-altmap usage.

Introduces flexibility, allowing users to specify at runtime which
memory ranges should utilize altmap, rather than relying on a static
system-wide setting that applies uniformly to all hotplugged memory.

Introduce new interface on s390 with the following attributes:

1) Attribute1:
/sys/firmware/memory/block_size_bytes

2) Attribute2:
/sys/firmware/memory/memoryX/config
echo 0 > /sys/firmware/memory/memoryX/config  -> deconfigure memoryX
echo 1 > /sys/firmware/memory/memoryX/config ->  configure memoryX

3) Attribute3:
/sys/firmware/memory/memoryX/altmap_required
echo 0 > /sys/firmware/memory/memoryX/altmap_required -> noaltmap
echo 1 > /sys/firmware/memory/memoryX/altmap_required -> altmap
echo N > /sys/firmware/memory/memoryX/altmap_required -> variable size
	 altmap grouping (possible future requirements),
	 where N specifies the number of memory blocks that the current
	 memory block manages altmap. There are two possibilities here:
         * If the altmap cannot fit entirely within memoryX, it can
           extend into memoryX+1, meaning the altmap metadata will span
           across multiple memory blocks.
         * If the altmap for memory range cannot fit within memoryX,
           then config will return -EINVAL.
           
NOTE: “altmap_required” attribute must be set before setting the block as
configured via “config” attribute. (Dependancy)

4) Additionally add the patch to check if the memory block is configured
with altmap or not. Similar to [RFC PATCH 2/4] mm/memory_hotplug: Add
memory block altmap sysfs attribute.

Most of the code changes will be s390 specific with this interface.

Request your inputs on the potential interface. Thank you.

Other questions:
1. I’m just wondering how variable-sized altmap grouping will be
structured in the future. Is it organized by grouping the memory blocks
that require altmap, with the first memory block storing the altmap
metadata for all of them? Or is it possible for the altmap metadata to
span across multiple memory blocks?


2. OR, will dedicated memory blocks be used exclusively for altmap
metadata, which the memory blocks requiring altmap would then consume? (To
prevent fragmentation) ?


Thank you,
Sumanth
