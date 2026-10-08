Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAE3016E0;
	Thu,  8 Oct 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484886; cv=none; b=ps48q03azlkc297CfL6mwYU0Fl6GXVRS8rMkNZBFteuPMfG0gyrIt4Zr4ykglPbNDkDxvemimHqriR80JYspyE6xYIQX3ImUV7ttRMK/VZMQWEpUB+PdoDIYUDT0l8ihDdwQBc5DtNMCsqQEuD9ijbV0rXUnouE/T4//15NkiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484886; c=relaxed/simple;
	bh=HJElLEPgrxlOKP4JDi1XsKlwjqGpa/eQjSjfI9ETzIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAmfUviL7LLJuXxnQZ7d0px1D217/kKlM9o+4/GPc0kJGgTedt7MdKGBrua5wwOAfiEX6RY2BFoiXhQ+PMdnqmH0Fi9quS9n5RTRKJBlOoWbB5NM8zuVSfqwanWzyWX9l8ZqozLG5WpN9PoWBE4hU2ytntVGs/puQ/PW3X9sBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RB5XE1fe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RB5XE1fe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZPIs1967165;
	Thu, 8 Oct 2026 18:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VjB+T8
	NiG15SKjHWq50mGJ99+6LUOy/RihNh1Hh6Pog=; b=RB5XE1feyl3mvLrzth5nMV
	hFTwky30RW1LmN9dB0ufbABrf4s8hfMmNpbDmK3p4/l9ZiM2VrOAirPlo1LRCq/S
	FQ5niI3MFv1i3KJW6YBNZiVtlKK/iTj11g5D0ZdFkPMuHHGAOCRhnMn6XpqUU+K/
	eS2OtER72+Ta5GWIW/+yAwuWSicE3zREocMLu5NNzFxy4y08X12VqspC4JkiimgT
	uwz3WmqOOeV1HP7Sv8VncMZ31INgMkG8bVGLbNh1DXPtVCzVkukJHBR92+3NlDp7
	U/2y3tytS6gVj0FX7iruh4YzwWPdGrghUHUZ6pm84bLFY6vtV2qEA8MwBCXA6uJA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvdwda-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 18:41:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWfRe3802200;
	Thu, 8 Oct 2026 18:41:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek8wk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 18:41:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698IfL0829426320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 18:41:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69D7A58043;
	Thu,  8 Oct 2026 18:41:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECED058055;
	Thu,  8 Oct 2026 18:41:20 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 18:41:20 +0000 (GMT)
Message-ID: <b3795dd5-edb4-4224-bbf2-fbedf4601349@linux.ibm.com>
Date: Thu, 8 Oct 2026 14:41:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] s390/vfio-ap: Transition device migration state
 from STOP to RUNNING and vice versa
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-13-akrowiak@linux.ibm.com>
 <20260807224358.3A73B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807224358.3A73B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zsxkaa8F3nyATeuCBls2CZIAeC3LR4ws
X-Proofpoint-ORIG-GUID: Zsxkaa8F3nyATeuCBls2CZIAeC3LR4ws
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac7e3d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=U2A-_XxCP4O0_PdhgYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX/KsyDCcrJ05o
 X/lFOnFGezM94TmtFh+Cb9CozNx1IrTSUHBSQWs6AtEh0PSt2p7mCNPbZ+rvkLDHeBzILINcMLL
 bXGVhR2WJqewYeo8f2/1qlXs9Yk6iYzB8gci5Z/h6mFJIfTJRA1TeL0Y//1x+XAKzPX4xIoO4SH
 w3lXdWuhgxDmRnDi7F6NyzzaHMpctLzYspWuewiscT2EUEV1WWSa678zFyVlPRJFxijk5yx8SJG
 zzKilAQrrvPXrZVVaySJd7cI4K8OtXT1F81GM/CsN72fqkJ5jH6PY1AomftpRAmC/TquTZCXqPw
 qoM5aPtqfc8CMaCNx9AaEIfiorUf1o5tOR0aL2qLTVgAt6cHw+HZ6pPTmXIxhGDsmPeryTb/Vzn
 YcyrSagNFAlQJe/jqFSXSruhxt71I81vd2clNHq/t+AcNUBGVEf9Ei4F44bDqPHufzznk14mvXJ
 pC7e/y5YGKSuMDxrTgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX1Ul+a5Wh9Ww9
 VNui/ngS14g1N1r9/PQvIlxNOsdygh4+IlUMlivo4EmoouTB2KRCMvH2dd1cAOl4FMuGg+k7BBY
 AQiy76flndUJHdgsFH07rdylMHtqwAw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080074



On 8/7/26 6:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The vfio_ap_set_state callback incorrectly returns success when attempting to change state while the device is in the VFIO_DEVICE_STATE_ERROR state.
> - [High] Missing cleanup of the migration state buffer (ap_config) when migration is cancelled or completes without a device reset, leading to stale data on subsequent migrations.
> - [Medium] The transition from VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP does not actually halt the physical AP queues, violating the VFIO migration specification.
> --
>
> --- Patch [12]: [PATCH v7 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa ---
> commit 17303c3774ef0d4972c24647246d0a4f7d6c4f04
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
>
> This patch implements the state transitions between VFIO_DEVICE_STATE_STOP and
> VFIO_DEVICE_STATE_RUNNING for the vfio-ap device. It assumes there is no
> internal device state to incorporate and returns success for these transitions.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 30160e3dddedd..24955f70e13e2 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1524,12 +1524,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   		return NULL;
>>   	}
>>   
>> +	/*
>> +	 * These states indicate migration has either not been initiated or
>> +	 * has completed and the vfio-ap device is operating normally. Since the
>> +	 * vfio-ap device does not virtualize a DMA device, there is no internal
>> +	 * device state to incorporate into the vfio-ap device on the target.
>> +	 */
>>   	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>>   	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
>>   	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>>   	     new_state == VFIO_DEVICE_STATE_STOP)) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +		return NULL;
> [Severity: Medium]
> Does the transition from VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
> need to halt the physical AP queues?
>
> Since the physical AP queues are not reset (e.g., via
> vfio_ap_mdev_reset_queues) during this transition, could asynchronous
> requests in flight continue executing?
>
> If they complete, they might post adapter interrupts to the KVM GISA after
> the guest state has been saved, altering external state and leading to lost
> interrupts on the destination.

The vfio_ap driver's only role is managing the guest's AP
configuration (shadow_apcb). It has no involvement in AP operations
on the guest; the AP instructions are sent directly to the hardware.
Any in-flight AP requests on the source are part of the guest and AP
bus state that is migrated; it is the responsibility of the guest's
crypto software on the destination to handle responses from the hardware
there. No queue reset is required at this transition point.

>
> [Severity: High]
> Does the transition from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
> miss cleaning up the migration state buffer?
>
> If a migration is cancelled, transitioning from STOP to RUNNING now returns
> success but doesn't call vfio_ap_release_mig_files() to free ap_config.

That will be fixed in the next version of the series

>
> On a subsequent migration attempt, vfio_ap_stop_copy_read() will see the
> non-NULL ap_config and send the stale configuration instead of capturing a
> fresh one:
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
>      ...
> 	if (!mig_file->ap_config) {
> 		ret = vfio_ap_get_config(matrix_mdev);
>      ...
> }
>
>>   	}
>>   
>>   	/* vfio_mig_get_next_state() does not use arcs other than the above */
> [Severity: High]
> With these new state transitions, does vfio_ap_set_state() still handle the
> VFIO_DEVICE_STATE_ERROR state correctly?
>
> If a migration error occurs and the device enters VFIO_DEVICE_STATE_ERROR,
> userspace might attempt to transition to another state like STOP or RUNNING.
>
> drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_set_state() {
> 	struct file *filp = NULL;
>      ...
> 	while (mig_data->mig_state != VFIO_DEVICE_STATE_ERROR &&
> 	       mig_data->mig_state != new_state) {
>          ...
> 		filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
>      ...
> 	return filp;
> }
>
> If mig_state is VFIO_DEVICE_STATE_ERROR, the loop condition is false,
> bypassing the transition logic. Because filp is initialized to NULL, the
> function returns success instead of rejecting the transition.

An ERROR check after the transition loop in vfio_ap_set_state() will be
added: filp will be set to ERR_PTR(-EIO).


