Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DE35AC0E;
	Fri,  9 Oct 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561551; cv=none; b=ZXSUxqYGb7+EF/5s5whOKdsmonuc/NHftQwadEo+5HFSkVv/pM8rpEkfNpAX5Ld9tPpjoOaIIJ44njBF2s/MyVR98+GtxGSIeOJsfSXEH5PJbdu/eyFC0SUwbBjjSlWZsK/Iv3eKnzmYVw+ITO8kX1fpLtaroXqyvncf2aLBioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561551; c=relaxed/simple;
	bh=xAv3WXdTWpUbIh1hTQCZXRJgClOt1KE9NC7oJ8dIKzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfZeXeXyCCMziR9I9BBo8rLtmiIRllPtbri8OwPc5r1VWgg2GeXEvJ2xik96TtN1wdJ6veBUDpul0Li+miXN7X+ZyP+fE2/Sh9UmVWuJc8Yi2deagAqoaX0pXNKTtKb3lc0ELeFQeN42p6OhhmjgwS/cgyL66VG5yja3T+5lV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iw4UpGNi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iw4UpGNi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DaXLm3215154;
	Fri, 9 Oct 2026 15:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S500zq
	SvZHCzcxNpN162xsalG0hh5JMHIOUVFVDGkIM=; b=iw4UpGNibeM3GKyeg/qZnm
	NAZLPghX6zqBkiQukG6LkK9XEJCXslZp3dXQZpy7eH+kr/FEy8Atzh+Ci8l34Tln
	oaDIm0LemzqPJ9wl/oKg2fFAeJTj7I0UevcKfPEzGBKZtNNxMZaXIPpeDw2pYk0D
	AGcZ5X98vjdbkWG8wtL9lwHCvQNGX4gQVMzCm8w54Tj79IzZ0h2/nrMYh4zWzeVN
	xNHZPtTjhad3V+Jf/irG35KeJzSu9szpEYmcaV01PZ+93neoANWHNlOPauwiQwER
	IjHAKWbxv+CnPl9hjISD4SzUqmsPq9I1Vq74/r/9Vl5FaYbXiK0hMA1c1v7X72Lw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1ju5t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:58:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWWnM3886526;
	Fri, 9 Oct 2026 15:58:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u3jgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:58:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Fwpow47383014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 15:58:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEC02004D;
	Fri,  9 Oct 2026 15:58:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3697320040;
	Fri,  9 Oct 2026 15:58:50 +0000 (GMT)
Received: from [9.111.137.247] (unknown [9.111.137.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 15:58:50 +0000 (GMT)
Message-ID: <99fd2571-7fc5-4e4f-993a-b858f83581fd@linux.ibm.com>
Date: Fri, 9 Oct 2026 17:58:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] s390/ism: Zerorize dmb at allocation
To: patchwork-bot+netdevbpf@kernel.org
Cc: aswin@linux.ibm.com, gbayer@linux.ibm.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        andrew+netdev@lunn.ch, julianr@linux.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
        stable@vger.kernel.org
References: <20260928151420.383105-1-wintera@linux.ibm.com>
 <179081520578.2192623.15327890080313694045.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <179081520578.2192623.15327890080313694045.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac90f40 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=RRy98KAXZkVnLKidrVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MiBTYWx0ZWRfX/mKE/U2/sAsu
 UHDkZ7vk9k9jl/vcBRDNoR5S+uCj0BxfPG5Z/2lW9tK72n/PyrdMx3Zrv2RJ3GrLMHihWHBmqb7
 zbyQUowP5Y6OVzcsADafMqIc2KOY3Z++Acr2/ANGTUcAb/HgnAD+L1xhg8aU0jKutBRHEHLBdmp
 OYjVt4bUfUxNhLLtGzy/3Mxza5y78+jXMDgGDOmRs526HRmDxbqLcM2136oWCa+rzy3mly+bWDT
 DYtoel1+o/AHTlwVpg3KyaxcDmRm0cxdRvfAHAnHiZoVSrgkRrsefMN1kjiDQKVO2eKN2XlzAU1
 +qKmBIGyfPkPElYT5uloKAGu58z2UNZK1II4We2xW/sXiskoYgtEeTMkO9uk6n+aAukoOoCdsdL
 B+7aVvL5bc7llYm28cmm7ZYv9n318h+QJuIjbkelGNaxhlctoxTB5M9TMqPSfZ/qR3nrOAhSZjD
 7fIJuyS2t0KtVSoRpUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MiBTYWx0ZWRfX3kjuE83vHekH
 QgVg7aIbMpRn+GSC+KcqJwWXDLEVjeVQi1oP4V6kVWe+6NRR/RLrr/51DwZkfyM4vK3CtDL6iU+
 BJoBMfWUEhIOsqbhFGxJc8FHJx9wquU=
X-Proofpoint-GUID: 4CEeOTIjURUfFzdDAhIvAibcLMktJaml
X-Proofpoint-ORIG-GUID: 3XkSa6XkJL3OotMZwVzE5uPhIobymqJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090062



On 01.10.26 02:40, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 28 Sep 2026 17:14:20 +0200 you wrote:
>> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
>> uninitialized kernel memory to be exposed in the receive message buffer'.
>> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
>> general the smc kernel module (dibs client) will only push newly received
>> data to userspace. We still should not have uninitialized data in a receive
>> buffer.
>>
>> [...]
> 
> Here is the summary with links:
>   - [net,v2] s390/ism: Zerorize dmb at allocation
>     https://git.kernel.org/netdev/net-next/c/a0227fa24e8a
> 
> You are awesome, thank you!

On 29.09.26 09:59, Alexandra Winter wrote:
>
> As mentioned in the commit message this issue was reported by Sashiko and found
> valid by me. I do not see a simple reproducer.

Hello Jakub and Greg,

I did some more thinking and now I have a reproducer, where a modified remote
smc peer causes a local kernel memory leak.
Reproducer and logs can be sent upon request.

Kindly consider this for net and stable and CVE.

There is nothing wrong with the statements in the commit message,
but I should have thought more about the worst case and written
a reproducer, I guess.
Sorry about that.

Alexandra




