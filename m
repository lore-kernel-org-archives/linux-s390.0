Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FE3F1AA6;
	Tue, 19 May 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206814; cv=none; b=XDIftPZI0dPOSo60s2BBAy/GOBlQLg1Qx4+3vyHaf2BpQGuxrG8SkXCYsHbjOH0kBKOYEQQYBWnoY/zpUSEnq12f1jzOag9JbxIsaDYr8Eswtyf8VXDjTmYVlgvmBlUPZuMlk3kfSz7Z1xh8kadYYX1+slsjwAk6Ur2TfLrrAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206814; c=relaxed/simple;
	bh=E9JLlMn2j+8zxBsFxmh2wEjBQEmG7o/ntMfsSTXGLUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaS878x64YeNhUxGFDs5QsrwKZOuE9fQSE9lgDAhJxxxJvz73AFlVvEGCYty2chWstx5PvayNqkfY3jahOoUEi1P1Y3nEXDlgBN4TdyH1XS0TbXx0tsfWXpWjlNc/xw3w4456wjNnmnfPJz+gnO2uqmARJtphog06HLJpMNfHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lzcwQA1A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lzcwQA1A"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEsHx1825954;
	Tue, 19 May 2026 16:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=COAuK3
	S5bbnbwOOJ7/HprXfMIG7KKU82kGoUP4HsFq0=; b=lzcwQA1A7K70JN9e3nQm+0
	HenOB0wS641Go4SL1IBScn76NLPMic22XDC2o7NwtYpLDbeKSAfQQFYVSo98hzKs
	XUV598xUDBJpRXFJlvyZLpATJA/KOrn0QVTLSJZcCD/nu6elsUjPQGev8oyiTV7Y
	MTuPRXFeUuWQgb8M9DvyC3h4C04YT+37C/wfRP1/1HNfw0WHU63CRaooMaQyykzw
	IkdsaNQjW2+ougn728H8sebjpxzwySzUy8EVOwlDYZ7j2S/6CqkZhdFek+epBBPt
	GtL5ZFg7G5C9jrnMx3F5uXgG+g9N5jCqbui5K+D5AKe59i9pNmXhh/BzR58ifyGQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74wxe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 16:06:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JFdBAf011730;
	Tue, 19 May 2026 16:06:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq3m5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 16:06:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JG6jdP49152370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:06:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CF192004B;
	Tue, 19 May 2026 16:06:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2F7620040;
	Tue, 19 May 2026 16:06:44 +0000 (GMT)
Received: from [9.111.6.43] (unknown [9.111.6.43])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 16:06:44 +0000 (GMT)
Message-ID: <c5c733b0-601d-4b79-9bc9-3db8cb050845@de.ibm.com>
Date: Tue, 19 May 2026 18:06:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] KVM: s390: vsie: Fix unshadowing logic
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260519150114.264309-1-imbrenda@linux.ibm.com>
 <20260519150114.264309-4-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260519150114.264309-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c8a99 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rznNWEhdgoIwmHFpetAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: X-x9RMLUET2y73oh_kPqPF3df68YANhF
X-Proofpoint-GUID: X-x9RMLUET2y73oh_kPqPF3df68YANhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2MCBTYWx0ZWRfX70JY6CwZ80cr
 F6X5LhFrSsUzI0gUewQ+FjNiCV+KL1wg+tlIBH5oHuTgmmehdWz9VcMkVv4gFsXyNkkBlnwmyYm
 Fc6LcgR/3ip8JvuuXxzk2k/rx9HpQsQiyZdABxpGeu1LxrplP1zV3HcOoktnrAsnHEhhHBXgP/E
 1+fTddGhSn4zp9pyaKdsNjbv7+rMzYJO717z4MxaZQSNPy04eQ+3z+dB/BJoil/qbKQWPsYRjMu
 VcwmavTOaDlHiHf4zLH8zMA4J7mTddWZqsKqIFgSKCX/qyobAh7TWMzvZnTKlyupT9on7FqM1fc
 MZa+AipZp8NecrG1XaAFV4RWKvEHY8rahuNPvQWTjncweRSMeukdkfbTkMHeI0deAHQ8WH3mWyr
 TgSGRpVgSqmQeLT5pzjHa2l4pkzJTeiO4b8Hzvwvyni+Bw0AdQlZZgr53shfSBZH7/O+i0ZkD2M
 sHBt51BRA/CNkxFAhFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190160



Am 19.05.26 um 17:01 schrieb Claudio Imbrenda:
> In some cases (i.e. under extreme memory pressure on the host),
> attempting to shadow memory will result in the same memory being
> unshadowed, causing a loop.
> 
> Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
> tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
> unnecessary unshadowing and perform better checks.
> 
> Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
> not unshadow properly when the large page would become unprotected.
> 
> Opportunistically add a check in gmap_protect_rmap() to make sure it
> won't be called with level == TABLE_TYPE_PAGE_TABLE.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


