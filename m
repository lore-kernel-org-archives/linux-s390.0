Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E849BD91;
	Thu, 24 Sep 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263902; cv=none; b=O/SxKlpnCHTPk9698Yt05ImTYRTP8WdpMKRpWBtGDFq4nmwbjMyv4i0+9jmNDEn5NIlVJv0ec3tRj5GRZN3SqBAvNbN0bVyGJatGQEhkPo+nTEO8MPtGYWCz1pJ1r9pVUETE/NVxIOjsXkKg9YYi9uf5sYFwdbsQCEsD7CCLcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263902; c=relaxed/simple;
	bh=uMpCpZa6hYesAU6Onxp9Dh8ZRur/ramkDn5vvN5YYWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+jKWDu6xSlZMH0lzdr/regTAB2+3I17/aVBelsb+YZ0lPlLvdsj/DsECCsUF0nUv7vzc9wXqj4o6D1GtGPoIHI3piJZAG6qM5BXBGV1l0oI1KjcSCTcETS8LKfk7dhYE2xT56m6iKhCaaU0YssdnlgNl81uH95uRJk44UlvlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hp059QVv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hp059QVv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6Bsr2183157;
	Thu, 24 Sep 2026 15:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vGIjl9
	TLDdiGYrrBXxUYqV7A0qZL9cYeg+mzgDMBWmE=; b=hp059QVvEv4EbeNolu7iK9
	3EBDMv/tpBdP2ibRndIkfwEr1Qb9nTuWfXuNBC7eUJco6SGtFTz5Jswm5ZaU1QQl
	rzQwJ54ecGfeu4NOk2hjafYBybzPe9wSAVigqKoN7mMGg1SLVhypekZbcXE0zKFA
	juD2ChbAEPsV9WZbMJvpUQjW3M3LdMtNORJyLmumi2SmPeMbliH4hHkfZcS1ivxC
	UuRq1XyFN/9whCnM8Xev0wkhNRdvqehayxsKzjcougtuY1i5DhJ2u822CSmrtc1f
	NcLfHFjiNx182Ad5daj5dOaw5qUjXzHXA+L3QgYBMDlhV55ZlNcK8G36hgQqY76g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshxr2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:31:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OEOoZ52194322;
	Thu, 24 Sep 2026 15:31:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2xbhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:31:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFVbDE29229730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:31:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF0158068;
	Thu, 24 Sep 2026 15:31:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46DD5804B;
	Thu, 24 Sep 2026 15:31:34 +0000 (GMT)
Received: from [9.111.196.99] (unknown [9.111.196.99])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 15:31:34 +0000 (GMT)
Message-ID: <e7343e01-724a-4393-86ae-de13fb052ed1@linux.ibm.com>
Date: Thu, 24 Sep 2026 17:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390/sclp: Implement resize for sclp-vt220 console
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
 <20260924104732.1978942-3-maxbr@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260924104732.1978942-3-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab5425b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=zBLIaIyO4mf18BS1cK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xlb-ptLXWwhgS4eO4Hfso2KwmmQyUyeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXxLZsMoX6Naut
 s6X1M8pjOm/V9nwrqkCpDyt6Gi7lfyiVwPYAtddUIu42dJbY1CUODD9jMqigoxHTox2Tx1xaaYb
 mgq+xdRcXPeuMrqKkwV+lkmF+nPgj/hW6MOClquAoAovpjJbk6Zcou22e4QPgrD8K8fYJhFAam2
 dmxgGbSkG7uNe3mggfw/aZEyhHNkOuKyc46CSilDyAAOaKSQsCSXYZKAEEcY126V6KCj83llBKj
 jjvkw71FP58+mT974AsAD/i41bXNz5EAlLyfhcFs68FPfjFYj+XAGC0cXLHPgMi2B2MZjsgHzT/
 vlOsz9LF3PMGApCx0xccSoyH750ZVYsIwqRn9198odl+y9aotK/z7pSJCo3WROWL6Q8stiiFPJr
 s8auY76sWX0ZiTNUtaqMWEylUI9gFPHQz6taYXwM5iRLzZyyhr2SBNpXzAOKg+p6RgbBBy9RC1g
 utkLKOON5otjAjUE2zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXyahyww5s+Jo0
 6NRsbiX3X3dbhr5DDLZgfx1OTsaGCZAlY/HC4g2qj/E4eG8TJDPnn1J0AQ3PMTxKaKnfsKgEThd
 OwQIB/nkYHqBpoyFNg4m9MrSZaN/Zsc=
X-Proofpoint-GUID: c0J1QMfOHmfPD1Rjtxw6H4jioLBS_1Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240062

On 24.09.2026 12:47, Maximilian Immanuel Brandtner wrote:
> Add support for sclp vt220 resize events to enable host-initiated
> terminal resizing when using the sclp-vt220 console.
> 
> This allows QEMU to dynamically resize the console. On older kernel
> versions, these events are safely ignored as the kernel drops events
> with undefined tty codes.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
