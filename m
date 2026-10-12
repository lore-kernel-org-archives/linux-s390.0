Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBC48F856;
	Mon, 12 Oct 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819047; cv=none; b=fzafwHdSpX5Tdn0W5725fyvwpYGeXs5GhSjNHUsLyVILkkP6TYUWEZWhN1eis9yslRy6529TE9xIgM66m//uxH6+3NetB172so24bGAuXXNlvRpFZzmmJ8snTY5L8LOYa3Owfs5+wm4QKAMmfhAWMkc2gXU+sR3nGPJEwFlrpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819047; c=relaxed/simple;
	bh=V3s6IJDBCBrIQpiCggb4LNK0QLo+InCbXZEoM4iUY7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtvDXgoaRsqhMkZJOFErLWiBZQv2FxRc38SumURb/0SqxjqX5h6Xj2SzXS6ChvtnROxgK2MdACJs7dcr5EeNjprWJDGHR43RoXEsv0aA/cFw0AlMv5bgyHwY+ni0/HU7Vz8qgk+dQ6hP33Z/JjZtzY/q8bfpPuFNaJxG8brKEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=owxoHg4Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owxoHg4Z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCESu0317275;
	Mon, 12 Oct 2026 15:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iRvXaIUTAaxd49S6BsiLMvHBDKVSij
	wseTraiJAequ0=; b=owxoHg4ZKv6q4/kOxNJHFatwF5WQhRd2fwUzkqPhuxVhp7
	112Q29czbDkyWxJgrvcp2W1nlY/rkp787E684IbqhvkR5k9cLCQBsQzKxqckHc8V
	SY18/mKDh0kdl9tHEH+3JZ+fUu+fMHyE7pnMynlZLbO5gMLpdkn2JlphiDJEoXkD
	5Vjlb5I0qOZNQWngXqKU68g9txiowW8f9cPLSA4SoGCTkm3rgbrXsFLYv/I2STV2
	kLzfUBcWCBfYC/fxPhkaCgYJqwGgk2lhqmSre1SCE/p8DW9iy89fFM1x6VfJ9j+5
	mo3bOeoRqJz3Gi6TrrwiDTG9pbw60WktxESmZl5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug9mq1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:30:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC51v41287108;
	Mon, 12 Oct 2026 15:30:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwqbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:30:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFUd0244433726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:30:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EABF820043;
	Mon, 12 Oct 2026 15:30:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E5820040;
	Mon, 12 Oct 2026 15:30:38 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 15:30:38 +0000 (GMT)
Date: Mon, 12 Oct 2026 17:30:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/32] s390/traps: Handle nullifying program checks in
 get_trap_ip()
Message-ID: <20261012153037.19350I2c-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-8-hca@linux.ibm.com>
 <f7a81358-0ff9-404b-9b27-1ea11c095694@linux.ibm.com>
 <20261012134221.19350F50-hca@linux.ibm.com>
 <efd8f77f-f66e-481d-a67a-d4f2d0520ad1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd8f77f-f66e-481d-a67a-d4f2d0520ad1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accfd25 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=v2IaggXekx5fkVIIHtsA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: lHP4tS0xFIcRemwaXLgY_Jr9eeJgB5Up
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX9/rnviXJpiV6
 oroqHiI1HKOuukxcSNhk36OKBPqj+o16nIfjJwOeAsGw62RGfOnsxkc8Fo9XG2Lj4tWkaQBYFmD
 g2IhkkCJH92akHulcsE+zlPma2400v707T++rqOEge2tyFyvRDBiDdK6v9b38JzbKSAn6O8U/jV
 SqS1U2b87Hg2efAS2hD2Ot9O8ynuQ7HZjKCWN0EDMtPq0UWMCZvieWS2VgRJH5EUUL8aOktmQi/
 6fIPA8AC+jsB2RGliSxDO8UfF6WsIPEeLwOG1fu/+v2oV3kV5mBsSW6VwgyynpqWa/xEAMmLUA8
 TJcoJCXQ8+p7o0fYSbm3WbXhgbARGpsamXelcpDcIMm/zcT7SEyH/rvdjOEpLmOyPdcXC0e2Niv
 y3Z7O5KYapgY8XAiE/1gaPd5vW+FIV71Q4Zk78dFIFRijvC3RCI6F/13kiNGe2NAqlNyMtHkhe0
 BPXPKHYIH0ljJ/AzewA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX9UMTMGIL4FSP
 scWniz0jwTTihpceGEcBzZ+L1wFg966nkhK/zWet6odxVTGwqOzv+lXfTGlZO9QZmHck0OVf9K4
 RZTcNk+k21Dq5lL6UysasWXOjty1WyI=
X-Proofpoint-ORIG-GUID: lHP4tS0xFIcRemwaXLgY_Jr9eeJgB5Up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120060

On Mon, Oct 12, 2026 at 04:31:17PM +0200, Ilya Leoshkevich wrote:
> On 10/12/26 15:42, Heiko Carstens wrote:
> > On Mon, Oct 12, 2026 at 03:01:56PM +0200, Ilya Leoshkevich wrote:
> 
> [...]
> 
> > > Should location be moved inside the "if"? Now it reads weirdly: we cast
> > > the pointer to __user before checking for user mode.
> > > 
> > > >    	if (user_mode(regs)) {
> > > >    		if (get_user(opcode, location))
> > 
> > You are suggesting to move the assignment like this:
> > 
> > 	if (user_mode(regs)) {
> > 		location = (void __user *)get_trap_ip(regs);
> > 		if (get_user(opcode, location))
> > 
> > ? Or something else? Sure, why not. Just let me know what you prefer.
> 
> Yes, and maybe also move the declaration there too.

Sure. I'm not going to send a new version. For only this. If I'm not
mistaken there is only the other minor nit pr_cont() vs printk() which
can be easily solved. No reason to spam everybody again :)
