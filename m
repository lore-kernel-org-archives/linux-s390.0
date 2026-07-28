Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA962D0614;
	Tue, 28 Jul 2026 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204482; cv=none; b=p9jpR6o+7gZeRXXHmhbaw73PmxZGleppBfH0MlW6rMjPCmjAoIhOOG9ayXzMJ6hBcA8HNKVjqoeu5T8PGIB5Pn+rg+qWl6Z4pkeqOygqQrJILbJYWhR6OHwgx6Za/w+RWLwCvEx2V2jj5COQ2AX4oKrRgd6n6G0NZK5sH7Y100U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204482; c=relaxed/simple;
	bh=Jwp6BtvWqAIFGVTNPLtN5FqIXfzpGqDtYmyhSyLXNMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaRb+GWQOIQd6eEXrGwWLDPjph7DzBcjBHaiXdEMdCaB35Lh+JGG8c9Gi+1Tm0I0WTuIHDD1bRIDAUdHXwR4Zp77p/Of7XVCfqeb1AVSjKXTYREN0tuId0/pB6POLbvjaZsoB6d3fTq7k6jJOJm7MGeORrQXUywloB23sZz3i6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xh7F3Qrb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xh7F3Qrb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0lnpg3675510;
	Tue, 28 Jul 2026 02:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xbl+tU
	YTSErcwxtPO/i1osVgwyJ30Sm6Va/OZo4mgAU=; b=Xh7F3QrbGLbEAhTmEOdJMQ
	BmWuRgYo1/dyfBl+I4rl8e+qZaCSkBjq+C1ul/KVPDcAQ3FwjqzDul9krxgq3THJ
	9TVN5LFwRqboiL8E87Nt5i6j+gGTCS9STIX4kd/GvqiP9ZD0nuXDCa4U7wetvkfF
	aAzeMe9D+Q3kN46OfD3aUke2JnzJNYkmaaYpUNIICJ2NENrStHfdnZk90ceX5P9F
	NTyKqWIOn+Xzpm0D1n4nt74es5tE28W+I7HJHwdorsTNK1A8w6Z4SHEhBGF3Rlnc
	SldIMTayn+H7AF7Q9WB9gq5Y1KflbN/PudCc6H8Wt6NnL89RtKpmPb07/hFhoABA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj2g61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:07:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1uKh5014938;
	Tue, 28 Jul 2026 02:07:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjyv42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:07:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S27vJp32113176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 02:07:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A960B58056;
	Tue, 28 Jul 2026 02:07:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2712D58052;
	Tue, 28 Jul 2026 02:07:57 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 02:07:57 +0000 (GMT)
Message-ID: <e0cc1373-0888-4518-8bf7-91cc3713c595@linux.ibm.com>
Date: Mon, 27 Jul 2026 22:07:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] s390/vfio_ccw: cancel existing workqueues
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX9CbPDKCbypEI
 8jnhvdAOFqvfYUL4+gDJGdW5MDbdayQCi+11SARgpv3jUVhUnC0x5DOdNAdc1FvLMEllDOzfMzE
 gxaU2CPChjBAKD3/ooTAMw89gJWj7Ng=
X-Proofpoint-GUID: tnqmqTPbudCkKjVoPp91IRdAdR3RWMMI
X-Proofpoint-ORIG-GUID: tnqmqTPbudCkKjVoPp91IRdAdR3RWMMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX9fII8/Cv5oPc
 zWZLreKfhGrSPW49J2u/7JdzASTrSva/WDob52pB69JLXVIUsjPejYFzE6wGYKgKgUyEz590l93
 TgXe82Zs5wQKRBle4Q9vlIT1zZGHzkjex9dOdr/roVJ+3pwtHjNxPl70TMHtCvqmWooYMycgAbt
 o9wuzdc52wLmmM2kIHeAQnm3GVVwkFv8Xpmp54AhA/1yimjE2BGq5G5z4H+VAMePPzSfsnjAbPX
 OZh18Bokp83UTV6qmqZmiG0R2lAzxgFzgE5BZygyx4+xSZ9/qNlq/v7AI+UvQOJ4o9XE2etdesM
 AmpYtDw8VMg2orTrLO2maVZPx8KN99/qhzcozDv0N1jU0nV05/gYGVD0JPzATqXZoeuObKS5MWO
 uxZza+aPgmdlz5yhEh/m8xNlhTZnd/3NGGykVWSyfj3qFCxfgZq37oMS5lZ+WDQ+HTEnZnREegv
 yengVRYBJUzZzLLz73w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a680eff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=wUE47ySAcWlnlIsVtMMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280014

On 7/27/26 9:35 PM, Eric Farman wrote:
> The initialization of the io_work and crw_work workqueues begs the
> question of whether they should be un-initialized. Add the corresponding
> cleanup tags in _release_dev to ensure work isn't dispatched after
> the private struct is free'd.
> 
> Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_ops.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 032a1cdf4df7..bc8eb485d03f 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
>  
> +	/*
> +	 * Ensure these work items are fully drained, so none can
> +	 * fire after being released.
> +	 */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
> @@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	/*
> +	 * Ensure these work items are drained, in the event the
> +	 * device is re-opened instead of released
> +	 */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }
>  

