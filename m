Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09F3DCDB4;
	Tue,  2 Jun 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400448; cv=none; b=KwTrQUP4ssmVMRHT3Fzicpk0W/7zVK1Ej7wfyiBm+2ZSzfK9oQCmLkYww27qZ4DZZ7tkNdITvYoHauBgP10kaACLibqke1JXC6Vb4yKrQ0CHwOjh0+NhY+ryipia0EnveZ1eJi5Qi10zQnysXIsoBTsaFC6CuEzbJyXdCTmqnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400448; c=relaxed/simple;
	bh=Deq/CiCYVwgJ9AXOA2TusYfaBT5kc8/6O8lf0ciAZzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn1ohwhXOUB2ZVaiRp+Q3mWnBGfTqi8fRdNVx8jEHvWSlZVDceKEo/gJUy1eryk2n0Ow4Z3o5tDDY+Aape1+zxvI4njYON81sysuln5y1aUA7B+3EaDnn5Ew9jCNCrqvE6rHiKNEwWKrnV1gewvp/SywBapNVjFFQQ1ZhEDdq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ay7HpW4W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ay7HpW4W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528S6Ud2708324;
	Tue, 2 Jun 2026 11:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LYl9buTXLVg8voMdEZdYZHG3wMYY13
	rXrkWb7Tj0SaQ=; b=ay7HpW4WdIqe9dGagerz6YnkHRmo0tgBwVaVSdA+rcTkrG
	crm59RM5e/LlZJD5thrDGxM49sgw50dknANqr+sRMbcyL31lBs2Syclq6oL0Q+TW
	qS86Gvs6e2BMsB+TNPNlF5sFwqPhFc77RYukC/B9kN3LcEEuknjCFdg1Lbm1DsBI
	iK97hWus8FOmU5140TGy4qb5HrfsgZXVgVQZedYohLMZq/j8p8zdRFbCGQYmnAmC
	dv4qlf8kHpH+PzuTdjEns6SavTXwrxnLVtmw7Oh2avHdPy+W6ks8CnunTbMgCE9P
	9/dXlBI1uDgZUhA4hbfoAFgnTr3YzFlmpOetqBOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahnejf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:40:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Bd941016854;
	Tue, 2 Jun 2026 11:40:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyaq0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:40:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652BeY8928573992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:40:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA7B02004F;
	Tue,  2 Jun 2026 11:40:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B02A20049;
	Tue,  2 Jun 2026 11:40:34 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 11:40:34 +0000 (GMT)
Date: Tue, 2 Jun 2026 13:40:32 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 7/7] s390/percpu: Provide arch_this_cpu_write()
 implementation
Message-ID: <032b0b0e-409b-4f0a-9958-5d4196a5b655-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-8-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-8-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMSBTYWx0ZWRfXwDpuXypXRPpi
 NoFzbYlJ7oZaIsMBEbZ3EfMQQn8peZWeeAlc1oLRCwI949Bovm1KrfoIfUk9/pGsEu0W4vQ/5hi
 ABxFve2JbuGML8CTd+e9RNkTyFsOqTfDdG10rqFmAC0KTc+BAWVDKw6clY3SLn0hBVMOSrjmTI8
 P76jWm9W4uG2iajwF66Ay8SQc+VfDNpOuT8ELectwS3yJSBmM/nd/pXxxTaLU60PVV3el58XSD9
 svvtr7BMQJMxpgIS4+4dBtC8umv8KaZJaLb5OulDPrE54GInCoVn+LuDyLFnPHvwpsr7L0oEHhA
 iA7xReioDdbBD/7i7FgtwY8dEzqhHVk0g+QErEdFx9cQ5pJqhpY1U6gzY+ajY4abvIQQI/Q+ZpA
 0wocroqX/L8B46AtIJrL7+ltvDPpTBBwaita29dptMhobu58H3kJArLJ8y8MomryiX/Ya1e638j
 xXjIBzFirmb5zYrqJvQ==
X-Proofpoint-ORIG-GUID: fmTDEpV4Q5KeFFAspN6DIfT8_etXRgtz
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ec137 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=A2CpN3_wmpm3pR6LOywA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fmTDEpV4Q5KeFFAspN6DIfT8_etXRgtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020111

On Tue, May 26, 2026 at 07:57:02AM +0200, Heiko Carstens wrote:
> Provide an s390 specific implementation of arch_this_cpu_write()
> instead of the generic variant. The generic variant uses a quite
> expensive raw_local_irq_save() / raw_local_irq_restore() pair.
> 
> Get rid of this by providing an own variant which makes use of the new
> percpu code section infrastructure.
> 
> With this the text size of the kernel image is reduced by ~1k (defconfig).
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
