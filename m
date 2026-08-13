Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFB3B0AE7;
	Thu, 13 Aug 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632921; cv=none; b=AHHqcuhcaWtyz7qWoaGieKGPwFNJZP1V4DoB0BS5Qq9VBptcx/JrEfZBiln+mi6PsZkZOv4Fo9HvzEG1v/gPIcMqOFiWSCfPPJru8NzIpTS+xC+c4cITELaKjZRlhoX0AlJwcykmz2EPQ747Ty0F/CXkrlU5qYw8Jz7RH8ZaeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632921; c=relaxed/simple;
	bh=bm+2kJKxDMFBEJQwZ9eBuZSMUImpdvEG7kSORuPCZSI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g6p9/+1kpb8DPc/ViGH4QjXA5R/lbmM6Dp7yQHly+wxjCFcx2UVlm3mS3OE9+FNoGtiQ52Q747Fin0Vczp0Vhny2mIeetORJoH2AjCZizsQiEH48tUdsaiFk+bW+KZeWVhWfqrayOYd2GMn92SwumUwsJeltxpgkHFODoOVsYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r/Zy1kJW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r/Zy1kJW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCW3ox1237411;
	Thu, 13 Aug 2026 14:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=SfGH0/Dq6eCL71/4HKgFlAEXlaUwI684wNDczfIGctQ=; b=r/Zy1kJWYYHP
	HVtCayxW7kNobEwo/rFTcVSZEAhwIuBvM93NC261RIvyJ48LzLt2Wt4/mn4N9s6K
	GShqJXFnFnVBB0Fz6l+opqfj0+oo4+I4cekkhXV3OKWK8/TLjHsVZM+NFLOSHSd4
	UW2dmwTCeyDCRc1ha8xfxy889QpIT+pCKq+SLzeMufWbaQzrHYc9xP/QNZVP7+fR
	io7DI41LqZssfrQ5GnB6x5iYpd8TMdCYETNAMkEkePmKn7go+LCHbSmRONrPQiFH
	fUup3+TmN8prxt3FmLlhx8o4CQnvHruPPQe3TWhshcbipAROs4EzQ3VYV9527XRJ
	E2YcNHprLg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb240stn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:55:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DEfKML018320;
	Thu, 13 Aug 2026 14:55:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wbh08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:55:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DEtD1t22020644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 14:55:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C468F5803F;
	Thu, 13 Aug 2026 14:55:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5A955804E;
	Thu, 13 Aug 2026 14:55:12 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 14:55:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 16:55:12 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawel Zalewski
 <pzalewski@thegoodpenguin.co.uk>
Subject: Re: [PATCH v1] s390/ap: Drop unused member from ap_device_id
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
Message-ID: <91317610485023098128b74d9598a22f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ddad3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IpJZQVW2AAAA:8
 a=VnNF1IyMAAAA:8 a=WPGbp9lQNnpjazLkh7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwNCBTYWx0ZWRfXyHf2K3Dy6hp4
 PO5qQ/LUbvLmxY4YbDNOUWLNGhypVzHabp19ihn7jqeoJo8CAmPHiskARSAWRprfkwe4CO8peWM
 6wCG0Y8tencYcXR0qCgozsVlvCkFLb/lxhGAFfhXHOn9Y118ly1NjN9tKNRcTlc4mRSqLzcOxpj
 WrHNgapsuzei8Mx0AU3htGoLatuwx9p+oMKxrgEc2hy++Qd6ofAqu0h/6TpMEkKmk+dMW1t45Km
 ccZKpUu6GKDlZNpjrYqqfqjuNdQK1wQ0qcRZjkH6c8DM53uJAn01ecnBWnd00X+0xN5j64vQuTS
 rnNaAlbjcUI7lRgRkEv00JUKNWMYERIndNMYJHE5XYJljuzAzR/RxTDCaQRLhLB5zXebbkhjc18
 edUurDP/PWKvyj7wtI2MY7cofcyIsK0gARPstzz9Cn27+Loa3Yb63KWct/PVLdd547MyBxAm0XB
 /n6YN8YNrgkodE8c5ug==
X-Proofpoint-ORIG-GUID: ZNz8u_LtLsPZS4gc5L0suM0rkCdG_32Y
X-Proofpoint-GUID: ZNz8u_LtLsPZS4gc5L0suM0rkCdG_32Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwNCBTYWx0ZWRfX8GbFEROLQbKB
 pHRSPKv0S4haj8iWxh84f3fxqt10YeTmpTLDuUZgkw95V8o2TlYzU0y/bsPvAwiq/eIlSJOiafM
 oOEh7SEuHelbIQa6LaRf9YsEg/YA3bA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130104

On 2026-08-06 17:57, Uwe Kleine-König wrote:
> ap_device_id::device_info is not used in the kernel. The structure is
> also not part of API/ABI, so the unused member can just be dropped.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) 
> <u.kleine-koenig@baylibre.com>
> ---
>  include/linux/device-id/ap.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/device-id/ap.h 
> b/include/linux/device-id/ap.h
> index 0992333a34db..011af33c0bcf 100644
> --- a/include/linux/device-id/ap.h
> +++ b/include/linux/device-id/ap.h
> @@ -14,7 +14,6 @@ typedef unsigned long kernel_ulong_t;
>  struct ap_device_id {
>  	__u16 match_flags;	/* which fields to match against */
>  	__u8 dev_type;		/* device type */
> -	kernel_ulong_t driver_info;
>  };
> 
>  #endif /* ifndef LINUX_DEVICE_ID_AP_H */
> 
> base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
