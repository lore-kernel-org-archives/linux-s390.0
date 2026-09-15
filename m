Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E343E0082;
	Tue, 15 Sep 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485079; cv=none; b=G5TpiCwt+WfluQDW8oydqJmGD6/7mKkIbB0482y/9FBJQ2UlBI/V2VHi+FTpLTG0tpg2AjO3EcwNtm5rVC4ySeob0iQr3OuYFk6p+vz3H1zblLiz+0ER2AIOiWRENb47YDItQkExOFLcC7+dA7Chj9vPW+uIyDIMIHoxHnl/7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485079; c=relaxed/simple;
	bh=wuExuP+XtJC7ECP/5qqiN5ofAWpqqENLyL0kKwvBy4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObcbJD30qU1mutMi6h5GSkMaQ2Yy/XiezPKopTu11jA692J/7nY+RygAX4BRjinLubRK0YQGTx9hDILlh/h5s1rAvaz0sP7BP232Vo7X1K5LyDNLkTMCLD7ak3SzGHSO2ISmMEJK6D6o9Z+QfNwYcY3/VFQxUx+CVNenKs1gqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S96J40Eo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S96J40Eo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD2CIX3199228;
	Tue, 15 Sep 2026 15:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FGahlG
	fhlVsUeAfWGDNtejtr4zTNuHgI+RlQUp4mnsQ=; b=S96J40EokEGdOReZAIUXaT
	PEwds7rCnYauj4dXmXfATxg7xwqHb/Oz6lhzlprnSz9OsoyODgqSDgOLJA90Bdc9
	slb3kgiaT/t3pYt0CarbDTZ7wU5W+M4hKK1YscaF51+84kkmUojLaHxVrhii7vLH
	GU/Xg5SvMuEwm8ZMGNhDUFNMWP1QK18wZ9hRlPa+pMH9oRuExpOr1QAO0qXWTIJI
	NH6k4/s1n2vZkQKKyPAkF9P0ea699lQta34zxgj3mY0UsnKSCEhfp99qbzZOMw1B
	AjnTEbRoKMw9Q9tiiBgGpAfdCGi7QPsl/Uf/Gj6MaPy1HpMge1rf1h97mD30FA/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq7rfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:11:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFB6W54190094;
	Tue, 15 Sep 2026 15:11:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03v9wan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:11:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FFB2iD19137196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 15:11:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E53420043;
	Tue, 15 Sep 2026 15:11:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A6520040;
	Tue, 15 Sep 2026 15:11:01 +0000 (GMT)
Received: from [9.224.93.92] (unknown [9.224.93.92])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 15:11:01 +0000 (GMT)
Message-ID: <339a97ed-c585-4888-a5e2-0ddfc3b3b4be@linux.ibm.com>
Date: Tue, 15 Sep 2026 17:11:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Bryam Vargas <hexlabsecurity@proton.me>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
 <20260914185309.326ab184@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260914185309.326ab184@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfXylCwc1laxHma
 mYXszWsGpwSS+CFU1ncAqxjMl/uVZrNRwZWOhQetHY0VBnAt/173HDr3R6A8hd2e79dY5t4vZgI
 vR/XmybT5jX3s6DUwx4p6r822IUDCNq6bqMpLAJhSoPlZG+6IwaN3yXv8lNPmUJ55DKEzqLvqGg
 xAakF7NAI5LzG8W6nApOCJD3SsgcHffvHA6S6ZU/2cmSjZW6+aAp+yG1IlkGHw3R1AezQSo/Y+d
 pJy9thns4j7rXCAyUf9LkYBItndSwtjElK7Rm/86s5aV1sNgBstM77TZ71QoE7JIqok3Wtslq4Z
 iKzCiX4Qlyw8aBPnrOAfWRvy8mQrcbd0poIO2Mr01rQpR5hqi2uKKxVgJrjckZ1LXz31RxvTJdO
 ZsMAbZmPzDmckjjUbdTt6ngGFj21Q7V4GobT2gwKe6bwShYgWWHWdjHIO7H+nFrFIPrp0SodYtH
 kLn2RBwr/GLyNnZNfhQ==
X-Proofpoint-GUID: UdDTz07cH1g-L8Hffz93KKCi4VWg_IN0
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa9600b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pbh_qswI3DY_xH3wKzYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8FaTB7xeVadYdrQRfFFkGyDHVs6bXK0T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfX12huqYS1pY/K
 j1jXMkWjv0JX0yXF7nRlh9wtmpzPUol8ypgiXhcyrJWQzc0C/lTFEvyssgZHRz9/vWhgV0SWvcJ
 m3XjtTRnYoZ+Xgo6k99Nx/1Ineh24W4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150219



On 15.09.26 03:53, Jakub Kicinski wrote:
> On Thu, 10 Sep 2026 18:29:19 +0200 Alexandra Winter wrote:
>>  static void iucv_sock_close(struct sock *sk);
> 
> deleted this line when applying per clashiko

Ack, thank you Jakub.
