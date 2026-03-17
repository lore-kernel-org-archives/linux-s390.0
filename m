Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E511713;
	Tue, 17 Mar 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754254; cv=none; b=dvqvgZY2FF2gicMUqIfuBJTT0o12RHLrwKE8+gDuEZZrB/iw2HfTeQPQJReef0+ARimlha8yKbDlalnm1Y9hgfOrmQEPA1+76LZ+kyOwBZL1X27C+XkfuamJSBUe9QoOVBIKLurpVxOqCN0scUZzSHuYD7957YUm+/VuyWKA14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754254; c=relaxed/simple;
	bh=A/9EXaggPO0RMXRfEN+NZRS5N8udseeZ3y6oGSTKR00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF8Uc2OkSJp+GZ+f0FswA3BJpSWtb3rROzl4HPC+WKWpHDlM14L2uziz4+JSoyPmibsuG1FXyTpbfV9prVY6tA8nCCnaKorw0J8daBCsxFlbxPTI+qp/Eh7z8D1qr1Y9drWoxgdd+6mhXMK8pjvQQrd1r+jz5E/W/BLSiAPr2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O/tntMjN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/tntMjN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7FP6m437268;
	Tue, 17 Mar 2026 13:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D7EVad
	H5FHZqlDSgSdncu3zUJZPRDTUuQeLFvi8LVfQ=; b=O/tntMjNvXXOYfdJf2kYhY
	OmawpjllNNlcEU8I64Z812nk576IoVSJXTjOsL2B9bT4fwg/OFDX2ckWusv6cVZB
	OzCVtz+spayvVG/oztXd8pitfTUdbhXSQRaNP3bIWIKHgqElj+5kmPIAyrW/YFdX
	Il9ZuenMlzaa8/oeobLPmsZWGgmNBYEzL/iCv708TERkbli+Q2ODhOMFzrJ+u2BZ
	nhJYje8mTKlgtDDda/FYsGJZ91o7ISzatueLN1gb+N+c7s+hWCJSwnOQSHJGxnjH
	srYF+lS2P9xVXI7WBCswzOKBhxfSEhYOTEM3uJnzJ4BKj4m5HnMMGuwvRlX3JJ8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cvf9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:30:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HBtMWf032343;
	Tue, 17 Mar 2026 13:30:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7js5y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:30:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HDUlYG51970366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 13:30:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68D3E2004B;
	Tue, 17 Mar 2026 13:30:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4582A20043;
	Tue, 17 Mar 2026 13:30:47 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 13:30:47 +0000 (GMT)
Message-ID: <bd75511c-8c49-4fcc-a67e-fd0e666ddfc0@linux.ibm.com>
Date: Tue, 17 Mar 2026 14:30:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: Fix lpsw/e breaking event handling
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, akrowiak@linux.ibm.com
References: <bc995033-1850-43f8-b04d-66f78ede157d@linux.ibm.com>
 <20260317130440.103576-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260317130440.103576-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b9578c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=267SFvvJ_KVZ4khQfcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfX3JGa/dOBe5jT
 dFJJDZTQIX3sBF4bD2m5lNHv3ehdvBQ2R29peSw+VJCH/iIZAhbCrMn0mimVXVdSByZg4ZMDmTn
 RtdFUdUhzs7+T/pYELgyIBnwQyDkF2/GUNSPa+Bb3o5Q8S24FDFkwlMuIn1ec5w4vzeqcugg0zi
 5VvPi5XL1nEBTdO+hopcE0AGHxE6lPdetkcqPKkQ2X99KbkF7hNfZ9JfykhDYFqa4cnpxfOZW9v
 Nylipq3bEF9pEkufrIZna+KGjqYvjnqUmZ/u0QXdFsm+lh44xDlqxEwG8G1cY9GLtrIi7jEx3nC
 PnvnDecMRHs5OZjz0zVv9SVeulHrz5XBPdeJ3qbuw09x9yOngN73pOHlZBG1LQ89VdTv8VJZaiF
 nLVDLvv39u9hz62anZd3Eox3ZrRNk/DY8C5fAP1ycmzRR2VAo2K0iXZws9ukz3uxuc0DTrcRu5M
 2iiOQpD1DiYOQR3ZAXw==
X-Proofpoint-GUID: GCjeQI4baSkLnWzl1tHH0MBKMsSVmPFY
X-Proofpoint-ORIG-GUID: GCjeQI4baSkLnWzl1tHH0MBKMsSVmPFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170117



Am 17.03.26 um 14:03 schrieb Janosch Frank:
> LPSW and LPSWE need to set the gbea on completion but currently don't.
> Time to fix this up.
> 
> LPSWEY was designed to not set the bear.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>


Looks good,

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/priv.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 3e764e6440d8..9d28b3fdba5b 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -710,12 +710,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>   {
>   	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
>   	psw32_t new_psw;
> -	u64 addr;
> +	u64 addr, iaddr;
>   	int rc;
>   	u8 ar;
>   
>   	vcpu->stat.instruction_lpsw++;
>   
> +	iaddr = gpsw->addr;
>   	if (gpsw->mask & PSW_MASK_PSTATE)
>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>   
> @@ -733,18 +734,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>   	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
>   	if (!is_valid_psw(gpsw))
>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	vcpu->arch.sie_block->gbea = iaddr;
>   	return 0;
>   }
>   
>   static int handle_lpswe(struct kvm_vcpu *vcpu)
>   {
>   	psw_t new_psw;
> -	u64 addr;
> +	u64 addr, iaddr;
>   	int rc;
>   	u8 ar;
>   
>   	vcpu->stat.instruction_lpswe++;
>   
> +	iaddr = vcpu->arch.sie_block->gpsw.addr;
>   	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>   
> @@ -757,6 +760,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
>   	vcpu->arch.sie_block->gpsw = new_psw;
>   	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	vcpu->arch.sie_block->gbea = iaddr;
>   	return 0;
>   }
>   

