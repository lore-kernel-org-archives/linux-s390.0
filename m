Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8B4DAF81;
	Mon, 12 Oct 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836535; cv=none; b=UyC0AVjDv0P4h5GxRqdjrbYEeJhmJ+WGRpSgDsl16NC7J57W+MGBcEgDluhVREdcZzaPO/76mAv2T7RnoUXtBTyrP4vhkLwS84aYKanMtyd5mX0WqeHbn54aLzi49FRX5SJnUvd+Ka6rVMaSYJ6UYoikay62iTDWjgqwzHNPXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836535; c=relaxed/simple;
	bh=l0gL9uYEPKSdTQudvp25cNOzTorFUob3Nscc6kfNgP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lp7Ik+MnRRJgFSF79XsN+o1o4bIni90X7Q8DXxUWcR4zxAcPcHF05PFDvqkmOhLCIF7M12HgL5Ahy4JvxEVj5RHSkqFG4bgapmyO+NrnyF1eJmGwMDE8yg2nfzy3ApLalZ7xr2qwHCWjf+6L1xmPUUfqsqOtTjfLtAEHVO1nLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P7Kj8cyJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P7Kj8cyJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJiVCQ1149509;
	Mon, 12 Oct 2026 20:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0uAu2A
	+sYKqnimE0S7xLUlHVun395otI+3Ws4gdQCEw=; b=P7Kj8cyJ1J6tHSrqL2hY/g
	z4ClRXP2fNOpOhwqwK4nf4J6+yy1jbJqJN3Wci5ZgvKptwk5iwvDGn99rfis2bKa
	3N/mcwqer5CNeEfrfLWYz9H7gZ9airD2p/m1ElcfSCkOa8EHKwBd0yYlRkt48UdE
	nmcjJwkDlee8tXNH8NICpjY9WhVCQ256U+7ejwssYB58n+wZFhdJnjKLh75WzUB7
	2tZD/0TarzrP29+GxRW65xJ2OgLbXb8/UJK2sUn7rthaC+8wCwanyuetRGfFgtCV
	yjpI5FkDaSc+79gul9eqqovdbMnWiMHHUIEfOhMUx+PlvDtMn5s3Qr6C5t2QT+dg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w2bpx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 20:22:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJdGaZ1828898;
	Mon, 12 Oct 2026 20:22:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vpw5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 20:22:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CKMBg231195654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 20:22:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3F95804E;
	Mon, 12 Oct 2026 20:22:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F545803F;
	Mon, 12 Oct 2026 20:22:10 +0000 (GMT)
Received: from [9.61.159.45] (unknown [9.61.159.45])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 20:22:10 +0000 (GMT)
Message-ID: <a7e6ff3a-2a64-4057-b9a6-26d80c718c5f@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:22:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-8-akrowiak@linux.ibm.com>
 <sashiko-outbox-165444@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4MCBTYWx0ZWRfX3IA+tblVZKev
 hNzcJv/fGWlsYXcwNZiwsO4/SihhzXx0+/hhaf0rFy8gWMW7jc90bzIs+oSKvoAm66wIKuemJ+J
 MlXhG/2g5UvfdDaxKc23xWD40jBFzFU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4MCBTYWx0ZWRfX3MFglDXdxswk
 d9YRZQ3UH6hlSCKGwR3JMMayUjJZQ4RbEYkTdlNFEi3xWsP3EFqirO3NcW311BZf/6LSUKI7gEL
 sWjHa5n1M6jVjOip9LYgZeE/8oiJhSC4n0Fsxk/sqsjApnV9Rlb9LEvWE4wQHfmVWndg3DGqF7s
 wGxMMyid3lEk3JJ7rBQKZ0ydT9KjCgURhj2wkmOSJXOaU52hGmvCZfwd6O6y6KqK0TXypdBQyVz
 DJIdn8G+agsHyg1cLcZ+yIRYeEbMrUpyd1fShX2Q7Xqezl+6+l8kYQvL6dBWsSScgx66bCA8AVy
 teArh0UrW/5RhXYPUTE1otejInpTcO5mtJS91Wn0/kHLxShY0IrAP25Fphobf7EOvGWrNAY8+iQ
 XqXo/70xYPwTh8x4NhuKLPD5XvSRtvmFgiRr4I1GK9802eCmbA/0NVx5CzrMB0OFyNmE0n4NA3H
 oAbM2PY9A+G05DZHkfQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd4175 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WWoxTm97podMns0e3DQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jkvp92uQrrlPn_-RqU_uL9uUm3Dt-FoU
X-Proofpoint-GUID: jkvp92uQrrlPn_-RqU_uL9uUm3Dt-FoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120080



On 10/9/26 7:54 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] vfs: stream position permanently advanced on copy_to_user failure
> - [Low] vfio: missing memory cleanup in vfio_ap_release_mig_file contradicts documented design
> --
>
> commit e098ee9f1268fb534553f678f8c768d5b444ac95
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to save the vfio device migration state
>
> This commit implements the read callback function for the file created to
> save the state of the vfio-ap device when transitioning to the STOP_COPY
> state. It copies the guest's AP configuration information to userspace.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index bbd007c06a776..0c43f25e2d9ba 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>> @@ -150,6 +144,276 @@ static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
> [ ... ]
>> +	/*
>> +	 * Lazy initialization: the migration config is generated on the first
>> +	 * read() call. vfio_ap_open_file_stream() initializes ap_config to NULL
>> +	 * and config_sz to 0. On first read, we generate the config by
>> +	 * snapshotting the guest's APQNs from shadow_apcb and retrieving hardware
>> +	 * info via TAPQ for each queue. The result is cached in mig_file->ap_config
>> +	 * for subsequent read() calls. The config is freed when the migration FD
>> +	 * is released (vfio_ap_release_mig_file -> vfio_ap_release_stop_copy_file).
>> +	 */
> [Severity: Low]
> The documentation here states the configuration is freed when the migration
> file descriptor is released by calling vfio_ap_release_stop_copy_file() from
> vfio_ap_release_mig_file().
>
> However, looking at the existing vfio_ap_release_mig_file(), it doesn't
> appear to call vfio_ap_release_stop_copy_file() during cleanup:
>
> static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
> {
> 	struct ap_matrix_mdev *matrix_mdev = filp->private_data;
>
> 	/* ... */
> 	vfio_device_put_registration(&matrix_mdev->vdev);
> 	return 0;
> }
>
> Could this lead to delayed resource reclamation and a dangling pointer since
> the ap_config buffer isn't actually freed when the file descriptor is closed?

You're right, the comment is wrong. vfio_ap_release_mig_file() only drops
the vfio_device registration reference taken in
vfio_ap_open_file_stream(); it does not free ap_config.

This is intentional: ap_config is owned by matrix_mdev->mig_data, not by
the file, and is freed under mdevs_lock by vfio_ap_release_mig_files()
when the migration session ends (device reset, device close/removal, and
the transitions back to STOP). Freeing it from the release callback would
race with stop_copy_read()/resuming_write(), which rely on mdevs_lock
rather than the file's lifetime to protect mig_data. If userspace closes
the FD early, the buffer is reclaimed at the next of those events; no
pointer is left dangling since mig_data keeps ownership throughout.

Since the mention of vfio_ap_release_mig_files() is completely unrelated
to the code block described by the comment, that will be removed from
the doc block for the next version of the series.

>
> [ ... ]
>> +	read_pos = *pos;
>> +	*pos += len;
>> +
>> +	/*
>> +	 * Keep mdevs_lock held across copy_to_user() to prevent a concurrent
>> +	 * vfio_ap_reset_migration_state() from freeing ap_config while we are
>> +	 * reading it.  copy_to_user() may fault on a non-resident user page,
>> +	 * but that is legal for a sleeping mutex.  The data transferred is at
>> +	 * most a few KB for any realistic AP configuration, so holding the lock
>> +	 * here is acceptable.
>> +	 */
>> +	if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len)) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		return -EFAULT;
>> +	}
>> +
>> +	mutex_unlock(&matrix_dev->mdevs_lock);
>> +
>> +	return len;
>> +}
> [Severity: Medium]
> If copy_to_user() fails and returns -EFAULT, pos has already been permanently
> advanced by len.
>
> Will a subsequent read() on this stream start from the advanced offset,
> skipping over those bytes and breaking the migration data stream?

Yes, that is a bug. *pos was advanced before copy_to_user(), so a fault
left the position past data that was never delivered, and a retried read()
would skip it.

mdevs_lock is held from the position read through copy_to_user(), so
nothing else can observe *pos in between and the early advance (and the
read_pos snapshot) is unnecessary. In the next version *pos is advanced
only after copy_to_user() succeeds, so an -EFAULT leaves the position
unchanged and the read can be retried.

>

