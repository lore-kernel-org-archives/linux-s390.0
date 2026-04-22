Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C73D170F;
	Wed, 22 Apr 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859740; cv=none; b=OpdBRLyEdfPJsyfo6fGE9KHC6XnIczhoHgHHD95suidml+PT0nB/1MGqdXnOwHLP16NakjNLGgUm7LikwgK3fhA9e3zXQyl6oNLivHvvDuF/XNSWlAEuRLF6nIZojcnBCJTCpbOA5XWmQ9GT0swPYDkr5gcYwe2nORsmqsyClgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859740; c=relaxed/simple;
	bh=JGOMgrkuRwwo8NIQ8At2Ro5c6+HtZZ+z132WBXlVTnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9/I6e1o4Oh9D/p4dE4vA3UCwSuvvCGWLKzxVB0OyFryEilWsDJPcbApdiQnlBi75CbTbwhRGJ6f4Tns7BOcdDeAS1i79/W1SdOpLxLZbWCoYN4INW4P0xsjMu2CHtNV16WFOkdzMhn/k7ojqidmr9n1dJnenfcbW26uCrAuaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ETsDu0I2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETsDu0I2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M3EYaG1678313;
	Wed, 22 Apr 2026 12:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=to2/bm
	YwzTvuIACTM73HU3ZIy4Uwf636CjH5A46xNgs=; b=ETsDu0I2yx47eDBDo2rAIV
	w/C3TLgtUhNCRyQCU2B/mfh11RDK6pjYEmRaUzoF/iWtIzf0oQlpLuPIyHw+xSM0
	NUGihYVMfMoXmi0F4uEWYclMRFTukoMOgTR94fzPEc8LejR2XFn+qhd201Rb3n0f
	EwUsYFo/eZTOSQsBVoKnUADJWDoCqg07rrjNY92yI0BnXkxuCoHmdBn2WiTLnO9v
	g1EKOWMF+s42Y22CuvsagImy2PE0sMzcWRYwyCbRgHkNWdwDUxPBqS0mDck2CU9L
	gqdANOVFjqMM2mFO20AQBh5eSWA/l8EDDTI+9B9htz4bYz36mSd/5tlsFKG52nRQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7k3g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:08:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MC5PY1025470;
	Wed, 22 Apr 2026 12:08:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxt4us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:08:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MC8eSe30933540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 12:08:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB8962004E;
	Wed, 22 Apr 2026 12:08:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39912004D;
	Wed, 22 Apr 2026 12:08:39 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 12:08:39 +0000 (GMT)
Message-ID: <b095898f-96b9-4211-aa99-58cfd5d4e538@linux.ibm.com>
Date: Wed, 22 Apr 2026 14:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260422085159.459678-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260422085159.459678-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zoyAkjUNjWupx29W9BUChyFMW9DNL4u5
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69e8ba4c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=NeOwnSWX0FaQQG-veq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NdITvjziovH74ib9c34e16oAwkVOndWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExMyBTYWx0ZWRfXzYYnbu/2OFXc
 mUMX2FOda1eZt6/TrcBuhF5ugeBDOlfaIBH13pSoD/CKhAoPDVo3jf8XzOV2BMa5sMQzPsx/qqs
 m0XN5mlThkzyLHNZyFleWd6xjOtmQ5DcBGWun9bk5CFD+OZVO7KkSfh+IB4PRJuq2n5Zel8t2Xe
 45jTjDFBwc78s/WYVdCc5GLMrpL+MHnvr4ylAQID8KSe2Q6k3k6Hv+GltWdInMS1ZuQ7lWeuOQh
 LJTegz//rEqxQl5acRlnz2Zb2gT0YgEyXYOezn5cMFaLw+eCVAkFGn8XosS4Koo1HDadl9E70NC
 2bEAK7GIwZmX94vZ8akULgnCGgnK77LTpmEV5EkWDOc6cPZv3NhZwC7CcRJN0Tz4SkiZMBvxLsx
 PZ0yL8rVfygh1HsyUKvV8YoPD4xUGFhxk7ODRafElGNRz9VfeaBcGyOkzGB8iHjZVQ4lWjNytg5
 si0Q77UgPI3rB3w5bEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220113

net-next is closed!

On 22.04.26 10:51, Mahanta Jambigi wrote:
> The smc-sysctl.rst documentation incorrectly stated that the previous
> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
> was 16. The correct historical value used before the introduction of the sysctl
> control was 48. Update the documentation to reflect the accurate default value.

s/default/historical/
or remove the last sentence

> 
> Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> ---
>  Documentation/networking/smc-sysctl.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index 904a910f198e..279d15e61899 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -100,14 +100,14 @@ smcr_max_recv_wr - INTEGER
>  	depending on the workload it can be a bottleneck in a sense that threads
>  	have to wait for work request buffers to become available. Before the
>  	introduction of this control the maximal number of work request buffers
> -	available on the receive path used to be hard coded to 16. With this control
> +	available on the receive path used to be hard coded to 48. With this control
>  	it becomes configurable. The acceptable range is between 2 and 2048.
>  
>  	Please be aware that all the buffers need to be allocated as a physically
>  	continuous array in which each element is a single buffer and has the size
>  	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
>  	with half of the buffer count until it is ether successful or (unlikely)
		typo in old documentation: s/ether/either/g

> -	we dip below the old hard coded value which is 16 where we give up much
> +	we dip below the old hard coded value which is 48 where we give up much
>  	like before having this control.
>  
>  	Default: 48

