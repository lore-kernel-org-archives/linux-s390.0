Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185200;
	b=QcysjBwKAMBo7jf4+9rUAvWlHBLBIkM7RNKH278jr3q+9JVM6e9cSh33Cez6ajULlwiT
	 e5+Y5kD3nalP3O/nmWotNXaJTbwm+ncFOdM+9MhlCAvrFYx43TPgf1URzTeyjl4bI6fJD
	 cw6s7x1B/RLxNqHwnr69kmtK/Yo1RsuDtErYrw4vI04ti0L5FURaqqPP7yc2rOqZyii/f
	 ycZrkXrqVMNyzEx413FIp3jH7TV26IwLHGFMMlPdsvfoB4r5mnjVfW8I0TECTOAilWs+g
	 /6prxEWnoUK8N9C4EEB1do6Sspl250JPEyn+9MkHpD5D9Vi/K+u1PSkjg3lp5dpXoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185200;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NgPW68yO5xRx7wOLZLF3kBzvXnOxI8QciKYbTZT0ohE=;
	b=ID/xdyZ8+DLFLv6jOltlCulQ8PgL4fewPQDta5jVrAiOdsfra5gkO3IzG1ixOAn4etwo
	 D6PvA72YGV31c4ntkLohetN7uTr3tnHSOOsDpM0le4BRnLsf2Risczk+mIei9pi5j+GdF
	 Fc0yk3sLOWOwvEfMsr7/6kFH6hndAc3VCMczUcjXlmjmmxBI2rFbZuJI/QfA0SH0EyERK
	 unTozJM5R7tx2EpneX5VtTIjD6sXxVkD3YOj2b6aPvk+gcnPF8uxv3e3eyTDV7EEkZhpK
	 HOtjcxCc1Lm0jnL1IKMhfe7LAMCTsX1Uxoy6V73Wyg+bM0USOFMZeiUVDZOSc2TmKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qn7xgmTg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF2606A31D;
	Wed, 28 Oct 2026 10:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BF2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qn7xgmTg
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8iaMi3807154;
	Wed, 28 Oct 2026 10:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NgPW68
	yO5xRx7wOLZLF3kBzvXnOxI8QciKYbTZT0ohE=; b=qn7xgmTgtZWOGNqWjUG3qF
	QppGRBNbL2FtTb5NPilvUQVy1RbNMANi+T/AkUvh5jsG/fCjb4EYAo0ezKFMnnw2
	nh/90YxGfADLXbmMsXoQK97bPc1BZDWDIfrGQzYDd81O4pbYRlPUJN6zGQth3/en
	6mN3Kgk1cxwxe7C8xmA/svVZNhBynyHDWuetxJJADTRJyvLwLTcMsNtWSAGGM/i9
	QXeJQom2O1oqin48MPznzWjDkzYmZpgVGiT7SOqisd6aoResXqOEeilKQRcRCucT
	XmvCQTFZqPdhHdHf6VGE7X+aehJ4pE+NTEbTx5KgGtt2uxJjpT9L5NPGvYEzHwTQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g4341-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:59:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K2aT089847;
	Wed, 28 Oct 2026 10:59:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010k67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:59:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SAxsAl44826990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 10:59:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37D2520043;
	Wed, 28 Oct 2026 10:59:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4D0D20040;
	Wed, 28 Oct 2026 10:59:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 10:59:53 +0000 (GMT)
Message-ID: <d63f0937-81fa-4f16-8d7e-759c7a9d117d@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:59:53 +0100
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
Subject: Re: [PATCH v2 05/10] s390/module: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-6-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae1d5ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=HpabCH1pQI9q6Scd3zQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: cjWpqtrfv6lOBw7j7NfGt5p1Rzs8uNoU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX0i5WyqVmTFeI
 9/XuMh0LVGYULb0efmeYMNWqcf1LgLi91XfL0ZSePt5ucxUWjlcAJ5zDej7nko5Y0d0e/QPqqOn
 JSK3l1n/Dfk0iOC2qDbGRB1N2aVSywZ/NUw9cAlvBZ/qB5TGJ03fZZU0CyJ8elBBbE4sZa7zUkt
 TiZVmWBdqzzG+sTwOAHydDGIkXbgGHBaG76c+4OCktHKMbbKC9ye+MX2UM5SrkRVMT+dnukam10
 TDfkB3yAe6q8IRD78yR2uTbPw6ySQ7EJl0p/Mq3RQll7bv1sya8W88m6Oho1TmQGop2MAyL4fXq
 fn0E7J9f98+FcHUN+QSWhgrXj7SPMKUQ/EKd8MmTRZKzUN1xMTm2rrtBUu8EYtPd8FG6YHRHrlL
 zZXxBG0tR3ww7O/T3vdGnsD6OGkZ1ySGupjzzjkON48zFGJAGuZhdo3H/FLqiwcHphgZ5t66FzX
 W7UnXJ5AEop38fU3lUA==
X-Proofpoint-GUID: cjWpqtrfv6lOBw7j7NfGt5p1Rzs8uNoU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXx9uDGpZtJ71u
 u1GVfKCEdMzJuwrA/GGgjwdl8qsiUX0Q8F638fdGUMmNaqqMNQvT+Fnum7dLtDq4H278p6rRua1
 GlJ4RLwjEd1mq9aTs5GFQoFWAXJsEzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280042



On 10/27/26 15:30, Heiko Carstens wrote:
> Acquire text_mutex in apply_relocate_add() in order to serialize text
> patching.
> 
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/module.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

