Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631837;
	b=ZqjHRNjldrP2iSiEjyosuoiCQksyARGqB6RClaMBZ4w0PUtc6vOR9aZei8siM1Kc6Jlq
	 XGBSnmu4lP5R8FibkAhtKh7CWx5+2mPgMAYx8Xtq4y/lxkHK1onF77GKT+sbImGhnVuCk
	 sTieUy65ACb2FiZuRyWiZeAGLE/G6vdNiLOeyMOEdoe9CIby65d9L5J2nyW1O5ukbcOMu
	 WzgsSxSeVeuC0tqULqu+sbavO7DdEMZfiftfSJxoQwjhW72LziX7YuWRAFp/H84ZOX7Di
	 VdRGE1+99f4PNMkR57HM2FIFsYU+zqSs4r9tNnnyicBxYmqORuwWYedAfw4yFgUjqZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zCUp5c0Bt/HDiJk4QaoEwgBAid/vRjdrPR5qUXfkDnY=;
	b=gGBFibokVEmlyjAfSUsiO44vOHrMfE5Dqc8bKwOWRy3ATtvQ1MHgKxN/B9omUQKLgQ15
	 J0enD2BUJ9t86D5QMUM78EwhbfCKG3iDcAOCCRgVGpQbDHuiK5VKgnjvoRFKzv5bOPKvp
	 1Ti0zjFspq1jqghxTUHxEdfAOQTwr7RYpIHoAviafxw3IFAoukllrQLMpOnPFtW+8Ro/l
	 E+5jDiSS5UKifU+Lcug3njUArCiemf7jE+HGHqFigZriitW+Zo7DDj71d0oIxuTQkI2qI
	 QjptRsQgE6Jt/KNLFaFPEq0z2JQvPmt0m/4Bqe7WcXYfX8eaVJ6b1JBM/wyibb/Icpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSu3rC9V;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9106083618;
	Mon,  2 Nov 2026 15:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9106083618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PSu3rC9V
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EET8M3114291;
	Mon, 2 Nov 2026 15:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zCUp5c
	0Bt/HDiJk4QaoEwgBAid/vRjdrPR5qUXfkDnY=; b=PSu3rC9VDr34UmOaNMkrkP
	Th3hhEKTpoPbSSxMUJEJO5RtEUBg7hfcsRUzcG0gdLFP+c/zEFIb/AmaYqfbgG7+
	vu244YcZl+3WhpQLkKwuX9m9ZgXeSVlTCdMi+0Yy0pfMHK2z6wexjWwPJcxbRRcS
	2SOlYB9zYgo27gmGX5D2JDhIF9FGheHIGhXzZA7WgIF3WJl/IkJjJoD/SfAE0Wtp
	x60aAFEzB+fZ+qudbAVscVHj4M6KCAFbw/SUvx51itk3dPcA9Js9MZAAeFBI+gkG
	QEIQerOPRi2UCqPsHkCWu6dBGEDHJPqaz2hfsTcNyO/kSMdv4XERUk8OhNJFLxDg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrs2pp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:03:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E5wFM1034496;
	Mon, 2 Nov 2026 15:03:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vefvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:03:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2F3jkm32309878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:03:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4662004E;
	Mon,  2 Nov 2026 15:03:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3442004B;
	Mon,  2 Nov 2026 15:03:45 +0000 (GMT)
Received: from [9.111.82.55] (unknown [9.111.82.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:03:45 +0000 (GMT)
Message-ID: <35e8b549-362e-4544-96d5-637fd78aed67@linux.ibm.com>
Date: Mon, 2 Nov 2026 16:03:45 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] KVM: s390: Fix idte_crste() clobber and table type
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-4-imbrenda@linux.ibm.com>
 <be03627c-edee-4ada-a40f-85a0f5b3068b@linux.ibm.com>
 <20261102152325.1e5a2c31@p-imbrenda>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261102152325.1e5a2c31@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae8a659 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pLv3k7ep7SECNlxe1aMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX+cFdeAc0vdbw
 BQOLaq26Lj+URgO63Zflrv6apu9nSjDFyzjv96PhLuOmeKKtx+IGBzrSYQtVD8TfJZy/qE+Hm6N
 MNQ2cB1+Xm9i8VQNC1KEwYJkDggHCvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfXyqEaJ5VQQEBQ
 8PtbtpJXqx75vWqezhrqMAeEz7/7osmzNAI5KT9n96GpsSaQhG2T0xoyyxhBOKDirLYsTZc0n3V
 kjUWD2HeOCW0tt6oOWp0qVdojZu2+oLNXGs1WrSVe7gZQGEPS3Jyp963nKIuHqr2fnykQ6+mtpU
 INRMkCaWyxZ+BFp13FF65xPzeK5deZ8myepnSsjZ9u+JeDUMClyYcj8ThKI+yamNhBHC/gWfRfQ
 8YNPB+tZ5s3hBAP0HrDIJFazB07j7wsLDZtPqJPziG1nNOMtxpxuMrJTW+VhI6Rhr3dBRihCXAY
 7A42/5eEqbTHZGE/0uRnXhH/iUlfmmdImkX49nebL8ngMcwfhEryqUJqkkgh+FBac60kEeSo5fa
 j6btk9FIWtnNTdQXxpSNg4iud0MhYnP8P3rN3rzrjchWbdASXrWNVm1tgNAOMy46VIC+n6S/1Wo
 PAP0GWf35XL2s64P2Sg==
X-Proofpoint-GUID: QZB-wKydGhU8JjiAQDViYkOtgjttXOxI
X-Proofpoint-ORIG-GUID: QZB-wKydGhU8JjiAQDViYkOtgjttXOxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058

On 11/2/26 3:23 PM, Claudio Imbrenda wrote:
> On Mon, 2 Nov 2026 15:12:07 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
>>> Fix idte_crste() to add the missing table-type bits and the missing
>>> "memory" clobber.
>>>
>>> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> Cc: stable@vger.kernel.org # 7.0+
>>> ---
>>>    arch/s390/kvm/gmap/dat.h | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
>>> index 687e1fa904d6..fb7e839a355f 100644
>>> --- a/arch/s390/kvm/gmap/dat.h
>>> +++ b/arch/s390/kvm/gmap/dat.h
>>> @@ -640,20 +640,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
>>>    	unsigned long table_origin = __pa(crste_table_start(crstep));
>>>    	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
>>>    
>>> +	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;
>>
>> Why don't you just OR crestp->tt ?
> 
> table_origin |= crstep->h.tt << 2;
> 
> not sure if it's more readable, but I do not have any preference

Fair enough, keep it.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
>>
>>> +
>>>    	if (__builtin_constant_p(opt) && opt == 0) {
>>>    		/* flush without guest asce */
>>>    		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
>>>    			: "+m" (*crstep)
>>>    			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
>>>    			  [local] "i" (local)
>>> -			: "cc");
>>> +			: "cc", "memory");
>>>    	} else {
>>>    		/* flush with guest asce */
>>>    		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
>>>    			: "+m" (*crstep)
>>>    			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
>>>    			  [asce] "a" (asce.val), [local] "i" (local)
>>> -			: "cc");
>>> +			: "cc", "memory");
>>>    	}
>>>    }
>>>      
>>
> 

