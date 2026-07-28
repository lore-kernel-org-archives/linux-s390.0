Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E143CE62;
	Tue, 28 Jul 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250428; cv=none; b=SxnMjX2/D88k57qckNoPhKmqvxhHDaP9uw9MfpQTQY0+i3SFU5NII9EbK3JlSFON7efClysKLj1soqLW5wR1gHzeGzhbmJIKM9dTCiSVJTIBYDyQUzOVoN4kwauGTbjkazfXnwdwE6nF6zyRSotaXHETgJRgSYPzJBkdHxdf9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250428; c=relaxed/simple;
	bh=NHciinpjyjHArAAKkBzFn5d2Tji4u8Aux6m/KJ6sjEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irNR/UW8s/Vli5GiOu+FKCW9zImfW9YSsH226glIwrodrdDTbvJwkfpDZvbm7FQ+82o9OCE9Q1S+pIj5iw83483hMq726SV6rcVKNZAScqwkCWoyfPSSccryMnBHMt7QN73MbKCsXPSg3xTRz+lSKQ2ZKsDv/9R7Agij05Fc/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVn/Kr+w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVn/Kr+w"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEmPFf1492463;
	Tue, 28 Jul 2026 14:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iBifai
	MDvd2SGX0ZTOHgh3wFlFZ7GKsrep4ygATRmwE=; b=KVn/Kr+wE12CQ5qfOa2DIg
	kHGUDr7RvitLyi+DNx0ltOVWxYGmos72VDeksn7+87vKwIGEmhjwZC1tXVVKASbW
	D/YYmTth8jbVYo6p32wiHY394t+unYb3IwkCDxb5NyOy2kh7oguE7dzh7yLUPp45
	kkWLfIUjpJYlTq1X5AbKnLorAdsCfYBYov7Rs+0Un0080QVji1frc0JGF94NFOVh
	mJkPf0WaihOOHSUg4xZDtm5x7TB90cEPCtzfu9NlXl24VtYNbY2Om2/N7H1uAh6D
	2mqIOo753QK/TZMMCBXPH/q31c4gEBblC3rVhOok34raZD/XEzw+89iaUFOtVoBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xnuje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:53:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEfbu4022330;
	Tue, 28 Jul 2026 14:53:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqah0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:53:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEriV38979166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:53:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDA4158062;
	Tue, 28 Jul 2026 14:53:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC5758056;
	Tue, 28 Jul 2026 14:53:44 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 14:53:44 +0000 (GMT)
Message-ID: <93e1e75a-3036-47cc-a142-eff9b43630d7@linux.ibm.com>
Date: Tue, 28 Jul 2026 10:53:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] s390/vfio_ccw fixes
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yulX7zCzvWNy_sM-94JwC6pSqzBHvVe2
X-Proofpoint-ORIG-GUID: yulX7zCzvWNy_sM-94JwC6pSqzBHvVe2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX00ipVedcetPq
 5oVxN7QndKF0UGjXxN9EYF09ZT8G9BhWCIRuWV5fpphfSctUjbS3kB3a0VtrXlwj7pvgJVRWSac
 /wXFb7Ak3r1HRzW7SltdvoQegM6dfOo=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68c27a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CwKo_ULbxPcJYfvcVycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX/D4S/v7AKO4f
 37wmW3D9pQOj+1kEwPs0R2W5H+sipvce8FvvTxtyyNFjPmSQUiJmgUr2jGGLp7ucHgEmHaNxMMP
 jBtXYC6Y4UjlgC9R3UOmg6RofLRB6vXEJ/+vZ1QJHmepc2OvlWx42ZpBDgA0BGvnB+wpeJxGApF
 tBxhKBOtT3oPlES2KuX9e/H6FtCYjQe6ZTxR2Kc9OLth3NNuFN6QtqipiQbBU3aNDGMbWscQC4q
 SV6RmApzg/KEODj+dfNbBhyRRn4A0wLaWfUK9/e6B+YYTjetqYvZyPfU1SuRFQFVu6sKzyZp9nm
 in5kfv/lpLOr/SqGxpUG24qTr67sqG5IZOFCorVJLAauIpbNrKQMiRa++5ppNcGKplHBBoeOFX+
 HG3R1D4ebDBtYc3PTeG1uD19+uXb5aJ9QQNrn3XsHF8U94bapzcMIhiRkYrE564tNNU7PEQ0KG2
 HT6riPg8gzW8nCJ3VYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280132

On 7/27/26 11:30 PM, Eric Farman wrote:
> This series addresses some pre-existing issues found in the
> s390 vfio_ccw (DASD passthrough) driver.
> 
> Patches 1-6 are identical to v6/v7/v8
> Patches 7-10 have minor changes compared to v7/v8
> 
> v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.com/
> v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.com/
> v3: https://lore.kernel.org/r/20260723174751.1180334-1-farman@linux.ibm.com/
> v4: https://lore.kernel.org/r/20260725152705.3958100-1-farman@linux.ibm.com/
> v5: https://lore.kernel.org/r/20260726040129.2946151-1-farman@linux.ibm.com/
> v6: https://lore.kernel.org/r/20260726172153.1818056-1-farman@linux.ibm.com/
> v7: https://lore.kernel.org/r/20260727192230.2715207-1-farman@linux.ibm.com/
> v8: https://lore.kernel.org/r/20260728013509.1551753-1-farman@linux.ibm.com/
> v8->v9:
>  - [MR] Added r-b (thank you!)
>  - [MR] Commit/comment message improvements
>  - [MR/sashiko] Re-add workqueue cleanup to vfio_ccw_mdev_release_dev, in the
>    form of a flush_work() call

Thanks Eric.

I think at this point the big issues are resolved, and this already is a
significant improvement overall.

We've also identified a few things (here and off-list) that would be
reasonable tackled as follow-ons, such as a well-defined lock hierarchy
and identifying reasonable places to add lockdep assertions.

Thanks,
Matt

> 
> Eric Farman (10):
>   s390/vfio_ccw: free all memory if cp_init() fails
>   s390/vfio_ccw: limit the number of channel program segments
>   s390/vfio_ccw: fix out of bounds check on CCW array
>   s390/vfio_ccw: ensure first IDAW remains constant
>   s390/vfio_ccw: calculate idal length based on idaw type
>   s390/vfio_ccw: ensure index for read/write regions are within range
>   s390/vfio_ccw: cancel existing workqueues
>   s390/vfio_ccw: move cp cleanup out of not operational
>   s390/vfio_ccw: selectively expand io_mutex
>   s390/vfio_ccw: implement a crw lock
> 
>  drivers/s390/cio/vfio_ccw_async.c   | 16 +++++++
>  drivers/s390/cio/vfio_ccw_chp.c     | 31 ++++++++++--
>  drivers/s390/cio/vfio_ccw_cp.c      | 74 +++++++++++++++++++++--------
>  drivers/s390/cio/vfio_ccw_cp.h      | 10 ++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 21 +++++++-
>  drivers/s390/cio/vfio_ccw_fsm.c     |  8 +++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 39 +++++++++++++--
>  drivers/s390/cio/vfio_ccw_private.h | 10 +++-
>  8 files changed, 176 insertions(+), 33 deletions(-)
> 

