Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE273B6BEB;
	Mon, 17 Aug 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968391; cv=none; b=KGjVs+ynEB7FDhgO72g+dMMUZWrKNHUuFn25V8phW5zUaT62beZhrOTfQMYZf8fkzOMzjDTe4y9lgbvfHGsVbFhAADBc0DuBLKALKKzryBbRH8uIjumB8I+yWR9iFWPdPGg08Zz57iHBtjRZUT39j04dWpuRjSPGQhscmxQosHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968391; c=relaxed/simple;
	bh=NhT6EF8Z3Bj2WKshxPIR22F9TIjw86UlD0x2dNFH3z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFqofgrJ/7bzntVpMnrLwOTECQkm8/GXoj4qlDDmJCIF0Xe6eBtxBh5G8Ddx092MBXOpamYtTg9ro9x/c8jX1RtRRCIndzsRbgW4DP5eC1L750sui51SQkcLdRkUQwTkjskP/44MT3IfyUKGtgxUz8C3/Jcxz7HJS4Wf6PQ0VZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gvxb0sMB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gvxb0sMB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HBe7oT3728213;
	Mon, 17 Aug 2026 12:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FYFepL
	v3ezJ82Nzh8nslucIcwoUoxA5A0xL8z43WPFo=; b=Gvxb0sMBz2c3XaTzZ2rKk8
	kyEhUZhHroURlobjYr6etEkfjx8HPFbqkdxUqEnbOc730p1pffVbEk9tpkGMHmSQ
	zMk3axi38vhtGsjhpcnnSnP4GbXprWG9VHAX7lYVvwruZpWeQPtQDxxp4EE1TPB9
	i8SGInCLDIBqXAM3CwBXCHhnyOXnQ+57tDEfommyQD8yvGAmwo1xuHQI8OU2fkXG
	T+0p83jdMd+e7pOglWBAIETmPQntdlqt53nwqIlj1SqgxgHKMJ+PenT3+84utIQ2
	/cVltk/kkFdSYnD08Yj2CJ8ANF9WOkRC6JGm1w2cWae2DC+JBb0eI8ic5Sp5az+A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4j445-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:06:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBuJ8V007438;
	Mon, 17 Aug 2026 12:06:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5qpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 12:06:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HC6Mbf52363652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 12:06:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EF1F2004B;
	Mon, 17 Aug 2026 12:06:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BDF520043;
	Mon, 17 Aug 2026 12:06:22 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 12:06:22 +0000 (GMT)
Message-ID: <4fb902b2-bd5e-48b0-aca0-07e51a80d8c7@linux.ibm.com>
Date: Mon, 17 Aug 2026 14:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/iucv: descend into net/iucv independently of
 IUCV
To: sashiko-reviews@lists.linux.dev, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260815135456.53684-1-pengpeng@iscas.ac.cn>
 <20260816135517.816271F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260816135517.816271F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pmogP8NQyrN1KfiVTS45ephLpnK9QzwG
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82f942 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=3ryqjR-gYcLxyyiNjjkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX6ed6Ow5JkbKz
 WgbDmRmZ/7ZuDZtxWWp2HTvHKUQtLpRFX2CJ0/btdhC9E9dCf5B8K0DWP7zSuiNivCX8pOLNFsM
 eNDFXW3q9VwKH0fGqegACaMW8osU1oA=
X-Proofpoint-ORIG-GUID: pmogP8NQyrN1KfiVTS45ephLpnK9QzwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfXzaOy7bODNQIP
 SrLDFLEKWZtceIIhIzgTATTgO6YNtkWXNh9oR2Jl52kWCLEfdf4320DE0x2UA/93L+8CFfOwQRj
 nr2Qq+xMh1Y9U9oRJkwy2WpKxgSQ4PJ2WfFH4dQXjP/lTzindBh0zSssNZCKj1x/G+JJ8ijwZ9c
 qbQCwP1BTKLijvPeZY6S4zM2+iL6ozqjwIMkgnzNIrIu3D0Cr3jmwjANpWs05clOhP9rR13rx8c
 1d0ISEnXRGzR/v/SaEWmHOlCWQMtEWLitAjA16CezKf90fIvSrtkKs4yUjMmbI2iPI+eSdbcn8j
 FFjRbm6313OklTd7qBZqcdNQYnYm3v1j+KXoqfWZ49BN4iA+0GR2/U63WT88FjNlmWiOtaUgwNU
 +7VaBTRD47TAhkTjh7YxfwgnJcEWGpcnl4rTymMrlW6Qb6saYI6CjqVlRDIKp58gygc8gUKg3ih
 Q5xiNcFV37CYN5WYLXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170091



On 16.08.26 15:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unconditional descent into net/iucv/ causes a vmlinux linker error when CONFIG_AFIUCV=y and CONFIG_IUCV=m.

@Pengpeng Hou,
if it easier, you can also fix this issue by making CONFIG_AFIUCV depend on CONFIG_IUCV.
I see no practical scenario where we would want AFIUCV without IUCV.

