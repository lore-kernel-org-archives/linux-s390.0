Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6F1CD15;
	Sun, 12 Oct 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288007; cv=none; b=EOq6na43I894yCMojnIjz1OKpSvZpBxc+8TYTuDP+tCAUPoaw7C0P9/XWNSrzHZ4iYXbfB+MR2RU4rn9Dok9wLNk7rPs4S7NN10iiY35jcT+xa/XAvDaNsEfBFekMs3gQpUeUgEW98837GndlYAmdBe0ecMr7VQ6k7ukqd7dNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288007; c=relaxed/simple;
	bh=LlyHJvp8ly5araPsUHQAHkaqhEJoeP1+TACVZyIyLhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWqFDPmc2NhjEQiqDwfg5VfiPwdIlzMQ20XcCC5FEnX5QQ4PwbIMvXEYE+sAjMcLhd+uCchSolDS7j0+TBxLpKQguWKLUTJwiOXCMMNuZt0ydcqNBKHSSRFmRF+9SjJAd1c8GNJam5CXsDoJvrdabYoDPhKpdZ9eOtT2IKo/PZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BEg4aZ4f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BEg4aZ4f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59C2h43V008641;
	Sun, 12 Oct 2025 16:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=k+IjG48gXSLZIvwDyRg49bJXm99WAp
	KLTC/kWT+9feE=; b=BEg4aZ4fP6EnZ2EVZY0lRk8okP+8i9pqnPizPqbdniuclI
	HgnzgWDzO4IzJdk/XINJDlUmfb8ov3rwfshO5yMlJLxJvIn8FA6OI4ydzJ0Cn9SK
	pDSj4GhAJoV0LuSn/uU0oA9NGLx1xNOTdFhaRv4KiFHODTEK5pjr4YadUc6tEyoF
	e6YJlhu3gMaWgLlbKilS3pHadoUZQbrBayKQXo1x+0KgrBRHc2LVbkCU9vOsCJxo
	IfmW+pIOFct5PVFyVDqLNnABTC86FduF0q+GzmC/dksM+QHXGsvq+lAvEqSwtQO7
	Y2hiot4VjSUUbndyBpnfxjQMUHEQGBZdf+Elwq/g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtn9s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Oct 2025 16:53:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59CD761C019531;
	Sun, 12 Oct 2025 16:53:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jma90h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Oct 2025 16:53:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59CGrC1p8389034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Oct 2025 16:53:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A99120132;
	Sun, 12 Oct 2025 16:53:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD0D920131;
	Sun, 12 Oct 2025 16:53:11 +0000 (GMT)
Received: from osiris (unknown [9.87.155.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 12 Oct 2025 16:53:11 +0000 (GMT)
Date: Sun, 12 Oct 2025 18:53:10 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Support dynamic (de)configuration of memory
Message-ID: <20251012165310.56572A3d-hca@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
 <20251011114426.5313b7cb6951618c20ab62ca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011114426.5313b7cb6951618c20ab62ca@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 01PQDja_xbgElKHR2TdnRKhXwIJDSUh8
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ebdcfd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=amVAB9R6KjWVUBAK2OEA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 01PQDja_xbgElKHR2TdnRKhXwIJDSUh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX7ZI9a5FEts5A
 /3agJNK2lThnDOJjuxKDdY0M3Nw9T+g5llBvVulTJD0GcVMHJju+mWB8tDZeTXpdtgeDFesVfSm
 geySesNVRllwQdGCOeqfTlf4B49oLSNCwOG/cZtor6v4qfG+332qOdXRt5vY68xitl3P4J6GTJ8
 SB7QuV4dLJey6QPuTN5H8YzGZX5/0iSrkAgPosxwV9SjKdTigRZo2ZYVQhRjCx1jlbtcpPyndST
 NJFdjp6C7kQnCrj92j1xCDZrtTAssr+3i89A5mtoU9rEPVU2Lslb2knWUbJQKdWHIrjhV4UaKGd
 /P80iFEGTFdNFdaqFNmtyo0jwKlr+CqsYTKKrwZ3NJohJTRaUKfGTFPu+NvggQgwRbWRwQWfW5i
 ZC7M+S657oSeVpkQv08bZEglkEJZSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

On Sat, Oct 11, 2025 at 11:44:26AM -0700, Andrew Morton wrote:
> On Fri, 10 Oct 2025 10:51:43 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:
> > Patchset provides a new interface for dynamic configuration and
> > deconfiguration of hotplug memory on s390, allowing with/without
> > memmap_on_memory support. It is a follow up on the discussion with David
> > when introducing memmap_on_memory support for s390 and support dynamic
> > (de)configuration of memory:
> > 
> > ...
> >
> >  arch/s390/mm/pgalloc.c         |   2 +
> >  arch/s390/mm/vmem.c            |  21 +--
> >  drivers/base/memory.c          |  23 +--
> >  drivers/s390/char/sclp_mem.c   | 288 +++++++++++++++++++++++----------
> >  include/linux/memory.h         |   9 --
> >  include/linux/memory_hotplug.h |  18 +--
> >  include/linux/memremap.h       |   1 -
> >  mm/memory_hotplug.c            |  17 +-
> >  mm/sparse.c                    |   3 +-
> >  9 files changed, 225 insertions(+), 157 deletions(-)
> 
> I can add this to mm.git in the usual fashion, but the s390 tree would
> be a better place from a testing point of view?

It is not only about the testing point of view. We also want the
correspondig util-linux changes upstream - there may (or much more likely
may not) feedback which could require additional changes. Which means we
would going back and forth.

I think it is easiest to move forward with the s390 tree because of this.
