Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980C3C5826;
	Tue,  9 Jun 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985852; cv=none; b=YvjmNEI1d5dmozefgZmpiFAqGARhkUQKfe/ghmjddv6Vml58PcmbN6da2RCL+oHTMIb66voBkej5lRrRz4epFqToZvQXI3xCtZA5VrNBuy/VFKvwDe/Bg/a8LpADMzOUO9qcnw7JumHHf+VNyNhwbdN1iJVyszFk08r9vQuxRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985852; c=relaxed/simple;
	bh=BNGAi2klR4o6SRU5NOaJL9B6wuV4cGmJYOoBPtuK2kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSytAXcoZ/TKvnzBOwPoqjjMNqR5xhIlJYHnXO0JOY3WZBni40/vpIQZhUEabh0tiwMu2OUp5g9oxT4QuBXKCNhQtnSF3UAPJr/rwfxn9d5sc0Ow3KsMXEkiLKfpEREwCG++4/IPiJc2lJ1R3RRa4DVVtYe/xuiJ3N3E/K4xOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNrQLgBP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNrQLgBP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LNmu32576971;
	Tue, 9 Jun 2026 06:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vYXtbuwZCFv7ZT9E6kEl2YGw+gn2hm
	JGFPGJGMMqylY=; b=rNrQLgBPU5lfJc3ZYpuJtQ+dXfrgosAq278z96ntCc9j4Q
	y0LTg09Jbjqa//xiAsVGSAxBlzU4ghJFgm8PFRM6Eka+Sx3bXO8WxN8vpBilv72h
	2LN0SQEEV9jkKPiGxtYAiSXP0ilmugCGSsZLqkSrC9EV2JHkXhOcU9Q+7CavZzcT
	zxa3DZsy52cTDiYL4mCjJqPsJOQBXsWMBMnCRyzRo33Am94TEPcHk8F9apwSd9EU
	ZP7RUeySKZIv6x4J7dAji6DnU14/RBHU7YFtwTH6kdrOV2N4YeACxwYxgWadxU06
	anTYTPOqcLCV+PNqFSEhCMMz6EB8KM8dht8TSDyQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23tr6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:17:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65964c85027266;
	Tue, 9 Jun 2026 06:17:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g0ggs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:17:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6596GvIq55640386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 06:16:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35F922004B;
	Tue,  9 Jun 2026 06:16:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3F2A20040;
	Tue,  9 Jun 2026 06:16:55 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 06:16:55 +0000 (GMT)
Date: Tue, 9 Jun 2026 08:16:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Jan Polensky <japo@linux.ibm.com>
Cc: Gary Guo <gary@garyguo.net>, Heiko Carstens <hca@linux.ibm.com>,
        gor@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] s390: Enable Rust support and add required arch
 glue
Message-ID: <628c4d30-f40c-4541-ab37-bec8dec23073-agordeev@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
 <20260608142122.34400J00-hca@linux.ibm.com>
 <8f3c0ffc-adc3-493f-8347-9e7579f3cf99-agordeev@linux.ibm.com>
 <DJ3SBEPW21J5.2GMLCYBAKF7PW@garyguo.net>
 <aicOenHnHeFE2qlD@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aicOenHnHeFE2qlD@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a27afde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=8uiGNJKnyaWAJt-TsBYA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: J5No0o4bbikNhV_27oEe8CGRfe8NWhAU
X-Proofpoint-GUID: ot7GyVmc41_W9WsJD5fo0xayenJuks7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA1NSBTYWx0ZWRfXzndsR5QbiajK
 ZvQWCEgzQTWVM2QXXzzPBmuLmhtKyq1c2qWdJZ53o3G0lYD5e5tGEFgPj5lSwnNuuVwluYWNbuJ
 X/ivIl7gRStXYNDmQjx6l+ehy7wMoZbl6P0vwzudAXB7xZoaBd1eifhpM2qoM5WflHSnWq/PRvQ
 kcYx5SeZiAuG7RN2ae4YdaOF8qQj8gouQJcD847/z1ZqNPc9NLKEKpb4oO2qhiTqxdp4LdUuPmK
 uaq+ckhLnYotfO8a7B7/+3Tnes6MHe24NvDKcA+fVvvF2FguarlkCpt1YS/LKRXN6qjCvCUtBBW
 S/D0HVpDsVHTIjwWOS8y3+ZjWYYG7gU2Q7bn9Y9o6EZzdGKvn4UOIt+Kqpjl4sAMm2RZQXY+TVA
 RKRafmOzy5ZJm3x//TElHffqGvt1HpnsrXv10ocyl7iWEFdQxF/gdr8p3KPRxeR77EumT/soq8A
 U2aBpjiw3LNeX3JsZDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090055

On Mon, Jun 08, 2026 at 08:48:26PM +0200, Jan Polensky wrote:
> On Mon, Jun 08, 2026 at 04:48:45PM +0100, Gary Guo wrote:
> > On Mon Jun 8, 2026 at 3:36 PM BST, Alexander Gordeev wrote:
> > > On Mon, Jun 08, 2026 at 04:21:22PM +0200, Heiko Carstens wrote:
> > >> I guess Alexander will pick this up and route this via s390.
> > >
> > > Yes, I applied and scheduled it for -rc7.
> > >
> > > Two new files fall under the Rust maintainers scope:
> > >
> > >  rust/helpers/helpers.c | 1 +
> > >  rust/helpers/string.c  | 8 ++++++++
> > >
> > > Please, let me know if someone is against it.
> > > Otherwise, an ack would be ideal ;)
> >
> > Thes string.c is missing __rust_helper and it is also missing a trailing
> > newline.
> >
> > Sashiko's report is accurate here:
> > https://sashiko.dev/#/patchset/20260601174625.2910233-1-japo%40linux.ibm.com?part=4
> >
> > Best,
> > Gary
> >
> > >
> > > Thanks!
> >
> >
> Hi Gary,
> 
> thanks for pointing this out.
> 
> I've added the missing __rust_helper. Regarding the trailing newline,
> the file already ends with one locally:
> 
>   $ tail -c2 rust/helpers/string.c | hexdump -C
>   00000000  7d 0a                                             |}.|
> 
> The other helpers are also mixed in this regard, so I kept it consistent.
> If you prefer, I can send a v7 adjusting this as well.

Looks like a whitespace damage:

$ tail -c2 rust/helpers/rbtree.c | hexdump -C
00000000  7d 0a                                             |}.|
00000002
$ tail -c2 rust/helpers/rcu.c | hexdump -C
00000000  7d 0a                                             |}.|
00000002
$ tail -c2 rust/helpers/string.c | hexdump -C
00000000  0a 7d                                             |.}|
00000002

> Best regards,
> Jan
