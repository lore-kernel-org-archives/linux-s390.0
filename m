Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2C42A16E
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340816; cv=none; b=cod1izlmEU6TUjgPHrzS4N5v7sxEP6C4EX/2Ug3qHS1fQOTmxc+IptWD4uJMcPZVRCzbXbj7dAeREiHjbMinIbsSW30FosKrghpuytjdPDE4SslHsVS/ab7PTqelMKRZcSmk3H1uYbBD1QXps5Fn95I0z7SLhqwma8fjm69/X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340816; c=relaxed/simple;
	bh=RZ3M5mrawcpIlP9f/1Om2ZE3l7TosixPaHNvwtQzlqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx46/cPjXor1Vpkt8PKj1k2S6KvL6WrbwpGhTWYtNvktIGqMj3nYYAopR7FtsiQM3JcdEeq5iKkTPLrSSf/mN2x8LkWDFLAyTvDe0TEYOtCEYQLKzBOgQ05ud5i2NDIxZLVpRUtZsWr7NtUbl4lsPVHW+xv7wKuSN/1PkMXI9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GaS7jsyL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GaS7jsyL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIQhQ3447697;
	Mon, 6 Jul 2026 12:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hzloyd
	7p/2Wzx0QUJxr6FRX8Je7l5Xm93r2lV//8uoc=; b=GaS7jsyLK0ERjGPi+Hx3TK
	2GSpGSO18NR0oE2ejURg6uXUyFgWYfEi+7bhu85kYvCE9nr55xIHGf4qyfN1QlAd
	Ikdb58uCO1nBHaVEfNL8lcr46TEMZvw6FqjpwiDaZXalUD9Dg1L86BWTGj2YBY0C
	x7IsfW2ETOIp4hFmuWNARHG94frrYUifOuCzLf0u2p4Tcv/hl6Yoof1SgWilqNro
	GVIe20Q9xJ7aNluiduMrHyn7ZPIYlCDTdmWhbf/FeYALWigXx0HvjyksZDtElGKE
	GlnzunWONLNJqFyYApZ2BzjDMT9q1I0PB00esrB9vZlKAhI/40TD45BnxanyNhgg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stshup7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:26:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666CJciX030483;
	Mon, 6 Jul 2026 12:26:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfw9jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:26:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666CQe5I51380522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 12:26:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E834B2004B;
	Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB6120040;
	Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Received: from [9.111.8.43] (unknown [9.111.8.43])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Message-ID: <28950379-427f-4b23-8247-721d25291799@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/21] target/s390x: Fix wrong address handling in
 address loops
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260706094317.17032-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2E0q2gMvM8wE0EOVMPe5jUEK9mgRdk5L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX9DGogk4eMUjH
 R0e9UxMwBBA69xRv6mj9P06qAv8uCtU5q23j0+krdNrASLlsw0CyV0pE+0NA0QtUS0i5VXIqPCs
 AIcikyfm2R9ntn/N6vElq12Q8nF7Vzs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b9f04 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=sR4FTfRTi0JzboByPSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2E0q2gMvM8wE0EOVMPe5jUEK9mgRdk5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX48b2OgbuCXWb
 uHaPKmy8f2Q/ORXtQ9ANuCO5r9IS3DhRRiLdmq3r0GKfQezuensuF7Xn8325EQPaaMdOo1EliY+
 03DJ2DLAS4xJ7IHadK4/xDQvFN4M2enxJhQJRXpiiLVErFStwgVYV1qsbz1d4NX8xgkUzIQC1hP
 4/r6qRsFt+bhuyStwCQeRokqWsR70tDlRVAmXoLUwcKgxPIByboe4ELZ2OSxAKESKUpj0XgTOUa
 q4Yg5Z9dFVnsLAXZ23GpmpOnQEPdQzlds1h38XWUzmJhxPbV6JHmhYFOQ8lKW5uDjvlNC/l0ziO
 B/lGDOIb2GO4GUAao4wWnn7YvKHGdt6wjs5JoFHh+Rs+1ZEhJCWJnOtglcharzuIO2cdflhAIjJ
 yCoXJ8EEnc1vpDnRCzp5NssXadYtSGvOiwQuNEstIO9RmvdjOu+inecQGe0m/7tQ+hQvyb/4l2A
 qEPoH7ERzsdjpOMsrqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060125

On 7/6/26 11:42, Harald Freudenberger wrote:
> The loop increments addr by the element stride (+= 4) before calling

+= 4? The code says += 8. Which one is correct? Please correct, if 
necessary.

> wrap_address, but then overwrites the loop addr with the wrapped
> value. On the next iteration the stride is applied to the wrapped
> address of the previous element, not to the original unwrapped
> address. This results in every element after the first is read from a
> wrong (wrapped) address.
> 
> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

