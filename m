Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439046;
	b=G4lpFfJMNlNUMdg9L5tGv50I/JxoyWRczgccBuPGn136lpmv8ePv4gqj9F+OXh8/WbpQ
	 4QUYxa245IJldxtE9t1QBfP5KrDw+AoM6MMDdKvzhVK29aQRonrDPEQR8pU5OxHxNVvs6
	 8+hNDnz9syPqTpA74DnSAKeMIQD3oxtrF0RgbMklLPtgZUtDZVEh5NizVvHkyV/h3ajeZ
	 aWdaeZItm6fJ9aCVPrcXukfJOj0RS5m9DtRg081TZOjY7z1eB2yUUoK4GJuKcTeT6oz1s
	 mDMPtdLWN6ywJ7O0su44e/0wOsan1T82aTeHWIAaSzOAnDv+9lg15tifFefwWq4dvlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439046;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J0aNMZGjkaYlYlEiIOgyjzZ61GdzrSA7YGjz7yiOd3U=;
	b=qSZuf6uvvkKV3vmsoJj9QEaw39o81C8m/z/MmAuyvttRzEsgrK5YKOrwzbT6XJfWdkeS
	 96hrOx75r0zKudfabKKYh3RmOvfQGqO+zqg8QEI3ksh9kYockFZQR60KddivNb4nJOyMy
	 WBjcOnnPij4wAVkA3Eavr9UubOddhf7dxClKFxctrEvIt8RifKnqBBlw4sXcl8/hQg1OX
	 3lnbPYD5BtS67InvgOuRJrG3S0XkCR9ByZMe+opXa/qZIKF2hzYLIZ+wuNdQxzyekprO7
	 dqqnQqSFxLg7s8/hG4QeuEy1BtvhIvqysZIZIbXVMibtaOE0j+knWPrAyZDPcrlJtXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjTI2dJm;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34806606A31E;
	Mon, 23 Nov 2026 13:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34806606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VjTI2dJm
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCYj3T1981047;
	Mon, 23 Nov 2026 13:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J0aNMZ
	GjkaYlYlEiIOgyjzZ61GdzrSA7YGjz7yiOd3U=; b=VjTI2dJm//EAKkyyho2DMj
	EXrNf6v0Fu6HhoD091/wzB6L09utq7H8gLgPv13AbelCBhOAklDr9XH3zRPX5q3y
	wVO5ZP8p/5fsbtfkOiRaSgKr1fOADk6DpmJEegQnp9nms4UymzaGSHnbDY++LXNl
	MIscfkC+eyyYry7T0X98C8DugoOmM5T/nXDmyB9chP11iwEbjXmBPXJHLxj1Rrn2
	IF4fgDbnk4HG1v0tzJ/zcZWiy9YVUyUtlLj3+WtmcfPiqPSVItG/kYyXPtfemVE5
	ga+2j95il9jnfIjAs1Krng+ORKkcu2KZ7WhBL0S4+mTv/EFHEF65y7/WmU5T2A2g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g338qs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:03:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJhPr1159476;
	Mon, 23 Nov 2026 13:03:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vf022-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:03:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AND3jl846006742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:03:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E379B20043;
	Mon, 23 Nov 2026 13:03:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A14A220040;
	Mon, 23 Nov 2026 13:03:44 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:03:44 +0000 (GMT)
Message-ID: <e53eaebd-c646-4d0e-841d-85ee7e7997d6@linux.ibm.com>
Date: Mon, 23 Nov 2026 14:03:44 +0100
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
Subject: Re: [PATCH v1 0/2] KVM: s390: vsie: Do not overwrite guest 3 state on
 early validity icpt
To: Gautam Gala <ggala@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261119124936.33396-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261119124936.33396-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b0439b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=3ZShRkCcaKa6pm3BFBwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX7WbJ7BilDQdB
 E6Ug33bXH4570ZLv5OFv59XGl/Bol4cPTN6H2lM5EAWiurxixYni3uzF3+wie5nFGo5p4X2SQ7i
 TmKMUUvFkII1xC3hu5ASNAbkSobfJfg=
X-Proofpoint-ORIG-GUID: z6wCqkl77eR2fopJWllk5PdBkRYQiBrK
X-Proofpoint-GUID: ORYwrD87rb85BxL1DCezvEagYpRKHL2I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX6oRkM5URu3gJ
 dFUDU4oo1HP6I4Pi7eLYpThcQDC/SpxA1tDhnw9yMTZRY0IlM7dfFtQoGnrGNel+xT0DTYnPcgw
 FDO1/U6h8BF9evulwdsFUSD88zX2flZfP/QkuRelyUmMrrYxMTrb6qWLBKExeKIQUX3PybDxuWX
 +6aVrOGEtH1/AJ83x9wjP+v2mox8MS3KfS0KWNYh9Ch9DWXCa26Irgtihwksr1q/mTMYxySWCO2
 jIlyKv085s+Mt+WZ09Wfh8caszE1yULYFs1QofPjG7C+/W2+JItgfZLelagSX6ObTzV31ralyKL
 exGdxqKxV31U9AlWMBx0wbS1fIVz5kVXQZhCtr7lc3QTk16QA3i52TZCuk4nVwhFLJ+vZimfWVK
 gFQI2oGgNz18F/vqlFijZN9lzJ5jrsE6qybkLMoHjuMmxylh9ED2ClLSyADHkLdvo/nvVzJoRnI
 Uygnk7jaayLVJD6i1Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050



Am 19.11.26 um 13:49 schrieb Gautam Gala:
> If prepare_cpuflags() rejects the SCB provided by guest 2 with a
> validity interception, shadow_scb() still calls unshadow_scb(). That
> copies the guest state from the shadow SCB back into the guest 2 SCB,
> although the shadow SCB does not hold guest 3 state at that point. Guest
> 2 then sees its guest 3 state overwritten with zeroes (new or recycled
> vsie page) or with the state of the previous run (cached vsie page),
> without guest 3 having run.
> 
> Patch 1 copies back only the interception data in this case and clears
> the stale interception data (icptstatus, ipa, ipb) when a shadow SCB is
> reused.
> 
> Patch 2 adds a selftest for early and late validity interceptions.
> 
> Gautam Gala (2):
>    KVM: s390: vsie: Do not overwrite guest 3 state on early validity icpt
>    KVM: s390: selftests: Add vsie validity interception tests
> 
>   arch/s390/kvm/s390/vsie.c                     |  24 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/s390/vsie_validity_test.c   | 435 ++++++++++++++++++
>   3 files changed, 453 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/s390/vsie_validity_test.c
> 

thanks applied.
