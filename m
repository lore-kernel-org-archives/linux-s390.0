Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA13AE19B
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042110; cv=none; b=VVaKAvs1jOUEZm8XFAROODf1mGSEaL2Xwdv3NoubwzhwyqR/cewXnfnexgPWVzsEAJumf9tRjUyCjqLWZalX6/W01k1tr7LA86XfkJtG6cRGdYD7tWAAhLCiL1dCbm9tsrefeFRy7Bw43Ia2EdC+mA6+adpof+VmawDmIsT5i74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042110; c=relaxed/simple;
	bh=AzRRG3nkJKa3TXNeid+LKKHFKkHFuLu5lrsQYS9PPWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbu5taZO1Xq3aLnnQk3bJu9l/307g4C8uePQ5IGhSqaIW708XCPHlXLWb5XMbGz775spnwhJJXzeHAXzK1ufhzwFjVfIGABLZg5C2EXz69DWhgTFix+3KwNzkUOBQ4sEYRU+ibm5C0UJAQ0Za5jlbA2s7P5vHxRjs5ISSZV9sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bjVMyiLQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bjVMyiLQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHiZ93328515;
	Thu, 6 Aug 2026 18:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2h3/HX
	/leAkdef8TZfyJz+awJSK0gG2UukYn+0Ql35o=; b=bjVMyiLQ28AUnJftdiQHuK
	7cfXoJeRO9/OXLN4tyuuQhuOjp5lUV6YmPslFIGsaqULqGwtUNeOArbKWmgKpilR
	UjhY5bGbgBxC6p7zyCIzYt/k5MAHebeHCPma90jlRUS2qAWsAR8SY4lrth3heneG
	O0z8LHsNG5kN0WY2qb7403qQeZHnvcHnwGeAKbAK8ePl+XBW2DucaMEGN+ggYaSf
	vNJqubUXYD9nt464VqI6drjnaFoscMNrubDbP19F+ERTH6XcZa6Chzt5pqpTbggc
	1Sp0x/cLk4BY8Y0b2zcWi7jrJuw/injdcWX9OtLYIW6gOVuuXnO63cFPBr82zdaQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy020910-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:48:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676IfHWp028794;
	Thu, 6 Aug 2026 18:48:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qvn51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:48:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676ImDon50135440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:48:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0006B20043;
	Thu,  6 Aug 2026 18:48:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52FB320040;
	Thu,  6 Aug 2026 18:48:12 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.90.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 18:48:12 +0000 (GMT)
Message-ID: <7acd03a1-2016-4b33-8280-16f86c1e9bbd@linux.ibm.com>
Date: Thu, 6 Aug 2026 20:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/19] target/s390x: Fix missing privileged flag at
 PCKMO instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-2-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 57qWU6IcRH0OC0G56KRL2JWVTg-dBYpy
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a74d6f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VjVqcevbztYfn-KFCzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 57qWU6IcRH0OC0G56KRL2JWVTg-dBYpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfX7rxw8vlfcID5
 sQhSTK3G8YAYi0yZsC5YkrmVzMLSvpk8fpyVJ411YLLs2bUUiZIrqzKTqnAJNh0clr45KBHKeya
 XtPL+f3Oul5/46C1TYMgQb193Ly+mITc53URdRMpCSpXwclDoeMccqxMeQnEO+Tcry66GVm3UKy
 sMWLcXofomSSj+J30cTkGv8OJXyuFO50RoUIQlkFmCiMNqdXw6totp82S7anJHpU9AS7CE3984h
 5VkNSotY4Q895rmwEtTH8XXAZPv49c7KI8DDxgm3+9CXtu8T9LFnzYgpHdzY8pTq/+dAuwUAMvz
 WA2oIa7Rpjyqu+j9DGa9micd44GVUnNnIuDsuXWClbLyD5mymIPTD28qiYatFcs1b1X6DaJaYFg
 5cXMBjil4GUIaj4oB9LvHCi2yeOgNtn+aEpkrgzad76o5hiMToL6iV5Yx8+xBfpeSW6SUQHPCzF
 TYXAIgum6zQ+tlXj/Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfXz0EtrtuCXT2U
 B4SgReKLXI4mc+VPuoVjHT5tyxC1J1/RWNacbBd63yx9JasOTsD9ocAuOMfsWBEL8C874vOViyg
 vjO5kavQZ6cZi0bjSJolRof0bonZ0e4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060147



On 8/6/26 17:12, Harald Freudenberger wrote:
> The CPACF instruction PCKMO is a privileged instruction. So set the
> IF_PRIV flag in insn-data.h.inc to reflect this.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

