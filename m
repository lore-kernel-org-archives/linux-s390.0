Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074E23D7FC;
	Mon,  2 Feb 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046549; cv=none; b=evF+ocHcvbGGrwx2GfKAyMQjB2JLeayKq1rw8YP0XPxMeaPM8G/OYgBQUW99LpmzRBRW3XojpLs4TRXNtl7vsgQqew81cV9ioSjVpgLWd0ByO1esNGlkBL5t+CKAW6LfYH9ZsSLvp/y/7wv3WCOkMV4nhNuk7vaJjZNr1gK2flM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046549; c=relaxed/simple;
	bh=JSV3GkPQFWTvQDoMtc9vQalyIuWccRoO2J2Vlt7ee8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8ZPDJPS0PVvDsmkmNcmyei0m3am27ChDJT/PxZUTEy+TVPflokiFyWefLIv1RxxEmVUc9OurvyUcUyQEYwv90IfQyNlwPGIDi6rdkJ5TMFBBgevq2wT8lZLvLu84Nvb3qjYK35w9GTfvQk10rSsnTtexrR4bxz4i6PIOYMGyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SnFVY670; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SnFVY670"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612ERMpu006538;
	Mon, 2 Feb 2026 15:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+bNH8c
	8azHGqltgCQV3/8XTF0YASLgikDm2nMiipNE0=; b=SnFVY670H9s5+S5EEGaSvA
	CA8aR30PKPcVrhbD4iqSwtfqioebXcchmCOJ1b7ZkHbvkuG3sg34fwTr5VGdhAxH
	7nVNu/+iMgBqVDWRxMdR3lSaa69Xg66AAvOZMh4nlodjrPHGxR+AsQq046cj7x8N
	eWnnC3sqR+h7By4oKImBDvWluZTQDy4uJXtQBdpKEp3RB6/OJ2skB0tfHQ/T3lCl
	y0ga7OXZRQTIqzz8HL/I4rt+dK7MS80x5rS1MhbuaKW+4gkNCM20ubi6fxJwM3zN
	Fy6kInoqaM/9kbY+PcmVtiYnw5WqMIutP0UyBGptCnW6xOPKe/3aopxXgEo4X/YQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gqmub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 15:35:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 612FZYXC026409;
	Mon, 2 Feb 2026 15:35:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gqmu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 15:35:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612FA3iu005938;
	Mon, 2 Feb 2026 15:35:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9j5c6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 15:35:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 612FZVAB30081728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 15:35:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D862004B;
	Mon,  2 Feb 2026 15:35:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 566EC20040;
	Mon,  2 Feb 2026 15:35:31 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Feb 2026 15:35:31 +0000 (GMT)
Message-ID: <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>
Date: Mon, 2 Feb 2026 16:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260201072309.222155-1-rdunlap@infradead.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260201072309.222155-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=6980c446 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=870lcERhYe6XzqJw7_QA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: eYdBFQ2MAJ_pblbNvaBPYQJY-0S9WFLx
X-Proofpoint-ORIG-GUID: r-y7vermKIigoHM0DSEUBBdDhV2CK284
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyMSBTYWx0ZWRfX/9qiXIyf3Dze
 tLf7RiqJ+EVCIrJN6o21BTgnZyWh9VKLi0aBKd0fIJOTIj5PK6QLMA63JMyUn+Nb9uD3ChxjSsP
 W+twnyfbHebOODtHGgTGsRheFQA0/2d7NcOBGhnK+0SbT1xDSOa5BdLUHIpP8X2Z3UmV22oAk6X
 sgtbe87mryUl39QyBDrYM3rMXT5/cVcMkSgJLvcWMeAyzWD81T3acFT17Sk5Xc8F+WyT3QtJyaW
 yUhXavCTQZ4IPBQfX7+O820UrFIDJyyaavV/jsaE5tDBu7J4W/X77GrqyBKsfuimrXQBmUhIaZu
 CIkEdZiiO6eTiQsVmMGjYbZyP+N4djx2BBnPyUY6l/iEqH4lgmXJycWeUrOr1V/paH0c41R8IGo
 wXKq7A+glToNlq8ZJCb8pdfSqilINMYd3gtKkJVDJrhnWtnuDu7aMX7CWF9pQLR+TAQuVDWaEw+
 bcCPm3myXd7OxaOh1Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020121



On 01.02.26 08:23, Randy Dunlap wrote:
> Fix numerous (many) kernel-doc warnings in iucv.[ch]:
> 
> - remove kernel-doc on static functions in iucv.c
> - convert function documentation comments to a common (kernel-doc) look,
>   even for static functions (without "/**")
> - use matching parameter and parameter description names
> 
> Examples:
> 
> Warning: include/net/iucv/iucv.h:210 missing initial short description
>  on line: * iucv_unregister
> Warning: include/net/iucv/iucv.h:216 function parameter 'handle' not
>  described in 'iucv_unregister'
> Warning: include/net/iucv/iucv.h:467 function parameter 'answer' not
>  described in 'iucv_message_send2way'
> Warning: net/iucv/iucv.c:727 missing initial short description on line:
>  * iucv_cleanup_queue
> 
> Build-tested with both "make htmldocs" and "make ARCH=s390 defconfig all".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Thank you very much for your effort Randy.
FYI: I had to use 'scripts/kernel-doc.py -none -Wall include/net/iucv/*' to see the warnings.



> v2:
> - correct verbs in descriptions of 2 functions (Jakub)
> - removed duplicate kernel-doc comments from the header file (Jakub)
> 
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Thorsten Winkler <twinkler@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> 
>  include/net/iucv/iucv.h |  209 ------------------------------
>  net/iucv/iucv.c         |  259 ++++++++++++++++++--------------------
>  2 files changed, 128 insertions(+), 340 deletions(-)
> 
> --- linux-next-20260130.orig/include/net/iucv/iucv.h
> +++ linux-next-20260130/include/net/iucv/iucv.h
> @@ -70,7 +70,7 @@
>  #define IUCV_IPLOCAL	0x01
>  
>  /*
> - * iucv_array : Defines buffer array.
> + * iucv_array - Defines buffer array.

Did that create a kernel doc warning? It's a struct, not a function.
I propose
+ * struct iucv_array
like other structs in this file.

[...]

> @@ -757,13 +742,12 @@ static void iucv_cleanup_queue(void)
>  }
>
>  /**
> - * iucv_register:
> + * iucv_register - Registers a driver with IUCV.
> + *
>   * @handler: address of iucv handler structure
>   * @smp: != 0 indicates that the handler can deal with out of order messages
>   *
> - * Registers a driver with IUCV.
> - *
> - * Returns 0 on success, -ENOMEM if the memory allocation for the pathid
> + * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
>   * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
>   */
>  int iucv_register(struct iucv_handler *handler, int smp)

Before this one, you changed /** to /*
after this one you left /**
That's a bit inconsistent.





All the fixes look good to me. And they get rid of the mentioned warnings.
I appreciate your approach to use the existing wording, though it may not
be according to the latest style guidelines.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>






