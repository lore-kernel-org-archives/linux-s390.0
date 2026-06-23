Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8B3C1991;
	Tue, 23 Jun 2026 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225017; cv=none; b=cBMrck8oeDKpvwLbyMKHxkFkbs7DATgjNcejcx0ZOuZuvEdnw3Uur1ygNJNemFnpwuX8HWavjQtmaQE8bc6Ohk/CCU2EA7z+4u8paTEt0fwCh8JmRDDjRAh8TokDLBOJHxlau/uLMgqMgxPxVJiUypLrkYhw8pznv+Ct7/AdXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225017; c=relaxed/simple;
	bh=aNj1SA1CBO5Er7syh/U4pW81ccwkQ0J2wFlp0kJLAK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfu4ie9Hn6DsHYSzkWIN96wY9RKnbJ6HLF0aBh55oFhNFkTu9GxNdmarcRY16vVKJ8K2YInPiIdQvulwY3QSD6I+/YGtrFMv9v7+vBUb1aF9xrmLnEOfcBYRULu65Zg3cRWxvkybb3c2ZjRO7QaCl5Q8DdfoI+h3cDE4/W3X0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LiEg5b+2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LiEg5b+2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn5Vb1827281;
	Tue, 23 Jun 2026 14:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XV/1dY
	IQvzQ88frSkANg2zbzasadjyWkxBvucar1ZEU=; b=LiEg5b+2Bf48a6fpvoYpd7
	0fW+L7IDjjiVbGJXp+SkvxP2JOb4J/CV434rMxF3iUjd1dcYiin0UsEy2aZTkdvN
	6GfORw1pp6rcIOJwQ0HIbxFYJVZOyPuqQbUh0Ad/vBCg/vOjoSIYzQQIzvFif0zh
	CPndYawS4is27R09BzPbHT/L1gl1SbJ6o3MWB2CETN8I4GCUxZNIFpLUFA1D/E6M
	wy+1BETOEWaw8DQvCCFvM9QGxEclufpTz3qvpKAn2ZyL0vf0Gscd698J4Dk6EqiB
	/DYdHcrOQbCIhB0IEVgGzKAV+pbXCKzFKxpwwimFTxbTJk0pxZdxkE3FaWwPnAnA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgspwaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:30:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJe30005046;
	Tue, 23 Jun 2026 14:30:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykd3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:30:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEUAnn7340614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:30:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67B5F58063;
	Tue, 23 Jun 2026 14:30:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2D715804B;
	Tue, 23 Jun 2026 14:30:08 +0000 (GMT)
Received: from [9.61.151.132] (unknown [9.61.151.132])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:30:08 +0000 (GMT)
Message-ID: <1f0f3a84-6fd3-4ae2-9518-72afb629203f@linux.ibm.com>
Date: Tue, 23 Jun 2026 10:30:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
To: Haoxiang Li <haoxiang_li2024@163.com>, alifm@linux.ibm.com,
        farman@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623075220.2022613-1-haoxiang_li2024@163.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260623075220.2022613-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX9yPRA8vm9nEf
 Yqj+1h/O/ZBSVmxIhTBFsP/lashdhPCb5j7Qfk7ARS+lqVYweJvCWXKqSrfaowF3y3JtYAn3Z98
 lKU7vaiYoktsJRjUOZzaCUtsl25+z/aS12AOE2Y9DU3zWhwDrEaZQ7DPMCvbCmQ+37j4nnLwUoo
 ytFKCZ6ZOMt+CRdgz2dMIzOzenyKiAFjsgZ8mfB3HwBZc8hL8ORSrfe+1EvTkCWXvxavdv0MRM9
 JQgFA7pzbdy+M7nxMvtAV5v8ugzazTdZCyczXB0bZ7X+NpY9h6CX39fem78SLx8TnaLIEYMfRwP
 Otx+NRff6THjrzg6g85mO7rHZxKUGncaihjMmXwm72bDjiD+Y1STUO/2nCkeyyD4ww9aBDVl9tU
 LNTJjhfDeWOqy5NhTffh49ASxAvvTcozER9NYr/0X2ufCv2kQ+oZm742zsQAl0T0wPRMwIqOL99
 /jx7g7WgxgCWW7+6nMg==
X-Proofpoint-GUID: _1puzog_juDBd3hgS_rWVbToKW-uDBe1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX7X5G6Vr7p7or
 VIgoUs622qg+mRpw0laqEvDH4Skexr1HVbSAonyZHhTag7zDMwyiGp5oEwq8b51gJu5RGJw39Gg
 vljLELFHqir1DJWcXRkN6trKwJYBJ7c=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a9875 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=SJ3Dp5tMb67BtvNYzm0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lheDpNn3MGiKZdmat2Nwthfr1xaoWA2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

On 6/23/26 3:52 AM, Haoxiang Li wrote:
> kvm_s390_gisc_register() registers the guest ISC before pinning
> the guest interrupt forwarding pages and allocating the AISB bit.
> If any of the later setup steps fails, the function unwinds the
> pinned pages and other local state, but does not unregister the
> GISC reference. Add the missing kvm_s390_gisc_unregister() to the
> error unwind path.

Hi Haoxiang,

Thanks for the fix!  A comment below..

> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  arch/s390/kvm/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e..a9d5996590e7 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -252,7 +252,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	srcu_read_unlock(&kvm->srcu, idx);
>  	if (npages < 1) {
>  		rc = -EIO;
> -		goto out;
> +		goto out_unregister_gisc;
>  	}
>  	aibv_page = pages[0];
>  	pcount++;
> @@ -327,6 +327,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  		unpin_user_page(aisb_page);
>  unpin1:
>  	unpin_user_page(aibv_page);
> +out_unregister_gisc:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
>  out:

Label 'out' is now unused in this function.

I think you could make this a 1-liner fix by keeping the goto unchanged
and instead just placing the unregister call right after out:

Thanks,
Matt 

>  	return rc;
>  }

