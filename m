Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42D379998;
	Fri, 21 Aug 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341277; cv=none; b=qWVrZSBgRmMeeF8bGKlN9i9mfS0zlfPnMpYPDYo/EuXAPk2/0DjdYFbvlsDJd/+w0LVq0YQoD7OCzry0YL3ZP7V0fEyhd41A9oPyoTd4a/rzD1uAmCDagydx4A3Kc60lzGpzyR7IkHQ8l7SXfg2YX48ju7IRGqEfpeXnXvSr/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341277; c=relaxed/simple;
	bh=2zrKE+9/no8iEpR2nt1pkwJvT4OmqRqR/H5cPO3X0ys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OWnNgh8U6VsxJ3Ebll9dyr1OP54G6k54gnBFXaMxNNR9mLC4zSEjmos5Ei1nfCsaNAoIeBsnZM0iXuAefg79tZHh1QyAeK5fZOA5aVySEQdFGaNdLzqDgsJDk+QGw7at9BLKdFSOoJC5m4W5SR8YvV0T8A2mmnQ9AgCBeZqrJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rxfh78Q9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rxfh78Q9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVWWm2363579;
	Fri, 21 Aug 2026 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w8Bp8Q
	yM9q1w8NgbWM1NfbIws9K+e4Aul4fV7xHzF2U=; b=Rxfh78Q9rr0rrRmdKUbyiI
	OtSxlvfQPYn/Wui3dSeATLzBL+6P8cCdXKJHVufQ1J6aSkpU40hVpmhUdqVbtFe6
	Onbj8Pi01qDnbzMa3oRWixUzcGagbXYZaqVhO87PbZo1b8S6SL18J1psWdzqJV1t
	Hb2DN3ICFMuIJlZZL6FWOEwqu5xItfxtjSAA08SXyf6PooCLe2xqkVkT1pgCVpDw
	6TC1I8u1kGGLhfsp2Mo6jFQch+V4L8Lky2pOgjh+dm2m/tOiuCt7DlnOIbWCkz0a
	nBDNsHb26F4TjQYyjjb7WZei+VDy2bNaOrD2wtaltVvjfoO3jdAl6HQtVvlv8qBw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uv8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJQF5v017740;
	Fri, 21 Aug 2026 19:41:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngxd4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJf5Pp52232590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B13420040;
	Fri, 21 Aug 2026 19:41:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5337C2004D;
	Fri, 21 Aug 2026 19:41:05 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:05 +0000 (GMT)
Message-ID: <f6eb1619-9957-42b6-9c6c-74b1c17b9b0f@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 07/25] unwind_user/eh_frame: Add support for
 reading .eh_frame_hdr section
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-8-jremus@linux.ibm.com>
 <20260818150220.373FB1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150220.373FB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88a9d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=ag1SF4gXAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=MFYg3CGWmyyPB8xNBDMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: zL-GG1ydcd9kxgvpTrpcUIajpVdFOywz
X-Proofpoint-GUID: zL-GG1ydcd9kxgvpTrpcUIajpVdFOywz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX3B45yTaRXJX2
 SEmEm/soaZrB4awTEe0PPpkDFREmxn7QFr+MWmP54LiFA5x1Q8IBRpFZ1qWUvpUMnKxchQ5dAW8
 kn+9arlLA7vm3VRD9Xj50srtdNHpiEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1DiLPRFaVDKD
 9fmgOyEEGzi1fJi9F4D9S9h/cQgkDX5HMfaC1qjS0WIHgG5Y2GcvRj/dviNbE8aRbHmjlrZhTNa
 J3PBkS3PdpA6yUNuTRv0uHyj57awZyZokEHsy1YXBaoJecfF0w0UkrWXx721teUrrwVPIog2+l6
 nLnT+2HLkzgwjnMEmYzHueSf0RuEmrUDiQhHCyGzNid3lSfrt51ov0MWVMrkq7vEWuAqJo6G55f
 LB3UeD9Oq29BRvJjPo1R2Urr2bc/niNs8ATrsLIhMmWDHyRtlgPSVbSy6jsKeCDnWQG973rrfl6
 EjJAraIxVOoFa/nj/NbJNHLiPFU5/yaTTXQ+ogDVudacF4KWQF0jxtEE+JXlGF/uoxNMlMwXE6h
 jhTuyjua3GZjq3CNzoI+5YTE6aW6DZRs8Sn1IxIzL+/LNqC+3NLDV7ZFbi7TKjImF85w1PyAHCN
 8r2AQoZSnUo+VkHk/fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:02 PM, sashiko-bot@kernel.org wrote:

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
>> +						unsigned long *addr,
>> +						unsigned long end,
>> +						u8 encoding,
>> +						unsigned long *value)
>> +{
>> +	unsigned long cur = *addr;
>> +	u8 format = DW_EH_PE_format(encoding);
>> +	u8 application = DW_EH_PE_application(encoding);
>> +	unsigned long result = 0;
>> +	int ret;
>> +
>> +	if (encoding == DW_EH_PE_omit)
>> +		return -EINVAL;
>> +
>> +	/* Determine base address based on application */
>> +	switch (application) {
>> +	case 0:
>> +		/* Absolute */
>> +		break;
>> +	case DW_EH_PE_pcrel:
>> +		result = *addr;
>> +		break;
>> +	case DW_EH_PE_datarel:
>> +		result = sec->eh_frame_hdr_start;
>> +		break;
>> +	case DW_EH_PE_textrel:
>> +		result = sec->text_start;
>> +		break;
>> +	case DW_EH_PE_funcrel:
>> +	case DW_EH_PE_aligned:
>> +		return -EOPNOTSUPP;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Read value based on format */
>> +	switch (format) {
>> +	case DW_EH_PE_absptr:
>> +		UNSAFE_GET_USER_INC(result, cur, end, Efault);

		unsigned long tmp;
		UNSAFE_GET_USER_INC(tmp, cur, end, Efault);
		result += tmp;

>> +		break;
> 
> [Severity: Medium]
> Does this overwrite the base address that was just computed for relative
> encodings?
> 
> When handling DW_EH_PE_absptr in combination with relative application flags
> like DW_EH_PE_pcrel, the base address is stored in the result variable above.
> However, UNSAFE_GET_USER_INC directly assigns the read value to result
> instead of adding it, which will discard the base address.
> 
> Should this read into a temporary variable and add it to result, similar to
> how the other formats are handled?

Yes.  I wrongly assumed that DW_EH_PE_absptr would be treated as-is,
similar as DW_EH_PE_omit, and would therefore not be allowed in
combination with any application flags as well as DW_EH_PE_indirect.

The LSB spec, section DWARF EH encoding [1] does read as any combination
would be allowed, as it is also implemented in libgcc's unwinder.

[1]: LSB 5.0.0, 10.5.1. DWARF Exception Header Encoding
     https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/dwarfext.html#DWARFEHENCODING> 
>> +	case DW_EH_PE_uleb128: {
>> +		unsigned long tmp;
>> +		ret = read_uleb128(&cur, end, &tmp);
>> +		if (ret)
>> +			return ret;
>> +		result += tmp;
>> +		break;
>> +	}

>> +static int eh_frame_read_header(struct eh_frame_section *sec)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	void __user *eh_frame_hdr = (void __user *)sec->eh_frame_hdr_start;
>> +	unsigned long cur = sec->eh_frame_hdr_start, end = sec->eh_frame_hdr_end;
>> +	unsigned long eh_frame_start, eh_frame_vma_end, table_start, table_end;
>> +	u8 version, eh_frame_ptr_enc, fde_count_enc, table_enc;
>> +	unsigned long fde_count;
>> +	int entry_size;
>> +	int ret;
> [ ... ]
>> +		/* Read FDE count */
>> +		ret = read_encoded_pointer(sec, &cur, end,
>> +					   fde_count_enc, &fde_count);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Determine binary search table start and end */
>> +		table_start = cur;
>> +		entry_size = 2 * encoded_pointer_size(table_enc);
>> +		if (!entry_size)
>> +			return -EINVAL;

Check that the FDE count is within the remaining .eh_frame_hdr bounds:

		if (fde_count > (end - table_start) / entry_size)
			return -EINVAL;

>> +		table_end = table_start + fde_count * entry_size;
>> +		if (table_end > sec->eh_frame_hdr_end)
>> +			return -EINVAL;

Drop this check in favor of the new one above.

> 
> [Severity: Medium]
> Can a maliciously large fde_count cause an integer overflow here?
> 
> Since fde_count is parsed from the untrusted user eh_frame_hdr section,
> the multiplication of fde_count * entry_size could wrap around to a small
> positive value.
> 
> This would bypass the bounds check against sec->eh_frame_hdr_end and
> potentially allow the kernel to trust an arbitrarily large fde_count,
> leading to out-of-bounds kernel memory reads when performing binary searches.
> 
> Would it be safer to use check_mul_overflow() and check_add_overflow() for
> these bounds calculations?
> 
>> +	}
>> +
>> +end:
> 

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

