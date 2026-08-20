Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896D3E49E7;
	Thu, 20 Aug 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231289; cv=none; b=D5jiK2L4uSPUvVt1sxycQHJ7fjXpFHSBcBaz7QpQMhgB22llfQpq8+3JyrZ/rRI3VNwG3XWPOYPfRNak9ahoqr9O4YDzjR5jy8Bo8tNWRnNXsxjtOtcBG44BGRX4zq3+oy/e3LKMb92p/yK5oJv57pSlhQ+PiAF6vd5+Do4ITQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231289; c=relaxed/simple;
	bh=NooM5MGO2/yYVnb4NcfKvUnuF2oryYoLKWmw1wPoVx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzhRNvZ7znIkk23+rF5r2XqYMSAGFgi0AarRfmt4R063CL7ybj4fCS3S92ma6VZDSH2kA1ieED5a7Tv+6NFQKmEMXykSLCSqKRSWcESY2ACVQsTLzKzoycnEW+zCRyl1MeGmeFX8PVqT5+iK1FX6brKa7dsTrav8ybHDGSbdnRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGGNiw8T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGGNiw8T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8qMXG3543573;
	Thu, 20 Aug 2026 13:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UW86y0
	7xcHTCQpPxTv+g1B0tK0bnrQq3jMDCFIogGnk=; b=sGGNiw8TTxyI4UawrDl7C7
	CZXv4w6oHvt+gdhx0xzT7Jx3mlFENGrVu9mc+IOD9N1iRcparSPmwWMY5Wdjrfc0
	s0OfCPCzeu8+F1A4KTu6UV9Uu9oSPT7Nj4OjdmXTgHnb/dOPP5DAfRfC3WKhL+Vc
	9HDV+YhZzg8mWXe5maz4Aawm3wq6q75ROPdvWw1kEUzLJsNEcCDU32+W9xYQbqon
	wzcxjY7lSLgPB4rwlu88HMwry4+4KmJGXDNklZwE+dcrHAQ4bYLVT5a3omqV6vyP
	5071ngjUdWfucEI7oTzhg7dTxhTfLlBI/qcJ2fJIMKBJlq1OZ+al5cUmnDRbYNww
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2aax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCuMYB015205;
	Thu, 20 Aug 2026 13:08:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekep4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KD80Q029753894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 13:08:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B360E58055;
	Thu, 20 Aug 2026 13:08:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B81D5804B;
	Thu, 20 Aug 2026 13:07:59 +0000 (GMT)
Received: from [9.61.142.83] (unknown [9.61.142.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 13:07:58 +0000 (GMT)
Message-ID: <971d827a-c342-461c-8c05-929b02df6807@linux.ibm.com>
Date: Thu, 20 Aug 2026 08:43:34 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] s390/vfio-ap: Transition device migration state
 to STOP
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-12-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a86fc32 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=KcP-LE1D-P1WT8hqH2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f7Pb2eZuMPyRkuYNzaOq-72DINidSyJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX+KtNBeW9SI1w
 aVMb54O/8VOOyhAamGjx97mmR54Ar4xCn/NlWu9diFjLNwK70LbBpQJ7WYuWk4KuBwE+KjujsML
 0nDv71eqNfupaDJtpQ+TEZ8d6brq4276BD5Vh+84V1tFK6ucT5BtnsGx1WGkSA+9GrkdfvPF5+D
 3ih8ks9PUY+7tu2YzjbywZiEFmZP8uY/kB52l5rxQKcCPOWJ+P5gsAjHDKa4EQtPjV56uyaVroq
 WHD0Ld7H2nhnco7sQseVrEj88BflV+I/irzk3H58ouVOrlkw18DpOTrbICUNI2CykI4sLAHXvBR
 BxQuv40MJiBC1WSbIKFia8KSLpnqN+LQ8UcpmAGz2/id4yjbWUONOITMyBq7j+dseSoHGj+HoKv
 dxmpu7QbcZE027Do64B7eZyxLMgbOqpyaiGxzkBIZBV3WOxyNReVPfEae12g3//i9HaZWvNQNsA
 sWXC0Pwxe6DPmEkIoZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX3ZsyMR9sX5o9
 coG5KZD1pORRBJiKSUKpDIJ5jSxxXnTK2aD2kbf46aMqNtOdtMqUGgFAr6UZJJMYBdrh+ua+PNR
 UuCNORUVyDU/BpXRUIiFUgOenNNRARM=
X-Proofpoint-ORIG-GUID: f7Pb2eZuMPyRkuYNzaOq-72DINidSyJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200097



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Typically at this point, interrupt processing for the device, DMA and other
> changes to the device's external state must be prohibited. For VFIO AP,
> there is no physical DMA device virtualized by the vfio-ap device . It
> merely manages the guest's AP configuration that identifies the devices
> passed through to the guest, but does not have access to any of them. Those
> AP devices are passed through and controlled exclusively by the SIE program

SIE is an instruction, not a program. It might be clearer to say:
pass-through AP devices are controlled by the hardware.

I'm not sure there is much benefit to having this as a separate patch at 
all. You could simply roll this into the patch where this logic is 
originally constructed and skip this patch entirely.

> used to start the guest. There  only thing to do at this point is return
> NULL to the caller since the file streams and associated data will get
> cleaned up as a result of the VFIO migration framework releasing the files.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index 4dd7373c3d9d..30160e3ddded 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1511,12 +1511,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>   		return filp;
>   	}
>   
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * between the source and target hosts. Since the vfio-ap device does
> +	 * not virtualize a DMA device, there is no internal device state to
> +	 * incorporate into the vfio-ap device on the target.
> +	 */
>   	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
>   	     new_state == VFIO_DEVICE_STATE_STOP) ||
>   	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>   	     new_state == VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return NULL;
>   	}
>   
>   	if ((cur_state == VFIO_DEVICE_STATE_STOP &&

