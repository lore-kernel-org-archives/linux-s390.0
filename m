Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778808;
	b=Jm4ZN3krkoV/+tVH0p8HavTHNzD4o6+B5q2RFubv/oXj1ibOdVPdTVjAf6/NxlfoeYGR
	 s/bD0NzQ+VAKD6rW8VXCO/iZ6uuuR/1V2tpY5TRBtgzjiS++7KvRbnM3tRBSELFSaX/GY
	 LHTqQdciBeg6dig2LYGDU+bb4WG8TfytYpR1yIm+VPInxYLdlJ771vLJLG3nUUx8/3qcI
	 SPjgP4rnnxTb9zsRPDtngzzV/OxJCp5yYTJd94Lo1KGILIwmoS/dyU6GMFWrGhExNKaDB
	 rJOIEmK/YoUaAuN89gD67UCiUXMN9dUqoDejagZovYmsCAXObevkXY4YPE3JhqVpxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=boD5RlH8ApXGUznUsv+SqEnFrkMWJRS4tA6AxVcHlxc=;
	b=z3bOXAC5qZUB+c5+Ep89mTZIB2Vi08fYNZGz1uBTxEnOAjVyW6ZBsB+0c48AjHklddHL
	 mG394l8bqKy2edBD78684vdw86sK9NKXAaYtxc8f/j4Q1q+qaHgJ4sptTTgoY7eiSNsBV
	 WI8cIN9uk94gOpf6XaxGpkwQnUgc/MxV/ozsGxpRjmP7b2VX1+u8hEUc5XwKBKUD0xUh5
	 gNcvxpaGt/HoopO8gCYYsff/mRiPJUP+7GvGrHsD9vmF0H4AgOwTj0zEJ00XItzLHEDIb
	 BZlwyCwMjUCmOWLJXsj/09IUcRCQDLVnKM+hagwFRMTHjzujwObu0EGkvJk2iyZm5iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VzyyEHA7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F3606A31E;
	Fri, 27 Nov 2026 11:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VzyyEHA7
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARB4sFu1654505;
	Fri, 27 Nov 2026 11:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=boD5Rl
	H8ApXGUznUsv+SqEnFrkMWJRS4tA6AxVcHlxc=; b=VzyyEHA7Q4Go9plQRPQyCA
	t3gcyzLR98/aMfbDw+SI3kuYzhSnTIFF/nNWze0gZyEWPAg+KdJRpD62w6OTH6WS
	B9zQiTV93+D5UVGnk+CPLysPzjz/58LlhFBJvl445a40ttdcUW3o25ltWLyVaJbl
	UZNvhP714cFuJ/JQo8ml5YYgmpYU/rZl/qBAs8083gMLQfQCntFJOaTsAHkqYN0n
	MWPps+jubcZ0bMjx4tk45narszkq5DnR1+eDvsvAlBgkY1zFSnkea5TEYDLYhLuL
	VS9j7x3zq3LfULBwNwOfLPfmMOYyt8IwQVVIbSZEqYRNct3mfC/RqCJE7l2N5juA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4vmbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 11:26:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAoPxB652939;
	Fri, 27 Nov 2026 11:26:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg3v79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 11:26:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARBQDsl51315168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 11:26:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A2322006E;
	Fri, 27 Nov 2026 11:26:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B289F20065;
	Fri, 27 Nov 2026 11:26:02 +0000 (GMT)
Received: from [9.111.71.154] (unknown [9.111.71.154])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 11:26:02 +0000 (GMT)
Message-ID: <968e660a-2d9c-444d-a4d2-b4b359152ded@linux.ibm.com>
Date: Fri, 27 Nov 2026 12:26:02 +0100
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
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: Add a test for nested guests
 in ESA mode
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Yvan Janssens <yvanj@cyber.gent>
Cc: David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125165604.3074595-1-yvanj@cyber.gent>
 <20261125165604.3074595-3-yvanj@cyber.gent>
 <20261126153745.399d7f3d@p-imbrenda>
 <a5b3119b-4986-411f-a03a-06b411c07c73@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <a5b3119b-4986-411f-a03a-06b411c07c73@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfX5vQOjm1ek2ZL
 s+UVENn/3Au39jAtps8QCVKjBvOoa7rNDZaOXiI00Gqo6s7td3NbXLzrNlAeLaQuQHidQ6MrI1i
 J1f0OAGLlQqwYGJk1lf95Z9teFycqQU=
X-Proofpoint-GUID: uivynPu8bwZQGjlllkqKWYeTVpAaqmXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfX6bxWDyj5lwaT
 shOlb37U2yaFzi3ElHPmql5CEYVxKSIB6kHuZrfbw/YaSNRBdsUrhwfGEx/bBEKU8E91/bzsog9
 QMvG5u93YOZCwHmazBFVNgpHa1LRGCs1zvCZ4Ls15EpXujwVVW6AXuQ87IAuUKBD9NGQr5fM+Y6
 zwtXcJQ/jmnUGCYl+G/4yivKAYDqEJNdzm0uDT1C91tbO7AtbtcwTN3XwolmhN7iI0HsF4adKpt
 qZzVWMNiWt4O+SLsvp1ux0lu+39618kphHfb+CWrFcAOW3D73ZEZ/Fut2irpwxXjko3SDtTd0AI
 M8a8nKLECG1J7oBz3AcE/5LN2dJhIf6xd5qWG470g/DXwHS86Zc0OamcA8BAjiOq8IQJ6/aMmzI
 e5mzt2waJk737uQbtrjluoHRV46mNp6LMqOMqhR8PJidzCRasLDXr9mF+WSUjkHkobvQ/NEs4m4
 AQ4PgSHyv3ZtjGjgIgg==
X-Proofpoint-ORIG-GUID: aok3soQnR9xwrEFU24aJxSgV6A8Bc200
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0968db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=iT8M5YjzDwDgK0uH:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=7tadYCu9qubQoYwvGvMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270044

On 11/27/26 8:56 AM, Christian Borntraeger wrote:
> Am 26.11.26 um 15:37 schrieb Claudio Imbrenda:
>> On Wed, 25 Nov 2026 17:56:03 +0100
>> Yvan Janssens <yvanj@cyber.gent> wrote:
>>
>>> Run a nested guest from a state description without the z/Architecture
>>> flag, with KVM_CAP_S390_VSIE_ESAMODE enabled, and let it execute STORE
>>> FACILITY LIST EXTENDED twice. vsie intercepts the first one of every SIE
>>> entry to shadow the facility list guest 2 designates and then has the
>>> instruction repeated.
>>>
>>> The test checks that the second doubleword of the PSW field, which is not
>>> part of an ESA/390 PSW, comes back unchanged, that the PSW points behind
>>> the last instruction, and that the first instruction stored the
>>> designated list. What the second instruction stored is printed for
>>> diagnosis.
>>>
>>> The test is skipped without the capability, without interpretive
>>> execution for the guest (SIEF2) and without facility 7 in the guest's
>>> model.
>>
>> which KVM ioctls are you testing here?
>>
>> are you sure that this is the right place for this test? my impression
>> is that this would be done more cleanly as a kvm-unit-test
> 
> We are explicitely testing 2 levels of SIE here and one level is a private
> "hypervisor". I think this would require some changes in kvm-unit-test/snippets.
> So in general I an fine with taking that via selftests.
> 
> Janosch, any concerns and opinions?

Yeah, looks like a selftest to me
