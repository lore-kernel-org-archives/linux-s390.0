Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54445FFBA;
	Wed,  5 Aug 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932139; cv=none; b=LF//V82Y7yW6rBOgzilOYCyvLa/ON/2/sYsSBi/hLHgmqvaN6G6nVreRM8YBpSEg6J1zPJhGtnUuNQgR8vWF/5UW87wCYYrUPVkFcYcfeeYUxlaj0Zw23wCKzMMLD6TVwuVUxPm4XQYhf+5vJrDhhKDuXPUgh7xlw6O+lRstUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932139; c=relaxed/simple;
	bh=1DkROhmaR+pXC8VkL/LRwgur0QxU7+TQqVW5StmNCso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqVf6TuLlflb67L14VRFtGo27xBYWQpwMGNHN83EX+7E+YOCJixmYcYyWOFWOzoC5KHm0o3nTiCMuepFbm0Yr+NDW3olmxkeAaStibWSx1VAsxgtFCJuXnl6AIRGDgu6pFTIvbCJwBvdvuJl6PyT1NrwAMQ0EQrpc9J1qLwADhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lU4mMfMH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lU4mMfMH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lgEn3387340;
	Wed, 5 Aug 2026 12:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CIoARI
	x9ftx+Rl0XU3vnocx4qM7owdhEwvFSj3y1H4I=; b=lU4mMfMHFjbsCzkf9eBNDi
	0NOBptpp3x5RmlDeuC6qXbQ5C19yl57X4EUo8/ERMiVr/HdE8q8iKPhgYPLqG9FN
	5s4I+gIFoCNZlercMcfiI01yoaP4V1DN6ZUngbrU5uHHWt+s4cIp/gswt1R1KtJd
	ex1liBCoU93ZNAz/rQRf5SpcKso3PYAWRlueHycJa+dZ4hUd5laAQXRZTmA5/F7n
	MPRT6ZFHI/GhoXtF+uORGKyOXywr27ZAlKV/Ax5v9iv5EibaxUgs11PxAtjTxmA4
	YXs86Dws3/IGFEBPGlJeCCrB3PcXTda0ypzA3V/8QSVBTGo9Z9iRTuac0jMxBUvw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52wpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:15:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CBE8j027240;
	Wed, 5 Aug 2026 12:15:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6j9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:15:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675CFWur29295194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:15:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429B05805C;
	Wed,  5 Aug 2026 12:15:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D95858051;
	Wed,  5 Aug 2026 12:15:31 +0000 (GMT)
Received: from [9.61.13.108] (unknown [9.61.13.108])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 12:15:31 +0000 (GMT)
Message-ID: <90163962-2d85-44c0-8793-4a532c79046f@linux.ibm.com>
Date: Wed, 5 Aug 2026 08:15:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-10-akrowiak@linux.ibm.com>
 <20260727181117.766031F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727181117.766031F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfXxEw6uum+RwGr
 J1p9fBgycAbgCjjB7oGg4+RhTfdxst3Raw/OY/srNex2RcaV0nl/JobbhfjBW48gEy3r+vKN6IB
 2SoA8ovtWZMSresNM5y8CS5qtf4e030=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5NCBTYWx0ZWRfXyGbpQrRd5hGp
 8k5rYOn/mfSkBPLS5+ddzvQ7Ud1R4KvyhkerrCgu+Q2NVhbFfjrKunrJ5jMwh2aikZOp1GAOlZ1
 UZ+irh/H06TJEEPGcQTsSEPHOFEsRrIlrsFZ2ad6uXKoQgonZk0qOiPFkxNeCsCpxmZ97GCs3Fg
 cCBy9HX5VHxcssUJeu6j5Y8pHBDgGf5MxwugzlIMTxRA07L+2mNlu7Snnl6yq7HroNY8n2BVuQi
 tfqH/B0oYe5FqMemHqkSFNVdHibYXNN6SOfrOe52+xsevH6wQRWPycvFVCn+BAbsKR7LTvcBJNh
 3p+vs+VrJX4j9+hGGajJZujiQ7VTXQA5RIyvrKgFhyPWxRUycD60JzptxUx/6+ewjxpEiXgGYIE
 feN9FBdnHs50isniUBuMIwjzCr6YWSIfcjss1pSGs/fE1VX1exoRnqtaTBA64OFbkJgmQ2uGL1k
 x2TnE0AW6KD4tg2g/VA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a732966 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=7yNgoilTr2P9NN8D:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=R6EK23lPG6ft_yACUD4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cDb0ID4O_HEzE6SA6nzfWlzoC-CC3Km6
X-Proofpoint-GUID: cDb0ID4O_HEzE6SA6nzfWlzoC-CC3Km6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050094



On 7/27/26 2:11 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Latent NULL pointer dereference in `collect_queues_by_apid` due to contradictory logic.
> --
>
> --- Patch [9]: [PATCH v6 09/15] s390/vfio-ap: Add method to set a new guest AP configuration ---
> commit 5b979f09ef9429e09eace5977dabbd22cc832bbf
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add method to set a new guest AP configuration
>
> This commit adds a new vfio_ap_set_new_config function to set a guest's AP
> configuration. It refactors code from ap_config_store to handle changes to
> the sysfs ap_config attribute and support live guest migration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index d05372b50d2fc..0b49be22d5d8b 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> -static void collect_queues_to_reset(struct ap_matrix_mdev *matrix_mdev,
>> -				    unsigned long apid,
>> -				    struct list_head *qlist)
>> +static void collect_queues_by_apid(struct ap_matrix_mdev *matrix_mdev,
>> +				   unsigned long apid,
>> +				   struct list_head *qlist)
>>   {
>>   	struct vfio_ap_queue *q;
>>   	unsigned long  apqi;
>>   
>>   	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS) {
>> -		q = vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
>> +		q = matrix_mdev ?
>> +				vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi)) :
>> +				vfio_ap_find_queue(AP_MKQID(apid, apqi));
> [Severity: Medium]
> Will this result in a NULL pointer dereference if matrix_mdev is NULL?
>
> The loop condition unconditionally accesses matrix_mdev->shadow_apcb.aqm.
> However, the ternary operator inside the loop (matrix_mdev ?) suggests
> that matrix_mdev could be NULL.
>
> If matrix_mdev can indeed be NULL, the unconditional dereference in
> for_each_set_bit_inv() will crash before the check is evaluated. If
> matrix_mdev is never NULL in practice, is the ternary check necessary?

Every caller passes matrix_mdev obtained from container context that is
always non-NULL at those call sites. The ternary is dead code — matrix_mdev
is never NULL here and will be removed.

>
>>   		if (q)
>>   			list_add_tail(&q->reset_qnode, qlist);
>>   	}

