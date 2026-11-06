Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977309;
	b=l0GfUD0s+W6lk9Sl/i46rQRsz1BHwcRthZFHlrSCiwbs7WKCdWOCQAXCD2mY6CB0gN5O
	 aXAPh0wfhstx7AEYvh2nElTPArhKGGJRAjTFm3bVKHCSv3NddNaM2zSMu9cLvH2jizs69
	 f84ZUP5D8CtmB0R+iZoY++HAru50+tNa5lwf33XeOlbksMXwQ7Wrhw4GXPshDWfCG/0yS
	 h41d0RuOQqARlSgyvN041FUFBwSrxj/6Zk7c7ucM9oVIDY0AZDff1oFZUxx9bxsZFRNN8
	 jykdGDLAcQc80/Y+5pY30vbbidpfzPf980man6ke170Gcm9iDDtRZW7t5aIXCzyJRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977309;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a+5V2TWWjdIGM55phHUzPvi/R6Wf6wFpaSva/g6FU5w=;
	b=Gct82dYZTBVdSVJXOTyFkVp/0rUmlr87OoONsM5L7YXEWw/lk9O4gRVr0nrqbJPy/vkZ
	 WxI2Q0bRdoW6oolRs8oCbTH33VGsTNnlkhBUNPyQNa6b6Z4GfRNuaP7WaKqQrI4CrRt1B
	 3FRZBf6g1TWnF9EsggJMhDV78ZXjIUKUaruDDmgFgNMJ4esD6vuMCoZdJ7gJlKUJ9RTJV
	 rZ+bx3OQ88n8bjJFWaXlPy4qJ2tudMEfN5EosUXMAPVJNqcJVc1nMpgnz6PwFPYGETA3e
	 4DtYxS3+DMWx1bFdPbqUKqXoA56mpuKYE6iixLugHpm/CrVWCsNKTMdH1ZeJfKhWm1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KDAmkwJA;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8782606A326;
	Fri,  6 Nov 2026 15:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8782606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KDAmkwJA
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EiCRY2644635;
	Fri, 6 Nov 2026 15:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a+5V2T
	WWjdIGM55phHUzPvi/R6Wf6wFpaSva/g6FU5w=; b=KDAmkwJA6GWdk4zhYTbN0v
	fWq1O/noiMmC1YcznmR3XY/eoqcgruirkERFaaGqxMjLeam9BnUaoSpM7VKandBh
	JsOa5GWRSPJK+6N6poOh9WbgTswqB5nVMYV3BfIQoMIBHLva6+HdiD1RL9F/jvxJ
	9Du/FWWPg9HZZyCIqTV5mg3SH+5Ff/NRRc5q69jAzJEWllIW3YAJL23bY8s5ltfy
	mhINBUdXJf0IllS0iJR8WFqQkr/yKYXyhJffY+tc5SnS/nVO82KNCjpOhwqL6lSj
	8OUsYzMbBc9hl7dHeinX1Pe/bErgLn42Km7Lvu7K2lR2IOTHebl4mI31DffJRQxw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9518b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:01:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EZ6i23578419;
	Fri, 6 Nov 2026 15:01:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7u5nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:01:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6F1ixk65864072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:01:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4EE58068;
	Fri,  6 Nov 2026 15:01:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A27B5805A;
	Fri,  6 Nov 2026 15:01:44 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:01:43 +0000 (GMT)
Message-ID: <0ec8976f-beca-4070-825f-1f828cecbd35@linux.ibm.com>
Date: Fri, 6 Nov 2026 10:01:43 -0500
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
Subject: Re: [PATCH v11 10/14] s390/vfio-ap: Transition device migration state
 to from/to STOP
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-11-akrowiak@linux.ibm.com>
 <sashiko-outbox-193825@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193825@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedebdb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-kYsNA629sg9qs7RJlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mhXcRIpuLNCY1qhQvrXtfVDI2mGbSLn9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfXyhQFWCxCqNfD
 o+42zbaQd4GcIxDDtMdU95PzPCqv7LyGeLyQhUDgPKGFcS6l9l7aYo4YKlWwT+NfBZ/clCjLBwd
 Z+EBCVnVv0g06lSPYa/Klt6FXsu5mCAfNQRFBiNqviuL9Xec0bzafmQ0flK9O4KJbNZkRJZd86B
 VIz7R0oGpox+hEpUmoHiQf3xs74fTU40MbRtp9dOzxrnG+vQdcZM3RQkGTIduz34BPII4xxfZ9y
 twP39bqnlQl9eUUYuHKzxidsnIS1HmK2/uohxSWAOcnFF+zWZMBC7m3Jxu3Od8NKbOQqofNlgNC
 IY4f40CfF+fCh0iwhxfdSv5BRPfGZ9NIxPQdfboFoMVCkf4ErmTZ88g8B9XMqzDinR5TgVTQDQP
 KzJNhbwGI27kktZJvR0u2ITZSWqJxf0uKA8nLqS3EDI2lUncIT419VqUD3zOw5PbGvPFZbQ0P7h
 8y4rXsOJ1EyypbGiDDw==
X-Proofpoint-GUID: mhXcRIpuLNCY1qhQvrXtfVDI2mGbSLn9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OCBTYWx0ZWRfX8HQ4JgfXikZE
 xnOZPoI1D44nHzwo5kgq0P/51e3KCV6XeUXQ5HEJHkcHd2KN0p+9fuUMQqERgPE0K6F2UExdsHV
 scYLK/sltV+dNloUYxsirnM999m76rg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060058



On 11/2/26 12:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] s390/vfio-ap: use-after-free of mig_data when device FD closes before data FD
> - [High] s390/vfio-ap: fortify panic on chunked writes in vfio_ap_resuming_write()
> --
>
> commit 6775fb7f340ff449dd183124e50a9831181c55db
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state to from/to STOP
>
> This commit implements the VFIO migration state transitions to and from
> VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state(), releasing
> migration file state when leaving RESUMING, STOP_COPY, or STOP.

All concerns expressed below have been handled in response to review 
comments
in several other patches. The fixes will be in the forthcoming v12 
series. See
my responses below for details.

>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 47f05e43b9e0e..c5534c6ee3cef 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -1170,20 +1172,46 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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
>> +	}
>> +
>> +	/*
>> +	 * Terminates the transfer session of the vfio-ap device state from
>> +	 * the source guest.
>> +	 */
>> +	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>> +	    new_state == VFIO_DEVICE_STATE_STOP) {
>> +		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
>> +		return NULL;
>> +	}
>> +
>> +	/*
>> +	 * These states indicate migration has either not been initiated or
>> +	 * has completed and the vfio-ap device is operating normally. Since the
>> +	 * vfio-ap device does not virtualize a DMA device, there is no internal
>> +	 * device state to incorporate into the vfio-ap device on the target.
>> +	 */
>> +	if (cur_state == VFIO_DEVICE_STATE_STOP &&
>> +	    new_state == VFIO_DEVICE_STATE_RUNNING) {
>> +		vfio_ap_release_mig_files(matrix_mdev);
>> +		return NULL;
>>   	}
>>   
>> -	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>> -	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
>> -	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>> -	     new_state == VFIO_DEVICE_STATE_STOP)) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +	if (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>> +	    new_state == VFIO_DEVICE_STATE_STOP) {
>> +		return NULL;
>>   	}
> [Severity: Critical]
> As reported by Sashiko on v5 [1], with the transitions to and from
> VFIO_DEVICE_STATE_STOP enabled in vfio_ap_transition_to_state(), userspace can
> now enter VFIO_DEVICE_STATE_STOP_COPY or VFIO_DEVICE_STATE_RESUMING and open a
> migration stream file descriptor.
>
> When vfio_ap_open_file_stream() creates that file descriptor, it sets
> filp->private_data to &matrix_mdev->mig_data->stop_copy_mig_file or
> &matrix_mdev->mig_data->resuming_mig_file and pins the registration of
> matrix_mdev->vdev via vfio_device_try_get_registration(). However, Both
> stop_copy_mig_file and resuming_mig_file are embedded inside struct
> vfio_ap_migration_data (matrix_mdev->mig_data) rather than struct
> ap_matrix_mdev:
>
> struct vfio_ap_migration_data {
> 	enum vfio_device_mig_state	mig_state;
> 	bool				resuming_mig_data_complete;
> 	struct vfio_ap_migration_file	resuming_mig_file;
> 	struct vfio_ap_migration_file	stop_copy_mig_file;
> };
>
> When the VFIO device file descriptor is closed while the migration stream file
> descriptor is still open (including during process exit, since close_files()
> closes file descriptors in ascending order), vfio_ap_mdev_close_device() calls
> vfio_ap_release_migration_data(), which destroys the mutexes and frees
> matrix_mdev->mig_data:
>
> void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
> {
> 	lockdep_assert_held(&matrix_dev->mdevs_lock);
>
> 	if (!matrix_mdev->mig_data)
> 		return;
>
> 	vfio_ap_release_mig_files(matrix_mdev);
> 	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
> 	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
> 	kfree(matrix_mdev->mig_data);
> 	matrix_mdev->mig_data = NULL;
> }
>
> Doesn't this cause a use-after-free when the open migration file descriptor is
> subsequently read in vfio_ap_stop_copy_read(), written in
> vfio_ap_resuming_write(), or closed in vfio_ap_release_mig_file(), where
> filp->private_data (mig_file) is dereferenced and mig_file->lock is locked or
> unlocked after matrix_mdev->mig_data has been freed?

In v12:
The lifetime of mig_data is tied to the vfio_device registration
rather than the device FD open/close cycle. mig_data is deallocated only in
vfio_ap_mdev_release_dev() after all open migration stream FDs have dropped
their registration references. On device close, vfio_ap_mdev_close_device()
resets the active migration files (clearing filp) via 
vfio_ap_reset_migration_state()
rather than freeing mig_data. Any subsequent or concurrent access on an 
open
migration stream safely encounters valid memory and returns -EINVAL/-ENXIO.

>
> [Severity: High]
> In addition, with VFIO_DEVICE_STATE_RESUMING now reachable via
> vfio_ap_transition_to_state(), can chunked writes in vfio_ap_resuming_write()
> trigger a fortify_panic() when CONFIG_FORTIFY_SOURCE is enabled?
>
> In struct vfio_ap_config, qinfo[] is annotated with __counted_by(num_queues).
> While vfio_ap_resuming_init() initializes ap_config->num_queues to
> MAX_AP_QUEUES when the stream is opened, vfio_ap_resuming_write() copies
> incoming chunks directly into ap_config before checking whether *pos exceeds
> expected_sz:
>
> 	ap_config = mig_file->ap_config;
> 	memcpy((char *)ap_config + *pos, kbuf, len);
> 	*pos += len;
>
> If an earlier write chunk overwrites ap_config->num_queues with a smaller
> value (or splits the 4-byte num_queues field across two write calls so that
> its upper bytes are zeroed first) and a subsequent write chunk writes past
> sizeof(struct vfio_ap_config) + ap_config->num_queues *
> sizeof(struct vfio_ap_queue_info), won't fortified memcpy() evaluate the
> updated ap_config->num_queues and call fortify_panic() before the bounds check

In v12:
The receive buffer in struct vfio_ap_migration_file is tracked as
a raw void * allocation (VFIO_AP_CONFIG_MAX_SIZE). Incoming write chunks
are copied directly into this raw buffer, ensuring fortified memcpy() 
evaluates
bounds against the full buffer allocation rather than the dynamic 
__counted_by
bounds of qinfo[]. Validation of num_queues, expected_sz, and the full
configuration is performed cleanly in kernel code once the complete header
has arrived.

> after memcpy() is reached?
>
> [1] https://lore.kernel.org/r/20260724182949.EA9C51F000E9@smtp.kernel.org
>

