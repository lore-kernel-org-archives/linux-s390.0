Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989995;
	b=Uwgyi3sriYE5kF6y+ARpXhYnevOYStS1vGwjZgKmnyunUMsar6S10ns1glloA8wLaT63
	 YMjbbLO0WML6L8P3rrYF56FBAbE2lJCQzk7RW6qH1GisnuGTisjrjjiulDQ8uJjAjBZ7X
	 eKznezYLQfwznwXXcn9aWbM/7Mt2MRUEMQYOJkVc4R2hr9BbOq1GVpzJDbkq6Zq/e3wkq
	 JrDX360RWFZiFCwqlbmITq6JcBMetvkd/8EpH4IKgc3Ww19woSfDGek69WSRoY89jp40m
	 PMZRPlkmwsR4JwQjHH1HhSS3vKHSEYYHH24KhvKvoufFbeUFUNnA1tr2m5HYcwpN7og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NZ2DiUYcYA6riJMrquv0S0uzwR3KjlESIdF8oXXvnq4=;
	b=Xh3Jp8WBtyQUNCce4DgKaBeHDdQJLoa7vvHoBISzTcmYru563qtwkCSyskzMO7SmFSK0
	 jJ2wm9nsOOlXTqC5rnwfYb566NrjAS2Vn02aAKjBFRGe96OfwXjSC28Hp7TEANUzv7CHt
	 K/DW1JaccI0/dIOiooDPruqWS3SBGFzYXFk4JwdD4O1rm3ChN5KvYQV9yrvgUYVos5qcg
	 yhp7vgjTGyX0EkAeHurUcX6DHFR3VeOsorVJj5cvRDFHgpxneOWVyLJ/1msgu6OTBG4Oc
	 Ik8+eRBcKNl+vTMZo2ZsJhDIWtFRcGvzyHh/Fa8T2nBMtk1/KvA1X6xURmOZO/Wxm9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CHYLikr7;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17718606A31C;
	Wed, 18 Nov 2026 08:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17718606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CHYLikr7
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SM6x032357;
	Wed, 18 Nov 2026 08:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NZ2DiU
	YcYA6riJMrquv0S0uzwR3KjlESIdF8oXXvnq4=; b=CHYLikr74UQY3xDY0mK1ln
	UItMzkTfsxSuJmhUcOAg25lgq/Of3U/OWPyIqfvLwQJ5EO59MWPJqU/lkOiOw00F
	QiaAQBtE4k4Hc9WrB/lQuSIre+I1HQTnaoDHCIqDtNuktjoUHG6jjFYNEL+AYOWp
	AkwsM8SEMvfiFPLYfswocUBfLnLW6kY91l7jwFy16irUd2Hyu43GUzzYEquNSQXo
	UyK4S+t3uNsLdoaGXVScfZ1Y9C4vhqTpxzeoQRyohmRx50QrMikRGXZr1iamvt6U
	CdORrNAtH07XBbOCxsGRMb7C0/KVmFR39RPr9LZDxeNhQaaVAWzIQkbMBJPj7Smg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9h67-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:17:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8GsLG2766497;
	Wed, 18 Nov 2026 08:17:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7qfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:17:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI8HTxD34734796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 08:17:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C966458052;
	Wed, 18 Nov 2026 08:17:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971BB5805D;
	Wed, 18 Nov 2026 08:17:14 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 08:17:14 +0000 (GMT)
Message-ID: <f201c30a-6fa9-4d9a-a77b-74d39f89f2d9@linux.ibm.com>
Date: Wed, 18 Nov 2026 13:47:12 +0530
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
Subject: Re: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
To: Ian Rogers <irogers@google.com>, Danilo Krummrich <dakr@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Yoshinori Sato
 <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
 <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        Alexander Aring <aahringo@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-3-irogers@google.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzMSBTYWx0ZWRfX6HgVMZTRPl85
 Jn18W+xXyZCi92S6DV05FbfcOPNGJFHWP78E/tejMVWymJnqf6YRWa3lQfegmn4iFOJICQoFNbC
 8fh77AnL+jCvHbyG7D8dqSe73s/x570g9zzXuT6BEhlr8jl3r0noGCIl5NBmBZT3KVNvrFD+dKM
 jmrjNQeA0euaud80lISJyfYHrs3jCYZTQa4ayAz9gFDK104eYk/TZg18Gqwd/J5Ixj5j5H+Mg2I
 ON9WlD8PFML3ou1bPmQl5abk01ve2XueAz/SPNj8iUQ/gnppB0P6G6CBLt3MEDM4SwAoGy7KId5
 yxw54L/3ILMaq2PyBoQpvOYAK35zGDxe3Y12powlrnXTOf7DqHPX9d2RKDcqN2WywfEZZZHqYGK
 e0tqtovVEX+A89Y42Kz3zAXdwVaBquDU9m+1ZF0j3UqpHYy7om6XFvFQQwEB9vdTA/NhCTJnATW
 AUOI0KD9i8Rc7/c3tuQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd5f1d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=UWczDWbm3HpFH-zmGUoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f4vCixBvRS1iziYkzXDAyNtWHqcSULbu
X-Proofpoint-ORIG-GUID: OYeOqBGP-BuxJLy49XGYjOXqV8575ClT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzMSBTYWx0ZWRfX6D4JeSBiVpo/
 1SUsT7QUnarJqrFd/whI1VbYytmfTPlmOafAXSjzDWGt8A4WgXnRmkoTMU5NO0iqVRltJs6vVFH
 VSWDbLyBnOCi2lpPYRK0hG7fndYLOWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180031


On 11/9/26 4:09 AM, Ian Rogers wrote:
> In add_var(), a struct kobject is dynamically allocated with
> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
> However, secvar_ktype does not define a .release callback, which results
> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>
> Provide a secvar_release() callback that calls kfree(kobj).
>
> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
> Signed-off-by: Ian Rogers <irogers@google.com>


LGTM,
thank you!

Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>


> ---
>   arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index 395399bbab2c..f3f6ac25ea78 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
>   };
>   __ATTRIBUTE_GROUPS(secvar_attr);
>   
> +static void secvar_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
>   static const struct kobj_type secvar_ktype = {
> +	.release	= secvar_release,
>   	.sysfs_ops	= &kobj_sysfs_ops,
>   	.default_groups = secvar_attr_groups,
>   };
