Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24132C3745;
	Wed,  4 Feb 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205678; cv=none; b=iEBETugbENEFcrAXPDBa26xsyISCbPYlA5PCrcGUQHAeknddjure/wPAaAxlW41uKl88R6XLh2t183I5Ym0aQe8wgIdbHTnqb+TX/VUnI4mxEwtG7pxUadI2Hos/nqz36ZIGo5ihNJMdZkL4dv2/T6TljmzMlXDaKTqFFXOT4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205678; c=relaxed/simple;
	bh=zm63p4BoOasofx6QJZn3TkcEuRg7um96Cq4qAYNg/vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ob+1PK1RJpAS9mEjRwPL6gKARBFJvlDdBKcHD0a/mR6MuL/qAMNiXebl/WbeD7jXbn7eANE/zFHRCsZX6HEa/jt8m1bUduFQywQ39J7NV5G6poFBZooAGlGjNx4qlZotLlRCd7v007r+0uT7vlbibij5OUtpBitc5YaWzgmCBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UP2CSSin; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UP2CSSin"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6144ggoY023248;
	Wed, 4 Feb 2026 11:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rWNaoF
	zYDYkptyQo8XPdtJMeLuhuZy/D2ImIdGHuafY=; b=UP2CSSinAekr1m1VEuLnx/
	XwqhGEYbTCQytRzJ0wAZjpuPqLpijKcFuItng+GxMLU0eprKEdBu3OQRAKIupP03
	yPT2fSEL9BTl7bqJA3m/dOThmt20oLPcjZQ3G8tnqGWlMORnJ3be7Uz6Y8tuw0DR
	Li+HRTi8SdvaZrxLOMfdAjc0xpJVwFd8qLr9eiHu+3J6A/doIKN9pBlsDbvEXVyt
	f0Xybltdv/FPeLMmui2IUYb2trX+hl3srpKS7gTFFqDGvN6FeSnge6NIkiIMpI6J
	mGG7nlJ5v0e8hvE0n0W6hXdzfGpD1l868hG0GJAUBOhFhAkyWrPupe/UhLsE1k/g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986hpyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 11:47:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 614Blul7004195;
	Wed, 4 Feb 2026 11:47:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986hpyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 11:47:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6147MAlC009156;
	Wed, 4 Feb 2026 11:47:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey54u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 11:47:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 614BlppP57606428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Feb 2026 11:47:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB172004B;
	Wed,  4 Feb 2026 11:47:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1FB20043;
	Wed,  4 Feb 2026 11:47:50 +0000 (GMT)
Received: from [9.52.196.90] (unknown [9.52.196.90])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Feb 2026 11:47:50 +0000 (GMT)
Message-ID: <1ab8cc09-5efb-4c7e-ba75-170e9b8d3815@linux.ibm.com>
Date: Wed, 4 Feb 2026 12:47:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cio: fix device lifecycle handling in
 css_alloc_subchannel()
To: Salah Triki <salah.triki@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130204800.217395-1-salah.triki@gmail.com>
Content-Language: en-US
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20260130204800.217395-1-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4NiBTYWx0ZWRfX4+uUfo/eOlHk
 KRSCilBLD5v5968Rb/yvigxgF5KfmlKwuN4DwugdwiXLOa6IZm2JD9Jo/5ll5gH0ZkDO+v2ZjgV
 zBxjnxFZcLvPC+Xpq4hwvggPw5hU/Jvb9BAg3lpQfcvRPhBjS8tx3qig83GqceSh3poKpQY4mAm
 glQTkmtD1z6OFD/hvMz10IY6ul4GIr0jP0y5hQGBjZvTvU/iLoIkUeJBO+1lTtHL8WHKLK10wij
 wfOQmVyPOanIahqerpcAtnvlTdnlWOywCYuiTEyDL3aZPw+A/fM36Unsf2RyN77SGnR0H0U+q83
 T/KtWpK9EKGz8KoZLtcv+YN/kVUPcsKSHsdmjYw6j03cMYDA24py6UGjj7u3bIxrnv4muSAmmO8
 0p0zzTaC0xgo98GcVKqkuZooln61jPem9YhcdmSzoitCWzeqFEWbhs8VkBLNv0YTFVZHrigqnoU
 n2ZG8cIO/PiWDUb4Vrw==
X-Proofpoint-GUID: zjznR82CQ_xg5mt10Z6pUkkcg-cbVKlL
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=698331ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=8-j6lBzqcow7hk2kIeYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H05tNg5M8hcKGhjh6SB3WcFICy5ws5E7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040086



On 1/30/26 21:47, Salah Triki wrote:
> `css_alloc_subchannel()` calls `device_initialize()` before setting up
> the DMA masks. If `dma_set_coherent_mask()` or `dma_set_mask()` fails,
> the error path frees the subchannel structure directly, bypassing
> the device model reference counting.
> 
> Once `device_initialize()` has been called, the embedded struct device
> must be released via `put_device()`, allowing the release callback to
> free the container structure.
> 
> Fix the error path by dropping the initial device reference with
> `put_device()` instead of calling `kfree()` directly.
> 
> This ensures correct device lifetime handling and avoids potential
> use-after-free or double-free issues.
> 
> Fixes: e5dcf0025d7af ("s390/css: move subchannel lock allocation")
> 
> Signed-off-by: Salah Triki<salah.triki@gmail.com>
> ---

Thank you.
this looks good to me.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>


