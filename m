Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670837C0F5;
	Fri, 25 Sep 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349430; cv=none; b=tdnBhwoGTK6NfcKlMkNs+mNrIOlCuFNUSvHJefVbGFrlZkOvRJvE7ZkhRPATWUVENDojGm0n1BdZHeGpT7m4GilQahMDLXxVW1tnq3Wc43NTZs+e0NiuILbqU8fNyMiAilo5oJWy9YirhyFENBcelP+8b5sLTO64JYgEPZBUrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349430; c=relaxed/simple;
	bh=Dth1pW+X/qoBasl4Sm/FBeTxR8R9lpHCCljFzhOUKho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I16ENQ+04xE00RIrvdRnFsCb1ufhDzt+LZDxng0/iWt/Cwai+HWNQmskz8f0KlySY47PUSIXvUIxDOVDuVWQnlJ7gKtO+MWlTCEDPg34bJM6cuWHHdnayuuyypomLxvdo509Ur8zU3LP+db4KiCcknFYyNT5cbM/9tqSfoYTgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PQlizrml; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PQlizrml"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4b16l2394514;
	Fri, 25 Sep 2026 15:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rV1r1S
	aMs8R2GMCMT2tW/2PbUnXsz2c243bENxyFY1c=; b=PQlizrmlh+uMWrGjQa6iQ2
	1PGICFID545vSH4YUZZNMV7NlRwSzCXsH24BlBaLWZ2ksP1tJmR6zQ29T2S9Gp9q
	Cu2a7ybZq6UffrWCE4NAHCv09tX1ZfLZ+f8Sl+PDnEz8S0hejjrvzPhs6YPRsOgy
	DRXOOcT3EJXz1qjvDlnPF6Zw/TTRd+wsjb7l/36lMcyg2NxJnpvrYff1gNG6jxwq
	8leNxNH9y9an/+nFpu5g3MEKL4CxHUB/pyV/RWfbg57lrUum07MmaWS5anOzKagQ
	1TsNg8j7NB78juepEGWbjPJIvQ0n8biqr9APAkJAP687hDamTPI6PBi6TSGN9cIw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske27rxb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:16:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PF1aO33297092;
	Fri, 25 Sep 2026 15:16:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qtx34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:16:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PFGpBc51184064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 15:16:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03AB72004E;
	Fri, 25 Sep 2026 15:16:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 922612004B;
	Fri, 25 Sep 2026 15:16:50 +0000 (GMT)
Received: from [9.111.133.14] (unknown [9.111.133.14])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 15:16:50 +0000 (GMT)
Message-ID: <717d9c0e-83e9-4ad7-82b6-7970a0ba6729@linux.ibm.com>
Date: Fri, 25 Sep 2026 17:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/iucv: require IUCV for AF_IUCV sockets
From: Alexandra Winter <wintera@linux.ibm.com>
To: netdev-bot+sashiko@kernel.org, hppiscas@163.com
Cc: twinkler@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com
References: <20260920034503.17322-1-hppiscas@163.com>
 <178996250579.2160803.3689804935882322466@kernel.org>
 <d0c5ed89-f782-4acf-8c4c-4626f4be650a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d0c5ed89-f782-4acf-8c4c-4626f4be650a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8l3E_mPJ93pvdEZdXYDMkRy1dVCP-3cz
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab69067 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=iMySd7Nm5nv2uyiilLIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX51Gjsu18j+VV
 EH6ZslkAU8an3qoK2glBS6kfJS7j5o1aynZ4DR3dCW6Xi0+4PzLkXuTBUiCUZmNYWUIXitlLUaR
 rJJnezqZjvG1hfIKVvWoJz3cULiM4pE=
X-Proofpoint-GUID: G-mNGDf8f4Q6p2hndv9kE6m8I3ukcCxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX3z769/oFiUAZ
 ahpBEjpvg6cGSmnvqzgcJjxfp78o539onsXMIwBLQ8qLh6F/dlskbyGI5Nh8XCeEGIJ3kmBGs7k
 gx+Juy4yd9EJmYRYJnamGoVFBYW/feHUBdnSXaD78MgFmKPE0VP4d6i+QgBNL9yLmfZGhuoEBgB
 H4Yp6a6LNxMAMO5tFCgJTGIGn+I5Tt+HeT1ix0aKToL8pzb0gcpHnVvLyhsZrEoIJEVIeJ1mg/d
 KRkFZI70izqMhsuj/DefgEJfjltg+NTtQHNfda1G9X7uerljgAKalaRd44kHBf6m+xvBmpVLG/N
 np7TGD62x4wjG7RkEz7qo28d2WbD/7F5Fa6NpUhe68m4ymXaDGn2hqgltVN9AHBwCw7HlytU4SI
 DUISRyF9CDwEMYU3i1t0Gl6XA3fUasyXOzayftfqSmwzpj25VWolhSlrvY3s5tDZV0lHIWCdJ0L
 UA9DOOS4Vw9M+ZEKe6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060



On 24.09.26 20:52, Alexandra Winter wrote:
> Actually even with your v2 IUCV=M, AF_IUCV=M builds fine in an LPAR,
> but modprobe returns with
> modprobe: ERROR: could not insert 'af_iucv': Protocol not supported	(not expected)
> modprobe: ERROR: could not insert 'iucv': Protocol not supported   	(expected)
> 
> Is this a result of
>> 	if (machine_is_vm() && ...
>> 		err = -EPROTONOSUPPORT;
> I don't fully understand it yet.
> 
> But that combination can be defined, even with your v3, so we have another open issue here.
> 
> I definitively need to test all possible combinations! (Should have done that earlier, I admit)

That is the same root cause as IUCV=M, AF_IUCV=Y linker error with v2:
the reference to `iucv_if'.
So this probably would work with v3.

Nevertheless, I'm working on a clean solution on top of your v2. Let me see if I can come up with that.

Kind regards
Alexandra
