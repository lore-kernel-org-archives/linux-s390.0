Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383844AB8E;
	Tue, 28 Jul 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249911; cv=none; b=L3qkghPJiSM8g6utesRVbfs63MNqsE4KFiAKqLrPbPRQAwY1ujHLRWqYa3unqm9SLvTOyYYUKuO1eQQxMM/QEaydCMKA27WzRrQBjsgzgRS0xqEDDRlX35Del5kdhmL0IfldfSjgvKHzYh6XspXpirW7qJLwtqZ4wmTnIGQ70tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249911; c=relaxed/simple;
	bh=fD6rP+ij1UurB0173oPfY8uNqLrQLfE6d6q9GSUXFEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5jmEyi93CJIPcvaShcfbTeE4EWmGibmoAspZZLVPOH7XJ9Il74rnbQ1HLlqzwiHuntz7nl5huiRkpdLX4UA2l4LzbdTkXd7Nrtf36TdEeTZfVdqgbZJQTLb8CreZbMgCjhmA+WdtfJTXgigmduEO/Z0Zpnr4tLt3BoWF2DMOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tJNk7tKb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tJNk7tKb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDlfKU1356653;
	Tue, 28 Jul 2026 14:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7a+38B
	w3Nqj4UbhC2WowxNI46J4Al70pBt+iZ5zHzlg=; b=tJNk7tKbPxY6z0kmPOwjX0
	A/G31t8sR520QhTS/wa54+bfA7kpvWAEx6S2M0T/In6jREF/iUf7TmUkVtW7nauR
	NEjRS3eflaD9/vKrgKHdbISgNjeYMmkO2umLbCf1WIyQfls7khUWRwPuBjm8VMZH
	mEJD+A9+NIRyM/bskor4AL9/u3JOgKziFE9rWkVGLCj5MIwaCgJ57+Q/i+zbcCzc
	2SkOgFQ+IxXHowPooFl8gsrte79PmwETDZiMaaz0nZGASVLzlnVLGEJuh1BrbW90
	aOC5AeZpSbYFzOuKtT9MHXC95nkZFW0tgzKJFrs005yvHlBtL4FQXz6FCSRHrncg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcw6yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:45:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEffx8024262;
	Tue, 28 Jul 2026 14:45:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y210b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:45:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEj3ur30409106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:45:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91F82004B;
	Tue, 28 Jul 2026 14:45:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FB6920043;
	Tue, 28 Jul 2026 14:45:03 +0000 (GMT)
Received: from [9.111.53.50] (unknown [9.111.53.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 14:45:03 +0000 (GMT)
Message-ID: <80896252-0a30-4342-8b8a-99398fcd6518@linux.ibm.com>
Date: Tue, 28 Jul 2026 16:45:03 +0200
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AbBB3A9RdXySX1dd9LMGBqkLe-ccleY4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX8HRDpUQrV5g3
 NdhxfAVdcSNy8pLssffGZh6hz2BdOJSqjdgvsFaZtfHc4pN7Q8WNk0BLcxtHPTMKnWFh3gNauoJ
 kVuaxX/rkKwjYIE2xruOrE9hiW8wjkw=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a68c074 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iJOlJMigZu3LgI6iOywA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX1j1pJ456oaoN
 i+Y2HOsf6I31PNOd4/P9gZGJVSyHpGcZ0lykWKOeTdwHBb6yXQqHoRvYAZuQccGVvIpawvZMyH/
 ZQ+cFrrdeXct6kXLCT1950rHglwEznaX6Jq6JMD2OrH+6shzMMWFILPp+AmiP5KHEdEYavVLnKs
 dNqivQyOXXYLFTMfi3KrEbZCB22E1CQ/yKF5L7rTRjL3hfx2pS4AVIPBRNeBK8wGvqO6I8F8Bo8
 WxblmCTNqX+yGAguiiSyTQgFTvuExHvuLPK1ACkI1clB1SkessqSyvgMZFgMFxoLLR3g/VHq3aB
 qe7bimkgwKEY9w/Ejbr5MIXEzn7C5j2QoYg+nCEgVd3z5VO8+wgJOhPje936O4wHVetRA9EyTGi
 enPknflf/hl6U0YNROoMQJeRPa4muoEFCGV/3iJc6jWwPV5Ot31ZNdUpAFCoKWT2qfI/T0triGO
 ZD8rY2d7nkWpVxHgWtg==
X-Proofpoint-GUID: AbBB3A9RdXySX1dd9LMGBqkLe-ccleY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280127

Am 28.07.26 um 05:30 schrieb Eric Farman:
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
>   - [MR] Added r-b (thank you!)
>   - [MR] Commit/comment message improvements
>   - [MR/sashiko] Re-add workqueue cleanup to vfio_ccw_mdev_release_dev, in the
>     form of a flush_work() call
> 
> Eric Farman (10):
>    s390/vfio_ccw: free all memory if cp_init() fails
>    s390/vfio_ccw: limit the number of channel program segments
>    s390/vfio_ccw: fix out of bounds check on CCW array
>    s390/vfio_ccw: ensure first IDAW remains constant
>    s390/vfio_ccw: calculate idal length based on idaw type
>    s390/vfio_ccw: ensure index for read/write regions are within range
>    s390/vfio_ccw: cancel existing workqueues
>    s390/vfio_ccw: move cp cleanup out of not operational
>    s390/vfio_ccw: selectively expand io_mutex
>    s390/vfio_ccw: implement a crw lock
> 
>   drivers/s390/cio/vfio_ccw_async.c   | 16 +++++++
>   drivers/s390/cio/vfio_ccw_chp.c     | 31 ++++++++++--
>   drivers/s390/cio/vfio_ccw_cp.c      | 74 +++++++++++++++++++++--------
>   drivers/s390/cio/vfio_ccw_cp.h      | 10 ++++
>   drivers/s390/cio/vfio_ccw_drv.c     | 21 +++++++-
>   drivers/s390/cio/vfio_ccw_fsm.c     |  8 +++-
>   drivers/s390/cio/vfio_ccw_ops.c     | 39 +++++++++++++--
>   drivers/s390/cio/vfio_ccw_private.h | 10 +++-
>   8 files changed, 176 insertions(+), 33 deletions(-

All applied. Thank you. 

