Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670333B786
	for <linux-s390@vger.kernel.org>; Mon, 19 Feb 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359095; cv=none; b=FhQutxSp+YULksXR00anuBWefoma985iqfbAPDy6H8mBrbdhmnMGMtaHHer5US9tBhUwrxcRqQ+YJjq1hVzuVSasYMgdrwbxNZfy7/IUj1eTGjqPJ+4HPFO/D8df8Se5EsYPDrlE5I0qjAywFDtwkzkRxEjaBum3LstPmUz4uqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359095; c=relaxed/simple;
	bh=VaGM0MNc54dzu2/ONUvzmqw8bWTkwZ7e2F6lBSnLeXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjpU/tq+ons0X6+l0uP5sn+Rwo5EMlTVxG0Uq7/nW8T2SnMdHIQRmUu2OiJupMyozTs+DEFdeJ8wrQEaZUWLv+gLMe7lc4wfE+pMwToaCK9EyK64jlSI+N/9hsNHm0vb1syVzd4ANnqz9k9zG2V6/A67ibVBg78y98pZlVTwzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mr7qf1wE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mr7qf1wE"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JG7K7P002432;
	Mon, 19 Feb 2024 16:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1BJp8IseztzZ8xcdseD+UYVgoPgjPHB6lnG0lU77diQ=;
 b=Mr7qf1wEki1Brs0Wv0jqj7QWK5emADfPmyYv11bvw4XCY9JoGEqpjbkZffj8lcf7CE2U
 RQO0qrFmxkENUe9pFwdfGbGWT82cb5KZbhVNvPkbGDumWEKotltlsnJUmygB08MnMga0
 keelWZPGRJXtVKC9MYeV0ILbhBVKOGPTy4pRAf8Bpquc6Lwug6/yd2uzpUi3Rw6LH80Y
 PoyfGy7EETO6P/rPDVJ8aqqMJ7BdiKvoV3LMXr5t6myRoilk1EhiaQsckvP7JIXPzQu6
 0rYiDqORRQx+J+ZEkfFXBn27wjcvVjB5WHrzgetVxRjH1Tn7bmHUlS9qruFFE6BGd+pA iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wca7nr33c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:11:30 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JG97d9008458;
	Mon, 19 Feb 2024 16:11:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wca7nr32j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:11:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JF1eUx017344;
	Mon, 19 Feb 2024 16:11:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm22b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 16:11:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JGBNtv22610434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 16:11:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3D72004B;
	Mon, 19 Feb 2024 16:11:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C71920040;
	Mon, 19 Feb 2024 16:11:22 +0000 (GMT)
Received: from osiris (unknown [9.171.27.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Feb 2024 16:11:22 +0000 (GMT)
Date: Mon, 19 Feb 2024 17:11:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 2/4] s390: Add relocs tool
Message-ID: <20240219161121.16287-D-hca@linux.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <20240219132734.22881-3-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219132734.22881-3-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5R2uyvRlqcudh6BKDy-T6uRAjCy7IlDc
X-Proofpoint-GUID: tw1LytxfdsdUTtiuZ5U3UWRelmQ8KbmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=792
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190121

On Mon, Feb 19, 2024 at 02:27:32PM +0100, Sumanth Korikkar wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> This 'relocs' tool is copied from the x86 version, ported for s390, and
> greatly simplified to remove unnecessary features.
> 
> It reads vmlinux and outputs assembly to create a .vmlinux.relocs_64
> section which contains the offsets of all R_390_64 relocations which
> apply to allocatable sections.
> 
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---

Sumanth, your Signed-off-by line should come last, since it should
reflect the route of a patch. I'll fix it up :)

> diff --git a/arch/s390/tools/relocs.c b/arch/s390/tools/relocs.c
> new file mode 100644
> index 000000000000..d3ae25e3c3a4
> --- /dev/null
> +++ b/arch/s390/tools/relocs.c
> @@ -0,0 +1,390 @@
> +#define ELF_BITS 64

With this...

> +#if ELF_BITS == 64
> +static uint64_t elf64_to_cpu(uint64_t val)
> +{
> +	return be64_to_cpu(val);
> +}
> +#define elf_addr_to_cpu(x)	elf64_to_cpu(x)
> +#define elf_off_to_cpu(x)	elf64_to_cpu(x)
> +#define elf_xword_to_cpu(x)	elf64_to_cpu(x)
> +#else
> +#define elf_addr_to_cpu(x)	elf32_to_cpu(x)
> +#define elf_off_to_cpu(x)	elf32_to_cpu(x)
> +#define elf_xword_to_cpu(x)	elf32_to_cpu(x)
> +#endif

...this is dead code. I'll remove it.
