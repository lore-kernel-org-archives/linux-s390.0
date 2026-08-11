Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948803B14BE;
	Tue, 11 Aug 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466309; cv=none; b=hQcFjvllqNs73t21/ZK6hNtLdUni2Zg3UfskqStonZPUU8zMqd8XfSoxRHNwxEuCNB/49xkKQOgdpmHuEHDDm8Qo8c/7mPXEAzAXOdxVTygWwsAPKOan1jzr6Wru17AX+YaixEnZIlUb4K8eBerzgCho+Qdt6n5bQsoLifwFdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466309; c=relaxed/simple;
	bh=BSmjIm5YUDJJZqV49VPLL3xpx1XVuUgkpKXoywhBd7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZnf9ndIvEpsoR8NsPOYBb9xsIA6yyd1SYXlqf9Kc8E4kCygnLl92vcnrocJnRfaKmUjIa6Z6eBMolJnBUDjlamBr6NdIzvmFUeoI84wFrOAWmIiTFUceqfqe6SU8y8C6/6xy85phEK+MqxZfRpOMmy1078I5fO1YR0IdDJ7xCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bU0e5lru; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bU0e5lru"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVauF3260708;
	Tue, 11 Aug 2026 16:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X9P76/
	opMyHH6vtL+p1sAt9/8idsOBgbdHRV2tUFjow=; b=bU0e5lru3tqu33GUX/IIyV
	B2r8B6sHQbmbz/MYmoAeOyLEy7bjLN9B6Mmn5ualTKL3A+ZlyEtNKcAU3Ieozm66
	Qe64nJ/iop0xft4gRUOxXQExXhO12thqhheQaldzYtapCPYHsqitCHScsF7cgzrq
	GGadDkKiYahsal9081DrYNHDm1U8abWkGc20T60L+1oGmg4ug2kRXKWYxqJmZUTD
	UkbN2RMP0PtxTAM7PQR2uFUXKskga8x/dghE31HZbr19hVqZ9GPPJXjgCYH2+xw2
	iT6TzR6Y9d/xfA99bSHb7uH2hvEdFGL1IZyjbKsPObsrisqJX0nO+xvrogL961NA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjywyfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:38:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGQhVg024338;
	Tue, 11 Aug 2026 16:38:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1q76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:38:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BGcJEr33424006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 16:38:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C34458056;
	Tue, 11 Aug 2026 16:38:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 423F65805A;
	Tue, 11 Aug 2026 16:38:18 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 16:38:18 +0000 (GMT)
Message-ID: <05763614-9402-4c3c-84de-90d7f1ff09e4@linux.ibm.com>
Date: Tue, 11 Aug 2026 12:38:17 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-5-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260810192257.1208410-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzOCBTYWx0ZWRfXxgTFIvxi4AWf
 8tRv2bmXmVOt6uuA5F8O3Ks5A+FQKPq+BX6DghH74tjUfxk11FilnfnS1Hv/kjMCaQ8/JcYz98f
 ZSphA0shtW3z5RtE4Qsd4xkQeQpaIKqjuvxTIsYxGBnF/jCmCO2AXke0kBC3zxhB0O1RjQsNzQ/
 aW0Ib6VZUB1kmTk9xmY5m+NHiv68muLU6vgKyQ1RTJHcFprGXjjaeFp6mBVhRaL5yecX+Hlfm9P
 9cBF7dEAw/kyY4llJETfXzYm+QGdoUsn+TSrjSKSk8aIMX4Rgok+fvxy/Ehx6E2b0/CpnUkwOwq
 1ZHxHwoLfA3VBzBVB4Ah9ATIKyhKRDTvhxa+7Dj6/RyQMdQbGDICaJaz2VT5dGDCp6G+RzPyjXd
 wZZ/pf2GMp/c+unmuv+ZICRwW/mGUmheVuJSEiFp+NBP+67xUc1XhhVeNPGR+GymCfy88esxp7l
 hapgmnzKvZ1pTrBstjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzOCBTYWx0ZWRfX1G5j+HKw/Jtr
 85DcA5rfw7sG9HLyhwmY6+6ZSXUMqJw1F0JvP8Kt9vX+CCSmy49UiE/iau/ENBHlgykqNm0p+zw
 1HB9Fg1dB2ym2LTGq5jOnNIsMedUXOk=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b4ffe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=utj1NnzjcZOxplUDwPcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U1HbXl1ax7NZQzq2UAI2WzUEG7SZrgae
X-Proofpoint-ORIG-GUID: U1HbXl1ax7NZQzq2UAI2WzUEG7SZrgae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110138

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> In the vfio_ap_mdev_cfg_add function, the apm_add, aqm_add and adm_add
> fields of an ap_matrix_mdev object fields are modified while not holding
> the matrix_dev->mdevs_lock. This lock must be held while making these
> to guard against a race condition with another caller that may be
> concurrently modifying these fields or any of the fields in the
> matrix_mdev->matrix.
> 
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


