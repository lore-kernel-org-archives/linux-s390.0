Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595A18DF93
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427523; cv=none; b=bLCHVbMk4kKiwlfeQrCTXBrzXNdtx0382jXsQwUuh3aY3PUE2nVeh1hrZXUHdk30QG5egz4oyItyKTI/0+p4CPHV2Gm7VRQ/i5qx/fObgEM4x3o48y5LcE7IF3M6zffCv6zmIreOD0AhWmV71zpamTpJd8bhQFN5sXNL6RPC2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427523; c=relaxed/simple;
	bh=Z12qbAORQKIeIafj9O/9xw4Bo/ZWEmWPUE1+H7QbVCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gtngAVoHbdI8ois4iJ7wkFH909COWhDeX1djiRaeonP2BA3gaydQjQmC84lt8CcXfSzsQD2bTLyLKsrXuRk4MJSIk4IG99NdBjBZXdCpzRzuPmA1VCllbTgwjTtgiJceEC290VORE6zRxW1sC3fNQVy0W/FubY59Q0huComKCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xc99TPBM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xc99TPBM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7wON3014773
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 12:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	MZIGn7lw5uQpL5jyDMW6PD/+cvoj3Guhb/3oxW9J8Cw=; b=Xc99TPBM7NrON4CZ
	dlUbTWVBDlwqUp073UBxLMdonnfb49oMUobvakBE+NCs2wOYNFfH7L2F22rEWMOz
	asKTWwhcvHsP+Z9c8PbcTYIxzIoRxKdzgGsWZX7cux3hA+2vrGjhD6aexyJBFF65
	Qhu8skI7BenGQpfgsVf5B8FU5hVuJMeZDOR0K2MVM4H9CNIH9AJSO16wG7r/lAFg
	yBAQkE3uU1GDMfKsbey8t9wILTDrnmeDLeE5l8fxeW8ydQhloJtgzP744nySRhmN
	7XH0aiOFfCh1GaTYuDRPv96+f884H9l5RohmvXFmtYGv/EsH95h9Lk+tvZfFKP84
	OCk+bw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qhbk0j94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 12:05:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V9CLjc011155
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 12:05:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmu8mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 31 Jul 2024 12:05:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VC5CAd40173838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 12:05:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6298420043;
	Wed, 31 Jul 2024 12:05:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1831320040;
	Wed, 31 Jul 2024 12:05:12 +0000 (GMT)
Received: from [9.179.1.161] (unknown [9.179.1.161])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 12:05:12 +0000 (GMT)
Message-ID: <9124f3d3-700f-4d54-be2c-df17cc6a719f@linux.ibm.com>
Date: Wed, 31 Jul 2024 14:05:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: fix validity interception issue when gisa is
 switched off
To: Michael Mueller <mimu@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, nrb@linux.ibm.com
References: <20240731113102.849562-1-mimu@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240731113102.849562-1-mimu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QuAl2wUf1RdqbumgtJPgjVXCjuOl5c0u
X-Proofpoint-ORIG-GUID: QuAl2wUf1RdqbumgtJPgjVXCjuOl5c0u
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310088

On 7/31/24 1:31 PM, Michael Mueller wrote:
> The following validity interception occures when the gisa usage has been
> switched off either by using kernel parameter "kvm.use_gisa=0" or by
> setting the related sysfs attribute to N (echo N >/sys/module/kvm/
> parameters/use_gisa).
> 
> The issue surfaces in the host kernel with the following kernel message as
> soon a new kvm guest start has been attemted.

How about:

We might run into a SIE validity if gisa has been disabled either via 
using kernel parameter "kvm.use_gisa=0" or by setting the related sysfs 
attribute to N (echo N >/sys/module/kvm/parameters/use_gisa).

The validity is caused by an invalid value in the SIE control block's 
gisa designation. That happens because we pass the uninitialized gisa 
origin to virt_to_phys() before writing it to the gisa designation.

To fix this we return 0 in kvm_s390_get_gisa_desc() if the origin is 0. 
kvm_s390_get_gisa_desc() is used to determine which gisa designation to 
set in the SIE control block. A value of 0 in the gisa designation 
disables gisa usage.


> Cc: stable@vger.kernel.org
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> Closes: https://ibm-systems-z.slack.com/archives/C04BWBXSKEY/p1722280755665409

I'd just remove that since it's not accessible for people outside of 
IBM. Yes, checkpatch will complain but in this case it's ok to ignore that.

> Fixes: fe0ef0030463 ("KVM: s390: sort out physical vs virtual pointers usage")
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index bf8534218af3..e680c6bf0c9d 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -267,7 +267,12 @@ static inline unsigned long kvm_s390_get_gfn_end(struct kvm_memslots *slots)
>   
>   static inline u32 kvm_s390_get_gisa_desc(struct kvm *kvm)
>   {
> -	u32 gd = virt_to_phys(kvm->arch.gisa_int.origin);
> +	u32 gd;
> +
> +	if (!kvm->arch.gisa_int.origin)
> +		return 0;
> +
> +	gd = virt_to_phys(kvm->arch.gisa_int.origin);
>   
>   	if (gd && sclp.has_gisaf)
>   		gd |= GISA_FORMAT1;

