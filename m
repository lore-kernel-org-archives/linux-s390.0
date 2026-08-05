Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AF2BDC0F;
	Wed,  5 Aug 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935683; cv=none; b=SJAAdMgJY8Ard63uJSUwSJCqy6Xb5jLDAOeX214jKWTTQ1D/2PY8ah55eTHFDba0h0ftqDs9T214UdH8knapHFi1J98TVE+gYG5LmtuQwbqbiqBrPbRMPUThj7sTfGHINcySdV/Wkar/WiBiaigUh5SdEw6hw9m6DPcRPeh9BdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935683; c=relaxed/simple;
	bh=1upffbS6T6+L5b1jXkxWDuMHXx4j7qqm+y/mFpQT11c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GP4kao5ppzPB4BAVq2w/l5GemMuKSMIsTrtsIYrLSPfyQEBzyo3RPWrl7omfvrT9b4wb4DgDvJpKKA0n+L+v5n5ti4ecMNl2b4Xpw8cJYupoG5q68mtl+EkPmeYtL3Md4e+Q4QS0VkiHQne+ehLVyTRdP9kmKuyQ76DeOQILGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HU/zsaxV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HU/zsaxV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHfQ61940678;
	Wed, 5 Aug 2026 13:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PNWbA9
	mFx/Ff+b2UyvAAw0TKu3AJCLpFPyiHJdIQ4iY=; b=HU/zsaxVi8mfT9CUoj8xdd
	GU/pHY86O7XCtoa6GK9z8DKEwBlbkW8z78W5tz1d4qcUe7DX+dIDxAjUdmQbVRIZ
	wFOdxhq5LwwR1cPKub3NjVAw0JWc/iwevn6+sRGVWmcJ6zG31wYNr/YE6dVojIrT
	riPD6xZVfj+7h62KoTxtjKLz+Ac1R07JKG+WzZiY0qV6gwdaZzuaXQSO4xFzAphr
	EZDXJVR4+XkOb6SdE+xkXxZXREWr5JpDa3/GagmpZEvh9RfllkhYWINFzQ9mN4HS
	MNadtUZUhWvXMv70Sjr3SiET1+gtFQK9wV/7uzYK1IsEirf76Fqf89gBmC5/AZ4A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqu3d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:14:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DBKLh019497;
	Wed, 5 Aug 2026 13:14:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgeg4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:14:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DEb4v49479936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:14:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF625805F;
	Wed,  5 Aug 2026 13:14:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA405805C;
	Wed,  5 Aug 2026 13:14:36 +0000 (GMT)
Received: from [9.61.13.108] (unknown [9.61.13.108])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:14:36 +0000 (GMT)
Message-ID: <74826403-39d5-48f1-809b-d5ff62b790e8@linux.ibm.com>
Date: Wed, 5 Aug 2026 09:14:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] s390/vfio-ap: Transition device migration state
 from STOP to RUNNING and vice versa
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-13-akrowiak@linux.ibm.com>
 <20260727182852.ABF2A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260727182852.ABF2A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V0JhO58-YzNqUaIDoZP2wlo-WK-MxQK0
X-Proofpoint-ORIG-GUID: V0JhO58-YzNqUaIDoZP2wlo-WK-MxQK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX5i4sjvrVbOMB
 kvMVE68PUQ2KQmFfPtj/GqV0q0WB3HCLi19np42YDfYMQE41VbN3fSB2eHxhtXpF9I6SB8Clb87
 E5zJSctmM6lST8euyfn+Qr6ut+Ysk08=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a733740 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_UpRN81A3srhLPRKp3oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX8Bn1GWt/yMU7
 ++/lyTvWv10xhMRHCBQrQya2RJqqpebRG7f/vwHlRe1EpP2vRjUs/n2RWLDaakslDVW0wdC3Duo
 k/FCknFbHmJIKYIybYSyfVEd73FIDXoGFFPNxzvvQdHSrc2/KdI7gi2XRuRL3AWN4CL5OOLc21J
 lBECnAnJxu0kka4ZnBIGtvvtP+KnvxZCKfw/4j+VMBlBM1Jys3j/HVcb7416O/DVxB45wn2Z04K
 NhEFVUfBhKaeDPUGbYeOx/qIfGRhOcFfaIDpdCiWWxeaaEMFkZAF3BM6YUQb/1//133eFQqbVwy
 cz7GQ/K8V8TLXiXZ5JXw7CRABrrJpDUUmHhxq36xvTiYNpMnnCc3GioamrnRs1HUsM2xkTLvESn
 OCxC8xhqWWjJ8t35RlOAnq0u1h4/DV0r1+ZBh94Deb6qS0ePl71yO9XQjbOt1aiTu+TOfoTYWJw
 yRZpBHnIl3lW8ZUUTcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050103



On 7/27/26 2:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Concurrent device reset, closure, or state transitions during migration data transfer cause Use-After-Free or Write-After-Free of `ap_config`.
> - [High] Overwriting the active migration file descriptor during state transitions allows silent migration of stale state and leaks file references.
> --
>
> --- Patch [12]: [PATCH v6 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa ---
> commit 2b837152c9f64c5082507b5aa41ffc56027c1e29
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
>
> The transition from STOP to RUNNING and vice versa indicates that
> the vfio device is operating normally and migration is not
> currently taking place. In this case, just set the new state.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index fc4cb893f0f00..1c385908fc39b 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1280,12 +1280,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
> [ ... ]
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
> [Severity: High]
> Does returning NULL here instead of -EOPNOTSUPP allow userspace to silently
> leak the active migration file and state?
>
> If a live migration is aborted and transitioned gracefully from STOP to
> RUNNING, the old file descriptor could remain active in mig_data because
> the driver still holds a reference to the file.
>
> If the process later starts a new migration and transitions to STOP_COPY
> again, it looks like vfio_ap_transition_to_state() unconditionally
> overwrites mig_data->stop_copy_mig_file.filp:
>
> vfio_ap_transition_to_state() {
>      ...
>      if (cur_state == VFIO_DEVICE_STATE_STOP &&
>          new_state == VFIO_DEVICE_STATE_STOP_COPY) {
>          ...
>          mig_data->stop_copy_mig_file.filp = filp;
>          return filp;
>      }
>      ...
> }
>
> Will this cause the driver's reference to the old file to be permanently lost?

>
> If the old fd is read, vfio_ap_stop_copy_read() might observe that
> mig_file->ap_config is already populated and skip updating it, serving
> stale configuration to the target.
>
> Additionally, when userspace closes the old fd, its release handler might
> fail to match the overwritten filp pointer, which would skip
> vfio_device_put_registration() and permanently pin the device.

The NULL return for STOP<->RUNNING transitions is the correct
VFIO API response when no data fd needs to be handed to
userspace — it does not touch any filp field in mig_data.
The scenario you describe — a new STOP->STOP_COPY transition
silently overwriting a still-live stop_copy_mig_file.filp —
cannot happen, for the following reasons:

File descriptor cleanup is always performed before a new fd
can be opened. vfio_ap_release_mig_files() is called by
both vfio_ap_reset_migration_state() (on VFIO_DEVICE_RESET)
and vfio_ap_release_migration_data() (on device close),
both under mdevs_lock. Either path nulls out
stop_copy_mig_file.filp before any subsequent
STOP->STOP_COPY transition can reach the code that writes
to it.

vfio_device_put_registration() is always balanced.
vfio_ap_release_mig_file() — the file_operations.release
handler invoked when userspace closes the fd —
unconditionally calls vfio_device_put_registration()
regardless of mig_data state. There is no code path that
causes it to be skipped.

The stale-data scenario does not apply.
validate_stop_copy_read_parms() rejects any read where
mig_data->stop_copy_mig_file.filp != filp. A fd from a
previous session will fail that check with -EINVAL and
never serve any data.

>
> [Severity: Critical]
> With these new state transitions, is there also a risk of use-after-free or
> write-after-free regressions during concurrent migration data transfers?
>
> If a userspace process calls read() or write() on the migration file
> descriptor, mdevs_lock is temporarily dropped during the data copy:
>
> vfio_ap_stop_copy_read() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
>      ...
> }
>
> Similarly in vfio_ap_resuming_write():
>
> vfio_ap_resuming_write() {
>      ...
>      mutex_unlock(&matrix_dev->mdevs_lock);
>
>      if (copy_from_user((char *)ap_config + write_pos, buf, len)) {
>      ...
> }
>
> Can a concurrent thread issue a VFIO_DEVICE_RESET ioctl, close the
> device fd, or trigger a state transition that acquires mdevs_lock and
> frees ap_config and mig_data?
>
> If so, when the read/write thread resumes execution, it appears it
> would access the freed ap_config memory, leading to arbitrary kernel
> memory corruption or information leaks.

This is a valid observation. At the commit under review,
vfio_ap_resuming_write() drops mdevs_lock for
copy_from_user() while holding a raw pointer to an
ap_config buffer that has not yet been stored into mig_data.
For subsequent writes (non-new-allocation path), the pointer
is retrieved from mig_data->resuming_mig_file.ap_config
under the lock but then used after the lock is dropped. A
concurrent VFIO_DEVICE_RESET calling
vfio_ap_release_mig_files() under the same lock could
kvfree() that buffer while the write path is copying into
it.

This will be addressed in the next patch series.

>
>>   	}
>>   
>>   	/* vfio_mig_get_next_state() does not use arcs other than the above */

