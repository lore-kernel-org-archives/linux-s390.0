Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276721CC5C;
	Fri, 19 Jun 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877117; cv=none; b=bFFEYUd59gkDM4qjgNuZ4MjobPQ+jRJvA7dIQodhfkhoOG/3tdYTHBzAS37LHsOhFlUt0OUUwYLxZK6lR6LUxdN7XTW2+XzvWU7GQ3mQctRHzG+ZRxmcfVg1WOO1K6Owil8xojdgMYMFHV0SeyV1l0yfGQaOIXLS5K6cz3rM2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877117; c=relaxed/simple;
	bh=EzBZJ9qeG1H+CBmwDylZnbgn0rtwsHQTYrzQKYU5w/M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPDL9mZuKZFSEvGh1xPkYCr4DBjIV5QkrwkIBC7cmYuzu/1Zo6E0XeElWatiIwUhLhnZTke8dZFMlX00Ryfs0ygYyNmJLp2GFQzscBTY9yf2TnnhuHRK2raDNwdWcc7EmGM71OcBzKqIix13OscL0LFyQswa+TDOJEjXBNEspxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPW2HbIZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPW2HbIZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIWHn2543348;
	Fri, 19 Jun 2026 13:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7keAmD47ngSgb4sNFEUjcZe2pBbMNw
	OoZa+mFQjvSnY=; b=EPW2HbIZor1lobXzrcHOi3UJN5UbUvIoAEI9caKT+owGWK
	j/jiF9ZGeXGab5Y9qekQM8e9G8KqbNo+5C9SMs8hUyymyYZI0mgu2/YtH+1Pc78v
	pAJlFkdr8LOXE59yCI+V0JtAj02a34bN/HTEmpuf/EHE2UbrHn35OLlRQNgJ8TrO
	pLbRsGhMltptsC4BpIJRAcDFJcQSbqeVU5KPGLeWgDHzU9lV1GK8kdjX9Wles1jH
	Kzcw4gt+RLbwvKk3b8VoRn3zWtJDzo+4z9pQwdyBJPqs/SY0/2lsOs6CymURaw5U
	N7FWrwB6rR+x1J1xViovZS0Zo6d/sYPbH+24XI0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequdwhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 13:51:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JDnawA011481;
	Fri, 19 Jun 2026 13:51:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17293w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 13:51:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JDpeao49873244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 13:51:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D37BE2004B;
	Fri, 19 Jun 2026 13:51:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B6920043;
	Fri, 19 Jun 2026 13:51:40 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 13:51:40 +0000 (GMT)
Date: Fri, 19 Jun 2026 15:51:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Bastian Blank <waldi@debian.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add build salt to the vDSO
Message-ID: <341438b5-e46f-492e-833a-04b59f41275f-agordeev@linux.ibm.com>
References: <ajQY-s7Y4mNPQfgy@steamhammer.waldi.eu.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQY-s7Y4mNPQfgy@steamhammer.waldi.eu.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfXyM85bi5Bo0vN
 TC/6RSHXj3vVOTlQLwEavhtwL8O9dKpLSFGt5KZKpHSOFdXBDPTxZf7WWXph/EXvcEHOaTfcE/b
 q/Y4tTWg8rgkOQkxoP7qWil+FjHTPW8=
X-Proofpoint-ORIG-GUID: O01hcQcae6FviaSHSesZEXPi6XTBKu65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfX/MkvI1q28dHx
 VGRuVDu60wdECcpU4GP279deGna5EU4oKrl0cRXEQj1Ooh9R3jwIYcxjcGGHVPNfT7Cbb6RTxmE
 31+5TdZPYJWGzN4ydAcJgj9gk3qavQgRF1l4QAH1IqD29PE0Z4wctakqF2ievs3Q53VcH+QRYUg
 vIIMM7cUvUI8+hR8FZCBuISpEO/YBrjwKRR7U+9hTxs02Qb0IVR8I0gMmpT4WplySQlr/PzgM0m
 BZfADK3h/YSX010ev5oDVpPGx8aHteUAXKqi2tlN/BfeDzgntgSeb4nGhXZ/OS+fwUFd0mdvFdV
 /tqidx4zvlqSK86qyZv+AJ1VtELnfeA/Jo8A4n8tHAfOVHUuZIexBaUPjXSG6/VAEjhhqhMkvt6
 lkxdly3WsEDRFy/XwlrXyk9abAMBWW/0tHY7JsOpGWpKqEnlqqFRUD28nAbF/FQdoy7qM2WG5NC
 Z1GzQZaYAVNQjm0/GrQ==
X-Proofpoint-GUID: O01hcQcae6FviaSHSesZEXPi6XTBKu65
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a354971 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=xNf9USuDAAAA:8
 a=HUiFJdqAhgTVA64Inx0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190130

On Thu, Jun 18, 2026 at 06:12:42PM +0200, Bastian Blank wrote:
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>
> ---
>  arch/s390/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kernel/vdso/note.S b/arch/s390/kernel/vdso/note.S
> index db19d0680a0a..d215781f26b5 100644
> --- a/arch/s390/kernel/vdso/note.S
> +++ b/arch/s390/kernel/vdso/note.S
> @@ -4,6 +4,7 @@
>   * Here we can supply some information useful to userland.
>   */
>  
> +#include <linux/build-salt.h>
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> @@ -11,3 +12,5 @@
>  ELFNOTE_START(Linux, 0, "a")
>  	.long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT

Applied, thanks!
