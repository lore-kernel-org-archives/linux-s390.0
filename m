Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B541632DD
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977864; cv=none; b=uGTQoKNT6xlX+ZfIZs98XHZVfQf7oiCQoqQDKlpUAlNieG3OkLtZwG1AEJsGTKPA5qQR9QC6DjPy7xGKs4qdZ4TzDdgBol8EVnqnQWAeUGm8VDQL+mK+xH3XQzjFAJSnJsz5jTahak1LHKXIRt9qzTwXRbe+fPdAEhJbAh3/qsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977864; c=relaxed/simple;
	bh=yu7yG4BTf6JwhqIUXjk2TJJpiIHXutBk3GERmxHVlUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeDvOmqJk953DTu3ETlRsP9aQTNyklyNzCClJ/vB8voWq4JCd5cyqAO0+60L8gVEm/BiOMZfa4Lu2Q1b5pVzHJYojWs2BWN0O4g/gF3YWxJd5UjzMLNj1Szc1wK0TfW8O/UpMwxtWfoBUBUwqdVtenSJjVHfJno1R7sPwboZ2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VpbP8I6e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VpbP8I6e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCfIUn2692034;
	Thu, 28 May 2026 14:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ofqraM
	36xfdjayWPA/BZ9sNNJ7MfOs/vIvXvYmqYF0k=; b=VpbP8I6eIUrQ0aOh9Fynk5
	QVXly2DSA4fDil8fzJkjaZZomy6akCSlmDSWpTyRsBtTnNV+iHrUITW5iu2AvRKM
	SZU6oeHj4CUzVHJPgsLwAHQmzGIpWyAhalEsVXS9FgsxBwotuQEknnLZtrtLSnOP
	xCnV5l8qkVZWGpBSdXjde2KsNJWVa5S22PaGjGAJozNTPiyC6howerDmGn4gNTCs
	XTaDbB/F046t+RaXRyrI6FYYtOekOP2s8IMxzlHT1Bb/wHqQB5oarscXmQryhyZx
	dzUF44Xr94+UQTpu3kwc5tE6s/Ad3aeYGiR6WW6e6TmAQtUeX5dv5CPfLJ78hcvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884beqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:17:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SE990W026526;
	Thu, 28 May 2026 14:17:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbrfh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:17:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SEHam949807724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:17:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9EE020043;
	Thu, 28 May 2026 14:17:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84D3E20040;
	Thu, 28 May 2026 14:17:36 +0000 (GMT)
Received: from [9.111.210.243] (unknown [9.111.210.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 14:17:36 +0000 (GMT)
Message-ID: <32d35e46-1f44-471c-9b34-715b4742cb54@linux.ibm.com>
Date: Thu, 28 May 2026 16:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner
 <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a184e85 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kt7I_EveaTZZBW9BUTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tX6qKjvVjNk0piP161fvXGJ5UzsH-oHr
X-Proofpoint-GUID: tX6qKjvVjNk0piP161fvXGJ5UzsH-oHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MyBTYWx0ZWRfXx8gTEklGPymq
 yV6O67iQYJsnY2WL4pdhA0ySFODWkY85tsOoNuwfgRwkKWMla8QUEC8t8w7w/rFjQ9Ag0tqyGOY
 I6Ss6zLqwxkMfR9qfgdVbkqcl0pE/waE9nC6nyPlGheFmbwv2iCoafl7ebkS3Ck/vu3bYI8/GNz
 XxBTmIAzA3LgntBU60zSJVKAY4wjHsRNEbJNOLaKERSWBmzPkR8z5sG/vaVEO3+SWQPW6fhPonf
 HCewxBiJUBaqlwOd5sQ9O/zcsBuRhA9NT9IGx4FnG8Xmsjq5K3NvIUmIPfAw34lNWooil9Fzv2M
 yUNiHEhZnoVig+IvvGg2JXdjRJokO6o8lWCICFUBK+mjqAa3paitHmbysPn72pVCLBA311O/jGP
 3l7BfmYjf0eMlQWkZvGM8L0CcNnvg53GhsLDR54WfBiIcs+sY1H1b6TOj6cbWYKIJbMMOJ8dv1E
 xL2saxGgxznL+/H7qOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280143



On 28.05.26 09:09, Mike Rapoport (Microsoft) wrote:
> qeth_get_trap_id() allocates a temporary buffer for STSI system
> information queries used to build trap identification strings.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Acked-by: Alexandra Winter <wintera@linux.ibm.com>



