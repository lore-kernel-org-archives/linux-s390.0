Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA71EB19B;
	Wed, 24 Jun 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323928; cv=none; b=D34F97IRBfIW18zb2+50AvlzUAwFE+0pyUGYncXsy87V1GsFSb0xyPOSJjKwHZC7Q0WT+Q47Y0nj8/Y+Jmhkr+gdn3441OEdsky7PfHBDnf2RDdwB2QAoVHR07WasW/Pn+DIGDF4otmgnjQTV1c/Tv2C8dUbftBw5YhHFzUMqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323928; c=relaxed/simple;
	bh=DX0QvMw8p361Zfh/uaeq6rdVEFY+BHHk1W/aVsV9w8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L31NOY4UVdceCJp2TPWsO2tudLFGxPh8mvRm5QZVtjZq6POABGi2E4xg0VrxoHlgGn7J6sGUl5bT2FvNuw4KiM+2Va7+p00M0cg3DvQX3S3lS+pGU/7vC1XBsAhl5rYuawrNTzVaAtxdx/ohbebJCEg6b/AkXgH0LTOonU/uC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MpsL10Qn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MpsL10Qn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmQrW1276793;
	Wed, 24 Jun 2026 17:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b1HcEC
	ppu6qulPwpoWTpcBvYci/hyL7Dbnu5U+SXgr4=; b=MpsL10Qn0A63XFylRclm1K
	sRe7Zh8Izek+mxYjmyBp7fJt/lhpUSM10sC9HUEIQ/9XPHN9ABlqPtkLVT+vW9kQ
	3iCE2heEoTsroVreEueSL77tYR6CHG2FIl7Nk2WbfPTRH6gfwWD2zkaBoMHXIdU/
	sK4vKFBNF2h0y0bDx72xsHW6Ds4zk6NOxFGow8kozoGs3o8nzwhcDt9V/Ke5+Yi6
	4N8TaqCrUVkuLDNPYJ5JCKVNRwZk9Nhq5oAcB3PBcgc1UFhd5hHFB2oBv6Z6dhsv
	ybLeb2BQK+i/Bv1rb76AHfnIrTxpYvCWw1hFfYPJiN/0hmKoLE0aFl17h1ZsL1xA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4npuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:58:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OHnp7v007183;
	Wed, 24 Jun 2026 17:58:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qj6dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:58:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OHwgL126018404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 17:58:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5BD758058;
	Wed, 24 Jun 2026 17:58:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E156858057;
	Wed, 24 Jun 2026 17:58:40 +0000 (GMT)
Received: from [9.61.10.90] (unknown [9.61.10.90])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 17:58:40 +0000 (GMT)
Message-ID: <b23fb347-a5e2-4fbe-a236-3c2e63d3b204@linux.ibm.com>
Date: Wed, 24 Jun 2026 13:58:40 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
To: Haoxiang Li <haoxiang_li2024@163.com>, alifm@linux.ibm.com,
        farman@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260624061910.2794734-1-haoxiang_li2024@163.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3c1ad4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=VnNF1IyMAAAA:8 a=os8-_7R8_0AxGdoVMvoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0OCBTYWx0ZWRfX2w8WhUObaxiK
 zg66ldcQX5Wb3BxD3M0S2AIEnwCWXnCkP6yIFtT9R/zypBathvTEW6hJhKjceoMiP/fKbrmd5M8
 BOS9ACTQ3ZJw4Ng2TE3tLzpDhGUVHKoTV3uN09CcUmOseUun72RsABTNKYiJZ+tLDM4Hf69Ea6+
 hAxMpLUcBtRlfSId9ZTzuHmqjmYE7IhN9v6qx9zgqtgp2R4H33UdEDMMIYz28JwoxYqixuCqOoi
 KOcnTTMJOnGo++Bw2qa9iKLg6j1Ak/HrrdVqAOztl07+oS8S3pEnvNY3b4DXibhlSI1h4nvKVzk
 tpej/ZshR8WCXyjhWSeIX4Y5KHkbC1l5hjGDAKEsOdGlNkG9zF3/ARnrlzwKP/fO0ttKSm+HEwv
 ImCQEqKewgu2pBevWEhuWknvDdPcpQ==
X-Proofpoint-GUID: FCJSaNL9rgTKiPt-vOTyEWWLGTEpyiNJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0OCBTYWx0ZWRfXyElvTaaKzwKB
 mx/hf0AZFTtOrVHpOvshS9l3gk/o1GVfLyQIiYkc4X0N14fHgKMFc85NeDM2sRunNmwkmnvhj39
 uAmTM1mNLgjDoWTGQGw9/VJ2FzBmiqk=
X-Proofpoint-ORIG-GUID: jOmk3o1TikHwpOQ7g5oRDVFxZjWHY3Na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240148

On 6/24/26 2:19 AM, Haoxiang Li wrote:
> kvm_s390_gisc_register() registers the guest ISC before pinning
> the guest interrupt forwarding pages and allocating the AISB bit.
> If any of the later setup steps fails, the function unwinds the
> pinned pages and other local state, but does not unregister the
> GISC reference. Add the missing kvm_s390_gisc_unregister() to the
> error unwind path.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks, code looks good:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Forced the codepath in question on s390 w/ passthrough devices, so feel
free to also add:

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
> Changes in v2:
>  - Move unregister call after "out" label. Thanks, Matt!
> ---
>  arch/s390/kvm/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e..686113be0530 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  unpin1:
>  	unpin_user_page(aibv_page);
>  out:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
>  	return rc;
>  }
>  

