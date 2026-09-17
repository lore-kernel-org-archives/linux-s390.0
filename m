Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5E224AF1
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649488; cv=none; b=NPnlKl/93Ubtnm5i3hNXvYqzxfAG/4etN6CySwjg+B9Bskg/RnsN1fMRFYpdiMcN/712IbdYZ/kI1tMl+f4eZKlKYVTWfbQi5WU9yy0MHI54O+b/5yTySeii37yeZd1rNPJQdBoxE5pbM0T7wtoIt60mr31NRwqo/esRYMYei4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649488; c=relaxed/simple;
	bh=XQKe/ha7zmWt/5MTCgonK0dm0aORJYddHUHhx7AKork=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQDmmrn3Dsj1J9vFh23tahA9xGP21p5ZHP6Pcgqj9Lo2G5fy93tFsHaE72tiqT2nxLATbeLx94p0dzZfBgzG2Pc3JsFFNiygL9wTYSQMX13+wa8jSacjehUFXYrHJgeEZe9NWvbLtKnC4p10tlHamEFy+V2B5nRm6owI88aobBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vsqve3FH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vsqve3FH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1XMH2191607
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7/HeL5
	l+lpIG7uCYyQ/Bt4xGy8PL0Pv+GTAHIxpWpiE=; b=Vsqve3FHyhlgXsoYk02ujY
	VdwYg1LKzIFvtwi5s4VYdQx+y2O7xy5lZMA7i6MLk3w42CHmPfOKSj8i65YBzipO
	h6vrt9ae7JNb5N8d0vUi1UNJwGW5JsLiycvlGGXPZnkgsWbcAhBE/mOPDgLiU6p9
	xySNvbGhs2uk8zOJr8NF3uyjb7jybkmmwxgM//EyVyhXmh9EP9za3eZ9HAeCELbH
	cFjOYzZjIt0vhtUnBM8rq4rulKFTcoEYGjizbl+co9yCNcU4BWVuhhDF5gucxaGT
	ledczc3OR5tdXvNxfyRdFQO3v2ulW5uBIPy0y+HOk6nA7mXs9QHqBHJo2vcTXX1A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx842egf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:51:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aJgP2899998
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:51:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjjefr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 12:51:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HCp2lE27984432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 12:51:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A829D58062;
	Thu, 17 Sep 2026 12:51:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D8505805D;
	Thu, 17 Sep 2026 12:51:01 +0000 (GMT)
Received: from [9.111.206.159] (unknown [9.111.206.159])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 12:51:01 +0000 (GMT)
Message-ID: <c052fd48-794d-4adf-9c3f-23bd306d5850@linux.ibm.com>
Date: Thu, 17 Sep 2026 14:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] s390/sclp_ocf: Fix computation of length of GDS
 values
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-4-egorenar@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260917065824.2858737-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfX58bTOM2Okwsc
 6ROWyQ8oSNbbsAyAoJAXTlTcQVs5xsTW2Z4xYnx/4NfxrPa30Bi8/UI3LRCX0ox8NBZTFdbFVNm
 o90JZO5MKyCH0Q0iIJsh5P9oHDbju/nh6mrvcF6+Pi+Qanx0acbnlx7PbHssikO/T7ByWyXhbuR
 /eH7xwjexhK7nTsxo7RstMhGHEgWwLdH0hsGLfSyyLKy2yCr6fRvtgxLI58X7KyPXiwMlcKQly7
 Suf0kbraln7u1LGVe1ZIeNOp/WtjAY2KnQzZqCkgad64aKoY/35z1B3DWDNo3AHgaamaKrhXkk3
 /tjynyrKc7yF94HJBkWgkG0Orbgy1rLGUd+SEgwhU7LCuyxDX++4AahlAftyukBKiC18uth8p3b
 s5u6XHzirQiIaurDH4u1JrZpXf0oHhxVCqhdud1qC0slDOzAAm7QKUQF6sqR6ZumoM85NFob9s2
 B/+2NdBjc8Rpfag2juA==
X-Proofpoint-ORIG-GUID: Y7dVSl1-988vlACe7451HLgPEgqHfU7v
X-Proofpoint-GUID: Y7dVSl1-988vlACe7451HLgPEgqHfU7v
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfXwZbP17pG9+Bn
 1mSJ/wG41CWmAflpvInCZN8lzcF3Oq5YnDg4/I3vw2YBaMPrRpGWkciAEIK0s16efSOapoxywRI
 YmjP1EvfqtUL2K9+3imjUYriHJYzUwo=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aabe23c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ioFTk4LWbP0TOPx-oiEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170175

On 17.09.2026 08:58, Alexander Egorenkov wrote:
> There is a potential invalid read memory access while extracting
> the HMC network and the CPC name from event buffers sent by OCF.
> 
> Both, the HMC network and the CPC name, are sent as a GDS subvector.
> A value stored in the length field of the header of a GDS (sub)vector
> includes not only the size of a GDS value but also the size of the GDS
> header. Therefore, to obtain the size of the GDS value only, the size of
> the GDS header must be first subtracted from the total GDS (sub)vector
> length.
> 
> If the length of the HMC network or the CPC name is less than 6,
> then the total length of the GDS subvector carrying it will be less than 8
> (length of value plus 2 bytes for GDS subvector header). In that case
> the memcpy() call in sclp_ocf_handler() will read extra 2 bytes following
> the GDS subvector.

Completely subjective comment that you can safely ignore, but this could
be shortened to something like:

Fix length calculation for HMC-network and CPC names in OCF event data
by excluding the GDS subvector header size. This prevents a potential
invalid read access beyond the available GDS name data.

> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
