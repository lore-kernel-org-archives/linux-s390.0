Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996562;
	b=LFbLc2yIh08U6RcfpdX9wOPlor4MkEAKqt4nA2NFfZaiDomkQ+nkDv0ChfLEIJzcKWDo
	 OH8gXT+BMvmifm45cDNn6yJXQilDnh23mQF+imjJgptdDsyMWKOL8F5JIjRJyd2IedFsi
	 HvASaViHFubVuVwZpnQwU+mqhEvlN6EAofK05yeymehG4fMIdoArQYAC4KBQmtU4CGyHW
	 RHCJArVDxmp1Ylk7TnUyPkjNRmUoiblFlxevj00xXdi8mb7K8faBZua3T9iKcdKFcHhKG
	 rdH7ZCU73vEGu6UJHu/EqYRXAkgprTx3HWU4kOxJCyLsbOD04OIUxsIKNYlqvAITi3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996562;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MZmVqOTHxTktTcU1qGgWrv5Bi4RVG456/6Vfq3swBUc=;
	b=jEkHG7egPBIFUSfnh+imJfM3ZfnHHuVp7VzlFTkZLd+iIYKHQZgSRkLhVYJeH6ca1Q3r
	 jMaf7hu9RdweixnFjiDTyfwQ+Paho0ZlK+e6yKkuwwB0xwZo48SXTWal/HJurwP1xupaO
	 g44gA5EXdimm5URuc3I1/oycMH6m6aewdlivNJKsowQ1XXkrTQqvFThiPRv6DDMS6hb1N
	 5og/crIyLCI8zQZSLoorOqXTVWffYLb2CPvTLxBAjTgp5XWllDiVDmvI4Z7/UMaFeTwhg
	 0yglQo5w5Auz243YvIdy6w2W473keNx1c0bgZkv1wH494Je1wSni7Ieg+tEwo5JtxFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Bcbg/1s0";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA973606A31C;
	Wed, 18 Nov 2026 10:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA973606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bcbg/1s0
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9uNIE3354313;
	Wed, 18 Nov 2026 10:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MZmVqOTHxTktTcU1qGgWrv5Bi4RVG4
	56/6Vfq3swBUc=; b=Bcbg/1s0GgB1RP+bYURvuotiA2w8Y75Bzqyt5qLKKiZzo2
	LDNvjffwdVTfd4XtKdwrkWjig0tX4LEcBZIIK3gRY0wiliR8+Bf7KuoPs+DHuWLA
	jzlf0wKaIrEpZitA8GI8S1JD5Ng9CSUyKygSgDnksd0tHvliBqIrCNNnJEbdw33G
	5RjhaZTTG5nZs3XNzfaTe9ItXqS1p2os0B9ej6Cb6ftiG4YVtPTpdysa7vlOFAI0
	wFTNflHbWbW91X7wQphs4AwOi59x47WqZtlpovRtRTXvrloBF0xT0i+Rp42RnUwb
	yB3C+Tr2b+7w9rpxVJAcwUfLsYGwmmK3ZC6BaQnQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhwjb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:09:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9nx8p1832149;
	Wed, 18 Nov 2026 10:09:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4rfvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 10:09:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIA9Bcx15139110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 10:09:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A6CE20071;
	Wed, 18 Nov 2026 10:09:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5038F2006C;
	Wed, 18 Nov 2026 10:09:11 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Nov 2026 10:09:11 +0000 (GMT)
Date: Wed, 18 Nov 2026 11:09:09 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <20261118100909.14542A04-hca@linux.ibm.com>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
 <20261116152216.165348Aa5-hca@linux.ibm.com>
 <20261118091126.25efaea8@pumpkin>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118091126.25efaea8@pumpkin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: uBfXR2dxc6PwfwtKlUHYdBmHv4j8jsO2
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd794c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=uEPgcOoI_TXTlIU_0SwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX1PC8daa1Jvk7
 kb7SppLX7bDgSgLGDXrqWZvoZjaZsy0OBNj47V+QkvMFtEpy1upJVp4Obwkcjmc9WLP5xKvkFuR
 3Ccg5XihKbJjdILw6E7cdQYLhn57gjo=
X-Proofpoint-ORIG-GUID: 4mmnc0ttL-ybd-Ur_WVKaNC63vTULTZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX1ZOHf78Ow3Bn
 a11wztO6vKtFxp1JIaE8QMgqv1fumQWjCsBqOtQUsXKafPyBfUt38EBju3EYnRYvi3y/z0lcfkQ
 Pq4lGYm+QUbB37Ftd/xSUmxn6yEgyWTe68+0z17WwCyDyp8fpKDa09d0z+kNh42cfXxxXpfCdjO
 P0J+ehhP/UFtuTN2FZakVZENsCc/2U/U0GklBYMYGmGoGJo7jSIOCZCsmZorSJPEGPH2c9pdA2H
 V/sefKeyBHjuLWfLX0aAM6nzraJHWht12H8OLYR13GCa/ARQVr7plfQi8dGdq/9rFrw36JC8Vp+
 TDp2oc2RjpsRN8/g6htKrLHxVi3piWerqADEhpQ943xwHyjqL3nJXYbb1MPTQiD5aGzeiChSpug
 XEyKKIW1USy+PxGvfjjETYWZouTucb/Nu1kY1HzuvQ0G1fcj9jekfy7JZ4rvY0KIK4r0FnXGm24
 c0zfyp+IezWGn/ovfSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180039

On Wed, Nov 18, 2026 at 09:11:26AM +0000, David Laight wrote:
> On Mon, 16 Nov 2026 16:22:16 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > It is a bit subtle that this really works. EXT_SCCB_READ_CPU is 3 * PAGE_SIZE,
> > so we end up with a guaranteed 4k alignment from the slab cache, which is
> > indeed sufficient here. But this is really not obvious, and not as stable as
> > before, IMHO.
> > 
> > I'd prefer to have this changed to:
> > 
> > 	sccb = kzalloc(PAGE_SIZE << get_order(length), GFP_KERNEL | GFP_DMA);
> > 
> > which comes with the same alignment guarantees as before.
> 
> Would it be better (more obvious) to round up EXT_SCCB_READ_CPU ?

Mike sent already a new version; this is now good enough.
