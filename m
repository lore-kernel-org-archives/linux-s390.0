Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950519;
	b=cc5zyf/2LihsD0sABUyCncfhNfaG/w+PpDD3GaMjUHmh2wxxBLlxL+GzuJ57fWUOso1g
	 w/zrSTMxaa1gEi9ZHb6C3q1Ih34evtM8R+j+t1Jkygt3QL9rhe6ZcB02fWiS8pxeIZddJ
	 3JFkKgMCzs7YZ3j3ytHwaDx0A/zXJdRz5Gj8yEdnxPKj1ujuQwV+9Ot1NLmCaraBZOYwS
	 q3fuG2Ni8PP3zGlgR8laEWhQtR9uA+wuV0sa0U5kPxn56UEzhdJ2ydE/+EYw9Qk2Hct9l
	 vyQWSt7RPIwNiwPKCgqh6nPc5KfRuVibPG87joUAEonvmrbYqDpsuxQqmLTI6YYaMXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XzgyPuhcROqb4nfXV5pSPi4MD/gL8O1srxZt18L7rzQ=;
	b=tPryQmmP7tFsyg85C0GiWd3wkrA1U03zT30ok9M1ugMqYjoO8r+ZwgJqRL6Y30weilcc
	 Kn68EAOievHTmWNj4X9+BjcWw27r4VsIeDjJkLleS0TZdvVp+P68VeFRvJMnkFtW68vLD
	 waI7suJSqhdMj+xGMH4QfTUvHUK3hatB0e8i5LEaoXO9IH4jcWLwdh+m7u6q9wdZcNLfQ
	 +VHzv97k22o1AKctCX3Sq6qMQ01k/Sk/88TW/4qrpyaPo/MD9c6I+08JvKSE9tHBlaliG
	 vI6BUqtJ82GwG5DzCyJMUCPwOybLh2OJUfe6/ROWoAFwHjAuCReidigXBWxtnQ5791w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r9lAF2iI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21558606A31C;
	Tue, 17 Nov 2026 21:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21558606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r9lAF2iI
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJQ5Lt1591183;
	Tue, 17 Nov 2026 21:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XzgyPu
	hcROqb4nfXV5pSPi4MD/gL8O1srxZt18L7rzQ=; b=r9lAF2iIkzezjW5h4Gm6d7
	MO3mMh5vTrnM6p1hB8BJoFAqJIVV6gXZrc82wTlqAGfA8CTM22BzHK2aLwidwcYN
	8M6QrZw0a/rvoYoE/Mz8bcfxhvtD2APzIdoLMDdP5YNyYOQlHVMRiQD1qiVffUN3
	yX3FwQQoL5R5ADjUZ8ClgDSPVD1yXZaTMld9EhA/Kv1hyTGcWtwFobDVv4qZEn+P
	D4NVGmvvbv72S1oEPxRMS55Rb4L34F5PBuO+GxZXj5cfWRAQOUbiG6IRjDwmtEh/
	AEP2Co+zFfLJq2swFkbkvByY85NfAIPoyN3AGHtQ51lyhfCycwUeE45Tzt/t4ufQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfat5g3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 21:21:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ6cLb3984352;
	Tue, 17 Nov 2026 21:21:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ndcxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 21:21:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHLLtdL64094706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 21:21:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D01C758055;
	Tue, 17 Nov 2026 21:21:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D419E58054;
	Tue, 17 Nov 2026 21:21:54 +0000 (GMT)
Received: from [9.61.4.73] (unknown [9.61.4.73])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 21:21:54 +0000 (GMT)
Message-ID: <5cb62244-d461-448b-b559-9f132d917c84@linux.ibm.com>
Date: Tue, 17 Nov 2026 16:21:54 -0500
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
Subject: Re: [PATCH v13 05/14] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-6-akrowiak@linux.ibm.com>
 <sashiko-outbox-209633@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-209633@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX5iCIeSrzKejG
 R2mQ9MhiycWFTnyvOmFkoe+P702bGBVbHh1YIJZ0EIPT6eD75U8lXG0BFJSDDTkKKjLtSOlAIGK
 wN+W7QpTriY1SIiXlMnl8urOvZrAYzE=
X-Proofpoint-ORIG-GUID: dPGlwZU_A3fzgztUmrZyiQptUCL6Zh3z
X-Proofpoint-GUID: dPGlwZU_A3fzgztUmrZyiQptUCL6Zh3z
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afcc576 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Td6lQYsFuNHRX64h0TYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX77A6CKcVYBxP
 qY2lLwS215YzKkK1rLFMdknXLDIXuV8xnM7DW7+cbexw1x9h42anUin85rqpsb+qoQ6Zrnz+fyU
 J6Pz9TrULg3Gqe5GUZwli6vm6Wd3A9PvbH1S5y2cE8IAGWiM2vCPspjx/WCcbBRlNtMVmEVBZnI
 ziWkF3J+LlFt08Y3kDpBFnW/EUEBRIqvzz74BaaegAZJUjg4VNIgHRZCjNYAhmFQbo93LJyaByN
 M9SFzbG8K9R3kWhLD2/RyUp4UYBnor56ybQtD+LeyngiA3HxF3x7mKhohw2mrPqGmkiK9AmAG9V
 SL6DmxM2qmNSDYjFQoFQjbXousp0JyG90kC9jAueReJOu++ugxKrlD5K7NPHemSBK5Fl0CYzxrG
 zYl/o/e3yPrOfms89EYYf/0FmNSpSG2fTqbbzucPrGr0FSQWroJXn0BmHvRAK+gaRbOquffHy5L
 Xni+wYanfmrh3+eZcDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170083



On 11/11/26 3:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] s390/vfio-ap: wrong SE guest check for migration in
>    vfio_ap_set_state()
> --
> 
> commit c3e849ed613219846146b19663fa802f6bc7ff34
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> 
> s390/vfio-ap: Callback to get/set vfio device mig state during guest migration
> 
> This commit adds the migration_set_state and migration_get_state callbacks
> for vfio-ap mediated devices to support VFIO_DEVICE_FEATURE_MIGRATION.
> 
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
>> index 94772cab1e855..df012f80ed0d7 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> 
> [ ... ]
> 
>> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>> +				      enum vfio_device_mig_state  new_state)
>> +{
>> +	int ret;
>> +	struct file *filp = NULL;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	enum vfio_device_mig_state next_state;
>> +	struct vfio_ap_migration_data *mig_data;
>> +
>> +	mutex_lock(&matrix_dev->mdevs_lock);
>> +
>> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
>> +	mig_data = matrix_mdev->mig_data;
>> +
>> +	/*
>> +	 * The mig_data pointer is set in the vfio_ap_init_migration_data
>> +	 * function which is called when the vfio-ap device fd is opened.
>> +	 * Since the implicit pre-open state is RUNNING, a request to set
>> +	 * RUNNING is a no-op. Any other state transition is invalid before
>> +	 * open_device.
>> +	 */
>> +	if (!mig_data) {
>> +		mutex_unlock(&matrix_dev->mdevs_lock);
>> +		if (new_state == VFIO_DEVICE_STATE_RUNNING)
>> +			return NULL;
>> +		return ERR_PTR(-ENODEV);
>> +	}
> 
> [Severity: Medium]
> Does vfio_ap_set_state() reject migration state transitions when the
> attached KVM guest is running in Secure Execution (SE) mode?
> 
> vfio_ap_init_migration_data() tries to skip allocating mig_data for SE
> guests by checking ap_is_se_guest(), which tests is_prot_virt_guest() &&
> ap_sb_available().  That checks whether the host kernel itself is running
> inside an SE guest, which is always false on a KVM host.  In addition, a
> KVM guest enters Protected Virtualization later during boot via
> KVM_PV_ENABLE (kvm_s390_pv_init_vm()), after open_device has already
> called vfio_ap_init_migration_data().
> 
> As a result, matrix_mdev->mig_data is always allocated on a KVM host, and
> vfio_ap_set_state() allows migration state transitions for SE KVM guests
> instead of checking whether matrix_mdev->kvm is protected (for example via
> kvm_s390_pv_is_protected()).

This is not a bug, and the analysis rests on a wrong premise.

ap_is_se_guest() is is_prot_virt_guest() && ap_sb_available(). It is
true only when the host kernel itself runs as a Secure Execution
guest. That is the case it is meant to catch: a host that is an SE
guest cannot run a nested guest with migration, so the driver does not
advertise migration or allocate mig_data. On a normal KVM host it is
false by design. It was never meant to detect whether a guest of this
host is protected.

You are right that a guest enters Protected Virtualization later, via
KVM_PV_ENABLE, after open_device has run, so mig_data is allocated for
it. That is harmless because QEMU does not migrate protected guests.
s390_machine_protect() registers a migration blocker ("protected VMs
are currently not migratable") with migrate_add_blocker() before it
calls s390_pv_vm_enable(), and it aborts protection if the blocker
cannot be added. Migration is therefore never started for a protected
guest, and vfio_ap_set_state() never receives STOP_COPY or RESUMING
for one.

> 

