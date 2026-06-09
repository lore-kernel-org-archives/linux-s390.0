Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD817C203;
	Tue,  9 Jun 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012008; cv=none; b=rw/RFyA3i3xrLXskcXICD+wsQID94tD40/PSHlDR7Y6UNSKRBzaJnTUEjDfr0OmkrJhvYXt3SYuxMBZYpEpTCJKjdI0xxxG9Trz7mIJrgsHgO2yy7LNdprA73oRoOcbMbWxLyJT6g+Y2q3MBd1IIeGB+LF2RPLIgVOB/DD78H54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012008; c=relaxed/simple;
	bh=M1Dyg8EJ0902QQPRE2PnfcpAg9jS8ixVukcX92uYIvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU3W9hMCRdCia4ygVKiKuqsxjC/kQoc3sXOnKTNbcJprimkEsRlvKPJpEmUU6W2f7ulKgpycXO6r/sTRNKUzTGNm1rzxPBdeuhqm3rA5wioMLNfHnCOEF+paFAz8g45HGAb8d40asP07a9PGofKM1REmEB2JNNMDqKUVOU99QPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TlWZO+Gl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TlWZO+Gl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595EfMX3019572;
	Tue, 9 Jun 2026 13:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rL10x7nepuPeWE6QjyuM2zV0V1tKBx
	AvdfNgjt7yJww=; b=TlWZO+GlaGikoDjxqnDiivDARTP2apV0sIhYuUri1l8w5z
	v5o2126h69u1gS9Kw8TQbEH2BC3UeX2hDqxFyHC/AnonHNP549vbKpZdExqkU5Gy
	YCTikWYJ54FlRBKuC0uxvB7U/6GMhoPwjNZxPTL2VJRhjN9OfxbPRl+MH706cNuO
	lP/Ejck03yzuoMbIsx6SeDnGcdFOlbFo3mma/OTIFRHbPwBmxxcuWY9E1ymFD3HM
	oVKZ9d+NpAIuzkMJM3IHLvo7cWl2cG1qt4oEvi1JNTdrsJw8njry7VyB8MVAV81V
	CsbMZuBfZcS0c1+G2kQopM39oPNWRATJ/MYmfhzw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qmb3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:33:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DJdEj032040;
	Tue, 9 Jun 2026 13:33:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych232t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:33:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DX7ob50528756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:33:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F63A2004E;
	Tue,  9 Jun 2026 13:33:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDB5320040;
	Tue,  9 Jun 2026 13:33:06 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 13:33:06 +0000 (GMT)
Date: Tue, 9 Jun 2026 15:33:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390: export memory encryption helper functions
Message-ID: <20260609133305.9217D0a-hca@linux.ibm.com>
References: <20260526102113.2594501-1-arnd@kernel.org>
 <7bb6c04b-ded9-47e3-9350-563344de9f80@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb6c04b-ded9-47e3-9350-563344de9f80@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a281619 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=_x3pgzztF0geSffqBKMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yHF98EgxDJ1JLCCxdAHENSuqIQN99VOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX2jZ69/F4Zcgf
 qVt7KrtocfO5+PCDOLmY926gKZ2oCT4Q//K3l5CpeLnhSCPDume2hDhB8RDR6WUbC+v30ewTD3b
 kQYkZ15wDUpSQso6r7w6Wp4AdK0UXuPxwP46eDBrMvrI8aTPjqWS8PNjK7ewcxiLLYR0hvZeJSm
 cOZw07BQlgXA3S6iLtf2O+8HHL3aGZ/XgyPr/Enru73acFK7hB/gj21MoxFkxyPzWHmbFgzBYAw
 OV4MZ5oiwOCqUZyQEfiwCR3JMN2DpSFKtDBPSFDwWtHdpwqpFZSnHfk9hRaH5u2ylpEz5waw1yt
 XXiXQrklNSaZlbSIb/9z+bFtXx9DOmGDgV4dy8OXJiQNaV5GcGwsnuIxSrrRRGuyR9YeXRJJ2CX
 HQpz1jsb4X7EVl0wyQOqHXuGVmwcEDXI6wm8WCVkfZOwfolk98OVM+NMTbZBdH2pvaaPfsXl9oh
 ZHu1GvplfBL4mic+gqA==
X-Proofpoint-ORIG-GUID: jq8IstPxeVQVkeE-Wry3wE4-IX3VmrnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090124

On Tue, Jun 09, 2026 at 02:38:45PM +0200, Christian Borntraeger wrote:
> Am 26.05.26 um 12:20 schrieb Arnd Bergmann:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The set_memory_encrypted/set_memory_decrypted functions are exported
> > on x86 and arm64 but not on s390, which leads to a new build failure
> > because they are now used in a loadable module:
> > 
> > ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> > ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> > 
> > Export these the same way we do on the other architectures.
> > 
> > Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> 
> This commit id was from an next tree? Seems to be no longer valid.
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> @Alexander/vasily/Heiko, can you maybe queue that via the s390 fixes tree?

There is a lot of discussion ongoing for the similar powerpc
patch. Waiting for the end result.

https://lore.kernel.org/all/20260522225853.878411-1-tjmercier@google.com/
