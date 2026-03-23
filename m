Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037D343D91;
	Mon, 23 Mar 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262794; cv=none; b=gTx67nc01yzTfjl5O0ugu1aMvhZFsCxtzb+tUBbHZnXC0zjAdvsK7uuZIWKyzxjyOFHb1T85AN74IHBQ5xEhADufyK0Bfkmd0rNceyzyFma3rV5Rb1LBF9mQpVbb24uj4Hc1ep+XYKyIf+Ibbt3OzaxTf21QnOPZwBQABYWXwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262794; c=relaxed/simple;
	bh=1y9ANh4vIpXzXj0IccJMQL3qLDd85gWbIQygYwLMzrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjFBMQgsiMQbSF1hhM44C/g9e0/SNyOmqDFNCnA4X0UNQ9S+zFD2BQ2nzsE4KqrzR6bc0ZwDF/FdehXBiP5jEGkqAjvpkfRiRPI+l3qu69L24PjVFmEIrgntv60KcRAhjJXtgmE+Zo0TKvOE+R2jDXXLmJ6AhzJUaiw9V4zS2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YFaOu4ja; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YFaOu4ja"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N5jQ482665123;
	Mon, 23 Mar 2026 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0YHEeRDrgXvu9eNJoSisu6lz+XPbwS
	Lasx3lvNLZ6D8=; b=YFaOu4jajwXg/lHXoW7fPfTEv+QWIg3z4kzjcjp0zZ953x
	r85WjE3kIyTm3zgfuS70wvr8Kcwio0ZGBmrk6AKhrM5lbvLBFsCVmXDQeAdZGHJT
	AxSd54f8vpGGaA2Lf6CAsjiTNi6tjXVhXt1rPn30YNtvmpBridQzdUkUgcKUUwor
	nwdYO3WRF8+nDjgPWWov0YAucsLjT9BcoVqDcOngoJfZ5wDk3/LPY2F9ElGzTP+a
	jsBim9zKoG3PUUYdQLKqHhAHH+nWZS6Dn/RxZfoDjj95OTMOkpy7Z9j5FZK+M8zr
	51uaGY3VqC6xjVLvEdFpRv6Gqe90CaL5ZsYEI6OA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktup5vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:46:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6TMEw005964;
	Mon, 23 Mar 2026 10:46:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yd47m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:46:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAkPLQ46531030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:46:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CBA2004E;
	Mon, 23 Mar 2026 10:46:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6DC2004B;
	Mon, 23 Mar 2026 10:46:24 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:46:24 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:46:23 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 1/8] KVM: s390: vsie: Fix dat_split_ste()
Message-ID: <20260323104623.66303-A-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bdi9JeRwdjGNwLW6qY_N6xRot-jdGm_K
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c11a05 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=buXqh26OFB9ADXD7E0MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX0+FR4WN8KC27
 uMNzf/UMFJFmw5LgR/iu1pulEO0hlPREDVRY4kbc8UGo0tCzdE4sbwoX9MXbYoyi8bJkM5udOVZ
 FCkF3E8i5ePxTwqocBTNXOTVd+/+jmbx/PJYwj7qxsWmGC7QHs77wiwPJQ/2S9iei7bKzaS96Ca
 CRFiA2ca92O0yQvSdJ7eRy45nxfViHrNwX5PBF+9Lm7ksg/rZju7KucA6oAB1pDzVoxIUkZUuzJ
 EhD4yMTXPyDCNjLB2ZEUzTCE9oFZ70DOy3dFk8bIdmjJlCDutDEnYFCU6ApyXrnvUzmx3T+PaSW
 pOLBpTzXBlbRyCGuoRRU4gXf5aEdAEkDkEZ5kH7toTIY2I8B47oCgX78X0+Z3Ft0MO9UnJ22mz2
 FEckDRd+n0I+vqswLL7HtHRJnTfHu9f1/z15zbHPpqDtdnRHUKKHMWU0fGIp2tkKqCTscmrIg8b
 kABNQGfdVFkYEfXS0Lw==
X-Proofpoint-GUID: Bdi9JeRwdjGNwLW6qY_N6xRot-jdGm_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230080

On Fri, Mar 20, 2026 at 05:15:35PM +0100, Claudio Imbrenda wrote:
> If the guest misbehaves and puts the page tables for its nested guest
> inside the memory of the nested guest itself, the shadow mapping will
> lose synchronization with the actual mapping.
> 
> Propagate the vsie_notif bit from shadowed large pages to smaller pages
> when splitting a large page.
> 
> Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

> ---
>  arch/s390/kvm/dat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 670404d4fa44..48b5f2bcf172 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
>  				pt->ptes[i].val = init.val | i * PAGE_SIZE;
>  			/* No need to take locks as the page table is not installed yet. */
>  			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
> +			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
>  			pgste_init.pcl = uses_skeys && init.h.i;
>  			dat_init_pgstes(pt, pgste_init.val);
>  		} else {
> -- 
> 2.53.0
> 
