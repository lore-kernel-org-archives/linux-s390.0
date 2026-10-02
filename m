Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B545516D;
	Fri,  2 Oct 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930945; cv=none; b=HYeu/dVNG/AfuQb7xSIUwpAYfzhTSFAXUp/S0Sz0hVyIRY/vS5gyEPtrqeal5GGPgwz1qlrGHHEbE/K0p8AQ0ktUBoeiEky/oc3osP4nuCDNOXWpq3EuYziKWUMTm9PkxymMQWKU32kIYwZbB6rV70bid5Mtjw8UxhCtkBWQ78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930945; c=relaxed/simple;
	bh=1TPhquZyrDsg/8FmLZ8aCOz6NH5qV6X5E4FJyHTAVuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLR747hoJ3WpTwh8jnrilaEIqA9tufdlCMsF+lOcI86N9eNx0ngt+CbbS7c8BSR6nZgENY9Plfz3nPkVWPG9XHntTxVcJdakroS3yzNCjEXzkzE9HwIRWoBXbJiY0Gb6URRDHrNCRaon/NoPWTcePShYA3hvJyir8vZpgMVNaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHr97iXl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHr97iXl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265SV52088950;
	Fri, 2 Oct 2026 08:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nUd5Qa
	4PVlHTnYqhMPbeUzIHXXl+Kv/MUthzFTgO5wk=; b=aHr97iXlOwTTuWwp3AHcyx
	Msfl5ViH/f9Wcs0h8DpQIH7TvWi/R9G59ek2XhdM/QDlkdxOSbwzjD0eujTtJGtY
	q6g8ZhosWvvYeLXmfY9gfYo7SZ1jRh+KZvyV3tIHxb2fQnUKu6WOMDZPqYqIpsuY
	V1INti84Qx8zjlI1TV1TX9ApUmWLpkCUmOhrE6/UweJtEG0cgwzk6FG5HhWwHD3M
	9EvfmwALzm5GLvcKQKDWTOe5x1vMBbFF3D7AyVkYdr+U9IKDljHLxtA0OgiKD2tv
	IR2toVuU50E+R+sAkgDFrXmG0ShfFbJfSgXoWHeX64rcRl6sO2o+iO9nRvO0l/6g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrr9fd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:48:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925ldcJ2090422;
	Fri, 2 Oct 2026 08:48:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk12577-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:48:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6928mdCk49021276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 08:48:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D78BC20043;
	Fri,  2 Oct 2026 08:48:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 459BA20040;
	Fri,  2 Oct 2026 08:48:39 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 08:48:39 +0000 (GMT)
Message-ID: <885ec96f-c352-4f9e-bcf1-f8ebabfebbbf@linux.ibm.com>
Date: Fri, 2 Oct 2026 10:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for
 KVM
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
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261001114605.4167fa97@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNCBTYWx0ZWRfX/6KEh0Kg7vQZ
 Ejn42GXe/R33AVdqyrtmqDg6Bs3RQRqwR6dQs9GlfkCgyWT3C8Z6oTZMr8eUwtCNentJgx7E3ur
 SAy6mX1uBr76eH3Of1kfRej/nutxNJZOyC5XAxLpINXFnfN5540M/Ikt1N0YzD3U7OVrzkpewFh
 BvRcZJeBKYnw/pvZxPWwDWmHIaiDRNSlmlCZlWAVUIXdykqTI1pR2gvNUtBxdiUcwL2vc4IRdGN
 fkb57j6zdDnt1FotsentXLWl3JbdfQFRVUCY/F7As+oRPjYIAV6HeHBlM4DN9dNRi5GtJR77HDx
 VVOJW1tf1waDqywTsynEuiGcn4lWw1vJfgoWn/PznJTcjPlH7V/n0ag8+bBBGPvQcW99/4U/53Z
 4zmX0e/2QL17ST10zTPTPI8ZBzd+nnXj8soF/OX560gQ1pdGAjJY8t728WEMH87YAyxAIu40bKi
 0h/8szBQzyTK9kIVrWw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf6fed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ob27xsy4tWdsBe0VFbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 64O6DfnnpyIPalxSFbSOdln8eaXMudiH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNCBTYWx0ZWRfX7IiNPD8xQvsv
 Zv0zRMMe/2BshVYwBqqSFZa5hKwmxLq1fJ9e+12bnT86R/I1wmM4aGyqBSPvrkuqdhDdz2Nrtx+
 87EQD77EfUt8569tPQq8XI2OAKEQtC0=
X-Proofpoint-GUID: 39qc0EAb6yRVTfJfZo3I5-uWmZ6ohE1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020034


Am 01.10.26 um 19:46 schrieb Alex Williamson:
> On Thu, 1 Oct 2026 13:59:49 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Am 28.09.26 um 15:07 schrieb Steffen Eiden:
>>> This series switches the KVM-VFIO interface and external consumers over to
>>> standard file-based reference counting, eliminating all external KVM symbol
>>> exports.
>>>    
>>
>> Paolo, Alex,
>>
>> I assume this will go over one of your tree? If you want, I can also create a topic branch
>> for you to pick if you prefer that.
> 
> It's a KVM focused change, vfio is collateral, so I'd defer to Paolo.
> I don't believe I have anything pending that conflicts, it applies
> cleanly against current vfio next branch, but a shared branch is always
> a nice hedge.  Thanks,
> 
> Alex

So I
- applied these patches on top of 7.3-rc2
- removed _safe from vfio_device_get_kvm_safe
- created a topic branch at
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=vfio_file_reference

Paolo,
unless you want to take it yourself, I will merge this into kvms390/next and schedule this for
the next merge window.
ok?

Christian
