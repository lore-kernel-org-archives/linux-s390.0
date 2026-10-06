Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B13BAD88
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273138; cv=none; b=ElccpsK1Ac1yKRBjM1STFARc1hZ29VyUwylUxPwjRwCeMdYofjdZaSSqQXCtbmUKb7cMqDpROB07epf6cMKNz82xCJYYTSfvuNHShW/dImzn3Ex2CsibVhETT7SYDPCeZKfV+ArBgK8uJWBecEz0+OudDKT28VpVmLE/5J7B7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273138; c=relaxed/simple;
	bh=dnG1CRQFIl99BAZX+HGEIB+OfL4ZEs3PCn7z5ppsrt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g75o/jtWKxgqOewE3rtqq3Z4ecB9+rCmB97IqPX50ymWNsSDR3S9j/bJHuol2MYqV/kO4DJX1I1w6oUN9cHuI/6cgXLkNpNJNQpw92UYKTWLy627dTJSf1nGc96ul7eIjY65smCHWUeyAnRmilrTWFKRfzF/xCN0Uwu0iBXaB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j0t+LIWY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j0t+LIWY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966cSQ02930601
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 07:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=egO7Uf
	FXvzWh8b4/ZJ4ANEZfmJCk7MhyAzujBsDhLTA=; b=j0t+LIWYZ0GxBUk2sEh8cm
	Boz6yUlrzQF35icflRO8EqnsGPbcOdwfSjVNtsT1aAQCI63g7s6kXdTmflLF6kwz
	ohdctgGWKkKXuAQmUbmtxr4RpdNcIlmHpb4TbsXRJ7iQ5VmRMKz6SPjlY0OPYqx1
	mGKvKIaxyA5n21qP0i9w5Z2I/+aRp5O00wpazKmcVSn22pXoabndY7HgrxJ7jxDK
	sYUU6ZwiE0BJmlNoiFw+UkKBK0j3jSolC4udhS6Sh90ByRMmO/JNrpBFHL58I3NC
	vm4HqvnRfMZUsVxnqvrzB88HC7//BdVb6TUWJYYVvz8xKTNPTOifXx+N37jH498A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv5saa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 07:52:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6966lcPF4151965
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 07:52:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgrw97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 07:52:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6967q8ZD47383020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 07:52:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA672004D;
	Tue,  6 Oct 2026 07:52:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895C420043;
	Tue,  6 Oct 2026 07:52:08 +0000 (GMT)
Received: from [9.111.8.112] (unknown [9.111.8.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 07:52:08 +0000 (GMT)
Message-ID: <b57ad058-ce04-4f91-b5fb-c1f1bd7ab558@linux.ibm.com>
Date: Tue, 6 Oct 2026 09:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] s390/crypto: Handle cpacf_kma() return code
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-3-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20261005141417.65822-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EolJ4Sn_reGXhrp9W3iaGTyav9YfDLLc
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4a8af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=OJiJi9LatHNxtUzuihsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EolJ4Sn_reGXhrp9W3iaGTyav9YfDLLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfX9DUSrVvactaW
 +N0DwVDomc8YhRJrKBurXn0YeSQfYtZzECGX7uz3cb4Dapiddyc87oA5po2tyWldNpgH1Luz7ep
 Kj8VEx1PXAS5Ig36LO9uyGx7RmNPzFKLRT+y/26GUmYtfhpUvC2zUdI+3cOW6wwjO5da7Ohyo9j
 s/lshwn/Ei/gIjdIUQs+pIsX7/8xBgFUq7suMAJXVf4iOMQqSA+ehR9m+kH1jZqZt8IRXuu1o/y
 Nm6IDLO8BeYUFmua/RkqMOX+n9Nl4mM+5BDu8L2Jm5cpTnFrNNtBibdKRqxKKyNR15fbltpmutg
 CyQ7VicTuw3Zo0GMTpKdkY95MNmiIgNDsbMzlLOV5E01IJl64i536LXp1QTHSAhryE4uQ4EC1/u
 JgvCJsZJJmR7KIIu5XnzZ7N/w12Uu3jRfLMms90PVEwX/H0tzGLLaxnxzOqD04jRuL0rqI3e0iv
 ILiVMWpsPl//k+oSAzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMCBTYWx0ZWRfXytUKg8g2JUyv
 /Tw1HBZNhCk2FomVa0dONvvFH1PMDBBo34EoUfMm5ItpCYkBW0mby52l9k7vX0HQhnZdsTrVpK8
 qIu5xAx43Pjpsyr8yZejy/W02exim+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060030

On 10/5/26 16:14, Harald Freudenberger wrote:
> Now that cpacf_kma() returns the condition code, check it and bail out
> with -EIO on any non-zero result. In practice CC 1 and CC 2 cannot
> occur: the GCM function codes are clear-key only, and the scatterwalk
> loop ensures block-aligned chunks with LAAD/LPC set on the final call.
> However, it is a defensive improvement, not a bug fix.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

