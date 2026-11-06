Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975124;
	b=B0Bavm/gb+yDV0s2Yv5uNesNgQQo8TUnsD5WNBrXIXWXZzVe4aZ4TvDN+84n3qCWx0Wi
	 jJ2PWr+O0WEJIXrniBawY9k4uuS2FMI8eaeI+7xDRigtKDwuGXk9wiYwCgY9nfr3UZ0LZ
	 MLAgOnZU1LHCSn4WL8D4Jtd3zJ0GQjmztD7cpEXIc9+TwLpM1dj23dSlmgedpzCsfDq7Z
	 INzl4898qbOCRIb5uRepCvRtaYLz4HU7SdQnoDxT/kUHhPmKb0HXTTvH5iTyeuzcUHhcQ
	 zksnWO6UW5+45jUlrY0p0I/9ezbciZ3vpRhmsYG/XT/dlp0AQpmtqJ3voBDpdAHZXnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975124;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CnzZ9tu/PJ0Xc56iPjJhoZcChGnPBcjUy3GAK0JvUCU=;
	b=lxMw1K2WwgcZ4HFMjozRB8QoQFL/6bShq0FwuWdp8ZVKFxQkgsOTtq/egAzeVySxG/Mi
	 KQJ6E6z2qakjs1TfwlefWhY2DdfIXjnDD5sJmKJSg5iTjUwGSlOo3OWlxAHJ/LfW1DgSS
	 J3MTM9K3ON4O/+xel2J8NoZEPW7b0GRwGu5oSoo65OAYjminb5uGAJDPPIoSFVCJf3eUp
	 m+6qoTWsSpUlKC8fwUg4CHR21/A/Amhpytirv62mOopXZCMrvwtllyRnQ6a+1pH8nf3QD
	 7h7cTwhTsR9UGYyQbHgzqucfDJiVUJ5i5mQ6nhRBxvcbq2ZlRru5r7IDdMkpf0ux58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DRb+1yN1;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423C606A33D;
	Fri,  6 Nov 2026 14:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6423C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DRb+1yN1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EENGk2577588;
	Fri, 6 Nov 2026 14:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CnzZ9t
	u/PJ0Xc56iPjJhoZcChGnPBcjUy3GAK0JvUCU=; b=DRb+1yN1b58UA3vJgQlIsQ
	LRLFKOt5bzU7Dm/sT3rdlOPfLA42Fbm5SmGiH7Q0P3w80Lh1INz2gVxBDf+fJWJ5
	wiOx1LwY8Y1VZWDSJemZEpoau4Cvo2+rGn1CZFRVS+Qk+PyIVimzrvzBnFxMGS0a
	lFtKAAlvHRyNo9FZlmWY+gNKETnGlxUWdxZcJ0I7Fa0He89NJq8BBSv2zqY9N/KY
	oIbahz6hXm803/Izviwfv/tuaPrLaB9W6oIqKV7099EvNhbWQv4wFZPVBX17CB8U
	BgJClIC5G0JsjygQGpLAgGGlg7u5Sa9x/+e7vfpIfxv1Hz/mu1mLsE6fdoqUF/ng
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94s6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 14:25:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Do4Mt3519503;
	Fri, 6 Nov 2026 14:25:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7txkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 14:25:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6EPLlU30671506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 14:25:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 541665805A;
	Fri,  6 Nov 2026 14:25:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A354058062;
	Fri,  6 Nov 2026 14:25:20 +0000 (GMT)
Received: from [9.61.114.69] (unknown [9.61.114.69])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 14:25:20 +0000 (GMT)
Message-ID: <0cc314a9-2fe1-41c5-bacc-bbf5552d1aeb@linux.ibm.com>
Date: Fri, 6 Nov 2026 09:25:20 -0500
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
Subject: Re: [PATCH v11 09/14] s390/vfio-ap: File ops called to resume the
 vfio device migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-10-akrowiak@linux.ibm.com>
 <sashiko-outbox-193805@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-193805@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aede353 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CTQ77ZSDLaTwiO4wZoYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hOb1hci8Vvvixm5yIoOJhp9F6q6yRYh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NiBTYWx0ZWRfXyw9cZJ36XzOF
 ZGpWjXi95+Ga0Xjrf0xE/Xr3CLXzcKXwk6+Js/MPnrxSfN7HyVpiz1a4qfDUBJ8TOCOEbX8RXyw
 pMHEjsbN0mc61E6xisiiZtTyU1GcmfPWU7pp2ENcmxMAqaF8SACjD9paOjZi4Kk1jQjD1krBNM8
 sK8BjqJryq7MidGTM0qOYX3SYLWnHJfO1XyPzCjUgF+V64JKtu8ICqrmXiRJl7y0JZZpgWEkV3Z
 6BkiIJZ/47CSbxRXMl52Jod2ppoU93TNXZishJJCU1SLU9ZZg5SnFsMC4i49BX1HMykG99PBgOB
 WMNfHnX2V/S0J5dL/fB7Tjp3Hx2IA8Mc3yo/5l2IVHHakw3ulzeeijmOCPSROY6Mjx9swyro9L3
 QXZXJQnZx9ESYQX7zqpyYpmfts4iq5j8RsNKeajFHYKfKm3Guwu+mPBixfMBc0RPKmgGeguaWqx
 WXa7Xes7syP4qmyGuMA==
X-Proofpoint-GUID: hOb1hci8Vvvixm5yIoOJhp9F6q6yRYh3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NiBTYWx0ZWRfX2LXfP12l1Dh1
 81bNBar8qpco0d0Xd5vXZP7XMUU4xDPfsSh7tLg1cv6wK+ESHu6C+SLBLY396+REkrdyRWAeKo7
 Q/rLZ1OxyEFctGUO+t5Ez2xzqyfnZTc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060056



On 11/2/26 12:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] s390/vfio-ap: use-after-free of mig_file in vfio_ap_resuming_write()
> - [High] s390/vfio-ap: fortify panic in vfio_ap_resuming_write() on chunked writes
> --
>
> commit 05b49746b964ad1916518e2c783de5c6220f1f14
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: File ops called to resume the vfio device migration
>
> This commit implements the write callback for the migration file stream used
> during the RESUMING phase to receive and validate the source guest's AP
> configuration on the destination host.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 526d83e8590d9..47f05e43b9e0e 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> @@ -466,11 +511,562 @@ static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *mig_
>>   	return filp;
>>   }
>>   
>> +static int validate_resuming_write_parms(struct vfio_ap_migration_file *mig_file,
>> +					 struct file *filp, size_t len)
>> +{
>> +	loff_t total_len;
>> +
>> +	lockdep_assert_held(&mig_file->lock);
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	if (!len || filp->f_pos < 0)
>> +		return -EINVAL;
>> +
>> +	if (!mig_file->matrix_mdev->mig_data)
>> +		return -ENODEV;
> [ ... ]
>
>>   static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
>>   				      size_t len, loff_t *pos)
>>   {
>> -	/* TODO */
>> -	return -EOPNOTSUPP;
>> +	struct vfio_ap_migration_file *mig_file;
>> +	struct vfio_ap_config *ap_config;
>> +	ssize_t ret;
>> +	void *kbuf;
> [ ... ]
>
>> +	mig_file = filp->private_data;
>> +	mutex_lock(&mig_file->lock);
>> +	mutex_lock(&ap_attr_mutex);
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +	pos = &filp->f_pos;
>> +
>> +	ret = validate_resuming_write_parms(mig_file, filp, len);
>> +	if (ret)
>> +		goto out_unlock;
> [Severity: High]
> Can this trigger a use-after-free on mig_file if the VFIO device file
> descriptor is closed while the migration file descriptor remains open?
>
> In vfio_ap_resuming_init() -> vfio_ap_open_file_stream(), filp->private_data
> is set to &mig_data->resuming_mig_file, which is embedded inside
> matrix_mdev->mig_data:
>
> drivers/s390/crypto/vfio_ap_migration.c:
> struct vfio_ap_migration_data {
> 	enum vfio_device_mig_state	mig_state;
> 	bool				resuming_mig_data_complete;
> 	struct vfio_ap_migration_file	resuming_mig_file;
> 	struct vfio_ap_migration_file	stop_copy_mig_file;
> };
>
> While vfio_ap_open_file_stream() calls vfio_device_try_get_registration() to
> keep matrix_mdev alive until vfio_ap_release_mig_file() runs, closing the
> VFIO device file descriptor invokes:
>
> vfio_ap_mdev_close_device()
>    vfio_ap_release_migration_data() {
> 	...
> 	vfio_ap_release_mig_files(matrix_mdev);
> 	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
> 	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
> 	kfree(matrix_mdev->mig_data);
> 	matrix_mdev->mig_data = NULL;
>    }
>
> Although validate_resuming_write_parms() checks
> !mig_file->matrix_mdev->mig_data under matrix_dev->mdevs_lock, mig_file
> itself lives inside the freed matrix_mdev->mig_data object. Calling
> vfio_ap_resuming_write() after or concurrently with
> vfio_ap_mdev_close_device() will lock and unlock the destroyed
> mig_file->lock and dereference mig_file->matrix_mdev in freed memory.

Confirmed:
This is the RESUMING write path of the same mig_data lifetime
issue reported on patches 03/14, 06/14, and 08/14, and will be resolved 
in v12
by moving mig_data deallocation to vfio_ap_mdev_release_dev() and resetting
migration state on device close.

>
>> +
>> +	ap_config = mig_file->ap_config;
>> +	memcpy((char *)ap_config + *pos, kbuf, len);
>> +	*pos += len;
>> +
>> +	/*
>> +	 * Check whether we have received all the data.  We know the total
>> +	 * expected size once num_queues has arrived, i.e. once *pos is past
>> +	 * the fixed header.  Until then keep accumulating.
>> +	 */
>> +	if (*pos >= offsetofend(struct vfio_ap_config, num_queues)) {
>> +		size_t expected_sz;
>> +
>> +		if (ap_config->num_queues > MAX_AP_QUEUES) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		expected_sz = sizeof(struct vfio_ap_config) +
>> +			      ap_config->num_queues *
>> +			      sizeof(struct vfio_ap_queue_info);
>> +
>> +		if (*pos > (loff_t)expected_sz) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
> [Severity: High]
> As reported by Sashiko on v9 [1], can the memcpy() in
> vfio_ap_resuming_write() trigger a fortify_panic() on chunked writes when
> CONFIG_FORTIFY_SOURCE and CONFIG_CC_HAS_COUNTED_BY are enabled?
>
> In struct vfio_ap_config, qinfo[] is annotated with
> __counted_by(num_queues):
>
> struct vfio_ap_config {
> 	u32				magic;
> 	u32				version;
> 	u32				num_queues;
> 	u8				reserved[4];
> 	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
> 	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> };
>
> Although vfio_ap_resuming_init() initializes ap_config->num_queues to
> MAX_AP_QUEUES, fortified memcpy((char *)ap_config + *pos, kbuf, len)
> evaluates __struct_size((char *)ap_config + *pos) using the current value of
> ap_config->num_queues in memory before the expected_sz check runs:
>
> 1. Once an earlier chunk writes the header with num_queues < MAX_AP_QUEUES,
>     the dynamic object size of *ap_config shrinks to expected_sz. If a
>     subsequent write() supplies more bytes than expected_sz - *pos (while
>     staying within VFIO_AP_CONFIG_MAX_SIZE), memcpy() executes before the
>     *pos > (loff_t)expected_sz check and calls fortify_panic() instead of
>     returning -EINVAL.
>
> 2. On big-endian s390, MAX_AP_QUEUES (0x00010000) has bytes 0x00, 0x01,
>     0x00, 0x00 at offsets 8..11. If an initial chunk of 10 or 11 bytes writes
>     the upper two bytes of a valid num_queues < 65536 (0x00, 0x00),
>     ap_config->num_queues in memory becomes 0. If the next chunk writes past
>     the header into qinfo[], fortified memcpy() evaluates __struct_size()
>     with ap_config->num_queues == 0 before copying the remaining bytes of
>     num_queues, triggering fortify_panic() on valid migration data.

Confirmed:
In v12, will be resolved :
    - Changing ap_config in struct vfio_ap_migration_file to a void * 
buffer
      representing the raw VFIO_AP_CONFIG_MAX_SIZE allocation.
    - Performing memcpy((char *)mig_file->ap_config + *pos, kbuf, len) into
      the raw buffer so fortified memcpy checks against 
VFIO_AP_CONFIG_MAX_SIZE.
    - Casting to struct vfio_ap_config * and evaluating num_queues, 
expected_sz,
      and do_post_copy_validation() only after the full fixed header has 
arrived
      (*pos >= offsetofend(struct vfio_ap_config, num_queues)).

>
> [1] https://lore.kernel.org/r/sashiko-outbox-170099@kernel.org
>

