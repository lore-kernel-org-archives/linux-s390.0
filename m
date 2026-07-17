Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5142A15C;
	Fri, 17 Jul 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298048; cv=none; b=gZqlXnPM8wfCuL1kHY2p9Ia/rU+lPjN3RnYw28LsMJRU4HLgv8wOckKAUrvwNjpoZVBkMcuVF4qWVDWEYekDSIHzve5NqcJ/XS8QiROXT1SgMMRXyU+BosxnuKb/KeXOoSshl+qkQpMssoUrtsj6RoPZU1+J5QdtH8grSz3uoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298048; c=relaxed/simple;
	bh=cHsTzn2tX40ywNJS0j4WjFz/ntPucHl9/VDGKGcdmIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX/DL+PdzKdt3gM9/EGMGbz31fet83fdWo16SkvSaZXccGrvk82X7T4Jqx77sFjB0+Fl3P8c8CZSbOUqiNgf64TcQ/WVcryCzNJIMLhRnx5GbIjvy1hngPSQ23ogoRwO9RnZd7/Q/m+nT7Pkgu9gGs/TeU9oSRKlUn1LmG97sJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HxsW1v3i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HxsW1v3i"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HEBglY359399;
	Fri, 17 Jul 2026 14:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CorMoY
	NWaVdsQft9S/AsGZ8ttquR2L7zEB96ShrkE+s=; b=HxsW1v3iqhdEAZQgCtD0Wg
	AeTrPiTGQ12zfCM2sQNyaqiCC7gS9eD2+7VntFNuZ813ubwkT5t68JJOfqvP02Yq
	PPn/pOT3aSodGQVOtk2SWarskl0hgb35vNmREedeOghVfsJ1vuq6uMtCTmYV8sEy
	ef8+QCNRIJofZQU056th71VkG8vTXDuvFWfXHC6LWBBOcwdvp92RYp4cKCor4QQj
	iLfkGHwWZ2VWTc9HFNSmfQKfklCam6jq5/+8Ko5wpPlI6cokpTVu5fa+bq2ueZ/X
	OfApTJnCIHBKjstC5okcEGKGGEMA/clGcavEAIfkhOkPXCIOUeS5/y3YdB0RzJ2Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33qdq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 14:20:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HEJkVM014101;
	Fri, 17 Jul 2026 14:20:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qj6xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 14:20:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HEKRaJ49479996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 14:20:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 342732004B;
	Fri, 17 Jul 2026 14:20:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D36A820043;
	Fri, 17 Jul 2026 14:20:26 +0000 (GMT)
Received: from [9.87.143.191] (unknown [9.87.143.191])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 14:20:26 +0000 (GMT)
Message-ID: <dd13861e-58af-44af-bfe0-9dc3dafdd7e8@linux.ibm.com>
Date: Fri, 17 Jul 2026 16:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0NCBTYWx0ZWRfX9ihXaygp5lLO
 O4Rz6jRW1Z9dHnVrO5rYLOvVoBbNCPYFWQ7BlarBN20Rt7O/zHHSFSNmRanbLzy3Qq3qb6F+tgt
 2XLilNiCYyx+mn/Wv5RvvBBKXdTb9Qc=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a3a2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=2prQhZuATWbUqhegNzEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DqIgFKXU8QGUr_fsz44b4UDm_zYQw64i
X-Proofpoint-ORIG-GUID: DqIgFKXU8QGUr_fsz44b4UDm_zYQw64i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0NCBTYWx0ZWRfX0kEHgqrfEDIh
 POwoBLF2T0UDvGvqTLqwLt33sIlQYPajCAco+fUIXAOfh7d04yFKVRYUrWh5qnJqybJKZ1XsRAa
 /AgU7sfZNoasG7dwpteKuFLBjYp8WGvYeV5slO/y6AV04hGYDJ/gSZUK0z1cl8zUcaxgEoJtkBj
 9meY+Vgfc4yUB2Qf/U8Nz66LB8dsX6cVSCfvi3fGDyxjH0j668dnws45NhCxCK7pxivTACuzPcF
 LNQyOGmgK12oz6GJYlPtgXZLNNxeKdmBnpjyFKzJ7ulTdNCjSkOaSgGvhxNK92A1bkaXoCOqsW3
 TE6t/GPTs+9qEfn5E354S8UbTdsg2Yqvs34jR21qqm0OFsGYbweuzgXI7KBzSKDlnwus0dyBqv8
 uygbDCnT6bPRDVnkvYvoRLeiZ6/sxkHbeS0riRvuxRw5CEhVa4DVfa41pZ83bGE4QpWdVedU+er
 duKtuzAsMNNLKNYeClw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170144

On 7/9/26 17:15, Christoph Schlameuss wrote:
> Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
> if guest-2 attempts to enter SIE with an SCA. If the SCA is used the
> vsie_pages are stored in a new vsie_sca struct instead of the arch vsie
> struct.
> 
> When the VSIE-Interpretation-Extension Facility is active the shadow SCA
> (ssca_block) will be created and shadows of all CPUs defined in the
> configuration are created. SCAOL/H in the VSIE control block are
> overwritten with references to the shadow SCA.
> 
> The shadow SCA contains the addresses of the original guest-3 SCA as
> well as the original VSIE control blocks. With these addresses the
> machine can directly monitor the intervention bits within the original
> SCA entries, enabling it to handle SENSE_RUNNING and EXTERNAL_CALL sigp
> instructions without exiting VSIE.
> 
> The original SCA will be pinned in guest-2 memory and only be unpinned
> before reuse. This means some pages might still be pinned even after the
> guest 3 VM does no longer exist.
> 
> The vsie_scas including the ssca_blocks are also kept within a map to
> reuse already existing ssca_blocks efficiently. While the map and array
> with references to the vsie_scas are held in the arch vsie struct. The
> use of vsie_scas is tracked using an ref_count.
> 

[...]

> +
> +static void vsie_sca_update(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
> +			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
> +{
> +	vsie_sca->ssca.cpu[cpu_nr].ssda = virt_to_phys(&vsie_page_n->scb_s);
> +	vsie_sca->ssca.cpu[cpu_nr].ossea = sca_o_entry_hpa;
We potentially update these while a cpu is in VSIE, correct?
Do we need to make sure that these stores are atomic?

