Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFD501F2F
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648396; cv=none; b=EOr7Uhw0MG8A1A9f4yp++kY8Kcl9Rdx4w3DOqSercTt3rjSLQJKwU02iiqSk07XiKD036Qar8P7QT4OzGGZWYzGwjIg8ojDrMM4OMkdcYuLBFAbM7nmASqSSFPrxGWnf2RDs46O1WeekAIfPaWWTUD+oOaQBXzmtVJbtnA9A/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648396; c=relaxed/simple;
	bh=E6fpvgFV5IRTErq5Tn+3zRJIPx0OI9B0q2jtcVJijjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgzrJTJ8wSR/hF4wz5r+rv6FOScF3FtmHISbJG+ghzUVhtVfUO3J2MkWTIFVCsnrv5fabmrSNaFDO0WSaCm8npm8/6inlF9xHAj0lksJV3OZkVb1yQVOjWxOYEGhj4rPllQd3nmhoeBMFvkKGwXgixjAR3cRV+TIy6nv/Yv5hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rXJv0AmH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rXJv0AmH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1hpR322501
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iHq27b
	LB1QvYgpfgJjt96f1sGdRW5Gr8lURlbC/sFs8=; b=rXJv0AmHshNiw1JhuNbWis
	XQku5vfKjTMlls/k5ylrRUlQ4aZkoaw2xpx5INcqPPmEVUTH+ifx8LZibVvjffyC
	tID2cgICo9ZiWowVofp1kBKbE/FZQ2lB/EEkx+tflkimx5zI845aB2Mgtfg5IOcp
	DiVGsKmg9UEUqacYdrIDaBRug0jaZDLhgCRJTKiJV9LhKZh5BoS4yVHMnJzfkKj7
	weNo3x+C3N0mvoPE91XLEZNLhcRkMwsq4q4fSAD7D6g0Faon22NuL3cQdEvF+q20
	HUMpITOfDfKTvJXXWM8eGFXtaMhneRuFGJERpNHECZV7LSPjhP5xD9g3K3G7qgtA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqjb5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:32:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aJcw2899998
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:32:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjjcr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:32:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HCWsZQ28377668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 12:32:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF0058059;
	Thu, 17 Sep 2026 12:32:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E6E58058;
	Thu, 17 Sep 2026 12:32:53 +0000 (GMT)
Received: from [9.111.206.159] (unknown [9.111.206.159])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 12:32:53 +0000 (GMT)
Message-ID: <d007f6ba-19a4-428b-8973-b54c02bbfa57@linux.ibm.com>
Date: Thu, 17 Sep 2026 14:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] s390/sclp: Introduce macro sclp_gds_for_each()
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-2-egorenar@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260917065824.2858737-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfX54qc+usn3yxZ
 ud3ssK5O9SvsnZ8qL1mXShBHL+ZYT+2OvoRpCUFFG53p8DYsBfx8U/b20oWtzKJ9+vTFr0oc/JM
 uTmlG1AitT0YqA4EluKg8EHeBYM1JQDQDqTm78RThwuSPKn+nek4V6xZSyud0CvctlAkYJ5Iiih
 8nubJKjbjLgwkP9/UuuxFroSK0B5Obv6cy9C0IHQUzcgTY8AdWqomZreacO8ErECcgD6Pj2VTCr
 Mjil+EJh5/4IZLeHAQOIqFfYdzW1TYP+sAVfYmUiNMsPhqzW+y5kM3mUOPKROwATZdc2IcWSSnC
 qTNuNaeQ4o6Wf93Z7oPr0sfWTBY4r+uOt6mP4rKyZg9AQddnCqeGMMcDL+jSIYBGVCpCGmFixoV
 BWIK9CJj8/1OaSzuGvpUhoWZiq2EzWYd669Nadm294pu6ygLfSPnH6ej8mwCe4bgLumn3Cbuf7+
 2qfMRW3yzrf5m07BfBA==
X-Proofpoint-GUID: VoXESwaljm5tZsFKnLVtSWQQhZpEfAbq
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aabddfb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=2QRF4rvlzbZCWKtnG8MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VoXESwaljm5tZsFKnLVtSWQQhZpEfAbq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfX+0nVAhka1XxP
 wJ2wVApp5N0qL6XW6IWs56JAASeLF4H5au6XhhjwT5kkmWNkBj0Foue1DwNtVU6Ba5u18ZsEy6U
 zUirnAsVb2adZewafqsBEphrLDlHq8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170175

On 17.09.2026 08:58, Alexander Egorenkov wrote:
> sclp_find_gds_{sub}vector() does not deal well with malformed event buffers
> consisting of GDS {sub}vectors. This can result in an infinite loop or
> an out-of-bounds memory read. Therefore, abort with NULL if
> * the next GDS header would exceed the given end boundary
> * the length in a GDS header contains an invalid value.
>   A valid length value in a GDS header should be at least as large
>   as the size of the corresponding GDS header (2 or 4 bytes)
>   but also not lead to exceeding the given end boundary.
> 
> Use the new macro in sclp_find_gds_{sub}vector() to iterates over entries

"iterates" => "iterate"

[...]

> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
>  	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
>  }
>  
> -static inline struct gds_vector *
> -sclp_find_gds_vector(void *start, void *end, u16 id)
> +/* Loop over all GDS {sub}vectors in a safe manner. */
> +#define sclp_gds_for_each(v, n, start, end)	\
> +	for ((n) = (end) - (start), (v) = (start);	\
> +	     (n) >= sizeof(*(v)) && (v)->length >= sizeof(*(v)) && (v)->length <= (n);	\
> +	     (n) -= (v)->length, (v) = (void*)(v) + (v)->length)

Since "n" is likely never used by caller-provided loop-body code, would
it be acceptable to define it as a loop-scoped variable, e.g

  for (int __n = (end) - (start); ...)

This would remove the need for the caller to provide the variable.

Also an explicit cast of "end" and "start" would remove the need for the
caller to ensure that both parameters are of type void *, i.e.:

  for ((n) = (void*)(end) - (void*)(start), (v) = (void*)(start);

This would remove the need to add local void* variables as is done in
patch 2, and reduce the chance for callers using a non-void* type
parameter that would lead to incorrect calculations of "n".


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
