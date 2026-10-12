Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65924AE102;
	Mon, 12 Oct 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824435; cv=none; b=F0SR/qOmgKWJNf1Yhh+vvrru8MlYn77Xsz6v7FnRrabII4uqG/K/rN/HnUkGekckpHo7u0R1OMKY+blQ0Jtece5/BbvCGDc5TwyYFKbaO7GGmfOwuxaiRBJ2dBmyPF2jPD0QjLo8YBduNx6qHtBDcRi+UOlD6UeSMC4TOrihPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824435; c=relaxed/simple;
	bh=XlMpCsZwHRis/pEfyx/KdtAb+qbUzUUk9zbb6iUNNtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bICvSLuc6nJBNo3hzkN6bNMgOiULfLfqJIV4nii1D8j2cZpFWLtxATju414NW8R3Nov6Re7Z8fwWwvSZGcF9N2SaI90b2jUastonkZA7mFaLDTEGfGnq0IHcxHrvp7yX/lR2UBAzz98O10Hl1X36cErz+mJLT1JidALglgowmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=opNmfJ1R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="opNmfJ1R"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiCOa3074653;
	Mon, 12 Oct 2026 17:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MXefPC
	WMnio4uh+OSGJ8+0/F2XFBxXe2DI0PeE+NXjc=; b=opNmfJ1Rknwmsp++gL910g
	1ff6UQKnFeCgjDTUx+wT7jwwHL802QlPwRmhVR+yRricJic2DxmhTEM7LKjhsrD8
	HUU/0CXS8GRgEc3SQXhATmYIICvGcoyynSfdhHI5ikbW0CmO1tii06su8YfhuaC4
	rT2crBaPxueZS0uSRwBXuy/CQ1OkuxMM6UK/QQtHNDELhDbp4lvhZbbAUWVKQzk8
	f5CI6h+Q45YM5ZZ2OPpwwKwdMPrqIgHtfyjdwUqQRtNs12rKEFwEqSUJYPYhkK5c
	etdo/n7juWaZy5BcJ8GYnkFPg3k4Bak9Dxg7bLqUA8EC+b968NdivONxBK2kOuPg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwha0px-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 17:00:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFo24u1519780;
	Mon, 12 Oct 2026 17:00:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjp3pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 17:00:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CH0UTI28115626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 17:00:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC0C158055;
	Mon, 12 Oct 2026 17:00:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA52858054;
	Mon, 12 Oct 2026 17:00:29 +0000 (GMT)
Received: from [9.61.159.45] (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 17:00:29 +0000 (GMT)
Message-ID: <e49d400b-adca-463a-8ff8-a18c04617e9f@linux.ibm.com>
Date: Mon, 12 Oct 2026 13:00:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-3-akrowiak@linux.ibm.com>
 <sashiko-outbox-165448@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165448@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX0bjIR/c1M1IW
 +r/lNOb9l4pi+7A+LtKFc5ISrnLL+I36N/ZO8w954eWxHv1xljBL95L/CQw+hQJOjQ00sgjc/fK
 4bAEiwQBM6XIO6XUUQ5iJyl7rqNz8tw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX4zairLCsA61+
 /BXqQlBFO0/qdVpd668kKPi0GKz5IeA54bOSVE0xOSNawC3Y1jErn89b8tJ1H+32T4GDR3iCbRx
 yTXGo+X1GPzhRB8kToCQifsmT+D/Ct4OLllkdePLso4jOWf9luGhOkJ/XFQejpzh9GjIk3bt9vw
 hL3ebTocbXbrvn+p2WEcWNJIIyqD7fMFZA865wrqBmmfB/0JcYuamM6+KPbE2gOonBVqpXzW7yQ
 7aT6pEmFbDXg5DlnGPLWf80+g4X7VZurB/J3jzten/b7Ve/2BLiCorMR+TCUbfYDa8fwKuHkMSV
 MP44nZFYFY8ilrN8aQGcdM/XHSEtMHQVPOWVJrIwc1Jirj5uoO/GvO307f1f9c2VkAzb3KZz4LS
 Sg4SPTX/Ch1i48y9e7Sgrs+n08/rgoVbpUy8nmFWnBaXjF3r6C3rQyGTzdLlaOuiteQnA2LPOoE
 enOmKPb1+jhS/8fegtQ==
X-Proofpoint-GUID: -DIw7c5c5xv4bbVn7J6Gs-6gOij4Ez8n
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acd1230 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aZccLKEs_VlgDMQ2Sr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -DIw7c5c5xv4bbVn7J6Gs-6gOij4Ez8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120066



On 10/9/26 7:55 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] vfio-ap: migration ABI layout depends on internal kernel macro AP_DOMAINS
> - [High] s390/vfio-ap: missing interrupt state in migration ABI
> --
>
> commit a77ac9d23bc32798a481b033c179b8862ae321e5
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Data structures for facilitating vfio device migration
>
> This commit introduces the data structures used to facilitate state
> transitions during vfio device migration for the s390 crypto subsystem.
> It adds the foundational structures for saving and restoring AP configuration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> new file mode 100644
>> index 0000000000000..f76d151a5ccec
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> +struct vfio_ap_queue_info {
>> +	u64 data;
>> +	u16 apqn;
>> +	u8  reserved[6];
>> +};
> [Severity: High]
> Does this structure capture the necessary fields for interrupt configuration
> state?
>
> During live migration, the guest's saved_iova and saved_isc appear to be
> dropped as they are omitted here. After live migration, will AP queues on the
> destination host have interrupts disabled because the Notification Indicator
> Byte (NIB) address is not restored, potentially causing guests waiting for
> crypto operations to hang?

On the destination host, the queues come up with interrupts disabled. The
guest's AP bus checks the IRQ state reported by the hardware each time it
processes a queue (ap_sm_read()). When it sees interrupts disabled, it
issues PQAP-AQIC again, and the destination host handles that in
vfio_ap_irq_enable() using its own NIB pinning and GISC registration.
Until then the AP bus polls rather than waiting for an interrupt, so the
guest does not hang.

>
> Furthermore, since the 6-byte reserved padding is too small to hold an 8-byte
> saved_iova and 1-byte saved_isc, could this prevent non-destructively
> extending the ABI later without breaking compatibility?

This vfio_ap_queue_info is contained in an array in struct vfio_ap_config.
That structure has magic and version fields which are checked during
the RESUMING phase of migration. These fields on the source and destination
systems must match or the migration will be terminated.

>
> [ ... ]
>
>> +struct vfio_ap_config {
>> +	u32				magic;
>> +	u32				version;
>> +	u32				num_queues;
>> +	u8				reserved[4];
>> +	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
>> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>> +};
> [Severity: High]
> Does relying on the internal AP_DOMAINS macro here tie the migration ABI
> layout to potentially changing architecture limits?
>
> Since this struct is directly read from and written to the migration file
> stream as raw bytes, if the AP_DOMAINS macro increases in the future
> to support new hardware limits, wouldn't the size of the adm array grow
> and shift the start offset of the qinfo[] array?
>
> This could silently break migration compatibility between older and newer
> kernels without a protocol version bump, as the destination would read qinfo
> elements from the wrong offset.

AP_DOMAINS is an architected limit: the APQI is the low-order byte of the
16-bit APQN, and the CRYCB ADM/AQM masks are architected as 256-bit fields.
It cannot grow without an architecture change that would also alter the
APQN format, and with it vfio_ap_queue_info, which would require a version
bump anyway.

>

