Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F5459AFC;
	Sun, 20 Sep 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928426; cv=none; b=LOm4R1PyMbHDCIs1f7+q2hONfzHZR52IWSYv31+DYHbxsNsGgAiUlBXoyd6gk+YxS76aZ4tA1GWODJwt0fyqW69O7tcCGiQWPwkcrE32AcZg6JDgqVMcYL9S8pIPum8qpE60F8A6vg5xv7kgWSD9aZ7RCdgCt9YtX1QXfHuBGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928426; c=relaxed/simple;
	bh=W+vMR2OGV0sMUeYcnW5GBBEvRxR1q2dwoP28hoRQuYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iADES1W5ov789X//9qGYrRiOvB7Pi4zRszwS0BhAWbvaY1P+5MFfRkgJCCMdbsdbgTO2RLUXJgw003ixqTTi5ReqKo0iRp3wWs+5zCMBw1X0e7bHAOvysrJO31DodVFoh2O4QBIUzpXuZKptE0wqKHkvttB6wecpIxSRU1aubco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LarCZc8w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LarCZc8w"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFaVga1879573;
	Sun, 20 Sep 2026 18:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gSQm+/rR3pASi/0SUNxB8Qq8vPENv6
	CpvH7QrG78q0g=; b=LarCZc8wstRTyvaeeF0Rh0VILzD9xcn8lLzVEPYcumq6/i
	V0b5uoLVESOv2NgUqkllClbCi9DrFyM1i581tho1hnhoPvU4azjnnnXFc2byI1ay
	wdEVzxvcNP7uAp/i57Do9wFrke/FCkzCrkrzUPen2oxu905L/K4XjCbMMsAj8c6s
	8bLjZxEynWwCp+fn0za6GdSG3Ob0dcoXZLZ6/+aeyIfj4ALkb8JD0q+igTBp8yD5
	UW8FBUwbqW4g8fnv8AYHIA/OsJDZ+dONpb7fCJfrQbCa84ZX0UN5Yd0XAnBx3s0S
	yvFsjk71Kvr7BarwSN1MVEDN4Tpga1GqnwchMt7Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq54t1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 18:20:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFHX4j4109026;
	Sun, 20 Sep 2026 18:20:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq2fq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 18:20:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KIKDtI37093870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 18:20:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C42BF20043;
	Sun, 20 Sep 2026 18:20:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6130020040;
	Sun, 20 Sep 2026 18:20:13 +0000 (GMT)
Received: from osiris (unknown [9.87.137.215])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 20 Sep 2026 18:20:13 +0000 (GMT)
Date: Sun, 20 Sep 2026 20:20:11 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
Message-ID: <20260920182011.18515Dfc-hca@linux.ibm.com>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916130613.15587F91-hca@linux.ibm.com>
 <bf57f67e-4a51-407a-b869-b9d78a9875b4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf57f67e-4a51-407a-b869-b9d78a9875b4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab023e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=iTZJ_rmbzj6-XQSVU9QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDI2NSBTYWx0ZWRfX6ARKW8NV9hd6
 BVG1Idc8lZzxNnuVj3XxjILfISXO+yn8R8T/PqpYBX3RDAEoY/VhOv2xLFGvSB6RtC8UK8ZXihW
 jI9v8zwB6DbaYjwWkRI9l4Qo7Xs6VvqGmz8MhD0tWM0/8AcxzG7osvsPao2FMjq0RNu3H0fmP3P
 qnZwEZ7KTx1skXIMbcx4xqy7sOFiMR4Rvmab5SEwlmo7wFrfrcBP8rv4LMUtmZ4qZvXMEzKbzTv
 Mhwu3C8BdA1SktJaMOusCZ9FTgHdnUistRtb82gBIGj8krMdu/U3lKhkTOuxxKujmYmJPTR5P0y
 KNEATWMsgnksIGRS5M657qGFTQNnHlZc54gL7BsgZRWA+NI8F8IOxH7UanwALSvZ/kzq4X/o4J5
 XLlTy5bccwoMLKJ3BBj0BlR0G9l7bLUApBWNYgrYZySDAFNQ7gGOK+sKsCrjmFM2plGEuXSg7Gw
 uA+sSkepdPLZw00i+Dg==
X-Proofpoint-ORIG-GUID: A898qOlsBDd8jU1o4XP8_XhYfDoXwp73
X-Proofpoint-GUID: A898qOlsBDd8jU1o4XP8_XhYfDoXwp73
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDI2NSBTYWx0ZWRfXzn4lTBGwUaX/
 nTH6fCleWHQK3oHHVrj/QUyaeYVykEhfTJgZRTaZow3yzUC7hyXbSFPRSxJ6JAfD0gyw5DRpFah
 7Q/ct+MvIIRil+Vi2BfaGerox59rezE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200265

On Fri, Sep 18, 2026 at 06:23:00PM +0200, Peter Oberparleiter wrote:
> On 16.09.2026 15:06, Heiko Carstens wrote:
> > On Wed, Sep 16, 2026 at 03:03:07PM +0300, Mike Rapoport (Microsoft) wrote:
> >> Mike Rapoport (Microsoft) (13):
> >>       s390/chsc: Use kzalloc() for CUBs
> >>       s390/chsc: Use kzalloc() for the SEI work area
> >>       s390/chsc_sch: Use kzalloc() for CHSC requests
> >>       s390/chsc_sch: Use __free(kfree) for synchronous CHSC requests
> >>       s390/cio: Use kzalloc() for CHSC work areas
> >>       s390/cmf: Use kmalloc() for the CMB area
> >>       s390/idals: Use kmalloc() for IDAL data buffers
> >>       s390/qdio_main: Use kzalloc() for the IRQ structure
> >>       s390/qdio_main: Use kzalloc() for the QDR
> >>       s390/qdio_setup: Use kzalloc() for QDIO buffers
> >>       s390/qdio_setup: Use kmalloc() for the storage list
> >>       s390/qdio_setup: Use kmalloc() for the SSQD request
> >>       s390/scm: Use kmalloc() for SCM information
> >>
> >>  arch/s390/include/asm/idals.h   |   9 +-
> >>  drivers/s390/cio/chsc.c         |  20 +--
> >>  drivers/s390/cio/chsc_sch.c     | 300 ++++++++++++++--------------------------
> >>  drivers/s390/cio/cmf.c          |  11 +-
> >>  drivers/s390/cio/qdio.h         |   2 +-
> >>  drivers/s390/cio/qdio_main.c    |  23 ++-
> >>  drivers/s390/cio/qdio_setup.c   |  14 +-
> >>  drivers/s390/cio/qdio_thinint.c |   2 +-
> >>  drivers/s390/cio/scm.c          |   7 +-
> >>  9 files changed, 150 insertions(+), 238 deletions(-)
> > 
> > As far as I am concerned:
> > Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Waiting for IO folks before applying. Thanks!
> 
> Looks good to me! For the full series:
> 
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Series applied, thanks!
