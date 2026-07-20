Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AC388E74;
	Mon, 20 Jul 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542956; cv=none; b=MSODpIQ0DUonm+Moit/pQmlux7xaZM2fe56dKDXGj+f6KBaS1c16/b28Z68p0btmCuquoUwWbok5WaojhRdFGXFpaeXC3CkUzXsVsHyTHZlKdgSxJhKiIAP5rAQpUo6PlSGao33UP49DXT/2nRP33C9JiWF2NKK7jHsV1CEaxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542956; c=relaxed/simple;
	bh=V2Jbp65Tb5elJFTmyNEnh0Sl5l5FFybsqFENj9x6fSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/eoy+oPXSBmIrArmO4J+inTHE5IqiRUv5fGZV50heu1do/Jn711JyTUfLP8uWWlbLapScKKrxR8umTYj/eBvp1xv5mMMolIKp0yrasUhOrTGHNR5EPtxIpZlNTCT2gLsdq8J4QLHmQ/1GKNC1Yw7Hid6vNfl+3i3Z9h9F+zkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rtBmkvpZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rtBmkvpZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABhx81811426;
	Mon, 20 Jul 2026 10:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/os2hd
	JOgnrgzWWYBsChFOmqiaBPCYTCZgY4Wf6Tw28=; b=rtBmkvpZFn03Apvg8Kw5uc
	/AgBL4QxuWtH82MvfMMHV6ThMqoBqli4Tbm/gpzsqCsHdoFv+SSgfYl3qF0muOp8
	BbVOf3XD9B31CooyhfhAw+lBbOwtKgdi4PmFBCHBijgk0kKRN+txIAuDwAYwJC1+
	BUaZzrIyp42Lk0403I2sFGv71fB3HVS3IdlrOU2nsqRXVCH5ob8GgXD5WADldapc
	EWfCNQs3OA708Ks/pjmrVNsM2CFiFErjv+7UNyqAb2RTM4Zm0v6f3w3Y9nlyJXj9
	LLlEtmP05JWv8gIKfYRbKmAkdxjji1cEGfRhBKLG7gqJRrdgqgk84/MgUnj7lYcA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxp5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:22:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAJcpK011526;
	Mon, 20 Jul 2026 10:22:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpwafc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:22:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAMRkB40173968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:22:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4986A20043;
	Mon, 20 Jul 2026 10:22:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3522004B;
	Mon, 20 Jul 2026 10:22:26 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:22:26 +0000 (GMT)
Message-ID: <ef45b636-f9da-4ac6-966b-091b657b5e3c@linux.ibm.com>
Date: Mon, 20 Jul 2026 12:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] s390/mm: Fix handling of vmalloc area in
 do_secure_storage_access()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-5-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX1l/TRJF7J1dm
 qmbbeB35KZt0tAaFl+lxX2ejAluWC2VfxTRRgiB3G/hP0U4yVy6Gx43BKxsVJd33icrYOAwCCaK
 Zcs/bMb99Tp6nEFsnnVc7WMKT52t48n2uB4nAkCQYY1wrP+T9RamJXHs1zwqz/qXhO4LVMnA6/q
 Ih6SxuFYMlBU++FfPMdyQFgxo8iUGWSzUgUqbZA8J51gtiHiahHuLQ8uzbSXQ1eVqFHhv8zJC3d
 I7PuIXqxfKztT2K32TRBThr2FNBC5WpPRA2TdNOuiqklo6IAD3EjpzZdX4ZnBR5c/wv89HqGSXS
 5DUfp1uPnxtW4TPnQu6rAegj9opP3qsdyPqlz+i1zSoiOAIC0uI83Uq1nkoIHkWMTlwTY8w8/tO
 ggElktJmfLjn5kx7aXYstazHLmJCijjwlN66mbDalyWNb3lWak+w7mVRtc+vXDlM0jvIqrgbWfY
 fI1nyWn6or0d/+gFobg==
X-Proofpoint-GUID: Yfbc1LgM4lM6_gogORNTWDWM1-H-fl0U
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5df6e7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=UbbVNIISdgRz_8cPp8oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfXwQGEjW5cBT16
 bJvz17DO8vpDHLS2bDdvhRYWy/PVyFNc3pZQ0qHKDsMgWnk3Dr80LZzpqjZ0BLZiRuUH6ZFf8N8
 kMIBDNBYFRQhSz5kWaiDXlQvmvIZEfA=
X-Proofpoint-ORIG-GUID: Yfbc1LgM4lM6_gogORNTWDWM1-H-fl0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114

Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> Secure storage access exceptions in vmalloc area need to be handled
> separately since folio_try_get() or virt_to_phys() do not work on such
> addresses. Given that there cannot be a valid access let such exceptions
> fail immediately. The kernel will either fixup or crash.
> 
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> ---
>   arch/s390/mm/fault.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index f150d97cac2e..e650cdfa2523 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>   		panic("Unexpected PGM 0x3d with TEID bit 61=0");
>   	}
>   	if (is_kernel_fault(regs)) {
> +		if (is_vmalloc_addr((void *)addr))
> +			return handle_fault_error_nolock(regs, 0);
>   		folio = virt_to_folio((void *)addr);
>   		if (unlikely(!folio_try_get(folio)))
>   			return;

