Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711393;
	b=NX1I46VrErh4Z22bGIByMIF01hoB62fHLjcNjs94mAv5+HZk1v87rj1+qM7RZx3IUexY
	 PoBILvUA9OCF+eS/uUze403H4nQ8kL7s4+N6Wylac48+qLmZ/LbKC9sd3ASB/ERNw1fwE
	 pD/MvHlqneLbymhBxNn12sLW39DvaAaKiw25+dmXTDrXTXcv5Qgd8TrGx6pvTLMgMGRzT
	 6wnBuySezw+8XOg6AuCIg3dgvkMKebdloTq7ekdAguRvfVaaaNn/8m7nq8GIn5sHuQ2yU
	 tXfWB2N9QOiSgZUjBZ9PIJJML7f3PU1zdv3OafXyYNmjgg8LpQmoe/gyWKVR5xaoj5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sZR8lQcMGraDhkdoJzR/QZ8aEkoOjBBgUzaHejKUy7I=;
	b=vFQCBgE9fCgz60SdaXQwwz+OU+nbFfRnGs/okiZ3qGm0xqVsZzwCMVfkroaPyvfaYrmZ
	 IaLWpQZ0UIZuQoRqAYaLsSuHx0/SayzPBAOTE2ZGUm/AaaAZ6QqAysi8iro9gAAEcz1Jk
	 K9VDcF9bz2ghrE1CSi1ZWgVAgDAUWVcTFkW2g2ZDmo23mj+dTPczKxmxS5svLAqTGLXv5
	 E1+UsMaSXrzynvsqIwahmK18YC35iIBavwAIwdnJO7EuU9a+4+LRhYFMjaBx2ciABxhoQ
	 rF/FGZnIXqqcUQSnG8kExqHtRfL4THuUaovzBCXR0sAAPw5ejz0uZPhMVfwMgYrROiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Slgr5sIm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE0606A326;
	Tue,  3 Nov 2026 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98EE0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Slgr5sIm
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CvLpi1857001;
	Tue, 3 Nov 2026 13:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sZR8lQ
	cMGraDhkdoJzR/QZ8aEkoOjBBgUzaHejKUy7I=; b=Slgr5sIm25tB5PJ38ZX/kx
	bmk12J3/OvDNZuZOHbjmaXBQF5b43evcd4jEmQPg66+k75OtQHBqqZNl0tzOaump
	lZotLovvBqMlXJ0oNWBnudOZvcNIpc2v3iGXGc+Xnk2D6fCAaShn6x/nX2+VnvXl
	j3FyDVITyr4F+aSatTqkj/tdGPzVSMwxu6GjEqZ/0WWWDXQ5bNA5qYCt2AEOlulX
	UA6qxfgsKD/oc5lH/o9p9pHKILfgF4nVlaXx5zKY7wN0W3Gjv3/YQtZvk1Q4rwSl
	+pdaeTxl2h2ydpFo+hLUquQTr0IdsMYZPD7uzCrBk7AkyyMUlppjFD0C+YC4gtUA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrwhac-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 13:09:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CntCS2590171;
	Tue, 3 Nov 2026 13:09:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gtd8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 13:09:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3D9ehX27328994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 13:09:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1206B20043;
	Tue,  3 Nov 2026 13:09:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6DDF20040;
	Tue,  3 Nov 2026 13:09:38 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 13:09:38 +0000 (GMT)
Message-ID: <92343a49-558a-47e4-9c32-d38bb542b791@linux.ibm.com>
Date: Tue, 3 Nov 2026 14:09:38 +0100
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
Subject: Re: [PATCH v2 0/2] Fix error handling for async_pf
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261020175818.375700-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae9dd19 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=23bLTTNykDBGDK2CfWkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MCBTYWx0ZWRfX13BfLU315MDY
 wtK24BAbh/v5yBOvtuoVJ+xHiMq5VLdfiBLgirwh2J3jgv8MNjmMEjUb/W8ej9FSprDXCqhVxD1
 caCxt6W5yk88BERTQJ2aJfbxwnI0V1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MCBTYWx0ZWRfX3VTl9Z5ikP2R
 2WkmHKJFmbIYbi2EqDGvvkdpG4CI1+AuqJNHhlzDsKD2Dco1N+y7rZcypbta2yR7meoKn1uZUlV
 d/O0R/D+z62zGd4x1RywXQUm/TKmLiuXDWKx7V7WFfOlJzsWrjI542ig190kaDs1KciNAWdIClx
 VgGN8MA3KwAhMbpCVDqIaAlT7ybb+zcBskssZj3lELbxKCeyQAITQ2e5i7nnh9cRfAmjgKFlgwP
 0qpzpzXa93LflJi+1y4mkiE+P5oXyJC6QjpXyIyAJJDMYtxXvJ+03fY4kcyZ+h20w5SGz/m1GGe
 YJ2IhOmqQYH4UY9YlACTiydLoJtp6zeOTefS3SGM2/H7jlgJ5+MlDI9+Vl1FZoeVcFLBAZ4up+j
 EZOQulvaRwqbh44P/6vT35nr3Z3ZD7PX+PO1UcrXrIvlPnCOK9HT0LmVmD4bSZUTcji2nzEzUZ6
 uDBQ2wA0TJSHZv98Cmw==
X-Proofpoint-GUID: 80iC0ZeJR1TZFjDn-HRo8HzzVeV7rfHP
X-Proofpoint-ORIG-GUID: hCJfNKaRXEpryl4ldmq4KoMVJTBVsUVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030050

Ping?

Am 20.10.26 um 19:58 schrieb Christian Borntraeger:
> Return mapping errors also for async_pf cases. Otherwise guests
> will loop forever. Nothing critical just missing error handling.
> 
> v1->v2:
> - !npages instead of npages == 0 (Sean)
> - new block comment (Sean)
> - fix testcase to build with 7.3 and 7.4-rc
> 
> Christian Borntraeger (2):
>    KVM: Set up async page faults only for faults that need to wait
>    KVM: selftests: Test that KVM_RUN fails for unresolvable host faults
> 
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/faultin_sigbus_test.c       | 169 ++++++++++++++++++
>   virt/kvm/kvm_main.c                           |   3 +-
>   3 files changed, 172 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/kvm/faultin_sigbus_test.c
> 

