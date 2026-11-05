Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865931;
	b=JTnbpJ5UEuyqHkjojtXBuRc32QxmmoChbcRYUCxaF08xNIcH+/08+rLv8Bi3DWY9XScH
	 xGFX4Qj4z+yfBm4/cJ6WGJnHN120/cFDibxUpQmYpIBA/LcNKRKtjpvDOuAf3Xk9Ak5VR
	 SwJT9CcNIAAruGvB62jBr8Xg85DniovA+0eE36ZbkZwAKKNVqEG1wHM2xIdA+0EfhYVrL
	 XdotwxNRuiwvAvSUiz5FkckOq4+2NOTHmaPndQThageAe2LVKG3U/Y+ENiSsHC46vdl7o
	 NBjT63HBkEGTtcyj3V3PMcjeH8ArZ6mgzaibvd7016vOVQ5/aVkMER+kTPGMR+zu4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865931;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MYSf8ihWGmT6xTRsDAY1yG2E8r4J/wsYQllVhJI7sQY=;
	b=ZQvMFMRHFQrm1SQOELTf4gNwBuByN4i1QNcF7U9XviJqz9kdky0beOAgpTFAnVkkMP/d
	 gKiEejBsxNXUI9VDSTRWQ6V66MSqbNPQzQCntZO/5CVm047Sloy7g98jdgUWpf8RE42Vo
	 jbxNuBIhw9PcaNyBq7UUjS5T4+OYqWBbc5ISLEPG78DO6/P2p7W66SORu6gzcAoqXWwg2
	 ly9TuX5qE++IiQnCiNlH7tAVPs5AVvx54f0nqPJhMXIwlIpMYOWI+9fDzWO4m69uf0hga
	 q75OkTqPvGjk0RmBZ+pzMLvIcHjbsQx87i9K4o6pEeDxQM2YwKvt3k0Jp72r99PGeNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gXWz+xyM;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F2606A329;
	Thu,  5 Nov 2026 08:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884F2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gXWz+xyM
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56iEeW1177839;
	Thu, 5 Nov 2026 08:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MYSf8i
	hWGmT6xTRsDAY1yG2E8r4J/wsYQllVhJI7sQY=; b=gXWz+xyMvvHN1k7uPss8Oy
	ybuf39oYOOarHlOxpcHV7npnC3Oy4pc2rAnP0GrP4BLpNR26Kr8GS9TZT+iv2nMb
	96up2LVV7bGJfL7eetJRrImUD2pKDNSdtC1oWWur4vpe6REIjwyeL+Hx5Gy5l03c
	o1UuLDSXUTDs2cQSxTvKLf/DgWxiVa429GnPwuTwpHkc+OF/EKGqcgtkBApqmYri
	Yzm0oBohp8cuhTzSddoMk7/vgU6YCkLUxJUNEH5HKxwbsarWTROHP806beMF36u2
	22/sU973VPE6XFP1eXjp+oy+8Lo+YFy7Qs+E/L4RGtxya8joV08L3keOYIK2iphw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80t0xc7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 08:05:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56ZBcC1234013;
	Thu, 5 Nov 2026 08:05:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6rnmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 08:05:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A585KBe39649732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 08:05:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38052005A;
	Thu,  5 Nov 2026 08:05:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829802004D;
	Thu,  5 Nov 2026 08:05:20 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 08:05:20 +0000 (GMT)
Message-ID: <f32282b5-befb-44af-8f70-800985d439dd@linux.ibm.com>
Date: Thu, 5 Nov 2026 09:05:20 +0100
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
Subject: Re: [PATCH v3 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
To: Sean Christopherson <seanjc@google.com>
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
References: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com>
 <20261023140506.336663-1-borntraeger@linux.ibm.com>
 <att35ilyLvAA8gM4@google.com>
 <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
 <auvVsbpFq4vApW1H@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <auvVsbpFq4vApW1H@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rxpZi2Vegphh2HNxgytCciFbCxyejKqo
X-Proofpoint-ORIG-GUID: R5NcSGLEs4Ednqcamf7zr7YDR5mRZkAn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMCBTYWx0ZWRfX240lZQtnxnf8
 2CT2eWmQnUgLXIzJPj/0Bsgbgf6YYQ1uaA+ETB8qShqi5WtWAeGBsqojM3dwYahWptFdV4CT1JT
 FP/eHQS8UQG6hm3I5kBIBje1gQtgut7GxbFXcQSiaCzdSv0zG8RVJuQjvN9a+yJ/07T/tNAKasR
 lL04KZ7If84FTL5mLiuj37GljvjtHadaH9O7qCn8Zgv72a10wLIlSDQL51jMJKzFZGPsJTFvznj
 TLy/CwhldYjYvjc2ZfJ0boPGfsgteTXk4OrBzYTMTajGa6RFp0JBSjiU8FrPovJAC8yWWnsB828
 AKTwzsyscNWggER9I8fCc2NwttHF6/z7pW1S/n+ezWKEGksSKSCjBBlllx3/6Y4n6r5aIQR8Hta
 P5mQIWO1EyVcCvIF1fQEBjZnQgj2SXMec+mf3O09tlFo9mmTfRVBIoR3HCKlYeprv+D/PKfzL0s
 H8YT5+AeNBFjQBIQMOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMCBTYWx0ZWRfXxstCPXk4dJeG
 icULEHvktvN7jkF87KVKwFgtLVzxuQZpYvkSVB/kf+wX0FL9TUhOXq5f9QJ+WW4azYbDsuAthxI
 gwOWszytVn3M8a1aIj/cmUEIdWsNOTs=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aec38c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=1d9LwUIU6U584Mw3tb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050030



Am 05.11.26 um 02:02 schrieb Sean Christopherson:
> On Tue, Oct 27, 2026, Christian Borntraeger wrote:
>> Am 23.10.26 um 17:06 schrieb Sean Christopherson:
>>> On Fri, Oct 23, 2026, Christian Borntraeger wrote:
>>>> Add a test in which the guest writes to a shmem-backed memslot beyond
>>>> the end of the file.  KVM_RUN must fail with -EFAULT.
>>>>
>>>> On x86 the guest enables interrupts, and on s390 the test sets up
>>>> pfault, so that KVM could handle the fault with an asynchronous page
>>>> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
>>>> retries the access forever, and the test fails after a timeout.
>>>>
>>>> The test is not built for LoongArch, which handles a failed mapping as
>>>> an MMIO access.
>>>>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>> ---
>>>> I went with Seans name proposal
>>>
>>> Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
>>> that and force Paolo to tell me no :-)
>>
>> Sean,
>> Will you pick up the fix and the selftest, shall I do it or Paolo directly?
> 
> I can grab 'em.  Were you hoping to get the fix into 7.4?  It doesn't seem super
> urgent?  I was leaning towards waiting for 7.5, but tagging it for stable@.  I.e.
> give ourselves a full cycle to make sure we didn't miss something, then get the
> fix backported because I wouldn't be surprised if people are hitting this in
> production without realizing it.

No, not super urgent. Might not even qualify for stable.
