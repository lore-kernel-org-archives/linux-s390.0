Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291081;
	b=vkwxVBxhWuEP4SPYEq/EL6zx3gjCwLsPBr51v6D5xqpKlX+F2foxGlY3VngUVEmv5uvI
	 hjDynuCb7ukzB9Ghyg7EZnzLX5TFNd43tikzU5V91AK3iIujse5pYz5IEP/l+npZIH28L
	 vmuCEd3bsPyIC0QjwfWA+Z8OoMKGhkwaXburLfcvfYrxDRpmxfMwJLqxUy+mju5NGZgmi
	 AijLvUSvWhlnNRtMZfvtmahoBT8Q9DEYIqQASDCX0TOLscozHlWXJSjqUsWygBR0M+keT
	 gu9t/ncHFVwY/NaX0cpAPQnQ9uLBWB+OWd6YacwbwtvgPwR93JSIO7gK06sQxn4GMUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291081;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f3Iv67n0h/RtoMWTXaKdXkfHPf9zC2T3413gV6Ghbnk=;
	b=a+oyqlEEGthZIQYB6NH0j1lvtDXb03vg6aVqrXGZMGtUukUcnCUVIlZImQLD6FmqvnZl
	 11uFITNMG8nBJmpJWPNzF00Zt9fZQFwRQOpAdyf477URXEupl0N4LSuUXFBTXalfaTzW2
	 Fj37nl5CaJ+1592QhQ8cdZ7HLBmvPZoIU8GyjI4FUvFhkobjhZJ8HSa58KTBafv5ExjxJ
	 Sg0RVGNkInZ5Z6VFiACrau4VHQV+Djpl0FZR7XlmMlsS6TFZZYw7fNohrgmaf8tUrqN7a
	 wcWYi/Kl2uGwAvS2aaj3EbyMh+xxOQrAkWM22vKv1eQ+1xOBb5/9xevAM6Tjk/MUPnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=me1I9VFl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31B606A31A;
	Thu, 29 Oct 2026 16:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F31B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=me1I9VFl
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGECKT3505113;
	Thu, 29 Oct 2026 16:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f3Iv67
	n0h/RtoMWTXaKdXkfHPf9zC2T3413gV6Ghbnk=; b=me1I9VFloI2gtnUE5qaq9H
	3coN1a/mZkdhNDRkHVNgJM/m1u25c+O2DKkom/RkE5B0c6XdGNkyNRhTL1ElvECS
	wTsQyGL+svkc7vD4pOMj9py8VxviBWJpzPhhA2CqeiOgzu7vZnl71AWxNd+tod8A
	soxmKW8kSeZcoEJWoYCNwHUAnO8PeL14ZTaMcbmDv0m8UOKBXlRpUBUrDBDIqNTF
	4VYBZu/5jNfQ18O7gKEGCWv4rq7xkdavZe5G0jt59iiOT9wru7dAu+ZD1HsfEPlk
	+qVOf9Loj5AgWvTsf/8hE7idEgfjLQisMQy2pig3aj5cnqMspoPhS26avwIpQIsA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3gb61w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:24:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGK6PG2213992;
	Thu, 29 Oct 2026 16:24:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010s1xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:24:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGObDJ17039966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:24:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C19C58065;
	Thu, 29 Oct 2026 16:24:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E387658051;
	Thu, 29 Oct 2026 16:24:36 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:24:36 +0000 (GMT)
Message-ID: <b2bb16bc-d866-4600-b2bf-5ac71e22ced5@linux.ibm.com>
Date: Thu, 29 Oct 2026 12:24:36 -0400
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/15] s390/vfio-ap: Transition device migration state
 to from/to STOP
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-12-akrowiak@linux.ibm.com>
 <sashiko-outbox-183053@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183053@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae37348 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SMkZLCyNcYPAoy_AmJMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B8ZZJHv0w2aA4b7baDLtBqmvM-E2lYm3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX3HwoTs3FNYWG
 DuJsHPeeVc6phkWGyKIM95KIORJ7NJH0bQfLBNE6k5IJAAthgJEJ3huHB8/xLvrTQ4AnLlim/zL
 wlypfXrdymK0gzGB0ZI4pSCIC2gBMHEoZS2YjzDt0A9a3OVKO2KWRdVG5Y7HUwq63cSxVGhpTAC
 C8zBtai+rg9UUCd2ryiidPrnO9p57XIt/TCUbmllcAH4fOm6L6OLC+UtvkFNGOw4iUL2LErpi3i
 wZ/ek74fm5pM3C7x84lpJBCd6ogUYFa1kICWcM+oBwaMjMjbwcLaKCv+1hqPQwMeIdVV3XfmWwB
 hfXjIUE0ZLGHhcp8484v/iePxgLBGWVzEMN1eRB96ikaNmTHV2Xfx5NkUSr43CUHgkJneqIg9/R
 MByHlTw1mXa6j/aiu/tx36OkbdDH6qu0lVSHVLmrQeXQ+aGUk4ANckDLFtX8NEEcH8JgDSSZAJm
 yguwWQEfLFT5vggJz9g==
X-Proofpoint-GUID: B8ZZJHv0w2aA4b7baDLtBqmvM-E2lYm3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX1sNfOly6tuTG
 Jl2gSs1TDlAQlCwc9ddG2/RowaVHP0UI7RAvlJoT1AW0gVDKoF9/ruATnAk2PvxFFV47J8VBNl5
 xLnCvQGFD4qEFjulSalupcdmHLBORts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290063



On 10/23/26 2:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: stale resuming_mig_data_complete after write past expected_sz
> --
>
> commit d607b25bfceefded024b198c63db651dfdea7ce6
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state to from/to STOP
>
> This commit implements the VFIO migration state transitions between STOP
> and RESUMING, STOP_COPY, and RUNNING in vfio_ap_transition_to_state(),
> cleaning up migration file state as needed.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 469fa09ec9087..cf38407d1b157 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -1052,7 +1048,7 @@ static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>>   		}
>>   
>>   		if (*pos == (loff_t)expected_sz) {
>> -			ret = do_post_copy_processing(matrix_mdev, ap_config);
>> +			ret = do_post_copy_validation(matrix_mdev, ap_config);
>>   			matrix_mdev->mig_data->resuming_mig_data_complete = !ret;
>>   		}
>>   	}
>> @@ -1146,20 +1142,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   		return filp;
>>   	}
>>   
>> -	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
>> -	     new_state == VFIO_DEVICE_STATE_STOP) ||
>> -	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>> -	     new_state == VFIO_DEVICE_STATE_STOP)) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +	/*
>> +	 * Terminates the data transfer session of the vfio-ap device state
>> +	 * to the destination guest.
>> +	 */
>> +	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
>> +	    new_state == VFIO_DEVICE_STATE_STOP) {
>> +		if (!mig_data->resuming_mig_data_complete)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		/* Set resuming_mig_data_complete to false for clean reuse */
>> +		matrix_mdev->mig_data->resuming_mig_data_complete = false;
>> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
>> +		return NULL;
>>   	}
> [Severity: Medium]
> Can the transition from VFIO_DEVICE_STATE_RESUMING to
> VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state() still succeed
> after a subsequent write() to the migration file descriptor pushes
> filp->f_pos past expected_sz and returns -EINVAL?
>
> In vfio_ap_resuming_write(), once a valid vfio_ap_config of size
> expected_sz (with num_queues < MAX_AP_QUEUES) has been written,
> resuming_mig_data_complete is set to true:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
> 	...
> 	memcpy((char *)ap_config + *pos, kbuf, len);
> 	*pos += len;
>
> 	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
> 		...
> 		if (*pos > (loff_t)expected_sz) {
> 			ret = -EINVAL;
> 			goto out_unlock;
> 		}
>
> 		if (*pos == (loff_t)expected_sz) {
> 			ret = do_post_copy_validation(matrix_mdev, ap_config);
> 			matrix_mdev->mig_data->resuming_mig_data_complete = !ret;
> 		}
> 	}
> }
>
> If userspace performs an additional write() on the same migration FD where
> filp->f_pos + len <= VFIO_AP_CONFIG_MAX_SIZE, validate_resuming_write_parms()
> succeeds, the extra bytes are copied into ap_config, and *pos advances
> past expected_sz. The check for *pos > (loff_t)expected_sz then returns
> -EINVAL, but resuming_mig_data_complete remains true.
>
> When userspace subsequently transitions from VFIO_DEVICE_STATE_RESUMING to
> VFIO_DEVICE_STATE_STOP, vfio_ap_transition_to_state() only checks
> !mig_data->resuming_mig_data_complete and succeeds despite the trailing
> data and failed write(). Should vfio_ap_resuming_write() clear
> resuming_mig_data_complete (or avoid mutating ap_config and *pos) when a
> write exceeds expected_sz?

Same as response to patch 10/15

>

