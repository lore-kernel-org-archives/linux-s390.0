Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE448CD7A;
	Mon, 12 Oct 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815039; cv=none; b=BlaDfweSHFJNmtazfdLEC2+cEdwUSHOy2bekywln1eekpj3LgvzOUAtuEt7Z2xkmJvM2Sqmx0b+AoE/EtWW+QnWUa13qJdnHw8nJAMmqNjpDR53h3YcquOTtRN+owsQmVBuzeQeM22YmLmxb2F9pBJEyhXqdMSReO8WEKGhdKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815039; c=relaxed/simple;
	bh=3irYXT7CxdNpHIr8vt7eAZ/fM2WPjaiqp/gVP5li10w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfTf9xHCt1gxIXMwZaR3NfhP9w/QOyb1PTBjXi6Bgyzxp0XdG1B5PckgxpbR9P4oeHcO/OAN2OhLF2W5DI4d4XA+D5/2+HtD0LJpXg44x6GV4k3thPfYJ51T5+0dkkKJZz0Ex4KNtp8c3QrWrDjyWRFZLExLzyKur+sWGaBABQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e2z8G3Zb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2z8G3Zb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEAeQ182455;
	Mon, 12 Oct 2026 14:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D05pzo
	u+VXb1HmvzjGb8w1SdN8za1VuEX0BcBjBVq1g=; b=e2z8G3ZbAdC174WpG2JOxw
	pU09gd/W3qviZdsIBHqYri5ipGgWbpA7pqWYJA+Iac4BbTJzR7FFiMNg9/ftb/tR
	0cYw/xoDA7IhK/tfoCoXTHZSKYaaosiYx0UDe+fn+u5IXgGED2gJ9vAA5nx/IjOD
	nDvUy67wuzUpsL28jXJrK12TbN5OCZIZ4EB8347dbB0fPIivkQpITnL/53Gd4NgO
	b2ddra1atqYYX6h+UF5EHq7DFXgGPavvI6AiSOwbPJIYDVKlGS/EBnPcPM1Nb44M
	BbjGCl4yHw45s3apXccViPN5IwiiUs1mafGWiTGIxflYHOUmtqaSLgpoz9TgRgqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39b34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:23:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4sV01286752;
	Mon, 12 Oct 2026 14:23:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwfb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:23:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CENq3N43647360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:23:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F4FE2004B;
	Mon, 12 Oct 2026 14:23:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B79E20043;
	Mon, 12 Oct 2026 14:23:52 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:23:51 +0000 (GMT)
Message-ID: <c7e97fe6-57d8-4587-b29a-665299302b53@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/32] s390/ipl: Convert inline assembly to EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-19-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-19-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EEmA-4eJUAu3TNTUEMLeYw187s--u6lf
X-Proofpoint-ORIG-GUID: EEmA-4eJUAu3TNTUEMLeYw187s--u6lf
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acced7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Xd7Fr9RBzWlSPAaGVCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXzC5byW/5d4ox
 rALYlIqowGQn8qLAy/SfvKqqcJRqBLayakQlltxV00hHRrzDoDuYbGtuNST0rpAtAL/TIZ3TQ1H
 3xfCyCoX9iNUjB31GRf1EOQDuCcBaCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX6fd+T8QIr8PD
 LPz9sFEzd7IKZKc+m0UB89YqJya11q8UZq6ClZh1OI8YQ5r6jsn0e96faOF+iKrnt8rOOwL7Yfk
 lT6F88pqtP3wgsg1wGi7dcH3eG+oz5Ufm/wPcJN5oeMpSXwwMfLHlKsW1f+4Ruvl5vBcLPzGkoF
 BTVV+jpZGFsU8fFsAL4Wal3gmNyTZDg1crWlxAgfPiRIyG2wGLtBg75lIeA6Vf41G9uuFqIqmIg
 gQgZlM3DveIBDVbR/Bc6O3qnDe6e5a5NLioOy5Cr+D5DAc5dO6iiP+JZeE8cod35jhotL3JoJi/
 JPtkiWv+PnzOLIW7J9SxwUZqfcfij5Dp8IgMjTph/GM7N6Es+bpSkDnMEwZ7mbh1ys/srbMk4hu
 1tXCzxMsG+95H1q4+i5ZIv6vDf2DqSYEBpFle/tUTKe72TynxBYx3STqFInqHMMhb3Wnhc/m9sV
 9VELAAJ16URM8pgUrcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert the diag308 exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/ipl.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

