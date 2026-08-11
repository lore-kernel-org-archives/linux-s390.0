Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740A3845B3;
	Tue, 11 Aug 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473864; cv=none; b=ONaVl4wKsogY4evRC3cHxApy09/gT5NfFj4J87uuLjCyhNZQYHbnla1laSGhmDkCbYBzEltafamUlSTmE+K62OetrtG10bgOXTxXjsSqdMOFRxzxFqNgwo90sQqx8qXgUP986bfXiR/tx1Djz64mtXuihbJDdb4cmpEvGfMiVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473864; c=relaxed/simple;
	bh=EJ8Hyo4C4cBOa6cAjFMn1wGh8qW9KyOgWKAcY0fIr88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Md/jpndDvRc2YpIWxnAdhBfl7/nU9dMp8XQHZ7oc7i68RzwPQM2LWvET1pToFN2zG/cTyqTV3Snb4j1h1ZVKUQnflt+5kOaV3BPkykQOeszSO0mBacT4m8kCXtO8Av3igNtevocdEWd0DBFJh7HH11Dn6oa2xlO4KWHSxqh/ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LELHT2xU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LELHT2xU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVSNs3260537;
	Tue, 11 Aug 2026 18:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g6YHx0
	1qFAsKoQdD4nIDSsavVDSaCqkQZnPKZFejL3Y=; b=LELHT2xUvbIfGy1iMLOrao
	WgCK+Vv0/0nfpwKqZPD6Bvlw9gD12Odb0m2EFGG0k3rPJss04isaCNimagJYh9Gy
	CUDxQmeKRKLMzpPrk6BLD3UU351RChfmVhcjUPpXCqMuxwWtSeVQBX5VCjtuIOQx
	IujDXotdwneIGB3dzHJR9U9m+5N7J1qdeuW0TAoG9zugvoNMnl+GsqkZxWcnZUCd
	tNFUQgeTZ0csPMd8R4a8xljTH0jqyn2czCRRXW0iQ4KNrFPGbsWshQVbRUaBodxb
	yOAM1q7JKLkjq8/IsYqoDD8YAHCqSJZEL980a05hXG2Dji/WHZpdDQ+z2OjvB5EA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxgv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:44:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfKNd030532;
	Tue, 11 Aug 2026 18:44:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy22w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:44:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIiEih18088448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:44:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 019A55803F;
	Tue, 11 Aug 2026 18:44:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA9B58060;
	Tue, 11 Aug 2026 18:44:12 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:44:12 +0000 (GMT)
Message-ID: <85212e98-c8db-4428-b5f2-70a0d9fb1207@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:44:12 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] s390/vfio-ap: Fix use of wrong lock in mdev probe
 function
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-4-akrowiak@linux.ibm.com>
 <4ca672ce-da47-497c-aed1-9500b7e89798@linux.ibm.com>
 <00b0ea7d-bdeb-42d3-aad1-a8a827f2deb1@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <00b0ea7d-bdeb-42d3-aad1-a8a827f2deb1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX3RHzibZXo0Kw
 v+GN+56NXLsUln+MPhkB0RTHDBGVSr5Ot8CV5lPOtteaTr9J0JwMCHfGXOcS2y3Q/5pHn5MIQEz
 olv0YC4s6pix+E+ikkT/WhTIqlkRwkGj+3h3c3Zg2TBYQH/Xz7fxycM5UC2+LjRQnJ27KAgz/7X
 DOZD11G2qzMzm8/AWFMzH7BxVBejNOsOPAc4AgW6QvQavaJVrbLiyakFKrTvF0fGApu7eaXRqIM
 SX8RSBqBlHR+/GWe+Kb6jGaEZLJk0YQlZuwQQg2Ce46l0m63D+m8CpdiPI+4mR8Q1ILA6UHvroL
 tXtt/IhvbLnBagf12Nwcun2g0LIzukFt77L2b/OHNpbZxJj0uE1mpV5o7uvgMaReT8qLmQISeAp
 b/fp8Xp+uzQQbfqywWBwZxAS1EW2aAF2NKpumG0IwHpDXC5zrLqeGONFOuaib21pIao/9j765PB
 rD9ES8xBm116gFCSQMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXy2FSyEiUK6zE
 8wZhVx5j/kqhF4FaYyDOYApaqNtnLTuG2axc7GYadQ3iFNlohW+JtWASx5mhhWcPjPGizQUiWVR
 JrfxvOAet+RoBMsg8fCB05kEE4vL0nU=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b6d80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=snnLmLkpdo0Jf2NeOwMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AMQogyZLXPREcN057ukiT2EvvtCeTyjW
X-Proofpoint-ORIG-GUID: AMQogyZLXPREcN057ukiT2EvvtCeTyjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155


>> Sashiko reports that this patch introduces a regression, which seems
>> valid.
>>
>> AFAICT you resolve this regression with patch 7 of this series.
>>
>> For the sake of bisect, can you look at whether squashing these 2
>> patches together would work so that we don't have an interim regression?
> 
> The reason for the two different patches is because the shah on the
> Fixes: tag
> differ.
> 

That's not a good enough reason to break bisect and introduce a regression.


