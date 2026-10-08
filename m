Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A539395ACE;
	Thu,  8 Oct 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486522; cv=none; b=NkEvx6Pk/kFXEEtdx8Ferji7Hv5Kx83Kyvl+CY3WMBwbA33Wqe8LIj6zNz5QHPWewOsDNyFqhTtBSu9f3RANZq2n4QYxdgDXpfF2opSiL4oisKUmb2d5BEcZZ/50gvLmgmEKnwgvidgr/VeDx591q0UIVkbrWAyrE3KvtWCFfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486522; c=relaxed/simple;
	bh=StYwcVJ1alVLddXICE5IoIrpTLyz9IaJC9WC49McDrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXjXQFfdYayGrYH9xxxvZaA9Xq2UyjXB+r/bLD5V2PSeZ884Zc+ILYRd7PuMtZVJjJp8V2Z39IB3jJt9tNexd27/3QDsoGYJu86Uc92KTPr6Q1sPrtcD+94BKC6GDg+8Cqtk+IqQbdcd08xMX8wIOCPua0xJoy5js75tOTkZk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7CNWEiz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7CNWEiz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZYjO784902;
	Thu, 8 Oct 2026 19:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PcwPW0
	aWVeE1fuJOObLYpYRuT0P35/KbPbBsjsP+03k=; b=g7CNWEizla0wEiyd7x8Yhr
	Hq2WiOafiapR9X+OWZDhoDRg0MC2/UaMHUZkzRE7860uJH1jb+Q51EAP+LHJBfyd
	o3CoVn0l+r8/RnnxF+OQ/z9fAgvvtSE2DCKeXOaf8CzaCYBJfdwSf3s7NFdz781v
	FtytlLRqPxvXV5ArbTo5FxMs6SxtOr2IMY+e++rv6bBKqW1iaMtR0aWvcHvn3Vfa
	DRJ8iwHAA93k5fvZ4sl9gE39mJ2k4XBT8nJR7baBZD20edOhnAXkHH7RJ0Pi5BOw
	2bFNxNE4G1VhT54YddCtCAuiUIHZ9VLrFq73FqNuBfaWTLhvKW20Y9zBwlVo36Dw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1dmng-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 19:08:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWgNp3783100;
	Thu, 8 Oct 2026 19:08:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5s2vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 19:08:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698J8bG929229624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 19:08:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5E8A58055;
	Thu,  8 Oct 2026 19:08:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC9F58043;
	Thu,  8 Oct 2026 19:08:37 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 19:08:37 +0000 (GMT)
Message-ID: <4cce992d-6fa4-414a-9889-23d8ac9f1098@linux.ibm.com>
Date: Thu, 8 Oct 2026 15:08:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] s390/vfio-ap: Transition device migration state
 to STOP
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-12-akrowiak@linux.ibm.com>
 <20260807225402.D7DB01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260807225402.D7DB01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac7ea37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8s1LejCmVXr28qEsvwkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NiBTYWx0ZWRfX+9vuQIz9mr3L
 1agjdxcGFV6Zta0Vti0u5BGZs+jJZ31ZjEr4Ao9T4HGmZj+abukoqyPczmSfEtPf31Om1YNn8fa
 V4qpY+CxRnhUXt/thWLg60pD8Dgyg2jkECzKTLwN+/7Be73eEuoAaYOky8gIfWv76yOGGVcxsC4
 veK3RixSU+Dr0vhnJXo0Xur3vUqPUkWrDWBJikQxWjTSv0WL37LJOVGNdgmp9KTewfFtN66muB7
 ijaODPQZapZk9/G2TWBQjqxc+/6PwY7ryVszYEaQfq9ey0CbdyQM0BDSTM/1RbiZf+zDFb0QyZ2
 dz8Va8P7N54tXfqP/gQZ6I0zn+KU2DoBs5o/478WXBKtTPy+rHtEjEX2i6pNhNf9pPeHgygXOjD
 bagJyQOl3U7h+S+CdUjf4Gds+5cixPZZTDdeRLXhtYPz+D8o8yXJvBOnl1F22t8Kmk42QNJxLbu
 9WysNPYTzUb3XXNm6kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NiBTYWx0ZWRfX9VUpdM6Juyij
 e57hBYAQP5rCnQTPXoYfhBEfmISP77L2RdVwI9xcdQKdLArZNcyIXC2SFXcRs34fR/AWWrsUIBd
 XUM2g5AW2vAs1iSUxhweLtLlQ16m6LA=
X-Proofpoint-GUID: soWSRSutXb43V7-ufQgzmYsei86o9OWe
X-Proofpoint-ORIG-GUID: soWSRSutXb43V7-ufQgzmYsei86o9OWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080076



On 8/7/26 6:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> New issues:
> - [High] Memory leak and silent transmission of stale device state due to missing buffer cleanup on FSM STOP transition.
> - [High] Migration data file descriptors allow out-of-band manipulation of the active AP configuration.
>
> Pre-existing issues:
> - [Critical] Unprotected concurrent ioctls cause Use-After-Free, Double Free, and Memory Leaks during migration reads/writes.
> - [High] RESUMING state machine is permanently broken by an incomplete reset.
> --
>
> --- Patch [11]: [PATCH v7 11/15] s390/vfio-ap: Transition device migration state to STOP ---
> commit e7e2429c70da0ea0a7016c096567e78834fcc351
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
>      s390/vfio-ap: Transition device migration state to STOP
>      
>      This commit updates the VFIO AP migration state machine to handle
>      transitions to the STOP state from RESUMING or STOP_COPY. It returns
>      NULL instead of an error, stating that the VFIO migration framework
>      will clean up file streams and associated data when releasing files.
>
>> There  only thing to do at this point is return
>> NULL to the caller since the file streams and associated data will get
>> cleaned up as a result of the VFIO migration framework releasing the files.
> [Severity: High]
> Is this assumption about the file streams and associated data getting cleaned
> up accurate?
>
> Looking at the file release callback:
>
> vfio_ap_release_mig_file() {
>      ...
>      vfio_device_put_registration(&matrix_mdev->vdev);
>      return 0;
> }
>
> The callback only releases the VFIO registration reference and does not free
> the state buffers like stop_copy_mig_file.ap_config or
> resuming_mig_file.ap_config.
>
> Could this lead to a memory leak and the silent transmission of stale device
> state to the destination host on subsequent migration attempts, for instance
> if we skip allocating and fetching a fresh configuration in
> vfio_ap_stop_copy_read() because ap_config was leaked and left populated?
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 4dd7373c3d9d9..30160e3dddedd 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1511,12 +1511,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>>   		return filp;
>>   	}
>>   
>> +	/*
>> +	 * Terminates the data transfer session of the vfio-ap device state
>> +	 * between the source and target hosts. Since the vfio-ap device does
>> +	 * not virtualize a DMA device, there is no internal device state to
>> +	 * incorporate into the vfio-ap device on the target.
>> +	 */
>>   	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
>>   	     new_state == VFIO_DEVICE_STATE_STOP) ||
>>   	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>>   	     new_state == VFIO_DEVICE_STATE_STOP)) {
>> -		/* TODO */
>> -		return ERR_PTR(-EOPNOTSUPP);
>> +		return NULL;
> [Severity: High]
> Does returning NULL here successfully change the FSM state without clearing
> the active filp pointers in mig_data?
>
> If userspace keeps the migration file descriptor open (or duplicates it)
> during an FSM transition to RUNNING, and then issues a write on the stale
> file descriptor, could this allow out-of-band manipulation of the KVM guest's
> AP configuration while the guest is actively running?
>
> The file operations like validate_resuming_write_parms() appear to only check
> if the incoming filp pointer matches the stored pointer:
>
> validate_resuming_write_parms() {
>      ...
>      if (filp != resuming_mig_file.filp)
>          return -ENXIO;
>      ...
> }
>
> This happens without ensuring the FSM is actually in the RESUMING state,
> potentially permitting writes during RUNNING.

The concern is legitimate. This will be fixed by calling
vfio_ap_release_mig_files() on both the RESUMING→STOP and
STOP→RUNNING transitions. This sets resuming_mig_file.filp to
NULL, so any write on a stale migration fd will fail the filp
equality check in validate_resuming_write_parms() with -ENXIO.
Since STOP is the only intermediate state between RESUMING and
RUNNING, every arc back to RUNNING will have cleared the filp
before it is reached.

>
> [Severity: High]
> This is a pre-existing issue, but does a reset or an aborted RESUMING phase
> leave the RESUMING state machine permanently broken?
>
> When vfio_ap_release_resuming_file() is called, it frees
> resuming_mig_file.ap_config but fails to clear resuming_config_buf.filled:
>
> vfio_ap_release_resuming_file() {
>      kvfree(mig_data->resuming_mig_file.ap_config);
>      mig_data->resuming_mig_file.ap_config = NULL;
>      mig_data->resuming_mig_file.config_sz = 0;
>      mig_data->resuming_mig_file.filp = NULL;
> }
>
> If userspace initiates a new RESUMING phase, validate_resuming_write_parms()
> will evaluate this condition as true:
>
>      if ((resuming_config_buf.filled && !resuming_mig_file.ap_config) ||
>          (!resuming_config_buf.filled && resuming_mig_file.ap_config))
>          return -EFAULT;
>
> Would this unconditionally reject all subsequent writes with -EFAULT?

This is already fixed in the next version of the series in response to
review comments made by Jason.
The two-phase allocation design — including the resuming_config_buf
staging struct, the filled flag, and the invariant check in
validate_resuming_write_parms() — hve been removed.
validate_resuming_write_parms() will be simplified to check only
the filp equality and bounds against a single pre-allocated
worst-case buffer, eliminating the stale filled/ap_config
inconsistency described.

>
> [Severity: Critical]
> This is a pre-existing issue, but are the migration reads and writes protected
> against concurrent ioctls?
>
> For example, in vfio_ap_resuming_write(), mdevs_lock is dropped before
> copying data from userspace and interacting with set_new_ap_configuration():
>
> vfio_ap_resuming_write() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
>      ...
>      ret = set_new_ap_configuration(matrix_mdev, ap_config, cfg_sz);
>      ...
>      if (!new_allocation)
>          kvfree(ap_config);
>      ...
> }
>
> If a concurrent VFIO_DEVICE_RESET ioctl occurs while the lock is dropped,
> could set_new_ap_configuration() assign a locally allocated ap_config into
> the now-NULL resuming_mig_file.ap_config?
>
> Would the outer function then call kvfree(ap_config), leaving a dangling
> pointer in the device state that could subsequently be used and double-freed?
>
> Similarly, in vfio_ap_stop_copy_read(), the lock is dropped before
> copy_to_user():
>
> vfio_ap_stop_copy_read() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>          return -EFAULT;
>      ...
> }
>
> Could a concurrent reset free mig_file->ap_config before or during the copy,
> leading to an information leak of freed kernel memory to userspace?

The concern is legitimate. Both races will be fixed by holding
locks for the full duration of the read and write operations.

>
>>   	}
>>   
>>   	if ((cur_state == VFIO_DEVICE_STATE_STOP &&

