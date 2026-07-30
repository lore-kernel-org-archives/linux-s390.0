Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE143C7B6
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419610; cv=none; b=HsYur4YRg7ium5zt+cfasJ/rlQhOgmOwHUKgcaG25l+L2ZB2UraXyttnIj8spXZAT2VGSuAhaObYy7wtTAOklf4P6U0P/AKYDUh1Bdcv1992IEUe3JvA2UvbUM+EMn+XHDRZC3aL/aQWatRVJzwcJSNuo+K3hUBrBzkDTLSa3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419610; c=relaxed/simple;
	bh=vijgL8ZIlnZPQtyOq9UwkxcyxT6+4OFuCoTIcOtif0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDAxv5tsYugfpmgAyapJBRCTUWPoH2aVtDLczW8O1xUtVITWQ/B6tC8XrAYLebn1U6Ny4fDEHoNoIjJ3D7cCIV7ypDX9fZDs3hd9cP16Do384XgeJ8IBmX3umqszmuwtCr9//64QgBV2szzmipPolHbGflLn7SIW3pOtYetPzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oyl5KKwQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oyl5KKwQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHcDF3091321;
	Thu, 30 Jul 2026 13:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=joMPfx
	uTKxNoARHXSncTlMxLcH9tPvTI74gRGqZYycE=; b=Oyl5KKwQvLuXdNHFrZJV5D
	RX88hMaZCtqujSRIz0w2IauKcJR1ut7BQ5t4BNXdaSiP2MYS7NUTrk4r0wk0UkWY
	dtfGhkAXANWg/k+BlRO3I2F8mzeUE1Kukl5ZbiGrzim2ISLd3pB1atH5K+ga/gJj
	Mb8wk/DevaO21JjjMT67fYRQ+qoswMKRGH0/rUdAWFXz/a7axMg+Y79KrQZU/GUu
	UkyAKQVd0gu/onxxJ/gYqKNKR/tyiSwWsO+na1C2GyUdUIGDJ4O0elihF4tyDs+6
	PMi3RucIV8bFP+WcdarbQpUSZpBQlxgoFRX3/T+IV5VgrQhjDxW7K5AOS7saVyiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7r27f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:53:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDfGMO007776;
	Thu, 30 Jul 2026 13:53:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkgte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:53:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDrLaX50659750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:53:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53D0E20043;
	Thu, 30 Jul 2026 13:53:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 051EE20040;
	Thu, 30 Jul 2026 13:53:21 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:53:20 +0000 (GMT)
Message-ID: <bb631d71-4fbd-4776-980b-f5b2251b1f9c@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Improve DIAG 9c observability
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260724103959.14861-1-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_gRP5MDlZx6PIcWCLgMaJps3FuhjHkT
X-Proofpoint-ORIG-GUID: Y_gRP5MDlZx6PIcWCLgMaJps3FuhjHkT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX0tpUmHYZtt0/
 fKXvEcVg6JeaDTmcelIa5UuTO/fuMvIh2bTHaOuOtLK2bAh9v7bCsU19P4rfzf7nW1RBSO8S+qU
 p64t9OtQ1h3mk13wvSOsj4/0MRGkQ4hc3IsYY4rzZDW3asTq8FD/SlhFP+cOMIJSiMr8q/nCHTx
 p15cZeZ8yKXQcvpsutfF9trA39HpQ+TtCqu1RzOsYbe3Aa48dH5LuiOwx63vatGgCYWXDAXV6xS
 6CysTXEpfqtWbGrn+5msbHklM/AO+UhrNlHI/wmTLotS+8HnEq4+kiRrdxBYAqGHmyVS4AfQlKZ
 uv26xkQtZRFKXCMd39A5nUJL2C2+8wKV8Zeow5x/d8fdyi2Ll9WAo/k80cRn8/rb1noMeglBMf3
 9eGKtctDsk9koCd2Rm93laq8I+Z4Z2qlEt5v4y3rKnMBTmeDtNogA8RQHQyG9aSCtuAElPaGibg
 2eGgL+UgFTe7KB7SQOw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b5756 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=78g2LO9kEZV3fVhhZvYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXzsC+gISs44Zm
 QOQaYfkZHGkvn3e/4PLh7iA0C5dAvi0zSk5xpY+0hI2/PYPFO+RFnBWcUAbDjHsdIDKf10LYlqq
 Zq9AYiRGo3y1fpUpRSq33XblDz1meGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300105


Am 24.07.26 um 12:39 schrieb Ciunas Bennett:
> This series enhances observability for DIAG 9c directed yield operations
> in s390 KVM by refactoring the handler and adding comprehensive tracing
> support.
> 
> The first patch refactors __diag_time_slice_end_directed() to use a
> single exit point with a result string variable. This consolidates the
> control flow and eliminates code duplication in logging statements,
> making the function more maintainable.
> 
> The second patch builds on this refactoring by adding a new tracepoint
> kvm_s390_diag_9c that captures detailed information about directed yield
> operations, including target vcpu, target physical CPU, and operation
> results. This enables better analysis of VCPU scheduling
> behaviour and helps diagnose performance issues in virtualised s390
> environments.
> 
> Together, these changes provide kernel developers and system
> administrators with better tools to understand and debug VCPU scheduling
> patterns related to directed yields.
> 
> ---
> Changes in v3:
>   - Patch 2: Remove duplicated target_cpu and target_vcpu fields
> 
> Changes in v2:
>   - Add system maintainers to review mail
> 
> Ciunas Bennett (2):
>    s390/kvm: Refactor __diag_time_slice_end_directed for single exit
>      point
>    s390/kvm: Add tracepoint for DIAG 9c directed yield operations
Thanks applied. I changed the subject to "KVM: s390:" for both patches.
