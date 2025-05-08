Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA3252917;
	Thu,  8 May 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714006; cv=none; b=UUMS0SHD7SzCZn5drsRkzz2rYBkL3rjctKBZGsOsPZBxq3uaqw3syvHvUtbrmmms1xLcYmTFGwlFSzDQ7xgoOHi7qzM8bBHGEzOaqlcr9c1fgAu7MIX7jdPLxRqvqCdaE6Ft+Lg5rIA6iTcdQ4bf7/6/wUnEhnCKKvH7776GALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714006; c=relaxed/simple;
	bh=XrV4JuEsI8Hr/6XfZfbjC6QvYK6N6o9BjhUVHbxlRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oD6PsIfa4v9IzKaxtm6pSr2qZz9diaPyCFCqCcIH3tlAiECzOEHKWJ9ZEbZVC6T9j5NyJJbSMn2W8WRFd4VjN1dc/hTBNrYIuB/NOWvyIYJjEwtEsdALey7FLOkq0GOiX4FaxMKK0xPS/Zr7Uy4K65/31g/JZ+0QORu9reUjbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gON0YwD8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gON0YwD8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548AE8af023344;
	Thu, 8 May 2025 14:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BbdA6G
	SNDQ9l9N6NDx+sJ5cwcfZ6sHdcZUGqGuEPWxw=; b=gON0YwD8l1vsFPIPrbIThu
	w7JsCJNwG49wctABvueEcyp3Z9SeRM9nH9YU/O7oHIJOdT9bNYV5BrYn51KHTa01
	PQaCvi8RlShcWa5fyPMYMyaUCsN5YJU6J256Z2TA0wokV6G8aGzOthVfaJqrZbY7
	Wbx4n1m18xEbtOU3cL/GZR4raEOerLQUQZNbVHbcCBJOwBzWlBGclDbchjApa8v/
	Gc2z/gYXY4xwBh7v2876drPXs8CXSKB+LIunXMpqr8AFf7Ol2eL009RuseWcMS2a
	CX5xJFZnFs5nXzDb5YRoIigk/OiIkKrD6/FXVnjASXGOfo1AT8SPuPXKZ3/wia4A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gfm9c0ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:20:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548Bj8HG013861;
	Thu, 8 May 2025 14:20:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062nstr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:20:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548EJxkF6947410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 14:19:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C1385805B;
	Thu,  8 May 2025 14:19:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1809158059;
	Thu,  8 May 2025 14:19:58 +0000 (GMT)
Received: from [9.111.68.72] (unknown [9.111.68.72])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 May 2025 14:19:57 +0000 (GMT)
Message-ID: <6046d139-2a46-4824-bdfc-687750c1ee5b@linux.ibm.com>
Date: Thu, 8 May 2025 16:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 10/24] zram: add zlib compression backend support
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
 <20240902105656.1383858-11-senozhatsky@chromium.org>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <20240902105656.1383858-11-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMCBTYWx0ZWRfX7qBZo6asl6pf nasu5CtQ/I3nGuBpw4+0+8DD0dv/O5TGlM5VdB/a5UGJB2+BtwjLOvmKXhNePYIYjegfWujqUbs 2BBaUPKt4gy1UCT3NRY2JsBI6pycxIjna3jOM5pbSw3FPxFE3/pdTvL45XF9S4t6k3QaIojFX3W
 vqaKyfbihntn1JlfAwN4MggBKIlkX4SxvayT5UwMA1i8YeLmS5zQXqX5SrRRXZ+1MMfuV9UomSK Fl7z8Gy2/6z7RBM1GOn/cqlNQOCLkNYTi8wN6AxIDmKOtbOB4xwrRrJG6dx91rMCmAC/oe94ejX 2umkYoOdhs6uynkqqN3hLJ3SfYdxUIEEfXIr+sn6lvFyFhWFhazzkXiLnWR2c7bUolE1ktIU/aW
 sKj7VLVszDdQ12c+RMUlT9FPFOqx3d3jCO7zhb8Amd4f+LyOkh5k2XSpR4exTEx32IIQonYF
X-Authority-Analysis: v=2.4 cv=RIGzH5i+ c=1 sm=1 tr=0 ts=681cbd91 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=cm27Pg_UAAAA:8 a=EwjiY0pQsr8U1XeyRU0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8dzpQ9hiECxgtoxRz0_p9h_in7PeFIRc
X-Proofpoint-ORIG-GUID: 8dzpQ9hiECxgtoxRz0_p9h_in7PeFIRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080120

Hello Sergey,

On 02.09.2024 12:55, Sergey Senozhatsky wrote:
> Add s/w zlib (inflate/deflate) compression.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---

> diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
> new file mode 100644
> index 000000000000..acefb86701b9
> --- /dev/null
> +++ b/drivers/block/zram/backend_deflate.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/zlib.h>
> +
> +#include "backend_deflate.h"
> +
> +/* Use the same value as crypto API */
> +#define DEFLATE_DEF_WINBITS		11
> +#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
> +

I was trying to use a zram device with a deflate compression algorithm tuned for s390 hardware acceleration. While I was able to set the compression level via algorithm_params sysfs attribute, I figured out that the window size used by zram zlib compression is limited to 4K since windowBits parameter is hardcoded to DEFLATE_DEF_WINBITS. In order to utilize s390 hardware deflate acceleration, the maximum window size is needed (windowBits of 15), which is also a zlib default. Thus, I'm wondering why windowBits value of 11 was picked for zram zlib compression backend support. The comment line says 'Use the same value as crypto API'... could you please clarify here? Are there some memory constraints?

I tried to build the kernel with DEFLATE_DEF_WINBITS set to 15 and verified that s390 hardware deflate acceleration works for zram devices with a deflate compression.

Thanks,
Mikhail
