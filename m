Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD9257854
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764306; cv=none; b=OjTBG4O+nb47HC1cSKJMQz0RFD2mChI9ImjNQL+8+FHsFOgil61W8WWKPm27cRLiIU+3FH5Il0yPUQj9EImrK+U6hN/YzPfxGptYq/vRjU0bZ2E31HsOcSyvrjo5raa73bnU8oApsAPU2+1NhWnRsk2aT7jmaNO6skTYQ7/HjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764306; c=relaxed/simple;
	bh=QDynQBb0yQarCshjiHKQoFmnAWZMucPEXgG+qmCjrYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRCmOXQUHDyY8lYVYdbRqfR6W7kE0GHybUGbj31ilzvlkDMlZ9iDjDrXEE+hgnH4ft3NLrQLT4czvD70yd7Ynt6mkXmP9xXa+56QdFVtSv4NgsdMcUcDuLrvQPgsKvIDQzrJ9gfcRKfTW3Itok7HdsGk7SYcKMglSWQl9kWa6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IhVxh9If; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IhVxh9If"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmbn2978041;
	Thu, 18 Jun 2026 06:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C8Tz10
	vku4Z4+7IRQcvVsvgg3FN/CvTBovzLiisguj8=; b=IhVxh9IfiUnefj2TDOXHaZ
	rGhIkdR6sxmJhiRhDrm7T02EW6MbcpVQ0Wcskx8kC3DfDzXh8v6Zv7PSU6RQijRj
	iBEo5dNiSluZrs/kqR91tnn1CocZrvFbMm54riXGpwgVuDypiWA3f6TVkxqg96jn
	1PGd//COv5izOblRigRY3XKg4cTO2eIE3hAoZr3GOoF407jNVhdY928n0sPQ0ITx
	8vLD6iaR14xIYkBC5GA7xhbSmIuig2ZFA2uJ05avcwPpm4i+xHeO6abpPZLof+BD
	+guSWtDYBtEoUm38Kqu4hzlnTwKzXIuKfp/seX4KdbBCAMyojD6LtmzbYkonw/mg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6kfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:31:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6Jubq017111;
	Thu, 18 Jun 2026 06:31:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722c63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:31:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6VX7228967354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:31:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DA942004D;
	Thu, 18 Jun 2026 06:31:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECB220043;
	Thu, 18 Jun 2026 06:31:32 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:31:32 +0000 (GMT)
Message-ID: <b8f22f51-2613-4213-a5a6-d6525b9c253e@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/17] crypto: Add aes-helpers file to support some AES
 modes
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-17-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-17-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K_d74zvR7wZiR44nr3tAVpHxW2FtIkSj
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3390c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=x69Jqp4PB8Y8lHcc1R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX61Z+rDB2BZqW
 pN3mhTxu0lNtWc5HFAdNHKdzMik/pkGnkijOo5Yvb27NvLH6YnPBmdSNITl1uuSwM0ga8pypW56
 sJf5CwY+Y5R53x5w9kQOfbzJavAypNI=
X-Proofpoint-ORIG-GUID: K_d74zvR7wZiR44nr3tAVpHxW2FtIkSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfXzFSR9wy86yZz
 d99Y8cshN5c+4eyBuf1fqWj6Va0GRiZg8FP6Fc4JOqm7UoZH6QpiAksJNGzT+yYYTrnP8O3qwB4
 mTXN6+En4ohX1sWT76o9RLqo3hUshC1iGqkbBQYkViQ656r439zNNN4U/QsgLCGkrKPtcqxPXmr
 28yFO28qx1B/9otHUqOZj7MYV1zAGf20mvJVrUDISuhRRu4DfRHDTatKSUwk2MfgDBfpplHaM5c
 DBU/dFbaEV+xs0r7n7JAiIc9C9GtKqVVhAYQnKSN8nYdikvoGjd2Jl4pyzdJ0GiXDFXj+tTUEOC
 EGw/9XL1hPSZmXXJS/WSH2oJYbg+/Hlp09NddqzgZMPntpQF155bLC/3me4NX5dmF5CyIt/bN5t
 xGT1h/yFKutIVWigNRM5W4HTHMvU8Hd8+dge8f1aPnMhUxOUa/Fb2AiVL1QUmoNZbXcm7BzIURi
 yzNr8DvO/TFLbX3Eypw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055



On 17.06.26 11:48, Harald Freudenberger wrote:
> Add a new file crypto/aes-helpers.c with simple functions
> to support some AES modes:
> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
> - AES ctr: AES_ctr_encrypt()
> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
> and some AES related helpers:
> - AES_xor()
> - AES_xts_prep_next_tweak()
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

I like this, but why do you do this so late in the series instead of 
implementing it directly like that? Otherwise:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   crypto/aes-helpers.c | 101 +++++++++++++++++++++++++++++++++++++++++++
>   crypto/meson.build   |   1 +
>   include/crypto/aes.h |  14 ++++++
>   3 files changed, 116 insertions(+)
>   create mode 100644 crypto/aes-helpers.c

[ snip ]

