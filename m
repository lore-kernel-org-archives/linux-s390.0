Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136223B6356;
	Tue, 13 Oct 2026 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895686; cv=none; b=Gh/XOf5Tv7hFhJbG4/CPZMrYlwkUD8hJ2fmFMHhxOU06VlOU8ZY46UP5ILpqqamm+b8G5i/1q7cm836W5mE/A5qA4ezA7OQlZO/52wn/czmzc0Sn8dexEGXp4r01a8AwuEdDE/yB3kph3oJp4k6L+5zkM6jv76jmk343VVNAj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895686; c=relaxed/simple;
	bh=9nsNO0g/KASUrdF+zvuK/zL60KsLE1kweEnLpZ7N1N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpbhaDWgHf1IpoY0KAcyEMCdDte9AktunTWW7b3ldPPVe4Io+RREEYbPnGf8+M4vXmGfMPiNu79GqyXTa2rYYGZz0d0d43Xz5oLB49y2y63EjY31MPtKtJmEmYxdXIAchHf2lIbGMW1KAZ/zfBiLo2PmBHBIhdYtttTvOyn+iDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZhQ2/8l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZZhQ2/8l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EBHL2016235;
	Tue, 13 Oct 2026 12:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0MnDN4
	gs6xjzjgCfJKFQozfchyvKXqC5YgyFK8yxbrY=; b=ZZhQ2/8lC3h51LfwueiD2X
	0bAdojvjz0i7CLdLjVqBv3w6+7/UjdFxtWLmr+iGEVfycuQe5hoQZPRKoWXjHjdk
	O87eyj6q6ZDYjaJr6hs8MXxUnLsAM0l2UEF4i13JUXWw+LmnPyjT31gO0snyFDbh
	mZ/IcAqIFDxOUwG/kgXKg8sOEG96ab+/v/V+jvUnJKCrGMnu6WuWSfA8uITCkytK
	Jfl5a0BmIzLtIfFCORigM0X/n/08T7aLK/ExY+KbcG3WC44uQUrAVSXZg52fTmSQ
	ai7G2lYJocgIqAFOAZgc9MUHyXSdq8hxuCBpWB9wC2BgUKBojl6Cb2E/ylByHXXw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7duge281-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:48:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCMY9B2660599;
	Tue, 13 Oct 2026 12:48:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppsyw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:48:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DCm22o30737064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 12:48:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14A5B58050;
	Tue, 13 Oct 2026 12:48:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1333058045;
	Tue, 13 Oct 2026 12:48:01 +0000 (GMT)
Received: from [9.61.17.246] (unknown [9.61.17.246])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 12:48:00 +0000 (GMT)
Message-ID: <449039c8-f14d-4a4a-b04d-d499745c5104@linux.ibm.com>
Date: Tue, 13 Oct 2026 08:48:00 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/15] s390/vfio-ap: Add method to set a new guest AP
 configuration
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-11-akrowiak@linux.ibm.com>
 <sashiko-outbox-165440@kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165440@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace2884 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=7yNgoilTr2P9NN8D:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=YG2yz8AqPtJa-em3xFMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: prio1xoTHCm3spudZrsR2peizeJN9QVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX5JzWJQg4dzEX
 zj6AgJ2TxwiQ+ynBfm0pLwUFeyuRdlRiHjD+0RKyUp5k9Ei9br/vGLiCb9UR/5nr29ys8gDiiXR
 nGW1J1sBKJ+zWz6KwANrfl6zq2Di6/Jk6sATogGBoSLKNQKQjQbfETTfK6yRQh5AptxXnaAqNbW
 11+kyk9bLTvPwr2HlVNTAXOMpE3ZVbVzpvU7tqvQO2PbyIFmEmGCS12PcvZezH5F54YaD8Pqe3f
 +fG0SbNDse604aeRqg/GebMJ/hQh5TklJ8B2NJzMtBPuoD8QkYh9/YXdFbcMOzQfnwGaitGXTH4
 n69vwIZqNFKrAAMBLVBynqepq8/6D1nb4nF/X9YveFRPkAV0ao7JiatDcHwH2I3mIogNjc93Ni9
 imYT2qAlAXvMZPTibDQSIcJoMD36CzcZZxbDTamVop6XBJM7drnNkhs/QeBLAK8EiFOFdP13Rni
 Y/c+FFhFiPZM3fbbE6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfXztECy9vHu5Yq
 Puhp3/Jg3pMmUJEpYEgTj/ZL7OwHTLxMTlDee20KbV/M8+QzeBwqaSitaAjWqTlD0trEr9t14J6
 RUnj6YUAbpdXissYHnl5u4H09ehP2qY=
X-Proofpoint-ORIG-GUID: prio1xoTHCm3spudZrsR2peizeJN9QVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130050



On 10/9/26 7:53 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] vfio_ap: duplicate prototype for vfio_ap_matrix_init()
> --
>
> commit e05cec73b2479bdf6aa3c63debaa31756d289ed2
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Add method to set a new guest AP configuration
>
> This patch adds a new vfio_ap_set_new_config function to set a guest's AP
> configuration. It refactors code from the ap_config_store function into a
> new, non-static function which is callable from both the sysfs attribute
> handler and the live guest migration code.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 9044ef4408c87..3910b5c023c91 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -172,6 +172,8 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
>>   void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
>>   			      struct ap_config_info *old_config_info);
>>   
>> +void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
> [Severity: Low]
> This isn't a bug, but does this patch add a duplicate prototype for
> vfio_ap_matrix_init()? Looking further down in this header, the exact same
> declaration already exists just above the newly added
> vfio_ap_set_new_guest_config() prototype.

The duplicate prototype will be removed for the next version.

>
>> +
>>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev);
> [ ... ]
>
>> @@ -235,4 +237,7 @@ assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
>>   
>>   void vfio_ap_matrix_init(struct ap_config_info *info, struct ap_matrix *matrix);
>>   
>> +int vfio_ap_set_new_guest_config(struct ap_matrix_mdev *matrix_mdev,
>> +				 struct ap_matrix *m_new);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */

