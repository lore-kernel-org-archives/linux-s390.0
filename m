Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD844239E;
	Thu, 20 Aug 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231296; cv=none; b=cxHOTjXiFoPI8J4ihEV931HSWzLoey1iu110TwqXZcdDxzOfPx/NboxS0j4cjFWN41H7j7n/1rhghLX9ZLGp7N9ny5kFUzl+MEN5Iz0GuD+ceI1+lIcYD5za/IFVPRwbOc+uBAkHaMb8t5wvmX6NxoZBWFyS7ga9NmkQiutx2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231296; c=relaxed/simple;
	bh=SV4ZzdZaM8xOrzVt5VAw2ZwhxBkjTzcrF+ZD33vkc6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZZlyNEGljHAzqHJfqziwPM2cOci70wZ0ke8AB2gHnBBK7Ed6Lpcabn2nf8+bxzJHruFOp+OkGAwGBk7zUcl07zoaOhVhohZLFBpirIxCQJsfxKx0E8uIIg2OEDVK6+ph0jx0+zOomQ+E+M3+Mr+9W1qAsHZIWXv+N+FrJvqCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fwk5J7Xk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fwk5J7Xk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8uKDN471804;
	Thu, 20 Aug 2026 13:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7KxfmD
	84iWHcsrFL9boIWTrjLIlsWjUOpaKuzR3CQWA=; b=fwk5J7XkErqFtSitL9qnYs
	cuj7KYMsSmjtAf1j5SeW8EkBaxgXWGkbLaFeVBTzVNXtWtXFMAU+N/TIWiwEXdsI
	6wGLpbaZ2OIRR9i+nVZTz/Eh3UWiFrEW8J8zpmJOoNK1kBJSAuk3x/4QWCesa0iz
	eZCW9jpgJ9lndGyLmyYmUzNACXYsciDKrsKBWC4GMdVuU8oS1Fitypx1oniyD90x
	eUlF2goOceA4Vwoxj4SnjyE8AgV+t79BkvC3+IhQEnyO6TnuvGC4inT8pSC0UwqN
	jyKVw+Znezu9dtg79SFcnV5CTvowqCGjPg3UY+eQ3MDrX5tG0Hy6s7nmyXzJ4I3w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jgbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCuIZN019313;
	Thu, 20 Aug 2026 13:08:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twergp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KD861M32309816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 13:08:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20AC058055;
	Thu, 20 Aug 2026 13:08:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 852275804B;
	Thu, 20 Aug 2026 13:08:04 +0000 (GMT)
Received: from [9.61.142.83] (unknown [9.61.142.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 13:08:04 +0000 (GMT)
Message-ID: <8b8dc348-ac31-4dbe-a518-9563d5414f09@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:01:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/15] s390/vfio-ap: Add 'migratable' feature to sysfs
 'features' attribute
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-15-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86fc38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=z7pE9qEtJ7sZLzaIgg0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BSHDWtJU5O5LNzWBwGd1A3eSF0-9p3Zk
X-Proofpoint-GUID: BSHDWtJU5O5LNzWBwGd1A3eSF0-9p3Zk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfXwGUbmmWhueSL
 sdfuBUQxrmdpPVBoenkeI9UQM8pkHqzj0Mc8o0lkHehFbnmjsR8ty/H5kGARsosGeuf2GH08Wd1
 s5MASSS9oQWmw7a6m/PrFn4fnr7SW/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX/VKONcVsulRb
 pxMhjrTJoCBI4Ih2THQV9Hx1BNsCdfsQwOKFjvof+j+FsS4ciY4x/b5/WypiZTd2hSfqNtKZb50
 rSMz/FrZptizjzieXPs7WdK+7nM5O2sEKuSo/Rwl4N9qo822GhbLb5JGUvgoR5v/j69mUN9flpS
 Q2BnbJN5QsI6PFCIHVhqJ1a478kyRKrg7kpOWLSr5VgExWtiELafD9wcAakuyltImwICB2SbFUM
 1TEsuzCl2zk3SR1jT6wLCVNuClcRKhVPix5cqAGaY1jCeNxkn2OnDahvgfYoMEt8ceLbBvxV3WG
 aL4XPkB0/REEwt3A6gaQNI9VRF3e5dkqY7Ji4++ywLpjgj016senEHXDhdROSdAvNyMcUrYr6vJ
 ZgBfzHQ4/havjCrjPmq/C8qY7TTdLwgTkCVOmutmkmr4FdtRS6nonQAw4R5TYKYQ3XxSZRLUAWN
 P13scvWS0cDqMX0hkIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200097



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Add the 'migratable' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migratable' feature will not be included when the
> feature attribute is displayed.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 8e69ed286bb9..abfb34421d74 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
>   struct ap_matrix_dev *matrix_dev;
>   debug_info_t *vfio_ap_dbf_info;
>   
> +#define VFIO_AP_DRV_FEATURES	"guest_matrix hotplug ap_config migratable"
> +#define SE_GUEST_FEATURES	"guest_matrix hotplug ap_config"
> +
>   static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
> +	/*
> +	 * If the system running is an SE guest, it will support a different
> +	 * set of features; for example, it will not support live guest
> +	 * migration
> +	 */
> +	if (ap_is_se_guest())
> +		return sysfs_emit(buf, "%s\n", SE_GUEST_FEATURES);

ap_is_se_guest() is defined like this:
is_prot_virt_guest() && ap_sb_available();

is_prot_virt_guest() makes sense, this tells is this is actually a 
secured guest.

But ap_sb_available() "Returns 1 if secure binding facility is available".

What do we want to happen here if is_prot_virt_guest() = TRUE while 
ap_sb_available() = FALSE? Have you considered this scenario?

Also, the code would be a bit more extendible if you emitted the static 
string of always supported features, and then if(se) emit the string of 
se support features prepended with a space. Then new feature updates 
only have a single string to modify, so no risk of accidentally missing one.

Also, I'd consider using "migrate" or "migration" as they match existing 
feature designations better. We did not use hotpluggable :)

> +
> +	/* Return all features supported by the vfio_ap device driver */
> +	return sysfs_emit(buf, "%s\n", VFIO_AP_DRV_FEATURES);
>   }
>   static DEVICE_ATTR_RO(features);
>   

