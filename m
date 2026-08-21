Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823EE414A21;
	Fri, 21 Aug 2026 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341292; cv=none; b=ry8BJiLalPEwPaPvP6JY4FDLVOKR692IWTE4FpyMgWDv+7imyP1fv7H9P18nizW41917yZGYdKvR8l1hvLbMOYMtbDkmWzForPgD1HZJDeTNyOo1gfalgBbAUc61mVI3ZPaEHftUxaQ1JIkJrpFn2RP/83xnl7JBmkYMyDmAUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341292; c=relaxed/simple;
	bh=SMso42hd+frfuXR5H6F5iiFt3RWLQjWskBwH8B6nask=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YCo77j6RD8eR6FvVCVnTu7ILf7cxg96YeIBItYkn2Q0U8LZyElEtBlpRF++mHnQRvSSFftX87+5sNkwmayKimAiSURE+t8b2Tt5pTnCxCVkhXq5bBNPfWK5861GonW3P6DtWaw0dmWZ8G9rYgeO75M1DJH3ZHRacWxXcJ0rneLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FIAiMlbm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FIAiMlbm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVt3j2315324;
	Fri, 21 Aug 2026 19:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fFOEC5
	Qp6Y0AsYOgNN88oD4YS3GYVMoVGB4jXLvKG74=; b=FIAiMlbmTPDj14mmCVIvy3
	Vpap1j50YnjjtfRFCAZI3HRlTgR7jcbRPKhGDDyieR2pFqaMASbMmnoZ0eF3j8ql
	OcSDW3wsBOIi2X8AXOs7O5R3ph4MeTjCAprYDJNw/7srPNw6x4vu7KspDxnjYuys
	bn8R4cL5jfBGzNQiWEa9geM6RTpZVihpCX3bGl7RFi0Q9bPILJaJVcJaaJ/VRWQv
	AYidL9LB5OrigNsr8uRMOloKQjkwcGnHUqQfEWtGHESEL9Plz7KB8iFLsoC4jxSj
	BVxC1AXFm/PX9p1pfrA3AXZkyPQL6PfIkt2IM/Echafkex0LX0QwSx8Zjy4YnJMg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ur7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHLp023485;
	Fri, 21 Aug 2026 19:41:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpp4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfNOs48234790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58E5120063;
	Fri, 21 Aug 2026 19:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0529320043;
	Fri, 21 Aug 2026 19:41:23 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:22 +0000 (GMT)
Message-ID: <59c6b807-03c7-432b-92a1-0bfe1742411c@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 12/25] unwind_user/eh_frame: Remove .eh_frame[_hdr]
 section on detected corruption
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-13-jremus@linux.ibm.com>
 <20260818151058.D6E9F1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151058.D6E9F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88a9e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=dw_N4WaJLLYh494Sxd8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wdQqbYKywM_rN6dD9OWLAYkQHIqcYdLN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX9A4+2r2BTvxa
 ewQSBy0YcTUNDeWXPxJfnnk7Lxb6nTvpmuomoujDzYUO6+LekhE6/N67Unb7vP4fxtmdbbYmxKp
 J90NUDdKm4GaeMZ/Dem0CoTOoLPfDI4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXzUURSPBEXUIv
 R8zszJH3cyQYcbzhFb5jWryvjd1kmIYLoP8fiIWU1YvBWyiIEWKWeAeCOjy/r8raLrL/r3Wdcev
 xYoGFUnB3VS2ZBgwabyB0OLnkbFwlhdihF8druPgBfPZsaTzok62O7N67Hki/75P+ljTRzYgHZX
 tbIgRVv9nVklUlOGEaowK6RP6b7/W8YjEVZfnIV04vpXQxDCef6T0rgxRsHP1EJTODP2d36Vnkb
 Wfw2+otD8A9T9fFOl4JRZo8wqSyk+XO8gu6Jz717qrLsBhJNIaC7zlYJyFNa/ULM5kBa2EW9plG
 FgNgDn8gBkLv52/8SZDhTfZuk1L5eh6R+zvb0Ipr/6kTlYMPcS1x8msYD6BYpE3hYDF2cWzbgDl
 2uHYZZfEGKmuun7HZ43GzJXtB3GdP0IQIyYt5E3ksywHZIzEIAxqOYzt9ZHhH9Ad1JsDh7jlwL7
 Sz5CmRb1MqdpT948dbQ==
X-Proofpoint-ORIG-GUID: wdQqbYKywM_rN6dD9OWLAYkQHIqcYdLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:10 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Lockless maple tree traversal races with concurrent in-place updates due to missing MT_FLAGS_USE_RCU.

Resolved in next version of preceding "[RFC PATCH v1 08/25] unwind_user/
eh_frame: Store .eh_frame_hdr section data in per-mm maple tree".

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

