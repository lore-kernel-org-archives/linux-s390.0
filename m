Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8B4C74
	for <linux-s390@vger.kernel.org>; Mon, 17 Mar 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219876; cv=none; b=nEpsziwoDXhkdT8FHebD050QC+7lFv9+KP0WnyhLaxjBkCW73mVfG6VIBi22ItT2PuUdildpFiAJNNVU/BbOWV9TtoSRhV5wm+qnxYEQXv0kkMBwAfnuNoAx3DvGpIwv1jAwiSjzJKdiXCp5AEPCowR/j3OBFdLnxEnWNyPmRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219876; c=relaxed/simple;
	bh=Q4NvwUh9EWjd0LsB0iPy7PI12n7I2z1Qyq1WNB1f8dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9VIqqdmxGL19WTHYojsHTuoeQDUHbLIBUb/Hff1/T5od4w0bzlQ0TCXIQKht4riOv4OWY8z2XITg7HBI2ALe+w01Re3Y4xTCDAlcYdYtKRAjWx+1v570w0iLa40xXx9KYIQyoklNBVnIhafPbRrTQ6oSW9TFfu7SM+Q3swwDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qrREAL1f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrREAL1f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDa4Vd022041;
	Mon, 17 Mar 2025 13:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WKutxz
	JM+G1/kq6aGiMZp3SzvYOEzf/XUEA2ZR6pZvo=; b=qrREAL1fFyWHNRmYnT8XZT
	6oA6icYZeKk0/K6SqE/NqiAavGLk/YZq0q9LyCUFR3zs1CtcehRrMH2qk3t1UZQ6
	R8fNd9bY+++cU25+WKTB/j1ys+8AGjjCU2pH5k3GcMwhCWJ4+GnnyZ4HapfDGTcs
	WK1aiacBltmQFBkkLyPTKDxnouY+abet03Yzaq7wfCWQWzxrVhjpdXUWXR8eZjOH
	I1njANTjtJzONSy1EGZIw5yYPqfaIDCBFNSeKKNNOGyhIiaBTScy1rMAOkMdX+2j
	yAuF9RYlynsA7WE8JDx5DzEvO2SKXE63vdTfh4JLqAXzUwTa+sbHp9tP6xtLJOXA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks98fds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:57:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HBqXcJ009157;
	Mon, 17 Mar 2025 13:57:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8ypmvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 13:57:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HDvj1B51904912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 13:57:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10012004B;
	Mon, 17 Mar 2025 13:57:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3851B20040;
	Mon, 17 Mar 2025 13:57:45 +0000 (GMT)
Received: from [9.179.25.138] (unknown [9.179.25.138])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 13:57:45 +0000 (GMT)
Message-ID: <c7e66f88-8f30-4ee5-984b-13cfd733a896@linux.ibm.com>
Date: Mon, 17 Mar 2025 14:57:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] s390/ap/zcrypt: Rework AP message buffer
 allocation
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-3-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Z4Al6ub9Zxd-zjMhnC6hNG7gPVmPr6S
X-Proofpoint-ORIG-GUID: -Z4Al6ub9Zxd-zjMhnC6hNG7gPVmPr6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_05,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=963 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170101

On 04/03/2025 18:20, Harald Freudenberger wrote:
> Slight rework on the way how AP message buffers are allocated.
> Instead of having multiple places with kmalloc() calls all
> the AP message buffers are now allocated and freed on exactly
> one place: ap_init_apmsg() allocates the current AP bus max
> limit of ap_max_msg_size (defaults to 12KB). The AP message
> buffer is then freed in ap_release_apmsg().
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/ap_bus.c           | 30 ++++++++++++++++
>  drivers/s390/crypto/ap_bus.h           | 21 ++---------
>  drivers/s390/crypto/zcrypt_api.c       | 49 +++++++++++++++-----------
>  drivers/s390/crypto/zcrypt_msgtype50.c | 20 ++++++-----
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 35 +++++++++---------
>  5 files changed, 90 insertions(+), 65 deletions(-)

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

