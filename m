Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292168;
	b=FIg91Bn8FD0EFZGYydPewOC3eVYaAH+jH/8zMHWDWMoOl4PkDANqvPJPLJlCU7W4b2Tc
	 DzDowVtLwwij5V+jh29hQsMZma5p6Jh5HztaVKcLOYMgoil90RcQBebYEUk6j5J8xuI13
	 PNgBnCSHdFHHIBuz09fLr2AsJd76B0CnHfgmiBLeMTxMRnaRq7kiOcumZ4NpOpwctiGIk
	 JkDflN1zG3Qi6CyiMMsXqvsCVYadHZLzOLVMfqhFzeCkKPCYHsh4LMxOHWqFt3+rrpnU9
	 rTkmy6gwkS5+syvGrVzU2vC+0CRxIpNb/0tTBzxXWMa2tUv1J7nLeDiBVbg13KmZAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292168;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RM6qhy2ivXjlJLMl9pIvXAmkCvlP1do4LZqnyTbsr8k=;
	b=tMfcJGzuLuplL599bxvWhFYeCc3ZH8MCUzffA4SNI++8YmJ44rexupg2QpaBDzJGLyOE
	 ClzatYtgGUKQxb+qvX6SDeXSX8by+AaqeNsYzvH5cn6bhLn6Uml+MCr5EYS/uPdyLr7Ls
	 xEja55GREBIDwMAShOW6C3tE4We81l5LkXUx82CT6KpBAVV4pKof0pdpCeyi9wrkjSI5I
	 b9wRtZ+vb3Bf6LhcHmMmDacufJIAMf775uO0U8N/t3pyChR36fVOz5SYL1l93/K+szMzG
	 0vvxt2pYy6xHuNwlBDziDECG1Y160063LYeEd8oSzhqCqTBXd4CQTfhOkQaSNUqDQ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WS2dm2xl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92C606A31C;
	Thu, 29 Oct 2026 16:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC92C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WS2dm2xl
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGEMG83505361;
	Thu, 29 Oct 2026 16:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RM6qhy
	2ivXjlJLMl9pIvXAmkCvlP1do4LZqnyTbsr8k=; b=WS2dm2xlc8AI56OTAlBlcR
	fjnc1F2xuJ3GrZa4CF2c+mi5TLRfYg48/3OvZZUxzhky7Z8qLVMSOAtm5AweazvJ
	icsbrx/sruGCEyIu9XGOZ7A9WaGQeJsXEWqtis7VIG7rxDPfbMkTv/We7hSAju9+
	C3/wHXdLYcXS7239WqP7GpC5m4XpZZpXSPiBEY9Px0YM5cd0xuLNIac8t4xoZgSL
	JeDC7fFGQRZ7K++AHcdFerLc4gTKnP3AVehxDyzq61HljEwuCgQjFH+U/rOHaDbf
	MSDHb7qdMUwifTLWemcR4Dc4TjqdNYGvy49vLNyEkYCfZnzHNbvpeEysxGIIXRWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3gb9f3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:42:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGYkcv3418653;
	Thu, 29 Oct 2026 16:42:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pfvad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:42:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGgjIh33751726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:42:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E69C05805C;
	Thu, 29 Oct 2026 16:42:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62B955805F;
	Thu, 29 Oct 2026 16:42:44 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:42:44 +0000 (GMT)
Message-ID: <2c59ec30-cfe4-4bc1-ac1f-c18beb5655ae@linux.ibm.com>
Date: Thu, 29 Oct 2026 12:42:43 -0400
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
Subject: Re: [PATCH v10 13/15] s390/vfio-ap: Set up for vfio-ap device
 migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-14-akrowiak@linux.ibm.com>
 <sashiko-outbox-183054@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183054@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z9G76iLPwvvsNELktTGXKB52XpAyWoYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX0DpwqKX6Zub8
 Drbz2wC/VFLFDYpIjAD7sOBc7lBVNJWVHv7+qLyWvYVN6CrcIOqOm3GYd3YHc9wgpmQ2mJiJxte
 dwscE41MLq3BgiKwt7V2H35zZLFFfbE2L3srfiPldfmiC5ykZI9Q9QPoh+7HJYSzACdEpNV0KFZ
 X3cdt31IJ2sbT4VdTmaR+pG0nw2P6oFu55uQo6j/g/7QkY9MGLRgTvY50KqUe+QjmGDjmghiCY0
 5SEUjTjOHUqSmrWTWurooU/FV4UAaLPDccVpgT2P+g0j/Ldheo9st0S6lL01DfEm5D26JTsgPfy
 zA8PWZ30g+xqy9VvFCSIeMC/wtN8xGcYfOjS6o9hvGz3/ElvdFCKpMsi3yMtAaNFG0nsT3sCLJj
 IrfMopr+WWz8793JLpsniZumdM6eVw==
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae37786 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=R3hAm40xv4kPzBdIJ08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z9G76iLPwvvsNELktTGXKB52XpAyWoYc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX3/Syw61OVnLZ
 DONLwvYkmvGXHZCCi9+NlyDmx1nUw+3Upq0/5ahKHrUiZGIcjtFCz7wx7Gx8HFQXWz0t9mVbdmw
 FKYwIJwNpIryMG45iMfEoGkpaOdz6t0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290063



On 10/23/26 2:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] s390/vfio-ap: wrong SE guest check via ap_is_se_guest() on KVM host
> - [Medium] s390/vfio-ap: stale completion flag and f_pos advance in vfio_ap_resuming_write()
> --
>
> commit 7adada8cbaf0b3057bf058ad4617540b9cea4ec9
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Set up for vfio-ap device migration
>
> This commit wires up VFIO migration operations and sets the
> VFIO_MIGRATION_STOP_COPY flag on the vfio-ap mdev during device probe to
> enable live migration support.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 38098968eaa2c..660b5a21fe9e8 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -212,6 +212,30 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
>>   	return 0;
>>   }
>>   
>> +static const struct vfio_migration_ops vfio_ap_migration_ops;
>> +
>> +/**
>> + * vfio_ap_setup_vfio_device_migration:
>> + *
>> + * Plug the object containing the function pointers to the migration callbacks
>> + * required to facilitate VFIO AP migration into the mdev
>> + *
>> + *
>> + * @matrix_mdev: pointer to object containing the mdev state
>> + */
>> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	/*
>> +	 * Live guest migration is not supported for SE guests, so there is no
>> +	 * need to initialize the migration capabilities.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return;
> [Severity: High]
> Does calling ap_is_se_guest() here and in vfio_ap_init_migration_data()
> actually detect a Secure Execution guest on the KVM host?

No, but it checks whether the host on which it is executed is an SE
guest, in which case a nested SE guest can not be migrated.

>
> In drivers/s390/crypto/ap_bus.c, ap_is_se_guest() checks whether the
> currently running kernel is itself a Protected Virtualization guest:
>
> bool ap_is_se_guest(void)
> {
> 	return is_prot_virt_guest() && ap_sb_available();
> }
>
> Since vfio_ap runs in the KVM host kernel where is_prot_virt_guest() is
> always false, ap_is_se_guest() will always evaluate to false on the host.
>
> Furthermore, at vfio_ap_mdev_probe() -> vfio_ap_setup_vfio_device_migration()
> time, matrix_mdev->kvm is still NULL, and a guest only enters Protected
> Virtualization mode at runtime via KVM_S390_PV_COMMAND. Should the SE guest
> check instead be performed dynamically against matrix_mdev->kvm via
> kvm_s390_pv_is_protected() when handling migration state transitions in
> vfio_ap_set_state() or vfio_ap_transition_to_state()?

Performing the check dynamically in vfio_ap_set_state() or
vfio_ap_transition_to_state() would also be wrong for a second
reason: ap_is_se_guest() at probe time is the correct place
because the host's SE guest status is fixed at boot. Deferring
the check to the first state transition would mean advertising
migration capability to QEMU via mig_ops and
VFIO_MIGRATION_STOP_COPY and then failing at runtime — which
is worse behavior than simply not advertising the capability
in the first place.

>
>> +
>> +	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
>> +	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>> +}
> [Severity: Medium]
> Now that vfio_ap_migration_ops is wired up and exposes the migration stream
> and state transitions to userspace, can vfio_ap_resuming_write() leave
> resuming_mig_data_complete set to true or leave filp->f_pos advanced when a
> write fails?
>
> In drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write():
>
> 	memcpy((char *)ap_config + *pos, kbuf, len);
> 	*pos += len;
>
> 	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
> 		size_t expected_sz;
>
> 		if (ap_config->num_queues > MAX_AP_QUEUES) {
> 			ret = -EINVAL;
> 			goto out_unlock;
> 		}
>
> 		expected_sz = sizeof(struct vfio_ap_config) +
> 			      ap_config->num_queues *
> 			      sizeof(struct vfio_ap_queue_info);
>
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
>
> If userspace writes a valid payload where *pos == expected_sz,
> resuming_mig_data_complete is set to true. If userspace then issues an extra
> write to the resuming FD before transitioning to VFIO_DEVICE_STATE_STOP, the
> extra bytes are copied into ap_config, *pos is incremented past expected_sz,
> and the function returns -EINVAL without clearing resuming_mig_data_complete.
> A subsequent transition from VFIO_DEVICE_STATE_RESUMING to
> VFIO_DEVICE_STATE_STOP in vfio_ap_transition_to_state() only checks
> mig_data->resuming_mig_data_complete and will still succeed.
>
> Also, when any of the checks on num_queues, expected_sz, or
> do_post_copy_validation() fail, *pos has already been incremented even though
> vfio_ap_resuming_write() returns an error. Should the validation happen
> before advancing *pos and clear resuming_mig_data_complete on error?

This is a duplicate of questions asked and answered in previous commit 
reviews.

>

