Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9C4A092B;
	Wed,  7 Oct 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376318; cv=none; b=a7ROPbc6r7PtIl7QqSk97yjH/cxlkpje1hX4rX70So5LU434jVC1OTq8k5KMJaZtNG3V3nqz5l9MTQB+jHHY70B9r+ZQo/k7HqgdAdSZ7Et1YPBVHWG7LiLuBt7UULCVwknUL6O+LrdmiVe2o35ec6DNCCIGK5YHMT+/VZKBhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376318; c=relaxed/simple;
	bh=eBnnQRq2DKsdnRzMGmwNU5Xgqrwxyv4PHNHd4aEFtWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SMAf3mCMYOVCJYG124HKq1WMHpbdw+vpQu7qC7g8nmL9qa52Mhn821u97yS+NmuWKxbFtU3/4sdBsRfKCBPKrZtZjCm5F/bAYde/GfHtuLuTK5D132qKtPRwY1+mtU/9vM4tRJrqNCjnnID9LI/bYr0FgYABUxnErv3VfS//SeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rUB3LBFu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rUB3LBFu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZjE32463294;
	Wed, 7 Oct 2026 12:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I6F92c
	7/q0LfkYxVOXI5tlPRLsWvRrXBU3E7n7bl1uI=; b=rUB3LBFu3c91dnPZJd2Pvg
	RuazKeVg8nVNHsL+6SM6n9ylkr4w9jTtaoNoxJlui4iBvDT8IwWhENE8IHGEhvxV
	PGLoWdBmcq5e0VQQipfygWvfkauoY/POY9wXUgMweYhCRNqZt4p3y6EMpQbrB2E3
	kxUGQ7BSnEa/x0BZpTSlQGgVbYrCnnKz6vlptG/UUy2iJr4F8Bj4QC6ecqaHvNAC
	XCwnlfEhad71p3z4ZBJt9uuXRpNvF+J7oAtbTeiPrJAcPDg/Z2s31Sxy+YjHXZwA
	X3BqVQupj7pwzhIlvc9I3gSoZVLrPfHCYxT9RKBRjNBsPxq+SLP3uL9Hg6tIQbWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74wf2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:31:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697Blds51808483;
	Wed, 7 Oct 2026 12:31:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxmsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:31:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697CVQfT51315100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 12:31:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 069B72004B;
	Wed,  7 Oct 2026 12:31:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C30220040;
	Wed,  7 Oct 2026 12:31:25 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 12:31:25 +0000 (GMT)
Message-ID: <0fcdcc1f-16bd-4895-9233-caf37639e0d9@linux.ibm.com>
Date: Wed, 7 Oct 2026 14:31:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for
 KVM
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <0c5fe5c2-4ab8-4d1f-a36a-84a8fd136160@linux.ibm.com>
 <20261001114605.4167fa97@shazbot.org>
 <885ec96f-c352-4f9e-bcf1-f8ebabfebbbf@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <885ec96f-c352-4f9e-bcf1-f8ebabfebbbf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TfPVzUcwf5TlMqjwPGC7Ad0CxMr2XHsC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfX9w72xk6QouRg
 K4zoD2xu3yc3Q6iPOa38AZq0GviSICF2rwyMzVOQuuPagL0jtwT6tjL9gZ4edkmBQFWfaDskcOe
 7omsDLGMFEP0ILMZGPSPB+nYj71oF7E=
X-Proofpoint-GUID: UNcywO8AOzLJNXeQDlArn6YSD7lkNYg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfXzcewfpB7VTYM
 lE4mq/eLTiCnJLUkTIHYevDGcw5faey9Sws/vNBVvHrA2LV7tC6f/4B3muVzrd8xogfK4FaTB5X
 eS2mF7S7QDDuYxoKb2L4iPlS4YsohFknrBI7ZI7rbrgRUq2T6kS+Ikp8rRHNvOCcnIZ4zUR+X/I
 lmchxVuQHbSUcVx4jjLDvAMyWRSnlB/j9HcYDTf0GzP3iivm9AtMIBM6e1iRKg+XMkJ5G42VfQi
 yptESx+UradOzDFPJTOrVskcrhJ2xc+JF2waWTKdMla6DoVY4C4zF9RIyMW3agb0A80KEFO5Rox
 FMF0iIYrytwjCa8/HeD9KQLRDkKNEqJ1YQeYsVmZdEO2qq5x/ipgmV43wLINH1VhCfBRK6k7p14
 jvtf2l7OnvKeYtR3KJ0W/Dw9DXLxxsi7XZ2kdI1HboIQwKFC3si4Q+kKQ238viW2W8UUrOOqQAL
 cqoY5xJATr6smuJdMUw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac63ba4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=q1eBkuuBtHdcWU8FWkoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070048

Am 02.10.26 um 10:48 schrieb Christian Borntraeger:
[..]
>>> Am 28.09.26 um 15:07 schrieb Steffen Eiden:
>>>> This series switches the KVM-VFIO interface and external consumers over to
>>>> standard file-based reference counting, eliminating all external KVM symbol
>>>> exports.
>>>
>>> Paolo, Alex,
>>>
>>> I assume this will go over one of your tree? If you want, I can also create a topic branch
>>> for you to pick if you prefer that.
>>
>> It's a KVM focused change, vfio is collateral, so I'd defer to Paolo.
>> I don't believe I have anything pending that conflicts, it applies
>> cleanly against current vfio next branch, but a shared branch is always
>> a nice hedge.  Thanks,
>>
>> Alex
> 
> So I
> - applied these patches on top of 7.3-rc2
> - removed _safe from vfio_device_get_kvm_safe
> - created a topic branch at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=vfio_file_reference
> 
> Paolo,
> unless you want to take it yourself, I will merge this into kvms390/next and schedule this for
> the next merge window.
> ok?
Its now part of linux-next 20261006. In case of future non-trivial conflicts before the next merge
window, feel free to pull in the topic branch and resolve it that way.

Christian
