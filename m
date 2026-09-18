Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745251588B;
	Fri, 18 Sep 2026 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748610; cv=none; b=BlSuFHLsa9lfnY1HjIbLohJ5sSIzSZf85RE/CjB94OffaetyCwSa2MRCc0Qpc00bz/QPNnsVB3+wMY6OhahwtyMTqJEew/O8gf2nBoAFxirtOwQ0MgEsTazcQY3EEgWgWsQjC4n9u5f5jjy2Wgjq9li1tLIczRPhxwMAPeFNRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748610; c=relaxed/simple;
	bh=7KbXMhEqmqjcyHwSyY4d88MqeXx5NAmrig7I9IyDPkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh3wqgVjPElLLTOAI3jq4ACr59//Nx8oJU8fIma50a9yhJpRdifagBUJaMTwa8buFbbDMMNC1TKOg9SsOWnL2itnh7JWQthZCLrXUNVQJ4K0zNJKI8+9+WTbBkYh/wZp5jfSq0jzpEDJ8/E3l3+awxBMJAS+y3mM5+uoXRFguAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U164ZCfS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U164ZCfS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVZm71393547;
	Fri, 18 Sep 2026 16:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IrSrPG
	h89ZBDJ8ImJt+nz22I+rOlaK5hWlIv4GDrkKo=; b=U164ZCfSbTri6NhwgGdd3A
	OoIYNbQwf6mDGk/ZN7w8Ru+s+GGDPi7jYOhlIoGDlMrqjEqWYq92ruppUAa9NUwO
	CG0fsRs5JefNx1W/Hdsrh4qtjwKMQ8v/5GrtRvuNbpFFKBxE28bvz/3Za8P0bzhq
	P1gkqz8uUaNTxWXzufHcxsdRQ+0jmi98abs178Z3ffGngut6hFVqyrlR14A+H2e0
	2XqfAstr4OqhE6z7mksk7I1jcjnV5YAZtWYtu1Bot1F9D+A/n+m1iqsUGJILvbgl
	+eLk77feKSajb86IdZm2kzBFQmDS5rzm96q8jyIXCe9ZvuDcdA8Oo5BSBCEVSf9g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5h770-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:23:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO2Fh771897;
	Fri, 18 Sep 2026 16:23:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffg5yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 16:23:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IGN8YI31982158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 16:23:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A5B358055;
	Fri, 18 Sep 2026 16:23:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 498C45804B;
	Fri, 18 Sep 2026 16:23:06 +0000 (GMT)
Received: from [9.111.192.138] (unknown [9.111.192.138])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 16:23:06 +0000 (GMT)
Message-ID: <bf57f67e-4a51-407a-b869-b9d78a9875b4@linux.ibm.com>
Date: Fri, 18 Sep 2026 18:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] s390/cio: replace page allocator calls with
 k[mz]alloc()
To: Heiko Carstens <hca@linux.ibm.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan
 <vneethv@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916130613.15587F91-hca@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260916130613.15587F91-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vTyVM8gFf2TLxGe0RjdKNlWme4FkyRm6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX12DmjXrEm5MR
 h/AvVcvlh5F9Jzcx3msRny4416tysM3XT+DK1T4EAg1Tc8kI2m3sAh0MCVEE5m2jJsOzsor/lWm
 LhlGoZjGMZlGoTfMOpXBVOkV27ORGEo=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad656e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IRwR5hotAdJOlb6Xvy0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vTyVM8gFf2TLxGe0RjdKNlWme4FkyRm6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIyOSBTYWx0ZWRfX9VrQ2GokdTf/
 ij01HjXDQRKd9KcreIiqI/fXcgj3CFh8IV3Ywtcj5oFBp9ClR4zc1dWxHF+s+wNUqCODODzn0pz
 62Hn7XGiwhK8ouluqvAn2U2Uv3R9hZ4nUA1k/ozSdmbdM3yLAouP2b7TjU+za74QNUP/SDs2kuV
 +TzM3unuJpH/QCI0WNt9zWl+flvufd6ShlibskDDOwZ/Wgrs7g7sEiVXHUAAMsiGIykrOcfZkZr
 aJYf1nfQqrxhYuQcle7w8QKFUsrgFS4tU2c6lyp9aiDUNFOues2xArRa4Dh+hp9pRGjSdWg2S+y
 3Z97elu/WJo/mNnyWwADDXckyafk1reo63sgpjQ+FSiVjXUxVdlqeiU4eSitu4SDZeNzQe6busz
 pjpvKbW7ZS+wbhuVrz+xIv9PsUoHOGDu0h9PeCq1L05AK5Bult0pgC74RcUO75w2eNGm7Hyaopl
 jmnErCQwD70LaaCERwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180229

On 16.09.2026 15:06, Heiko Carstens wrote:
> On Wed, Sep 16, 2026 at 03:03:07PM +0300, Mike Rapoport (Microsoft) wrote:
>> The saga continues :)
>>
>> This series covers CIO, QDIO, SCM and IDAL buffer allocations.
> 
> ...
> 
>> Mike Rapoport (Microsoft) (13):
>>       s390/chsc: Use kzalloc() for CUBs
>>       s390/chsc: Use kzalloc() for the SEI work area
>>       s390/chsc_sch: Use kzalloc() for CHSC requests
>>       s390/chsc_sch: Use __free(kfree) for synchronous CHSC requests
>>       s390/cio: Use kzalloc() for CHSC work areas
>>       s390/cmf: Use kmalloc() for the CMB area
>>       s390/idals: Use kmalloc() for IDAL data buffers
>>       s390/qdio_main: Use kzalloc() for the IRQ structure
>>       s390/qdio_main: Use kzalloc() for the QDR
>>       s390/qdio_setup: Use kzalloc() for QDIO buffers
>>       s390/qdio_setup: Use kmalloc() for the storage list
>>       s390/qdio_setup: Use kmalloc() for the SSQD request
>>       s390/scm: Use kmalloc() for SCM information
>>
>>  arch/s390/include/asm/idals.h   |   9 +-
>>  drivers/s390/cio/chsc.c         |  20 +--
>>  drivers/s390/cio/chsc_sch.c     | 300 ++++++++++++++--------------------------
>>  drivers/s390/cio/cmf.c          |  11 +-
>>  drivers/s390/cio/qdio.h         |   2 +-
>>  drivers/s390/cio/qdio_main.c    |  23 ++-
>>  drivers/s390/cio/qdio_setup.c   |  14 +-
>>  drivers/s390/cio/qdio_thinint.c |   2 +-
>>  drivers/s390/cio/scm.c          |   7 +-
>>  9 files changed, 150 insertions(+), 238 deletions(-)
> 
> As far as I am concerned:
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Waiting for IO folks before applying. Thanks!

Looks good to me! For the full series:

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
