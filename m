Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E32318EC4
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955343; cv=none; b=o6l240muP0+3npMYJoQ/pzF+DXhn9vLO8VFvIJgGlaguWnCfQLHRcHkfQxoxripXls5qx3M8xnRrMrTlLYGk3alEaeHbIy2crCn8OMC49JbfLcAWBPfn4OPKStrAIGRY7r6JrIWETqIINVOYcLHSLM4FI1Fzvomz3NeZpgE9mAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955343; c=relaxed/simple;
	bh=vhxWh6u01WO/VAetAI1ZH3Jw1noyMUXpHRQeUJNLoP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWsw+hzIK7OIl1NLgMlMom4V9FR4NLU6wTSuM1FCN5YBkKIPARmIP0JdZLf11K423FzPUW5zdFMhziJ+QFv4pl4gh/nnuaTI0k2xJAT0K5Nk9/R3RJNowJqqw4RNJfM95gqsN/oo4OEuwb5Mc9TTHgSyvbfKnHZNRgcXXn4Ft+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RyzJd4dg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyzJd4dg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLWMq41866853;
	Mon, 17 Aug 2026 08:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uAjXUA
	MslYXYKKBXhAlhQCe4aFYDy2p48BTY7aXnk20=; b=RyzJd4dgVQzFillAWtlJEC
	gjdOWjAlXLged96OPatmbcdRyRf2rUETV6ju8rY6NEIEdmCsc0szF/aVZi09N3kn
	CXv0QKTmIU3DXm/CXoToDZ7r3/ACtuQZgp2b7qEyS+5OEb3WiWwyXY4MK/jeVFF+
	ThgTAgJQ5Kr3ybksq89GY3D86jHv8E2+p2gAslJtqLWvSMeL1kcU7S8dkXOJGNT3
	6ejBBIU9Si+PjBDlenDyF2T73ZZr9cfG4Pje21dQlmS5FBTV4YYsuotk0IRQMtr/
	igND+q2FYhZBAuRQXtx2TG/Gpv+X9R7CtyjjlbdyMSFaEJdNL0tabQtv5RnMbYfg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqh6fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:28:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8QJUL002488;
	Mon, 17 Aug 2026 08:28:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejw58w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:28:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H8SoqO40043004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 08:28:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35B2F20043;
	Mon, 17 Aug 2026 08:28:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A579820040;
	Mon, 17 Aug 2026 08:28:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 08:28:49 +0000 (GMT)
Message-ID: <49c9f364-6786-4949-a0e0-26f0a82ee168@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/19] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-16-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-16-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX0IVpMeNvS5v8
 hwCC6JkoKMcN81Vykg3irM/HW74SktHs/8pfX112wSamPvxU3EKHyta1DwnDQ6/NcLypXl+kwMM
 5TwjQn8xVYx/bteCYN80P7SLX4AtBlrD4TiSeD2k5ldAD+tlNOz+kbKLomwDREQHoGuAtQKMSVv
 lz1mDWSItsAFt7D/9dkxKP66gFrdHjeUJSWQGXnRg6e3sTzzJz+baAttq22IkE8eO/BSibvR//T
 UndICnftKV/kN1xwJ8kjR+fA5rhDC1NaKb/7jTsVqRJzG2dTAVeHj7Rz/m3ypdVS9A6vmna0CkC
 R81wbFwB4Mmyok1cCNpLIJy6/HYRVRywHDE1M9wQYCzZqI6Bo/Xf+T6k+SkRg565E/WB8bkG9jw
 JuUVIideG38fYrJBzzkjXf0M6LiWuxcMiyKIX1bGRIOglH30YJu4CHU8iaJ8EjybmweDMmxpVsg
 rTuJ7+LEvDJ5eMtQoVg==
X-Proofpoint-ORIG-GUID: zouY5WBnlzSw955TcMs-I8-YR-zbwdK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXyfSKu0bNUdPN
 A+QCEsTzEA808PuasOstwB8PZNIZUdpUnfUgyHFMyuw00j9pY5YH80mIot6e6rrb5EcRmUrJ+BC
 c7FT0w84n7TcjX2/BazZ6nIt0DaNtio=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82c647 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oP_v4j5VuBO_2k_MHp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zouY5WBnlzSw955TcMs-I8-YR-zbwdK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 ++
>   target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 95 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

