Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888020;
	b=E/QLQ1twABiOC+4QbCe3oGF2l9ymc+q3kZDdtjQm8TqW2MuRsId5lztKRFEX03a+unEP
	 K1gxnycVpZe4zNsdVye0ZtZxRY4GOf/oLX9/JWlMRYhvLUEHUsqPt3p20Nx7B8ym1W91S
	 qTNJlPHOus/GYDUFHU1CCJpo8JbjM+k55lRS34C9A4SzEtapFj7AojiOzK18PsB1n2lzo
	 /blMBR8JV2HyQCYMVKuNUJ4QvGi088mqVC+OzYOhJrE8+358CWmg7HnzGF1v22chWIYuf
	 niGEwwJrk8jmkUCBbHW1TdPwgDff/ILl+LNYkABIVCTMhCl8mD8wPm4WPZkbr00Vi7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888020;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Gr+NUEMjau+xl2lP4NDpYm7f/Dhs1l8XcQKj5Nk+OLA=;
	b=fjABvCFplHsXXoEUNa1+Hu5Gxmge0HxGdPjJFRqUEQLUVifp9TILWjpfnRnvKc6qADre
	 wCIWpcAaReRnO896zNFdjZWMBBaTOMzIVPDU7sYz7GFt8B3oK6GtvqclBWUliFMa5as+Z
	 n4kuEQxmIyVGlAPQM/WrZC12nr6m3Os3fI1qqEnBH67rLxRcx0wf8MUqE3Qmqol9MZrau
	 eLA2gWWjHoXkvBH+Qyd0T4g2hr+Fbj2Jl6Fkl615c0lgKod6TkbMzVmIWwwExn/Pfes9Q
	 xPyWB/4UgrzFxQ0+Hrza/jrl7O7SXk0g2/GQNIo1Q2B9JBpuvr3TjwV/K8/ie4RgBLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NdI7v+wR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B043606A31B;
	Thu,  5 Nov 2026 14:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B043606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NdI7v+wR
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AESJd2060070;
	Thu, 5 Nov 2026 14:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gr+NUE
	Mjau+xl2lP4NDpYm7f/Dhs1l8XcQKj5Nk+OLA=; b=NdI7v+wRtIodvKWFkACcuw
	KqCZ4vapNr37oyPTZ1gSHsz7YQKQbadWIwKyGT+pUqFy7XZqbm/B2yYwwXYEDXaq
	MskmGrVat8CndN3gclZyXS0KnvO+H//zaYvXlY57iMEFBd4y/tHMsx/b5s0FuLxu
	fJzfsmhIVB7ML25bjnoyfpICYwUvs9Pji+gUvHxK7y7WlBkm6U5VzEl2PBAbubBh
	+lKcBMj9b68SZuBUQOpq9YvUhNgSs5gSJKiRaO3sjs5CV+orIaHwU/JbRHBIk9jo
	q9K15Y00eDxAlDlmZgMQsiFqwnFs0gSFJbIdHw7upZSVOyorcn6wf8rTmKjbEy9Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdj8q7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:13:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5DeBpA1509508;
	Thu, 5 Nov 2026 14:13:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7krjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:13:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EDWwk46203372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:13:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B494B2004B;
	Thu,  5 Nov 2026 14:13:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A2AF20043;
	Thu,  5 Nov 2026 14:13:32 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:13:32 +0000 (GMT)
Message-ID: <60da9bc6-eaae-4aff-85d3-63da3b83a6ac@linux.ibm.com>
Date: Thu, 5 Nov 2026 15:13:32 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: drivers/s390x: select uvdevice tests using the
 target architecture
To: Sasha Levin <sashal@kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>,
        Steffen Eiden
 <seiden@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014200149.1365017-1-sashal@kernel.org>
 <20261103130131.4069212-3-sashal@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261103130131.4069212-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qEyc5Vq2YMukiGxTB4LaH3WuC3jNWR4i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX9HsualfMzmPh
 q3J/NklJh8YCChVU0SbLfBaNaZwOw8W+ITPykCkPwzWTbWabmnP2BxrqtQ2NXvNrv4D4yeY23rA
 xE5Li3CHHON09SVDRnvTqCTC0YOVVoASN6fs+YGQ3u58BcNnPU6/6p93cGxq6U8+aQGkQPLGCtk
 Iw7CkQrSziQ6MKlR0/m8AQAPG0nDAWppL+iiZD0txtIMpmkYq8SWhLtWDnVTqZaDGGDzgcMIL9v
 EkDukkAAVh29qJMZHDt+RXzk6inA4JkjWYohKPXCwH0fj5/e+YI3VL8ILBeAeV33uDqQenVkLgw
 boXfLXH8kTwquveviAIWKVuvjvUo3Jd6LFGPQ2txpm8dj2AKYbUxK7oMO680FhqL/VMF7g+O/vf
 IHKjCrvNuFVIncknGjnDiThPDGfYRAeeIhFvWuiFCTEinm/6R7BvdVB4u9rMtQQeBOToXJ1Fchn
 5phaixi5vIpvQTJCE+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXxOhrwzD/V6hj
 5nL2C64p3oiJ9jApbF3fyJO9q2cb73nZCRwjBlFuZBeUVylwm9HWVk7e6GlUCzP7po60rBgyjX7
 Qr1lyudDZwrPWkPhgac31vRm6dY+EfE=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec8f11 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=RhU_m4-V-8PcAr7x2KIA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: qEyc5Vq2YMukiGxTB4LaH3WuC3jNWR4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

Am 03.11.26 um 14:01 schrieb Sasha Levin:
> Ping. Steffen reviewed this and it still applies on 7.4-rc1.
> 
> The uvdevice tests still never get built when s390 is cross compiled
> (KernelCI builds on x86, so uname -m never says s390x). Could one of you
> pick it up, or should it go through Shuah's tree?

Applied and queued for kvms390/master https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/commit/?id=fdbf9b6e8faf00b7bbfc6c87de09676c971d2fe7
Thank you and sorry for the delay. 

