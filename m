Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30B3BFE52;
	Fri,  7 Aug 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100811; cv=none; b=ROu1sATa5lyCOlaRzRkoBzVTf4pDj5/t2v5m+L9Yw7ug9jrwtiPieu+xlX/5ioJABeafHrH5SJYNOEPanNru+clX41Uw/CXwUvOUKRqvqrjs0iM0aJGJvBJ/XNR+0B3OdSHR8hF7O0J+T7tkm/e1mGs1O8rhg16FcczQOum/P50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100811; c=relaxed/simple;
	bh=v7KazLWpeaYnQmgeQJtjJDHPhNMZzI7GaXqtcmNqxmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sx9HKkEg0OLoPkThSjxJwXqDODj+soM4UkcXZPBAFoEplqTI1lvFf8EgAZ3H5yKlnBe3t9pqxx1BS2jrqGZ0jUeg+LPjSQLo8Oe+z/4Sf5UlGSkitU7zT2fv+3DLwJ1pwrzAbWNRKiB/IZLSJTezgESlbi95U2AdHzU35H10UCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CT6Yrc1U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CT6Yrc1U"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HovC4068205;
	Fri, 7 Aug 2026 11:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tUFOrAECSdKgMQZYQLLoXPW1/6SL2d
	KgtTpNVFBgGnM=; b=CT6Yrc1Uc2liWkfL6ov9XlWyU9U2McNbf2NLnTn9dGNTrr
	kiVPmotX3cJh/0F1up8SSNzBj7joRNYKAk0+O3bzhaK7MNCKDWQ4BojnC2StPpFk
	Kv2BXHkW9abuJvbB2nITpsGlVCOy7uuPEAv1nPPp6hlJQf9Pk2vbsF8ymSg8X92Z
	f6LznkL7kYZnumCiMLJnyFWJNdtT4m8VMdi0nqBxj+WeVud7X9tzOUqSTzCQzU0U
	kEpjRHQaIUhvJXq+UJjjvDH02kNLwWZoscV7ukCBQJp1zSAjmfmq/MaXpOj3fGgV
	K6vGKLss8/dWFyOljmNBx+1ysePZzy2Psw9sO+0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy023e57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:06:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AuHdr018996;
	Fri, 7 Aug 2026 11:06:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgq6rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:06:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677B6gJw51708258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:06:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520A820043;
	Fri,  7 Aug 2026 11:06:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D41220040;
	Fri,  7 Aug 2026 11:06:42 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 11:06:42 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
In-Reply-To: <yt9d8q6irz6h.fsf@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
	<yt9d8q6irz6h.fsf@linux.ibm.com>
Date: Fri, 07 Aug 2026 13:06:41 +0200
Message-ID: <yt9d4ih6rxz2.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DprsAnoDZjxS62xV_1G7tTJC7AtRWbH4
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75bc47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ZTAy-GUbHt1BAPXnVhMA:9
X-Proofpoint-GUID: DprsAnoDZjxS62xV_1G7tTJC7AtRWbH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfXzFHBDRHCVX9m
 jzGORdmJ0lkLjQiMklmKFew8uF+JAIFIbU9sW+K993qZZPdx1Hv1GRsrzYfLtUY2LcB4PYl7PZP
 AJB/zmEPWQv0L13T4dPWb/NzcxKfCDDLokkRPRyZbDXsOfJl9L6TxCmTyb20i6zS8I9rLWOxY2P
 kBy+2Au+f5JRO3WXCTUsuwCrWzGEIQR5VUE17muLMV8TcXSsD+m67eCkRNUlc41q7+f2/nDkaGv
 PMeLzeKnj9Kl3KgB9Lju6+cT7alNjlEWzaTOyoKbxmRXsOOO+e0Nj1Gcrvlnz70V+zMEYQaYr+O
 rh0posqoBceRvM/7pBRzNktiRgiaFT7mdip6y+kIPGn3l5rPHcLc4bAjiuGtaISCE8CIXNrihz6
 jnrqeCU8PbsB3URAJ39acTp8rzEP0TPadvbnNhbxk75PXRE1u3ugivpERSnFu+vOtLB/EK0dBz2
 frV8E5SYToRadzQVPqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX0MSxeFz81Zt0
 4pGCzA1W8Zj8rY+4bNAopmiREyB7Rh4jAAGuEUq0C03Q1g0bLjwSK12uHOS6CTcRG4PyYzdB7pY
 4vLqxXj960yYGH0pPDvvFTn0LplCqYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083

Sven Schnelle <svens@linux.ibm.com> writes:

> Christoph Schlameuss <schlameuss@linux.ibm.com> writes:
>
>> Make the code slightly more readable.
>>
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>>  arch/s390/kvm/vsie.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 3e956c7faa4b..937f9c99bc00 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
>>  /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
>>  static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
>>  {
>> -	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
>> +	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
>>  	/* mark the page always as dirty for migration */
>>  	mark_page_dirty(kvm, gpa_to_gfn(gpa));
>>  }
>
> Could you add to the commit description what you changed? I.e. use
> phys_to_pfn() instead of the open coded shift? It's bad if you do a 'git
> log' and get commit with useless descriptions like 'make code more
> readable'.

Nevermind - was in a rush and missed that it's in the summary... :-/
