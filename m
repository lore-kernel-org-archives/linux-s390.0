Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BB37756C
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316995; cv=none; b=Ho3ACQMymszXCBhkeo/P38iSd2OsYl5W5j9e6sbz0X/qRUY56YCzHbo0I/tsVhp3adAfypQd5s4Yumjn6PGdbQwBKzYjLglcqtgYZM6I1f0+Ytlog4onUz8fzDUSlrraDWWRdhN9sNYO9/nEk4YDVFFEpDzGq+Ie4qYGdN2vcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316995; c=relaxed/simple;
	bh=e5qaYCNybpYGIt6ezLO3O5+PFEO6Q7FAcjz1PVBw5zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=metAaTI3I7VwrX1M/ZvdzDqBqVmV+a0aZzLusNqKPRokxpri5xyUpHXjcpfIEk710f3zoR6j2u3MrBQ6iF8FaziPDduPC6I2rUutSrhXtnN6kel5qr4XaS4ay8ManE287hARCSJmpnyCCgmB/UalJMC8GuY7XL5vD+ildGCUZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxUZecjF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxUZecjF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65114l4q987831;
	Mon, 1 Jun 2026 12:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=W/H/WSpbvKqu4fPV0Fu0d81DPuNmSn
	rS9ygP4m732lM=; b=rxUZecjF3FpETlMEBISlp9xBEQcY2YajeSn9pe2Kgk1p81
	BbByvBS2Y+Q5owx2orp/k/wgi8QaD1j8SmcZXSRwhzkSrZ86wTxzbU6PABBdVV0i
	84AvhuE7IVxjn/3F/ka5OU+2C2xzooVib4p/ZKdt4ffToxUeS9dj7OYKxAV5GqRk
	tfoJUp+jrz09BF7ppVC0UD2E4b25B9RG5ARGF1NBV//1rt8/e7L/A8389C1etODS
	EmFJowDl1g6y4hrAS67m36XU5pFbphCyBG88Zg3K+2LiiuXN/sDeub41ZcIyfhgL
	f9Y0B0AazQMahKoJuewVMSlP4kM2S/ePIAWQPn0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht07vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 12:29:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651CO5ax009843;
	Mon, 1 Jun 2026 12:29:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy5rfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 12:29:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651CTkwU60490210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 12:29:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 431882004D;
	Mon,  1 Jun 2026 12:29:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FAC720043;
	Mon,  1 Jun 2026 12:29:46 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 12:29:46 +0000 (GMT)
Date: Mon, 1 Jun 2026 14:29:44 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/6] s390/drivers: replace __get_free_pages() call
 with kmalloc()
Message-ID: <77182598-7f97-48ac-ad85-1fd9c2c2c931-agordeev@linux.ibm.com>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CQqUWL2UTBIan788yUPcVvNiZldTUpf7
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1d7b3e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=_0kljoH3NqQINkRqSNAA:9 a=CjuIK1q_8ugA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyMSBTYWx0ZWRfXyEsQPX7bnUsW
 7kEKJGT1UQegWetz0RN15tyWBNsKCR1NCg7XU3KlXwL5+TZjO0ytxDhHLknCldNzexNIUMdol9Y
 X73s1bIOzgqOXUOdAXfQKaiCQvqPLltITNt0riCU7fX79OUUSiY5YJqD4mVjbVzm/8iEWtmwWjs
 9tzTD7b3TZfASk0sGXVk0/YuwomUIf3nTzd2/NvsbP7GN1jnULH/Vo3s6vqt43fJcYnX3k0BmIF
 7acQcOvBlCnOu2jMYut8iPf+nEDPkxaMIrXFcrbPm5cqgKZhLbq1GNRNkdBWAvXybzRgFXMSmRb
 u3MjWQDaTxAeTJFQFN85rXtrSLOwRFnjoqJuxz0eDF/xImBjSbQUOLas73+HLZg9TjNhM6Dm3jW
 /s0cAvWYE1YbVaabyEhrwI2X2Ec3/9Hqsj3V5BXk+dWXujlzlf782k1tfwurwxy90oyp2O02axa
 Lqi8DZPPpByNcLSa6xA==
X-Proofpoint-ORIG-GUID: CQqUWL2UTBIan788yUPcVvNiZldTUpf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010121

On Sun, May 31, 2026 at 05:08:21PM +0300, Mike Rapoport (Microsoft) wrote:
> This is a (tiny) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> Nowadays the right way to say "I need a buffer" is kmalloc() rather than
> ancient and ugly __get_free_pages().
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-drivers
> 
> ---
> v2 changes:
> * dasd: fix wrongly converted freeing of rawpadpage
> * qeth: make 'info' void * to actually kill the castings
> * add tags, thanks everybody!
> 
> v1: https://patch.msgid.link/20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org
> 
> ---
> Mike Rapoport (Microsoft) (6):
>       s390/con3270: replace __get_free_page() with kmalloc()
>       s390/dasd: replace get_zeroed_page() with kzalloc()
>       s390/hvc_iucv: replace get_zeroed_page() with kzalloc()
>       s390/qeth: replace get_zeroed_page() with kzalloc()
>       s390/trng: replace __get_free_page() with kmalloc()
>       s390/zcrypt: replace get_zeroed_page() with kzalloc()
> 
>  drivers/char/hw_random/s390-trng.c | 5 +++--
>  drivers/s390/block/dasd_eckd.c     | 8 ++++----
>  drivers/s390/block/dasd_eer.c      | 4 ++--
>  drivers/s390/char/con3270.c        | 8 ++++----
>  drivers/s390/crypto/zcrypt_api.c   | 6 +++---
>  drivers/s390/net/qeth_core_main.c  | 8 ++++----
>  drivers/tty/hvc/hvc_iucv.c         | 6 +++---
>  7 files changed, 23 insertions(+), 22 deletions(-)

Applied, thanks!

> Sincerely yours,
> Mike.
