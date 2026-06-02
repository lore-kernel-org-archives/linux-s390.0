Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546903DB32F;
	Tue,  2 Jun 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400425; cv=none; b=T62zdSce2TQwXqyNu8b5DbosJ671W+AcC4p5zHtuLAC2UScLDsY4SeC4QFi/jhV5PrT1Jj70rphGDaKBeSILeRBWoY+GHKioFGcvA9BQ4X+DdS7lLH7JMPZmP4bmC4IsqoV3fChAnroKPo3SsXje4lQop10vvc7oNnYN08yhh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400425; c=relaxed/simple;
	bh=dldYc1eajWlDnPY6vlqamBlEl3pUOf/4zMZiOejepxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yrt64651xE0fGtmdtG7kHXI4C7v9c7j8PlQpgdezQ8z3AUfdmuLdD3gVSaflF9YBX43FAr0AMn0QM8ZgsfYsuuuLtky3Z6qrqpUQBLaohDC4oCDs4RptbTDaxml6Qd6xGWb/NYoDvwuEpSR2N0QiSX6l5blyuSsxl7grSj+UYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TjHtWsiu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TjHtWsiu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65271hm72298475;
	Tue, 2 Jun 2026 11:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0Xj8jMi5fSGoS1G0OupHX5oDzKPPaW
	gxNjPRKD5a7Uw=; b=TjHtWsiuLTGEMr2H/7qDyQqIzbKAxT+DVxMs7No/I6OAkt
	PgLMsEo78qQAqFEH8loCkOD9YJEZ/WEuNz0j/7LfGzlYzRr28R1rMUfu8gaHAZdT
	c3chkvC/gjbUietpB3/Vx7vzQUuBgu+hMHuaENk5f87MqcHrT9v2jmlm9A4P2J8F
	X5sDuAt46vhMZvebwnTBxGCFflaarlPoWASbc1LXregj28PUEZun7VQTz+5QmU5P
	8XRW47cFnGjXG2qpgDF39bBkMJAtYhee+kbUOtHA5d3CeSsBMNtR1oIiVR2k9qPB
	UnRUq+1bmJ2w+2hynC7wZeDxXXtewLvdo6mZOsEQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahnegu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:40:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Bd4rG028805;
	Tue, 2 Jun 2026 11:40:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qb78d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:40:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652Be9Zw29819152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:40:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE5D32004D;
	Tue,  2 Jun 2026 11:40:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FCD92004B;
	Tue,  2 Jun 2026 11:40:09 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 11:40:09 +0000 (GMT)
Date: Tue, 2 Jun 2026 13:40:07 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 6/7] s390/percpu: Provide arch_this_cpu_read()
 implementation
Message-ID: <17c282b9-a74c-4d6c-a301-23bcc98d63b8-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-7-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-7-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExMSBTYWx0ZWRfXxvi1KQ1CDv0i
 NCLN8luDhkGok2RiN/Et9d6nFWPvA4ezjTxO4to5iVgbYRAzdXtVMFSrv9SJj9nvWnssAAU0J+S
 PpnMnrrhOeKu4Big2wh4MRyVTXN9ShX3hEfF+mmEI7A6oXqTZmwCD3HcKmThZCfF58tgYGWWbiz
 GFgZz7GJ5AUwVSKHoOTkyxQUXyVATz0McWscL8k+HylJY9YjASD8USoAYYbhUH/Yyelc8Hg4nmy
 b/ZvNYYZG3rIrwder85SmwIU2aEiZ59s9U04yDWz+1PiZ7Tj2Npf+o7mzkEoJiQ3vqeuZktVjxH
 d/T1iMf2yIswnVMMn0eIegn9gx8Fo24nPDbbIaRPudiIfPShf3Hwr/NP6O6ICDSo/v5ZGWKuGta
 0kqtN490ChxGcNMCDxg4EXCHnOQ/WndPhLBuuRFY8CtqwiUdxOCPOsLMGd9RNXB44bNjRO3ML6q
 CNRy7mrGVWdELjgxRQQ==
X-Proofpoint-ORIG-GUID: p-GYYhKF6w0bmJgmeNk2nTMmHieVZ7j9
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ec11e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=cgPm772acQ0nl-z8f2EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: p-GYYhKF6w0bmJgmeNk2nTMmHieVZ7j9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020111

On Tue, May 26, 2026 at 07:57:01AM +0200, Heiko Carstens wrote:
> Provide an s390 specific implementation of arch_this_cpu_read() instead
> of the generic variant. The generic variant uses preempt_disable() /
> preempt_enable() pair and READ_ONCE().
> 
> Get rid of the preempt_disable() / preempt_enable() pairs by providing an
> own variant which makes use of the new percpu code section infrastructure.
> 
> With this the text size of the kernel image is reduced by ~1k
> (defconfig). Also 87 generated preempt_schedule_notrace() function
> calls within the kernel image (modules not counted) are removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
