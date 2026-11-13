Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566847;
	b=2YsjoM4OLtH09srX9h5ShVWCE+Se9r8xcYgS+9DJsNU+cAbxJT8DwlEk4hc+2j48S1l8
	 Bj/TUFpW80CZMZ5Rqw5Q20Fo/tmIybWNMlfBiLbfhy79B8w6oceTdwQ5Fx5kQ7nHpBTRn
	 oe7ftSxhZk2mmUg9DCMt8ybCYYqtnJ99yaYx71q6PNmSA0ZQdn82f8MMxjkOCiDi47JGu
	 Gegg3FJOG3ctcqPt9a6G2E4U8Ug0idHXVMx+MeIF0I/BxGylUXPw2kDEck2el9Qrumuay
	 dl8vAAOiVXmFrhU+unlAFpioDQjgRz3OG7CyHL0BKbRGbZgU3rT6FkSSUFdXghR+u8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566847;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PDrr01F8zEi2bfwy8RiWD/Vfd6hVMWs3NzZENSUK8DM=;
	b=vzmvj6ulo7HYv7zewfhfZ41Kb+yj6b2xujCfagiTr68z9UOqJl3S6mM0cVKXrEQE44v2
	 ICVniMGvWSwjKT8BbM5uDCafp8jVwGtiR7RDa0JxwHhYis6iUyQ3UPlzO4gOgpw38o/fI
	 EfzwZLdE0NLNwbgqL8/p0crmAHqwavL7bTeBlIrAlMrHPb2hZK5ECLS1kp/YjDdnxr/NH
	 4qvxXXfDalxxSnYfNMPIXtdmzthbp41X0MGiev+QObS5sW4UGxnwAhQMftxpe1DUbaSKq
	 75jSAOUvFLLif15OjVB2VVTIwYSumfdHbY1kaMKxjXnVV9ZYwO6jp5/4Yyo1BUisI5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qCXZ5U6R;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89B606A323;
	Fri, 13 Nov 2026 10:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C89B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qCXZ5U6R
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8iQ66735030;
	Fri, 13 Nov 2026 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PDrr01
	F8zEi2bfwy8RiWD/Vfd6hVMWs3NzZENSUK8DM=; b=qCXZ5U6RKznhVjxaNakzzt
	RvCjXLi6iLTpjmzOotiQwwzCkJS7KHohuQRAuLouD/5dM4FXTdXyf+DLgIZV0tEK
	Xl0j14x0Wl7S7zOJvRgXChhZzOYOByZkrI04xxhhmNjXIEb+WZkMxn1AZyFkQjzn
	3ZxMqeAmNyy8CwYgoJai7fae/XVdWSLaT28kIbR2ggjQD+yIXlsTDvV3YBH3zVkk
	y3c+a/g0NZhBKh5XrVJsbDws3i++q4Ww/S9z8bG5ouwIFgIr3gipgHmH7F+N83Z9
	NqzJB5Qdwpo6/4LTwvFMjrLN1sbrJybWAr/EOLFEloHeOAUrW/bqEG9jwkCxgUjA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntjtyf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:47:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8Z5bX2008611;
	Fri, 13 Nov 2026 10:47:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85bkvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:47:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADAlKCx38273346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 10:47:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2909420043;
	Fri, 13 Nov 2026 10:47:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E998F20040;
	Fri, 13 Nov 2026 10:47:19 +0000 (GMT)
Received: from [9.111.25.141] (unknown [9.111.25.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 10:47:19 +0000 (GMT)
Message-ID: <9ac3d4fd-3bdb-4570-a294-47ed73114463@linux.ibm.com>
Date: Fri, 13 Nov 2026 11:47:19 +0100
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
Subject: Re: [PATCH 4/6] KVM: s390: selftests: Add ucontrol helpers and
 instruction tests
To: "Aaron M. Brown" <aaronmbr@linux.ibm.com>, kvm@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
 <20261110111619.61760-5-aaronmbr@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261110111619.61760-5-aaronmbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX8Zno7FJhSWx0
 Cfrw9ldAyvCk+vDi5IjBuuWWzRtPWtnNB5zf87ygT7CJcmi17oYRxWB8YdGeAp9QexN/MAdojVH
 i7PYxTaF+0q8nLWLGXnwtsKMM/Vij/jpiaJm+vbD61wJQ5JHB55O5lIQGxVoUMk2MX55CHnKmMr
 3B5Qzdun8TmQrefUcbfaHVS+KX/1BtIVKB03KG+HDbQqrxMmBYoyTOFodzriwy0Rt5/fT17t/BH
 8u+rcDX1ErS9K7CyivCUCIyQNnTngtLzQCpESCCY9AmoDk4MXaIN332owz032kC5CEYBzfxIEX5
 EVu/UxPAVN3zX9DOvYcij795CaTjYEaL5q0SPoW59Q75VASYpiHD6EMmWMnq8ufUpisf2E4wJ0z
 uml4CEt8Oi7vzrfL9R5yue2qzk+yYJ9VLLKgc1YII/+QOKEV6VfDfa6YpiE6AbyrnPYxbKKun+N
 NEs7qBFw0sa0aAGwd9w==
X-Proofpoint-ORIG-GUID: uZGDG5WStga6aGL4dutLzxir8GSfBQHk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX6e3BnwDsAQm5
 YziSqNMli5BA1dW+23Ts9zg24rBRwu926OBG3BSMdsE+YP36To/IMO+ZWGKJtdvijYSKWvFZMoD
 4L5PM7wjl6aYkOQBMFXiOwB6iptJubs=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af6eabe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qosI_CU9wHyCTK_ckBMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uZGDG5WStga6aGL4dutLzxir8GSfBQHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130042

On 11/10/26 12:16 PM, Aaron M. Brown wrote:
> Add helpers to run a guest on a ucontrol VM and use them to test
> instruction intercepts handled in userspace.
> 
> manual_kvm_creation_execution() creates the VM and vCPU, maps 4 MiB
> with KVM_S390_UCAS_MAP, sets the PSW and r15, and runs the vCPU. r15
> must be valid because C guest functions adjust it in their prologue.
> 
> ucontrol_available() checks KVM_CAP_S390_UCONTROL and CAP_SYS_ADMIN.
> Tests that need it are skipped, with a reason from the new skip_reason
> field.
> 
> Tests added: STSI, TSCH and STSCH. Each must cause ICPT_INST with the
> expected opcode.
> 
> Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
> Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
We already have ucontrol tests which have a working fixture handling, so 
check what code is missing in ucontrol_test.c and move that code over 
instead please.
