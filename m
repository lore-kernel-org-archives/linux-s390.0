Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBB31F995;
	Tue,  4 Aug 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840593; cv=none; b=eS8ssS+SgLvX0Cevz6COteIsJezxpioRrvnLocCXvKVhARbi83lc9hSZIJ4/9pP4WS1XbF6Bpf7vcR6GChSTXC263UptYdDuKnznwP2v4jb1yUqgbjRDKYEF5HlmXCCFnUjzISvCSCzYBVBVM0+GshKVYFmLGlBzpUvBsRF7Qa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840593; c=relaxed/simple;
	bh=KD9VCIcQkSM8zKdO3tZVGg8xj6KxViKMA32KyxDf4Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrWoDO93dt0EE+DKcZjyy1Q/pztz+rjgMUZGSzssP13W3fZftYN8cQHbGXG+glR7xs2LOki4dlrVwPF3srWlbTwSInzsrv2iGreWI6JZ1hN6kOus2RCiDhvmHN5dVPKpddCHzwI9TqbYsoaNmXm2clHBv3vUuztPWjMy53olKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SyIphgvZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SyIphgvZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HYHK323748;
	Tue, 4 Aug 2026 10:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pBEgex
	hAipZeVO6mAKS9pwHLXOUZrWxtgHwQMlCESuA=; b=SyIphgvZ21Mj7Z2qKpmnom
	nRUYjzfrrTDMBkstFg0RkPPticwD93lk0hodh9Biza7OwWlRwlX8JIgCRS4iOQD3
	ZNi2rV4vVp4C/iNbPtOwrJJC5YghZfi5TJqg40iKT2MNjBWHREm9cUKGG6TFzHI9
	syErOHxQF8dyoinVJr/X0AjmlSm1J4rCbJTBxfuDczTcmZ/Yy/9FYCB53TnxRPps
	+Q2EiqR+qIEHCaxOeIHVoJ6e4UaYPtX2hdSQRvyUeT4Y4Dq2Vb92KPKQhYzoBvR3
	8o5tnorCZgwT5I93MAAz8/1cKRtJcU8k8VBD1uUiYKU8LKjSPooRS7qHG3SADaZw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4we19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:49:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AfIaZ022440;
	Tue, 4 Aug 2026 10:49:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9grg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:49:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674AnaZm24445560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:49:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37EF058059;
	Tue,  4 Aug 2026 10:49:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACDE58058;
	Tue,  4 Aug 2026 10:49:35 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 10:49:35 +0000 (GMT)
Message-ID: <f3d5d78c-1992-4027-a1a6-345b76b5b14c@linux.ibm.com>
Date: Tue, 4 Aug 2026 06:49:34 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-3-akrowiak@linux.ibm.com>
 <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX0hhQMqoj0v0/
 lyC8Mk6JQ8X7AVyBfgkA0aL6Wrl6LGiOaN7zlu+XnwcK+x1QEpYx2j/hSfruhGaDbJ5TyzG5GRM
 2PredeTMsnZUk5NWvaWPvkyOAYk8u+c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX2Xl6yXL8QBlY
 pVL1QJEdbXPY/zoMu9fRDHlIOHnmeo+mHSmgeFZ2/FcPH7536azoQB7U7x+g3bPZyyU5KWjZ+0+
 TIEsIjnmNzKl7sueqOhVvi6xUSir2Eiw8AGaRjImZXJGUsN1LWwixrHX4kY8POHGzwZgodbIWLw
 LcF0ptscEcqSmFaxMGh3+IX6bz9FmnGLTioSMCi16lfRzdAoRgOOYJl4Q4/pRfUcb6C+EhMtuB7
 8ZH+ao2a7nL3uCukL45t55nkexr8y6MCmhm9dJvz3nfuE9Az/jFjYUmu6X/OEYauMdTcOJTuGt2
 zJ5gnvhtW60qbJrQVRjePqUp4z0KuiRuxUnZaKAoLR2F6BxiZ/rJgBts+nEZ9oEtIQY2eGTOcwl
 FJCoIvSMFNnkWGvZlrV4gSp7uDYct4pyA3ephWHEMXh/nsEveuP03l0vrVGSSwjuPLe75BTJGZj
 0DeM2Jqqg2L9nqp76mQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71c3c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MdEa33EV34lG5rOqodIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WJpJ4pT4CAY8v9Zox9EB6HFrRWdXcvgN
X-Proofpoint-GUID: WJpJ4pT4CAY8v9Zox9EB6HFrRWdXcvgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040085



On 7/27/26 1:40 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The VFIO migration data structure lacks a magic identifier and version number, and relies on an architectural macro for array sizing, posing a risk to ABI stability.
> - [Low] Typo and grammatical error in the docstring for `resuming_mig_file`.
> --
>
> --- Patch [2]: [PATCH v6 02/15] s390/vfio-ap: Data structures for facilitating vfio device migration ---
> commit 1aa240c81b915a9ce3e59c82c532c41c1cab4d99
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Data structures for facilitating vfio device migration
>
> This commit creates the data structures used to facilitate state transitions
> during vfio device migration.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> +/**
>> + * struct vfio_ap_migration_data
>> + *
>> + * Manages the migration state for the VFIO device that maintains the AP
>> + * configuration of the guest being migrated.
>> + *
>> + * @mig_state:		the current migration state
>> + * @resuming_mig_file:	the object used to restore the state of the vfio-ap
>> + *			device the destination host:
> [Severity: Low]
> This isn't a bug, but there appears to be a missing word here. Should this
> say "device on the destination host." instead of ending with a colon?
>
>> + * @stop_copy_mig_file: the object used to store the AP configuration of the
>> + *			source guest for transfer to the destination host.
>> + */
>> +struct vfio_ap_migration_data {
> [ ... ]
>> +/**
>> + * struct vfio_ap_config - the guest's AP configuration
>> + *
>> + * @num_queues:	the number of queues passed through to the guest
>> + * @reserved:	padding to ensure proper alignment of @adm
>> + * @adm:	bitmap specifying the control domains in the AP configuration
>> + * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
>> + *		queue information for a queue passed through to the guest
>> + */
>> +struct vfio_ap_config {
>> +	u32				num_queues;
>> +	u8				reserved[4];
>> +	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
> [Severity: Medium]
> Does this data structure need a version number or magic identifier to safely
> handle ABI stability across host migrations?
>
> Since this structure defines the binary layout of the migration data stream,
> could changing the architectural macro AP_DOMAINS or the structure layout in
> future kernel versions silently break live migration compatibility between
> hosts running different kernel versions?

Will add magic and version fields an check them when userspace sends
state data to the destination host (RESUMING phase).

>
>> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>> +};

