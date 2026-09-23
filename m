Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6E47F3CD
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161058; cv=none; b=cUajHxHp/1iMq3/hJM4Tlc42o0Uz1m7MfsJpttfRrkF1+Vrw9GbsuuttvsK4nSGPZ0U8vPqOe0djbDbNX9KSb+aLQhWcMMUnfDQt076UOvLpg/t4fV/CwgGiA/pdJOruh/8xI+buXAAPKw57rpnpHlFxbOSO55DbWbmR+/vJ0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161058; c=relaxed/simple;
	bh=jgmoSUvOEt8Ebsi83ebZwnWv1MPKT3cYuxyrV1Cnw/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niwRoDKTWvyvwrm9AdwdakI4Niw5tuEMDL49feHwJnFaHahwKZcZk9AuPVmZZmbhs/DWIZDm6HCSObBh+iVK5MA+a34MAiY9J2Ry1aV7nbbMGTRwhDVqAIMrEBvBDfv3EGARDUAxDX+6TmW4FJmxTZrt/ZWfPrUQMDqram60nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bec2+N7J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bec2+N7J"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Zh3w2742274
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rtel1J
	g8/ZFYRo7kYzMe67y2AVPhT3gi1BUrzg25sKs=; b=Bec2+N7JHxs47bPSo6jzX2
	YjLxSYGK3K+3pGNX1oLzaSlLR+OGGzMytsxPL+nApMXrhpCtoypNWaBQIiZz5T1/
	GBimb8VpgluSsPWyilUmSyHtPwZ4CZVFzs8lhrJjLWTFp2j0BHrvNghxxih6Vjuz
	OF2+13LnVeyA9aDpb3osUHgebNTNXkK8SNmbZw+J0nmKb3mAajf5Irk/euDNYhnm
	gPEEsIzd8a/rwnu4oOkNj2Ssp12Xl+kVvRLiHb5XApANXC7PcmSF19fRHKTCVBEM
	lfECPrC8cVOSL8fg9qb5M7ieccf2LguVWQyVz7C94svv7x5ToRSSL8099tQNtA2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1jajv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:57:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N95fh7005144
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:57:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8rcr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:57:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NAvQ7O44892542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 10:57:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601F320043;
	Wed, 23 Sep 2026 10:57:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED37B20040;
	Wed, 23 Sep 2026 10:57:25 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 10:57:25 +0000 (GMT)
Message-ID: <468a1b65-0701-468e-a9e6-de9d63493f88@linux.ibm.com>
Date: Wed, 23 Sep 2026 12:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
To: Alexander Egorenkov <egorenar@linux.ibm.com>, oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
 <20260923074006.3962077-3-egorenar@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260923074006.3962077-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5KsEeBaPhLpS01Cs6aPQHhQRkTEOUJuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MiBTYWx0ZWRfXxc6mSBV+pJp+
 FJuG5du6ug59HSxkgM28RGb8mk1Mpv8AHWMS4NtiBRWS/URMpN9a6wlaLOswL/TEeXFY9FwZbld
 H56gVlOtS0mRS0he3XbO5QCppSngYZ4wmgkbEPxFvwNLnhuz4mPaEkaT5qZPF7JeC3ZqLvBSs1m
 Ptow8R6K8N4xBfQ/LTk24M8WJXhbd+NEgMtT85i9b1DpBN8AcwOx4N4Ck0brmt/VbJrok4JI4Al
 KMgRSbAE6ziWaWNRx0mfStBYWab/MxLprjMEjvqYcij9hUux3qjhGqa3gpS/WARnw0t9uFeBx56
 6Q64+f98ltj0Cw+okP5q8ozn5ohddFGQagHb+js9j37vE9x8/O6zfzv3nzHNAfeLtdG7UIXdnWN
 SCk5M73UMWBHyiU97ktLRJ9GZueYVTyELaJ2upafaDDk2AP3cuMRTjlmPNkIH/W0hQ4ZClMQ43Y
 kRv36s3r6aDa1sDJVqg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3b09c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=djuJhc1BHunn01h8AqUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MiBTYWx0ZWRfX7YYz+NBe3FPP
 /Ohuc+Lnshp3I1Vhd+H9lZsvdKYN7rmTHbKWEAFLYOn2/91h/gTEV9I5cinetZV6r8OU3Rzxk1j
 LSukEOlKPDkO7x33rffznPeXx6rWccc=
X-Proofpoint-GUID: 5KsEeBaPhLpS01Cs6aPQHhQRkTEOUJuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230042



Am 23.09.26 um 09:40 schrieb Alexander Egorenkov:
> sclp_find_gds_{sub}vector() does not deal well with malformed event buffers
> consisting of GDS {sub}vectors. This can result in an infinite loop or
> an out-of-bounds memory read. Therefore, abort with NULL if
> * the next GDS header would exceed the given end boundary
> * the length in a GDS header contains an invalid value.
>    A valid length value in a GDS header should be at least as large
>    as the size of the corresponding GDS header (2 or 4 bytes)
>    but also not lead to exceeding the given end boundary.
> 
> Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
> of a GDS {sub}vector in a safe manner bailing out on the first invalid
> entry.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Fixes: 30c2df51173e ("[S390] sclp: event buffer dissection")
> ---
>   drivers/s390/char/sclp.h | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
> index b31a680e0871..a006d7abfdf3 100644
> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
>   	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
>   }
>   
> -static inline struct gds_vector *
> -sclp_find_gds_vector(void *start, void *end, u16 id)
> +/* Loop over all GDS {sub}vectors in a safe manner. */
> +#define sclp_gds_for_each(v, n, start, end)	\
> +	for ((n) = (void*)(end) - (void*)(start), (v) = (typeof(v))(start);	\
> +	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
> +	     (n) -= (v)->length, (v) = (void*)(v) + (v)->length)

void * instead of void* for checkpatch

> +
> +static inline struct gds_vector *sclp_find_gds_vector(void *start,
> +						      void *end, u16 id)
>   {
>   	struct gds_vector *v;
> -
> -	for (v = start; (void *) v < end; v = (void *) v + v->length)
> +	int n;

add a blank line here and below? checkpatch complains. Same for the next patch.


> +	sclp_gds_for_each(v, n, start, end) {
>   		if (v->gds_id == id)
>   			return v;
> +	}
>   	return NULL;
>   }
>   
> -static inline struct gds_subvector *
> -sclp_find_gds_subvector(void *start, void *end, u8 key)
> +static inline struct gds_subvector *sclp_find_gds_subvector(void *start,
> +							    void *end, u8 key)
>   {
>   	struct gds_subvector *sv;
> -
> -	for (sv = start; (void *) sv < end; sv = (void *) sv + sv->length)
> +	int n;
> +	sclp_gds_for_each(sv, n, start, end) {
>   		if (sv->key == key)
>   			return sv;
> +	}
>   	return NULL;
>   }
>   

