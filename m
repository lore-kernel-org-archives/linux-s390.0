Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D503DDDB8;
	Mon, 16 Mar 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686867; cv=none; b=MzpveDfM9UrshEEuv8IdHXs1nCDkUtnp3obMqbaLb9vN1pxc7cO0ogLSDS11oOsDi4+ypgTBziHryu28VUHqmjffssfAUfkUoJjfdgCEQK5WiUklG8U/b2zrwTxtknHYUMHP7+RjVvleL0KJIb+o+ab3VGA5yGnhM/8KgEGFLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686867; c=relaxed/simple;
	bh=RmRnS0pjH505r5xAvH0PH5EL6Rc9RFCDEYJ6Wrny7rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REaucOBdP+bY97wh26hnUFnl5V3YZ8R4mDIhgW8149RZWMFh4CUaRGMBiWPlkzHLkdNpj/fddp8Q0/OQeu+Xb66a90BfgG4NtOITo8oPeJtyqu9+/cB9/LTMi1aQdfBCbpcPWuGfi8wbVGNBmClxj93+KW4UlOvZvlsxx8dW4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LNL8xjDa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LNL8xjDa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GIFH6H1518585;
	Mon, 16 Mar 2026 18:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RmRnS0
	pjH505r5xAvH0PH5EL6Rc9RFCDEYJ6Wrny7rY=; b=LNL8xjDarvo4oYwzFrGJfQ
	iwS+LhXktTCNk/FykaKW9ZLJxavzWcjwtFJe+PVver4lpFqO34ui6q2UEeAeqIT1
	E/b8LCAxfuxarHjq1KI3C65NZysSUoJeHvsj7fr0zoz/PuYYds4gezvg2e+HGpom
	dCHdUJ1i+xOGq1VD5+xv/FMmZHRWN3zbN/xoOU8/I9+JFTHAWS9MdG9L5y79BurM
	xDoKWpqvFx3UNeH2rWxD/kbyLi/Xni/S43VjrMTdX/lX/9YtvqWGmt6CCsg6EJTr
	4TumZn5XazQDfD7MXO01g3TkdBUjtGN/pcZd3YCYe8uNt9Kg0XTGGcl3nDNZHDEw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfbk4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:47:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GF6hYH015746;
	Mon, 16 Mar 2026 18:47:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n5xj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:47:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GIle1c15532400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:47:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1269B20043;
	Mon, 16 Mar 2026 18:47:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF33020040;
	Mon, 16 Mar 2026 18:47:39 +0000 (GMT)
Received: from [9.87.135.243] (unknown [9.87.135.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:47:39 +0000 (GMT)
Message-ID: <bc995033-1850-43f8-b04d-66f78ede157d@linux.ibm.com>
Date: Mon, 16 Mar 2026 19:47:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] KVM: s390: Consolidate lpswe variants
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, akrowiak@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-3-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316180310.17765-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AymZ7yM_XXfSxIninas-t6idLcvaIXvY
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b85051 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=U_JUeUZVbtrPZ0bCk3sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0OCBTYWx0ZWRfX6V6SPZbyuVN1
 So3rnCTxAFG3xZqNFLMoLZwI3HSzYdCjVQsoXvFDgRg+JsybF5NUT70ylKIHsmxrYd5A1ZSPFx9
 Bt4x1Y/MaT2rvYlWuplrDmEuTg+Riqfj0lXWUeQIzf4wTDPB27rzA1ylgCSVjSpdqPOu1QBPXae
 0FA/qcxAyLWiGClxCOO1Foxc9bYo0oemiygjt25RECEHPULDoSZMXbqYrUkI2LUpvFxXiDyMTCC
 PyXCfQCVGYrnB3IyAqZXFgxLAmWjSogUhitkXNfGldhbNrh/6Hh0tyy4R2WcRlQiSpBiLg8DK3O
 8HxGqF6rOXh39BysYIBxgDdqay/MGcQZ5+2md5mbXt1wXPKGJm/8Ugb5CXo/S/s8LORYS4xCsQk
 FsCGDOd74qdIRt+GuRMX8mt24SWm8s9QNiUTsUcYQY5JaEGjAprs2242CUYJ6DIvZVSiDqEztGt
 8FPpEKUfm96fvhn2jMg==
X-Proofpoint-GUID: AymZ7yM_XXfSxIninas-t6idLcvaIXvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160148


Am 16.03.26 um 17:23 schrieb Janosch Frank:
> LPSWE and LPSWEY currently only differ in instruction format but not
> in functionality.

I think this is actually a bug in KVM. LPSWEY does not set the breaking
event address register, LPSWE does. Maybe that would be the better fix
to actually set gbea when emulating LPSWE. This must happen after all
checks, so I guess combining both would make this harder, so better
not do this.

