Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA92D5408;
	Tue,  2 Sep 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828338; cv=none; b=io9nMlhqa2J8SI1MDi6AzkAwptRTB6So3jnZTypc2Sk6vYJhBdDzgrHFkyrgQhYf8PaR4XRpOmw8hK6I7F6KEdR6Z7ve4qb2JpKgyCjAEOml2ZcmOapBi7hLocyu2WO45To8ebRZZ8SWVVzaBU1U4wrVP2wdJsdV4lj6Gwd7G28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828338; c=relaxed/simple;
	bh=JLaI4yEZcFCICpJNYnFY1L16zlFO5+isVd8M2lwYo/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYbaSw5QH8VEK3K3fza3Hkaw7E8HMVY8HGFb4BkVtNpz7dwNgz4+RywfQfiSvDV63bfQgocum4+Tvn2DArwY1blXVVBEN68OUBU9sEM6UqqAke/s4nyGnpVMw4nhcOJ6AdjIL8u898Mya77INqfydlg/ustRI/oxmp88lL8koOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqXBN9s8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqXBN9s8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5828Z40q030645;
	Tue, 2 Sep 2025 15:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LMxWXa
	DGqj7use+dXt+3hgEC9pcONsdxH8vcNgCyWCI=; b=OqXBN9s83BrgFFjvnh4QUv
	ha1ZTHXx9YEhORBDVPRckVBfewQ+fZYuQnDF/9xqw5k9zqrV+69edy/mkWlO1608
	B6SpD1QoGR1x630mVlp2WvNwsLiT5LqBC/C4n5DqsyodBiqT/3fvHVxgAmebtZOM
	ZOmf+4hQyyb4BiBGy+YZ1zMrHG7MG3gnYVFWSxIsQrfPxxC9lJUluZcmv8u8iUQy
	zsaeIevxdwRfx/4r7ISTQvBBKI+ctN5Hd7uAXpYErfr6cJiVqqMeIHlmsXQbIehh
	3YmSC8YCgaLjhx+vk3ozjY7BDbT8zONRDcxO1cqCBVebFUN3QxAX5swlzeGCVrIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd7bct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 15:52:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582CJlTp019910;
	Tue, 2 Sep 2025 15:52:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmu3hhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 15:52:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582Fq7iX60031414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 15:52:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964E958059;
	Tue,  2 Sep 2025 15:52:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AA958058;
	Tue,  2 Sep 2025 15:52:06 +0000 (GMT)
Received: from [9.105.76.126] (unknown [9.105.76.126])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Sep 2025 15:52:06 +0000 (GMT)
Message-ID: <c7da1650-af86-40ee-812b-45d972365e7f@linux.ibm.com>
Date: Tue, 2 Sep 2025 11:52:05 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Fix memory corruption when using identity
 domain
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
        schnelle@linux.ibm.com
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
        jgg@ziepe.ca, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
References: <20250827210828.274527-1-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Cam Miller <cam@linux.ibm.com>
In-Reply-To: <20250827210828.274527-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b712aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=aNs30nL-xdb_lp8ugGoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX5A14JbKmjGY2
 HTVbKC08xTZaV9sTNh7wgXDS5CBJHcimkn9hJ+MGJ+L8n4iGFm2a+PHM/pcSbEDCblutqAC2AIJ
 dyKcfjbZAmdGVjWqsDcInVDJtLp4D4Axh4pb4MgQXKblUpuRC9aiEm4ZKdnnG0vfQZHJzAyCNDX
 heKgylFBxpdr0aRLKI6GOW23YaX1asx9hInTCoP1GAsSFqqMdjAV4obltc2G+gWUp2PXdfVDTi3
 b1O0BzcDEi8VelrzDHEXATwRaQNd7ELil0xcq/k6WjAE9MpzW2gUPL542+5/SiVacI3LH1SxPM1
 OaPW/72YSSkiBniiyq5SdUu79zLemXPD3ZDZ7aEP5DuSLmDMmI3cNPUIsImub3qXGbHa7BAExlF
 1AROQLZ+
X-Proofpoint-GUID: nbJgOmraHjL3dGMrQEOwZpYh68nJcsL2
X-Proofpoint-ORIG-GUID: nbJgOmraHjL3dGMrQEOwZpYh68nJcsL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Tested-by: Cam Miller <cam@linux.ibm.com>

On 8/27/25 17:08, Matthew Rosato wrote:
> zpci_get_iommu_ctrs() returns counter information to be reported as part
> of device statistics; these counters are stored as part of the s390_domain.
> The problem, however, is that the identity domain is not backed by an
> s390_domain and so the conversion via to_s390_domain() yields a bad address
> that is zero'd initially and read on-demand later via a sysfs read.
> These counters aren't necessary for the identity domain; just return NULL
> in this case.
> 
> This issue was discovered via KASAN with reports that look like:
> BUG: KASAN: global-out-of-bounds in zpci_fmb_enable_device
> when using the identity domain for a device on s390.
> 
> Cc: stable@vger.kernel.org
> Fixes: 64af12c6ec3a ("iommu/s390: implement iommu passthrough via identity domain")
> Reported-by: Cam Miller <cam@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 9c80d61deb2c..d7370347c910 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -1032,7 +1032,8 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
>  
>  	lockdep_assert_held(&zdev->dom_lock);
>  
> -	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
> +	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
> +	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
>  	s390_domain = to_s390_domain(zdev->s390_domain);

