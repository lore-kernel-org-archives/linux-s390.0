Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E73DE433;
	Tue, 26 May 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793203; cv=none; b=C96l6vgA654nl9Qk9PAQV/Yed73YB7sD/TF5eMxdSt74XsflMCgynwFt3GqT5qokLM+3OL3vu1PJV1pPP3zlhwAAGADnsMeIKmyguAfM9f0xZKg2nO/+6o9vl6WSOPEVpZGz4HjruqVYMRPXXqRjrqIV2okInnmLDCT1LEOcpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793203; c=relaxed/simple;
	bh=0CXf01p+qqGlHFx8YiSdWeDIBy1qBR/dyjwtrgxi4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faFgx9RW2l6LV5jENo0ZEHpqXE1KA8Ol0/plLQUqYYFY1zK6C+z7HWOpfZD9kSxW78R7gseq5iLykMnKFooyYHls7JVAha2eycnvpHGYHZGpYGL38BmdDk3gUz5W7abc1IEUAk9QAEPK9Kf6LcgpjHRvJutzZqlSJzC4UBqjcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RIqA5659; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RIqA5659"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8WX642119566;
	Tue, 26 May 2026 10:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LC9aId
	eOuZZ6A+zkWyJ4k7aujHzldnLo7aiy/Nqtq5Y=; b=RIqA56597JExSzukXyKmb4
	n/G6jB8sOcYaJO1WG+UhpG3W0O/7Uv2flF9eIwJYMWu3pv/nz8guJ5x5vNCyWclT
	CO2MtlpJUTPBw+/4JZ6ygLgQn7/+Wg6GsekCM049uGzQpfhMAEoCjb4RyuREm3um
	Lm+a2l5SYmNwFCq6D5kn9v1GtuceV9KMkltK2tcqAOLO8RRa1ui5U3ZVs93ErYcT
	x1k5grOgZhefyaHpVSgD88U80+lRTolch9mPswrB4hSu6CE9hlfsKWV0E/T3YdKr
	ZZWUDK0StfMiupX/YxqUuxDJRzNOfJ1WP2bthT7dT50fioy1lU9SY8v2jkLF0A0g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nukr1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:59:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QAs86T015094;
	Tue, 26 May 2026 10:59:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg8sen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 10:59:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QAxTcG16580918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 10:59:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51DB12004D;
	Tue, 26 May 2026 10:59:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D4E02004B;
	Tue, 26 May 2026 10:59:29 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 26 May 2026 10:59:28 +0000 (GMT)
Date: Tue, 26 May 2026 12:59:27 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Sumit
 Semwal <sumit.semwal@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>,
        "David Hildenbrand (Arm)"
 <david@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390: export memory encryption helper functions
Message-ID: <20260526125927.6ed8498c@p-imbrenda>
In-Reply-To: <20260526102113.2594501-1-arnd@kernel.org>
References: <20260526102113.2594501-1-arnd@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5MiBTYWx0ZWRfXzwgIvSdJkGBv
 GLjLX1v+PurDD8N+cWAHySNG9ytX0J90HiSbyDvGc1Pxu/uafb+I+FMfbHG+wJE9Q3oZri9CQuI
 lCpe0QJPNJE8MtG62XLVVWl1jeL8LQwQ2o9dSs3x4vzJfJ5s2jGG/q/iTIzd98yE5mmjwHaCkQO
 Qulc8mntd5UlNNK4EQQpvEY4nqzvCBiZ68itQjXsudUMPzK1c/dybN9k7pPwXvF9dPGtNwG9rfY
 IlM9KGeyuvr+pT30uvbxYcPNdajdDo7ZY3iEXU57BAvasAYmkSLnoU+alEPLSyndbZD1pCV+rz6
 LxQb08qIWMJPMT+h6UgH8BuOeiuhSkqKEkxIeXaR6Rjs2o9NxHtGnklNe8+w/Qy7Yzoz0ToBCD3
 WfgJTRGtH/leQ12spIK8OdTGRlYW//S6x2eaeytUlQ1v5QZhFXJ94rZy0tLIQ2N/9KjAatWWAUg
 4uC9lbg08IE+zrY6cMg==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a157d16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nebloLCbriYy-_gPf0QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: VDGS-GTp1-JjMYUKbCbJc-4ugl_GyzwI
X-Proofpoint-GUID: M8sJtt1rKP0lsroqe6UlTFAIg3_TQJxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260092

On Tue, 26 May 2026 12:20:37 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The set_memory_encrypted/set_memory_decrypted functions are exported
> on x86 and arm64 but not on s390, which leads to a new build failure
> because they are now used in a loadable module:
> 
> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> 
> Export these the same way we do on the other architectures.
> 
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f07168a0d3dd..d589c5e4d388 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -124,6 +124,7 @@ int set_memory_encrypted(unsigned long vaddr, int numpages)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
>  
>  int set_memory_decrypted(unsigned long vaddr, int numpages)
>  {
> @@ -135,6 +136,7 @@ int set_memory_decrypted(unsigned long vaddr, int numpages)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(set_memory_decrypted);
>  
>  /* are we a protected virtualization guest? */
>  bool force_dma_unencrypted(struct device *dev)

