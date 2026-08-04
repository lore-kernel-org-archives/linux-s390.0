Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B031F99B;
	Tue,  4 Aug 2026 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873476; cv=none; b=BHxDDPuWH+HqU+QLwqiktuW9UDd/bq3NQyalYTbwh5WG7y7D/4jeakrk24zOXwfVA3445iG4Q+8n8x1qs4GP4rbx3EaQ+mfKzdL9aolEe2hBfbfeEqXz4Lav2yQcAwfGrm8CNplg7dYazIx54f2e1VS4jzBTr5e9eSiPWtgciDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873476; c=relaxed/simple;
	bh=G3c42QNT69hdDNPQyXUvScdW6KhSXKl64YqUReQxUvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXQrHYVhWFLF/5aW//mowm9n7eTwIPzOWyvAwK8DPrhwXj+SgRMuKVUF6kie6OWGQKXmOKihbpM3rTY+B5reuiDW9Et3vzp/k74oQmHZA4+l9de1aFsaQlG65UrhkAPBsPOJO+g1YNNpUOKP39k1sOU0mKTcgumLdoVPp2IHgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EgDUdLEI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EgDUdLEI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JmXWO4116455;
	Tue, 4 Aug 2026 19:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qLppjq
	4kr6zhlfFvgJ4Tb0MDK6NCpw0tvAvHlE5evCA=; b=EgDUdLEIxX5ykF1JXfvT8Z
	wlUMvDY/f9o8y/vehIKCWMMytqya/kYaEXdCcjus4yEsZrBEfSqDAjIOUFGec+eW
	jYmn9JM5NBu5qITxhEyn8vQQMpqm9MwhhM6DDthCJfJ4NGwB2uIHfFjBgF/MotOo
	IrRD0fuaEa2T0zl3agOlkxsBTnsCu5EjY4R30aJyy6omUq3BS7VPOuh8k+W+ITg3
	ep9eBfZuWUMdlqHTm4sjGVCqzaixwOf8k1lCuIhuT68g8fvBH3RcovD/SNhuTJ8m
	fuahgO0/Vh2jqmDwrNqtUt2OJAo8G8ebZnbks35yVT9tVUMVE/0xaLeQ37qNSdyA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqqnwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 19:57:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674JugC2024765;
	Tue, 4 Aug 2026 19:57:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qkp7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 19:57:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Jvjem61473062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 19:57:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8635F58058;
	Tue,  4 Aug 2026 19:57:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93B1F58057;
	Tue,  4 Aug 2026 19:57:44 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 19:57:44 +0000 (GMT)
Message-ID: <20c2f649-10d7-469f-94ea-02cfeb767c1b@linux.ibm.com>
Date: Tue, 4 Aug 2026 15:57:44 -0400
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
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-3-akrowiak@linux.ibm.com>
 <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S1qkl2IYLwe5drhoukdIK9aTtss7I3Gy
X-Proofpoint-ORIG-GUID: S1qkl2IYLwe5drhoukdIK9aTtss7I3Gy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX1pqhoRs4zuaD
 oZj6+NgL4IbPBMek9/parsLXIFtsIeWZRl1VKf3i+/VATScAcMLaSFuGlzS7IKgFsInpFwGhnXR
 MOxIykjoDLmG/OwKny4gIsu2nXdfpeg=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a72443b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MdEa33EV34lG5rOqodIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX00t/a+XkgP+A
 f6Sx6vDblxtFC1nsXxjfJAxHRoNYvXM8sxnQeqMXs6DpN7vTkV8dLniuL/kxoK/CwG9rAy70AZW
 YauHQaCNC/hqUdOll9d3kQrEgmHvOIeKJ8PeYqAFsTC3UgWW2Q88g/90PKyqPOzFjX8CC2r5qHz
 psTkBhPu+dYyBk2U8bh1xT2r3Vm/krNNcZX3uyWWxXmEktO9m3GLGkDrPIv0bV7lOFJxmfmGLWi
 DXKmQusmH5LKDGrdtKMONFOb5T+pSMln3AkE9PE3Tei9LzOGNydUWoZ3It0Vb1krHFhcMjEJgym
 wKplhZ09fAewNbM6Kaww9ZCVFvSr55Dg488EBuIcVQxnPTzSwSAqlBnjmEWzEi+enYlXcrwwW3I
 3sGFicpHeIrBD5PlcUfsCTIDnbezDNRXIw5Io0THG2qmqwrPg4OtswjRZZe4CQZf6BtRua9xagi
 JlgGjO+LxTC/mmllgDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040160



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

The next version of the patch will incorporate magic and version fields.

>
>> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>> +};

