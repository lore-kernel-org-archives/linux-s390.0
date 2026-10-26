Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023468;
	b=zK1as6vAI43MrmQAqLTL6e/OPIWV7rXujhcOi5L1HC34jIqUQEVKCfmkScUOo0Jomym+
	 X1QmSJFLunG7ELkFnuml5ZhlFlzFqKXgUOFbJm/qObnmwlsC3B5X9zpt7TVTDAkqZDrGm
	 WUFHfx7ghxBhRQ8Sk/v6Vm02i6zazHYiFRqLi2eY1TuDHrX1DO3afnkQkSsMdyr41n0LC
	 B0EVFJ+/iKnxeL2MFYNzzFVkViiWChWX8+Q0p0mfnWRSMCBuvxiA33rmLYgIN5V5HohBo
	 4YAPgsQRyxgVBdIa50A96h/P1zsLZxfOzDopG2/HYXrppx+UOml4dKI1SX7tAQgxhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023468;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PuMxAq8ry7rkPRNo8bPxAsp3Y2xQSTcDNM5FlctNm3Y=;
	b=sGIXo8Pq5TDxw4YvRAv+i3gSa3LxMbImFnp3pGyv4Sp18DvsDq1paQJTo1PTKKXE4P91
	 wYnlRrKE+U5UOkBHk2DPi+jyAbi621+Xx9+17+t6qo2DKsWqERX669kgsj1dCQWQxwtT6
	 eD/biMr9Xm1vpaBz3j+HAcBa4eR6Umh4/clkxsjtk8pjZG/0ecpu0NrnDabhsYKVmnjbs
	 yQDDeEE43FwlHp3vF8xhDjRj0Ekwu9VvsMMtE2FUCTzgbqFxa6BW/qPBq0aVadA+dQx+0
	 9xRUnqdBGuYs2e6kfYECF3kG6F3ptKmo/vy2qjAcG/ZOtfeJpXGlm8mbmW9L+couVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WczHv1l5;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551A606A322;
	Mon, 26 Oct 2026 14:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4551A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WczHv1l5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEiR42189635;
	Mon, 26 Oct 2026 14:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PuMxAq
	8ry7rkPRNo8bPxAsp3Y2xQSTcDNM5FlctNm3Y=; b=WczHv1l5TOazfh0PnAEzes
	Qd7QtYSoqM4Pu74DM3sgyIyevq6tqoWsHNtSOj+Ji2BhAq9Rx+dOCmfY9F3deanr
	XBFMTwbN5XybZ2HekLpJki5jgaPyA+TEfdJzEZj4tkwD9/xJfU2blM0+Vs27OGb+
	weKJHo511MJYYo1WYjz8TBHvPhzQAxW9cLKirYeyWGDgiVn/YwC+7v+d+kf14/F7
	nd3buw7wKcBG/anvY/ZzeX2w4Uo4828vBS32QptpmQ9MZOmw87QqeUSAiX+9mrvT
	Xt6/dLyTN9Azu4z2IVSRhleCAEa0tUHcITR/N8AZd/blMVxYdYuuFdL4FVbUOJug
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3ft8j1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:04:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB4vt12397555;
	Mon, 26 Oct 2026 14:04:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80je7jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:04:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QE4PTM11272786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 14:04:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9115805D;
	Mon, 26 Oct 2026 14:04:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51D358052;
	Mon, 26 Oct 2026 14:04:24 +0000 (GMT)
Received: from [9.61.99.193] (unknown [9.61.99.193])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 14:04:24 +0000 (GMT)
Message-ID: <b544c525-f13e-4fde-a98a-3e41f1827ca3@linux.ibm.com>
Date: Mon, 26 Oct 2026 10:04:24 -0400
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
Subject: Re: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-4-akrowiak@linux.ibm.com>
 <sashiko-outbox-183045@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183045@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I-b_LZiAvJqRA3N8MXIvxgQWmPynsOsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXxcC4PE98AgQz
 Gq+Eiw6qAAq/5Esvd5WHSp8eY6+brnF0FTi4dgHyQhNB1/38k9T/dMAle5kw6TjLRZHC9Ap8roi
 nET2g5SzOsV2k6D0uUlRf5ehFjFs54ukMtC4QorVisxbIiYkf2mbVXg0rhfYu+WdbDvbToGcu3q
 Vkmoq6pAOZtfLMXzcmzmFu4mHPb5vRnfB2T1v0tXnROK/KY2AHAmqhj/l4YMrZ6LAgOm1X86joV
 FSojkaF2bupdGMLw/QgMrRR2RLyu5wkkVINsxglEzEjRVd7RBPrkdqsHQ7U8jEpgnHVHLRgY54w
 BR+VFbW6kffPaxDz8Qiookijfvlp+YZrxr5IuQJmQczuop7zXcD+XIn77vgdbgYLXvYbeXHWkqt
 t7iZ858lYFmUyPPineKHroSzniAt9A==
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6adf5deb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=B8PkBatXBUWJemwRq-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I-b_LZiAvJqRA3N8MXIvxgQWmPynsOsC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX76SUMlkYQkRf
 P7CfxINkR/qwFRUO9+DJ2WiCi1gG8IjIiho2ASBwGR755T72jFPcw/w2dbZB7qy7jn0evCt/a0X
 /uQ8dCfh3k06rkDJv1QCY33jyf214D8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610260054



On 10/23/26 2:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: ap_is_se_guest() checks host in vfio_ap_init_migration_data()
> --
>
> commit 79c297f4ef408f423e0eed3174df28dca4e407f2
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Functions to initialize/release vfio device migration data
>
> This patch adds helper functions to allocate, initialize, and release the
> vfio_ap_migration_data structure and its associated migration file state
> when a vfio_ap mediated device is opened, closed, or released.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index f01a37e4c418f..ba86a1afbb332 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> [ ... ]
>
>> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	struct vfio_ap_migration_data *mig_data;
>> +
>> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
>> +
>> +	/*
>> +	 * Live guest migration is not supported for SE guests, so there is no
>> +	 * need to initialize the migration data.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return 0;
> [Severity: Medium]
> Does ap_is_se_guest() check the right entity here when called via
> vfio_ap_mdev_open_device() -> vfio_ap_init_migration_data()?
>
> In drivers/s390/crypto/ap_bus.c, ap_is_se_guest() is defined as:
>
> bool ap_is_se_guest(void)
> {
> 	return is_prot_virt_guest() && ap_sb_available();
> }
>
> That helper checks whether the currently running kernel itself is executing as
> a Protected Virtualization (Secure Execution) guest, rather than checking
> whether the target KVM guest attached to the mediated device is an SE guest.
> Because vfio_ap runs on the KVM host where is_prot_virt_guest() is false,
> ap_is_se_guest() will always evaluate to false here and matrix_mdev->mig_data
> will still be allocated and initialized for SE guests.
>
> Additionally, vfio_ap_init_migration_data() is called from
> vfio_ap_mdev_open_device() when userspace first opens the VFIO device (and
> before vfio_ap_mdev_set_kvm() sets matrix_mdev->kvm), whereas an s390 KVM
> guest only transitions into Protected Virtualization mode later when the guest
> executes DIAG 308 subcode 8 or 10. Can the SE guest check be performed when a
> migration state transition is requested via kvm_s390_pv_is_protected(), rather
> than during device open?

It is true that ap_is_se_guest() checks only whether the host kernel 
itself is
running as a Secure Execution guest; it does not check whether the KVM 
guest
attached to the mdev is protected. However, when the host kernel is an 
SE guest,
the AP hardware queues are bound to that SE host under UV control. The 
AP queue
state on an SE host is protected memory and cannot be extracted and 
transmitted
to a destination host, so live guest migration of vfio-ap devices is not
possible from such a host regardless of whether any particular KVM guest is
also running under SE. The ap_is_se_guest() guard in
vfio_ap_setup_vfio_device_migration() and vfio_ap_init_migration_data() is
checking the right entity for the right reason.

The existing uses of ap_is_se_guest() in ap_queue.c (e.g. the secure binding
path) follow the same pattern — they gate AP subsystem behavior on the 
host's
own SE status, not on any KVM guest's status. The features_show() 
function in
vfio_ap_drv.c omits the migration feature token on SE hosts for the same 
reason.

>

