Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104314;
	b=zbLck94x4pq+krFGVpr24zgX4GrGuuzjJhAjGIWxkS+c0ON6wn1IxFLmTU2OorZOhH/h
	 oIcx+mRPPXkkue2lLfxn5dvnEiXWMBSWImDDH/DHBWgoKaSYodrs6V6iros/1CMjE0rPj
	 C5s1dRG0OYGdEVJWkY0oaiSFXWnzujXuRuOC1uDauV0NPzLSWnVtXxW18VcZp9GPRtBAX
	 y8EMYiUWLFQXHGGeYOvFFIfj/xuEBMzJK1wVsz5W3RxozV/SAuZklKuTpn2xO6SNQhsx9
	 8/DIkX/HND5lkujh2f60LwYVzUxodZDVxuRs3yj4St2jnuHp7LrwfbiJteCCT3CS4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104314;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kveJN3/jod4XkmDJmHZz4VCE6cpdj2LRPjXi4+APUSM=;
	b=cWcje6PZDKQkk7gD/E49Sr2wHvcQeCzwlhy8bmAJqxKp+ap3GH07O/3UTu6GUFWNsvub
	 QU9S1/EYopU0SI1woUR9kWQRoDV1ar9DTJ1LF56WAo/2T+51nOkkk+m6b8rsgHGbrB7/i
	 Uv4W/bw5J9oZ7FX2oCWM+GSM+pJNPo4hWOlpCCc6smloeGarj9ZeVCx/1xQNBTBd1kbJ1
	 9rUmqOJUcUmRnyDkEz1uNE5lS4jgb7v8KLkpmQr9s0u7R5jW43mHRKKJ3g2iHzJBh3iMI
	 5odIPRLW+LBl2wTi+WKfaIq6qRsSh+R6w+UiUjCAQK5Nft3wp8hkkJm8kQUMhZX8WIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tuXrsLIb;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8D606A326;
	Tue, 27 Oct 2026 12:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F8D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tuXrsLIb
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5ij2n4073455;
	Tue, 27 Oct 2026 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kveJN3
	/jod4XkmDJmHZz4VCE6cpdj2LRPjXi4+APUSM=; b=tuXrsLIb111HODH3SvYyYS
	+mhjOb5bFeTYRU7P+LyA3ytkm/VwZMCMv9u/wMHm5DYlzQXl3DoR+tjhb1JtsLSN
	oFMLmZ67mfmZvf+8tMLWmL7ZuzYzlc5V7LIjwgXGum135YMqCldi8+bgPNp4Xsfc
	Upy4Avyq5lArqfgm4uqTyBiQdWvYVshTRbT5M3sANFfpBHX6dYcFe58fi0TCDtV+
	vKoFfDBnfcrwXbjNsOeJb+JxLdnFlbkO9ixneIwLpwroPTPLGyitCICwnXwEnFSY
	eWIVxxWwsB30iCWfgWT06gOvgmu06bPZ5bQttcvUv/obyPC9RESsFUPR4DQAb0gQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsya3c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 12:31:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAenfq3687775;
	Tue, 27 Oct 2026 12:31:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvjs50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 12:31:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RCVWxC27722022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 12:31:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC61A2005A;
	Tue, 27 Oct 2026 12:31:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE0F20065;
	Tue, 27 Oct 2026 12:31:32 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 12:31:32 +0000 (GMT)
Message-ID: <421ebe63-dd9a-4da6-a2f6-104a9473b301@linux.ibm.com>
Date: Tue, 27 Oct 2026 13:31:32 +0100
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
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <att35ilyLvAA8gM4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX9jU55l5tC0ou
 DwPP1OcYJme62E+PbeSmQJ5c1LyabEa3Ab6yWtCUqde1EXBS8Tabuj2FvoWHJAqqyInykdwl7Lh
 Jo/KYASaQ/WVHEkEd3oHFxW6J4n3HmiztwcNYLcYFC485Yo4rqo3JECy1UwFigaGTFjdfIpAwLb
 0UnFVeTfWQMyxY9FYbi7g+8bv2awJJs7Dcd7r/iqmaU/fqm57unf7L47LxgeiO73XJOMLw8swOn
 XSDb2j0HkqtzgYXnBTTgpuXTFpSS9jgdyOL/MDLnrYtHt73/W/NkV9EDhztXcm66kEVwLlaSk24
 UhhYwBMkpMSme335B8qd2V2oxjYuUHkZtthVyfteCrMql2zqHkk5ISNNaecFJdKK/gAWy7d59z4
 n0PR5pxrxdsUjLvZVeR6v35ZxXjYT7UO62fg0YoLxVVEyX8RTK2Ox7COTxLiF3XHMleuOcTw+/U
 ZuS8qfazF4rt09BqkTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX92c45qGvG6gy
 EmGYlX5bKHWSPiKli+fRRTV4T9DiiQ+p1oUE9xVzbKk4wpp8MA1+GkEjtX4EhtEo5koXlVMCRmO
 D6qlbZBAqdznpUvidugueizGJn6Bero=
X-Proofpoint-ORIG-GUID: SVATyTCUUXodeohhmx9chwGKuDILuDTn
X-Proofpoint-GUID: 9w142X697fcqVz1HDx9kdeoT1c3CNK9q
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae099aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=LyKNgWWw_06KBpMtn9AA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270048

Am 23.10.26 um 17:06 schrieb Sean Christopherson:
> On Fri, Oct 23, 2026, Christian Borntraeger wrote:
>> Add a test in which the guest writes to a shmem-backed memslot beyond
>> the end of the file.  KVM_RUN must fail with -EFAULT.
>>
>> On x86 the guest enables interrupts, and on s390 the test sets up
>> pfault, so that KVM could handle the fault with an asynchronous page
>> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
>> retries the access forever, and the test fails after a timeout.
>>
>> The test is not built for LoongArch, which handles a failed mapping as
>> an MMIO access.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>> I went with Seans name proposal
> 
> Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
> that and force Paolo to tell me no :-)

Sean,
Will you pick up the fix and the selftest, shall I do it or Paolo directly?


