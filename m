Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9934756A5;
	Thu, 23 Jul 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819972; cv=none; b=Gj+7veGxUH/vLEB68k7Em8h+slOjLZwoAT5GTYTQT5d8E7PWsPxKwMyD1plAZstnTuymBzEHeMCrkB1Qgf5PtDhoh/d0UU85RB0TC7jfCFuqwdfD614KOxikTrp0pYRcJLA0ysVxhmri1s8RjI9HkR44rAR1O3E2hjd76d2lKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819972; c=relaxed/simple;
	bh=wwZcu/zyt1FAUeYi6erRrQC4mUbB9NUuNtVmKwQw0As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJeJM+bzcupqamU21qgrKhf06CEm9yCh1QIpB6irfkDZC/jyG5qDqQRfTelUuE5WIhyB6hsAmILhYKy+GUkuE976RcDXJvGtZphJn0ztDvy6EJ33ug8HVVLyMsN89zW03zAKwaUF482eYrBPTXjMD4IpVTD2h5kJaRQIxVV6HdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JIPPXqJp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JIPPXqJp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBoik3089974;
	Thu, 23 Jul 2026 15:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KeG7aM
	7dexqwCNO18X2lTA3Zcl+djh0q2tQmqOsl5z4=; b=JIPPXqJpsxV5NYqWFVvBEQ
	i00P7qa5cXnmp9488C2aeVawCw3PLA1oSFCpnPAOmRFCgY4zg/IZlHPUdpIWtm6Z
	1cQIECMcFQSoYWVe7rlwbxaEJ+POh7h6LdBWGM8STKwKTfCm1YunnHsKsMeTKD9w
	yVETHY2v21Wa0avbTmizPck8jmmL0+dwm/h0/zWuwvdDKPglY05BOwt/JGNapxob
	9hSxteHIn3NRKplxO0e0/WD1gt4PNdEEV598LdwzeYmAfcWKzMLtjvN2s2ALs4DJ
	1sQLYdZhv+C+7vnW7kTqwEtyDlPojGrxeRvs/LtY19rhIg9aidjfWR6FPJIx8ldA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abr9pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:19:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NF4Z1J002233;
	Thu, 23 Jul 2026 15:19:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcqsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:19:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NFJNTY8519996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:19:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1076658059;
	Thu, 23 Jul 2026 15:19:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43ECC58053;
	Thu, 23 Jul 2026 15:19:22 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:19:22 +0000 (GMT)
Message-ID: <a0044314-5d84-413b-8912-b50907fa0964@linux.ibm.com>
Date: Thu, 23 Jul 2026 11:19:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-6-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260722170621.1686-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfXy/e1B7YxiBBV
 ZWCb1uJdRmsoT0bmhmJdlgr/m11PTdp56U7PoK4TWnnkii9IbKvQVxeyHfeX1nwII4MRsNAYHr9
 TYbMjE5AjEvQTOc+iwPsX7sZJeBIYGI+7EAJRJjITZQBa/G30C1mLLE9jsNGvxLkBVYJCFkJdEA
 SzLaiMndftGq56bRDfGfrZpxbO2cfFuVsEX5GZf3q9idnAPFQGLLfB7RKWOe/k0EMoNOyj3hgr5
 SbnufJByXeK8gCvQWX7hZCNqAOPbtGB9WpJYXsO0dAcc0EBNGUC1wx468msc4DrHMAMACWu9Sxc
 G8W7URjL+9bPKe40Ni61McGW9grMwyLfENHbAajvqnMF3yuO8DHt01IIHOO5lQ41yRtIOBQZokp
 IfgnU3xHra4cPLsJMZr2TyxZaCTCFSA0OeTJQzKK/B+ETBqRQU8MfN1sFAscbCtjMlMP3AWOFFb
 S7e4T4sYfXcipprVjWw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6230fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=W6YiH1k79j17DU6STyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NFAJtneAhPM9XYsCLdKev7GL0hvtV6av
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfX1AN8zaoHlNQ6
 Ut1Xgkb96+b2pbsUYo967pMMLeR4iJjFSo9elOs2ZyCAIRCP/W6zcSz0m+MTQ0uKoRssbArVsDI
 urTltAy29RuXIba4isiM95p0VyRBet8=
X-Proofpoint-GUID: NFAJtneAhPM9XYsCLdKev7GL0hvtV6av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230149

On 7/22/26 1:06 PM, Farhan Ali wrote:
> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
> the error code but doesn't do any resource cleanup thus leaking resources.

Nits: s/the/an/  ....  and 'resource cleanup, thus leaking' (add a comma)

> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
> unpinning any pinned pages.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 231a4236fc3c..d76b2c5484ac 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -341,19 +341,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	aift->kzdev[zdev->aisb] = zdev->kzdev;
>  	spin_unlock_irq(&aift->gait_lock);
>  
> -	/* Update guest FIB for re-issue */
> -	fib->fmt0.aisbo = zdev->aisb & 63;
> -	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
> -	fib->fmt0.isc = gisc;
> -

OK, I had the same problem as Christian here.

This is dead code because we don't re-use the fib, we make a new one in
kvm_zpci_set_airq() and fill it with values from the kzdev.  Right?

I agree adding something to the commit message to that effect would be
good, even something like 'While at it, remove dead code that stored FIB
values that were never referenced.'

>  	/* Save some guest fib values in the host for later use */
> -	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
> +	zdev->kzdev->fib.fmt0.isc = gisc;
>  	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
> -	mutex_unlock(&aift->aift_lock);
>  
>  	/* Issue the clp to setup the irq now */
>  	rc = kvm_zpci_set_airq(zdev);
> -	return rc;
> +	if (!rc) {
> +		mutex_unlock(&aift->aift_lock);

This is subtle; we are now holding the aift_lock a bit longer now (over
the MPCIFC re-issue) which I don't think is strictly necessary since we
aren't messing with any of the zpci_aift fields during that timeframe,
but I think is fine to do.  Maybe also worth a mention in the commit
message that the lock is held a bit longer in order to handle the error
case vs drop/re-acquire.

For the code itself:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> +		return rc;
> +	}
> +
> +	/* Start cleanup */
> +	zdev->kzdev->fib.fmt0.isc = 0;
> +	zdev->kzdev->fib.fmt0.aibv = 0;
> +
> +	spin_lock_irq(&aift->gait_lock);
> +	gaite->count--;
> +	gaite->aisb = 0;
> +	gaite->gisc = 0;
> +	gaite->aisbo = 0;
> +	gaite->gisa = 0;
> +	aift->kzdev[zdev->aisb] = NULL;
> +	spin_unlock_irq(&aift->gait_lock);
> +
> +	airq_iv_release(zdev->aibv);
> +	zdev->aibv = NULL;
>  
>  free_aisb:
>  	airq_iv_free_bit(aift->sbv, zdev->aisb);

