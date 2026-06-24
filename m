Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A483812E4;
	Wed, 24 Jun 2026 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281697; cv=none; b=E9znhJpQNUVfDDnJilgRBsMZoftWKUJyONXWiVRKPACzmuZbnNULqbuP5pmNRnNphSQ/SfFGQEyL9o+vU8f7jnNggbFC5t2oXLVpFD5FEWJNG4IcBonltFefutHEAzuCsGv3L+jed0gg0f4JS7+HZ/DE6bnUFZlCZmtXa8oYv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281697; c=relaxed/simple;
	bh=gt9JQW4adQN1JapWb+d2+uSABeDsB+A2SXWV7dr6128=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGjP2QPOlmsx9fSha46PvfJepOK9wZ6Yr5NduVqe6BlSGt0LnoAdKgbeumq6DLySlWDCBsv5YJzz/68P8QwVVEPHOMdrYMn6VEL0J54QVGAAAyHo8FaZp5HX9JorFH5ldG8/wNFt1QrE7wS1qAfl1VAD4qgsmADAiCAr2SrKBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pgTLVcnz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pgTLVcnz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O1mZFl3671388;
	Wed, 24 Jun 2026 06:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MsRELk
	/CS1xzk+PAko3I6kg+AhHBmZcfDeT4wLZTtCM=; b=pgTLVcnz7KB6/FzC4uXzeZ
	7XlQ8lunTFTvVE0cpoKtztMHfAn1+NTXv+y7RjMLphA2fUvlid89jLQPdmZwFcnd
	J6c/Tgb603r81bbTuSxTfpYmSGS/AeGixJY12oEBD8LRGYSHhGIbiMpbC3M6fExY
	VyZA2skME1aVyT+utRFJggf3D0SBWiV9PCQ+NoK5IUXqdu5gtWkXSUy0xVVti7p4
	HBl7UjKTvBWNGGg1cpxw64OcH5EZoVoOldbf5Ug26TqFNcIARX16s5wSHYFnYiEi
	etqgwyLvZ5xBsqOLLNU/F85qnS2HDOpFkcFVVRx0+Fj7xv9VlkxBROkujmqsYquQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9htrrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 06:14:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O653VL021547;
	Wed, 24 Jun 2026 06:14:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phf4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 06:14:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O6EkEx18088626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 06:14:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF44958058;
	Wed, 24 Jun 2026 06:14:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C243F58063;
	Wed, 24 Jun 2026 06:14:40 +0000 (GMT)
Received: from [9.123.3.51] (unknown [9.123.3.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 06:14:40 +0000 (GMT)
Message-ID: <3a77aeb8-f2f1-4cc9-b5c1-2cc71e569602@linux.ibm.com>
Date: Wed, 24 Jun 2026 11:44:39 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        wintera@linux.ibm.com, pasic@linux.ibm.com, horms@kernel.org,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
 <ajqh_3YDwz9q5Aiz@gmail.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <ajqh_3YDwz9q5Aiz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FewBYyPVJEnfWm8Royst2Iny7p7iGRHm
X-Proofpoint-GUID: qkOC-oHEJTwkI4vdonJOqdjr5jreoF4u
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3b75d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=_QdjCJnycWTIf79EoOgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA0NSBTYWx0ZWRfX+TQoaTxENRr3
 INNoLWUGNKNoa66ofextEcRna74/mzf3set7ffXC89vHg2Q5H+xBocioXJm+didwFjybIZoyO1i
 D68A7/+HgOcyUPq92FJ5srd3SbilH7FSXlQBEXdJO2PplPMkdgvJOyWcHJ0eUcgqjj50UDv56Yi
 roDUr4uVOk1szNyhaFXbVU25k9ES3GVr68V2o7t2G1x2P0ybyz5GnQm4bPWVUUtp186CxXaDEG0
 u+NJ8wbmgQzsFXDG8SC8ymxqltpE6dR8CXVlyxTm+dejha9gF5FB3c3r3yBtRTssaR/fcRnRUe1
 bp768RLsW/z3wCp435dSa+w+2ffVxab/SdwEcZYZjMm4GaFHIROY2TiiDrDAu7hNEFwPB3Omu1+
 NbUAXsQ4FMXPN+L9Z3TZm8klnmZObw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA0NSBTYWx0ZWRfX2S41vXoatTBr
 0yWHDsG3/Umtwj5mcNizLynMH7FizyajIJY77Tn/3lmYwqnZIqEXtJalZOyRKtwgbcLNqeZ+5ho
 yBEKAk6hl57Lj7ebOltPDkapj58jH2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240045



On 23/06/26 8:42 pm, Breno Leitao wrote:
> On Fri, Apr 24, 2026 at 07:23:36AM +0200, Mahanta Jambigi wrote:
>> The smc-sysctl.rst documentation incorrectly stated that the previous
>> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
>> was 16. The correct historical value used before the introduction of the sysctl
>> control was 48. Update the documentation to reflect the accurate historical
>> value. Also fix a couple of minor typos.
>>
>> Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable
> 
> This Fixes tag is broken. You probably want:
> 
> 	Fixes: aef3cdb47bbb ("net/smc: make wr buffer count configurable")

I believe you are talking about the missing parenthesis & double quotes
around the commit subject line? I verified the 12-character commit hash
points to the correct commit.

> 
> Other than that, it looks good, the corrected value checks out.

