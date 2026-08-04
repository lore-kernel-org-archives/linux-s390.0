Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3C39E9AC;
	Tue,  4 Aug 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840002; cv=none; b=liP5R3S4H+ASHzwS/huYat4uEXB9F3ZuZpbkeYDOGWU07uTevl1o+UnZUMKJcvbNKbyxnrgzClxwxxrvzjO33I+BlF8sWvSCjJRYX9pDMLavFAa9BJI5M/sg9P0e4IENzalVfXezsV2EjtYcAStvOuRV8gIifeV2eMmluUQO8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840002; c=relaxed/simple;
	bh=fKWN6V0Q9N5px75unrB4B/fWKbFtLw3p7+tDcsnUnqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5GGLQl/P/wHB4VKL8u6RU2vHCVHQrF22qBKzL5XP9v9l3WgQEnJZ1I5Ko/DqDQo0IxRVF08roV4bVT2wMAXRwcSCfule086HfibO5bltxaCe8JGz21hGFK7ztycbo7i2rK/t4S0I8F93lU4S1vK8Gurd3QvozT3o3QeImULXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kuOC+eYu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kuOC+eYu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748Hpbl236709;
	Tue, 4 Aug 2026 10:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UMMXhY
	Of+wW/ruaRSt6BoKW327uNc0wmFNYIysQQqgI=; b=kuOC+eYuxmF7yNg+BIdUz/
	6Nmw+rco1F6wF8vDWRLFiZ9JOpurWDNlb87UKYrc4haCD8MmtWZIR2Kni6sla93e
	7fnidbYkaGlRUrgwMPSZCRX8b22UulcHEDUZS8ltG+jn9Nc4t8Nsk7uYhKfwS0Vx
	k25YR+Vy/mK4sp43rCQGlB0qe/kds5YqdbSmxmjEW3RsDtBHIjfuH30ulw04C5a+
	2XvHsk86Y/nL2SuyuavzTw7q47UGH7C0bPQppDrFsA+JlRs7+Q8evHTCEPfCjYoN
	Dbp1OvAg1AtP7oYJTWsfjzn/xvnHnIqpCRdzECk4QjkxusypV9Dmrd/m7Ep14YWQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g54p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:39:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AQFBg005284;
	Tue, 4 Aug 2026 10:39:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9fwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 10:39:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674Adu4263570184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:39:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DABD258061;
	Tue,  4 Aug 2026 10:39:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E09B5805D;
	Tue,  4 Aug 2026 10:39:56 +0000 (GMT)
Received: from [9.61.89.119] (unknown [9.61.89.119])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 10:39:55 +0000 (GMT)
Message-ID: <84841aeb-876a-48e1-b4dd-1207320a812f@linux.ibm.com>
Date: Tue, 4 Aug 2026 06:39:55 -0400
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
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-3-akrowiak@linux.ibm.com>
 <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727174014.E83231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4MSBTYWx0ZWRfX0GDzVkwaJRhF
 GESnECZNQqSbfC0P1YTS1nOrRJ3zkT3/NHD5mXGxsQGBGRzkAZLDTTn+Ihv/xWIEjgapx2pR99k
 s/gOGOKnnGKIPAXG+9/QWiYi+nJrDmIDd2Qdnq4eYEDZjFdNXecXcAJGxYkxJVkPTsibyMDJO2/
 Int/i6H9Ny5lhnl9npBB9Jiu543H405bIP9DP2+P8G0Gin8HGFU+fDQwCj4iGj1RpckiV5Ah3LS
 dsDC7n+e9NlPniiAOHVYxHXbyDTBFckFLq3h+e4GPhPh+8ArWe3r/sZOHNldn2zM7y/X0lZVTFI
 fK/Zp0jHJZtm6gXtOfgGRafU5srLeqW5zlVlfEMD+zgkkuxOTDAD2y8BJpZwnlKBAL26FOyq+6R
 BGFO9UL0kg0stO8/E7GGeL8ONhpm0gqSW2ymtQbrT+JU1Ro3yxkLoiDr+r3ZA/gqdD56RFFKIwY
 TXFFZOkjK954/pAL/5Q==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71c17f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=MdEa33EV34lG5rOqodIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZlPgxQpxYBrwjrqKVaGxSNy6uD8WlFyt
X-Proofpoint-ORIG-GUID: ZlPgxQpxYBrwjrqKVaGxSNy6uD8WlFyt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4MSBTYWx0ZWRfX2yoOxRjKu6+D
 cgmbs422WAQ43EV50lE86WdxqHX9he9EPxsauDxA+X2edcIAhM5eyMXVjJfUKZPXlmdPxBBFta5
 MEmbjIwQP1YEjONlyCtbzTec3DEMkzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040081



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
>
>> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>> +};

