Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8233938C;
	Thu, 13 Aug 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616450; cv=none; b=KIfdxFouWb0NHDWDwxQJSsUgitElJcthBFYbLWCeuzRw+NSwkTTmOrFu8YJ6H2PdL2ANNWCizEnBmLFi8oqCLLwWZcThgU//4Sxu58lej4BfM99QDTT+L3XLBbCGZHkIvUlPMdZkZBYZaVlMU4cTu8/TD0afNAiJ8Y17v14gbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616450; c=relaxed/simple;
	bh=f6xHnY3RFc4my6WiZj2ig7vbv9EjSIFgKRB9CwT/tiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=lpAsK7Qf8esgDfoRkIsxts7k+a+Pj2Y2ehkJI/9EnHpEN9E1u7kdiGl0ttL4oOnvcX3BCnK8vNCtb90HZzCiuGR/4HzAULBT+2YH7TawUrNh6MHbVUiyOSfL5UZtzHsNsMr89/4dRi0XtQUjXBfTEsSs5DkwwtBIw/LhJVo1AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p0aRWVJo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p0aRWVJo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D994Yp043076;
	Thu, 13 Aug 2026 10:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dGAkr8
	kSh2c1+NdkaM1e3PBEZgikZ1uVoWk53IygFPs=; b=p0aRWVJowRG1WmBDwHjjr/
	DYmVGypgodGuNN/6jSA6DNojGX0nzZu3x91w987i1G6Rc/H2EnES+FKUxMqJEdpu
	N2bpYhk6BOfczRCK5k5gvAAmjL/+r/8NjzZRdvhi23VHfTw6JuVmDcXdnFNF1pqk
	TshyjqONd3WC7Y54jj+8dMTF9nritqqlNElhgbE+IhhfbYv97QyH8GzE7Jf2rAzq
	uW1DVLxr0ykGrsysvGVZShb88+k7xnZKA49YDZWc49LXU5UfoGJthBw0SQp2mDH3
	Oe+X/7k3mO4kKXLt1tDoMiFqMLaOEtvn6Oo/gcCPMTGAxb/F5jLOF4oORd3lurwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk07cda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 10:20:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DABK9J011267;
	Thu, 13 Aug 2026 10:20:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hah5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 10:20:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DAKWGD42729930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 10:20:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8BC20070;
	Thu, 13 Aug 2026 10:20:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E952F2006F;
	Thu, 13 Aug 2026 10:20:31 +0000 (GMT)
Received: from darkmoore (unknown [9.111.34.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 10:20:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:20:26 +0200
Message-Id: <DKNQNZP8SFF1.16PA05LCPY2E6@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] s390/uv: Prevent potential out-of-bounds read
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "David Hildenbrand" <david@kernel.org>,
        "Heiko Carstens"
 <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        "Harald Freudenberger"
 <freude@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Steffen Eiden" <seiden@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
 <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
In-Reply-To: <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3MCBTYWx0ZWRfX7A5ndYAdhZPH
 xC6UkivxdUHVXxoAmTGc6KmNgfeGm6aQQNXB718ngAN1EnwIWHuCeuinv77A3Y+2d0Op0bnfqB4
 ak46gj5z5WvVNVnK8lSUSPj7sBs88TvjvH1RnJwgucHUwbGFhDO941X0EMXDyDtqkraunRcuacY
 XIXqjdEjPC9gN3uHjLCYumFdADGeWzyUOcrE3gZfWk8551ZZjJW4E3HbAvhZAa3ymygYs2j3Nx2
 MRfe6dyMp8TNHpOUqW3fthCtOxcaOObRuPOcV1y4Sc1mI7f1iUPFv8fHOZ9YBZGqqeqK0UdHxAB
 S/slck+mmG/V7uy2YaSF/5S3LG7ibjsfW5+lDb6sAAHshFEbF5Uu8VwAF08ysou/XBnpepEgPh9
 jKEE9QWOWWhwQcekqDJsgI3FBlj8bbjstUa68qqXVETRC6JtjoSCQbiROv2dn51hJbbLpbSuR/X
 WJMGnjZt+CSRhZMJ8tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3MCBTYWx0ZWRfX/jHOJHtrt1xm
 Hglx5FqAPIws4OG3GPjGmP00A3TefpC8UY8wAGtpCmLJTeOuz1hjp2OSmwYSVu8gjRrTquxUDUy
 W0JFiUbC2rlX4ONY5IBfrTsrnILA7xw=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7d9a75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=m1nyXNRS_fih0tuCIHwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s5tsnqmTaemzTQPvsaRKwVCZ3sah3T_2
X-Proofpoint-ORIG-GUID: s5tsnqmTaemzTQPvsaRKwVCZ3sah3T_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130070

On Wed Aug 12, 2026 at 5:55 PM CEST, Steffen Eiden wrote:
> When the system has more than 85 secrets, the uv_secret_list struct
> array only holds up to 85 items per page, resulting in an out of bounds
> read in find_secret_in_page if the targeted secret is in the next page
> or not stored at all.
>
> Fix this by looping over the number of stored secrets which is the
> per sub-list count of stored secrets and not the overall count.
>
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kernel/uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index d970b15ef126..e70acad09cd5 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -760,7 +760,7 @@ static int find_secret_in_page(const u8 secret_id[UV_=
SECRET_ID_LEN],
>  {
>  	u16 i;
> =20
> -	for (i =3D 0; i < list->total_num_secrets; i++) {
> +	for (i =3D 0; i < list->num_secr_stored; i++) {
>  		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) =3D=3D 0)=
 {
>  			*secret =3D list->secrets[i].hdr;
>  			return 0;


