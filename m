Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD9131724
	for <linux-s390@vger.kernel.org>; Thu, 15 Feb 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994549; cv=none; b=AKUwPhnqguw5MpHRggIZhVilnjjiMlCmWZ7maBxKftXZaIM/GzeoiEr/Pjmq8n9GK0dvbAjGmEOKIpyCzb3WRW/qxbCKDGp9tXSwxv7Vjonu5iZenW0EblPEWpZiNZtmq745qrLUW+10HOYYsyw7jpn0d8SaohCTrkKoK2Hx82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994549; c=relaxed/simple;
	bh=nEzkq57P5U11Kyj7JZ+pRV3FSKpPFDCoJmYgcEt7yEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G3r/kDUSjUZtUeMBVrluMq7f9f7ErZN4BzF+DjYiyxB8D4hXPDe4IExA8BW8i3hn+IPLNLZsXVsAKUSZ04ecHNSa3gsfhDktcJRXSqWgRFkGA8Ss4CPhzzE4qQ8pr0CBInrSD2if9xhy2a4D/+GUZLyHJtA2YC8crFF80uxIcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VxuNUPYl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VxuNUPYl"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FApwJ9017401;
	Thu, 15 Feb 2024 10:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=uOuqYJu9b+yWaTyyCAffqQvcEZW3+BD9eeJf/nZwLFs=;
 b=VxuNUPYlEeb17KIvW1DStWI/ve2mpIgiwBQupOqTOHZJo/RVPnkqM+5PSKbg6ZzVNwov
 91BH5syUvngT1LNNHaFNo7QV1aqRQgH+ho0gMs94XpLty9rxDkH1WgHYAk05PUnfYwy/
 6p95o8rGTHanKPcy7MiGmSCaTXGjbIHL1wZBT8lJgubSxvAEGxsZG2RVBLcw2hv1p6r3
 Bd4X2JZPamdQVV5xINUDayVHjO9Um7sSdbDBeg/UCqPl8Umril3LPhfKPtLAkkrMbYkw
 mCkTZxHTSY8ij1JnbABZm9+ad3/qh7dKj4EPzXZZH4HdyldQhHvIgVUsB4FJhuXruFFP yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h7yr3mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:55:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FAqrld020842;
	Thu, 15 Feb 2024 10:55:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9h7yr3ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:55:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAOt0g004287;
	Thu, 15 Feb 2024 10:50:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0mcau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 10:50:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FAocrb19006116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:50:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB8720043;
	Thu, 15 Feb 2024 10:50:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 001502004B;
	Thu, 15 Feb 2024 10:50:37 +0000 (GMT)
Received: from localhost (unknown [9.171.10.232])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 10:50:37 +0000 (GMT)
Date: Thu, 15 Feb 2024 11:50:36 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        hca@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH 1/4] s390/vdso64: filter out munaligned-symbols flag for
 vdso
Message-ID: <your-ad-here.call-01707994236-ext-5786@work.hours>
References: <20240213104707.673053-1-sumanthk@linux.ibm.com>
 <20240213104707.673053-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213104707.673053-2-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MKJA6GuuViohE2hMm7JImk3iveRw7KDQ
X-Proofpoint-GUID: XfT_nh4YExtRFc3GE5V4j4Pqc2dkvt4b
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=921 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150086

On Tue, Feb 13, 2024 at 11:47:04AM +0100, Sumanth Korikkar wrote:
> Gcc recently implemented an optimization [1] for loading symbols without
> explicit alignment, aligning with the IBM Z ELF ABI. This ABI mandates
> symbols to reside on a 2-byte boundary, enabling the use of the larl
> instruction. However, kernel linker scripts may still generate unaligned
> symbols. To address this, a new -munaligned-symbols option has been
> introduced [2] in recent gcc versions.
> 
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-June/622872.html
> [2] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/625986.html
> 
> However, when -munaligned-symbols  is used in vdso code, it leads to the
> following compilation error:
> `.data.rel.ro.local' referenced in section `.text' of
> arch/s390/kernel/vdso64/vdso64_generic.o: defined in discarded section
> `.data.rel.ro.local' of arch/s390/kernel/vdso64/vdso64_generic.o
> 
> vdso linker script discards .data section to make it lightweight.
> However, -munaligned-symbols in vdso object files references literal
> pool and accesses _vdso_data. Hence, compile vdso code without
> -munaligned-symbols.  This means in the future, vdso code should deal
> with alignment of newly introduced unaligned linker symbols.
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  arch/s390/kernel/vdso64/Makefile | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
