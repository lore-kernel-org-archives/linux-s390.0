Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185006;
	b=1N0Se3yw+TqLLGLD+zqdTZevtNKhPXPidCdlE4p4YHnHxjs9CHBD0Z4rIQ4zbsCol7OZ
	 CZsj/2pu9D3t1CZ8wPy62XNJOkbYVXUtdN43VWU4OftseSf+Cb99/PZZh8DVgvsVW46v2
	 2xl4PL9xtQyY1YsI5ffCqhQqR4w4n6qf3K/eyosc/Qah+Cd7n+gXBDFVeOD8n++lADzv/
	 mFXe5+zlRXV7bLlG6tEc/4hCNxND26qghS9aExcuWaDrgaMm0iqe1pCW8XEl+jDdpKpNJ
	 b1St41mpMmLsIPJ+ESMAOPboSTf6AHtud6TB9FEiwogOZ0zZ/VkS0A6lhpUWMhpVvQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185006;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P3Cx7xZ3eRr6G5PUqS9jqZ8goXeOXuPLjJPRVGRgDAw=;
	b=Iv5gQ9WwEOLqfLCNKV7uBgn9XFlwmli03oZDOrejLnlDVJlYvGlDQHKwNkISn809KlBk
	 uVAUKOmwSd0NvCIVQzIQ2PfB8yTGl1aumEtlMOqB1MCs2aKp4pCRdyKJ2SJTWpC854WTJ
	 eI5dy+2LYlxwwgzJ7pAYlh5QARTCLh2aSDAw1bAJy+3phZoUxqyYC1yddJGtJ2DtDLG95
	 zfRXGota26H0nsIB/fk5Lt0QezCsityTDuj1cOrXvDjn7+CH9299ZWYPNiVQxcJZaJClN
	 S/d9E91AQmInyF1uOkOxd4ukR/0xixGJSPGMokUWn8gJ6vPJxwmq/POjd8A5i0YlevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KlrSArkg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA77606A31C;
	Wed, 28 Oct 2026 10:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KlrSArkg
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8ib9m791581;
	Wed, 28 Oct 2026 10:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P3Cx7x
	Z3eRr6G5PUqS9jqZ8goXeOXuPLjJPRVGRgDAw=; b=KlrSArkgWf18n7oDaVdJvv
	jUOKJsaGTHLXpIeXN/+lBc7nSgYaSwvgm3j6CH96jhfLHjgN4qPCnu9tWLP9ihg7
	aAVTpZnUW7stavv2iBRlEiiGXl1Zv9j2y8YEfThspNNaXXa7MF6rC23gU2a0ntDh
	HL5ziUjHOkGn939YsfCO/MhGRi0blxaRr2HuuZkpTDjM48hjV7yXDVRL0O49xVJT
	cdaeKbUvn/+mzBb1BycH0bpvIZo787nPbk9oj6tiCJf5jcPBSE8PVs52kExNUuE5
	4tyJaBtfqinwNdVux7RT2q96kjR9l7yV09ICcs217cvW1CJ8sVmWQGWnxaLrIn2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavksud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:56:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K6r11316185;
	Wed, 28 Oct 2026 10:56:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1v927-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:56:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SAuemr34079020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 10:56:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8613E2004B;
	Wed, 28 Oct 2026 10:56:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49BEE20040;
	Wed, 28 Oct 2026 10:56:40 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 10:56:40 +0000 (GMT)
Message-ID: <72bd0cb0-2c5e-4c51-b68a-499ab96689fa@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:56:39 +0100
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
Subject: Re: [PATCH v2 03/10] s390/bpf: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-4-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae1d4ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Yp5wXM3k0iUQaFnxeTgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: 85FYskONHFN3onAgQTPJ0EW8SZGl86x1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX1sj7e3ycHmB9
 I4XhlKlyCzSyEsQ/fE/3lx7us8tTuByoa/CR9uzT3v4sHsZnWE/c9zMLGH00j604Ba4CvZmf/kf
 Yk0DhCg3DCr7ePQmL8MqQoGXAYgZb7M=
X-Proofpoint-ORIG-GUID: 85FYskONHFN3onAgQTPJ0EW8SZGl86x1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX0J0gZddOOnnY
 YroByeSmRJwJ6Qhn9vjVbF3j/IRjOSAWwyHzTenOPNe61X8FKrXvHogdxWZvlmpHjqIhpllI8wh
 3ljjuTUpEh0/N2iX8ExW9xe0lsfwYatVTZT4b7z5z4J+u/4sdHJSUwbqQD7tAzG6JSIjdcZ+CEA
 Y68xJj4IKLImeasQkhpoo2JJuHzY/K5473+xkyEzbVPkVdRw/oSrhNxaOh90P8lU33cRNAOc+Je
 xtjtzu3KX0V8ZA4wp1t3BEqnjpbQwkbFteA9bZ7rMnzNANvxDZP3IQ2edOYOxY2PtUHAUTohLYi
 B4Fr5DvQu8bdASCEIcrO4ZzIfhoeU+WWN5SfVXZ2NqT9ibExvoCgKxryLPg72/vEkznDlujVeSp
 0T45xpXdjQnrSvz51QgYhpsehCcl5HGTU+q3uV/qOk+6mZQaKaRULz4mc+K8DTo70VNhvu5gvYl
 OK2zOL1kcCWHoKUjX/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280042



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex in bpf_arch_text_poke(). This way s390 uses text_mutex
> like most other architectures.
> 
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/net/bpf_jit_comp.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


