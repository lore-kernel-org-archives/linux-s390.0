Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E5471D03;
	Tue,  1 Sep 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256595; cv=none; b=bP3NviTdri3VEAP1uzBbSGil2RG/OalwRi7eu2Ra3G2nIBNnHvYLfNaISpRTcDvkgWDj+R9KovQjNwIHLlPH19p6lwNZ9rRcV6UjFgjvPphBh8/wlM0ccD9vFbwaNKNr0HSW80hqW/gSU+h/yePubouQUj+C14i0l8k0kkdym+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256595; c=relaxed/simple;
	bh=AWTBME2fyqgNTBKhPIZXkoYRatuX1i6WsboI1HVu/rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNl9HPdGxrQ0j74yjZfNUqGcFa8bTqEB4KguM6k75jYjlB76Za5HPxcaSNyginIZr8WCOoROAG0bBCXD8osCU3vPaW8yLN+dLABYqeXlOa3BVt/uIpPZdf9CA8sEsCXRj6Dtbtrt3kB0GaKqAj6AhGbEnM4UADQbDjkKDaZWdXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/br1F4t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/br1F4t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817VvRP2893103;
	Tue, 1 Sep 2026 09:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a29THp
	HOoYAjTajKwDTzz1M4IP4ZioxJtgmGKM4/1wM=; b=T/br1F4tMg5ZCDXErrI73+
	BvN1UAY0vkdFedWunef1F5WBAUS9tnMFM9seFEzbYgNEax1NFYaCtKGCNzSYTCKC
	LV3c8d2u9iS1bjwDfDfLhdXxtGliPBbvNdIYZlyXswscRWBZkyYO7ZE5M+JpqW0T
	6qpW89xTtlwNRQAsgBALgydqz2mlCNrFrM7IZ4YkbMuuGtbgKjjYnaQThY50xLy9
	Zp5fb+BEASrfZWQna65NpXNEXrFnjkiDVICP9CVhCEhAMwAS4hT9l1g9t852YN/7
	BrUv0iaV9tULQK3TSualLXz23+1dTWNYNWl6HHF0szIq82shAp72XhHTvjW+XJWg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r6yc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:56:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6819uH9P025442;
	Tue, 1 Sep 2026 09:56:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygatpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 09:56:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6819uSCk50790874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 09:56:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A45820040;
	Tue,  1 Sep 2026 09:56:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3038E20049;
	Tue,  1 Sep 2026 09:56:28 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 09:56:28 +0000 (GMT)
Message-ID: <9f3ef9c6-85ab-4e37-a1a5-0ff1f14b6650@linux.ibm.com>
Date: Tue, 1 Sep 2026 11:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 v8] s390/pai: Use PAI PMU index as parameter replacing
 event
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901085448.2260658-2-tmricht@linux.ibm.com>
 <20260901091238.F26751F000E9@smtp.kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260901091238.F26751F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a96a150 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX3pssJl7NLM/4
 QA+IBgILBFVzyLOE3yIk66nBTO+74XvUmUBD0OeoaO7QjSD559dN1LnfCJduaSxcP0D7yu6RFTr
 oWRNKz/M5UE3K8xgl04/zcT66FP8IrZq8IFMYq70A6m9AtfI8raJa4LMEdVdZRz8m3Ma37+Xz23
 nUjPgTMP7thsikUMAq/ZCVbr3Q05QJC9F+5UyoDWvPfHkfZhJ6fTS5QVy4SGQNRW4wAzXUEkpVe
 2ZBC6EzpxkVGh/TTld8bnwiy2WKR/24UQrT+c4WODMZQqCdE+Uvx+E3hyKrS7zdHZGTWEwWnOXR
 QoFttnDNMv/GyrDmOW8hGP/H9bQGXimDFIbjbnPejemawNMHZTCVm6WIdG9AuZGp7JcGNres9ND
 LwRvWqFyGDoQKN0Ad+BXARB5ZMY9G7FGEDEZId7jFRQgz1ro/62X1i7RYUI3jLfRUA5w4isKQrw
 3mfUSOmiL+pt8UAyN0g==
X-Proofpoint-GUID: B-k0i2rIOdbYkHrQ_-l152pjtCcYLS2u
X-Proofpoint-ORIG-GUID: B-k0i2rIOdbYkHrQ_-l152pjtCcYLS2u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NCBTYWx0ZWRfX6SxN+VgqHLet
 /3Dto/HlF3GnRHAKNXv/6CaRpzbUZzdM8wmKvVrKS0sYpGqU1Mv4M2Wm94FYxC3l+LA6d117Yc+
 /2RNM4hy4lOiaMsqyT2uEyhEs4a1eh8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010084

On 9/1/26 11:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing bounds check on the hardware-reported NNPA counter count (`ib.num_nnpa`) leads to an out-of-bounds kernel heap read.
> --

This is not correct. The value of ib.num_nnpa is read out from hadware and should be correct.
It is assigned to member pai_pmu::num_avail.
Later in function  attr_event_init() that value is compared to pai_pmu::num_named
which contains the number of supported events. And the minimum of both values is taken:

In attr_event_init()
  unsigned int min_attr = min_t(unsigned int, p->num_named, p->num_avail);

So this is protected.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
