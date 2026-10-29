Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292818;
	b=do+ntVCpK1FEF0MuTRrLswApPEkEjmBZae2RDkfMKWc1WmEuY02GnCiVb4wtBmWziGYH
	 /WTWP39RVrTwQS39gVJxxAYld9GXlnCx6v9kCRb4XRR1Cft+KDBIaPFoMCPagJ9Zezu5h
	 pIQ2tO14nicV2e+YjAP9eLTUHU+biBvmm7ws8L3zGyP9FLQi8YwbH5hB5t5HADgEmpRwJ
	 8mHZVT13KtO4MnNUegj7isyBZabmY5QXjptuk0+SxnJP8cZM2QnIvnFFysvvWjpBhR81S
	 PckgTZo9Z4BMT5TwFkgCGovaZSp6IgKD9HIeCy13JUQ/HfplKLEh6bGoakMTg5CZ2xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0VTQp+EVKn1QJ1lsjGVpGWhpyzchj1Q/Gv/8uf4gnIM=;
	b=XFc/zP7EVaoI1B2B54AWCWm9Trnd2iZ897MAQ6lhZ6rkU5XsLXZpxz+hI4OazCrSn4ll
	 ycZEKLvY+/DMocqSSJn4jBpQSA1e3naesCqlYq91cGQsSxLdDUVGkWg/BGmyvQhnYW1mU
	 hEf7z+KUiVyFvEq97KozsTViR9+XodujtEw3LBk14N2nQjwoeIblqxRHbFPHeguuctQhQ
	 juLB2MEFX7EFswoF11xES04YTYTboONIyZEgnyFXQqtHZo0rKPLkrtkdT9i/iszepn9m4
	 q6/uJcAjwn7dfIm5EIOiU7grAHtmjq7BdgYYzHtO/hkzc5FBvdvTAoGRdaPx4efTjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yt0vGlCu;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB775606A31A;
	Thu, 29 Oct 2026 16:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB775606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yt0vGlCu
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGE5l13038771;
	Thu, 29 Oct 2026 16:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0VTQp+
	EVKn1QJ1lsjGVpGWhpyzchj1Q/Gv/8uf4gnIM=; b=Yt0vGlCuYwgbO2ReVysSFw
	DfqjoTV8D/FrHH4eIKzHGYM+QcZFTHqzGgNqpCrLk77vcz/TwDyUM84y0OsX2uHK
	wje+EEJMUMQiT3eG+5l4dXjTzQeMNC2SByt9WXkCejosVxcU18Mc102KhKpQKNtJ
	XqPVmFuMlgspnA7WebjCOHwYYmqcYmBfKBqHXDuiCqz8d3fgpz4PLhvMR+owVaIW
	WeKmgFGz4fAPz6FGMBxNsRALpIZ703O7xQl2POO/Gu8JtMMXFNMVenNVhqHRqUvM
	PMftDxEfOaDfl54hVEKFU3BctG5UjEEn7mtxOIen6Jaa3ZikQt9JGuDTXZf0/txw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbtbm4n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:53:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGK2mX3449980;
	Thu, 29 Oct 2026 16:53:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm6pb8y88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:53:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGrYfr35586318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:53:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFAF658051;
	Thu, 29 Oct 2026 16:53:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E61258060;
	Thu, 29 Oct 2026 16:53:34 +0000 (GMT)
Received: from [9.61.101.238] (unknown [9.61.101.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:53:34 +0000 (GMT)
Message-ID: <ff8b2e7e-e0f1-4228-b38d-45c1ae52e378@linux.ibm.com>
Date: Thu, 29 Oct 2026 12:53:33 -0400
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
Subject: Re: [PATCH v10 14/15] s390/vfio-ap: Add 'migration' feature to sysfs
 'features' attribute
To: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-15-akrowiak@linux.ibm.com>
 <sashiko-outbox-183040@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-183040@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX6umXh++RFwSg
 cFjHDoEqG4au2d20sLU20XfpqAs2Vf8LJ86sNNNmwm+TKzv7jo5RilBS1UL5gjiFWK65RiYuJOK
 Cf6V9sFGaFpT0m8pNjUopTiY/PJwKe6hvqPuDsq4ugsJwGpgPaLVQlHOAAZaVCR0662IVSAyTSP
 5A7oU03GBCnaIRr1V4xKa/1w7Og0IOT7hs/U9KiDcbMHNQblq8b1t2993qBc834xa55y9VSEx5e
 ovhYWS0zT4ZYpLZaRQPF1GhGbqw906t05cuqXiqwrTCfyEstsFAI6XFT4agpsAXQXHSUgUT7Xt0
 12IRyTd9mxal0jXeX9ka2ocMWkpYicKQphGW6y5FuIDrmOdgh5un0+4imEg9rydR1+L3mb9ZgwY
 ZocpxQ+E+Dl/sdmXF1NPDQHaBC5frc6YP71kQqv9fK2gFH9/ZRIhCMWZvZoWkaifUuamYNxpb1s
 0FXyiSdBtXyz5XIReUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX9gH2hNn4QTqk
 cAorZDhf0cSX6mahoKpaMk368r1QfIwQbd9CQEEoJsRdAJtckwUs+ruvoj/yu6oK64T1pjwSVVx
 uv6Lyu/q8fy9SDal08I3D0LiMtTvrqE=
X-Proofpoint-ORIG-GUID: KPGB36moG6i5XLRbAaYnj9gkQ-IzUuzo
X-Proofpoint-GUID: KPGB36moG6i5XLRbAaYnj9gkQ-IzUuzo
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae37a11 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_DQi5qwBATJB8iS1gjQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290065



On 10/23/26 2:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] s390/vfio-ap: features_show() uses guest-side ap_is_se_guest() on KVM host
> --
>
> commit 43fb24f8f56fe7dba5cb74bbc8da847cfac6779e
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
>
> This commit adds the migration feature string to the vfio_ap matrix sysfs
> features attribute unless ap_is_se_guest() returns true.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 8e69ed286bb9c..c63a050a23569 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
>>   struct ap_matrix_dev *matrix_dev;
>>   debug_info_t *vfio_ap_dbf_info;
>>   
>> +#define VFIO_AP_BASE_FEATURES	"guest_matrix hotplug ap_config"
>> +#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"
>> +
>>   static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
>> +	/*
>> +	 * SE guests do not support live guest migration; emit only the base
>> +	 * feature set for them.
>> +	 */
>> +	if (ap_is_se_guest())
>> +		return sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
>> +
>> +	/* Non-SE: base features plus those not available on SE guests */
>> +	return sysfs_emit(buf, "%s %s\n", VFIO_AP_BASE_FEATURES,
>> +			  VFIO_AP_SE_EXCLUDED_FEATURES);
> [Severity: Medium]
> Can ap_is_se_guest() ever evaluate to true here on a KVM host?

Yes, if the host is an SE guest trying to migrate a nested guest.

>
> Looking at drivers/s390/crypto/ap_bus.c:
>
> bool ap_is_se_guest(void)
> {
> 	return is_prot_virt_guest() && ap_sb_available();
> }
>
> and arch/s390/boot/uv.c:uv_query_info():
>
> 	if (test_bit_inv(BIT_UVC_CMD_SET_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list) &&
> 	    test_bit_inv(BIT_UVC_CMD_REMOVE_SHARED_ACCESS, (unsigned long *)uvcb.inst_calls_list))
> 		prot_virt_guest = 1;
>
> is_prot_virt_guest() checks whether the currently running kernel is itself a
> protected virtualization guest, which is mutually exclusive with running as a
> KVM host in is_prot_virt_host_capable().
>
> Because vfio_ap runs on the KVM host, ap_is_se_guest() will always return
> false in features_show(), as well as in the earlier patches in this series in
> drivers/s390/crypto/vfio_ap_migration.c:
>
> vfio_ap_mdev_probe() -> vfio_ap_setup_vfio_device_migration():
> 	if (ap_is_se_guest())
> 		return;
>
> 	matrix_mdev->vdev.migration_flags = VFIO_MIGRATION_STOP_COPY;
> 	matrix_mdev->vdev.mig_ops = &vfio_ap_migration_ops;
>
> and vfio_ap_mdev_open_device() -> vfio_ap_init_migration_data():
> 	if (ap_is_se_guest())
> 		return 0;
>
> Additionally, /sys/devices/vfio_ap/matrix/features is a host-wide attribute on
> matrix_dev, whereas whether a KVM guest uses Secure Execution is a per-VM
> runtime property (such as kvm_s390_pv_is_protected(matrix_mdev->kvm) after the
> guest transitions into protected mode via KVM_PV_ENABLE), and a single host
> can run both SE and non-SE guests simultaneously.
>
> Should the SE guest migration restriction be enforced per guest or mdev using
> host-side KVM protected virtualization state rather than ap_is_se_guest()?

Yes, ap_is_se_guest() can evaluate to true on a KVM host — if
the host kernel is itself running as an SE guest trying to
migrate a nested guest. That is precisely the scenario being
guarded against.

The features attribute is correctly host-wide. Whether the
host can support AP migration is a fixed property of the host
kernel determined at boot, not a per-VM runtime property.

>

