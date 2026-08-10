Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46B35838F;
	Mon, 10 Aug 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384984; cv=none; b=ikS7MrGpJhJq6eU9L77N7gXLBMse+0WkXTe+VBkWNntQjyyf+YrQ7GGrWT2nlWZ5/hPC7egnAseiRw8qX9NsuEUQTqKcL9pjlhlIvO2MxqRXW0ZJ5T22j/WaxvrvM4tJt4IlUpAkloHxmSClO5esBgAdnzwme2pWR7c/QxeV19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384984; c=relaxed/simple;
	bh=pGeDz6tILl1Gtsabt3pyNwRLYyhZtk5j1+KP4w3APe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpUydmA4VHAWtKfQRoKll3GiBqdW/BHog1aZZiRduLk9wqrp6qzZSw1Iq+hPzBKTJRNnE40w4OmeAEMB0B1nGwYl8HAKY9v4mLdXOOKagBSdMIZGFkQORQD+sZJZMSUyc1zEnuzBgGptYMV6Kt9cnzfnYEjRGwB7xwLRWNPefEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=co1wzSqh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="co1wzSqh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVfjM2069661;
	Mon, 10 Aug 2026 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IOmL55
	W1COjRnG1FNEckiaOPDTbTom2QbyX65HqlwsU=; b=co1wzSqh1vPYHii/GgQTnO
	tWkzMh8j2w1Py4pbFSrrlrtXr3b+FHbdffP/Orgy9ZvAPldZvlEmz7yNHDzboofr
	UcY94xX3urI04nsVypKcY1WSo5LamYOdMZTC8nn192dRnpsxixpTUtXj/zh7R9dB
	zbnbuVzE6C5bLD9BCJrIEcsdOQH6CSA7zQRjZZ9S1p0i43K8CCtyH/P+ugmPa3Na
	Hr21ieJiuTQGhW/Fgxi5u1YcW9fVpuNMgSoNdhMUR1ZazuU8Cpgx5ay25U2hIuUG
	y+W5XlZWgjn42M+yAbb0FrJfbAL4ZaSJd8nXK/Z2iVKc1o1tjg2H0VaMwh0h4v4w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2ryq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:03:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHuGBc011609;
	Mon, 10 Aug 2026 18:03:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxwnuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:03:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AI2wcW63439208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 18:02:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4B55805A;
	Mon, 10 Aug 2026 18:02:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2474558060;
	Mon, 10 Aug 2026 18:02:58 +0000 (GMT)
Received: from [9.61.71.153] (unknown [9.61.71.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 18:02:58 +0000 (GMT)
Message-ID: <9ca7cfe1-7f4e-4e5a-b405-b82660b21254@linux.ibm.com>
Date: Mon, 10 Aug 2026 14:02:57 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-6-akrowiak@linux.ibm.com>
 <20260808173022.0208E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260808173022.0208E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a1255 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=G-DxkIJha76McrL11J4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YT0dq-V5cSkVcnniTNfAkAbsMbGSA1rf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfXwxIhIYdcUDTm
 CyqSNMbc4EMWGFZAZxJSU5u2iqEiVCNMtZKu9NyHrhn8NM+CaPD2P+sUeHS1U4dTk9AGTK17n+N
 1EYZrQKC9tIarTE/lemKAp6S/mwFELmvGnEzpeISYtUj+0UMwxd9lc59l2ZvBGeGeewJGseYFIL
 zBAiOcyohn4H87zGmFWWS8l1nnuiQMmywe+ZoTliGmLwXCpvbqHBa1IJTcWHq8qkUMkgvfUKAZb
 Jo2tK3d1LMzsXqsz2qJv1dHRkc2APhCT3fBaqpRWuMlaSu+2QegDyN8qBNAa0W0PnVSzPi6/m9O
 xl+M47xpGo8aq7xuOPF9QXrKLO3pB+3JhUrBMbrY+VjxdnKebbBRWTink6xoRj8RrlUUV+IvzXn
 Im2S4nD9+ZLVziTe3NcWuOJkyGFMKVWzAoX6EWSvHe8fFPamMB2h7j1sY3F386GzFGMlLwQtSIH
 KYbg97t3JIXhnoGYUvA==
X-Proofpoint-ORIG-GUID: YT0dq-V5cSkVcnniTNfAkAbsMbGSA1rf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX7VTpltAOskUG
 jHGG+SZovj8h0NPDNNH/f4N/GDJQ5zxtPmZj0ZoOxRuCMGWfMs5OUYAPI9J53iOfYUMgP+YXBS8
 mIF8VsSsiS+KUAipAhlNcUzEcRgVcLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100154



On 8/8/26 1:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing KVM guest configuration updates when the last AP device or domain is unplugged due to incorrect usage of `bitmap_andnot` return value.
> --
>
> --- Patch [5]: [PATCH 5/5] s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove ---
> commit c11c3bac302d3bc1f0a23db222df493383b0819f
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>
> The vfio_ap_config_remove function uses the bitmap_andnot function to clear
> bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
> assigned to the mdev). This prevents the explicitly unplugged control
> domains from being removed the KVM guest. The bitmap_and function is used
> instead.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 897518b88c281..9c7257c179a7a 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -2621,9 +2621,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
>>   		do_remove |= bitmap_and(aqrem, aq_remove,
>>   					  matrix_mdev->matrix.aqm,
>>   					  AP_DOMAINS);
>> -		do_remove |= bitmap_andnot(cdrem, cd_remove,
>> -					     matrix_mdev->matrix.adm,
>> -					     AP_DOMAINS);
>> +		do_remove |= bitmap_and(cdrem, cd_remove,
>> +					matrix_mdev->matrix.adm,
>> +					AP_DOMAINS);
>>   
>>   		if (do_remove)
>>   			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,
> [Severity: Critical]
> This is a pre-existing issue, but does the bitwise logic in
> vfio_ap_mdev_hot_unplug_cfg() incorrectly assume bitmap_andnot() returns true
> when bits are cleared?
>
> Looking at vfio_ap_mdev_hot_unplug_cfg(), the return value of bitmap_andnot()
> is used to determine if a hotplug update is necessary:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
> 	...
> 	if (!bitmap_empty(aprem, AP_DEVICES)) {
> 		do_hotplug |= bitmap_andnot(matrix_mdev->shadow_apcb.apm,
> 					    matrix_mdev->shadow_apcb.apm,
> 					    aprem, AP_DEVICES);
> 	}
> 	...
> 	if (do_hotplug)
> 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> }
>
> However, bitmap_andnot() returns false when the resulting destination bitmap
> becomes empty.
>
> If a host administrator unplugs the final active AP adapter or domain assigned
> to an mdev, the unplugged bit is cleared from the guest mask, leaving the
> shadow_apcb bitmap entirely empty. Because it is empty, bitmap_andnot()
> returns false.
>
> Will this cause do_hotplug to evaluate to 0 and skip calling
> vfio_ap_mdev_update_guest_apcb() entirely, allowing the KVM guest to retain
> hardware access to unplugged or revoked AP devices? The same pattern is used
> for aqm and adm on subsequent lines.

This is a bug. The author obviously mistook the value returned from 
bitmap_andnot.
The fix will be to check whether the input bitmaps intersect with the 
corresponding
bitmaps in matrix_mdev->shadow_apm/aqm/adm and then do the bitmap_and
only if they intersect and set do_hotplug to true.

>

