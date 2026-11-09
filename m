Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217032;
	b=KjsSw0FEZJkWhXlfLve9ruUyF8OhzdlSIZZhYDYTfrGoZztz44oDJUu1R8tl9PPD8iMV
	 hLRPhSs3LHHAnGABIv/mCLDxP7tKwC4npYPsOefxWP/cM/NdHKV2MVvot5wdwJ3FdAQhY
	 QWni2zDCRgndHnTbbys6LKMxnj2y98OshXZaraNu0fQo+fzDRGVG0HUdDOwvnJONYkKps
	 48ek+CjArr9BnKITd3CyupGZpPoJDDUKQFRmapIYaSK4gCsQhDK3EpI9oO7ddr1zny+xg
	 Hn9My+LAoDrg7tdWglRV4Z9PPit9pQ7D5gK7CSEOcA3qC0IPYbIQLkaUewmw0rBDA8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=J/iWHjF4AaECsofrO55BbxAn0Skq7FK30tduxXxCaTk=;
	b=BZduavWIH6ZcOST6uFePH0Xvb50ho62McwmwEPQ5vfd07GHHLzWXyrpQcG9E5cbFcHFK
	 vznY/ox/HXsuWEHlouJq1upP4vTK1iUDUlPRLx3OGn2ZRf3JwiNuLbej9gHZuyt1rzW2P
	 KKaevMLlGoHN4FIY5Nce4xSWyOQbtkZno2hTJDhP/OIpaqrF43cl3mGZqvltAhNRy8F67
	 Cw5dacFdMxnltfTIDhUUcZ96TgKyNn7vhOvZRHY/ulHo84RIdriRh1ib6V+UILLRkVMXn
	 vL4G81moXSo4GSh7t7UNqcZHpw8PHa83asbFlyiTgCVElqU5+76pv8WBjZ/D0JV7o7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Pqhb/I4b";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DC606A33A;
	Mon,  9 Nov 2026 09:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5DC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pqhb/I4b
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96E6cs2811988;
	Mon, 9 Nov 2026 09:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J/iWHj
	F4AaECsofrO55BbxAn0Skq7FK30tduxXxCaTk=; b=Pqhb/I4bXhGbEn6MEAII86
	WhqmtXuYLET/8rSSM5RK0VSU3wdN79DNSBFTlE7OUIOwbH9oBNu6IIzbKMsSDfoM
	/WKAcwOWKZrOZb33BoBo7sIxdjjZQWvQO0Q6QEyHmjQM370PYJLdxshgZla7bzYU
	OTUUIWlinUscx5P68McgwruAK3EwhcNTkZGy6N5YJxQ28BTDJxisAGlnBi5mf9Kr
	/UFzUI+NLmiM8xBRQY1ENZ60dJXWny0IUylS9RGK17JhU1K1l9Wyo1HvcjM5cxcq
	Jjt3DuxIGQ9gGdIW7IrCz4INDUFmp8uGWXfXcPQstF9eE4UKdciXYHkfCEVHM+Eg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5v4n3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:37:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96K1Gv3836718;
	Mon, 9 Nov 2026 09:37:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xxk8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:37:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A99b54r30802418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 09:37:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 553102004F;
	Mon,  9 Nov 2026 09:37:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC7932004E;
	Mon,  9 Nov 2026 09:37:04 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 09:37:04 +0000 (GMT)
Message-ID: <8b6e2c2d-8d05-4bc8-9975-2f3cfb33d608@linux.ibm.com>
Date: Mon, 9 Nov 2026 10:37:04 +0100
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
Subject: Re: [PATCH] KVM: s390: arm64: Tolerate unused functions in extracted
 source
To: Andreas Grapentin <gra@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wj5IxEiKp2N9OM5wJloAWdMTPTe3mUWX
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af19445 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=X7hgzCVrISkdk12EHgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wj5IxEiKp2N9OM5wJloAWdMTPTe3mUWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX+k82D7/5GvHe
 d2hLvDQlAb33k681lFPGYrDCKTnlBS8i651ZC/C+VVFueKdjhsn87Hhbw0shZITpUIqtioIp0ep
 GX1Vz7mRIVK384At59KU9Sh9tvbZoYdw8iaGk5sGFWuQ5T+3DYn1yL9Zu+VIVkkzUgCEvnlIbc0
 RFBcfT8LWVndJ70hyRuuyWqBc676mdo01OEEAi1mSKXBh5VbtSt9Vr4tn5ULM0CJtLx8Zk/qU5w
 0vPU+n6biQTQX5ZR9yohlF/K7i6AVv2Pbj8a/Z1yIDgMyV4wFO6a81BfEyJpHMF2a2ISyE6zUms
 SjlYRXgk+e1Y9NgtirWgA3aeCH4tu8i5v4bK4Zejp8qhJW5p01R8Y5RrBOOxa9H48CyfS3KEpUb
 /UDuZvKYp9JTmH+INxNqPllzLqoXRQiRnxrsPDNMckQTQYw4oDM8Rynm+TfCnuwNana7khd30i0
 QWJeVkch4uckQ63Rzkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX1jJxsZDPt5FC
 rfr1xtuIWGHZEc+I4G18QQLPgTip4ho4WiNlQxXsPJPGOxNJrT9IoHZ/8+gVY+rzZmpWFr8LBTO
 s0zI8UxjildpQ0HPwt261aYJgyp/KxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036

Am 05.11.26 um 15:14 schrieb Andreas Grapentin:
> Extracting static declared arm64 functions with no consumer on the s390
> side into the generated sources causes compiler warnings when subsuming
> the generated sources from s390. This causes spurious compiler warnings
> that make it harder to extract larger, more cohesive portions of the
> arm64 source.
> 
> Update the extraction logic to wrap the extracted source into diagnostic
> pragmas to disable -Wunused-function for the extracted block. This
> allows us to share more freely, and also opens up more paths for future
> code sharing with a separation of extraction and definition of consumers
> in separate commits.
> 
> Obviously no functional change intended.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


As you send this mail, I will drop Steffens signoff.
applied thanks.


> ---
>   arch/s390/kvm/arm64/copy-arm64c.awk | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/copy-arm64c.awk
> index 640a7bcb7e23..a318be97c419 100644
> --- a/arch/s390/kvm/arm64/copy-arm64c.awk
> +++ b/arch/s390/kvm/arm64/copy-arm64c.awk
> @@ -42,6 +42,9 @@ BEGIN {
>   	print "#endif /* __INCL_GEN_ARM_FILE */"
>   	print "#undef __INCL_GEN_ARM_FILE"
>   	print ""
> +	print "__diag_push()"
> +	print "__diag_ignore_all(\"-Wunused-function\", \"tolerate unused functions shared from arm64\")"
> +	print ""
>   
>   	file_header_done = 1
>   }
> @@ -78,5 +81,10 @@ copying {
>   }
>   
>   END {
> -	exit error || !found_marker || copying
> +	ok = !error && found_marker && !copying
> +	if (ok) {
> +		print ""
> +		print "__diag_pop()"
> +	}
> +	exit !ok
>   }
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261105-series1-fixups2-8ce6cc54a21f
> 
> Best regards,

