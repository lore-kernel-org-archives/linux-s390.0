Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486621;
	b=JuVvfUMTCC/qG/N/Lv27BpuTfNJlvFjdhiELKZLPPlsfPn1m+hUyw2C6uEuwUcYJAQu4
	 WuXHQ8SMDJBLCjCmgq6aRvnnJX1bxwizG+LBLUHiOwLLjQOgxvv1Bkz8/HdpmBf1THdx+
	 YmksW13TlWG113VEvgX5U+2EWy78y6QD1+EjJjeHg7jZ/zt3XM5C58aZfV9E/u5d3TIqc
	 l4DId+5tLk252v9HWcbkB0BHYt0ksLVRB9tblwZm2qu/uwdvU3i85tDdvIlWw2P/sxBns
	 o7NtH0J06J30yVxKiARDbte5k4JdT6yOjW/4fRMKWs3fT9p0YiJdMQmm5FYYjqnfHiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486621;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Cj3Ij+gD3pAhnaPzvGDvSChqThcBsoLwEviqlfPVQtk=;
	b=VoEI07wYgNlGcnnxt77fbQ4rOaqoUqmYkv0us/WVzrNS2rRaul6Y4xmVRR1G82TypajO
	 kM9mwNpk97pg+dgSLV8WGgxwMHgcM+QvaSkEUNwad26GYjiUxSLqYV8NfKECvmE5wtdMf
	 ZJogcspgUoMSuCo/Vr7gaOJqp3qRqPvyB/SjWyQy1gAMSFzhxuBmlBcSyvdSuytkjYhqN
	 PO+JZX9REauWmrwV5GzVJnnt21jw9pdIFbRKc8PQl1vXHkFxFT/9lJXhECuE+Hhc8SKOt
	 hPfDCiib1mTEidRIbSAq88OWVQMtXuqHLR+5cLBiNqnxnDe3/qMf77W++aSAEXI5T6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="WQ/tsRED";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEA606A891;
	Thu, 12 Nov 2026 12:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCEA606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WQ/tsRED
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2igij2858143;
	Thu, 12 Nov 2026 12:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Cj3Ij+gD3pAhnaPzvGDvSChqThcBso
	LwEviqlfPVQtk=; b=WQ/tsREDtIPV7Lbql/CUKVbe0H0Wpm21xiFmBEk3xd8YeB
	5QJgQUR1sI2FDzUZQwPi4gaIb2yQqaCPmrnT7n8YjRmiQ/ArV4h9i7227YIebuGi
	+pKgP/ErqGaKG0dbwzqEZXZp3PQ0Y7FO9iJrXZYJVwE6Pt4mLM4+aZFUguZG54y5
	HB8pe5yjUjpTd2EDIMEJjxWbPdrWC25StgpjZ84SOcC3R9SYDbDrONkRqKrMOsHx
	EH2M+xlVT9/wuZ3+gfnwKltoG5nloS7CKbuzyqWIWHsX3VXjE4/h5uwoqdN6HKAw
	T6gW1JLTfZgvOKfQHads3ncoOb4SAobDbww+UJIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv65sf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:29:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACCBKwl669861;
	Thu, 12 Nov 2026 12:29:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd8581d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:29:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACCTXQB13894124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 12:29:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 084932004B;
	Thu, 12 Nov 2026 12:29:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF9D520040;
	Thu, 12 Nov 2026 12:29:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.69.86])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Nov 2026 12:29:31 +0000 (GMT)
Date: Thu, 12 Nov 2026 13:29:30 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Helen Koike <helen.fornazier@gmail.com>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Message-ID: <d812b71d-b7ec-496f-9404-add2282105a6-agordeev@linux.ibm.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX61PWThN5bLBB
 QHvsaKAzKaSemekTkz04TfXUL5f11+UWnI8aQzwwM2Nnf8f2b7WkCrqgqP99j3hHQ0OEU+bZSg0
 mPsk/wyxJKoRGOu6mxbHXMCSMDREZh4=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5b132 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=itkboQNlIvS3CmqEExoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MXa2Sk-_6Sw_bmg7o3uoEatjrHj-1pvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX6vLbARu7BivS
 zj1FORlMjbdRdBzJM9SUIYx06lNa0IOX3yDAVN8Qmu1OkDg7x9LTz4aSot0L08MANolZWays6Br
 KfJax0kAp4eIspAjOU2dHV95hkEP8oUgJf/p3Y/+1H96m0UWu7gHG0igGl50TLiaMF446dFqdHU
 tWer/PU9hA/4xF5IlzjfwQZnADKOIY1MgZYC9MoIq8ZnC1AKpuL89aXrs/xmOPGcFCn4maGw8pF
 59AA0w4KbGhWVDJHkgeCCAuDbqm+IoLUiZGCK8oMWE2rPGwduiiFLfFwDRIMpuwSrpT7hM0eA9x
 rba29btnR6kpUccVJ4iGr3RYCQSdwT6tvRs9BBTgPV4NUZ+suZ6+EhM3RpDmH/jYo9eT6yeEdQi
 17pzmOEjns87LdD3DNKI8MOPulpo/6xzEc9zWbvzUAMnoJ00RwHK/7OkcAgMg501+snBSAlFezd
 PJdds51219o+oqVUmxw==
X-Proofpoint-ORIG-GUID: MqkU3Q4i0ftX4RD9tfhyu81C8hZy5Ha2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048

On Wed, Nov 11, 2026 at 08:41:26PM +0800, Xueyuan Chen wrote:
> CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> counters are updated regardless of this option.
> 
> Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> debugfs is unavailable.
> 
> Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> documentation to match, and clarify the pool name in the debugfs path.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
...
>  arch/s390/configs/debug_defconfig                |  2 +-
>  arch/s390/configs/defconfig                      |  2 +-
...
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index d44674b63715..83193ef8efb9 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -100,7 +100,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
>  CONFIG_IOSCHED_BFQ=y
>  CONFIG_BINFMT_MISC=m
>  CONFIG_ZSWAP=y
> -CONFIG_ZSMALLOC_STAT=y
> +CONFIG_DEBUG_FS=y
>  CONFIG_SLAB_BUCKETS=y
>  CONFIG_SLUB_STATS=y
>  # CONFIG_COMPAT_BRK is not set
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index e00e252d4694..694a309377d5 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -94,7 +94,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
>  CONFIG_IOSCHED_BFQ=y
>  CONFIG_BINFMT_MISC=m
>  CONFIG_ZSWAP=y
> -CONFIG_ZSMALLOC_STAT=y
> +CONFIG_DEBUG_FS=y
>  CONFIG_SLAB_BUCKETS=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MEMORY_HOTPLUG=y

So DEBUG_FS is selected unconditionally? Please, drop this for s390.

> --  
> Best regards,
> Xueyuan

Thanks!
